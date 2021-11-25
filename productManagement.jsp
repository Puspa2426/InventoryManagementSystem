<%@page import='java.util.Date' %>
<%@page import='java.text.SimpleDateFormat' %>
<jsp:scriptlet>
    if ( session.isNew() || session.getAttribute ( "username" ) == null || session.getAttribute ( "displayName" ) == null || session.getAttribute ( "email" ) == null ||
         session.getAttribute ( "profilePicture" ) == null || session.getAttribute ( "accountType" ) == null || !session.getAttribute ( "accountType" ).toString().equals ( "Administrator" ) )
    {
        response.sendRedirect ( "index.jsp" );
        return;
    }

    final String accountType = session.getAttribute ( "accountType" ).toString();

    final Date now = new Date();
    final SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd" );
    final SimpleDateFormat timeFormat = new SimpleDateFormat ( "HH:mm" );
</jsp:scriptlet>
<jsp:include page='header.jsp' />
<script type='text/javascript'>
    var activity
    var productIndex

    function PerformAction()
    {
        var oldProductID = document.getElementById ( 'oldProductID' + productIndex ).value

        switch ( activity )
        {
            case 'Update':
                var productID = document.getElementById ( 'productID' + productIndex ).value
                var productName = document.getElementById ( 'productName' + productIndex ).value

                var categoryEl = document.getElementById ( 'category' + productIndex )
                var category = categoryEl.options [ categoryEl.selectedIndex ].value

                var quantity = document.getElementById ( 'quantity' + productIndex ).value
                var price = document.getElementById ( 'price' + productIndex ).value

                if ( window.XMLHttpRequest )
                {
                    // code for modern browsers
                    xmlhttp = new XMLHttpRequest()
                }
                else
                {
                    // code for old IE browsers
                    xmlhttp = new ActiveXObject ( 'Microsoft.XMLHTTP' )
                }

                xmlhttp.onreadystatechange = function()
                {
                    if ( this.readyState == 4 && this.status == 200 )
                    {
                        if ( this.responseText === 'Success' )
                        {
                            if ( oldProductID !== productID )
                            {
                                document.getElementById ( 'oldProductID' + productIndex ).value = productID
                                alert ( oldProductID + ' updated successfully to ' + productID + '!' )
                            }
                            else
                                alert ( oldProductID + ' updated successfully!' )

                            location.reload ( true )
                        }
                        else
                            alert ( this.responseText )
                    }
                }

                xmlhttp.open ( 'POST', 'ajax_updateProductInformation.jsp', true )
                xmlhttp.setRequestHeader ( 'Content-type', 'application/x-www-form-urlencoded' )
                xmlhttp.send ( 'oldProductID=' + oldProductID + '&productID=' + productID + '&productName=' + productName + '&category=' + category + '&quantity=' + quantity + '&price=' + price )
                break

            case 'Delete':
                if ( window.XMLHttpRequest )
                {
                    // code for modern browsers
                    xmlhttp = new XMLHttpRequest()
                }
                else
                {
                    // code for old IE browsers
                    xmlhttp = new ActiveXObject ( 'Microsoft.XMLHTTP' )
                }

                xmlhttp.onreadystatechange = function()
                {
                    if ( this.readyState == 4 && this.status == 200 )
                    {
                        if ( this.responseText === 'Success' )
                        {
                            alert ( oldProductID + ' deleted successfully!' )
                            location.reload ( true )
                        }
                        else
                            alert ( this.responseText )
                    }
                }

                xmlhttp.open ( 'POST', 'ajax_deleteProduct.jsp', true )
                xmlhttp.setRequestHeader ( 'Content-type', 'application/x-www-form-urlencoded' )
                xmlhttp.send ( 'productID=' + oldProductID )
                break
        }

        return false
    }

    function HandleCategoryChange()
    {
        var categoryEl = document.getElementById ( 'category' )
        var category = categoryEl.options [ categoryEl.selectedIndex ].value

        if ( window.XMLHttpRequest )
        {
            // code for modern browsers
            xmlhttp = new XMLHttpRequest()
        }
        else
        {
            // code for old IE browsers
            xmlhttp = new ActiveXObject ( 'Microsoft.XMLHTTP' )
        }

        xmlhttp.onreadystatechange = function()
        {
            if ( this.readyState == 4 && this.status == 200 )
            {
                document.getElementById ( 'spanInventory' ).innerHTML = this.responseText
            }
        }

        xmlhttp.open ( 'POST', 'ajax_productManagement.jsp', true )
        xmlhttp.setRequestHeader ( 'Content-type', 'application/x-www-form-urlencoded' )
        xmlhttp.send ( 'category=' + category + '&productID=&productName=' )
    }

    function SearchByProductID()
    {
        var categoryEl = document.getElementById ( 'category' )
        var category = categoryEl.options [ categoryEl.selectedIndex ].value

        var productID = document.getElementById ( 'productID' ).value

        if ( window.XMLHttpRequest )
        {
            // code for modern browsers
            xmlhttp = new XMLHttpRequest()
        }
        else
        {
            // code for old IE browsers
            xmlhttp = new ActiveXObject ( 'Microsoft.XMLHTTP' )
        }

        xmlhttp.onreadystatechange = function()
        {
            if ( this.readyState == 4 && this.status == 200 )
            {
                document.getElementById ( 'spanInventory' ).innerHTML = this.responseText
            }
        }

        xmlhttp.open ( 'POST', 'ajax_productManagement.jsp', true )
        xmlhttp.setRequestHeader ( 'Content-type', 'application/x-www-form-urlencoded' )
        xmlhttp.send ( 'category=' + category + '&productID=' + productID + '&productName=' )
        return false
    }

    function SearchByProductName()
    {
        var categoryEl = document.getElementById ( 'category' )
        var category = categoryEl.options [ categoryEl.selectedIndex ].value

        var productName = document.getElementById ( 'productName' ).value

        if ( window.XMLHttpRequest )
        {
            // code for modern browsers
            xmlhttp = new XMLHttpRequest()
        }
        else
        {
            // code for old IE browsers
            xmlhttp = new ActiveXObject ( 'Microsoft.XMLHTTP' )
        }

        xmlhttp.onreadystatechange = function()
        {
            if ( this.readyState == 4 && this.status == 200 )
            {
                document.getElementById ( 'spanInventory' ).innerHTML = this.responseText
            }
        }

        xmlhttp.open ( 'POST', 'ajax_productManagement.jsp', true )
        xmlhttp.setRequestHeader ( 'Content-type', 'application/x-www-form-urlencoded' )
        xmlhttp.send ( 'category=' + category + '&productID=&productName=' + productName )
        return false
    }
</script>
<body class='size-1280'>
    <!-- HEADER -->
    <header>
        <div class='line'>
            <div class='box'>
               <div class='s-12 l-12 right'>
                    <div class='margin'>
                        <table width='100%'>
                        <tr>
                            <td width='30%'><img src='images/logo.png' style='width:250px;height:90px' /></td>
                            <td width='40%'><center><img src='images/college.png' style='height:90px' /></center></td>
                            <td width='30%'><table>
                            <tr>
                                <td><%= session.getAttribute ( "displayName" ) %></td>
                                <td><img src='images/profileBlank.png' /></td>
                            </tr>
                        </table></td>
                        </tr>
                        </table>
                   </div>
               </div>
            </div>
        </div>
    </header>
    <!-- ASIDE NAV AND CONTENT -->
    <div class='line'>
        <div class='box'>
            <div class='margin2x'>
                <!-- CONTENT -->
                <section class='s-12 m-4 l-9 right'>
                <center>
                <h3>Product Management</h3><br />
                <table style='width:100%'>
                <tr>
                    <td width='100%'><table width='100%'>
                    <tr valign='top'>
                        <td>Category:</td>
                        <td><select id='category' style='width:100%' onchange='HandleCategoryChange()'>
                            <option value=''>All categories</option>
                            <%
                                final String[] arrProductCategories = InventoryManagementSystem.Driver.ReadProductCategories();

                                if ( arrProductCategories != null )
                                {
                                    for ( int productIndex = 0; productIndex != arrProductCategories.length; ++productIndex )
                                    {
                                        final String productCategory = arrProductCategories [ productIndex ];
                                        out.println ( "                            <option value='" + productCategory + "'>" + productCategory + "</option>" );
                                    }
                                }
                            %>
                        </select></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr valign='top'>
                        <form onsubmit='return SearchByProductID()'>
                        <td>Product ID:</td>
                        <td><input type='text' id='productID' style='width:100%' required='required' /></td>
                        <td><input type='submit' class='buttons' value='Search' style='width:100%' /></td>
                        </form>
                        <form onsubmit='return SearchByProductName()'>
                        <td>Product Name:</td>
                        <td><input type='text' id='productName' style='width:100%' required='required' /></td>
                        <td><input type='submit' class='buttons' value='Search' style='width:100%' /></td>
                        </form>
                    </tr>
                    </table></td>
                </tr>
                <tr>
                    <td width='100%'><span id='spanInventory'><table style='width:100%' border='1'>
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
                        final String[] arrProductInformation = InventoryManagementSystem.Driver.ReadProductInformation ( null, null, null );

                        if ( arrProductInformation != null )
                        {
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
                    </table></span></td>
                </tr>
                </table>
                <input type='button' class='buttons' value='Add New Product' style='width:50%' onclick='document.getElementById("aAddNewProduct").click()' />
                </center>
                </section>
                <!-- ASIDE NAV -->
                <aside class='s-12 m-4 l-3'>
                    <div class='aside-nav minimize-on-small'>
                        <p class='aside-nav-text'>Sidebar navigation</p>
                        <jsp:include page='navigationSide.jsp' />
                    </div>
                </aside>
            </div>
        </div>
    </div>
    <a href='addNewProduct.jsp' id='aAddNewProduct' title='Add New Product' rel='gb_page_center[640,480]'></a>
    <jsp:include page='footer.jsp' />