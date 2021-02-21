object Form1: TForm1
  Left = 192
  Top = 107
  Width = 453
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 376
    Top = 416
    Width = 48
    Height = 13
    Caption = 'Caio Elizio'
  end
  object btnPainel: TButton
    Left = 16
    Top = 104
    Width = 89
    Height = 25
    Caption = 'Painel'
    TabOrder = 0
    OnClick = btnPainelClick
  end
  object btnOpenPort: TButton
    Left = 16
    Top = 152
    Width = 89
    Height = 25
    Caption = 'Abrir Conexao'
    Enabled = False
    TabOrder = 1
    OnClick = btnOpenPortClick
  end
  object MemoLog: TMemo
    Left = 112
    Top = 64
    Width = 321
    Height = 273
    Lines.Strings = (
      'log de comunicao serial...')
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = False
    TabOrder = 2
  end
  object btnComunicar: TButton
    Left = 16
    Top = 200
    Width = 89
    Height = 25
    Caption = 'Comunicar'
    Enabled = False
    TabOrder = 3
  end
  object btnFechar: TButton
    Left = 16
    Top = 248
    Width = 89
    Height = 25
    Caption = 'Fechar Conexao'
    Enabled = False
    TabOrder = 4
  end
  object ComPort1: TComPort
    Connected = True
    BaudRate = br115200
    Port = 'COM7'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    StoredProps = [spBasic]
    TriggersOnRxChar = True
    Left = 48
    Top = 24
  end
end
