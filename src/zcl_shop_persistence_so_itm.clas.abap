CLASS zcl_shop_persistence_so_itm DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_shop_persistence_so_itm .

    METHODS constructor
      IMPORTING
        !io_amount_wrap TYPE REF TO zif_amount_wrap OPTIONAL
        !io_item_db     TYPE REF TO zif_shop_so_itm_db OPTIONAL .
protected section.
private section.

  data MO_AMOUNT_WRAP type ref to ZIF_AMOUNT_WRAP .
  data MO_ITEM_DB type ref to ZIF_SHOP_SO_ITM_DB .
ENDCLASS.



CLASS ZCL_SHOP_PERSISTENCE_SO_ITM IMPLEMENTATION.


  METHOD constructor.

    IF io_amount_wrap IS BOUND.
      mo_amount_wrap = io_amount_wrap.
    ELSE.
      CREATE OBJECT mo_amount_wrap TYPE zcl_amount_wrap.
    ENDIF.

    IF io_item_db IS BOUND.
      mo_item_db = io_item_db.
    ELSE.
      CREATE OBJECT mo_item_db TYPE zcl_shop_so_itm_db.
    ENDIF.

  ENDMETHOD.


  METHOD zif_shop_persistence_so_itm~create_resource.

    DATA: ls_so_itm      TYPE zshop_so_itm,
          ls_so_itm_json TYPE zshop_so_itm_json.

    ls_so_itm_json = ia_data.

    ls_so_itm-so_number = ls_so_itm_json-sales_order_id.
    ls_so_itm-posnr     = ls_so_itm_json-sales_order_item.

    ls_so_itm-waers     = ls_so_itm_json-currency.

    ls_so_itm-dmbtr = mo_amount_wrap->currency_amount_bapi_to_sap(
      iv_currency = CONV waers( ls_so_itm_json-currency )
      iv_amount   = CONV bapicurr_d( ls_so_itm_json-amount )
    ).

    mo_item_db->create( ls_so_itm ).

    rs_so_itm = ls_so_itm.

  ENDMETHOD.


  METHOD zif_shop_persistence_so_itm~delete_resource.

    DATA: ls_so_itm      TYPE zshop_so_itm,
          ls_so_itm_json TYPE zshop_so_itm_json.

    ls_so_itm_json = ia_data.

    ls_so_itm-so_number = ls_so_itm_json-sales_order_id.
    ls_so_itm-posnr     = ls_so_itm_json-sales_order_item.

    ls_so_itm-waers     = ls_so_itm_json-currency.

    ls_so_itm-dmbtr = mo_amount_wrap->currency_amount_bapi_to_sap(
      iv_currency = CONV waers( ls_so_itm_json-currency )
      iv_amount   = CONV bapicurr_d( ls_so_itm_json-amount )
    ).

    mo_item_db->delete( ls_so_itm ).

  ENDMETHOD.
ENDCLASS.
