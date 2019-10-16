class ZCL_SHOP_SO_HDR_DB definition
  public
  create public .

public section.

  interfaces ZIF_SHOP_SO_HDR_DB .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SHOP_SO_HDR_DB IMPLEMENTATION.


  METHOD zif_shop_so_hdr_db~create.

    SELECT COUNT(*) from zshop_so_hdr
      WHERE bukrs     = is_data-bukrs
        AND branch    = is_data-branch
        AND so_number = is_data-so_number.

    IF sy-dbcnt > 0.
      RAISE EXCEPTION TYPE zcx_shop_dbdata_already_exists
        EXPORTING
          textid = zcx_shop_dbdata_already_exists=>data_found.
    ENDIF.

    INSERT zshop_so_hdr FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_shop_db_access_error
        EXPORTING
          textid        = zcx_shop_db_access_error=>create_error
          mv_table_name = 'ZSHOP_SO_HDR'.
    ENDIF.

  ENDMETHOD.


  METHOD zif_shop_so_hdr_db~delete.

    SELECT COUNT(*) FROM zshop_so_hdr
      WHERE bukrs     = is_data-bukrs
        AND branch    = is_data-branch
        AND so_number = is_data-so_number.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_shop_dbdata_not_found
        EXPORTING
          textid = zcx_shop_dbdata_not_found=>no_data.
    ENDIF.

    DELETE zshop_so_hdr FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_shop_db_access_error
        EXPORTING
          textid        = zcx_shop_db_access_error=>delete_error
          mv_table_name = 'ZSHOP_SO_HDR'.
    ENDIF.

  ENDMETHOD.


  METHOD zif_shop_so_hdr_db~read.

    DATA: lr_company_code   TYPE RANGE OF bukrs,
          lr_business_place TYPE RANGE OF j_1bbranc_,
          lr_so_number      TYPE RANGE OF vbeln,
          lr_so_date        TYPE RANGE OF zshop_so_date.

    MOVE-CORRESPONDING is_selection_fields-bukrs     TO lr_company_code.
    MOVE-CORRESPONDING is_selection_fields-branch    TO lr_business_place.
    MOVE-CORRESPONDING is_selection_fields-so_number TO lr_so_number.
    MOVE-CORRESPONDING is_selection_fields-so_date   TO lr_so_date.

    SELECT * FROM zshop_so_hdr INTO TABLE rt_data
      WHERE bukrs     IN lr_company_code
        AND branch    IN lr_business_place
        AND so_number IN lr_so_number
        AND so_date   IN lr_so_date.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_shop_dbdata_not_found
        EXPORTING
          textid = zcx_shop_dbdata_not_found=>no_data.
    ENDIF.

  ENDMETHOD.


  METHOD zif_shop_so_hdr_db~read_by_id.

    SELECT SINGLE * FROM zshop_so_hdr INTO rs_data
      WHERE bukrs     = iv_company_code
        AND branch    = iv_business_place
        AND so_number = iv_sales_order_id.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_shop_dbdata_not_found
        EXPORTING
          textid = zcx_shop_dbdata_not_found=>no_data.
    ENDIF.

  ENDMETHOD.


  METHOD zif_shop_so_hdr_db~update.

    SELECT COUNT(*) FROM zshop_so_hdr
      WHERE bukrs     = is_data-bukrs
        AND branch    = is_data-branch
        AND so_number = is_data-so_number.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_shop_dbdata_not_found
        EXPORTING
          textid = zcx_shop_dbdata_not_found=>no_data.
    ENDIF.

    MODIFY zshop_so_hdr FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_shop_db_access_error
        EXPORTING
          textid        = zcx_shop_db_access_error=>update_error
          mv_table_name = 'ZSHOP_SO_HDR'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
