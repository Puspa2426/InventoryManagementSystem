<jsp:scriptlet>
    session.invalidate();

    response.sendRedirect ( "index.jsp" );
</jsp:scriptlet>