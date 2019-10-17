CLASS zcl_shop_persistence_so_hdr DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_shop_persistence_so_hdr .

    METHODS constructor
      IMPORTING
        !io_date_wrap TYPE REF TO zif_date_wrap OPTIONAL
        !io_header_db TYPE REF TO zif_shop_so_hdr_db OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mo_header_db TYPE REF TO zif_shop_so_hdr_db .
    DATA mo_date_wrap TYPE REF TO zif_date_wrap .
ENDCLASS.



CLASS ZCL_SHOP_PERSISTENCE_SO_HDR IMPLEMENTATION.


  METHOD constructor.

    IF io_date_wrap IS BOUND.
      mo_date_wrap = io_date_wrap.
    ELSE.
      CREATE OBJECT mo_date_wrap TYPE zcl_date_wrap.
    ENDIF.

    IF io_header_db IS BOUND.
      mo_header_db = io_header_db.
    ELSE.
      CREATE OBJECT mo_header_db TYPE zcl_shop_so_hdr_db.
    ENDIF.

  ENDMETHOD.


  METHOD zif_shop_persistence_so_hdr~create_resource.

    DATA: ls_so_hdr_json TYPE zshop_so_hdr_json,
          ls_so_hdr      TYPE zshop_so_hdr.

    ls_so_hdr_json = ia_data.

    " KEY fields
    ls_so_hdr-bukrs     = ls_so_hdr_json-company_code.
    ls_so_hdr-branch    = ls_so_hdr_json-business_place.
    ls_so_hdr-so_number = ls_so_hdr_json-sales_order_id.

    ls_so_hdr-credat = mo_date_wrap->convert_date_to_internal( ls_so_hdr_json-sales_order_date ).
    ls_so_hdr-so_date = mo_date_wrap->convert_date_to_internal( ls_so_hdr_json-create_date ).

    rs_so_hdr = mo_header_db->create( ls_so_hdr ).

  ENDMETHOD.


  METHOD zif_shop_persistence_so_hdr~delete_resource.

    DATA: ls_so_hdr      TYPE zshop_so_hdr,
          ls_so_hdr_json TYPE zshop_so_hdr_json.

    ls_so_hdr_json = ia_data.

    ls_so_hdr-bukrs     = ls_so_hdr_json-company_code.
    ls_so_hdr-branch    = ls_so_hdr_json-business_place.
    ls_so_hdr-so_number = ls_so_hdr_json-sales_order_id.

    ls_so_hdr-so_date   = mo_date_wrap->convert_date_to_internal( ls_so_hdr_json-sales_order_date ).
    ls_so_hdr-credat    = mo_date_wrap->convert_date_to_internal( ls_so_hdr_json-create_date ).

    mo_header_db->delete( ls_so_hdr ).

  ENDMETHOD.
ENDCLASS.
