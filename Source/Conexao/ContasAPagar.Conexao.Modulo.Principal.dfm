object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 274
  Width = 606
  object fdConexao: TFDConnection
    Params.Strings = (
      'Database=ControleDeDespesas'
      'Server=DESKTOP-HEINZ'
      'OSAuthent=Yes'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 160
    Top = 24
  end
end
