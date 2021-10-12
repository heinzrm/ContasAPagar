unit ContasAPagar.Diversos.Procedimentos;

interface

uses
  FMX.Controls;

type
  TProcedimentos = class
  public
    class procedure SetarFoco(pComponent: TControl);
  end;
implementation

{ TProcedures }

class procedure TProcedimentos.SetarFoco(pComponent: TControl);
begin
  if pComponent.Canfocus then
  begin
    pComponent.SetFocus;
  end;
end;

end.
