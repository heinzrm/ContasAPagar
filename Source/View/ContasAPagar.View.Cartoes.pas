unit ContasAPagar.View.Cartoes;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.ListBox,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.Edit,
  ContasAPagar.View.ModeloPrincipal,
  FMX.TabControl,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView,
  System.Actions,
  FMX.ActnList,
  System.ImageList,
  FMX.ImgList,
  ContasAPagar.Diversos.Enumerados,
//  ContasAPagar.Diversos.RTTI,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  System.Rtti,
  System.Bindings.Outputs,
  Fmx.Bind.Editors,
  Data.Bind.EngExt,
  Fmx.Bind.DBEngExt,
  Data.Bind.Components,
  Data.Bind.DBScope,
  Data.Bind.GenData,
  Data.Bind.ObjectScope,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FMX.ListView.Adapters.Base,
  FMX.Objects,
  system.Generics.Collections,
  ContasAPagar.Model.Entity.Cartoes,
  ContasAPagar.Interfaces.Controller.Cartoes;

type
  TfrmCartoes = class(TfrmModelo)
    ListView1: TListView;
    Layout1: TLayout;
    edtDescricao: TEdit;
    lblDesc: TLabel;
    edtIdCartoes: TEdit;
    BindingsList1: TBindingsList;
    FDConsultaDescricao: TStringField;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB1: TBindSourceDB;
    FDConsultaIdCartoes: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
    Controller : IControllerCartoes<TCartoes>;
    procedure HabilitarBotoes(pHabilitar: Boolean);
  public
    { Public declarations }
    procedure BuscarDados; override;
  end;
var
  frmCartoes: TfrmCartoes;

implementation

{$R *.fmx}

uses
  ContasAPagar.Diversos.Procedimentos, ContasAPagar.Controller.Cartoes;

procedure TfrmCartoes.btnEditarClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text := FDConsulta.FieldByName('DESCRICAO').AsString;
  edtIdCartoes.Text := FDConsulta.FieldByName('IdCartoes').AsString;
end;

procedure TfrmCartoes.btnExcluirClick(Sender: TObject);
begin
  FChave := FDConsulta.FieldByName('IdCartoes').AsString;
  inherited;
end;

procedure TfrmCartoes.btnInserirClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text := EmptyStr;
  edtIdCartoes.Text := EmptyStr;
end;

procedure TfrmCartoes.btnSalvarClick(Sender: TObject);
//var
//  Cartoes : Tcartoes;
begin
//  Cartoes := TCartoes.Create;
//  try
//    TClassRtti.getClassDoForm(Layout1,Cartoes);
//    Controller.Tela(ttCartoes).Salvar(FState,Cartoes, FChave);
//    BuscarDados;
//  finally
//    FreeAndNil(Cartoes)
//  end;
  inherited;
end;

procedure TfrmCartoes.btnVoltarClick(Sender: TObject);
begin
  inherited;
  HabilitarBotoes(True);
end;

procedure TfrmCartoes.BuscarDados;
var
  Cartoes : TCartoes;
begin
  Cartoes := TCartoes.Create;
  try
    if FDConsulta.Active then
    begin
      FDConsulta.EmptyDataSet;
    end;
    FDConsulta.AppendData(Controller.Tela(Tela).Pesquisar(Cartoes),True);
  finally
    FreeAndNil(Cartoes);
  end;
end;

procedure TfrmCartoes.FormCreate(Sender: TObject);
begin
  Tela := ttCartoes;
  inherited;
  Controller := TControllerCartoes<TCartoes>.New;
  BuscarDados;
  TabControl1.ActiveTab := TabItem1;
  TProcedimentos.SetarFoco(edtDescricao);
end;

procedure TfrmCartoes.HabilitarBotoes(pHabilitar: Boolean);
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

procedure TfrmCartoes.ListView1DblClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text := FDConsulta.FieldByName('DESCRICAO').AsString;
  edtIdCartoes.Text := FDConsulta.FieldByName('IdCartoes').AsString;
  HabilitarBotoes(False);
  NextTabAction1.ExecuteTarget(Sender);
end;

end.
