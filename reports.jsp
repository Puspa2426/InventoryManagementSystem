<%@page import='java.util.Date' %>
<%@page import='java.text.SimpleDateFormat' %>
<jsp:declaration>
    static int MAX_ITEMS_IN_GRAPH;
</jsp:declaration>
<jsp:scriptlet>
    if ( session.isNew() || session.getAttribute ( "username" ) == null || session.getAttribute ( "displayName" ) == null || session.getAttribute ( "email" ) == null ||
         session.getAttribute ( "profilePicture" ) == null || session.getAttribute ( "accountType" ) == null || !session.getAttribute ( "accountType" ).toString().equals ( "Retailer" ) )
    {
        response.sendRedirect ( "index.jsp" );
        return;
    }
    final String accountType = session.getAttribute ( "accountType" ).toString();

    final Date now = new Date();
    final SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd" );
    final SimpleDateFormat timeFormat = new SimpleDateFormat ( "HH:mm" );

    MAX_ITEMS_IN_GRAPH = 10;
</jsp:scriptlet>
<jsp:include page='header.jsp' />
<body class='size-1280'>
    <!-- HEADER -->
    <header>
    <script type='text/javascript'>
    function GenerateReportTable()
    {
        document.getElementById ( 'spanContent' ).innerHTML = "\
                        <table style='width:100%' border='1'>\
                        <tr align='center'>\
                            <th>No</th>\
                            <th>Item ID</th>\
                            <th>Item Name</th>\
                            <th>Category</th>\
                            <th>Quantity</th>\
                            <th>Price (RM)</th>\
                        </tr>\
                        <tr align='center'>\
                            <td>1</td>\
                            <td>BK111</td>\
                            <td>C Programming</td>\
                            <td>Books</td>\
                            <td>9</td>\
                            <td>112.90</td>\
                        </tr>\
                        <tr align='center'>\
                            <td>2</td>\
                            <td>CL111</td>\
                            <td>T-shirt</td>\
                            <td>Clothes</td>\
                            <td>5</td>\
                            <td>32.70</td>\
                        </tr>\
                        <tr>\
                        <td colspan='6'><center><input type='button' class='buttons' value='Print' style='width:100%' onclick='window.print()' /></center></td>\
                        </tr>\
                        </table>"
    }

    function GenerateReportGraph()
    {
        document.getElementById ( 'aGenerateReportGraph' ).click()
    }
    </script>
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
                <!--<img src='images/newParcelTrackingEntry.png' style='width:40%' /><br />-->
                <table style='width:100%'>
                <tr>
                    <td width='100%'><table width='100%'>
                    <tr valign='top'>
                        <td>Start Date:</td>
                        <td><input type='date' value='<jsp:expression>dateFormat.format ( now )</jsp:expression>' style='width:100%' /></td>
                        <td>End Date:</td>
                        <td><input type='date' value='<jsp:expression>dateFormat.format ( now )</jsp:expression>' style='width:100%' /></td>
                    </tr>
                    <tr valign='top'>
                        <td>Category:</td>
                        <td><select id='category' style='width:100%'>
                            <option value=''>All categories</option>
                            <option value='Books'>Books</option>
                            <option value='Clothes'>Clothes</option>
                        </select></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr valign='top'>
                        <td>Item Name:</td>
                        <td><input type='text' style='width:100%' /></td>
                        <td>Item ID:</td>
                        <td><input type='text' style='width:100%' /></td>
                    </tr>
                    <tr>
                        <td colspan='2'><input type='button' class='buttons' value='Generate Report (Table)' style='width:49%' onclick='GenerateReportTable()' /><input type='button' class='buttons' value='Generate Report (Graph)' style='width:49%;float:right' onclick='GenerateReportGraph()' /></td>
                        <td colspan='2'><input type='button' class='buttons' value='Generate Report (Table)' style='width:49%' onclick='GenerateReportTable()' /><input type='button' class='buttons' value='Generate Report (Graph)' style='width:49%;float:right' onclick='GenerateReportGraph()' /></td>
                    </tr>
                    </table></td>
                </tr>
                <tr>
                    <td width='100%'><span id='spanContent'></span></td>
                </tr>
                </table>
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
    <a href='generateReportGraph.html' id='aGenerateReportGraph' title='Sales Report' rel='gb_page_center[640,480]'></a>
    <jsp:include page='footer.jsp' />