<jsp:scriptlet>
    final String productID = request.getParameter ( "productID" );
    final int quantity = Integer.parseInt ( request.getParameter ( "quantity" ) );

    InventoryManagementSystem.Database.InitDatabase();

    final String status = InventoryManagementSystem.Driver.UpdateProductQuantity ( productID, quantity );

    out.print ( status );
</jsp:scriptlet>