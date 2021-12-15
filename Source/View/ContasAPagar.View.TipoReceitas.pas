unit ContasAPagar.View.TipoReceitas;

interface

uses
  ContasAPagar.Controller.Cartoes,
  ContasAPagar.Interfaces.Controller.Cartoes,
  ContasAPagar.Model.Entity.TipoReceita,
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
  FMX.Edit,
  FMX.Forms,
  FMX.Graphics,
  FMX.ImgList,
  FMX.Layouts,

  FMX.ListView.Appearances,
  FMX.ListView.Types,
  FMX.ListView,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  System.Actions,
  System.Classes,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants, ContasAPagar.Diversos.RTTI, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FMX.ListView.Adapters.Base, FMX.ActnList, System.ImageList,
  FMX.DialogService, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TfrmReceitas = class(TfrmModelo)
    Layout1: TLayout;
    edtDescricao: TEdit;
    lblDesc: TLabel;
    edtIdTipoReceita: TEdit;
    ListView1: TListView;
    FDConsultaIdTipoReceita: TStringField;
    FDConsultaDescricao: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormCreate(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Controller  : IControllerCartoes<TTipoReceitas>;
    TipoReceita : TTipoReceitas;
    procedure HabilitarBotoes(pHabilitar: Boolean);

  public
    { Public declarations }
    procedure BuscarDados; override;
   end;

var
  frmReceitas: TfrmReceitas;

implementation

uses
  ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Diversos.Procedimentos;

{$R *.fmx}

{ TfrmModelo1 }

procedure TfrmReceitas.btnEditarClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text     := FDConsulta.FieldByName('DESCRICAO').AsString;
  edtIdTipoReceita.Text := FDConsulta.FieldByName('IdTipoReceita').AsString;
  TProcedimentos.SetarFoco(edtDescricao);
end;

procedure TfrmReceitas.btnExcluirClick(Sender: TObject);
begin
  FChave := FDConsulta.FieldByName('IdTipoReceita').AsString;
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
                                      Controller.Tela(ttTipoReceitas).Excluir(TipoReceita,FChave);
                                      BuscarDados;
                                      ExibirMensagem('Registro excluido com sucesso!');
                                    end;
                                  end);
end;

procedure TfrmReceitas.btnInserirClick(Sender: TObject);
begin
  inherited;
  edtDescricao.Text     := EmptyStr;
  edtIdTipoReceita.Text := EmptyStr;
  TProcedimentos.SetarFoco(edtDescricao);
end;

procedure TfrmReceitas.btnSalvarClick(Sender: TObject);
begin
  TClassRtti<TTipoReceitas>.getClassDoForm(Layout1,TipoReceita);
  Controller.Tela(ttTipoReceitas).Salvar(FState,TipoReceita, FChave);
  BuscarDados;
  inherited;
end;

procedure TfrmReceitas.btnVoltarClick(Sender: TObject);
begin
  inherited;
  HabilitarBotoes(True);
end;

procedure TfrmReceitas.BuscarDados;
begin
  inherited;
  if FDConsulta.Active then
  begin
    FDConsulta.EmptyDataSet;
  end;
  FDConsulta.AppendData(Controller.Tela(Tela).Pesquisar(TipoReceita),True);
  FDConsulta.IndexFieldNames := 'Descricao';
end;

procedure TfrmReceitas.FormCreate(Sender: TObject);
begin
  Tela        := ttTipoReceitas;
  Controller  := TController<TTipoReceitas>.New;
  TipoReceita := TTipoReceitas.Create;
  inherited;
  BuscarDados;
  TabControl1.ActiveTab := TabItem1;
end;

procedure TfrmReceitas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(TipoReceita);
end;

procedure TfrmReceitas.HabilitarBotoes(pHabilitar: Boolean);
begin
  case pHabilitar of
    True:
    begin
      edtIdTipoReceita.Enabled := True;
      edtDescricao.Enabled     := True;
      btnSalvar.Visible        := True;
    end;
    False:
    begin
      edtIdTipoReceita.Enabled := False;
      edtDescricao.Enabled     := False;
      btnSalvar.Visible        := False;
    end;
  end;
end;

end.
