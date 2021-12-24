unit ContasAPagar.View.Cartoes;

interface

uses
  ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Diversos.RTTI,
  ContasAPagar.Interfaces.Controller,
  ContasAPagar.Model.Entity.Cartoes,
  ContasAPagar.View.ModeloPrincipal,
  Data.Bind.Components,
  Data.Bind.DBScope,
  Data.Bind.EngExt,
  Data.Bind.GenData,
  Data.Bind.ObjectScope,
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
  Fmx.Bind.DBEngExt,
  Fmx.Bind.Editors,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Edit,
  FMX.Forms,
  FMX.Graphics,
  FMX.ImgList,
  FMX.Layouts,
  FMX.ListBox,
  FMX.ListView,
  FMX.ListView.Adapters.Base,
  FMX.ListView.Appearances,
  FMX.ListView.Types,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  System.Actions,
  System.Bindings.Outputs,
  System.Classes,
  system.Generics.Collections,
  System.ImageList,
  System.Rtti,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

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
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Controller : IController<TCartoes>;
    Cartoes    : TCartoes;
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
  ContasAPagar.Diversos.Procedimentos,
  ContasAPagar.Controller,
  FMX.DialogService;

procedure TfrmCartoes.btnEditarClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text := FDConsulta.FieldByName('DESCRICAO').AsString;
  edtIdCartoes.Text := FDConsulta.FieldByName('IdCartoes').AsString;
  TProcedimentos.SetarFoco(edtDescricao);
end;

procedure TfrmCartoes.btnExcluirClick(Sender: TObject);
begin
  FChave := FDConsulta.FieldByName('IdCartoes').AsString;
  inherited;
  TDialogService.MessageDialog('Excluir do registro selecionado?',
                                  TMsgDlgType.mtConfirmation,
                                  [TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo],
                                  TMsgDlgBtn.mbNo,
                                  0,
                                  procedure(const AResult: TModalResult)
                                  begin
                                    if  AResult = mrYes then
                                    begin
                                      Controller.Tela(ttCartoes).Excluir(Cartoes,FChave);
                                      BuscarDados;
                                      ExibirMensagem('Registro excluido com sucesso!');
                                    end;
                                  end);
end;

procedure TfrmCartoes.btnInserirClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text := EmptyStr;
  edtIdCartoes.Text := EmptyStr;
  TProcedimentos.SetarFoco(edtDescricao);
end;

procedure TfrmCartoes.btnSalvarClick(Sender: TObject);
begin
  TClassRtti<TCartoes>.getClassDoForm(Layout1,Cartoes);
  Controller.Tela(ttCartoes).Salvar(FState,Cartoes, FChave);
  BuscarDados;
  inherited;
end;

procedure TfrmCartoes.btnVoltarClick(Sender: TObject);
begin
  inherited;
  HabilitarBotoes(True);
end;

procedure TfrmCartoes.BuscarDados;
begin
  if FDConsulta.Active then
  begin
    FDConsulta.EmptyDataSet;
  end;

  FDConsulta.AppendData(Controller.Tela(Tela).Pesquisar(Cartoes),False);
  FDConsulta.IndexFieldNames := 'Descricao';
  FDConsulta.First;
end;

procedure TfrmCartoes.FormCreate(Sender: TObject);
begin
  Tela    := ttCartoes;
  Cartoes := TCartoes.Create;
  inherited;
  Controller := TController<TCartoes>.New;
  BuscarDados;
  TabControl1.ActiveTab := TabItem1;
end;

procedure TfrmCartoes.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Cartoes)
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
