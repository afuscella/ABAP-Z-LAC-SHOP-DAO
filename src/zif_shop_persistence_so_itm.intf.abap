interface ZIF_SHOP_PERSISTENCE_SO_ITM
  public .


  methods CREATE_RESOURCE
    importing
      !IA_DATA type ANY
    returning
      value(RS_SO_ITM) type ZSHOP_SO_ITM
    raising
      ZCX_BAPI_AMOUNT_INCORRECT
      ZCX_SHOP_DBDATA_ALREADY_EXISTS
      ZCX_SHOP_DB_ACCESS_ERROR .
  methods DELETE_RESOURCE
    importing
      !IA_DATA type ANY
    raising
      ZCX_BAPI_AMOUNT_INCORRECT
      ZCX_SHOP_DBDATA_NOT_FOUND
      ZCX_SHOP_DB_ACCESS_ERROR .
endinterface.
