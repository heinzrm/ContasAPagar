unit ContasAPagar.Diversos.RTTI;

interface

uses
  ContasAPagar.Diversos.CustomAttributes,
  Data.DB,
  FMX.Edit,
  FMX.Layouts,
  FMX.StdCtrls,
  Math,
  System.Classes,
  System.StrUtils,
  System.SysUtils,
  System.TypInfo,
  System.Generics.Collections;

type
  TClassRtti<T> = class
  private
    class function getTextFromComponente(componente: TComponent): string;
    class function MontarColunas(pObjet: TObject): String;
    class function MontarColunasUpDate(pObjet: TObject): String;
    class function MontarValoresInsert(pObjet: TObject; pLstSql: TStringBuilder): string;
    class function MontarWhere(pObjet: TObject): String;
  public
    class procedure getClassDoForm(Formulario: Tlayout; classe: TObject);
    class procedure getClassDoDataSet(DataSet: TDataSet; classe: TObject);
    class procedure AlimentaDataSet(DataSet:TDataSet;Classe:TObject);
    class function MontarInsert(pObjet: TObject; pNomeTabela: string): string;
    class function MontarSelect(pObjet: TObject; pNomeTabela: string): string;
    class function MontarUpdate(pObjet: TObject; pNomeTabela: string; pChave: string): string;
    class function BuscaChavePrimaria(pObject: TObject): string;
  end;

implementation

uses
  System.Rtti, FMX.DateTimeCtrls;


{ TClassRtti }

class procedure TClassRtti<T>.AlimentaDataSet(DataSet: TDataSet; Classe: TObject);
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  NomeCampo    :string;
begin
  if not (DataSet.State in [dsInsert,dsEdit]) then
    Exit;

  rtCtx := TRttiContext.Create;
  try
    rtType := rtCtx.GetType(Classe.ClassType);
    for rtProp in rtType.GetProperties do
    begin
      for rtAtrib in rtProp.GetAttributes do
      begin
        if (rtAtrib is ACampo) then
        begin
          NomeCampo := (rtAtrib as ACampo).NomeDB;
          if not (rtAtrib as ACampo).SomenteLeitura then
            DataSet.FindField(NomeCampo).AsString := rtProp.GetValue(classe).ToString;
        end;
      end;
    end;
  finally
    rtCtx.Free;
  end;
end;

class function TClassRtti<T>.BuscaChavePrimaria(pObject: TObject): string;
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  NomeCampo  : string;
begin
  rtCtx := TRttiContext.Create;
  try

    rtType := rtCtx.GetType(pObject.ClassType);
    for rtProp in rtType.GetProperties do
    begin
      for rtAtrib in rtProp.GetAttributes do
      begin
        if rtAtrib is APK then
        begin
          Result := (rtAtrib as APK).ChavePrimaria;
          Exit;
        end;
      end;
    end;
  finally
    rtCtx.Free;
  end;
end;

class procedure TClassRtti<T>.getClassDoDataSet(DataSet: TDataSet; classe: TObject);
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  NomeCampo    :string;
begin
  rtCtx := TRttiContext.Create;
  try
    rtType := rtCtx.GetType(Classe.ClassType);
    for rtProp in rtType.GetProperties do
    begin
      for rtAtrib in rtProp.GetAttributes do
      begin
        if (rtAtrib is ACampo) then
        begin
          NomeCampo := (rtAtrib as ACampo).NomeDB;
          if not (rtAtrib as ACampo).SomenteLeitura then
          begin
            var Valor : TValue;
            case rtprop.GetValue(classe).Kind of
              tkInteger : Valor := DataSet.FindField(NomeCampo).AsInteger;
              tkUString,
              tkString : Valor := DataSet.FindField(NomeCampo).AsString;
              tkFloat   :
              begin
                if (rtProp.GetValue(classe).TypeInfo = TypeInfo(TDate)) or
                   (rtProp.GetValue(classe).TypeInfo = TypeInfo(TTime)) or
                   (rtProp.GetValue(classe).TypeInfo = TypeInfo(TDateTime)) then
                begin
                  Valor := DataSet.FindField(NomeCampo).AsDateTime;
                end
                else
                begin
                  Valor := DataSet.FindField(NomeCampo).AsFloat;
                end;
              end;
            end;

            if valor.ToString = EmptyStr then
              Continue;
            rtProp.SetValue(classe, Valor);
          end;
        end;
      end;
    end;
  finally
    rtCtx.Free;
  end;
end;

class procedure TClassRtti<T>.getClassDoForm(Formulario: Tlayout; classe: TObject);
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  Value      : TValue;
  Componente : TComponent;
  I          : Integer;
  NomeCampo  : string;
begin
  rtCtx:=TRttiContext.Create;
  try
    rtType    :=rtCtx.GetType(Classe.ClassType);
    for rtProp in rtType.GetProperties do
    begin
      for rtAtrib in rtProp.GetAttributes do
      begin
        if (rtAtrib is ACampo) then
        begin
          NomeCampo := (rtAtrib as ACampo).NomeDB;
          for I:=0 to pred(formulario.ControlsCount) do
          begin
            componente:=Formulario.Controls[I];
            if String(AnsiUpperCase(componente.Name)).Contains(AnsiUpperCase(NomeCampo)) then
            begin
              case rtProp.GetValue(classe).Kind of
                tkUString: Value:= getTextFromComponente(componente);
                tkInteger: Value:= getTextFromComponente(componente).ToInteger;
                tkFloat  :
                begin
                  if (rtProp.GetValue(classe).TypeInfo = TypeInfo(TDate)) or
                     (rtProp.GetValue(classe).TypeInfo = TypeInfo(TTime)) or
                     (rtProp.GetValue(classe).TypeInfo = TypeInfo(TDateTime)) then
                  begin
                    Value:= StrToDateTime(getTextFromComponente(componente));
                  end
                  else
                  begin
                    Value:= getTextFromComponente(componente).Replace('.',EmptyStr).ToDouble;
                  end;
                end;
              end;

             rtProp.SetValue(Pointer(classe), Value);
            end;
          end;
        end;
      end;
    end;
  finally
    rtCtx.Free;
  end;
end;

class function TClassRtti<T>.getTextFromComponente(componente: TComponent): string;
var
  dData: TDateTime;
begin
  if componente is TEdit then
  begin
    if ((componente as TEdit).Text='') then
      Exit('0')
    else
      Exit((componente as TEdit).Text);
  end;

  if componente is TDateEdit then
  begin
    if ((componente as TDateEdit).Text='') then
      Exit('0')
    else
    begin
      Exit((componente as TDateEdit).Text);
    end;
  end;
end;

class function TClassRtti<T>.MontarColunas(pObjet: TObject): String;
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  NomeCampo  : string;
  pLista     : TStringBuilder;
  iContador : Integer;
begin
  iContador := 0;

  rtCtx := TRttiContext.Create;
  pLista:= nil;
  try
    pLista:= TStringBuilder.Create;

    rtType := rtCtx.GetType(pObjet.ClassType);
    for rtProp in rtType.GetProperties do
    begin
      for rtAtrib in rtProp.GetAttributes do
      begin
        if (rtAtrib is ACampo) then
        begin
          NomeCampo := (rtAtrib as ACampo).NomeDB;
          if not (rtAtrib as ACampo).SomenteLeitura then
            pLista.AppendLine(ifthen((iContador = 0),NomeCampo,Format(',%s',[NomeCampo])));
        end;
      end;
      Inc(iContador);
    end;
    Result := pLista.ToString;
  finally
    rtCtx.Free;
    FreeAndNil(pLista)
  end;
end;

class function TClassRtti<T>.MontarColunasUpDate(pObjet: TObject): String;
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  NomeCampo  : string;
  pLista     : TStringBuilder;
  iContador  : Integer;
  sNomeChavePrimaria : string;
begin
  iContador := 0;

  rtCtx := TRttiContext.Create;
  pLista:= nil;
  try
    pLista:= TStringBuilder.Create;

    rtType := rtCtx.GetType(pObjet.ClassType);
    for rtProp in rtType.GetProperties do
    begin
      for rtAtrib in rtProp.GetAttributes do
      begin
        if rtAtrib is APK then
        begin
          sNomeChavePrimaria := (rtAtrib as APK).ChavePrimaria;
        end;

        if (rtAtrib is ACampo) then
        begin
          NomeCampo := (rtAtrib as ACampo).NomeDB;
          if not (rtAtrib as ACampo).SomenteLeitura and (NomeCampo <> sNomeChavePrimaria) then
          begin
            pLista.AppendLine(IfThen((iContador = 0),
                              Format('%s = %s',[NomeCampo, QuotedStr(rtProp.GetValue(pObjet).ToString)]),
                              Format(',%s = %s',[NomeCampo,QuotedStr(rtProp.GetValue(pObjet).ToString)])));
            Inc(iContador);
          end;
        end;
      end;

    end;
    Result := pLista.ToString;
  finally
    rtCtx.Free;
    FreeAndNil(pLista)
  end;
end;

class function TClassRtti<T>.MontarInsert(pObjet: TObject; pNomeTabela: string): string;
var
  LstSql : TStringBuilder;
begin
  LstSql := TStringBuilder.Create;
  try
    LstSql.AppendLine('Insert into');
    LstSql.AppendLine(pNomeTabela);
    LstSql.AppendLine('(');
    LstSql.AppendLine(MontarColunas(pObjet));
    LstSql.AppendLine(') Values(');
    LstSql.AppendLine(MontarValoresInsert(pObjet,LstSql));
    LstSql.AppendLine(')');
    Result := LstSql.ToString;
  finally
    FreeAndNil(LstSql);
  end;
end;


class function TClassRtti<T>.MontarSelect(pObjet: TObject; pNomeTabela: string): string;
var
  LstSql : TStringBuilder;
begin
  LstSql := TStringBuilder.Create;
  try
    LstSql.AppendLine('Select');
    LstSql.AppendLine(MontarColunas(pObjet));
    LstSql.AppendLine(Format('from %s',[pNomeTabela]));
    Result := LstSql.ToString;
  finally
    FreeAndNil(LstSql);
  end;
end;

class function TClassRtti<T>.MontarUpdate(pObjet: TObject; pNomeTabela: string; pChave: string): string;
var
  LstSql : TStringBuilder;
begin
  LstSql := TStringBuilder.Create;
  try
    LstSql.AppendLine(Format('Update %s SET',[pNomeTabela]));
    LstSql.AppendLine(MontarColunasUpDate(pObjet));
    LstSql.AppendLine(Format('Where %s',[MontarWhere(pObjet)]));
    Result := LstSql.ToString;
  finally
    FreeAndNil(LstSql);
  end;
end;

class function TClassRtti<T>.MontarValoresInsert(pObjet: TObject; pLstSql: TStringBuilder): string;
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  NomeCampo  : string;
  pLista     : TStringBuilder;
  iContador  : Integer;
  sData      : string;
begin
  iContador := 0;

  rtCtx := TRttiContext.Create;
  pLista:= nil;
  try
    pLista:= TStringBuilder.Create;

    rtType := rtCtx.GetType(pObjet.ClassType);
    for rtProp in rtType.GetProperties do
    begin
      for rtAtrib in rtProp.GetAttributes do
      begin
        if (rtAtrib is APK) then
        begin
          rtProp.SetValue(pObjet, TGuid.NewGuid.ToString);
        end;
        if (rtAtrib is ACampo) then
        begin
          NomeCampo := (rtAtrib as ACampo).NomeDB;
          if not (rtAtrib as ACampo).SomenteLeitura then
          begin
            case rtProp.GetValue(pObjet).Kind of
              tkUString: pLista.AppendLine(ifthen((iContador = 0),QuotedStr(rtProp.GetValue(pObjet).toString),Format(',%s',[QuotedStr(rtProp.GetValue(pObjet).toString)])));
              tkInteger: pLista.AppendLine(ifthen((iContador = 0),rtProp.GetValue(pObjet).toString,Format(',%s',[rtProp.GetValue(pObjet).toString])));
              tkFloat  :
              begin
                if (rtProp.GetValue(pObjet).TypeInfo = TypeInfo(TDate)) or
                   (rtProp.GetValue(pObjet).TypeInfo = TypeInfo(TTime)) or
                   (rtProp.GetValue(pObjet).TypeInfo = TypeInfo(TDateTime)) then
                begin
                  if StrToDateTime(rtProp.GetValue(pObjet).ToString) = 0 then
                    sData := 'NULL'
                  else
                    sData := QuotedStr(FormatDateTime('yyyymmdd',StrToDateTime(rtProp.GetValue(pObjet).ToString)));

                  pLista.AppendLine(ifthen((iContador = 0),sData,Format(',%s',[sData])));
                end
                else
                begin
                  pLista.AppendLine(ifthen((iContador = 0),QuotedStr(rtProp.GetValue(pObjet).ToString.Replace('.','').Replace(',','.')),
                                                          Format(',%s',[QuotedStr(rtProp.GetValue(pObjet).ToString.Replace('.','').Replace(',','.'))])));
                end;
              end;
            end;
          end;
        end;
      end;
      Inc(iContador);
    end;
    Result := pLista.ToString;
  finally
    rtCtx.Free;
    FreeAndNil(pLista)
  end;
end;

class function TClassRtti<T>.MontarWhere(pObjet: TObject): String;
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  NomeCampo  : string;
  pLista     : TStringBuilder;
  iContador  : Integer;
  Value      : string;
begin
  iContador := 0;

  rtCtx := TRttiContext.Create;
  pLista:= nil;
  try
    pLista:= TStringBuilder.Create;

    rtType := rtCtx.GetType(pObjet.ClassType);
    for rtProp in rtType.GetProperties do
    begin
      for rtAtrib in rtProp.GetAttributes do
      begin
        if (rtAtrib is ACampo) then
        begin
          NomeCampo := (rtAtrib as ACampo).NomeDB;
          if (not (rtAtrib as ACampo).SomenteLeitura) and ((rtAtrib as ACampo).CondicaoWhere) then
          begin
            Value := rtProp.GetValue(pObjet).ToString;
            pLista.AppendLine(ifthen((iContador = 0),
                                      Format('%s = %s',[NomeCampo,QuotedStr(Value)]),
                                      Format('and %s = %s',[NomeCampo,QuotedStr(Value)])));
          end;
        end;
      end;
      Inc(iContador);
    end;
    Result := pLista.ToString;
  finally
    rtCtx.Free;
    FreeAndNil(pLista)
  end;
end;

end.
