<jsp:scriptlet>
    final String username = request.getParameter ( "username" );
    final String password = request.getParameter ( "password" );

    InventoryManagementSystem.Database.InitDatabase();

    final String status = InventoryManagementSystem.Driver.Login ( username, password );
    final String[] statusFields = status.split ( "`" );

    if ( statusFields.length == 5 && statusFields [ 0 ].equals ( "Success" ) )
    {
        final String accountType = statusFields [ 4 ];

        session.setAttribute ( "username", username );
        session.setAttribute ( "displayName", statusFields [ 1 ] );
        session.setAttribute ( "email", statusFields [ 2 ] );
        session.setAttribute ( "profilePicture", statusFields [ 3 ] );
        session.setAttribute ( "accountType", accountType );

        out.print ( "Success`" + accountType );
    }
    else
        out.print ( status );
</jsp:scriptlet>