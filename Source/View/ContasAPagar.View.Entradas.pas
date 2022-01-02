unit ContasAPagar.View.Entradas;

interface

uses
  ContasAPagar.Interfaces.Controller,
  ContasAPagar.Model.Entity.Receita,
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
  FMX.DateTimeCtrls,
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
  TfrmEntrada = class(TfrmModelo)
    ListView1: TListView;
    Layout1: TLayout;
    cbTipoReceita: TComboBox;
    dtDataRecebimento: TDateEdit;
    edtValor: TEdit;
    lblDataRecebimento: TLabel;
    lblTipoReceita: TLabel;
    lblValor: TLabel;
    FDTipoReceita: TFDMemTable;
    FDTipoReceitaIdTipoReceita: TStringField;
    FDTipoReceitaDescricao: TStringField;
    FDConsultaIdReceita: TStringField;
    FDConsultaIdTipoReceita: TStringField;
    FDConsultaDataRecebimento: TSQLTimeStampField;
    FDConsultaValor: TFMTBCDField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField: TLinkFillControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    FDConsultaDescricao: TStringField;
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure edtValorTyping(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FDConsultaCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    Controller : IController<TReceita>;
    Receita   : TReceita;
    procedure HabilitarBotoes(pHabilitar: Boolean);
  public
    { Public declarations }
    procedure BuscarDados; override;
  end;

var
  frmEntrada: TfrmEntrada;

implementation

uses
  FMX.DialogService,
  ContasAPagar.Diversos.Procedimentos,
  ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Diversos.RTTI,
  ContasAPagar.Model.Entity.TipoReceita,
  ContasAPagar.Diversos.Formatar,
  ContasAPagar.Controller;

{$R *.fmx}

procedure TfrmEntrada.btnEditarClick(Sender: TObject);
begin

  inherited;
  TProcedimentos.SetarFoco(edtValor);
end;

procedure TfrmEntrada.btnExcluirClick(Sender: TObject);
begin
  FChave := FDConsulta.FieldByName('IdReceita').AsString;
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
                                      Controller.Tela(ttReceita).Excluir(Receita,FChave);
                                      BuscarDados;
                                      ExibirMensagem('Registro excluido com sucesso!');
                                    end;
                                  end);
end;

procedure TfrmEntrada.btnInserirClick(Sender: TObject);
begin
  inherited;
  edtValor.Text           := '0,00';
  dtDataRecebimento.Date  := Now;
  cbTipoReceita.ItemIndex := -1;
  TProcedimentos.SetarFoco(edtValor);
end;

procedure TfrmEntrada.btnSalvarClick(Sender: TObject);
begin
  TClassRtti<TReceita>.getClassDoDataSet(FDConsulta,Receita);
  Controller.Tela(ttReceita).Salvar(FState,Receita, FChave);
  BuscarDados;
  inherited;
  dtDataRecebimento.DateTime
end;

procedure TfrmEntrada.btnVoltarClick(Sender: TObject);
begin
  inherited;
  HabilitarBotoes(True)
end;

procedure TfrmEntrada.BuscarDados;
var
  TipoReceita: TTipoReceitas;
begin
  inherited;
  TipoReceita := nil;
  try
    TipoReceita := TTipoReceitas.Create;

    if FDConsulta.Active then
    begin
      FDConsulta.EmptyDataSet;
    end;

    if FDTipoReceita.Active then
    begin
      FDTipoReceita.EmptyDataSet;
    end;

    FDTipoReceita.AppendData(Controller.Tela(ttTipoReceitas).Pesquisar(TipoReceita),False);
    FDTipoReceita.First;

    FDConsulta.AppendData(Controller.Tela(Tela).Pesquisar(Receita),False);
    FDConsulta.First;

  finally
    FreeAndNil(TipoReceita);
  end;
end;

procedure TfrmEntrada.edtValorTyping(Sender: TObject);
begin
  inherited;
  Formatar(edtValor, TFormato.Valor);
end;

procedure TfrmEntrada.FDConsultaCalcFields(DataSet: TDataSet);
begin
  inherited;
  FDTipoReceita.Locate('IdTipoReceita',FDConsulta.FieldByName('IdTipoReceita').AsString,[loPartialKey]);
  FDConsulta.FieldByName('Descricao').AsString := FDTipoReceita.FieldByName('Descricao').AsString;

end;

procedure TfrmEntrada.FormCreate(Sender: TObject);
begin
  Tela    := ttReceita;
  Receita := TReceita.Create;
  inherited;
  Controller := TController<TReceita>.New;
  BuscarDados;
  TabControl1.ActiveTab := TabItem1;
end;

procedure TfrmEntrada.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Receita);
end;

procedure TfrmEntrada.HabilitarBotoes(pHabilitar: Boolean);
begin
  case pHabilitar of
    True:
    begin
      edtValor.Enabled         := True;
      dtDataRecebimento.Enabled := True;
      cbTipoReceita.Enabled    := True;
      btnSalvar.Visible        := True;
    end;
    False:
    begin
      edtValor.Enabled         := False;
      dtDataRecebimento.Enabled := False;
      cbTipoReceita.Enabled    := False;
      btnSalvar.Visible        := False;
    end;
  end;
end;


end.
