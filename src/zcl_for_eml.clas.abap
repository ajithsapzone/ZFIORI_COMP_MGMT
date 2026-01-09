CLASS zcl_for_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_for_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    "Data Inserted for zcompany_vh table Country value field help
    DATA it_country TYPE STANDARD TABLE OF zcompany_vh.


    it_country = VALUE #( ( companyid = 'ENS001' country = 'INDIA'   )
                          ( companyid = 'ENS002' country = 'CANADA' )
                          ( companyid = 'ENS003' country = 'AMERICA' ) ).

    INSERT zcompany_vh FROM TABLE @it_country.

    IF it_country IS NOT INITIAL.
      out->write( 'DATA LOADED SUCCESSFULLY !!!!' ).
    ENDIF.


    "Data Inserted for zattendance_vh table status text field value help
    DATA it_atten TYPE STANDARD TABLE OF zattendance_vh.

    it_atten = VALUE #( ( code = 'P' statustext = 'Present' )
                        ( code = 'A' statustext = 'Absent' )
                        ( code = 'N' statustext = 'Not Logged In Yet' ) ).

    INSERT zattendance_vh FROM TABLE @it_atten.


    IF it_atten IS NOT INITIAL.
      out->write( 'DATA LOADED SUCCESSFULLY !!!!' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
