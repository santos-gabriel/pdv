object dm: Tdm
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 475
  Width = 599
  object fd: TFDConnection
    Params.Strings = (
      'Database=pdv'
      'User_Name=root'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 32
  end
  object driver: TFDPhysMySQLDriverLink
    VendorLib = 'D:\Documents\DEV\WsDelphi\PDV\PDV\libmySQL.dll'
    Left = 480
    Top = 32
  end
  object tb_cargos: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.cargos'
    TableName = 'pdv.cargos'
    Left = 40
    Top = 96
  end
  object query_cargos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM cargos order by cargo asc;')
    Left = 40
    Top = 168
    object query_cargosid: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 5
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_cargoscargo: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 20
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 55
    end
  end
  object ds_cargos: TDataSource
    DataSet = query_cargos
    Left = 40
    Top = 240
  end
  object tb_func: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'funcionarios'
    TableName = 'funcionarios'
    Left = 120
    Top = 96
  end
  object query_func: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM funcionarios;')
    Left = 120
    Top = 168
    object query_funcid: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
      Visible = False
    end
    object query_funcnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 24
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object query_funccpf: TStringField
      DisplayLabel = 'CPF'
      DisplayWidth = 15
      FieldName = 'cpf'
      Origin = 'cpf'
      Required = True
    end
    object query_functelefone: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 15
    end
    object query_funcendereco: TStringField
      DisplayLabel = 'Endereco'
      DisplayWidth = 30
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 50
    end
    object query_funccargo: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 15
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object query_funcdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
  end
  object ds_func: TDataSource
    DataSet = query_func
    Left = 120
    Top = 240
  end
  object tb_usuarios: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.usuarios'
    TableName = 'pdv.usuarios'
    Left = 192
    Top = 96
    object tb_usuariosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tb_usuariosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object tb_usuariosusuario: TStringField
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
      Size = 25
    end
    object tb_usuariossenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 25
    end
    object tb_usuarioscargo: TStringField
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 30
    end
    object tb_usuariosidFuncionario: TIntegerField
      FieldName = 'idFuncionario'
      Origin = 'idFuncionario'
      Required = True
    end
  end
  object query_usuarios: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM usuarios ORDER BY nome asc')
    Left = 200
    Top = 168
    object query_usuariosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object query_usuariosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object query_usuariosusuario: TStringField
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
      Size = 25
    end
    object query_usuariossenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 25
    end
    object query_usuarioscargo: TStringField
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 30
    end
    object query_usuariosidFuncionario: TIntegerField
      FieldName = 'idFuncionario'
      Origin = 'idFuncionario'
      Required = True
    end
  end
  object ds_usuarios: TDataSource
    DataSet = query_usuarios
    Left = 200
    Top = 240
  end
end
