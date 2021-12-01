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
  System.Rtti,
  System.SysUtils,
  System.StrUtils;

type
  TClassRtti = class
  private
    class function getTextFromComponente(componente: TComponent):string;
    class function MontarColunasInsert(pObjet: TObJect): String;
    class function MontarValoresInsert(pObjet: TObJect; pLstSql: TStringBuilder):string;
  public
    class procedure getClassDoForm(Formulario: Tlayout; classe: TObject);
    class procedure AlimentaDataSet(DataSet:TDataSet;Classe:TObject);
    class function MontarInsert(pObjet: TObJect; pNomeTabela: string): string;
  end;

implementation


{ TClassRtti }

class procedure TClassRtti.AlimentaDataSet(DataSet: TDataSet; Classe: TObject);
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  Value      : TValue;
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
          if not (rtAtrib as ACampo).SomenteLitura then
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
           if String(AnsiUpperCase(componente.Name)).Contains(NomeCampo) then
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

class function TClassRtti.MontarColunasInsert(pObjet: TObJect): String;
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  Value      : TValue;
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
          if not (rtAtrib as ACampo).SomenteLitura then
            pLista.AppendLine(ifthen((iContador = 0),NomeCampo,Format(',%s',[NomeCampo])));
        end;
      end;
      Inc(iContador);
    end;
  finally
    rtCtx.Free;
    FreeAndNil(pLista)
  end;

end;

class function TClassRtti.MontarInsert(pObjet: TObJect; pNomeTabela: string): string;
var
  LstSql : TStringBuilder;
begin
  LstSql := TStringBuilder.Create;

  LstSql.AppendLine('Insert into');
  LstSql.AppendLine(pNomeTabela);
  LstSql.AppendLine('(');
  LstSql.AppendLine(MontarColunasInsert(pObjet));
  LstSql.AppendLine(') Value(');
  LstSql.AppendLine(MontarValoresInsert(pObjet,LstSql));
  LstSql.AppendLine(')');

end;

class function TClassRtti.MontarValoresInsert(pObjet: TObJect; pLstSql: TStringBuilder): string;
begin

end;

end.
