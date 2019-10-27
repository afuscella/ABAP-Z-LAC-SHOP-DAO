interface ZIF_LAC_SHOP_PERSIST_SO_TXT
  public .


  methods CREATE_RESOURCE
    importing
      !IA_DATA type ANY
    returning
      value(RS_SO_TXT) type ZSHOP_SO_TXT
    raising
      ZCX_LAC_SHOP_DATA_EXIST
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
  methods DELETE_RESOURCE
    importing
      !IA_DATA type ANY
    raising
      ZCX_LAC_SHOP_DATA_NOT_FOUND
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
endinterface.
