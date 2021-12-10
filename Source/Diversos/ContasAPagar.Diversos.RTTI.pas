unit ContasAPagar.Diversos.RTTI;

interface

uses
  ContasAPagar.Diversos.CustomAttributes,
  Data.DB,
  FMX.Dialogs,
  FMX.Edit,
  FMX.Forms,
  FMX.Layouts,
  FMX.ListBox,
  FMX.StdCtrls,
  Math,
  System.Classes,
  System.StrUtils,
  System.SysUtils,
  System.TypInfo,
  System.Generics.Collections;

type
  TClassRtti = class
  private
    class function getTextFromComponente(componente: TComponent):string;
    class function MontarColunas<T>(pObjet: T): String;
    class function MontarColunasUpDate<T>(pObjet: T): String;
    class function MontarValoresInsert<T>(pObjet: T; pLstSql: TStringBuilder):string;
    class function MontarWhere<T>(pObjet: T): String;
  public
    class procedure getClassDoForm(Formulario: Tlayout; classe: TObject);
    class procedure AlimentaDataSet(DataSet:TDataSet;Classe:TObject);
    class function MontarInsert<T>(pObjet: T; pNomeTabela: string): string;
    class function MontarSelect<T>(pObjet: T; pNomeTabela: string): string;
    class function MontarUpdate<T>(pObjet: T; pNomeTabela: string; pChave: string): string;
  end;

implementation

uses
  System.Rtti;


{ TClassRtti }

class procedure TClassRtti.AlimentaDataSet(DataSet: TDataSet; Classe: TObject);
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

class procedure TClassRtti.getClassDoForm(Formulario: Tlayout; classe: TObject);
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  Value        : TValue;
  Componente   : TComponent;
  I            : Integer;
  NomeCampo    :string;
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
               tkFloat:   Value:= getTextFromComponente(componente).ToDouble;
             end;

             rtProp.SetValue(classe, Value);
           end;
         end;
       end;
      end;
    end;
  finally
    rtCtx.Free;
  end;
end;

class function TClassRtti.getTextFromComponente(componente: TComponent): string;
begin
  if componente is TEdit then
  begin
    if ((componente as TEdit).Text='') then
      Exit('0')
    else
      Exit((componente as TEdit).Text);
  end;

  if componente is TLabel then
  begin
    if ((componente as TLabel).Text='') then
      Exit('0')
    else
      Exit((componente as TLabel).Text);
  end;
end;

class function TClassRtti.MontarColunas<T>(pObjet: T): String;
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

    rtType := rtCtx.GetType(TypeInfo(T));
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

class function TClassRtti.MontarColunasUpDate<T>(pObjet: T): String;
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

    rtType := rtCtx.GetType(TypeInfo(T));
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
                              Format('%s = %s',[NomeCampo, QuotedStr(rtProp.GetValue(TypeInfo(T)).ToString)]),
                              Format(',%s = %s',[NomeCampo,QuotedStr(rtProp.GetValue(TypeInfo(T)).ToString)])));
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

class function TClassRtti.MontarInsert<T>(pObjet: T; pNomeTabela: string): string;
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


class function TClassRtti.MontarSelect<T>(pObjet: T; pNomeTabela: string): string;
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

class function TClassRtti.MontarUpdate<T>(pObjet: T; pNomeTabela: string; pChave: string): string;
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

class function TClassRtti.MontarValoresInsert<T>(pObjet: T; pLstSql: TStringBuilder): string;
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  NomeCampo  : string;
  pLista     : TStringBuilder;
  iContador  : Integer;
begin
  iContador := 0;

  rtCtx := TRttiContext.Create;
  pLista:= nil;
  try
    pLista:= TStringBuilder.Create;

    rtType := rtCtx.GetType(TypeInfo(T));
    for rtProp in rtType.GetProperties do
    begin
      for rtAtrib in rtProp.GetAttributes do
      begin
        if (rtAtrib is APK) then
        begin
          rtProp.SetValue(TypeInfo(T), TGuid.NewGuid.ToString);
        end;
        if (rtAtrib is ACampo) then
        begin
          NomeCampo := (rtAtrib as ACampo).NomeDB;
          if not (rtAtrib as ACampo).SomenteLeitura then
          begin
            case rtProp.GetValue(rtType).Kind of
               tkUString: pLista.AppendLine(ifthen((iContador = 0),QuotedStr(rtProp.GetValue(rtType).toString),Format(',%s',[QuotedStr(rtProp.GetValue(rtType).toString)])));
               tkInteger: pLista.AppendLine(ifthen((iContador = 0),rtProp.GetValue(rtType).toString,Format(',%s',[rtProp.GetValue(rtType).toString])));
               tkFloat:   pLista.AppendLine(ifthen((iContador = 0),QuotedStr(rtProp.GetValue(rtType).toString),Format(',%s',[QuotedStr(rtProp.GetValue(rtType).toString)])));
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

class function TClassRtti.MontarWhere<T>(pObjet: T): String;
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

    rtType := rtCtx.GetType(TypeInfo(T));
    for rtProp in rtType.GetProperties do
    begin
      for rtAtrib in rtProp.GetAttributes do
      begin
        if (rtAtrib is ACampo) then
        begin
          NomeCampo := (rtAtrib as ACampo).NomeDB;
          if (not (rtAtrib as ACampo).SomenteLeitura) and ((rtAtrib as ACampo).CondicaoWhere) then
          begin
            Value := rtProp.GetValue(rtType).ToString;
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
