unit ContasAPagar.View.ModeloPrincipal;

interface

uses
  ContasAPagar.Diversos.Enumerados,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DatS,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FMX.ActnList,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.DialogService,
  FMX.Forms,
  FMX.Graphics,
  FMX.ImgList,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  System.Actions,
  System.Classes,
  System.ImageList,
  System.Types,
  System.UITypes,
  System.Variants,
  ContasAPagar.Interfaces.Controller,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf;

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
    FDConsulta: TFDMemTable;
    lytMensagem: TLayout;
    Rectangle1: TRectangle;
    lblMensagem: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    FTela : TTelas;
    { Private declarations }
  protected
    procedure ExibirMensagem(pMensagem: String);
  public
    { Public declarations }
    FState     : TDataSetState;
    FChave     : string;
    Controller : IController<TObject>;
    property Tela : TTelas read FTela write FTela;
    procedure BuscarDados; virtual;abstract;
    function ApplyMask(aMask, aValue: String): String;
  end;

var
  frmModelo: TfrmModelo;

implementation

uses
  System.SysUtils;

{$R *.fmx}

procedure TfrmModelo.btnInserirClick(Sender: TObject);
begin
  NextTabAction1.ExecuteTarget(Sender);
  FState := dsInsert;
end;

function TfrmModelo.ApplyMask(aMask, aValue: String): String;
Var
  iContador : Integer;
  iContador2 : Integer;
  Texto : String;
begin
  Result := EmptyStr;
  Texto  := EmptyStr;
  aMask  := aMask.ToUpper;
  for iContador := 0 to aValue.Length-1 do
     if CharInSet(aValue.Chars[iContador],['0'..'9']) Then
        Texto := Texto + aValue.Chars[iContador];
  iContador2 := 0;
  iContador := 0;
  while (iContador < Texto.Length) And (iContador2 < aMask.Length) do
  Begin
    While aMask.Chars[iContador2] <> '#' Do
    Begin
      Result := Result + aMask.Chars[iContador2];
      Inc(iContador2);
    End;
    Result := Result + Texto.Chars[iContador];
    Inc(iContador2);
    Inc(iContador);
  End;
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

procedure TfrmModelo.ExibirMensagem(pMensagem: String);
begin
  lblMensagem.Text := pMensagem;
  lytMensagem.Visible := True;
  Application.ProcessMessages;
  Sleep(3000);
  lytMensagem.Visible := False;
end;

procedure TfrmModelo.FormCreate(Sender: TObject);
begin
  lytMensagem.Visible := False;
end;

end.
