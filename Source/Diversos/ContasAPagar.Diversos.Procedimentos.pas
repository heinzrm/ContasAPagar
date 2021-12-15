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

uses
  System.Classes;

{ TProcedures }

class procedure TProcedimentos.SetarFoco(pComponent: TControl);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize( nil,
         procedure
         begin
           pComponent.SetFocus;
         end
      );
    end
  ).Start;
end;

end.
