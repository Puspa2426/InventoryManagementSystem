<jsp:include page='header.jsp' />
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
        <script type='text/javascript'>
            function ForgetPassword()
            {
                var username = document.getElementById ( 'username' ).value

                // AJAX codes
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
                        if ( this.responseText.trim() === 'Success' )
                        {
                            alert ( 'Your password has been sent to your registered e-mail!' )
                            location.href = 'index.jsp'
                        }
                        else if ( this.responseText.trim() === 'Not Registered' )
                            alert ( 'Username not registered in system!' )
                        else
                            alert ( this.responseText )
                    }
                }

                xmlhttp.open ( 'POST', 'ajax_forgetPassword.jsp', true )
                xmlhttp.setRequestHeader ( 'Content-type', 'application/x-www-form-urlencoded' )
                xmlhttp.send ( 'username=' + username )

                return false
            }
        </script>
    </header>
    <!-- ASIDE NAV AND CONTENT -->
    <div class='line'>
        <div class='box'>
            <div class='margin2x'>
                <!-- CONTENT -->
                <section class='s-12 m-8 l-10 right'>
                <center>
                <img src='images/forgetPassword.png' style='width:40%' /><br />
                <img src='images/profile.png' /><br />
                <form onsubmit='return ForgetPassword()'>
                <table style='width:40%'>
                <tr>
                    <td><span class='buttons' style='width:100%'>Username:</span></td>
                        <td><input type='text' id='username' style='width:100%' required='required' /></td>
                </tr>
                <tr>
                    <td colspan='2'><br /></td>
                </tr>
                <tr>
                    <td>><input type='submit' value='Verify by E-mail' class='buttons' style='width:100%' /></td>
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