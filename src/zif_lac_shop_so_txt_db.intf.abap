interface ZIF_LAC_SHOP_SO_TXT_DB
  public .


  methods CREATE
    importing
      !IS_DATA type ZLAC_SHOP_SO_TXT
    raising
      ZCX_LAC_SHOP_DATA_EXIST
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
  methods READ
    importing
      !IS_SELECTION_FIELDS type ZLAC_SHOP_SO_TXT_SELECTION
    returning
      value(RT_DATA) type ZLAC_SHOP_SO_TXT_TAB
    raising
      ZCX_LAC_SHOP_DATA_NOT_FOUND .
  methods READ_BY_KEYS
    importing
      !IV_SALES_ORDER_ID type J_1BBRANC_
      !IV_SALES_ORDER_ITEM type VBELN
      !IV_TEXT_LINE type ZLAC_SHOP_TEXT_LINE
    returning
      value(RS_DATA) type ZLAC_SHOP_SO_TXT
    raising
      ZCX_LAC_SHOP_DATA_NOT_FOUND .
  methods UPDATE
    importing
      !IS_DATA type ZSHOP_SO_TXT
    raising
      ZCX_LAC_SHOP_DATA_NOT_FOUND
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
  methods DELETE
    importing
      !IV_SO_NUMBER type VBELN
      !IV_POSNR type POSNR
    raising
      ZCX_LAC_SHOP_DATA_NOT_FOUND
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
endinterface.
