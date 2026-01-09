

CLASS lhc_Z_I_COMPANY DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR z_i_company RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR z_i_company RESULT result.
    METHODS checknobranch FOR VALIDATE ON SAVE
      IMPORTING keys FOR z_i_company~checknobranch.
    METHODS overloginstatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR z_i_company~overloginstatus.
    METHODS setallpresent FOR MODIFY
      IMPORTING keys FOR ACTION z_i_company~setallpresent.

ENDCLASS.

CLASS lhc_Z_I_COMPANY IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.

  ENDMETHOD.


  METHOD checknobranch.

    READ ENTITIES OF z_i_company
    IN LOCAL MODE
    ENTITY z_i_company
    FIELDS  ( Nobranch )
    WITH VALUE #( ( %key-CompanyId = keys[ 1 ]-%key-CompanyId ) )
    RESULT DATA(result).


    LOOP AT result INTO DATA(ls_result).
      IF ( ls_result-Nobranch BETWEEN 1 AND 3 ).
      ELSE.
        failed-z_i_company = VALUE #( ( %key-CompanyId = ls_result-%key-CompanyId ) ).
        reported-z_i_company = VALUE #( ( %key-CompanyId = ls_result-%key-companyId
                                          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                          text =  'Branch Should be between 1-3' ) ) ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD overloginstatus.
*    MODIFY ENTITIES OF z_i_company
*    IN LOCAL MODE
*    ENTITY z_i_company
*    UPDATE FROM VALUE #( ( %key-CompanyId = keys[ 1 ]-%key-CompanyId
*                           overloginstatus = 'Absent'
*                           %control-overloginstatus = if_abap_behv=>mk-on ) )
*   FAILED DATA(failed)
*   REPORTED DATA(overreported).


    MODIFY ENTITIES OF z_i_company
    IN LOCAL MODE
    ENTITY z_i_company
    UPDATE FROM VALUE #( FOR key IN keys                "for Understanding I have added this  FOR is Like LOOP condition
                       ( %key-CompanyId = key-CompanyId
                         overloginstatus = 'Absent'
                         %control-overloginstatus = if_abap_behv=>mk-on ) )
   FAILED DATA(failed)
   REPORTED DATA(overreported).

*   %key-CompanyId = keys[ 1 ]-%key-CompanyId



  ENDMETHOD.

  METHOD setallpresent.

    DATA it_header TYPE TABLE FOR UPDATE z_i_company.
    DATA ls_header LIKE LINE OF it_header.
    DATA it_item TYPE TABLE FOR UPDATE z_i_employees.
    DATA ls_item LIKE LINE OF it_item.


    READ ENTITIES OF z_i_company
    IN LOCAL MODE
    ENTITY z_i_company
    ALL FIELDS WITH VALUE #( ( %key-CompanyId = keys[ 1 ]-%key-CompanyId ) )
    RESULT DATA(Header)
    ENTITY z_i_company BY \_employees
    ALL FIELDS WITH VALUE #( ( %key-CompanyId = keys[ 1 ]-%key-CompanyId ) )
    RESULT DATA(Item).


    LOOP AT header INTO DATA(ls_head).
      ls_header = CORRESPONDING #( ls_head ).
      ls_header-overloginstatus = 'Present'.
      ls_header-%control-overloginstatus = if_abap_behv=>mk-on.
      APPEND ls_header TO it_header.
    ENDLOOP.


    LOOP AT item INTO DATA(ls_items).
      ls_item = CORRESPONDING #( ls_items ).
      ls_item-loginstatus = 'Present'.
      ls_item-%control-loginstatus = if_abap_behv=>mk-on.
      APPEND ls_item TO it_item.
    ENDLOOP.


    MODIFY ENTITIES OF z_i_company
    IN LOCAL MODE
    ENTITY z_i_company
    UPDATE FROM it_header
    ENTITY z_i_employees
    UPDATE FROM it_item
    FAILED DATA(fail)
    REPORTED DATA(report).


  ENDMETHOD.

ENDCLASS.


CLASS lhc_z_i_employees DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS empJoiningdate FOR VALIDATE ON SAVE
      IMPORTING keys FOR z_i_employees~empJoiningdate.
    METHODS overallstatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR z_i_employees~overallstatus.

ENDCLASS.

CLASS lhc_z_i_employees IMPLEMENTATION.

  METHOD empjoiningdate.

    READ ENTITIES OF z_i_company
    IN LOCAL MODE
    ENTITY z_i_company BY \_employees
    FIELDS ( Joiningdate )
    WITH VALUE #( ( %key-CompanyId = keys[ 1 ]-%key-CompanyId ) )
    RESULT DATA(result).

    LOOP AT result INTO DATA(ls_result).

      IF ls_result-Joiningdate GE cl_abap_context_info=>get_system_date( ).
        failed-z_i_employees = VALUE #( ( %key-CompanyId = ls_result-%key-CompanyId ) ).
        reported-z_i_employees = VALUE #( ( %key-CompanyId = ls_result-%key-companyId
                                          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                           text = 'Wrong Date' ) ) ).
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD overallstatus.

    DATA(all_present) = abap_true.

    READ ENTITIES OF z_i_company
    IN LOCAL MODE
    ENTITY z_i_company
    FIELDS ( CompanyId )
    WITH VALUE #( ( %key-CompanyId = keys[ 1 ]-%key-CompanyId ) )
    RESULT DATA(result_companyid).


    READ ENTITIES OF z_i_company
    IN LOCAL MODE
    ENTITY z_i_company BY \_employees
    FIELDS ( loginstatus )
    WITH VALUE #( ( %key-CompanyId = keys[ 1 ]-%key-CompanyId ) )
    RESULT DATA(result_loginstatus).


    IF ( line_exists( result_loginstatus[ loginstatus = 'Not Logged In Yet' ] ) ).
      DATA(overallstatus) = 'Not Logged In Yet'.
    ELSE.

      LOOP AT result_loginstatus INTO DATA(ls_status).
        IF ls_status-loginstatus <> 'Present'.
          all_Present = abap_false.
        ENDIF.
        EXIT.
      ENDLOOP.

      IF all_present = abap_true AND result_loginstatus IS NOT INITIAL.
        overallstatus = 'Present'.
      ELSE.
        overallstatus = 'Absent'.
      ENDIF.
    ENDIF.


    "Updating the Overall Status value into Header Using Modify syntax

    MODIFY ENTITIES OF z_i_company
    IN LOCAL MODE
    ENTITY z_i_company
    UPDATE FROM VALUE #( ( %key-CompanyId =   result_companyid[ 1 ]-%key-CompanyId
                          overloginstatus = overallstatus
                          %control-overloginstatus = if_abap_behv=>mk-on ) )
    FAILED DATA(failed1)
    REPORTED DATA(reported1).




  ENDMETHOD.

ENDCLASS.
