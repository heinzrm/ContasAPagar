unit ContasAPagar.Diversos.LoadLayout;

interface

uses
  FMX.Layouts, System.Classes, FMX.Forms, FMX.Types;

type
  TClassLoad = class
    class procedure LoadLayout(const LayoutMain : TLayout; const AFormClass : TComponentClass);
    class procedure CloseLayout(const LayoutMain : TLayout);
  end;
implementation

{ TClassLoad }

class procedure TClassLoad.CloseLayout(const LayoutMain: TLayout);
begin
  if Assigned(LayoutMain) then
  begin
    while LayoutMain.ChildrenCount > 0 do
    begin
      LayoutMain.RemoveObject(LayoutMain.Children[0]);
    end;
  end;
end;

class procedure TClassLoad.LoadLayout(const LayoutMain: TLayout;
  const AFormClass: TComponentClass);
var
	LComponent : TComponent;
  FFormLayout : TForm;
begin
  CloseLayout(LayoutMain);
	Application.CreateForm(AFormClass, FFormLayout);
	LComponent := FFormLayout.FindComponent('LayoutMain');
	if Assigned(LComponent) then
	begin
		LayoutMain.AddObject(TLayout(LComponent));
	end;
end;

end.
