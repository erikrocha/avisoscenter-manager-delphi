unit uAPIRest;

interface

uses
  JSON, Classes, SysUtils, REST.Client, REST.Types, System.IniFiles, Dialogs;

type
  TAPIRest = Class(TObject)
    Protected
      FBaseUrl    : string;
      FTokenName  : string;
      FTokenValue : string;
      FParamName  : string;
      FParamValue : string;
      FResource   : string;
      FRootElement: string;

      FName       : TStringList;
      FID         : TStringList;
      FSKU        : TStringList;
      FBarcode    : TStringList;
      FPrice      : TStringList;
      FStock      : TStringList;
      FLocation   : TStringList;
      FLocationS  : string;
      FStatus     : TStringList;

      FStorehouseID   : TStringList;
      FStorehouseCode : TStringList;

      FResults    : string;

      { avisos center }
      FLatitude   : TStringList;
      FLongitude  : TStringList;
      FCategoryId : TStringList;
      FCategoryName: TStringList;
      FTypeId     : TStringList;
      FTypeName   : TStringList;
      FAd         : TStringList;
      FDate       : TStringList;
      FUpdated    : TStringList;
      FExpired    : TStringList;
      FAddress    : TStringList;
      FCondition  : TStringList;
      FIsIA       : TStringList;
      FBath       : TStringList;
      FWifi       : TStringList;
      FCable      : TStringList;
      FParkingMoto: TStringList;
      FParkingCar : TStringList;
      FThermal    : TStringList;
      FLaundry    : TStringList;
      FSilent     : TStringList;
      FPets       : TStringList;
      FCity       : TStringList;
      FCurrency   : TStringList;
      FYear       : TStringList;
      FMileage    : TStringList;
      FEngine     : TStringList;
      FFuel       : TStringList;
      FTransmission:TStringList;
      FColor      : TStringList;
      FNotes      : TStringList;

      FPhones     : TStringList;
      FImages     : TStringList;
      FBrand      : TStringList;
      FModel      : TStringList;

    Public
      Constructor Create;
      Destructor Destroy; Override;
      Procedure add(value: String);
      Procedure config(
        baseUrl   :string;
        tokenName :string;
        tokenValue:string;
        paramName :string;
        paramValue:string;
        resource  :string;
        rootElement:string
      );
      procedure loadData(field: String);

      procedure getAds;
      procedure getAd;
      procedure getPhonesFromId;
      procedure getImagesFromId;
      procedure getAdsFromPhone;
      procedure getBrands;
      procedure getModelsFromBrandId;
      procedure getLastIdAd;

      Function baseUrl: String;
      Function tokenName: String;
      function paramValue: string;
      function resource: string;

      Function name(id: Integer): String;
      function id(id: Integer): string;
      function sku(id: Integer): String;
      function barcode(id: Integer): String;
      function price(id: Integer): String;
      function stock(id: integer): string;
      function location(id: integer): string;
      Function count: Integer;
      function countStorehouse: integer;
      Function response: String;
      function storehouseCode(id: integer): string;

      function save: string;
      function put: string;

      { Avisos Center }
      function latitude(id: integer): string;
      function longitude(id: integer): string;
      function categoryId(id: integer): string;
      function categoryName(id: integer): string;
      function typeId(id: integer): string;
      function typeName(id: integer): string;
      function ad(id: integer): string;
      function date(id: integer): string;
      function updated(id: integer): string;
      function address(id: integer): string;
      function condition(id: integer): string;
      function status(id: integer): string;
      function isIA(id: integer): string;
      function bath(id: integer): string;
      function wifi(id: integer): string;
      function cable(id: integer): string;
      function parkingMoto(id: integer): string;
      function parkingCar(id: integer): string;
      function thermal(id: integer): string;
      function laundry(id: integer): string;
      function silent(id: integer): string;
      function pets(id: integer): string;
      function phones(id: integer): string;
      function images(id: integer): string;
      function brands(id: integer): string;
      function models(id: integer): string;
      function city(id: integer) : string;
      function currency(id: integer): string;
      function year(id: integer): string;
      function mileage(id: integer): string;
      function engine(id: integer): string;
      function fuel(id: integer): string;
      function transmission(id: integer): string;
      function color(id: integer): string;
      function expired(id: integer): string;
      function notes(id: integer): string;


      function existMap: integer;
      function countImages: integer;
      function GetBearerTokenFromIni: string;




  End;

implementation

{ TAPIRest }

function TAPIRest.GetBearerTokenFromIni: string;
var
  IniFile: TIniFile;
  Token: string;
begin
  // env.ini
  // [Auth]
  // BearerToken={token}
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'env.ini');
  try
    // Leer el token desde la sección [Auth] y clave BearerToken
    Token := IniFile.ReadString('Auth', 'BearerToken', '');

    if Token = '' then
      raise Exception.Create('El token Bearer no se encontró en el archivo env.ini');
  finally
    IniFile.Free;
  end;
  Result := Token;
end;

procedure TAPIRest.add(value: String);
begin
  FName.Add(value);
end;

function TAPIRest.barcode(id: Integer): String;
begin
  Result := FBarcode[id];
end;

function TAPIRest.baseUrl: String;
begin
  Result := FBaseUrl;
end;

function TAPIRest.bath(id: integer): string;
begin
  Result := FBath[id];
end;

function TAPIRest.brands(id: integer): string;
begin
  Result:= FBrand[id];
end;

function TAPIRest.color(id: integer): string;
begin
  Result:= FColor[id];
end;

function TAPIRest.condition(id: integer): string;
begin
  Result:= FCondition[id];
end;

procedure TAPIRest.config(baseUrl, tokenName, tokenValue, paramName, paramValue,
  resource, rootElement: string);
begin
  FBaseUrl    := baseUrl;
  FTokenName  := tokenName;
  FTokenValue := tokenValue;
  FParamName  := paramName;
  FParamValue := paramValue;
  FResource   := resource;
  FRootElement:= rootElement;
end;

function TAPIRest.count: Integer;
begin
  Result := FID.Count;
end;

function TAPIRest.countStorehouse: integer;
begin
  result:= FStorehouseCode.Count;
end;

constructor TAPIRest.Create;
begin
  FName := TStringList.Create;
end;

function TAPIRest.currency(id: integer): string;
begin
  Result:= FCurrency[id];
end;

destructor TAPIRest.Destroy;
begin
  inherited;
end;

function TAPIRest.id(id: Integer): string;
begin
  Result := FID[id];
end;

function TAPIRest.isIA(id: integer): string;
begin
  Result := FIsIA[id];
end;

function TAPIRest.name(id: Integer): String;
begin
  Result := FName[id];
end;

function TAPIRest.notes(id: integer): string;
begin
  result:= FNotes[id];
end;

function TAPIRest.paramValue: string;
begin
  result:= FParamValue;
end;

function TAPIRest.parkingCar(id: integer): string;
begin
  Result := FParkingCar[id];
end;

function TAPIRest.parkingMoto(id: integer): string;
begin
Result := FParkingMoto[id];
end;

function TAPIRest.pets(id: integer): string;
begin
  Result := FPets[id];
end;

function TAPIRest.phones(id: integer): string;
begin
  Result:= FPhones[id];
end;

function TAPIRest.price(id: Integer): String;
begin
  Result := FPrice[id];
end;

function TAPIRest.resource: string;
begin
  result:= FResource;
end;

function TAPIRest.response: String;
var
  cli: TRESTClient;
  req: TRESTRequest;
  res: TRESTResponse;
  bearerToken: string;
begin

  // Leer el token Bearer desde el archivo env.ini
  bearerToken := GetBearerTokenFromIni;

  cli := TRESTClient.Create('');
  req := TRESTRequest.Create(cli);
  res := TRESTResponse.Create(req);

  cli.BaseURL := FBaseUrl;

  // Añadir el header de autorización con el token Bearer
  req.AddParameter('Authorization', 'Bearer ' + bearerToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);

  req.AddParameter(FTokenName, FTokenValue, TRESTRequestParameterKind.pkHTTPHEADER);
  req.AddParameter(FParamName, FParamValue, TRESTRequestParameterKind.pkURLSEGMENT);
  req.Resource := FResource;
  req.response := res;
  res.RootElement := 'items';

  req.Execute;

  result := res.Content;
end;

function TAPIRest.save: string;
var
  cli: TRESTClient;
  req: TRESTRequest;
  res: TRESTResponse;
  p: TRESTRequestParameter;
  bearerToken: string;
begin
  cli:= TRESTClient.Create(nil);
  req:= TRESTRequest.Create(cli);
  res:= TRESTResponse.Create(req);

  // get token
  bearerToken := GetBearerTokenFromIni;

  cli.BaseURL:= FBaseUrl;
  req.AddParameter('Authorization', 'Bearer ' + bearerToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
  req.Method:= TRESTRequestMethod.rmPOST;
  p:= req.Params.AddItem;
  p.ContentType:= TRESTContentType.ctAPPLICATION_JSON;
  p.Kind:= TRESTRequestParameterKind.pkREQUESTBODY;
  p.Name:= FParamName;
  p.Value:= FParamValue;

  req.response := res;
  req.Execute;

  result:= res.Content;
end;

function TAPIRest.put: string;
var
  cli: TRESTClient;
  req: TRESTRequest;
  res: TRESTResponse;
  p: TRESTRequestParameter;
  bearerToken: string;
begin
  cli:= TRESTClient.Create(nil);
  req:= TRESTRequest.Create(cli);
  res:= TRESTResponse.Create(req);

  // get token
  bearerToken := GetBearerTokenFromIni;

  cli.BaseURL:= FBaseUrl;
  req.AddParameter('Authorization', 'Bearer ' + bearerToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
  req.Method:= TRESTRequestMethod.rmPUT;
  p:= req.Params.AddItem;
  p.ContentType:= TRESTContentType.ctAPPLICATION_JSON;
  p.Kind:= TRESTRequestParameterKind.pkREQUESTBODY;
  p.Name:= FParamName;
  p.Value:= FParamValue;

  req.response := res;
  //req.Execute;
  try
  req.Execute;
  Result := res.Content;
  except
    on E: Exception do
    begin
      // Manejar el error y obtener información adicional
      ShowMessage('Error: ' + E.Message);
      Result := '';
    end;
  end;

  result:= res.Content;
end;

function TAPIRest.silent(id: integer): string;
begin
  Result := FSilent[id];
end;

function TAPIRest.sku(id: Integer): String;
begin
  Result := FSKU[id];
end;

function TAPIRest.status(id: integer): string;
begin
  result:= FStatus[id];
end;

function TAPIRest.stock(id: integer): string;
begin
  result := FStock[id];
end;

function TAPIRest.storehouseCode(id: integer): string;
begin
  result:= FStorehouseCode[id];
end;

Procedure TAPIRest.loadData(field: String);
var
  json      : string;
  obj, data : TJSONObject;
  arr       : TJSONArray;
  i, q      : Integer;
begin
  FName     := TStringList.Create;
  FID       := TStringList.Create;
  FSKU      := TStringList.Create;
  FBarcode  := TStringList.Create;
  FPrice    := TStringList.Create;
  FStock    := TStringList.Create;
  FLocation := TStringList.Create;
  FStatus   := TStringList.Create;
  FStorehouseID   := TStringList.Create;
  FStorehouseCode := TStringList.Create;

  { avisos center }
  FLatitude := TStringList.Create;
  FLongitude:= TStringList.Create;
  FCategoryName:= TStringList.Create;
  FAd       := TStringList.Create;
  FDate     := TStringList.Create;
//  FAdType   := TStringList.Create;
  FAddress  := TStringList.Create;

  json      := response;
  obj       := TJSONObject.ParseJSONValue(json) as TJSONObject;
  arr       := obj.Values['items'] as TJSONArray;
  q         := strtoint(obj.Values['count'].Value);

  try
    for i := 0 to q-1 do
    begin
      data := arr[i] as TJSONObject;

      { producto }
      if field = 'name' then
      begin
        FName.Add(data.Values[field].value);
        FID.Add(data.Values['id'].value);
      end;

      { productoBventa }
      if field = 'abc' then
      begin
        FName.Add(data.Values['description'].value);
        FID.Add(data.Values['id'].value);
        FSKU.Add(data.Values['sku'].value);
        FBarcode.Add(data.Values['barcode'].value);
        FPrice.Add(data.Values['price'].value);
        FLocation.Add(data.Values['locations'].Value);
        FStock.Add(data.Values['quantity'].Value);
      end;

      { variante }
      if field = 'description' then
      begin
        FName.Add(data.Values[field].value);
        FID.Add(data.Values['id'].value);
        FSKU.Add(data.Values['code'].value);
        FBarcode.Add(data.Values['barCode'].value);
      end;

      { precio }
      if field = 'variantValue' then
      begin
        FID.Add(data.Values['id'].value);
        FPrice.Add(data.Values[field].value);
      end;

      { localizacion }
      if field = 'barcode' then
      begin
        FID.Add(data.Values['id'].value);
        FBarcode.Add(data.Values[field].value);
        FStock.Add(data.Values['quantity'].Value);
        FLocation.Add(data.Values['location'].Value);
      end;

      { cliente}
      if field = 'code' then
      begin

        FID.Add(data.Values['id'].value);
        FBarcode.Add(data.Values[field].value);
        FStock.Add(data.Values['quantity'].Value);
        FLocation.Add(data.Values['location'].Value);
      end;

      { localizacion }
      if field = 'location' then
      begin
        FID.Add(data.Values['id'].value);
        FStorehouseID.Add(data.Values['storehouse_id'].Value);
        FStorehouseCode.Add(data.Values['code'].Value);
        FStatus.Add(data.Values['status'].Value);
      end;

      { ads }
      if field = 'body' then
      begin
        FName.Add(data.Values[field].value);
        FSKU.Add(data.Values['name'].value);
        FID.Add(data.Values['ad_id'].value);
        FBarcode.Add(data.Values['ads_created_at'].value);
      end;

      { searchAdCategories }
      if field = 'searchAdCategories' then
      begin
        FName.Add(data.Values['body'].value);
        FSKU.Add(data.Values['name'].value);
        FID.Add(data.Values['id'].value);
      end;

      { searchAdPhones }
      if field = 'searchAdPhones' then
      begin
        FName.Add(data.Values['body'].value);
        FSKU.Add(data.Values['number'].value);
        FID.Add(data.Values['id'].value);
      end;

      { map }
      if field = 'map' then
      begin
        FID.Add(data.Values['id'].value);
        FName.Add(data.Values['body'].value);
        FLatitude.Add(data.Values['latitude'].value);
        FLongitude.Add(data.Values['longitude'].value);
      end;

       { rents }
      if field = 'rents' then
      begin
        FID.Add(data.Values['ad_id'].value);
        FCategoryName.Add(data.Values['name'].value);
        FAd.Add(data.Values['body'].value);
        FDate.Add(data.Values['created_at'].value);
        FLatitude.Add(data.Values['latitude'].value);
        FLongitude.Add(data.Values['longitude'].value);
//        FAdType.Add(data.Values['type'].value);
        FAddress.Add(data.Values['address'].value);
        FPrice.Add(data.Values['price'].value);
       end;

       { needs }
      if field = 'needs' then
      begin
        FID.Add(data.Values['ad_id'].value);
        FCategoryName.Add(data.Values['name'].value);
        FAd.Add(data.Values['body'].value);
        FDate.Add(data.Values['date'].value);
       end;

    end;
  except
    //showMessage('Error: la lista de resultados sobrepaso los 50 registros');
  end;
end;


function TAPIRest.location(id: integer): string;
begin
  result := FLocation[id];
end;

function TAPIRest.thermal(id: integer): string;
begin
  Result := FThermal[id];
end;

function TAPIRest.tokenName: String;
begin
  Result := FTokenName;
end;

function TAPIRest.transmission(id: integer): string;
begin
  Result:= FTransmission[id];
end;

{ Avisos Center }
function TAPIRest.latitude(id: integer): string;
begin
  result := FLatitude[id];
end;

function TAPIRest.laundry(id: integer): string;
begin
  Result := FLaundry[id];
end;

function TAPIRest.longitude(id: integer): string;
begin
  result := FLongitude[id];
end;

function TAPIRest.mileage(id: integer): string;
begin
  Result:= FMileage[id];
end;

function TAPIRest.models(id: integer): string;
begin
  Result:= FModel[id];
end;

function TAPIRest.images(id: integer): string;
begin
  result := FImages[id];
end;

function TAPIRest.cable(id: integer): string;
begin
  Result := FCable[id];
end;

function TAPIRest.categoryId(id: integer): string;
begin
  Result := FCategoryId[id];
end;

function TAPIRest.wifi(id: integer): string;
begin
  Result := FWifi[id];
end;

function TAPIRest.year(id: integer): string;
begin
  Result:= FYear[id];
end;

function TAPIRest.categoryName(id: integer): string;
begin
  result := FCategoryName[id];
end;

function TAPIRest.city(id: integer): string;
begin
  result:= FCity[id];
end;

function TAPIRest.ad(id: integer): string;
begin
  result := FAd[id];
end;

function TAPIRest.date(id: integer): string;
begin
  result := FDate[id];
end;

function TAPIRest.typeId(id: integer): string;
begin
  Result:= FTypeId[id];
end;

function TAPIRest.typeName(id: integer): string;
begin
  Result := FTypeName[id];
end;

function TAPIRest.updated(id: integer): string;
begin
  Result:= FUpdated[id];
end;

function TAPIRest.address(id: integer): string;
begin
  result := FAddress[id];
end;

function TAPIRest.engine(id: integer): string;
begin
  result:= FEngine[id];
end;

function TAPIRest.existMap: Integer;
begin
  result := FLatitude.Count;
end;

function TAPIRest.expired(id: integer): string;
begin
  result:= FExpired[id];
end;

function TAPIRest.fuel(id: integer): string;
begin
  result:= FFuel[id];
end;

procedure TAPIRest.getAd;
var
  json      : string;
  obj, data : TJSONObject;
begin

  FID           := TStringList.Create;
  FCity         := TStringList.Create;
  FDate         := TStringList.Create;
  FCategoryId   := TStringList.Create;
  FCategoryName := TStringList.Create;
  FTypeId       := TStringList.Create;
  FTypeName     := TStringList.Create;
  FAd           := TStringList.Create;
  FAddress      := TStringList.Create;
  FCondition    := TStringList.Create;
  FLatitude     := TStringList.Create;
  FLongitude    := TStringList.Create;
  FIsIA         := TStringList.Create;
  FPrice        := TStringList.Create;
  FBath         := TStringList.Create;
  FWifi         := TStringList.Create;
  FCable        := TStringList.Create;
  FParkingMoto  := TStringList.Create;
  FParkingCar   := TStringList.Create;
  FThermal      := TStringList.Create;
  FLaundry      := TStringList.Create;
  FSilent       := TStringList.Create;
  FPets         := TStringList.Create;
  FStatus       := TStringList.Create;
  FCurrency     := TStringList.Create;
  FYear         := TStringList.Create;
  FMileage      := TStringList.Create;
  FEngine       := TStringList.Create;
  FFuel         := TStringList.Create;
  FTransmission := TStringList.Create;
  FColor        := TStringList.Create;


  json := response;
  obj := TJSONObject.ParseJSONValue(json) as TJSONObject;

  FID.Add(obj.Values['ad_id'].Value);
  FDate.Add(obj.Values['date'].Value);
  FCategoryId.Add(obj.Values['category_id'].Value);
  FCategoryName.Add(obj.Values['category_name'].Value);
  FTypeId.Add(obj.Values['type_id'].Value);
  FTypeName.Add(obj.Values['type_name'].Value);
  FAd.Add(obj.Values['body'].Value);
  FAddress.Add(obj.Values['address'].Value);
  FCondition.Add(obj.Values['condition'].Value);
  FLatitude.Add(obj.Values['latitude'].Value);
  FLongitude.Add(obj.Values['longitude'].Value);
  FIsIA.Add(obj.Values['isIA'].Value);
  FPrice.Add(obj.Values['price'].Value);
  FBath.Add(obj.Values['bath'].Value);
  FWifi.Add(obj.Values['wifi'].Value);
  FCable.Add(obj.Values['cable'].Value);
  FParkingMoto.Add(obj.Values['parking_moto'].Value);
  FParkingCar.Add(obj.Values['parking_car'].Value);
  FThermal.Add(obj.Values['thermal'].Value);
  FLaundry.Add(obj.Values['laundry'].Value);
  FSilent.Add(obj.Values['silent'].Value);
  FPets.Add(obj.Values['pets'].Value);
  FStatus.Add(obj.Values['ad_status'].Value);
  FCity.Add(obj.Values['city_id'].Value);
  FCurrency.Add(obj.Values['currency'].Value);
  FYear.Add(obj.Values['year'].Value);
  FMileage.Add(obj.Values['mileage'].Value);
  FEngine.Add(obj.Values['engine'].Value);
  FFuel.Add(obj.Values['fuel'].Value);
  FTransmission.Add(obj.Values['transmission'].Value);
  FColor.Add(obj.Values['color'].Value);

end;

// v1
{procedure TAPIRest.getAds;
var
  json      : string;
  obj, data : TJSONObject;
  arr       : TJSONArray;
  i, count  : Integer;
begin
  FID       := TStringList.Create;
  FDate     := TStringList.Create;
  FCategoryName:= TStringList.Create;
  FAd       := TStringList.Create;
  FAddress  := TStringList.Create;
  FCondition:= TStringList.Create;
  FStatus   := TStringList.Create;
  FLatitude := TStringList.Create;
  FLongitude:= TStringList.Create;
  FUpdated  := TStringList.Create;
  FExpired  := TStringList.Create;
  FNotes    := TStringList.Create;

  json      := response;
  obj       := TJSONObject.ParseJSONValue(json) as TJSONObject;
  arr       := obj.Values['items'] as TJSONArray;
  count     := strtoint(obj.Values['count'].Value);

  for i := 0 to count-1 do
  begin
    data := arr[i] as TJSONObject;
    FID.Add(data.Values['ad_id'].value);
    FDate.Add(data.Values['date'].value);
    FCategoryName.Add(data.Values['category_name'].value);
    FAd.Add(data.Values['body'].value);
    FAddress.Add(data.Values['address'].value);
    FCondition.Add(data.Values['condition'].value);
    FStatus.Add(data.Values['ad_status'].value);
    FLatitude.Add(data.Values['latitude'].value);
    FLongitude.Add(data.Values['longitude'].value);
    FUpdated.Add(data.Values['updated'].value);
    FExpired.Add(data.Values['expired_at'].value);
    FNotes.Add(data.Values['notes'].value);
  end;
end;}

// v2
procedure TAPIRest.getAds;
var
  json      : string;
  obj, itemsObj, data : TJSONObject;
  arr       : TJSONArray;
  i, count  : Integer;
begin
  FID       := TStringList.Create;
  FDate     := TStringList.Create;
  FCategoryName:= TStringList.Create;
  FAd       := TStringList.Create;
  FAddress  := TStringList.Create;
  FCondition:= TStringList.Create;
  FStatus   := TStringList.Create;
  FLatitude := TStringList.Create;
  FLongitude:= TStringList.Create;
  FUpdated  := TStringList.Create;
  FExpired  := TStringList.Create;
  FNotes    := TStringList.Create;
  try
    json := response;
    // Parse the JSON response
    obj := TJSONObject.ParseJSONValue(json) as TJSONObject;
    if not Assigned(obj) then
      raise Exception.Create('Error parsing JSON');
    // Retrieve the 'items' object
    itemsObj := obj.Values['items'] as TJSONObject;
    if not Assigned(itemsObj) then
      raise Exception.Create('Error: "items" not found in JSON');
    // Retrieve the 'data' array within 'items'
    arr := itemsObj.Values['data'] as TJSONArray;
    if not Assigned(arr) then
      raise Exception.Create('Error: "data" array not found in "items"');
    count := arr.Count;
    // Ensure we do not attempt to access data beyond the array bounds
    if count > 0 then
    begin
      for i := 0 to count - 1 do
      begin
        data := arr.Items[i] as TJSONObject;
        // Check if the JSON object contains the expected fields
        if Assigned(data) then
        begin
          FID.Add(data.Values['ad_id'].Value);
          FDate.Add(data.Values['date'].Value);
          FCategoryName.Add(data.Values['category_name'].Value);
          FAd.Add(data.Values['body'].Value);
          FAddress.Add(data.Values['address'].Value);
          FCondition.Add(data.Values['condition'].Value);
          FStatus.Add(data.Values['ad_status'].Value);
          FLatitude.Add(data.Values['latitude'].Value);
          FLongitude.Add(data.Values['longitude'].Value);
          FUpdated.Add(data.Values['updated'].Value);
          FExpired.Add(data.Values['expired_at'].Value);
          FNotes.Add(data.Values['notes'].Value);
        end;
      end;
    end;
  finally
    obj.Free; // Free the JSON object to avoid memory leaks
  end;
end;

procedure TAPIRest.getAdsFromPhone;
var
  json      : string;
  obj, data : TJSONObject;
  arr       : TJSONArray;
  i, count  : Integer;
begin
  FID       := TStringList.Create;
  FAd       := TStringList.Create;
  FPhones   := TStringList.Create;
  FCategoryName:= TStringList.Create;
  FDate     := TStringList.Create;
  FStatus   := TStringList.Create;

  json      := response;
  obj       := TJSONObject.ParseJSONValue(json) as TJSONObject;
  arr       := obj.Values['items'] as TJSONArray;
  count     := strtoint(obj.Values['count'].Value);

  for i := 0 to count-1 do
  begin
    data := arr[i] as TJSONObject;
    FID.Add(data.Values['ad_id'].value);
    FAd.Add(data.Values['body'].value);
    FPhones.Add(data.Values['number'].value);
    FCategoryName.Add(data.Values['category_name'].value);
    FDate.Add(data.Values['date'].value);
    FStatus.Add(data.Values['status'].value);
  end;
end;

procedure TAPIRest.getImagesFromId;
var
  json      : string;
  obj, data : TJSONObject;
  arr       : TJSONArray;
  i, count  : Integer;
begin
  FID       := TStringList.Create;
  FImages   := TStringList.Create;

  json      := response;
  obj       := TJSONObject.ParseJSONValue(json) as TJSONObject;
  arr       := obj.Values['items'] as TJSONArray;
  count     := strtoint(obj.Values['count'].Value);

  for i := 0 to count-1 do
  begin
    data := arr[i] as TJSONObject;
    FID.Add(data.Values['ad_id'].value);
    FImages.Add(data.Values['url'].value);
  end;
end;

procedure TAPIRest.getLastIdAd;
var
  json      : string;
  obj       : TJSONObject;
begin
  FID       := TStringList.Create;
  json      := response;

  obj       := TJSONObject.ParseJSONValue(json) as TJSONObject;

  try
    FID.Add(obj.Values['lastId'].value);
  finally
    obj.Free;
  end;
end;

procedure TAPIRest.getPhonesFromId;
var
  json      : string;
  obj, data : TJSONObject;
  arr       : TJSONArray;
  i, count  : Integer;
begin

  FID       := TStringList.Create;
  FPhones   := TStringList.Create;

  json      := response;
  obj       := TJSONObject.ParseJSONValue(json) as TJSONObject;
  arr       := obj.Values['items'] as TJSONArray;
  count     := strtoint(obj.Values['count'].Value);

  for i := 0 to count-1 do
  begin
    data := arr[i] as TJSONObject;
    FID.Add(data.Values['ad_id'].value);
    FPhones.Add(data.Values['number'].value);
  end;
end;

procedure TAPIRest.getBrands;
var
  json      : string;
  obj, data : TJSONObject;
  arr       : TJSONArray;
  i, count  : Integer;
begin
  FID       := TStringList.Create;
  FName     := TStringList.Create;

  json      := response;
  obj       := TJSONObject.ParseJSONValue(json) as TJSONObject;
  arr       := obj.Values['items'] as TJSONArray;
  count     := strtoint(obj.Values['count'].Value);

  for i := 0 to count-1 do
  begin
    data := arr[i] as TJSONObject;
    FID.Add(data.Values['id'].value);
    FName.Add(data.Values['name'].value);
  end;
end;

procedure TAPIRest.getModelsFromBrandId;
var
  json      : string;
  obj, data : TJSONObject;
  arr       : TJSONArray;
  i, count  : Integer;
begin
  FID       := TStringList.Create;
  FName    := TStringList.Create;

  json      := response;
  obj       := TJSONObject.ParseJSONValue(json) as TJSONObject;
  arr       := obj.Values['items'] as TJSONArray;
  count     := strtoint(obj.Values['count'].Value);

  for i := 0 to count-1 do
  begin
    data := arr[i] as TJSONObject;
    FID.Add(data.Values['model_id'].value);
    FName.Add(data.Values['name_model'].value);
  end;
end;

function TAPIRest.countImages: Integer;
begin
  result := FID.Count;
end;

end.
