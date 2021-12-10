unit ContasAPagar.View.Despesas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  ContasAPagar.View.ModeloPrincipal, FMX.TabControl, System.Actions,
  FMX.ActnList, System.ImageList, FMX.ImgList, FMX.Controls.Presentation,
  FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.Objects;

type
  TfrmDespesas = class(TfrmModelo)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDespesas: TfrmDespesas;

implementation

{$R *.fmx}

end.
