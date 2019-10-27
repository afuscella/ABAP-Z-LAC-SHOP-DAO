class ZCL_LAC_SHOP_SO_HDR_DB definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SHOP_SO_HDR_DB .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_LAC_SHOP_SO_HDR_DB IMPLEMENTATION.


  METHOD zif_lac_shop_so_hdr_db~create.

    SELECT COUNT(*) FROM zlac_shop_so_hdr
      WHERE bukrs     = is_data-bukrs
        AND branch    = is_data-branch
        AND so_number = is_data-so_number.

    IF sy-dbcnt > 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_data_exist
        EXPORTING
          textid = zcx_lac_shop_data_exist=>conflict.
    ENDIF.

    INSERT zlac_shop_so_hdr FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_db_access_error
        EXPORTING
          textid        = zcx_lac_shop_db_access_error=>create_error
          mv_table_name = 'ZLAC_SHOP_SO_HDR'.
    ENDIF.

    rs_so_hdr = is_data.

  ENDMETHOD.


  METHOD zif_lac_shop_so_hdr_db~delete.

    SELECT COUNT(*) FROM zlac_shop_so_hdr
      WHERE bukrs     = is_data-bukrs
        AND branch    = is_data-branch
        AND so_number = is_data-so_number.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_data_not_found
        EXPORTING
          textid = zcx_lac_shop_data_not_found=>not_found.
    ENDIF.

    DELETE zlac_shop_so_hdr FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_db_access_error
        EXPORTING
          textid        = zcx_lac_shop_db_access_error=>delete_error
          mv_table_name = 'ZLAC_SHOP_SO_HDR'.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_shop_so_hdr_db~read.

    DATA: lr_company_code   TYPE RANGE OF bukrs,
          lr_business_place TYPE RANGE OF j_1bbranc_,
          lr_so_number      TYPE RANGE OF vbeln,
          lr_so_date        TYPE RANGE OF zshop_so_date.

    MOVE-CORRESPONDING is_selection_fields-bukrs     TO lr_company_code.
    MOVE-CORRESPONDING is_selection_fields-branch    TO lr_business_place.
    MOVE-CORRESPONDING is_selection_fields-so_number TO lr_so_number.
    MOVE-CORRESPONDING is_selection_fields-so_date   TO lr_so_date.

    SELECT * FROM zlac_shop_so_hdr INTO TABLE rt_data
      WHERE bukrs     IN lr_company_code
        AND branch    IN lr_business_place
        AND so_number IN lr_so_number
        AND so_date   IN lr_so_date.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_data_not_found
        EXPORTING
          textid = zcx_lac_shop_data_not_found=>not_found.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_shop_so_hdr_db~read_by_keys.

    SELECT SINGLE * FROM zlac_shop_so_hdr INTO rs_data
      WHERE bukrs     = iv_company_code
        AND branch    = iv_business_place
        AND so_number = iv_sales_order_id.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_data_not_found
        EXPORTING
          textid = zcx_lac_shop_data_not_found=>not_found.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_shop_so_hdr_db~update.

    SELECT COUNT(*) FROM zlac_shop_so_hdr
      WHERE bukrs     = is_data-bukrs
        AND branch    = is_data-branch
        AND so_number = is_data-so_number.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_data_not_found
        EXPORTING
          textid = zcx_lac_shop_data_not_found=>not_found.
    ENDIF.

    MODIFY zlac_shop_so_hdr FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_db_access_error
        EXPORTING
          textid        = zcx_lac_shop_db_access_error=>update_error
          mv_table_name = 'ZLAC_SHOP_SO_HDR'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
