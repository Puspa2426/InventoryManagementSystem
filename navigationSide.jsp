                    <ul>
                        <%
                            final String accountType = ( String ) session.getAttribute ( "accountType" );

                            if ( accountType != null )
                            {
                                if ( accountType.equals ( "Retailer" ) )
                                {
                                    out.println ( "<li><a href='logout.jsp'>Log Out</a></li>" );
                                    out.println ( "<li><a href='viewInventory.jsp'>View Inventory</a></li>" );
                                    out.println ( "<li><a href='generateBarcode.jsp'>Generate Barcode</a></li>" );
                                    out.println ( "<li><a href='reports.jsp'>Generate Report</a></li>" );
                                    out.println ( "<li><a href='inventoryManagement.jsp'>Inventory Management</a></li>" );
                                    out.println ( "<li><a href='profile.jsp'>Profile</a></li>" );
                                }
                                else if ( accountType.equals ( "Administrator" ) )
                                {
                                    out.println ( "<li><a href='logout.jsp'>Log Out</a></li>" );
                                    out.println ( "<li><a href='viewInventory.jsp'>View Inventory</a></li>" );
                                    out.println ( "<li><a href='generateBarcode.jsp'>Generate Barcode</a></li>" );
                                    out.println ( "<li><a href='productManagement.jsp'>Product Management</a></li>" );
                                    out.println ( "<li><a href='profile.jsp'>Profile</a></li>" );
                                }
                            }
                        %>
                    </ul>