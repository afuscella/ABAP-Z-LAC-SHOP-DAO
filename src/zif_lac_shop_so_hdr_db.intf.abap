interface ZIF_LAC_SHOP_SO_HDR_DB
  public .


  methods CREATE
    importing
      !IS_DATA type ZLAC_SHOP_SO_HDR
    returning
      value(RS_SO_HDR) type ZLAC_SHOP_SO_HDR
    raising
      ZCX_LAC_SHOP_DATA_EXIST
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
  methods READ
    importing
      !IS_SELECTION_FIELDS type ZLAC_SHOP_SO_HDR_SELECTION
    returning
      value(RT_DATA) type ZLAC_SHOP_SO_HDR_TAB
    raising
      ZCX_LAC_SHOP_DATA_NOT_FOUND .
  methods READ_BY_KEYS
    importing
      !IV_COMPANY_CODE type BUKRS
      !IV_BUSINESS_PLACE type J_1BBRANC_
      !IV_SALES_ORDER_ID type VBELN
    returning
      value(RS_DATA) type ZLAC_SHOP_SO_HDR
    raising
      ZCX_LAC_SHOP_DATA_NOT_FOUND .
  methods UPDATE
    importing
      !IS_DATA type ZLAC_SHOP_SO_HDR
    raising
      ZCX_LAC_SHOP_DATA_NOT_FOUND
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
  methods DELETE
    importing
      !IS_DATA type ZLAC_SHOP_SO_HDR
    raising
      ZCX_LAC_SHOP_DATA_NOT_FOUND
      ZCX_LAC_SHOP_DB_ACCESS_ERROR .
endinterface.
