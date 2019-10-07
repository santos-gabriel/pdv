unit Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  Tdm = class(TDataModule)
    fd: TFDConnection;
    driver: TFDPhysMySQLDriverLink;
    tb_cargos: TFDTable;
    query_cargos: TFDQuery;
    query_cargosid: TFDAutoIncField;
    query_cargoscargo: TStringField;
    ds_cargos: TDataSource;
    tb_func: TFDTable;
    query_func: TFDQuery;
    ds_func: TDataSource;
    query_funcid: TFDAutoIncField;
    query_funcnome: TStringField;
    query_funccpf: TStringField;
    query_functelefone: TStringField;
    query_funcendereco: TStringField;
    query_funccargo: TStringField;
    query_funcdata: TDateField;
    tb_usuarios: TFDTable;
    query_usuarios: TFDQuery;
    query_usuariosid: TFDAutoIncField;
    query_usuariosnome: TStringField;
    query_usuariosusuario: TStringField;
    query_usuariossenha: TStringField;
    query_usuarioscargo: TStringField;
    query_usuariosidFuncionario: TIntegerField;
    ds_usuarios: TDataSource;
    tb_fornecedores: TFDTable;
    query_fornecedores: TFDQuery;
    ds_fornecedores: TDataSource;
    query_fornecedoresid: TFDAutoIncField;
    query_fornecedoresnome: TStringField;
    query_fornecedoressegmento: TStringField;
    query_fornecedoresendereco: TStringField;
    query_fornecedorestelefone: TStringField;
    query_fornecedoresdata: TDateField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

  //DECLARACAO DAS VARIAVEIS GLOBAIS
  idFuncionario : String;
  nomeFuncionario : String;
  cargoFuncionario : String;

  chamada : String;

  nomeUsuario : String;
  cargoUsuario : String;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  fd.Connected := true;
end;

end.
