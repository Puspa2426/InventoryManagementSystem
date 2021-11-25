<jsp:include page='header.jsp' />
<script type='text/javascript'>
function Login()
{
    var username = document.getElementById ( 'username' ).value
    var password = document.getElementById ( 'password' ).value

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
            if ( this.responseText.startsWith ( 'Success' ) )
            {
                var fields = this.responseText.split ( '`' )

                if ( fields.length == 2 )
                {
                    var accountType = fields [ 1 ]

                    switch ( accountType )
                    {
                        case 'Retailer':
                        case 'Administrator':
                            location.href = 'viewInventory.jsp'
                            break

                        default:
                            alert ( 'Unknown account type... please contact the administrator for assistance!' )
                            break
                    }
                }
                else
                    alert ( 'Unknown response... please try relogin again!' )
            }
            else if ( this.responseText === 'Invalid' )
                alert ( 'Invalid username and/or password entered!' )
            else
                alert ( this.responseText )
        }
    }

    xmlhttp.open ( 'POST', 'ajax_login.jsp', true )
    xmlhttp.setRequestHeader ( 'Content-type', 'application/x-www-form-urlencoded' )
    xmlhttp.send ( 'username=' + username + '&password=' + password )
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
                            <td width='30%'>&nbsp;</td>
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
                <section class='s-12 m-8 l-10 right'>
                <center>
                <img src='images/login.png' style='width:40%' /><br />
                <img src='images/profile.png' /><br />
                <form onsubmit='return Login()'>
                <table style='width:40%'>
                <tr>
                    <td><span class='buttons' style='width:100%'>Username:</span></td>
                        <td><input type='text' id='username' style='width:100%' required='required' /></td>
                </tr>
                <tr>
                    <td><span class='buttons' style='width:100%'>Password:</span></td>
                        <td><input type='password' id='password' style='width:100%' required='required' /></td>
                </tr>
                <tr>
                    <td colspan='2'><br /></td>
                </tr>
                <tr>
                    <td colspan='2'><input type='submit' value='Login' class='buttons' style='width:100%' /></td>
                </tr>
                </table><br />
                <table style='width:40%'>
                <tr>
                    <td width='50%'><input type='button' value='Forget Password' class='buttons' style='width:100%' onclick='location.href="forgetPassword.jsp"' /></td>
                    <td width='50%'><input type='button' value='Register' class='buttons' style='width:100%' onclick='location.href="register.jsp"' /></td>
                </tr>
                </table>
                </form>
                </center>
                </section>
                <!-- ASIDE NAV -->
                <aside class='s-12 m-4 l-2'>
                    <div class='aside-nav minimize-on-small'>
                        <p class='aside-nav-text'>Sidebar navigation</p>
                        <jsp:include page='navigationSidePreLogin.html' />
                    </div>
                </aside>
            </div>
        </div>
    </div>
    <jsp:include page='footer.jsp' />