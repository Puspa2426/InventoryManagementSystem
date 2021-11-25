<%
    final String paramCategory = request.getParameter ( "category" );
    final String paramProductID = request.getParameter ( "productID" );
    final String paramProductName = request.getParameter ( "productName" );

    InventoryManagementSystem.Database.InitDatabase();

    final String[] arrProductInformation = InventoryManagementSystem.Driver.ReadProductInformation ( paramCategory, paramProductID, paramProductName );

    if ( arrProductInformation != null )
    {
%>
<table style='width:100%' border='1'>
                    <tr align='center'>
                        <th>No</th>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Quantity</th>
                        <th>Price (RM)</th>
                    </tr>
<%
        int no = 1;

        for ( int productIndex = 0; productIndex != arrProductInformation.length; ++productIndex )
        {
            final String[] fields = arrProductInformation [ productIndex ].split ( "`" );

            final String productID = fields [ 0 ];
            final String productName = fields [ 1 ];
            final String category = fields [ 2 ];
            final int quantity = Integer.parseInt ( fields [ 3 ] );
            final double price = Double.parseDouble ( fields [ 4 ] );

            final int priceInt = ( int ) Math.floor ( price );
            final double remainder = ( price - priceInt ) * 10;
            final int priceFract1 = ( int ) Math.floor ( remainder );
            final int priceFract2 = ( int ) Math.round ( ( remainder - priceFract1 ) * 10 );
            final String strPrice = priceInt + "." + priceFract1 + priceFract2;

            out.println ( "                    <tr align='center'>" );
            out.println ( "                        <td>" + no++ + "</td>" );
            out.println ( "                        <td>" + productID + "</td>" );
            out.println ( "                        <td>" + productName + "</td>" );
            out.println ( "                        <td>" + category + "</td>" );
            out.println ( "                        <td>" + quantity + "</td>" );
            out.println ( "                        <td>" + strPrice + "</td>" );
            out.println ( "                    </tr>" );
        }
    }
%>
</table>