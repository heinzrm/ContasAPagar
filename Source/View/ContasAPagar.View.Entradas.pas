unit ContasAPagar.View.Entradas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  ContasAPagar.View.ModeloPrincipal, FMX.TabControl, System.Actions,
  FMX.ActnList, System.ImageList, FMX.ImgList, FMX.Controls.Presentation,
  FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView;

type
  TfrmEntrada = class(TfrmModelo)
    ListView1: TListView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEntrada: TfrmEntrada;

implementation

{$R *.fmx}

end.
