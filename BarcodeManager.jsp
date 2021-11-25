<%@page import='java.awt.image.BufferedImage' %>
<%@page import='java.io.ByteArrayOutputStream' %>
<%@page import='java.io.IOException' %>
<%@page import='javax.servlet.ServletException' %>
<%@page import='javax.servlet.ServletOutputStream' %>
<%@page import='javax.servlet.annotation.WebServlet' %>
<%@page import='javax.servlet.http.HttpServlet' %>
<%@page import='javax.servlet.http.HttpServletRequest' %>
<%@page import='javax.servlet.http.HttpServletResponse' %>
<%@page import='org.krysalis.barcode4j.impl.code128.Code128Bean' %>
<%@page import='org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider' %>
<jsp:scriptlet>
    final String value = request.getParameter ( "barcode" );
    response.setContentType ( "image/jpg" );

    final Code128Bean code128 = new Code128Bean();
    code128.setHeight ( 15f );
    code128.setModuleWidth ( 0.3 );
    code128.setQuietZone ( 10 );
    code128.doQuietZone ( true );
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    BitmapCanvasProvider canvas = new BitmapCanvasProvider ( baos, "image/x-png", 300, BufferedImage.TYPE_BYTE_BINARY, false, 0 );
    code128.generateBarcode ( canvas, value );
    canvas.finish();

    final ServletOutputStream responseOutputStream = response.getOutputStream();
    responseOutputStream.write ( baos.toByteArray() );
    responseOutputStream.flush();
    responseOutputStream.close();
</jsp:scriptlet>