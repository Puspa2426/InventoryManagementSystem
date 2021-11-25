<jsp:include page='header.jsp' />
<script type='text/javascript'>
    function Register()
    {
        var username = document.getElementById ( 'username' ).value
        var displayName = document.getElementById ( 'displayName' ).value
        var email = document.getElementById ( 'email' ).value
        var password = document.getElementById ( 'password' ).value
        var retypePassword = document.getElementById ( 'retypePassword' ).value

        if ( password !== retypePassword )
        {
            alert ( 'The Password and Retype Password fields do not match!' )
            return false
        }

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
                    alert ( 'User registered successfully!' )
                    
                    document.getElementById('username').value = ''
                    document.getElementById('displayName').value = ''
                    document.getElementById('email').value = ''
                    document.getElementById('password').value = ''
                    document.getElementById('retypePassword').value = ''

                    location.href = 'index.jsp'
                }
                else if ( this.responseText === 'Duplicate' )
                    alert ( 'This username already exist in the database... please select a different username!')
                else
                    alert ( this.responseText )
            }
        }

        xmlhttp.open ( 'POST', 'ajax_register.jsp', true )
        xmlhttp.setRequestHeader ( 'Content-type', 'application/x-www-form-urlencoded' )
        xmlhttp.send ( 'username=' + username + '&displayName=' + displayName + '&email=' + email + '&password=' + password )
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
                <img src='images/register.png' style='width:40%' /><br />
                <img src='images/profile.png' /><br />
                <form onsubmit='return Register()'>
                <table style='width:60%'>
                <tr>
                    <td><span class='buttons' style='width:100%'>Username:</span></td>
                        <td><input type='text' id='username' style='width:100%' required='required' /></td>
                </tr>
                <tr>
                    <td><span class='buttons' style='width:100%'>Display Name:</span></td>
                        <td><input type='text' id='displayName' style='width:100%' required='required' /></td>
                </tr>
                <tr>
                    <td><span class='buttons' style='width:100%'>E-mail:</span></td>
                        <td><input type='email' id='email' style='width:100%' required='required' /></td>
                </tr>
                <tr valign='top'>
                    <td><span class='buttons' style='width:100%'>Password:<br />(Min 8 characters with upperCase,<br />lowerCase and number/special characters)</span></td>
                        <td><input type='password' id='password' pattern='(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$' style='width:100%' required='required' /></td>
                </tr>
                <tr>
                    <td><span class='buttons' style='width:100%'>Retype Password:</span></td>
                        <td><input type='password' id='retypePassword' style='width:100%' required='required' /></td>
                </tr>
                <tr>
                    <td colspan='2'><br /></td>
                </tr>
                <tr>
                    <td colspan='2'><input type='submit' value='Register' class='buttons' style='width:100%' /></td>
                </tr>
                </table><br /><br />
                </form>
                <input type='button' value='Back' class='buttons' style='float:right;width:150px' onclick='location.href="index.jsp"' />
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