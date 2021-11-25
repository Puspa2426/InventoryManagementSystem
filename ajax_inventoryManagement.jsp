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
                        <th style='width:5%'>No</th>
                        <th style='width:20%'>Product ID</th>
                        <th style='width:20%'>Product Name</th>
                        <th style='width:20%'>Category</th>
                        <th style='width:15%'>Price (RM)</th>
                        <th style='width:10%'>Quantity</th>
                        <th style='width:10%'>Action</th>
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

            final String strPrice = String.format ( "%.2f", price );

            out.println ( "                    <tr align='center'>" );
            out.println ( "                        <form onsubmit='return UpdateQuantity(\"" + productID + "\"," + no + ")'>" );
            out.println ( "                        <td>" + no + "</td>" );
            out.println ( "                        <td>" + productID + "</td>" );
            out.println ( "                        <td>" + productName + "</td>" );
            out.println ( "                        <td>" + category + "</td>" );
            out.println ( "                        <td>" + strPrice + "</td>" );
            out.println ( "                        <td><input type='number' id='quantity" + no + "' value='" + quantity + "' style='width:100%;text-align:right' required='required' /></td>" );
            out.println ( "                        <td><input type='submit' class='buttons' value='Update' style='width:100%' /></td>" );
            out.println ( "                        </form>" );
            out.println ( "                    </tr>" );

            ++no;
        }
    }
%>
</table>