CLASS z2ui5_cl_app_hello_world DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA product           TYPE string.
    DATA quantity          TYPE string.
    DATA quantity2          TYPE string.
    DATA check_initialized TYPE abap_bool.

ENDCLASS.


CLASS z2ui5_cl_app_hello_world IMPLEMENTATION.

  METHOD z2ui5_if_app~main.


    IF check_initialized = abap_false.
      check_initialized = abap_true.

      product  = 'tomato'.
      quantity = '500'.

      DATA(lo_view) = z2ui5_cl_xml_view=>factory( client ).
      client->set_view( lo_view->shell(
            )->page(
                    title          = 'abap2UI5 - First Example'
                    navbuttonpress = client->__event( 'BACK' )
                    shownavbutton  = abap_true
                )->header_content(
                    )->link(
                        text = 'Source_Code'
                        href = lo_view->hlp_get_source_code_url(  )
                        target = '_blank'
                )->get_parent(
                )->simple_form( title = 'Form Title' editable = abap_true
                    )->content( 'form'
                        )->title( 'Input'
                        )->label( 'quantity'
                        )->input( client->__bind_edit( quantity )
                        )->label( client->__bind( quantity2 )
                        )->input(
                            value   = product
                            enabled = abap_false
                        )->button(
                            text  = 'count'
                            press = client->__event( val = 'BUTTON_POST' )
             )->stringify( ) ).

    ENDIF.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        quantity = CONV i( quantity ) + 1.
        quantity2 = CONV i( quantity ) + 1.
        client->popup_message_toast( |{ product } { quantity } - send to the server| ).
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-id_prev_app_stack  ) ).
    ENDCASE.


  ENDMETHOD.
ENDCLASS.
