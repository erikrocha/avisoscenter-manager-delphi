object frm_ad_list: Tfrm_ad_list
  Left = 0
  Top = 0
  Caption = 'Lista de Avisos'
  ClientHeight = 299
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnResize = FormResize
  TextHeight = 13
  object pnl_container: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 299
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 982
    ExplicitHeight = 295
    object pnl_body: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 61
      Width = 962
      Height = 227
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 960
      ExplicitHeight = 223
      object sg_data: TStringGrid
        Left = 1
        Top = 1
        Width = 960
        Height = 225
        Align = alClient
        DrawingStyle = gdsGradient
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
        TabOrder = 0
        ExplicitWidth = 958
        ExplicitHeight = 221
      end
    end
    object pnl_header: TPanel
      Left = 1
      Top = 1
      Width = 982
      Height = 50
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 980
      object btn_refresh: TSpeedButton
        AlignWithMargins = True
        Left = 706
        Top = 11
        Width = 32
        Height = 28
        Margins.Left = 10
        Margins.Top = 10
        Margins.Bottom = 10
        Align = alRight
        Glyph.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFDEDEDE5A5A5A0C0C0C000000000000070707525252D0
          D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3F0000000000000000000000000000
          000000000000000000002B2B2BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000797979
          E5E5E5FFFFFFFFFFFFECECEC858585000000000000000000FDFDFDFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11111100000012
          1212FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF242424000000
          000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9090
          90000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF111111000000707070FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF000000000000CDCDCDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFECECEC000000000000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFDBDBDB000000070707FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF252525000000BABA
          BAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9F0000005B5B5BFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          7272720000008E8E8EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8C8C8C0000
          00737373FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFA2A2A2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF9F9F9F0000005A5A5AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFDBDBDB000000070707FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000CCCCCCFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9090
          90000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F1F00000009
          0909404040707070F3F3F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF111111000000121212FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF5C5C5C000000000000000000000000525252FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000787878
          E2E2E2FFFFFFFFFFFFFDFDFD999999000000000000000000888888FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F
          3F3F000000000000000000000000000000000000000000000000000000000000
          C1C1C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFDEDEDE5C5C5C0E0E0E000000000000070707525252EE
          EEEE040404000000F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF121212030303FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ExplicitLeft = 823
        ExplicitTop = 12
      end
      object lbl_count: TLabel
        AlignWithMargins = True
        Left = 11
        Top = 11
        Width = 43
        Height = 28
        Margins.Left = 10
        Margins.Top = 10
        Margins.Bottom = 10
        Align = alLeft
        Caption = 'lbl_count'
        ExplicitHeight = 13
      end
      object btn_new: TButton
        AlignWithMargins = True
        Left = 741
        Top = 11
        Width = 75
        Height = 28
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 5
        Margins.Bottom = 10
        Align = alRight
        Caption = 'Nuevo'
        TabOrder = 0
        OnClick = btn_newClick
        ExplicitLeft = 739
      end
      object btn_edit: TButton
        AlignWithMargins = True
        Left = 821
        Top = 11
        Width = 75
        Height = 28
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 5
        Margins.Bottom = 10
        Align = alRight
        Caption = 'Editar'
        TabOrder = 1
        OnClick = btn_editClick
        ExplicitLeft = 819
      end
      object edt_delete: TButton
        AlignWithMargins = True
        Left = 901
        Top = 11
        Width = 75
        Height = 28
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 5
        Margins.Bottom = 10
        Align = alRight
        Caption = 'Eliminar'
        TabOrder = 2
        ExplicitLeft = 899
      end
      object btn_pag_1: TButton
        Left = 128
        Top = 6
        Width = 57
        Height = 25
        Caption = 'Pag 1'
        TabOrder = 3
        OnClick = btn_pag_1Click
      end
      object btn_pag_2: TButton
        Left = 191
        Top = 6
        Width = 57
        Height = 25
        Caption = 'Pag 2'
        TabOrder = 4
        OnClick = btn_pag_2Click
      end
      object btn_pag_3: TButton
        Left = 254
        Top = 6
        Width = 57
        Height = 25
        Caption = 'Pag 3'
        TabOrder = 5
        OnClick = btn_pag_3Click
      end
    end
  end
end
