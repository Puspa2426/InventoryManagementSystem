<jsp:scriptlet>
    final String username = request.getParameter ( "username" );
    final String displayName = request.getParameter ( "displayName" );
    final String email = request.getParameter ( "email" );
    final String password = request.getParameter ( "password" );
    final long oldProfilePicture = Long.parseLong ( request.getParameter ( "oldProfilePicture" ) );
    final long profilePicture = Long.parseLong ( request.getParameter ( "profilePicture" ) );

    InventoryManagementSystem.Database.InitDatabase();

    final String status = InventoryManagementSystem.Driver.SaveProfile ( session.getAttribute ( "username" ).toString(), username, displayName, email, password, oldProfilePicture, profilePicture );

    if ( status.equals ( "Success" ) )
    {
        session.setAttribute ( "username", username );
        session.setAttribute ( "displayName", displayName );
        session.setAttribute ( "email", email );
        session.setAttribute ( "profilePicture", profilePicture );
    }

    out.print ( status );
</jsp:scriptlet>