unit ContasAPagar.View.ModeloPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl,
  FMX.Objects, System.ImageList, FMX.ImgList, System.Actions, FMX.ActnList,
  ContasAPagar.Controller.Cartoes, ContasAPagar.Diversos.Variaveis,
  ContasAPagar.Diversos.Enumerados, Data.DB,
  ContasAPagar.Controller.Intereface.Cartoes;

type
  TfrmModelo = class(TForm)
    LayoutMain: TLayout;
    lytMain: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    lytPage1Top: TLayout;
    btnInserir: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    Layout2: TLayout;
    btnSalvar: TButton;
    btnVoltar: TButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    procedure FormCreate(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    FTela: TTelas;
    { Private declarations }
  public
    { Public declarations }
    Controller: IControllerCartoes;
    FState    : TDataSetState;
    property Tela : TTelas read FTela write FTela;
  end;

var
  frmModelo: TfrmModelo;

implementation

{$R *.fmx}

procedure TfrmModelo.btnInserirClick(Sender: TObject);
begin
  NextTabAction1.ExecuteTarget(Sender);
  FState := dsInsert;
end;

procedure TfrmModelo.btnEditarClick(Sender: TObject);
begin
  NextTabAction1.ExecuteTarget(Sender);
  FState := dsEdit;
end;

procedure TfrmModelo.btnSalvarClick(Sender: TObject);
begin
  PreviousTabAction1.ExecuteTarget(Sender);
end;

procedure TfrmModelo.btnVoltarClick(Sender: TObject);
begin
  PreviousTabAction1.ExecuteTarget(Sender);
end;

procedure TfrmModelo.FormCreate(Sender: TObject);
begin
  Controller := TControllerCartoes.New;
end;

end.
