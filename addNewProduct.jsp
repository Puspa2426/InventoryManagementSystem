<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.1//EN' 'http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd'>
<html xmlns='http://www.w3.org/1999/xhtml' lang='en-MY'>
<head>
<meta name='viewport' content='width=device-width, initial-scale=1.0' />
<title>Add New Product</title>
<script src='js/jquery-1.8.3.min.js'></script>
<script src='js/jquery-ui.min.js'></script>
<script src='js/canvasjs.min.js'></script>
<style>
    .links:hover { color: red }

    .buttons
    {
            display: inline-block;
            padding: 5px 5px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #fff;
            background-color: blue;
            border: none;
            border-radius: 9px;
            box-shadow: 0 3px #333; 
    }

    .buttons:hover { background-color: #3e8e41 }

    .buttons:active
    {
      background-color:#333;
      box-shadow: 0 5px #666;
      transform: translateY ( 4px );
    }
</style>
<script type='text/javascript'>
    function AddProduct()
    {
        var productID = document.getElementById ( 'productID' ).value
        var productName = document.getElementById ( 'productName' ).value

        var categoryEl = document.getElementById ( 'category' )
        var category = categoryEl.options [ categoryEl.selectedIndex ].value

        var price = document.getElementById ( 'price' ).value
        var quantity = document.getElementById ( 'quantity' ).value

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
                    alert ( 'Product added successfully to database!' )
                    parent.parent.location.reload ( true )
                }
                else
                    alert ( this.responseText )
            }
        }

        xmlhttp.open ( 'POST', 'ajax_addProduct.jsp', true )
        xmlhttp.setRequestHeader ( 'Content-type', 'application/x-www-form-urlencoded' )
        xmlhttp.send ( 'productID=' + productID + '&productName=' + productName + '&category=' + category + '&quantity=' + quantity + '&price=' + price )

        return false
    }
</script>
</head>
<body class='size-1280'>
    <!-- ASIDE NAV AND CONTENT -->
    <div class='line'>
        <div class='box'>
            <div class='margin2x'>
                <!-- CONTENT -->
                <section class='s-12 m-8 l-10 right'>
                <center>
                    <h3>Add New Product</h3>
                    <form onsubmit='return AddProduct()'>
                    <table width='50%'>
                    <tr>
                        <td>Product ID:</td>
                        <td><input type='text' id='productID' style='width:100%' required='required' /></td>
                    </tr>
                    <tr>
                        <td colspan='2'><br /></td>
                    </tr>
                    <tr>
                        <td>Product Name:</td>
                        <td><input type='text' id='productName' style='width:100%' required='required' /></td>
                    </tr>
                    <tr>
                        <td colspan='2'><br /></td>
                    </tr>
                    <tr>
                        <td>Category:</td>
                        <td><select id='category' style='width:100%' required='required'>
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
                    </tr>
                    <tr>
                        <td colspan='2'><br /></td>
                    </tr>
                    <tr>
                        <td>Price (RM):</td>
                        <td><input type='number' id='price' step='0.01' style='width:100%' required='required' /></td>
                    </tr>
                    <tr>
                        <td colspan='2'><br /></td>
                    </tr>
                    <tr>
                        <td>Initial Quantity:</td>
                        <td><input type='number' id='quantity' style='width:100%' required='required' /></td>
                    </tr>
                    <tr>
                        <td colspan='2'><br /></td>
                    </tr>
                    <tr>
                        <td colspan='2'><input type='submit' class='buttons' value='Add Product' />&nbsp;<input type='button' class='buttons' value='Cancel' onclick='parent.parent.GB_hide()' /></td>
                    </tr>
                    </table>
                    </form>
                </center>
                </section>
            </div>
        </div>
    </div>
</body>
</html>