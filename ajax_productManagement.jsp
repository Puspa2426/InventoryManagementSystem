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
                        <th style='width:5%'>Quantity</th>
                        <th style='width:10%'>Price (RM)</th>
                        <th style='width:20%'>Action</th>
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
            out.println ( "                        <form onsubmit='return PerformAction()'>" );
            out.println ( "                        <input type='hidden' id='oldProductID" + no + "' value='" + productID + "' />" );
            out.println ( "                        <td>" + no + "</td>" );
            out.println ( "                        <td><input type='text' id='productID" + no + "' value='" + productID + "' style='width:100%' required='required' /></td>" );
            out.println ( "                        <td><input type='text' id='productName" + no + "' value='" + productName + "' style='width:100%' required='required' /></td>" );
            out.println ( "                        <td><select id='category" + no + "' style='width:100%' required='required'>" );

            final String[] arrProductCategories = InventoryManagementSystem.Driver.ReadProductCategories();

            if ( arrProductCategories != null )
            {
                for ( int productIndex2 = 0; productIndex2 != arrProductCategories.length; ++productIndex2 )
                {
                    final String productCategory = arrProductCategories [ productIndex2 ];
                    final String selected = ( category.equals ( productCategory ) ) ? " selected='selected'" : "";
                    out.println ( "                    <option value='" + productCategory + "'" + selected + ">" + productCategory + "</option>" );
                }
            }

            out.println ( "                        </select></td>" );
            out.println ( "                        <td><input type='number' id='quantity" + no + "' value='" + quantity + "' style='width:100%;text-align:right' required='required' /></td>" );
            out.println ( "                        <td><input type='number' id='price" + no + "' step='0.01' value='" + strPrice + "' style='width:100%;text-align:right' required='required' /></td>" );
            out.println ( "                        <td><input type='submit' class='buttons' value='Update' onclick='javascript:activity=\"Update\";productIndex=" + no + "' style='width:49%' /><input type='submit' class='buttons' value='Delete' onclick='javascript:activity=\"Delete\";productIndex=" + no + "' style='width:49%;float:right' /></td>" );
            out.println ( "                        </form>" );
            out.println ( "                    </tr>" );

            ++no;
        }
    }
%>
</table>