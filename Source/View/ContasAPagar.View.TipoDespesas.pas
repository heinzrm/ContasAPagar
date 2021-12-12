unit ContasAPagar.View.TipoDespesas;

interface

uses
  ContasAPagar.Controller.Cartoes,
  ContasAPagar.Interfaces.Controller.Cartoes,
  ContasAPagar.Model.Entity.TipoDespesa,
  ContasAPagar.View.ModeloPrincipal,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FMX.ActnList,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.ImgList,
  FMX.Layouts,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  System.Actions,
  System.Classes,
  System.ImageList,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants, FMX.Edit;

type
  TfrmModelo1 = class(TfrmModelo)
    Layout1: TLayout;
    edtDescricao: TEdit;
    lblDesc: TLabel;
    edtIdCartoes: TEdit;
  private
    { Private declarations }
    Controller : IControllerCartoes<TTipoDespesas>;
    procedure HabilitarBotoes(pHabilitar: Boolean);
  public
    { Public declarations }
  end;

var
  frmModelo1: TfrmModelo1;

implementation

{$R *.fmx}

{ TfrmModelo1 }

procedure TfrmModelo1.HabilitarBotoes(pHabilitar: Boolean);
begin
  case pHabilitar of
    True:
    begin
      edtIdCartoes.Enabled := True;
      edtDescricao.Enabled := True;
      btnSalvar.Visible    := True;
    end;
    False:
    begin
      edtIdCartoes.Enabled := False;
      edtDescricao.Enabled := False;
      btnSalvar.Visible    := False;
    end;
  end;
end;

end.
