<%@ page import="java.io.*,java.util.*,javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<jsp:declaration>
    static File file;
    static String status;
</jsp:declaration>
<%
    final int maxFileSize = 5000 * 1024;
    final int maxMemSize = 5000 * 1024;
    final ServletContext context = pageContext.getServletContext();
    final String filePath = context.getInitParameter ( "file-upload" );

    // Verify the content type
    final String contentType = request.getContentType();

    status = "Fail";

    if ( ( contentType.indexOf ( "multipart/form-data" ) >= 0 ) )
    {
        final DiskFileItemFactory factory = new DiskFileItemFactory();

        // maximum size that will be stored in memory
        factory.setSizeThreshold ( maxMemSize );
      
        // Location to save data that is larger than maxMemSize.
        factory.setRepository ( new File ( "c:\\temp" ) );

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload ( factory );
      
        // maximum file size to be uploaded.
        upload.setSizeMax ( maxFileSize );
      
        try
        {
            // Parse the request to get file items.
            final List fileItems = upload.parseRequest ( request );

            // Process the uploaded file items
            final Iterator i = fileItems.iterator();
         
            while ( i.hasNext () )
            {
                final FileItem fi = ( FileItem ) i.next();

                if ( !fi.isFormField () )
                {
                    Parcel_Tracking.Database.InitDatabase();

                    Parcel_Tracking.Data.databaseLocal.OpenDatabase();
                    final long oid = Parcel_Tracking.Data.databaseLocal.WriteLargeObject ( fi.getInputStream() );
                    Parcel_Tracking.Data.databaseLocal.Commit();
                    Parcel_Tracking.Data.databaseLocal.CloseDatabase();

                    status = "OK" + oid;
                }
            }
        }
        catch ( final Exception e )
        {
            out.println ( e );
        }
    }

    out.println ( status );
%>