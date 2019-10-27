interface ZIF_LAC_SHOP_PERSIST_SO_HDR
  public .


  methods CREATE_RESOURCE
    importing
      !IA_DATA type ANY
    returning
      value(RS_SO_HDR) type ZLAC_SHOP_SO_HDR
    raising
      ZCX_LAC_DATE_CONVERSION_ERROR
      ZCX_LAC_MISSING_PARAMETER
      ZCX_LAC_SHOP_DATA_EXIST
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
  methods DELETE_RESOURCE
    importing
      !IA_DATA type ANY
    raising
      ZCX_LAC_DATE_CONVERSION_ERROR
      ZCX_LAC_MISSING_PARAMETER
      ZCX_LAC_SHOP_DATA_NOT_FOUND
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
endinterface.
