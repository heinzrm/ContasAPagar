unit ContasAPagar.View.Despesas;

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
  ContasAPagar.View.ModeloPrincipal,
  FMX.TabControl,
  System.Actions,
  FMX.ActnList,
  System.ImageList,
  FMX.ImgList,
  FMX.Controls.Presentation,
  FMX.Layouts,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FMX.Objects,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Edit,
  FMX.ListBox,
  FMX.DateTimeCtrls,
  Fmx.Bind.GenData,
  Data.Bind.GenData,
  System.Rtti,
  System.Bindings.Outputs,
  Fmx.Bind.Editors,
  Data.Bind.EngExt,
  Fmx.Bind.DBEngExt,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  MultiDetailAppearanceU;

type
  TfrmDespesas = class(TfrmModelo)
    ListView1: TListView;
    Layout1: TLayout;
    edtDescricao: TEdit;
    edtValor: TEdit;
    lblDescricao: TLabel;
    lblValor: TLabel;
    dtDataVencimento: TDateEdit;
    cbCategoria: TComboBox;
    cbTipoDespesa: TComboBox;
    lblTipoDespesa: TLabel;
    lblCategoria: TLabel;
    lblDataVencimento: TLabel;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    AdapterBindSource1: TAdapterBindSource;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
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
