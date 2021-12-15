unit ContasAPagar.View.Categoria;

interface

uses
  ContasAPagar.Controller.Cartoes,
  ContasAPagar.Diversos.Procedimentos,
  ContasAPagar.Interfaces.Controller.Cartoes,
  ContasAPagar.Model.Entity.Categoria,
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
  TfrmCategoria = class(TfrmModelo)
    ListView1: TListView;
    Layout1: TLayout;
    edtDescricao: TEdit;
    lblDesc: TLabel;
    edtIdCategoria: TEdit;
    FDConsultaIdCategoria: TStringField;
    FDConsultaDescricao: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    Controller : IControllerCartoes<TCategoria>;
    Categoria    : TCategoria;
    procedure HabilitarBotoes(pHabilitar: Boolean);
  public
    { Public declarations }
    procedure BuscarDados; override;
  end;

var
  frmCategoria: TfrmCategoria;

implementation

uses
  ContasAPagar.Diversos.Enumerados, FMX.DialogService,
  ContasAPagar.Diversos.RTTI;

{$R *.fmx}

procedure TfrmCategoria.btnEditarClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text   := FDConsulta.FieldByName('DESCRICAO').AsString;
  edtIdCategoria.Text := FDConsulta.FieldByName('IdCategoria').AsString;
  TProcedimentos.SetarFoco(edtDescricao);
end;

procedure TfrmCategoria.btnExcluirClick(Sender: TObject);
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
                                      Controller.Tela(ttCategoria).Excluir(Categoria,FChave);
                                      BuscarDados;
                                      ExibirMensagem('Registro excluido com sucesso!');
                                    end;
                                  end);
end;

procedure TfrmCategoria.btnInserirClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text   := EmptyStr;
  edtIdCategoria.Text := EmptyStr;
  TProcedimentos.SetarFoco(edtDescricao);
end;

procedure TfrmCategoria.btnSalvarClick(Sender: TObject);
begin
  TClassRtti<TCategoria>.getClassDoForm(Layout1,Categoria);
  Controller.Tela(ttCategoria).Salvar(FState,Categoria, FChave);
  BuscarDados;
  inherited;
end;

procedure TfrmCategoria.btnVoltarClick(Sender: TObject);
begin
  inherited;
  HabilitarBotoes(True)
end;

procedure TfrmCategoria.BuscarDados;
begin
  if FDConsulta.Active then
  begin
    FDConsulta.EmptyDataSet;
  end;

  FDConsulta.AppendData(Controller.Tela(Tela).Pesquisar(Categoria),False);
  FDConsulta.IndexFieldNames := 'Descricao';
end;

procedure TfrmCategoria.FormCreate(Sender: TObject);
begin
  Tela      := ttCategoria;
  Categoria := TCategoria.Create;
  inherited;
  Controller := TController<TCategoria>.New;
  BuscarDados;
  TabControl1.ActiveTab := TabItem1;
end;

procedure TfrmCategoria.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Categoria)
end;

procedure TfrmCategoria.HabilitarBotoes(pHabilitar: Boolean);
begin
  case pHabilitar of
    True:
    begin
      edtIdCategoria.Enabled := True;
      edtDescricao.Enabled   := True;
      btnSalvar.Visible      := True;
    end;
    False:
    begin
      edtIdCategoria.Enabled := False;
      edtDescricao.Enabled   := False;
      btnSalvar.Visible      := False;
    end;
  end;
end;

end.
