program Arduino_Delphi_ComPort;

uses
  Forms,
  ComMainForm in 'Examples\delphi\ComMainForm.pas' {FormPrincipal},
  uFuncoes in 'uFuncoes.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'TComPort ver. 2.10 example';
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
