unit ad_details;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  JSON.Types, JSON.Writers, Vcl.ComCtrls, RegularExpressions, vcl.Imaging.pngimage,

  uAPIRest, Vcl.ExtDlgs;

type
  Tfrm_ad_details = class(TForm)
    mmo_json: TMemo;
    pnl_services: TPanel;
    gpb_services: TGroupBox;
    ckb_bath: TCheckBox;
    ckb_wifi: TCheckBox;
    ckb_cable: TCheckBox;
    ckb_parkingMoto: TCheckBox;
    ckb_parkingCar: TCheckBox;
    ckb_thermal: TCheckBox;
    ckb_laundry: TCheckBox;
    ckb_silent: TCheckBox;
    ckb_pets: TCheckBox;
    pnl_images: TPanel;
    lbl_image: TLabel;
    btn_imageURL: TButton;
    mmo_imageUrl: TMemo;
    lb_images: TListBox;
    pnl_ads: TPanel;
    lb_ads: TListBox;
    lbl_services_close: TLabel;
    lbl_images_close: TLabel;
    pnl_ad_details: TPanel;
    lbl_date: TLabel;
    lbl_category: TLabel;
    lbl_ad: TLabel;
    lbl_telefono: TLabel;
    lbl_direction: TLabel;
    lbl_latitude: TLabel;
    lbl_condition: TLabel;
    lbl_status: TLabel;
    lbl_type: TLabel;
    lbl_price: TLabel;
    cmb_category: TComboBox;
    cmb_type: TComboBox;
    edt_phone: TEdit;
    edt_address: TEdit;
    edt_latitudeLongitude: TEdit;
    mmo_body: TMemo;
    cmb_status: TComboBox;
    btn_images: TButton;
    btn_save: TButton;
    cmb_condition: TComboBox;
    ckb_isIA: TCheckBox;
    edt_price: TEdit;
    dtp_date: TDateTimePicker;
    dtp_time: TDateTimePicker;
    btn_juliaca: TButton;
    lb_phones: TListBox;
    btn_phone: TButton;
    btn_phone_delete: TButton;
    btn_services: TButton;
    lbl_ads_count: TLabel;
    btn_ads_clear: TButton;
    pnl_header: TPanel;
    lbl_city: TLabel;
    cmb_city: TComboBox;
    cmb_currency: TComboBox;
    pnl_vehicles: TPanel;
    lbl_brand: TLabel;
    cmb_brand: TComboBox;
    lbl_model: TLabel;
    cmb_model: TComboBox;
    lbl_year: TLabel;
    edt_year: TEdit;
    lbl_mileage: TLabel;
    edt_mileage: TEdit;
    lbl_engine: TLabel;
    edt_engine: TEdit;
    lbl_fuel: TLabel;
    edt_fuel: TEdit;
    lbl_transmission: TLabel;
    edt_transmission: TEdit;
    color: TLabel;
    edt_color: TEdit;
    btn_vehicles: TButton;
    lbl_currency: TLabel;
    lbl_vehicles_close: TLabel;
    dtp_date_expired: TDateTimePicker;
    dtp_time_expired: TDateTimePicker;
    lbl_expired: TLabel;
    mmo_notes: TMemo;
    lbl_notes: TLabel;
    SavePictureDialog1: TSavePictureDialog;
    btn_tmp: TButton;
    procedure FormCreate(Sender: TObject);

    procedure cmb_categoryCloseUp(Sender: TObject);
    procedure cmb_conditionCloseUp(Sender: TObject);
    procedure btn_imageURLClick(Sender: TObject);
    procedure btn_juliacaClick(Sender: TObject);
    procedure btn_servicesClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_phoneClick(Sender: TObject);
    procedure btn_clearControlsClick(Sender: TObject);
    constructor Create(AOwner: TComponent; const AValue: string);
    procedure FormActivate(Sender: TObject);
    procedure lb_adsDblClick(Sender: TObject);
    procedure btn_phone_deleteClick(Sender: TObject);
    procedure btn_ads_clearClick(Sender: TObject);
    procedure lbl_ads_closeClick(Sender: TObject);
    procedure lbl_statusClick(Sender: TObject);
    procedure lbl_services_closeClick(Sender: TObject);
    procedure lbl_images_closeClick(Sender: TObject);
    procedure btn_imagesClick(Sender: TObject);
    procedure edt_phoneKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btn_vehiclesClick(Sender: TObject);
    procedure cmb_brandSelect(Sender: TObject);
    procedure cmb_modelSelect(Sender: TObject);
    procedure cmb_citySelect(Sender: TObject);
    procedure lbl_vehicles_closeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmb_categoryChange(Sender: TObject);
    procedure cmb_conditionChange(Sender: TObject);
  private
    procedure generateJsonAd;
    procedure clearControls;
    procedure getPhonesFromId;
    procedure getImagesFromId;
    procedure getAdsfromPhone;
    function unFlipDate(date: TDate; time: TTime): string;
    function validateLatitudeLongitude(value: string): boolean;
    procedure splitLatitudeLongitude(const InputText: string; var OutputString1, OutputString2: string);

    // api's
    procedure getBrands;
    procedure getModelByBrandId;
    procedure getCities;
    procedure getLastIdAd;

    // get comboboxID's
    procedure getBrandId;
    procedure getModelId;
    procedure getCityId;

    // generate images
    procedure generateImage;
    function getBackgroundColor(const option: string): TColor;
    function getLogoFileName(const option: string): string;

  public
    adFormAction: string;
  end;

  TBrand = record
    id: Integer;
    name: string;
  end;

var
  frm_ad_details: Tfrm_ad_details;
  _i: integer = 0;
  _countPhones: integer = 0;
  _brandId: string;
  _modelId: string;
  _cityId: string;
  _getLastIdAd: integer;

implementation

{$R *.dfm}

{ Tfrm_addDetails }

uses
  func, ad_list;


procedure Tfrm_ad_details.btn_ads_clearClick(Sender: TObject);
begin
  lb_ads.Clear;
  lbl_ads_count.Caption:= '0';
end;

procedure Tfrm_ad_details.btn_clearControlsClick(Sender: TObject);
begin
  clearControls;
end;

procedure Tfrm_ad_details.btn_imagesClick(Sender: TObject);
begin
  pnl_images.Left := (frm_ad_details.ClientWidth - pnl_images.Width) div 2;
  pnl_images.Top := (frm_ad_details.ClientHeight - pnl_images.Height) div 2;
  pnl_images.Visible:= true;
end;

procedure Tfrm_ad_details.btn_imageURLClick(Sender: TObject);
begin
  lb_images.Items.Add(trim(mmo_imageUrl.Text));
  inc(_i);
  mmo_imageUrl.Text:= '';
end;

procedure Tfrm_ad_details.btn_juliacaClick(Sender: TObject);
begin
  edt_address.Text:= 'JULIACA';
end;

procedure Tfrm_ad_details.btn_phoneClick(Sender: TObject);
begin

  if edt_phone.Text = '' then
  begin
    showMessage('Ingrese un número de celular');
  end
  else
  begin
    lb_ads.Clear;
    getAdsfromPhone;

    lb_phones.Items.Add(trim(edt_phone.Text));
    inc(_countPhones);
    edt_phone.Text:= '';
  end;


end;

procedure Tfrm_ad_details.btn_phone_deleteClick(Sender: TObject);
var
  confirmResult: Integer;
begin

  if lb_phones.ItemIndex <> -1 then
  begin
    confirmResult := MessageDlg('¿Estás seguro de eliminar este teléfono: '+lb_phones.Items.Text + ' ?', mtConfirmation, [mbYes, mbNo], 0);

    // Verificar la respuesta del usuario
    if confirmResult = mrYes then
    begin
      // Eliminar el elemento seleccionado
      lb_phones.Items.Delete(lb_phones.ItemIndex);
    end
    else
    begin
      //empty
    end;
  end
  else
  begin
     showMessage('Selecciona un número de teléfono');
  end;
end;

procedure Tfrm_ad_details.btn_saveClick(Sender: TObject);
var
  adSave: TAPIRest;
  adPut: TAPIRest;
begin

  if adFormAction = 'new'  then
  begin

    // validate latitude & longitude
    if edt_latitudeLongitude.Text <> '' then
    begin
      if not ValidateLatitudeLongitude(edt_latitudeLongitude.Text) then
      begin
        ShowMessage('Latitud/Longitud no esta ingresado correctamente. Ejm. -15.123456, -75.123456');
        edt_latitudeLongitude.SetFocus;
        edt_latitudeLongitude.SelectAll;
        abort;
      end;
    end;

    // select currency
    if edt_price.Text <> '' then
    begin
      if cmb_currency.ItemIndex = -1 then
      begin
        showMessage('Selecciona una moneda');
        abort;
      end;
    end;

    // category
    if cmb_category.ItemIndex = -1 then
    begin
      showMessage('Selecciona una categoria');
      abort;
    end;

    // if is category then select type
    if cmb_category.ItemIndex = 1 then
    begin
      if cmb_type.ItemIndex = -1 then
      begin
        showMessage('Selecciona un type');
        abort;
      end;

      if Length(trim(edt_address.Text)) = 0 then
      begin
        showMessage('Ingresa una dirección');
        abort;
      end;

  //    if Length(trim(edt_latitude.Text)) = 0 then
  //    begin
  //      showMessage('Ingresa una latitud');
  //      abort;
  //    end;
  //
  //    if Length(trim(edt_longitude.Text)) = 0 then
  //    begin
  //      showMessage('Ingresa una longitud');
  //      abort;
  //    end;
    end;

    // body
    if Length(trim(mmo_body.Text)) = 0 then
    begin
      showMessage('Ingresa el cuerpo del aviso.');
      abort;
    end;

    if lb_phones.Count = 0 then
    begin
      showMessage('Ingresa un teléfono');
      abort;
    end;

    // condition
    if cmb_condition.ItemIndex = -1 then
    begin
      showMessage('Selecciona una condición');
      abort;
    end;

    generateJsonAd;

    adSave:= TAPIRest.Create;
    adSave.config(
      'https://api.avisoscenter.com/v1/postAd',
  //    'http://localhost:8000/api/postAd',
      '',
      '',
      'body',
      mmo_json.Text,
      '',
      ''
    );

    adSave.save;
    showMessage('Guardado');

    // save image generated
    generateImage;

    //clearControls;
  end
  else
  if adFormACtion = 'edit' then
  begin
    generateJsonAd;

    adPut:= TAPIRest.Create;
    adPut.config(
      'https://api.avisoscenter.com/v1/ads/'+frm_ad_list._ad_id,
  //    'http://localhost:8000/api/postAd',
      '',
      '',
      'body',
      mmo_json.Text,
      '',
      ''
    );
    adPut.put;
    showMessage('Aviso Editado');
  end;

  frm_ad_details.Close;
end;

procedure Tfrm_ad_details.btn_servicesClick(Sender: TObject);
begin
  pnl_services.Left := (frm_ad_details.ClientWidth - pnl_services.Width) div 2;
  pnl_services.Top := (frm_ad_details.ClientHeight - pnl_services.Height) div 2;
  pnl_services.Visible:= true;
end;



procedure Tfrm_ad_details.clearControls;
begin
  dtp_date.Date := now;
  dtp_time.Time := now;

  cmb_status.ItemIndex := 1;
  cmb_category.ItemIndex := -1;
  cmb_type.ItemIndex := -1;
  cmb_condition.ItemIndex := -1;

  mmo_body.Lines.Clear;
  mmo_imageUrl.Lines.Clear;

  edt_price.text := '';
  edt_address.text := '';
  edt_latitudeLongitude.text := '';
  edt_phone.text := '';

  ckb_bath.Checked := false;
  ckb_pets.Checked := false;
  ckb_wifi.Checked := false;
  ckb_cable.Checked := false;
  ckb_parkingMoto.Checked := false;
  ckb_parkingCar.Checked := false;
  ckb_thermal.Checked := false;
  ckb_laundry.Checked := false;
  ckb_silent.Checked := false;



//  sg_images.ClearContent;
  lb_images.clear;
  _i := 0;

  lb_phones.Clear;
  _countPhones := 0;

  cmb_type.Enabled := false;
  gpb_services.Enabled := false;
  ckb_isIA.Enabled := false;
  ckb_isIA.Checked := false;

  // vehicles
  cmb_brand.ItemIndex := -1;
  cmb_model.ItemIndex := -1;
  edt_year.text := '';
  edt_engine.Text := '';
  edt_mileage.Text := '';
  edt_fuel.Text := '';
  edt_transmission.Text := '';
  edt_color.Text := '';
end;

function Tfrm_ad_details.getBackgroundColor(const option: string): TColor;
begin
  if UpperCase(Option) = 'NECESITO' then
    Result := RGB(76, 176, 80) // #4CB050
  else if UpperCase(Option) = 'ALQUILO' then
    Result := RGB(244, 67, 54) // #F44336
  else if UpperCase(Option) = 'VENDO' then
    Result := RGB(250, 163, 7)
  else
    Result := RGB(116, 133, 140);
end;

procedure Tfrm_ad_details.getBrandId;
var
  selectedName: string;
  selectedID: Integer;
begin
  // Obtén el nombre seleccionado en el combo
  selectedName := cmb_brand.Text;

  // Busca el índice del nombre seleccionado en el combo
  // y luego obtén el objeto asociado (que es el ID) en ese índice
  selectedID := Integer(cmb_brand.Items.Objects[cmb_brand.ItemIndex]);

  _brandId:= selectedID.ToString;
  lbl_brand.Caption:= selectedName+'-'+selectedID.ToString;
end;

procedure Tfrm_ad_details.getBrands;
var
  brands: TAPIRest;
  i: integer;
  brands_cmb: array of TBrand;
begin
  brands := TAPIRest.Create;
  brands.config(
    'https://api.avisoscenter.com/v1/getAllBrands',
    '',
    '',
    '',
    '',
    '',
    'items'
  );

  brands.getBrands;
  SetLength(brands_cmb, brands.count);

  for i := 0 to brands.count - 1 do
  begin
    brands_cmb[i].id := brands.id(i).ToInteger;
    brands_cmb[i].name := brands.name(i);
  end;

  cmb_brand.Clear;
  for i := 0 to length(brands_cmb)-1 do
  begin
    cmb_brand.Items.AddObject(brands_cmb[i].name, TObject(brands_cmb[i].id));
  end;
end;

procedure Tfrm_ad_details.getCities;
var
  i: integer;
  cities_cmb: array of TBrand;
begin
  SetLength(cities_cmb, 3);

  cities_cmb[0].id := 1;
  cities_cmb[0].name := 'Juliaca';

  cities_cmb[1].id := 2;
  cities_cmb[1].name := 'Puno';

  cities_cmb[2].id := 3;
  cities_cmb[2].name := 'Pto. Maldonado';


  cmb_city.Clear;
  for i := 0 to length(cities_cmb)-1 do
  begin
    cmb_city.Items.AddObject(cities_cmb[i].name, TObject(cities_cmb[i].id));
  end;
end;

procedure Tfrm_ad_details.getCityId;
var
  selectedName: string;
  selectedID: Integer;
begin
  // Obtén el nombre seleccionado en el combo
  selectedName := cmb_city.Text;

  // Busca el índice del nombre seleccionado en el combo
  // y luego obtén el objeto asociado (que es el ID) en ese índice
  selectedID := Integer(cmb_city.Items.Objects[cmb_city.ItemIndex]);

  _cityId:= selectedID.ToString;
  lbl_city.Caption:= selectedName+'-'+selectedID.ToString;
end;

procedure Tfrm_ad_details.cmb_brandSelect(Sender: TObject);
begin
  // trae el ID del elemento seleccionado en el cmb_brand
  getBrandId;

  // trae los modelos de ID de la marca seleccionada
  getModelByBrandId;
end;

procedure Tfrm_ad_details.cmb_categoryChange(Sender: TObject);
begin
  if cmb_category.ItemIndex = 1 then
  begin
    // rent
    cmb_type.Enabled := true;
    gpb_services.Enabled := true;
  end else
  if cmb_category.ItemIndex = 2 then
  begin
    // sell
    cmb_type.Enabled := true;
    gpb_services.Enabled := false;

//    cmb_type.Clear;
//    cmb_type.Items.Add('VEHÍCULO');
//    cmb_type.Items.Add('TERRENO');
  end else
  begin
    cmb_type.Enabled := false;
    gpb_services.Enabled := false;

    cmb_type.ItemIndex := -1;
    ckb_bath.Checked := false;
    ckb_pets.Checked := false;
    ckb_wifi.Checked := false;
    ckb_cable.Checked := false;
    ckb_parkingMoto.Checked := false;
    ckb_parkingCar.Checked := false;
    ckb_thermal.Checked := false;
    ckb_laundry.Checked := false;
    ckb_silent.Checked := false;
  end;
end;

procedure Tfrm_ad_details.cmb_categoryCloseUp(Sender: TObject);
begin
//  if cmb_category.ItemIndex = 1 then
//  begin
//    // rent
//    cmb_type.Enabled := true;
//    gpb_services.Enabled := true;
//  end else
//  if cmb_category.ItemIndex = 2 then
//  begin
//    // sell
//    cmb_type.Enabled := true;
//    gpb_services.Enabled := false;
//
////    cmb_type.Clear;
////    cmb_type.Items.Add('VEHÍCULO');
////    cmb_type.Items.Add('TERRENO');
//  end else
//  begin
//    cmb_type.Enabled := false;
//    gpb_services.Enabled := false;
//
//    cmb_type.ItemIndex := -1;
//    ckb_bath.Checked := false;
//    ckb_pets.Checked := false;
//    ckb_wifi.Checked := false;
//    ckb_cable.Checked := false;
//    ckb_parkingMoto.Checked := false;
//    ckb_parkingCar.Checked := false;
//    ckb_thermal.Checked := false;
//    ckb_laundry.Checked := false;
//    ckb_silent.Checked := false;
//  end;
end;

procedure Tfrm_ad_details.cmb_citySelect(Sender: TObject);
begin
  getCityId;
end;

procedure Tfrm_ad_details.cmb_conditionChange(Sender: TObject);
begin
  if cmb_condition.ItemIndex = 1 then
  begin
    ckb_isIA.Enabled := true;
    ckb_isIA.Checked := true;
  end else
  begin
    ckb_isIA.Enabled := false;
    ckb_isIA.Checked := false;
  end;
end;

procedure Tfrm_ad_details.cmb_conditionCloseUp(Sender: TObject);
begin
//  if cmb_condition.ItemIndex = 1 then
//  begin
//    ckb_isIA.Enabled := true;
//    ckb_isIA.Checked := true;
//  end else
//  begin
//    ckb_isIA.Enabled := false;
//    ckb_isIA.Checked := false;
//  end;
end;

procedure Tfrm_ad_details.cmb_modelSelect(Sender: TObject);
begin
  // recupera el ID del modelo seleccionado
  getModelId;
end;

constructor Tfrm_ad_details.Create(AOwner: TComponent; const AValue: string);
begin
  inherited Create(AOwner);
  adFormAction := AValue;
end;

procedure Tfrm_ad_details.edt_phoneKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    btn_phone.Click;
  end;

  if not (Key in ['0'..'9', #8, #127]) then
    Key := #0; // Anular la tecla ingresada
end;

procedure Tfrm_ad_details.FormActivate(Sender: TObject);
begin

  edt_phone.SetFocus;
  getCities;
  getLastIdAd;

  // form position
  WindowState := wsNormal;
  Left := 0;
  Top := 0;

  // en ciudad elegiar juliaca por defecto
  cmb_city.ItemIndex:= 0;
  getCityId;

  if adFormAction = 'edit' then
  begin
    // ocultar dtp_date and dtp_time, mostrar texto en el label
    dtp_date.Visible:= false;
    dtp_time.Visible:= false;
    lbl_date.Caption:= 'Publicado   ' + relativeTime(frm_ad_list._date);

    { getPhones, getImages }
    getPhonesFromId;
    getImagesFromId;

    { status }
    if frm_ad_list._status = '1' then
    begin
      cmb_status.ItemIndex:= 1;
    end
    else
    if frm_ad_list._status = '0' then
    begin
      cmb_status.ItemIndex:= 0;
    end
    else
    if frm_ad_list._status = 'null' then
    begin
      cmb_status.ItemIndex:= 0;
      showMessage('Status: null > Inactivo');
    end;

    { category }
    cmb_category.ItemIndex := StrToInt(frm_ad_list._category_id) - 1;

    { type }
    if frm_ad_list._type_id = 'null' then
    begin
      cmb_type.ItemIndex:= -1;
    end
    else
    begin
      cmb_type.ItemIndex := StrToInt(frm_ad_list._type_id) - 1;
    end;

    { body }
    mmo_body.Text     := frm_ad_list._body;

    { address }
    if frm_ad_list._address = 'null' then
    begin
      edt_address.Text  := '';
    end
    else
    begin
      edt_address.Text  := frm_ad_list._address;
    end;

    { latitude }
    if frm_ad_list._latitude = 'null' then
    begin
      edt_latitudeLongitude.Text  := '';
    end
    else
    begin
      edt_latitudeLongitude.Text  := frm_ad_list._latitude +', '+frm_ad_list._longitude;
    end;

    { type }
    if frm_ad_list._condition = 'paid' then
    begin
      cmb_condition.ItemIndex:= 0;
    end
    else
    if frm_ad_list._condition = 'free' then
    begin
      cmb_condition.ItemIndex := 1;
    end;

    { isIA }
    if frm_ad_list._isIA = '1' then
    begin
      ckb_isIA.Checked:= true;
    end
    else
    if frm_ad_list._isIA = '0' then
    begin
      ckb_isIA.Checked:= false;
    end;

    { price }
    if frm_ad_list._price = 'null' then
    begin
      edt_price.Text  := '';
    end
    else
    begin
      edt_price.Text  := frm_ad_list._price;
    end;

    { bath }
    if frm_ad_list._bath = '1' then
    begin
      ckb_bath.Checked:= true;
    end
    else
    if frm_ad_list._bath = '0' then
    begin
      ckb_bath.Checked:= false;
    end;

    { wifi }
    if frm_ad_list._wifi = '1' then
    begin
      ckb_wifi.Checked:= true;
    end
    else
    if frm_ad_list._wifi = '0' then
    begin
      ckb_wifi.Checked:= false;
    end;

    { cable }
    if frm_ad_list._cable = '1' then
    begin
      ckb_cable.Checked:= true;
    end
    else
    if frm_ad_list._cable = '0' then
    begin
      ckb_cable.Checked:= false;
    end;

    { parking_moto }
    if frm_ad_list._parking_moto = '1' then
    begin
      ckb_parkingMoto.Checked:= true;
    end
    else
    if frm_ad_list._parking_moto = '0' then
    begin
      ckb_parkingMoto.Checked:= false;
    end;

    { parking_car }
    if frm_ad_list._parking_car = '1' then
    begin
      ckb_parkingCar.Checked:= true;
    end
    else
    if frm_ad_list._parking_car = '0' then
    begin
      ckb_parkingCar.Checked:= false;
    end;

    { thermal }
    if frm_ad_list._thermal = '1' then
    begin
      ckb_thermal.Checked:= true;
    end
    else
    if frm_ad_list._thermal = '0' then
    begin
      ckb_thermal.Checked:= false;
    end;

    { laundry }
    if frm_ad_list._laundry = '1' then
    begin
      ckb_laundry.Checked:= true;
    end
    else
    if frm_ad_list._laundry = '0' then
    begin
      ckb_laundry.Checked:= false;
    end;

    { silent }
    if frm_ad_list._silent = '1' then
    begin
      ckb_silent.Checked:= true;
    end
    else
    if frm_ad_list._silent = '0' then
    begin
      ckb_silent.Checked:= false;
    end;

    { pets }
    if frm_ad_list._pets = '1' then
    begin
      ckb_pets.Checked:= true;
    end
    else
    if frm_ad_list._pets = '0' then
    begin
      ckb_pets.Checked:= false;
    end;
  end;


end;

procedure Tfrm_ad_details.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frm_ad_details.Release;
  frm_ad_details:= nil;
end;

procedure Tfrm_ad_details.FormCreate(Sender: TObject);
begin
  clearControls;
  dtp_date.Date := now;
  dtp_time.Time := now;
  dtp_date_expired.Date := now;
  dtp_time_expired.Time := now;
end;

procedure Tfrm_ad_details.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Verifica si la tecla presionada es "Enter" y si la tecla "Ctrl" está siendo presionada
  if (Key = VK_RETURN) and (ssCtrl in Shift) then
  begin
    // Aquí puedes llamar al evento del botón que deseas ejecutar
    btn_save.Click;
  end;
end;

procedure Tfrm_ad_details.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if key=#27 then
  begin
    edt_phone.SetFocus;
  end;

end;

procedure Tfrm_ad_details.generateImage;
var
  Bitmap: TBitmap;
  logo: TPngImage;
  logoFileName, txt: string;
  CenterX, MaxCaracteres, i, lb_elements: Integer;
  backgroundColor: TColor;
  title, body, phone, date: TRect;


  FileName: String;
begin
  // Crear una imagen en tiempo de ejecución
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width := 1080;  // Ancho de la imagen
    Bitmap.Height := 1080; // Alto de la imagen

    // Obtener el color de fondo para la categoria seleccionada
    backgroundColor := getBackgroundColor(cmb_category.Text);

    // Dibujando el fondo de color
    Bitmap.Canvas.Brush.Color := backgroundColor;
    Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));

    // Mostrar el logo en la imagen
    logo := TPngImage.Create;
    try
      // Obtener el nombre del archivo del logo según la opción
      logoFileName := getLogoFileName(cmb_category.Text);
      Logo.LoadFromFile(GetLogoFilePathFromIni + logoFileName);

      // Calcular la posición central horizontalmente
      CenterX := (Bitmap.Width - logo.Width) div 2;

      // Dibujar la segunda imagen en la posición deseada
      Bitmap.Canvas.Draw(CenterX, 150, logo);
    finally
      Logo.Free;
    end;

    { title }
    // Configurar el rectángulo para el título
    title := Rect(0, 300, Bitmap.Width, Bitmap.Height);

    // Escribir título en la imagen
    Bitmap.Canvas.Font.Size := 48;
    Bitmap.Canvas.Font.Name := 'Fredoka';
    Bitmap.Canvas.Font.Style := [fsBold];
    Bitmap.Canvas.Font.Color := clWhite;
    // Coordenadas X,Y ubicar texto (forma simple)
    //Bitmap.Canvas.TextOut(250, 200, 'NECESITO');

    // Dibujar el texto centrado vertical y horizontalmente con saltos de línea automáticamente
    DrawText(Bitmap.Canvas.Handle, PChar(uppercase(cmb_category.Text)), Length(cmb_category.Text), title, DT_WORDBREAK or DT_CENTER or DT_VCENTER);

    { body }
    txt:= mmo_body.Text;
    body := Rect(40, 450, Bitmap.Width - 40, Bitmap.Height);

    MaxCaracteres := 245;
    if Length(txt) > MaxCaracteres then
    begin
      //txt := Copy(txt, 1, MaxCaracteres) + '...';

      // Reducir el tamaño de la fuente si el texto supera los 240 caracteres
      //Bitmap.Canvas.Font.Size := 20;
      Bitmap.Canvas.Font.Size := 26;
    end
    else
      //Bitmap.Canvas.Font.Size := 28;
      Bitmap.Canvas.Font.Size := 34;

    Bitmap.Canvas.Font.Name := 'Product Sans';
    Bitmap.Canvas.Font.Style := [fsBold];
    Bitmap.Canvas.Font.Color := clWhite;

    // Concatenar la dirección al final solo si tiene algún valor
    if Trim(edt_address.Text) <> '' then
      txt := txt + ' ' + Trim(edt_address.Text);

    // font uppercase
    //DrawText(Bitmap.Canvas.Handle, PChar(uppercase(txt)), Length(txt), body, DT_WORDBREAK or DT_CENTER or DT_VCENTER); v1
    DrawText(Bitmap.Canvas.Handle, PChar(txt), Length(txt), body, DT_WORDBREAK or DT_CENTER or DT_VCENTER);

    { phones }

    // Establecer el límite de elementos
    lb_elements := 2;

    // Verificar si hay más de 3 elementos en el ListBox
    if lb_phones.Items.Count > lb_elements then
    begin
      // Reducir el tamaño de la fuente si hay más de 3 elementos
      Bitmap.Canvas.Font.Size := 28;
    end
    else
    begin
      // Tamaño de fuente predeterminado si hay 3 o menos elementos
      Bitmap.Canvas.Font.Size := 35;
    end;

    txt:= '📞️';
    if lb_phones.Items.Count > 0 then
    begin
      // Iterar a través de los elementos del ListBox
      for i := 0 to lb_phones.Items.Count - 1 do
      begin

        // Concatenar el elemento actual a la cadena con un separador "/"
        txt := txt + lb_phones.Items[i];

        // Agregar un separador "/" si no es el último elemento
        if i < lb_phones.Items.Count - 1 then
          txt := txt + ' / ';
      end;
    end;

    // Configurar el rectángulo para el texto
    phone := Rect(0, 950, Bitmap.Width, Bitmap.Height);

    //Bitmap.Canvas.Font.Size := 30;
    Bitmap.Canvas.Font.Name := 'Fredoka';
    //Bitmap.Canvas.Font.Name := 'League Spartan';
    Bitmap.Canvas.Font.Style := [fsBold];
    Bitmap.Canvas.Font.Color := clWhite;

    // Dibujar el texto centrado vertical y horizontalmente con saltos de línea automáticamente
    DrawText(Bitmap.Canvas.Handle, PChar(txt), Length(txt), phone, DT_WORDBREAK or DT_CENTER or DT_VCENTER);

    { show id }
    // Escribir texto en la imagen
    Bitmap.Canvas.Font.Name := 'JetBrains Mono';
    Bitmap.Canvas.Font.Size := 12;
    Bitmap.Canvas.Font.Color := clWhite;
    //Bitmap.Canvas.TextOut(1025, 1040, inttostr(_getLastIdAd + 1));
    Bitmap.Canvas.TextOut(740, 1040, 'www.avisoscenter.com/aviso/' + inttostr(_getLastIdAd + 1));

    { show publish - expire }

    // Configurar el rectángulo para el título
    date := Rect(0, 1040, Bitmap.Width, Bitmap.Height);

    // concatenate publish - expire
    txt:= '   Publicado: ' + DateTimeToStr(dtp_date.Date) + ' hasta ' + DateTimeToStr(dtp_date_expired.Date);

    // Escribir título en la imagen
    Bitmap.Canvas.Font.Size := 12;
    Bitmap.Canvas.Font.Name := 'JetBrains Mono';
    Bitmap.Canvas.Font.Color := clWhite;


    // Dibujar el texto centrado vertical y horizontalmente con saltos de línea automáticamente
    //DrawText(Bitmap.Canvas.Handle, PChar(txt), Length(txt), date, DT_WORDBREAK or DT_CENTER or DT_VCENTER);
    DrawText(Bitmap.Canvas.Handle, PChar(txt), Length(txt), date, DT_WORDBREAK or DT_LEFT or DT_VCENTER);

    { save }
    // Obtener el nombre del archivo con la extensión forzada a ".jpg"
    FileName := inttostr(_getLastIdAd + 1);
    if not FileName.ToLower.EndsWith('.jpg') then
      FileName := FileName + '.jpg';

    // Ubicación y el nombre del archivo
    // FileName := 'D:\prj\active\avisoscenter\z_img\img_to_fb\' + FileName; old
    FileName := GetSaveFilePathFromIni + FileName;

    // Guardar la imagen en el archivo
    Bitmap.SaveToFile(FileName);
  finally
    Bitmap.Free;
  end;
end;

procedure Tfrm_ad_details.generateJsonAd;
var
  stringWriter: TStringWriter;
  writer: TJsonTextWriter;
  row: integer;
  latitude, longitude: string;
begin
  stringWriter:= TStringWriter.Create;
  writer:= TJsonTextWriter.Create(stringWriter);

  try
    writer.Formatting:= tjsonFormatting.indented;
    writer.WriteStartObject;

      writer.WritePropertyName('city_id');
      writer.WriteValue(trim(_cityId));

      writer.WritePropertyName('brand_id');
      writer.WriteValue(trim(_brandId));

      writer.WritePropertyName('model_id');
      writer.WriteValue(trim(_modelId));

      writer.WritePropertyName('body');
      writer.WriteValue(trim(mmo_body.Text));

      writer.WritePropertyName('address');
      writer.WriteValue(trim(edt_address.text));

      writer.WritePropertyName('price');
      writer.WriteValue(trim(edt_price.text));

      // split latitude & longitude
      if edt_latitudeLongitude.text <> '' then
      begin
        if validateLatitudeLongitude(edt_latitudeLongitude.Text) then
        begin
          splitLatitudeLongitude(edt_latitudeLongitude.Text, latitude, longitude);
        end else
        begin
          showMessage('Latitud/Longitud no esta ingresado correctamente, Ejm. -15.123456, -70.123456');
          abort;
        end;
      end;

      writer.WritePropertyName('latitude');
      writer.WriteValue(trim(latitude));

      writer.WritePropertyName('longitude');
      writer.WriteValue(trim(longitude));

      { condition }
      writer.WritePropertyName('condition');
      if cmb_condition.ItemIndex <> -1 then
      begin
        if cmb_condition.ItemIndex = 0 then
        begin
          writer.WriteValue('paid');
        end else
        if cmb_condition.ItemIndex = 1 then
        begin
          writer.WriteValue('free');
        end;
      end
      else begin
        writer.WriteValue('');
      end;

      { type }
      writer.WritePropertyName('type_id');
      if cmb_type.ItemIndex <> -1 then
      begin
        writer.WriteValue(cmb_type.ItemIndex + 1);
      end
      else begin
        writer.WriteValue('');
      end;

      { isIA }
      writer.WritePropertyName('isIA');
      if (ckb_isIA.Checked = true) then
      begin
        writer.WriteValue(1);
      end else
      begin
        writer.WriteValue(0);
      end;

      { bath }
      writer.WritePropertyName('bath');
      if (ckb_bath.Checked = true) then
      begin
        writer.WriteValue(1);
      end else
      begin
        writer.WriteValue(0);
      end;

      { pets }
      writer.WritePropertyName('pets');
      if (ckb_pets.Checked = true) then
      begin
        writer.WriteValue(1);
      end else
      begin
        writer.WriteValue(0);
      end;

      { wifi }
      writer.WritePropertyName('wifi');
      if (ckb_wifi.Checked = true) then
      begin
        writer.WriteValue(1);
      end else
      begin
        writer.WriteValue(0);
      end;

      { cable }
      writer.WritePropertyName('cable');
      if (ckb_cable.Checked = true) then
      begin
        writer.WriteValue(1);
      end else
      begin
        writer.WriteValue(0);
      end;

      { parking_moto}
      writer.WritePropertyName('parking_moto');
      if (ckb_parkingMoto.Checked = true) then
      begin
        writer.WriteValue(1);
      end else
      begin
        writer.WriteValue(0);
      end;

      { parking_car }
      writer.WritePropertyName('parking_car');
      if (ckb_parkingCar.Checked = true) then
      begin
        writer.WriteValue(1);
      end else
      begin
        writer.WriteValue(0);
      end;

      { thermal }
      writer.WritePropertyName('thermal');
      if (ckb_thermal.Checked = true) then
      begin
        writer.WriteValue(1);
      end else
      begin
        writer.WriteValue(0);
      end;

      { laundry }
      writer.WritePropertyName('laundry');
      if (ckb_laundry.Checked = true) then
      begin
        writer.WriteValue(1);
      end else
      begin
        writer.WriteValue(0);
      end;

      { silent }
      writer.WritePropertyName('silent');
      if (ckb_silent.Checked = true) then
      begin
        writer.WriteValue(1);
      end else
      begin
        writer.WriteValue(0);
      end;

      { status }
      writer.WritePropertyName('status');
      if cmb_status.ItemIndex = 0 then
      begin
        // 0 = active
        writer.WriteValue(0);
      end
      else if cmb_status.ItemIndex = 1 then
        // 1 = inactive
        writer.WriteValue(1);
      begin
      end;

      writer.WritePropertyName('notes');
      writer.WriteValue(trim(mmo_notes.Text));

      writer.WritePropertyName('currency');
      writer.WriteValue(trim(cmb_currency.Text));

      writer.WritePropertyName('year');
      writer.WriteValue(trim(edt_year.Text));

      writer.WritePropertyName('mileage');
      writer.WriteValue(trim(edt_mileage.Text));

      writer.WritePropertyName('engine');
      writer.WriteValue(trim(edt_engine.Text));

      writer.WritePropertyName('fuel');
      writer.WriteValue(trim(edt_fuel.Text));

      writer.WritePropertyName('transmission');
      writer.WriteValue(trim(edt_transmission.Text));

      writer.WritePropertyName('color');
      writer.WriteValue(trim(edt_color.Text));

      writer.WritePropertyName('category_id');
      writer.WriteValue(cmb_category.ItemIndex + 1);

      { phones }
      writer.WritePropertyName('phones');
      writer.WriteStartArray;
//        for row := 0 to sg_phones.RowCount-1 do
        for row := 0 to lb_phones.Count-1 do
        begin
          writer.WriteStartObject;

          writer.WritePropertyName('phone');
//          writer.WriteValue(sg_phones.Cells[0, row]);
          writer.WriteValue(lb_phones.Items[row]);

          writer.WriteEndObject;
        end;
      writer.WriteEndArray;

      writer.WritePropertyName('datetime');
      writer.WriteValue(unFlipDate(dtp_date.date, dtp_time.Time));

      if dtp_date.Date = dtp_date_expired.Date then
      begin
        // fechas iguales
        writer.WritePropertyName('expired_at');
        writer.WriteValue(''); // null
      end
      else
      begin
        // fechas diferentes
        writer.WritePropertyName('expired_at');
        writer.WriteValue(unFlipDate(dtp_date_expired.date, dtp_time_expired.Time));
      end;

      { images }
      writer.WritePropertyName('images');
      writer.WriteStartArray;
        for row := 0 to lb_images.Count-1 do
        begin
          writer.WriteStartObject;

          writer.WritePropertyName('url');
          writer.WriteValue(lb_images.Items[row]);

          writer.WriteEndObject;
        end;
      writer.WriteEndArray;


    writer.WriteEndObject;
  finally
    //empty
  end;

  mmo_json.Lines.Clear;
  mmo_json.Lines.Add(stringWriter.ToString);
end;

procedure Tfrm_ad_details.getAdsfromPhone;
var
  ads: TAPIRest;
  i: integer;
begin
  ads := TAPIRest.Create;
  ads.config(
    'https://api.avisoscenter.com/v1/getAdsFromPhone',
    '',
    '',
    'number',
    edt_phone.Text,
    '?number={number}',
    'items'
  );

  ads.getAdsFromPhone;
  lbl_ads_count.Caption:= ads.count.ToString;

  for i := 0 to ads.count-1 do
  begin
    lb_ads.items.Add(ads.phones(i) + ' | ' + Format('%06d', [ads.id(i).ToInteger]) + ' | ' + ads.categoryName(i) + ': ' + ads.ad(i) + ' | ' + ads.status(i) + ' | ' + relativeTime(ads.date(i)) );
  end;
end;

procedure Tfrm_ad_details.getImagesFromId;
var
  i: integer;
begin
  for i := 0 to Length(frm_ad_list._images)-1 do
  begin
    lb_images.Items.Add(frm_ad_list._images[i]);
  end;
end;

procedure Tfrm_ad_details.getLastIdAd;
var
  ads: TAPIRest;
begin
  ads := TAPIRest.Create;
  ads.config(
    'https://api.avisoscenter.com/v1/getLastIdAd',
    '',
    '',
    '',
    '',
    '',
    ''
  );

  ads.getLastIdAd;
  _getLastIdAd:= strtoint(ads.id(0));
end;

function Tfrm_ad_details.getLogoFileName(const option: string): string;
begin
  if UpperCase(Option) = 'NECESITO' then
    Result := 'logo_green.png'
  else if UpperCase(Option) = 'ALQUILO' then
    Result := 'logo_red.png'
  else if UpperCase(Option) = 'VENDO' then
    Result := 'logo_yellow.png'
  else
    Result := 'logo_gray.png';
end;

procedure Tfrm_ad_details.getModelByBrandId;
var
  models: TAPIRest;
  i: integer;
  models_cmb: array of TBrand;
begin
  models := TAPIRest.Create;
  models.config(
    'https://api.avisoscenter.com/v1/getModelsByBrandId',
    '',
    '',
    'brand_id',
    _brandId,
    '?brand_id={brand_id}',
    'items'
  );

  models.getModelsFromBrandId;
  SetLength(models_cmb, models.count);

  for i := 0 to models.count - 1 do
  begin
    models_cmb[i].id := models.id(i).ToInteger;
    models_cmb[i].name := models.name(i);
  end;

  cmb_model.Clear;
  for i := 0 to length(models_cmb)-1 do
  begin
    cmb_model.Items.AddObject(models_cmb[i].name, TObject(models_cmb[i].id));
  end;
end;

procedure Tfrm_ad_details.getModelId;
var
  selectedName: string;
  selectedID: Integer;
begin
  // Obtén el nombre seleccionado en el combo
  selectedName := cmb_model.Text;

  // Busca el índice del nombre seleccionado en el combo
  // y luego obtén el objeto asociado (que es el ID) en ese índice
  selectedID := Integer(cmb_model.Items.Objects[cmb_model.ItemIndex]);

  _modelId:= selectedID.ToString;
  lbl_model.Caption:= selectedName+'-'+selectedID.ToString;
end;

procedure Tfrm_ad_details.getPhonesFromId;
var
  i: integer;
begin
  for i := 0 to Length(frm_ad_list._phones)-1 do
  begin
    lb_phones.Items.Add(frm_ad_list._phones[i]);
  end;
end;

procedure Tfrm_ad_details.lbl_ads_closeClick(Sender: TObject);
begin
  lb_ads.Clear;
  pnl_ads.Visible:= false;
end;

procedure Tfrm_ad_details.lbl_images_closeClick(Sender: TObject);
begin
  pnl_images.Visible:= false;
end;

procedure Tfrm_ad_details.lbl_services_closeClick(Sender: TObject);
begin
  pnl_services.Visible:= false;
end;

procedure Tfrm_ad_details.lbl_statusClick(Sender: TObject);
begin
  generateJsonAd;
end;



procedure Tfrm_ad_details.lbl_vehicles_closeClick(Sender: TObject);
begin
  pnl_vehicles.Visible := false;
end;

procedure Tfrm_ad_details.lb_adsDblClick(Sender: TObject);
begin
  showMessage(lb_ads.Items[lb_ads.ItemIndex]);
end;

procedure Tfrm_ad_details.splitLatitudeLongitude(const InputText: string; var OutputString1, OutputString2: string);
var
  Parts: TArray<string>;
begin

  Parts := InputText.Split([',']);

  if Length(Parts) = 2 then
  begin
    OutputString1 := Trim(Parts[0]);
    OutputString2 := Trim(Parts[1]);
  end
  else
  begin
    showMessage('error en el formato');
  end;
end;

function Tfrm_ad_details.unFlipDate(date: TDate; time: TTime): string;
var
  dte, tme, year, month, day, hour: string;
begin
  dte := datetostr(date);
  tme := timetostr(time);

  { date }
  if length(dte) = 10 then
  begin
    { 13/11/2022 }
    { 1234567890 }
    year:=  Copy(dte, 7, 4);
    month:= Copy(dte, 4, 2);
    day:=   Copy(dte, 1, 2);

    result := year +'/'+month+'/'+day + ' ' + tme;

  end else if length(dte) = 9 then
  begin
    { 3/11/2022 }
    { 123456789 }
    year:=  Copy(dte, 6, 4);
    month:= Copy(dte, 3, 2);
    day:=   Copy(dte, 1, 1);

    result := year +'/'+month+'/'+day + ' ' + tme;
  end;
end;

function Tfrm_ad_details.validateLatitudeLongitude(value: string): boolean;
var
  regex: TRegEx;
begin
  // Expresión regular para validar el formato
  //regex := TRegEx.Create('-\d{2}\.\d{6,}');
  //regex := TRegEx.Create('^-\d{2}\.\d{6}, -\d{2}\.\d{6}$');
  regex := TRegEx.Create('^-{1}\d{2}\.\d{6,}, -{1}\d{2}\.\d{6,}$');

  // Verificar si el texto coincide con la expresión regular
  Result := regex.IsMatch(value) and (Length(value) <= 40);
end;

procedure Tfrm_ad_details.btn_vehiclesClick(Sender: TObject);
begin
  getBrands;
  pnl_vehicles.Left := (frm_ad_details.ClientWidth - pnl_vehicles.Width) div 2;
  pnl_vehicles.Top := (frm_ad_details.ClientHeight - pnl_vehicles.Height) div 2;
  pnl_vehicles.Visible:= true;
end;

end.
