object InfoForm: TInfoForm
  Left = 302
  Top = 120
  Width = 571
  Height = 402
  BorderIcons = [biSystemMenu]
  Caption = 'HID Device Usage Info'
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    000001000200101010000100100028010000260000002020100001001000E802
    00004E0100002800000010000000200000000100040000000000C00000000000
    0000000000000000000000000000000000000000800000800000008080008000
    00008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00000000000000000000000BBBB0000000000B
    B000BB000000000BB0000B000000000BBB000BB00000000BBB000BB000000000
    00000BB00000000000000BB00000000000000BB00000000000000BB000000000
    00000BB00000000000000BB00000000000000BB0000000000000BBBB00000000
    000BBBBBB0000000000000000000FFFF0000F87F0000E73F0000E7BF0000E39F
    0000E39F0000FF9F0000FF9F0000FF9F0000FF9F0000FF9F0000FF9F0000FF9F
    0000FF0F0000FE070000FFFF0000280000002000000040000000010004000000
    0000800200000000000000000000000000000000000000000000000080000080
    000000808000800000008000800080800000C0C0C000808080000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
    000000000000000000000000000000000000000000000000000000BBBBBB0000
    00000000000000000000BBB0000BBB000000000000000000000BB00000000BBB
    0000000000000000000BB00000000BBB000000000000000000BBBB0000000BBB
    B00000000000000000BBBB00000000BBBB0000000000000000BBBBB0000000BB
    BB0000000000000000BBBBB0000000BBBB0000000000000000BBBBB0000000BB
    BB00000000000000000BBB00000000BBBB0000000000000000000000000000BB
    BB0000000000000000000000000000BBBB0000000000000000000000000000BB
    BB0000000000000000000000000000BBBB0000000000000000000000000000BB
    BB0000000000000000000000000000BBBB0000000000000000000000000000BB
    BB0000000000000000000000000000BBBB0000000000000000000000000000BB
    BB0000000000000000000000000000BBBB0000000000000000000000000000BB
    BB0000000000000000000000000000BBBB0000000000000000000000000000BB
    BB0000000000000000000000000000BBBB0000000000000000000000000000BB
    BB0000000000000000000000000000BBBB00000000000000000000000000BBBB
    BBB00000000000000000000000BBBBBBBBBBBB00000000000000000000000000
    00000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFC0
    FFFFFF1E3FFFFE7F8FFFFE7F8FFFFC3F87FFFC3FC3FFFC1FC3FFFC1FC3FFFC1F
    C3FFFE3FC3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFF
    C3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFFC3FFFFFF
    C3FFFFFFC3FFFFFF01FFFFFC003FFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object InfoMemo: TMemo
    Left = 0
    Top = 0
    Width = 561
    Height = 337
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Save: TButton
    Left = 16
    Top = 345
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Save'
    TabOrder = 1
    OnClick = SaveClick
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'text files|*.txt|all files|*.*'
    Left = 104
    Top = 328
  end
end
