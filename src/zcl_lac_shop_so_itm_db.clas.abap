class ZCL_LAC_SHOP_SO_ITM_DB definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SHOP_SO_ITM_DB .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_LAC_SHOP_SO_ITM_DB IMPLEMENTATION.


  METHOD zif_lac_shop_so_itm_db~create.

    SELECT COUNT(*) FROM zlac_shop_so_itm
      WHERE so_number = is_data-so_number
        AND posnr     = is_data-posnr.

    IF sy-dbcnt > 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_data_exist
        EXPORTING
          textid = zcx_lac_shop_data_exist=>conflict.
    ENDIF.

    INSERT zlac_shop_so_itm FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_db_access_error
        EXPORTING
          textid        = zcx_lac_shop_db_access_error=>create_error
          mv_table_name = 'ZLAC_SHOP_SO_ITM'.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_shop_so_itm_db~delete.

    SELECT COUNT(*) FROM zlac_shop_so_itm
      WHERE so_number = is_data-so_number
        AND posnr     = is_data-posnr.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_data_not_found
        EXPORTING
          textid = zcx_lac_shop_data_not_found=>not_found.
    ENDIF.

    DELETE zlac_shop_so_itm FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_db_access_error
        EXPORTING
          textid        = zcx_lac_shop_db_access_error=>delete_error
          mv_table_name = 'ZLAC_SHOP_SO_ITM'.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_shop_so_itm_db~read.

    DATA: lr_sales_order_id   TYPE RANGE OF vbeln,
          lr_sales_order_item TYPE RANGE OF posnr,
          lr_currency         TYPE RANGE OF waers,
          lr_amount           TYPE RANGE OF dmbtr.

    MOVE-CORRESPONDING is_selection_fields-so_number TO lr_sales_order_id.
    MOVE-CORRESPONDING is_selection_fields-posnr     TO lr_sales_order_item.
    MOVE-CORRESPONDING is_selection_fields-waers     TO lr_currency.
    MOVE-CORRESPONDING is_selection_fields-dmbtr     TO lr_amount.

    SELECT * FROM zlac_shop_so_itm INTO TABLE rt_data
      WHERE so_number IN lr_sales_order_id
        AND posnr     IN lr_sales_order_item
        AND waers     IN lr_currency
        AND dmbtr     IN lr_amount.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_data_not_found
        EXPORTING
          textid = zcx_lac_shop_data_not_found=>not_found.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_shop_so_itm_db~read_by_keys.

    SELECT SINGLE * FROM zlac_shop_so_itm
      INTO rs_data
      WHERE so_number = iv_sales_order_id
        AND posnr     = iv_sales_order_item.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_data_not_found
        EXPORTING
          textid = zcx_lac_shop_data_not_found=>not_found.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_shop_so_itm_db~update.

    SELECT COUNT(*) FROM zlac_shop_so_itm
      WHERE so_number = is_data-so_number
        AND posnr     = is_data-posnr.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_data_not_found
        EXPORTING
          textid = zcx_lac_shop_data_not_found=>not_found.
    ENDIF.

    MODIFY zlac_shop_so_itm FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_shop_db_access_error
        EXPORTING
          textid        = zcx_lac_shop_db_access_error=>update_error
          mv_table_name = 'ZLAC_SHOP_SO_ITM'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
