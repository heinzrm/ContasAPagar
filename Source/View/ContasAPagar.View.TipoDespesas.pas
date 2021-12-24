unit ContasAPagar.View.TipoDespesas;

interface

uses
  ContasAPagar.Diversos.RTTI,
  ContasAPagar.Interfaces.Controller,
  ContasAPagar.Model.Entity.TipoDespesa,
  ContasAPagar.View.ModeloPrincipal,
  Data.Bind.Components,
  Data.Bind.DBScope,
  Data.Bind.EngExt,
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
  FMX.DialogService,
  FMX.Edit,
  FMX.Forms,
  FMX.Graphics,
  FMX.ImgList,
  FMX.Layouts,
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
  System.ImageList,
  System.Rtti,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

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
    Controller  : IController<TTipoDespesas>;
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
  ContasAPagar.Controller,
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
  FDConsulta.First;
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
