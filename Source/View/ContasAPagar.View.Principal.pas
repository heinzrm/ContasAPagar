unit ContasAPagar.View.Principal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.ListBox,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.MultiView, ContasAPagar.View.Cartoes;

type
  TfrmPrincipal = class(TForm)
    MultiView1: TMultiView;
    ListBox1: TListBox;
    ltbCartoes: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    LayoutMain: TLayout;
    procedure ltbCartoesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  ContasAPagar.Diversos.LoadLayout;

{$R *.fmx}

procedure TfrmPrincipal.ltbCartoesClick(Sender: TObject);
begin
  TClassLoad.LoadLayout(LayoutMain,TfrmCartoes);
end;

end.
