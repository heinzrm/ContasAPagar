unit ContasAPagar.Model.Receitas;

interface

uses
//  ContasAPagar.Dao.Receitas,
  ContasAPagar.Model.Entity.TipoReceita,
  ContasAPagar.Interfaces.Model.Crud,
  ContasAPagar.Model.Conexao,
  Data.DB, FireDAC.Comp.DataSet,
  System.Generics.Collections;

type
  TModelReceitas<T>= class(TInterfacedObject,ICrud<T>)
  private
//    FDaoReceitas : TDaoReceitas<TReceitas>;
  public
    Class function New: ICrud<T>;
    constructor Create;
    destructor Destroy; override;
    procedure Alterar;
    procedure Cancelar;
    procedure Editar;
    procedure Excluir(pChave: string);
    function Pesquisar(pObject: T): IFDDataSetReference;
    procedure Salvar(pState: TDataSetState; pObject: T; pChave: string);

//    function Pesquisar<T>(pObject: T): IFDDataSetReference;
//    procedure Alterar;
//    procedure Cancelar;
//    procedure Editar;
//    procedure Excluir(pChave: string);
//    procedure Salvar<T>(pState: TDataSetState; pObject: T; pChave: string);
   end;

implementation

uses
  System.SysUtils;

{ TCartoes }

{ TModelReceitas<T> }

procedure TModelReceitas<T>.Alterar;
begin

end;

procedure TModelReceitas<T>.Cancelar;
begin

end;

constructor TModelReceitas<T>.Create;
begin
  inherited Create;

//  FDaoReceitas := TDaoReceitas.Create;
end;

destructor TModelReceitas<T>.Destroy;
begin
//  FreeAndNil(FDaoReceitas);
  inherited;
end;

procedure TModelReceitas<T>.Editar;
begin

end;

procedure TModelReceitas<T>.Excluir(pChave: string);
begin
//  FDaoReceitas.Delete(pChave)
end;

class function TModelReceitas<T>.New: ICrud<T>;
begin
  Result := Self.Create;
end;

function TModelReceitas<T>.Pesquisar(pObject: T): IFDDataSetReference;
begin
//  Result:= FDaoReceitas.Select(pObject);
end;

procedure TModelReceitas<T>.Salvar(pState: TDataSetState; pObject: T; pChave: string);
begin
//  case pState of
//    dsEdit   : FDaoReceitas.Update(pObject, pChave);
//    dsInsert : FDaoReceitas.Insert(pObject);
//  end;
end;

end.
