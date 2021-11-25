<jsp:declaration>
    static String accountType;
    static long profilePicture;
</jsp:declaration>
<jsp:scriptlet>
    accountType = session.getAttribute ( "accountType" ).toString();

    if ( session.isNew() || session.getAttribute ( "username" ) == null || session.getAttribute ( "displayName" ) == null || session.getAttribute ( "email" ) == null ||
         session.getAttribute ( "profilePicture" ) == null || accountType == null || ( !accountType.equals ( "Retailer" ) && !accountType.equals ( "Administrator" ) ) )
    {
        response.sendRedirect ( "index.jsp" );
        return;
    }

    profilePicture = Long.parseLong ( session.getAttribute ( "profilePicture" ).toString() );
</jsp:scriptlet>
<jsp:include page='header.jsp' />
<script type='text/javascript'>
    var oid = <jsp:expression>profilePicture</jsp:expression>

    function handleFileSelect()
    {
        document.getElementById ( 'progressNumber' ).innerHTML = '0%'
        document.getElementById ( 'prog' ).value = 0

        var file = document.getElementById ( 'fileToUpload' ).files [ 0 ]

        if ( file )
        {
            if ( window.FileReader )
            {
                var reader = new FileReader()

                reader.onload = ( function ( theFile )
                {
                    return function ( e )
                    {
                        document.getElementById ( 'outputProfile' ).innerHTML = [ '<img src="', e.target.result,'" title="', theFile.name, '" width="100%" />' ].join ( '' )
                    }
                } ) ( file )

                reader.readAsDataURL ( file )
            }
        }
    }

    function uploadFile()
    {
        if ( document.getElementById ( 'fileToUpload' ).files.length == 0 )
        {
            alert ( 'Please select profile image first!' )
            return
        }

        var fd = new FormData()
        fd.append ( 'fileToUpload', document.getElementById ( 'fileToUpload' ).files [ 0 ] )

        var xhr = new XMLHttpRequest()
        xhr.upload.addEventListener ( "progress", uploadProgress, false )
        xhr.addEventListener ( "load", uploadComplete, false )
        xhr.addEventListener ( "error", uploadFailed, false )
        xhr.addEventListener ( "abort", uploadCanceled, false )
        xhr.open ( 'POST', 'processUploadProfile.jsp' )
        xhr.send ( fd )
    }

    function uploadProgress ( evt )
    {
        if ( evt.lengthComputable )
        {
            var percentComplete = Math.round ( evt.loaded * 100 / evt.total )
            document.getElementById ( 'progressNumber' ).innerHTML = percentComplete.toString() + '%'
            document.getElementById ( 'prog' ).value = percentComplete
        }
        else
        {
            document.getElementById ( 'progressNumber' ).innerHTML = 'Unable to compute progress!'
        }
    }

    function uploadComplete ( evt )
    {
        /* This event is raised when the server send back a response */
        var response = evt.target.responseText.trim()

        if ( response.startsWith ( 'OK' ) )
        {
            oid = response.substring ( 2 )

            var file = document.getElementById ( 'fileToUpload' ).files [ 0 ]

            document.getElementById ( 'progressNumber' ).innerHTML = '100%'
            document.getElementById ( 'prog' ).value = 100

            alert ( 'Image was uploaded successfully!' )
        }
        else
            alert ( evt.target.responseText )
    }

    function uploadFailed ( evt )
    {
        alert ( 'There was an error attempting to upload the file.' )
    }

    function uploadCanceled ( evt )
    {
        alert ( 'The upload has been canceled by the user or the browser dropped the connection.' )
    }

    function SaveProfile()
    {
        var displayName = document.getElementById ( 'displayName' ).value
        var email = document.getElementById ( 'email' ).value
        var password = document.getElementById ( 'password' ).value
        var retypePassword = document.getElementById ( 'retypePassword' ).value

        if ( password !== '' && password !== retypePassword )
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
                    alert ( 'Profile updated successfully to database!' )
                    location.reload ( true )
                }
                else if ( this.responseText === 'Not Found' )
                {
                    alert ( 'User not found in database!')
                    location.href = "logout.jsp"
                }
                else
                    alert ( this.responseText )
            }
        }

        xmlhttp.open ( 'POST', 'ajax_saveProfile.jsp', true )
        xmlhttp.setRequestHeader ( 'Content-type', 'application/x-www-form-urlencoded' )
        xmlhttp.send ( 'username=<%= session.getAttribute ( "username" ) %>&displayName=' + displayName + '&email=' + email + '&password=' + password + '&oldProfilePicture=<jsp:expression>profilePicture</jsp:expression>&profilePicture=' + oid )
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
                <section class='s-12 m-8 l-10 right'>
                <center>
                <h3>Edit Profile</h3>
                <form onsubmit='return SaveProfile()'>
                <table style='width:50%'>
                <tr valign='top'>
                    <td><span class='buttons' style='width:100%'>Profile Picture:</span></td>
                    <td><input type='file' name='fileToUpload[]' id='fileToUpload' onchange='handleFileSelect()' /><br />
                        <table width='100%'><tr><td width='85%'><progress id='prog' value='0' max='100.0' style='width:100%'></progress></td><td width='15%'><span id='progressNumber'></span></td></tr></table>
                <center><output id='outputProfile'><img src='<jsp:expression>( profilePicture != 0 ) ? "loadImage.jsp?oid=" + profilePicture : "images/profile.png"</jsp:expression>' width='100%' /></output></center><br />
                        <input type='button' class='buttons' onclick='uploadFile()' value='Upload Image' style='width:100%' /></td>
                </tr>
                <tr>
                    <td><span class='buttons' style='width:100%'>Display Name:</span></td>
                        <td><input type='text' id='displayName' value='<%= session.getAttribute ( "displayName" ) %>' style='width:100%' required='required' /></td>
                </tr>
                <tr>
                    <td><span class='buttons' style='width:100%'>E-mail:</span></td>
                        <td><input type='email' id='email' value='<%= session.getAttribute ( "email" ) %>' style='width:100%' required='required' /></td>
                </tr>
                <tr>
                    <td><span class='buttons' style='width:100%'>Change Password:</span></td>
                        <td><input type='password' id='password' style='width:100%' /></td>
                </tr>
                <tr>
                    <td><span class='buttons' style='width:100%'>Re-type Password:</span></td>
                        <td><input type='password' id='retypePassword' style='width:100%' /></td>
                </tr>
                <tr>
                    <td colspan='2'><input type='submit' value='Save' class='buttons' style='width:100%' /></td>
                </tr>
                </table>
                </form><br />
                </center>
                </section>
                <!-- ASIDE NAV -->
                <aside class='s-12 m-4 l-2'>
                    <div class='aside-nav minimize-on-small'>
                        <p class='aside-nav-text'>Sidebar navigation</p>
                        <jsp:include page='navigationSide.jsp' />
                    </div>
                </aside>
            </div>
        </div>
    </div>
    <jsp:include page='footer.jsp' />