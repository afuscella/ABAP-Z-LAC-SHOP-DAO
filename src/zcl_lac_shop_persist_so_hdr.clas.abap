class ZCL_LAC_SHOP_PERSIST_SO_HDR definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SHOP_PERSIST_SO_HDR .

  methods CONSTRUCTOR
    importing
      !IO_DATE_WRAP type ref to ZIF_LAC_DATE_WRAP optional
      !IO_TIME_WRAP type ref to ZIF_LAC_TIME_WRAP optional
      !IO_HEADER_DB type ref to ZIF_LAC_SHOP_SO_HDR_DB optional .
  methods CONVERT_DATE
    importing
      !IV_DATE type STRING
    returning
      value(RV_DATE) type D .
  methods CONVERT_TIME
    importing
      !IV_TIME type STRING
    returning
      value(RV_TIME) type T .
  PROTECTED SECTION.
private section.

  data MO_HEADER_DB type ref to ZIF_LAC_SHOP_SO_HDR_DB .
  data MO_DATE_WRAP type ref to ZIF_LAC_DATE_WRAP .
  data MO_TIME_WRAP type ref to ZIF_LAC_TIME_WRAP .
ENDCLASS.



CLASS ZCL_LAC_SHOP_PERSIST_SO_HDR IMPLEMENTATION.


  METHOD constructor.

    IF io_date_wrap IS BOUND.
      mo_date_wrap = io_date_wrap.
    ELSE.
      CREATE OBJECT mo_date_wrap TYPE zcl_lac_date_wrap.
    ENDIF.

    IF io_time_wrap IS BOUND.
      mo_time_wrap = io_time_wrap.
    ELSE.
      CREATE OBJECT mo_time_wrap TYPE zcl_lac_time_wrap.
    ENDIF.

    IF io_header_db IS BOUND.
      mo_header_db = io_header_db.
    ELSE.
      CREATE OBJECT mo_header_db TYPE zcl_lac_shop_so_hdr_db.
    ENDIF.

  ENDMETHOD.


  METHOD convert_date.

    TRY.
        rv_date = mo_date_wrap->convert_date_to_internal( iv_date ).
      CATCH zcx_lac_date_conversion_error zcx_lac_missing_parameter ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.


  METHOD convert_time.

    TRY.
        rv_time = mo_time_wrap->convert_time_to_internal( iv_time ).
      CATCH zcx_lac_time_conversion_error ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.


  METHOD zif_lac_shop_persist_so_hdr~create_resource.

    DATA: ls_so_hdr_json TYPE zlac_shop_so_hdr_json,
          ls_so_hdr      TYPE zlac_shop_so_hdr.

    ls_so_hdr_json = ia_data.

    " KEY fields
    ls_so_hdr-bukrs       = ls_so_hdr_json-companycode.
    ls_so_hdr-branch      = ls_so_hdr_json-businessplace.
    ls_so_hdr-so_number   = ls_so_hdr_json-salesorderid.

    ls_so_hdr-credat      = convert_date( ls_so_hdr_json-createdate ).
    ls_so_hdr-cretim      = convert_time( ls_so_hdr_json-createtime ).

    ls_so_hdr-so_date     = convert_date( ls_so_hdr_json-salesorderdate ).
    ls_so_hdr-so_category = ls_so_hdr_json-salesordercategory.

    rs_so_hdr = mo_header_db->create( ls_so_hdr ).

  ENDMETHOD.


  METHOD zif_lac_shop_persist_so_hdr~delete_resource.

    DATA: lv_company_code   TYPE bukrs,
          lv_business_place TYPE j_1bbranc_,
          lv_sales_order_id TYPE vbeln,
          ls_so_hdr         TYPE zlac_shop_so_hdr,
          ls_so_hdr_json    TYPE zlac_shop_so_hdr_json.

    ls_so_hdr_json = ia_data.

    lv_company_code   = ls_so_hdr_json-companycode.
    lv_business_place = ls_so_hdr_json-businessplace.
    lv_sales_order_id = ls_so_hdr_json-salesorderid.

    ls_so_hdr = mo_header_db->read_by_keys(
      iv_company_code   = lv_company_code
      iv_business_place = lv_business_place
      iv_sales_order_id = lv_sales_order_id
    ).

    mo_header_db->delete( ls_so_hdr ).

  ENDMETHOD.
ENDCLASS.
