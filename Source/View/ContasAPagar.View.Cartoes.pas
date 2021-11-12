unit ContasAPagar.View.Cartoes;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.ListBox,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.Edit,
  ContasAPagar.View.ModeloPrincipal, FMX.TabControl, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Actions, FMX.ActnList, System.ImageList, FMX.ImgList;

type
  TfrmCartoes = class(TfrmModelo)
    ListView1: TListView;
    Layout1: TLayout;
    Edit1: TEdit;
    Label2: TLabel;
    lblChaveCartoes: TLabel;
    lblCodigo: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCartoes: TfrmCartoes;

implementation

{$R *.fmx}

uses
  ContasAPagar.Diversos.Procedimentos;

procedure TfrmCartoes.FormCreate(Sender: TObject);
begin
  inherited;
  TabControl1.ActiveTab := TabItem1;
  TProcedimentos.SetarFoco(Edit1);
end;

end.
