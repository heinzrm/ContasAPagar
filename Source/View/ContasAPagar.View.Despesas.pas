unit ContasAPagar.View.Despesas;

interface

uses
  ContasAPagar.Interfaces.Controller,
  ContasAPagar.Model.Entity.Despesa,
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
  FireDAC.Stan.StorageXML,
  FMX.ActnList,
  Fmx.Bind.DBEngExt,
  Fmx.Bind.Editors,
  Fmx.Bind.GenData,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.DateTimeCtrls,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.ImgList,
  FMX.Layouts,
  FMX.ListBox,
  FMX.ListView, FMX.Edit,
  FMX.ListView.Adapters.Base,
  FMX.ListView.Appearances,
  FMX.ListView.Types,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  MultiDetailAppearanceU,
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
  TfrmDespesas = class(TfrmModelo)
    ListView1: TListView;
    Layout1: TLayout;
    edtDescricao: TEdit;
    edtValor: TEdit;
    lblDescricao: TLabel;
    lblValor: TLabel;
    dtDataVencimento: TDateEdit;
    cbCategoria: TComboBox;
    cbTipoDespesa: TComboBox;
    lblTipoDespesa: TLabel;
    lblCategoria: TLabel;
    lblDataVencimento: TLabel;
    FDConsultaIdDespesa: TStringField;
    FDConsultaDescricao: TStringField;
    FDConsultaIdTipoDespesas: TStringField;
    FDConsultaIdCategoria: TStringField;
    FDConsultaDataVencimento: TSQLTimeStampField;
    FDConsultaDataPagamento: TSQLTimeStampField;
    FDConsultaValor: TFMTBCDField;
    FDCategoria: TFDMemTable;
    FDTipoDespesa: TFDMemTable;
    FDTipoDespesaIdTipoDespesas: TStringField;
    FDTipoDespesaDescricao: TStringField;
    FDCategoriaIdCategoria: TStringField;
    FDCategoriaDescricao: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB2: TBindSourceDB;
    BindSourceDB3: TBindSourceDB;
    LinkFillControlToField: TLinkFillControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    FDConsultaIdCartoes: TStringField;
    FDCartoes: TFDMemTable;
    FDCartoesIdCartoes: TStringField;
    FDCartoesDescricao: TStringField;
    lytValor: TLayout;
    lytDescricao: TLayout;
    lytTipoDespesa: TLayout;
    lytCatoes: TLayout;
    lytCategoria: TLayout;
    lytDataVencimento: TLayout;
    lblCatoes: TLabel;
    CBCartoes: TComboBox;
    BindSourceDB4: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure btnInserirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure edtValorTyping(Sender: TObject);
    procedure cbTipoDespesaChange(Sender: TObject);
  private
    { Private declarations }
    Controller : IController<TDespesa>;
    Despesas   : TDespesa;
    procedure HabilitarBotoes(pHabilitar: Boolean);
  public
    { Public declarations }
    procedure BuscarDados; override;
  end;

var
  frmDespesas: TfrmDespesas;

implementation

uses
  ContasAPagar.Diversos.Procedimentos,
  FMX.DialogService,
  ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Controller,
  ContasAPagar.Diversos.RTTI,
  ContasAPagar.Model.Entity.Categoria,
  ContasAPagar.Model.Entity.TipoDespesa,
  ContasAPagar.Diversos.Formatar,
  ContasAPagar.Model.Entity.Cartoes;

{$R *.fmx}

procedure TfrmDespesas.btnEditarClick(Sender: TObject);
begin
  inherited;
  TProcedimentos.SetarFoco(edtValor);
end;

procedure TfrmDespesas.btnExcluirClick(Sender: TObject);
begin
  FChave := FDConsulta.FieldByName('IdDespesa').AsString;
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
                                      Controller.Tela(ttDespesa).Excluir(Despesas,FChave);
                                      BuscarDados;
                                      ExibirMensagem('Registro excluido com sucesso!');
                                    end;
                                  end);
end;

procedure TfrmDespesas.btnInserirClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text       := EmptyStr;
  edtValor.Text           := '0,00';
  dtDataVencimento.Date   := Now;
  cbTipoDespesa.ItemIndex := -1;
  cbCategoria.ItemIndex   := -1;
  TProcedimentos.SetarFoco(edtValor);
end;

procedure TfrmDespesas.btnSalvarClick(Sender: TObject);
begin
  TClassRtti<TDespesa>.getClassDoDataSet(FDConsulta,Despesas);
  Controller.Tela(ttDespesa).Salvar(FState,Despesas, FChave);
  BuscarDados;
  inherited;
  dtDataVencimento.DateTime;
end;

procedure TfrmDespesas.btnVoltarClick(Sender: TObject);
begin
  inherited;
  HabilitarBotoes(True)
end;

procedure TfrmDespesas.BuscarDados;
var
  Categoria   : TCategoria;
  TipoDespesas: TTipoDespesas;
  Cartoes     : TCartoes;
begin
  inherited;
  Categoria    := nil;
  TipoDespesas := nil;
  Cartoes      := nil;
  try
    TipoDespesas := TTipoDespesas.Create;
    Categoria    := TCategoria.Create;
    Cartoes      := TCartoes.Create;

    if FDConsulta.Active then
    begin
      FDConsulta.EmptyDataSet;
    end;

    if FDCategoria.Active then
    begin
      FDCategoria.EmptyDataSet;
    end;

    if FDTipoDespesa.Active then
    begin
      FDTipoDespesa.EmptyDataSet;
    end;

    if FDCartoes.Active then
    begin
      FDCartoes.EmptyDataSet;
    end;

    FDConsulta.AppendData(Controller.Tela(Tela).Pesquisar(Despesas),False);
    FDConsulta.First;

    FDCategoria.AppendData(Controller.Tela(ttCategoria).Pesquisar(Categoria),False);
    FDCategoria.First;

    FDTipoDespesa.AppendData(Controller.Tela(ttTipoDespesas).Pesquisar(TipoDespesas),False);
    FDTipoDespesa.First;

    FDCartoes.AppendData(Controller.Tela(ttCartoes).Pesquisar(Cartoes),False);
    FDCartoes.First;

  finally
    FreeAndNil(Categoria);
    FreeAndNil(TipoDespesas);
    FreeAndNil(Cartoes)
  end;
end;

procedure TfrmDespesas.cbTipoDespesaChange(Sender: TObject);
begin
  inherited;
  lytCatoes.Visible := (cbTipoDespesa.ItemIndex = 0);
end;

procedure TfrmDespesas.edtValorTyping(Sender: TObject);
begin
  inherited;
  Formatar(edtValor, TFormato.Valor);
end;

procedure TfrmDespesas.FormCreate(Sender: TObject);
begin
  Tela    := ttDespesa;
  Despesas := TDespesa.Create;
  inherited;
  Controller := TController<TDespesa>.New;
  BuscarDados;
  TabControl1.ActiveTab := TabItem1;
end;

procedure TfrmDespesas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Despesas);
end;

procedure TfrmDespesas.HabilitarBotoes(pHabilitar: Boolean);
begin
  case pHabilitar of
    True:
    begin
      edtDescricao.Enabled     := True;
      edtValor.Enabled         := True;
      dtDataVencimento.Enabled := True;
      cbTipoDespesa.Enabled    := True;
      cbCategoria.Enabled      := True;
      btnSalvar.Visible        := True;
    end;
    False:
    begin
      edtDescricao.Enabled     := False;
      edtValor.Enabled         := False;
      dtDataVencimento.Enabled := False;
      cbTipoDespesa.Enabled    := False;
      cbCategoria.Enabled      := False;
      btnSalvar.Visible        := False;
    end;
  end;
end;

end.
