unit ContasAPagar.Model.Entity.Categoria;

interface

uses

  Data.DB,
  ContasAPagar.Diversos.CustomAttributes,
  SysUtils;

type
  [ATabela('Categoria')]
  TCategoria = class
  private
    FIDCategoria: string;
    FDescricao: String;
  public
    [APK('IdCategoria')]
    [ACampo('IdCategoria',False,True) , ANotNull, AFormato(4)]
    property IdCategoria: string read FIDCategoria write FIDCategoria;
    [ACampo('Descricao'), AFormato(100)]
    property Descricao: String read FDescricao write FDescricao;
  end;

implementation

{ TCartoes }

end.
