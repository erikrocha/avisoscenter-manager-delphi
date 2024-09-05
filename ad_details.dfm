object frm_ad_details: Tfrm_ad_details
  Left = 0
  Top = 0
  Caption = 'Aviso'
  ClientHeight = 577
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  TextHeight = 13
  object pnl_ad_details: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 496
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 3
    ExplicitWidth = 398
    ExplicitHeight = 493
    object lbl_date: TLabel
      Left = 20
      Top = 53
      Width = 29
      Height = 13
      Caption = 'Fecha'
    end
    object lbl_category: TLabel
      Left = 20
      Top = 111
      Width = 47
      Height = 13
      Caption = 'Categoria'
    end
    object lbl_ad: TLabel
      Left = 20
      Top = 143
      Width = 26
      Height = 13
      Caption = 'Aviso'
    end
    object lbl_telefono: TLabel
      Left = 20
      Top = 231
      Width = 42
      Height = 13
      Caption = 'Tel'#233'fono'
    end
    object lbl_direction: TLabel
      Left = 20
      Top = 327
      Width = 43
      Height = 13
      Caption = 'Direcci'#243'n'
    end
    object lbl_latitude: TLabel
      Left = 20
      Top = 352
      Width = 26
      Height = 13
      Caption = 'Mapa'
    end
    object lbl_condition: TLabel
      Left = 20
      Top = 386
      Width = 46
      Height = 13
      Caption = 'Condici'#243'n'
    end
    object lbl_status: TLabel
      Left = 238
      Top = 18
      Width = 33
      Height = 13
      Caption = 'Estado'
      OnClick = lbl_statusClick
    end
    object lbl_type: TLabel
      Left = 251
      Top = 110
      Width = 20
      Height = 13
      Caption = 'Tipo'
    end
    object lbl_price: TLabel
      Left = 190
      Top = 386
      Width = 29
      Height = 13
      Caption = 'Precio'
    end
    object lbl_city: TLabel
      Left = 20
      Top = 17
      Width = 33
      Height = 13
      Caption = 'Ciudad'
    end
    object lbl_currency: TLabel
      Left = 281
      Top = 386
      Width = 38
      Height = 13
      Caption = 'Moneda'
    end
    object lbl_expired: TLabel
      Left = 20
      Top = 80
      Width = 30
      Height = 13
      Caption = 'Expira'
    end
    object lbl_notes: TLabel
      Left = 21
      Top = 412
      Width = 28
      Height = 13
      Caption = 'Notas'
    end
    object cmb_category: TComboBox
      Left = 73
      Top = 107
      Width = 152
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = cmb_categoryChange
      OnCloseUp = cmb_categoryCloseUp
      Items.Strings = (
        'Necesito'
        'Alquilo'
        'Vendo'
        'Traspaso'
        'Anticresis'
        'Servicios'
        'Otros')
    end
    object cmb_type: TComboBox
      Left = 277
      Top = 107
      Width = 106
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      Items.Strings = (
        'Habitaci'#243'n'
        'Habitaci'#243'n + ba'#241'o'
        'Mini Departamento'
        'Departamento'
        'Casa'
        'Local comercial'
        'Otros'
        'Veh'#237'culo'
        'Terreno')
    end
    object edt_phone: TEdit
      Left = 73
      Top = 228
      Width = 121
      Height = 21
      Color = clWhite
      TabOrder = 0
      OnKeyPress = edt_phoneKeyPress
    end
    object edt_address: TEdit
      Left = 73
      Top = 323
      Width = 246
      Height = 21
      TabOrder = 5
    end
    object edt_latitudeLongitude: TEdit
      Left = 73
      Top = 352
      Width = 310
      Height = 21
      TabOrder = 6
    end
    object mmo_body: TMemo
      Left = 73
      Top = 140
      Width = 310
      Height = 77
      TabOrder = 4
    end
    object cmb_status: TComboBox
      Left = 277
      Top = 14
      Width = 106
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 14
      Text = 'Activo'
      Items.Strings = (
        'Inactivo'
        'Activo')
    end
    object btn_images: TButton
      Left = 82
      Top = 455
      Width = 66
      Height = 25
      Caption = 'Imagenes'
      TabOrder = 12
      OnClick = btn_imagesClick
    end
    object btn_save: TButton
      Left = 221
      Top = 455
      Width = 162
      Height = 25
      Caption = 'Guardar'
      TabOrder = 15
      OnClick = btn_saveClick
    end
    object cmb_condition: TComboBox
      Left = 73
      Top = 382
      Width = 56
      Height = 21
      Style = csDropDownList
      TabOrder = 7
      OnChange = cmb_conditionChange
      OnCloseUp = cmb_conditionCloseUp
      Items.Strings = (
        'Pagado'
        'Gratis')
    end
    object ckb_isIA: TCheckBox
      Left = 135
      Top = 384
      Width = 56
      Height = 17
      Caption = #191'isIA?'
      TabOrder = 8
    end
    object edt_price: TEdit
      Left = 223
      Top = 382
      Width = 50
      Height = 21
      TabOrder = 9
    end
    object dtp_date: TDateTimePicker
      Left = 73
      Top = 49
      Width = 81
      Height = 21
      Date = 45121.000000000000000000
      Time = 0.616653495373611800
      TabOrder = 16
    end
    object dtp_time: TDateTimePicker
      Left = 153
      Top = 49
      Width = 72
      Height = 21
      Date = 45121.000000000000000000
      Time = 0.616653495373611800
      Kind = dtkTime
      TabOrder = 17
    end
    object btn_juliaca: TButton
      Left = 312
      Top = 321
      Width = 71
      Height = 25
      Caption = 'Juliaca'
      TabOrder = 18
      OnClick = btn_juliacaClick
    end
    object lb_phones: TListBox
      Left = 200
      Top = 228
      Width = 183
      Height = 87
      ItemHeight = 13
      TabOrder = 19
    end
    object btn_phone: TButton
      Left = 73
      Top = 250
      Width = 81
      Height = 25
      Caption = '+'
      TabOrder = 20
      OnClick = btn_phoneClick
    end
    object btn_phone_delete: TButton
      Left = 158
      Top = 250
      Width = 36
      Height = 25
      Caption = '-'
      TabOrder = 21
      OnClick = btn_phone_deleteClick
    end
    object btn_services: TButton
      Left = 20
      Top = 455
      Width = 60
      Height = 25
      Caption = 'Servicios'
      TabOrder = 11
      OnClick = btn_servicesClick
    end
    object mmo_json: TMemo
      Left = 74
      Top = 281
      Width = 120
      Height = 34
      Lines.Strings = (
        'mmo_json')
      ScrollBars = ssVertical
      TabOrder = 22
      Visible = False
    end
    object cmb_city: TComboBox
      Left = 73
      Top = 14
      Width = 106
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Juliaca'
      OnSelect = cmb_citySelect
      Items.Strings = (
        'Juliaca'
        'Puno'
        'Puerto Maldonado')
    end
    object cmb_currency: TComboBox
      Left = 325
      Top = 382
      Width = 58
      Height = 21
      Style = csDropDownList
      TabOrder = 10
      Items.Strings = (
        'soles'
        'dolares')
    end
    object btn_vehicles: TButton
      Left = 150
      Top = 455
      Width = 65
      Height = 25
      Caption = 'Veh'#237'culos'
      TabOrder = 13
      OnClick = btn_vehiclesClick
    end
    object dtp_date_expired: TDateTimePicker
      Left = 73
      Top = 76
      Width = 81
      Height = 21
      Date = 45121.000000000000000000
      Format = #39#39
      Time = 0.616653495373611800
      TabOrder = 23
    end
    object dtp_time_expired: TDateTimePicker
      Left = 153
      Top = 76
      Width = 72
      Height = 21
      Date = 45121.000000000000000000
      Time = 0.616653495373611800
      Kind = dtkTime
      TabOrder = 24
    end
    object mmo_notes: TMemo
      Left = 73
      Top = 409
      Width = 310
      Height = 39
      TabOrder = 25
    end
    object btn_tmp: TButton
      Left = 244
      Top = 41
      Width = 75
      Height = 25
      Caption = 'tmp'
      TabOrder = 26
      Visible = False
    end
  end
  object pnl_ads: TPanel
    Left = 0
    Top = 496
    Width = 400
    Height = 81
    Margins.Top = 0
    Align = alBottom
    Color = clWhite
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 2
    ExplicitTop = 493
    ExplicitWidth = 398
    object lb_ads: TListBox
      AlignWithMargins = True
      Left = 6
      Top = 22
      Width = 388
      Height = 58
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = lb_adsDblClick
      ExplicitWidth = 386
    end
    object pnl_header: TPanel
      Left = 1
      Top = 1
      Width = 398
      Height = 16
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 396
      object lbl_ads_count: TLabel
        AlignWithMargins = True
        Left = 386
        Top = 1
        Width = 6
        Height = 14
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alRight
        Alignment = taRightJustify
        Caption = '0'
        ExplicitHeight = 13
      end
      object btn_ads_clear: TButton
        AlignWithMargins = True
        Left = 6
        Top = 1
        Width = 75
        Height = 14
        Margins.Left = 5
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Limpiar'
        TabOrder = 0
        OnClick = btn_ads_clearClick
      end
    end
  end
  object pnl_images: TPanel
    Left = 716
    Top = 496
    Width = 401
    Height = 142
    BorderStyle = bsSingle
    TabOrder = 1
    Visible = False
    object lbl_image: TLabel
      Left = 14
      Top = 30
      Width = 36
      Height = 13
      Caption = 'Imagen'
    end
    object lbl_images_close: TLabel
      Left = 375
      Top = 5
      Width = 20
      Height = 13
      Caption = '[ X ]'
      OnClick = lbl_images_closeClick
    end
    object btn_imageURL: TButton
      Left = 318
      Top = 24
      Width = 75
      Height = 25
      Caption = '+'
      TabOrder = 0
      OnClick = btn_imageURLClick
    end
    object mmo_imageUrl: TMemo
      Left = 64
      Top = 24
      Width = 257
      Height = 25
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object lb_images: TListBox
      Left = 8
      Top = 55
      Width = 385
      Height = 73
      ItemHeight = 13
      TabOrder = 2
    end
  end
  object pnl_services: TPanel
    Left = 388
    Top = 526
    Width = 313
    Height = 105
    BorderStyle = bsSingle
    TabOrder = 0
    Visible = False
    object lbl_services_close: TLabel
      Left = 282
      Top = 6
      Width = 20
      Height = 13
      Caption = '[ X ]'
      OnClick = lbl_services_closeClick
    end
    object gpb_services: TGroupBox
      Left = 5
      Top = 17
      Width = 297
      Height = 81
      Caption = 'Servicios'
      TabOrder = 0
      object ckb_bath: TCheckBox
        Left = 8
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Ba'#241'o privado'
        TabOrder = 0
      end
      object ckb_wifi: TCheckBox
        Left = 8
        Top = 39
        Width = 97
        Height = 17
        Caption = 'Wifi'
        TabOrder = 1
      end
      object ckb_cable: TCheckBox
        Left = 8
        Top = 62
        Width = 97
        Height = 17
        Caption = 'Cable'
        TabOrder = 2
      end
      object ckb_parkingMoto: TCheckBox
        Left = 92
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Parqueo moto'
        TabOrder = 3
      end
      object ckb_parkingCar: TCheckBox
        Left = 92
        Top = 39
        Width = 97
        Height = 17
        Caption = 'Parqueo carro'
        TabOrder = 4
      end
      object ckb_thermal: TCheckBox
        Left = 92
        Top = 62
        Width = 97
        Height = 17
        Caption = 'Agua caliente'
        TabOrder = 5
      end
      object ckb_laundry: TCheckBox
        Left = 184
        Top = 16
        Width = 118
        Height = 17
        Caption = 'Zona de lavander'#237'a'
        TabOrder = 6
      end
      object ckb_silent: TCheckBox
        Left = 184
        Top = 39
        Width = 97
        Height = 17
        Caption = 'Silencioso'
        TabOrder = 7
      end
      object ckb_pets: TCheckBox
        Left = 184
        Top = 62
        Width = 97
        Height = 17
        Caption = 'Permite mascotas'
        TabOrder = 8
      end
    end
  end
  object pnl_vehicles: TPanel
    Left = 401
    Top = 14
    Width = 216
    Height = 259
    BorderStyle = bsSingle
    TabOrder = 4
    Visible = False
    object lbl_brand: TLabel
      Left = 12
      Top = 29
      Width = 29
      Height = 13
      Caption = 'Marca'
    end
    object lbl_model: TLabel
      Left = 12
      Top = 53
      Width = 34
      Height = 13
      Caption = 'Modelo'
    end
    object lbl_year: TLabel
      Left = 12
      Top = 80
      Width = 19
      Height = 13
      Caption = 'A'#241'o'
    end
    object lbl_mileage: TLabel
      Left = 12
      Top = 134
      Width = 25
      Height = 13
      Caption = 'Millas'
    end
    object lbl_engine: TLabel
      Left = 12
      Top = 107
      Width = 28
      Height = 13
      Caption = 'Motor'
    end
    object lbl_fuel: TLabel
      Left = 12
      Top = 161
      Width = 58
      Height = 13
      Caption = 'Combustible'
    end
    object lbl_transmission: TLabel
      Left = 12
      Top = 188
      Width = 56
      Height = 13
      Caption = 'Transmisi'#243'n'
    end
    object color: TLabel
      Left = 12
      Top = 215
      Width = 25
      Height = 13
      Caption = 'Color'
    end
    object lbl_vehicles_close: TLabel
      Left = 184
      Top = 6
      Width = 14
      Height = 13
      Caption = '[X]'
      OnClick = lbl_vehicles_closeClick
    end
    object cmb_brand: TComboBox
      Left = 87
      Top = 25
      Width = 106
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnSelect = cmb_brandSelect
    end
    object cmb_model: TComboBox
      Left = 87
      Top = 49
      Width = 106
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnSelect = cmb_modelSelect
    end
    object edt_year: TEdit
      Left = 87
      Top = 76
      Width = 42
      Height = 21
      BevelKind = bkFlat
      TabOrder = 2
    end
    object edt_mileage: TEdit
      Left = 87
      Top = 130
      Width = 58
      Height = 21
      BevelKind = bkFlat
      TabOrder = 3
    end
    object edt_engine: TEdit
      Left = 87
      Top = 103
      Width = 82
      Height = 21
      BevelKind = bkFlat
      TabOrder = 4
    end
    object edt_fuel: TEdit
      Left = 87
      Top = 157
      Width = 106
      Height = 21
      BevelKind = bkFlat
      TabOrder = 5
    end
    object edt_transmission: TEdit
      Left = 87
      Top = 184
      Width = 106
      Height = 21
      BevelKind = bkFlat
      TabOrder = 6
    end
    object edt_color: TEdit
      Left = 87
      Top = 211
      Width = 82
      Height = 21
      BevelKind = bkFlat
      TabOrder = 7
    end
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 352
    Top = 48
  end
end
