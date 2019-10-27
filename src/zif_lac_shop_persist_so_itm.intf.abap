interface ZIF_LAC_SHOP_PERSIST_SO_ITM
  public .


  methods CREATE_RESOURCE
    importing
      !IA_DATA type ANY
    returning
      value(RS_SO_ITM) type ZLAC_SHOP_SO_ITM
    raising
      ZCX_LAC_BAPI_AMOUNT_INCORRECT
      ZCX_LAC_SHOP_DATA_EXIST
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
  methods DELETE_RESOURCE
    importing
      !IA_DATA type ANY
    raising
      ZCX_LAC_BAPI_AMOUNT_INCORRECT
      ZCX_LAC_SHOP_DATA_NOT_FOUND
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
endinterface.
