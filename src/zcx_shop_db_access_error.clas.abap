class ZCX_SHOP_DB_ACCESS_ERROR definition
  public
  inheriting from ZCX_SHOP
  create public .

public section.

  constants:
    begin of CREATE_ERROR,
      msgid type symsgid value 'ZSHOP',
      msgno type symsgno value '000',
      attr1 type scx_attrname value 'MV_TABLE_NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CREATE_ERROR .
  constants:
    begin of READ_ERROR,
      msgid type symsgid value 'ZSHOP',
      msgno type symsgno value '001',
      attr1 type scx_attrname value 'MV_TABLE_NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of READ_ERROR .
  constants:
    begin of UPDATE_ERROR,
      msgid type symsgid value 'ZSHOP',
      msgno type symsgno value '002',
      attr1 type scx_attrname value 'MV_TABLE_NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of UPDATE_ERROR .
  constants:
    begin of DELETE_ERROR,
      msgid type symsgid value 'ZSHOP',
      msgno type symsgno value '003',
      attr1 type scx_attrname value 'MV_TABLE_NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of DELETE_ERROR .
  data MV_TABLE_NAME type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_TABLE_NAME type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_SHOP_DB_ACCESS_ERROR IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_TABLE_NAME = MV_TABLE_NAME .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
