unit Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Mask, Vcl.StdCtrls, Vcl.Buttons, Conexao;

type
  TFrmFornecedores = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    txtBuscaNome: TEdit;
    txtNome: TEdit;
    txtEndereco: TEdit;
    txtTelefone: TMaskEdit;
    DBGrid1: TDBGrid;
    txtSegmento: TEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtBuscaNomeChange(Sender: TObject);
  private
    { Private declarations }
    procedure habilitarCampos;
    procedure limparCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;
    procedure buscarNome;

  public
    { Public declarations }
  end;

var
  FrmFornecedores: TFrmFornecedores;

  id : String;

implementation

{$R *.dfm}

{ TFrmFornecedores }

procedure TFrmFornecedores.associarCampos;
begin
  dm.tb_fornecedores.FieldByName('nome').Value := txtNome.Text;
  dm.tb_fornecedores.FieldByName('segmento').Value := txtSegmento.Text;
  dm.tb_fornecedores.FieldByName('telefone').Value := txtTelefone.Text;
  dm.tb_fornecedores.FieldByName('endereco').Value := txtEndereco.Text;

  dm.tb_fornecedores.FieldByName('data').Value := DateToStr(Date);
end;

procedure TFrmFornecedores.btnEditarClick(Sender: TObject);
begin

  if Trim(txtNome.Text) = '' then
       begin
           MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
           txtNome.SetFocus;
           exit;
       end;


       associarCampos;
       dm.query_fornecedores.Close;
       dm.query_fornecedores.SQL.Clear;
       dm.query_fornecedores.SQL.Add('UPDATE fornecedores set nome = :nome, segmento = :segmento, endereco = :endereco, telefone = :telefone where id = :id');
       dm.query_fornecedores.ParamByName('nome').Value := txtNome.Text;
       dm.query_fornecedores.ParamByName('segmento').Value := txtSegmento.Text;
       dm.query_fornecedores.ParamByName('endereco').Value := txtEndereco.Text;
       dm.query_fornecedores.ParamByName('telefone').Value := txtTelefone.Text;

       dm.query_fornecedores.ParamByName('id').Value := id;
       dm.query_fornecedores.ExecSQL;


       listar;
       MessageDlg('Editado com Sucesso!!', mtInformation, mbOKCancel, 0);
       btnEditar.Enabled := false;
       BtnExcluir.Enabled := false;
       limparCampos;
       desabilitarCampos;

end;

procedure TFrmFornecedores.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tb_fornecedores.Delete;
    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);


     btnEditar.Enabled := false;
     BtnExcluir.Enabled := false;
     txtNome.Text := '';
     listar;
  end;

end;

procedure TFrmFornecedores.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  dm.tb_fornecedores.Insert;
  btnSalvar.Enabled := true;
end;

procedure TFrmFornecedores.btnSalvarClick(Sender: TObject);
begin
  if Trim(txtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
    txtNome.SetFocus;
    exit;
  end;



  associarCampos;
  dm.tb_fornecedores.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limparCampos;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;
end;

procedure TFrmFornecedores.buscarNome;
begin
  dm.query_fornecedores.Close;
  dm.query_fornecedores.SQL.Clear;
  dm.query_fornecedores.SQL.Add('SELECT * from fornecedores where nome LIKE :nome order by nome asc');
  dm.query_fornecedores.ParamByName('nome').Value := txtBuscaNome.Text + '%';
  dm.query_fornecedores.Open;
end;

procedure TFrmFornecedores.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_fornecedores.Edit;


  txtNome.Text := dm.query_fornecedores.FieldByName('nome').Value;

  txtSegmento.Text := dm.query_fornecedores.FieldByName('segmento').Value;



  if dm.query_fornecedores.FieldByName('telefone').Value <> null then
  txtTelefone.Text := dm.query_fornecedores.FieldByName('telefone').Value;

  if dm.query_fornecedores.FieldByName('endereco').Value <> null then
  txtEndereco.Text := dm.query_fornecedores.FieldByName('endereco').Value;

  id := dm.query_fornecedores.FieldByName('id').Value;

end;

procedure TFrmFornecedores.desabilitarCampos;
begin
  txtNome.Enabled := false;
  txtSegmento.Enabled := false;
  txtEndereco.Enabled := false;
  txtTelefone.Enabled := false;
end;

procedure TFrmFornecedores.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  dm.tb_fornecedores.Active := true;
  listar;
  listar;
end;

procedure TFrmFornecedores.habilitarCampos;
begin
  txtNome.Enabled := true;
  txtSegmento.Enabled := true;
  txtEndereco.Enabled := true;
  txtTelefone.Enabled := true;
end;

procedure TFrmFornecedores.limparCampos;
begin
  txtNome.Text := '';
  txtSegmento.Text := '';
  txtEndereco.Text := '';
  txtTelefone.Text := '';
end;

procedure TFrmFornecedores.listar;
begin
  dm.query_fornecedores.Close;
  dm.query_fornecedores.SQL.Clear;
  dm.query_fornecedores.SQL.Add('SELECT * from fornecedores order by nome asc');
  dm.query_fornecedores.Open;
end;

procedure TFrmFornecedores.txtBuscaNomeChange(Sender: TObject);
begin
  buscarNome;
end;

end.
