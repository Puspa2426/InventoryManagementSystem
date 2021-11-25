<jsp:scriptlet>
    final String oldProductID = request.getParameter ( "oldProductID" );
    final String productID = request.getParameter ( "productID" );
    final String productName = request.getParameter ( "productName" );
    final String category = request.getParameter ( "category" );
    final int quantity = Integer.parseInt ( request.getParameter ( "quantity" ) );
    final double price = Double.parseDouble ( request.getParameter ( "price" ) );

    InventoryManagementSystem.Database.InitDatabase();

    final String status = InventoryManagementSystem.Driver.UpdateProductInformation ( oldProductID, productID, productName,
        category, quantity, price );

    out.print ( status );
</jsp:scriptlet>