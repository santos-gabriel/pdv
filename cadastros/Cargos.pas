unit Cargos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls;

type
  TfrmCargos = class(TForm)
    Label2: TLabel;
    txtCargo: TEdit;
    grid: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure associarCampos;
    procedure listar;
  public
    { Public declarations }
  end;

var
  frmCargos: TfrmCargos;
  id : String;

implementation

{$R *.dfm}

uses Conexao;

procedure TfrmCargos.associarCampos;
begin
  dm.tb_cargos.FieldByName('cargo').Value := txtCargo.Text;
end;

procedure TfrmCargos.btnEditarClick(Sender: TObject);
  var
    cargo : String;
begin

  if Trim(txtCargo.Text) = '' then
  begin
    MessageDlg('Escolha um valor para editar!', mtInformation, mbOKCancel, 0);
    txtCargo.SetFocus;
    listar;
    exit;
  end;

  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add('SELECT * FROM cargos where cargo = ' + QuotedStr(Trim(txtCargo.Text)));
  dm.query_cargos.Open;

  if not dm.query_cargos.IsEmpty then
   begin
     cargo := dm.query_cargos['cargo'];
     MessageDlg('Cargo '+cargo+' já cadastrado', mtInformation, mbOKCancel, 0);
     txtCargo.Text := '';
     txtCargo.SetFocus;
     listar;
     exit;
   end;

   associarCampos;
   dm.query_cargos.Close;
   dm.query_cargos.SQL.Clear;
   dm.query_cargos.SQL.Add('UPDATE cargos SET cargo = :cargo WHERE id = :id;');
   dm.query_cargos.ParamByName('cargo').Value := txtCargo.Text;
   dm.query_cargos.ParamByName('id').Value := id;
   dm.query_cargos.ExecSQL;

   listar;
   MessageDlg('Editado com sucesso!', mtConfirmation, mbOKCancel, 0);
   btnEditar.Enabled := false;
   btnExcluir.Enabled := false;
   txtCargo.Text := '';
   txtCargo.Enabled := false;

end;

procedure TfrmCargos.btnExcluirClick(Sender: TObject);
begin

  if MessageDlg('Deseja excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tb_cargos.Delete;
  end;

  txtCargo.Text := '';
  txtCargo.Enabled := false;
  btnSalvar.Enabled := false;
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  listar

end;

procedure TfrmCargos.btnNovoClick(Sender: TObject);
begin
  btnSalvar.Enabled := true;
  txtCargo.Enabled := true;
  txtCargo.Text := '';
  txtCargo.SetFocus;
  dm.tb_cargos.Insert;
end;

procedure TfrmCargos.btnSalvarClick(Sender: TObject);
  var
    cargo : String;
begin

  //VERIFICAR CAMPO VAZIO
  if Trim(txtCargo.Text) = '' then
  begin
    MessageDlg('Preencha o cargo!', mtInformation, mbOKCancel, 0);
    txtCargo.SetFocus;
    exit;
  end;

  //VERIFICAR CARGO JA CADASTRADO
  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add('SELECT * FROM cargos WHERE cargo = ' + QuotedStr(Trim(txtCargo.Text)));
  dm.query_cargos.Open;

  if not dm.query_cargos.IsEmpty then
  begin
      cargo := dm.query_cargos['cargo'];
      MessageDlg('Cargo '+cargo+' já está cadastrado!', mtInformation, mbOKCancel, 0);
      txtCargo.Text := '';
      txtCargo.SetFocus;
      exit;
  end;


  associarCampos;
  dm.tb_cargos.Post;
  MessageDlg('Salvo com sucesso!', mtConfirmation, mbOKCancel, 0);
  txtCargo.Text := '';
  txtCargo.Enabled := false;
  btnSalvar.Enabled := false;
  listar;


end;

procedure TfrmCargos.FormCreate(Sender: TObject);
begin
  dm.tb_cargos.Active := true;
  listar;
end;

procedure TfrmCargos.gridCellClick(Column: TColumn);
begin

  txtCargo.Enabled := true;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_cargos.Edit;
  if dm.query_cargos.FieldByName('cargo').Value <> null then
    txtCargo.Text := dm.query_cargos.FieldByName('cargo').Value;

  id := dm.query_cargos.FieldByName('id').Value;


end;

procedure TfrmCargos.listar;
begin

  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add('SELECT * FROM cargos ORDER BY cargo asc;');
  dm.query_cargos.Open;

end;

end.
