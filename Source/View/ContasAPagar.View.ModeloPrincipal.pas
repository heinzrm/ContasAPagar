unit ContasAPagar.View.ModeloPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmModelo = class(TForm)
    lytPrincipal: TLayout;
    ToolBar1: TToolBar;
    ListBox1: TListBox;
    ltbIncluir: TListBoxItem;
    ltbAlterar: TListBoxItem;
    ltbPesquisar: TListBoxItem;
    ltbExcluir: TListBoxItem;
    ltbImprimir: TListBoxItem;
    ltbGravar: TListBoxItem;
    ltbFechar: TListBoxItem;
    lytMain: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModelo: TfrmModelo;

implementation

{$R *.fmx}

end.
