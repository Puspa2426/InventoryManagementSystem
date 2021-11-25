<jsp:scriptlet>
    final String username = request.getParameter ( "username" );
    final String displayName = request.getParameter ( "displayName" );
    final String email = request.getParameter ( "email" );
    final String password = request.getParameter ( "password" );

    InventoryManagementSystem.Database.InitDatabase();

    out.print ( InventoryManagementSystem.Driver.AddUser ( username, displayName, email, password ) );
</jsp:scriptlet>