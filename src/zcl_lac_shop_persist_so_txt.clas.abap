class ZCL_LAC_SHOP_PERSIST_SO_TXT definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SHOP_PERSIST_SO_TXT .

  methods CONSTRUCTOR
    importing
      !IO_TEXT_DB type ref to ZIF_LAC_SHOP_SO_TXT_DB optional
      !IO_TEXT_WRAP type ref to ZIF_LAC_TEXT_WRAP optional .
protected section.
private section.

  data MO_TEXT_DB type ref to ZIF_LAC_SHOP_SO_TXT_DB .
  data MO_TEXT_WRAP type ref to ZIF_LAC_TEXT_WRAP .

  methods FORMATTER_INPUT_MESSAGE
    importing
      !IV_MESSAGE type C
    returning
      value(RS_SPLIT_RESULT) type ZLAC_SPLIT_RESULT .
ENDCLASS.



CLASS ZCL_LAC_SHOP_PERSIST_SO_TXT IMPLEMENTATION.


  METHOD constructor.

    IF io_text_db IS BOUND.
      mo_text_db = io_text_db.
    ELSE.
      CREATE OBJECT mo_text_db TYPE zcl_lac_shop_so_txt_db.
    ENDIF.

    IF io_text_wrap IS BOUND.
      mo_text_wrap = io_text_wrap.
    ELSE.
      CREATE OBJECT mo_text_wrap TYPE zcl_lac_text_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD FORMATTER_INPUT_MESSAGE.

    rs_split_result = mo_text_wrap->text_split(
      iv_length = 50 ##NUMBER_OK
      iv_text   = iv_message
    ).

  ENDMETHOD.


  METHOD zif_lac_shop_persist_so_txt~create_resource.

    DATA: ls_so_txt      TYPE zshop_so_txt,
          ls_so_txt_json TYPE zshop_so_txt_json,
          lv_message     TYPE c LENGTH 1024.

    ls_so_txt_json = ia_data.

    " KEY fields
    ls_so_txt-so_number = ls_so_txt_json-salesorderid.
    ls_so_txt-posnr     = ls_so_txt_json-salesorderitem.

    lv_message = ls_so_txt_json-message.
    WHILE lv_message <> space.

      DATA(ls_split_result) = formatter_input_message( lv_message ).

      ls_so_txt-line = sy-index.
      ls_so_txt-text = ls_split_result-line.

      lv_message = ls_split_result-rest.

      mo_text_db->create( ls_so_txt ).

    ENDWHILE.

  ENDMETHOD.


  METHOD ZIF_LAC_SHOP_PERSIST_SO_TXT~DELETE_RESOURCE.

    DATA: ls_so_txt      TYPE zshop_so_txt,
          ls_so_txt_json TYPE zshop_so_txt_json.

    ls_so_txt_json = ia_data.

    ls_so_txt-so_number = ls_so_txt_json-salesorderid.
    ls_so_txt-posnr     = ls_so_txt_json-salesorderitem.

    mo_text_db->delete(
      iv_so_number = ls_so_txt-so_number
      iv_posnr     = ls_so_txt-posnr
    ).

  ENDMETHOD.
ENDCLASS.
