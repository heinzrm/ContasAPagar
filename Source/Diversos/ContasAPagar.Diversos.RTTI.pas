unit ContasAPagar.Diversos.RTTI;

interface

uses
  System.Rtti,
  FMX.Forms,
  System.Classes,
  System.SysUtils,
  FMX.StdCtrls,
  FMX.Dialogs,
  Data.DB,
  ContasAPagar.Diversos.CustomAttributes,
  FMX.Edit, FMX.ListBox, FMX.Layouts;

type
  TClassRtti = class
  private
    class function getTextFromComponente(componente: TComponent):string;
  public
    class procedure getClassDoForm(Formulario: Tlayout; classe: TObject);
    class procedure AlimentaDataSet(DataSet:TDataSet;Classe:TObject);
  end;

implementation

uses
  Math;


{ TClassRtti }

class procedure TClassRtti.AlimentaDataSet(DataSet: TDataSet; Classe: TObject);
var
  rtCtx      : TRttiContext;
  rtType     : TRttiType;
  rtProp     : TRttiProperty;
  rtAtrib    : TCustomAttribute;
  Value      : TValue;
  NomeCampo    :string;
  I: Integer;
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
    rtType := nil;
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

end.
