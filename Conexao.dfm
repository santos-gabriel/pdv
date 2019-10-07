object dm: Tdm
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 353
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
    Left = 80
    Top = 104
  end
  object query_cargos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM cargos order by cargo asc;')
    Left = 80
    Top = 176
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
    Left = 80
    Top = 248
  end
  object tb_func: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'funcionarios'
    TableName = 'funcionarios'
    Left = 208
    Top = 104
  end
  object query_func: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM funcionarios;')
    Left = 208
    Top = 176
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
    Left = 208
    Top = 248
  end
  object tb_usuarios: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.usuarios'
    TableName = 'pdv.usuarios'
    Left = 320
    Top = 104
  end
  object query_usuarios: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM usuarios ORDER BY nome asc')
    Left = 320
    Top = 176
    object query_usuariosid: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_usuariosnome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object query_usuariosusuario: TStringField
      DisplayLabel = 'Usuario'
      DisplayWidth = 18
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
      Size = 25
    end
    object query_usuariossenha: TStringField
      DisplayLabel = 'Senha'
      DisplayWidth = 18
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 25
    end
    object query_usuarioscargo: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 25
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 30
    end
    object query_usuariosidFuncionario: TIntegerField
      FieldName = 'idFuncionario'
      Origin = 'idFuncionario'
      Required = True
      Visible = False
    end
  end
  object ds_usuarios: TDataSource
    DataSet = query_usuarios
    Left = 320
    Top = 248
  end
  object tb_fornecedores: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.fornecedores'
    TableName = 'pdv.fornecedores'
    Left = 424
    Top = 104
  end
  object query_fornecedores: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM fornecedores ORDER BY nome asc;')
    Left = 424
    Top = 184
    object query_fornecedoresid: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object query_fornecedoresnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 20
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object query_fornecedoressegmento: TStringField
      DisplayLabel = 'Segmento'
      DisplayWidth = 18
      FieldName = 'segmento'
      Origin = 'segmento'
      Required = True
      Size = 25
    end
    object query_fornecedoresendereco: TStringField
      DisplayLabel = 'Endereco'
      DisplayWidth = 20
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 35
    end
    object query_fornecedorestelefone: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 17
      FieldName = 'telefone'
      Origin = 'telefone'
      Required = True
      Size = 15
    end
    object query_fornecedoresdata: TDateField
      DisplayLabel = 'Data de Cadastro'
      DisplayWidth = 8
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
  end
  object ds_fornecedores: TDataSource
    DataSet = query_fornecedores
    Left = 424
    Top = 248
  end
end
