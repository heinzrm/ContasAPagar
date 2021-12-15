unit ContasAPagar.View.TipoDespesas;

interface

uses

  ContasAPagar.Interfaces.Controller.Cartoes,
  ContasAPagar.Model.Entity.TipoDespesa,
  ContasAPagar.View.ModeloPrincipal,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DatS,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
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
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants, FMX.Edit, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FMX.ActnList, System.ImageList,
  FMX.DialogService, ContasAPagar.Diversos.RTTI, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.ListView;

type
  TfrmTipoDespesas = class(TfrmModelo)
    Layout1: TLayout;
    edtDescricao: TEdit;
    lblDesc: TLabel;
    edtIdTipoDespesas: TEdit;
    FDConsultaIdTipoReceita: TStringField;
    FDConsultaDescricao: TStringField;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Controller  : IControllerCartoes<TTipoDespesas>;
    TipoDespesa : TTipoDespesas;
    procedure HabilitarBotoes(pHabilitar: Boolean);
  public
    { Public declarations }
    procedure BuscarDados; override;
  end;

var
  frmTipoDespesas: TfrmTipoDespesas;

implementation

uses
  ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Controller.Cartoes,
  ContasAPagar.Diversos.Procedimentos;

{$R *.fmx}

{ TfrmModelo1 }

procedure TfrmTipoDespesas.btnEditarClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text      := FDConsulta.FieldByName('DESCRICAO').AsString;
  edtIdTipoDespesas.Text := FDConsulta.FieldByName('IdTipoDespesas').AsString;
  TProcedimentos.SetarFoco(edtDescricao);
end;

procedure TfrmTipoDespesas.btnExcluirClick(Sender: TObject);
begin
  FChave := FDConsulta.FieldByName('IdTipoDespesa').AsString;
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
                                      Controller.Tela(ttTipoReceitas).Excluir(TipoDespesa,FChave);
                                      BuscarDados;
                                      ExibirMensagem('Registro excluido com sucesso!');
                                    end;
                                  end);
end;

procedure TfrmTipoDespesas.btnInserirClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text      := EmptyStr;
  edtIdTipoDespesas.Text := EmptyStr;
  TProcedimentos.SetarFoco(edtDescricao);
end;

procedure TfrmTipoDespesas.btnSalvarClick(Sender: TObject);
begin
  TClassRtti<TTipoDespesas>.getClassDoForm(Layout1,TipoDespesa);
  Controller.Tela(ttTipoDespesas).Salvar(FState,TipoDespesa, FChave);
  BuscarDados;
  inherited;
end;

procedure TfrmTipoDespesas.btnVoltarClick(Sender: TObject);
begin
  inherited;
  HabilitarBotoes(True);
end;

procedure TfrmTipoDespesas.BuscarDados;
begin
  inherited;
  if FDConsulta.Active then
  begin
    FDConsulta.EmptyDataSet;
  end;
  FDConsulta.AppendData(Controller.Tela(Tela).Pesquisar(TipoDespesa),True);
  FDConsulta.IndexFieldNames := 'Descricao';
end;

procedure TfrmTipoDespesas.FormCreate(Sender: TObject);
begin
  Tela        := ttTipoDespesas;
  Controller  := TController<TTipoDespesas>.New;
  TipoDespesa := TTipoDespesas.Create;
  inherited;
  BuscarDados;
  TabControl1.ActiveTab := TabItem1;
end;

procedure TfrmTipoDespesas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(TipoDespesa);
end;

procedure TfrmTipoDespesas.HabilitarBotoes(pHabilitar: Boolean);
begin
  case pHabilitar of
    True:
    begin
      edtIdTipoDespesas.Enabled := True;
      edtDescricao.Enabled      := True;
      btnSalvar.Visible         := True;
    end;
    False:
    begin
      edtIdTipoDespesas.Enabled := False;
      edtDescricao.Enabled      := False;
      btnSalvar.Visible         := False;
    end;
  end;
end;

end.
