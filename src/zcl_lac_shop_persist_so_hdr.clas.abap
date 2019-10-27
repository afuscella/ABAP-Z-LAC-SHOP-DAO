class ZCL_LAC_SHOP_PERSIST_SO_HDR definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SHOP_PERSIST_SO_HDR .

  methods CONSTRUCTOR
    importing
      !IO_DATE_WRAP type ref to ZIF_LAC_DATE_WRAP optional
      !IO_HEADER_DB type ref to ZIF_LAC_SHOP_SO_HDR_DB optional .
  PROTECTED SECTION.
private section.

  data MO_HEADER_DB type ref to ZIF_LAC_SHOP_SO_HDR_DB .
  data MO_DATE_WRAP type ref to ZIF_LAC_DATE_WRAP .
ENDCLASS.



CLASS ZCL_LAC_SHOP_PERSIST_SO_HDR IMPLEMENTATION.


  METHOD constructor.

    IF io_date_wrap IS BOUND.
      mo_date_wrap = io_date_wrap.
    ELSE.
      CREATE OBJECT mo_date_wrap TYPE zcl_lac_date_wrap.
    ENDIF.

    IF io_header_db IS BOUND.
      mo_header_db = io_header_db.
    ELSE.
      CREATE OBJECT mo_header_db TYPE zcl_lac_shop_so_hdr_db.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_shop_persist_so_hdr~create_resource.

    DATA: ls_so_hdr_json TYPE zlac_shop_so_hdr_json,
          ls_so_hdr      TYPE zlac_shop_so_hdr.

    ls_so_hdr_json = ia_data.

    " KEY fields
    ls_so_hdr-bukrs     = ls_so_hdr_json-companycode.
    ls_so_hdr-branch    = ls_so_hdr_json-businessplace.
    ls_so_hdr-so_number = ls_so_hdr_json-salesorderid.

    ls_so_hdr-credat = mo_date_wrap->convert_date_to_internal( ls_so_hdr_json-salesorderdate ).
    ls_so_hdr-so_date = mo_date_wrap->convert_date_to_internal( ls_so_hdr_json-createdate ).

    rs_so_hdr = mo_header_db->create( ls_so_hdr ).

  ENDMETHOD.


  METHOD zif_lac_shop_persist_so_hdr~delete_resource.

    DATA: ls_so_hdr      TYPE zlac_shop_so_hdr,
          ls_so_hdr_json TYPE zlac_shop_so_hdr_json.

    ls_so_hdr_json = ia_data.

    ls_so_hdr-bukrs     = ls_so_hdr_json-companycode.
    ls_so_hdr-branch    = ls_so_hdr_json-businessplace.
    ls_so_hdr-so_number = ls_so_hdr_json-salesorderid.

    ls_so_hdr-so_date   = mo_date_wrap->convert_date_to_internal( ls_so_hdr_json-salesorderdate ).
    ls_so_hdr-credat    = mo_date_wrap->convert_date_to_internal( ls_so_hdr_json-createdate ).

    mo_header_db->delete( ls_so_hdr ).

  ENDMETHOD.
ENDCLASS.
