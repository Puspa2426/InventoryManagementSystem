<jsp:scriptlet>
    final String productID = request.getParameter ( "productID" );

    InventoryManagementSystem.Database.InitDatabase();

    final String status = InventoryManagementSystem.Driver.DeleteProduct ( productID );

    out.print ( status );
</jsp:scriptlet>