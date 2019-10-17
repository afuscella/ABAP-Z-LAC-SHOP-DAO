interface ZIF_SHOP_PERSISTENCE_SO_TXT
  public .


  methods CREATE_RESOURCE
    importing
      !IA_DATA type ANY
    returning
      value(RS_SO_TXT) type ZSHOP_SO_TXT
    raising
      ZCX_SHOP_DBDATA_ALREADY_EXISTS
      ZCX_SHOP_DB_ACCESS_ERROR .
  methods DELETE_RESOURCE
    importing
      !IA_DATA type ANY
    raising
      ZCX_SHOP_DBDATA_NOT_FOUND
      ZCX_SHOP_DB_ACCESS_ERROR .
endinterface.
