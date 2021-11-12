unit ContasAPagar.View.ModeloPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl,
  FMX.Objects, System.ImageList, FMX.ImgList, System.Actions, FMX.ActnList;

type
  TfrmModelo = class(TForm)
    LayoutMain: TLayout;
    lytMain: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    lytPage1Top: TLayout;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Layout2: TLayout;
    Button5: TButton;
    Button7: TButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
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
