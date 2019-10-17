interface ZIF_SHOP_PERSISTENCE_SO_HDR
  public .


  methods CREATE_RESOURCE
    importing
      !IA_DATA type ANY
    returning
      value(RS_SO_HDR) type ZSHOP_SO_HDR
    raising
      ZCX_DATE_CONVERSION_ERROR
      ZCX_MISSING_PARAMETER
      ZCX_SHOP_DBDATA_ALREADY_EXISTS
      ZCX_SHOP_DB_ACCESS_ERROR .
  methods DELETE_RESOURCE
    importing
      !IA_DATA type ANY
    raising
      ZCX_DATE_CONVERSION_ERROR
      ZCX_MISSING_PARAMETER
      ZCX_SHOP_DBDATA_NOT_FOUND
      ZCX_SHOP_DB_ACCESS_ERROR .
endinterface.
