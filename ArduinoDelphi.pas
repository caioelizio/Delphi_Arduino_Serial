unit ArduinoDelphi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CPort, StdCtrls;

type
  TForm1 = class(TForm)
    ComPort1: TComPort;
    btnPainel: TButton;
    btnOpenPort: TButton;
    MemoLog: TMemo;
    Label1: TLabel;
    btnComunicar: TButton;
    btnFechar: TButton;
    procedure btnPainelClick(Sender: TObject);
    procedure btnOpenPortClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnPainelClick(Sender: TObject);
begin
      ComPort1.ShowSetupDialog;
      btnOpenPort.Enabled := True;
end;

procedure TForm1.btnOpenPortClick(Sender: TObject);
begin
  ComPort1.Open;
  if ComPort1.Connected then
  begin
    MemoLog.Text := MemoLog.Text + 'Conexao OK! ('+ComPort1.Port+')';
  end
end;

end.
