<%@page import='java.util.Properties' %>
<%@page import='javax.mail.Message' %>
<%@page import='javax.mail.Session' %>
<%@page import='javax.mail.Transport' %>
<%@page import='javax.mail.internet.InternetAddress' %>
<%@page import='javax.mail.internet.MimeMessage' %>
<%
    final String username = request.getParameter ( "username" );

    Parcel_Tracking.Database.InitDatabase();

    final String result = InventoryManagementSystem.Driver.RetrieveEmailPassword ( username );

    if ( result.startsWith ( "Success" ) )
    {
        final String[] fields = result.substring ( 7 ).split ( "`" );

        final String email = fields [ 0 ];
        final String userPassword = fields [ 1 ];

        final String host = "smtp.gmail.com";
 
        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
        final String subject = "Your Parcel Tracking System password", messageText = "Your password for Parcel Tracking System is <b>" + userPassword + "</b>.";

        final String from = "parcel.tracking.system.2020@gmail.com";
        final String password = "pts2020Admin";

        final boolean sessionDebug = false;

        final Properties props = System.getProperties(); 

        props.put ( "mail.host", host );
        props.put ( "mail.transport.protocol.", "smtp" );
        props.put ( "mail.smtp.auth", "true" );
        props.put ( "mail.smtp.", "true" );
        props.put ( "mail.smtp.port", "465" );
        props.put ( "mail.smtp.socketFactory.fallback", "false" );
        props.put ( "mail.smtp.socketFactory.class", SSL_FACTORY );
        props.put ( "mail.smtp.ssl.trust", "*" );

        final Session mailSession = Session.getDefaultInstance ( props, null );
        mailSession.setDebug ( sessionDebug );

        final Message msg = new MimeMessage ( mailSession ); 
        msg.setFrom ( new InternetAddress ( from ) );

        final InternetAddress[] address = { new InternetAddress ( email ) };

        msg.setRecipients ( Message.RecipientType.TO, address );
        msg.setSubject ( subject );
        msg.setContent ( messageText, "text/html" ); // use setText if you want to send text

        final Transport transport = mailSession.getTransport ( "smtp" );
        System.setProperty ( "javax.net.ssl.trustStore", "conf/jssecacerts" );
        System.setProperty ( "javax.net.ssl.trustStorePassword", "changeit" );
        transport.connect ( host, from, password );

        try
        {
            transport.sendMessage ( msg, msg.getAllRecipients() );
            out.print ( "Success" );
        }
        catch ( final Exception err )
        {
            out.print ( "Error" + err.getMessage() );
        }

        transport.close();
    }
    else if ( result.isEmpty() )
        out.print ( "Not Registered" );
    else
        out.print ( result );
%>