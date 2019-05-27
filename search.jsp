<%@ page contentType="text/html; charset=utf-8" language="java" import="java.text.SimpleDateFormat" errorPage="" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.Date" errorPage="" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.Vector" errorPage="" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/searchStyle.css">
    <title>Search Result</title>
</head>

<%@ include file = "process/connect.jsp" %>
<%@ include file = "process/model.jsp" %>

<%
    String fromPage = request.getParameter("src");
    String pg = request.getParameter("page");

    /*
    src=homePage
    memberId=1 kalo 0, guest. kalo ga 0, dia member
    homeFrom=Bandung
    homeDate=2019-05-26
    homeTo=Bandung
    homePassengerQuantity=1
    classHome=Economy
    */

    int memberId = -1;
    String from = "";
    String to = "";
    String departDate = "";
    int qty = 0;
    String cabinClass = "";

    int data_per_page = 5;
    int start_data = 1;
    int total_data = 0;

    boolean isLoggedIn = true;
    boolean found = true;
    Vector<SearchResult> vectorResult = new Vector<SearchResult>();
    int curr_page = 0;


    if(fromPage!=null){
        try{

            if(pg == null || pg.equals("")) curr_page = 1;
            else curr_page = Integer.parseInt(pg);

            start_data = data_per_page * (curr_page-1);
            

            Date todayDate = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String today = formatter.format(todayDate); //untuk tau kapan order_date nya
            
            memberId = Integer.parseInt(request.getParameter("memberId"));
            from = request.getParameter("homeFrom");
            to = request.getParameter("homeTo");
            departDate = request.getParameter("homeDate");
            qty = Integer.parseInt(request.getParameter("homePassengerQuantity"));
            cabinClass = request.getParameter("homeClass");

            String query = "SELECT t.ticket_id, a.airline_name, cf.city_name AS 'from', ct.city_name AS 'to', t.depart_date, t.price_economy, t.price_business, t.seat  FROM ticket AS t INNER JOIN airline AS a ON t.airline_id=a.airline_id INNER JOIN city AS cf ON t.from_city_id=cf.city_id INNER JOIN city AS ct ON t.to_city_id=ct.city_id WHERE cf.city_name='"+ from +"' AND ct.city_name='"+ to +"' AND t.seat >= "+ qty +" AND t.depart_date LIKE '"+ departDate +"' LIMIT "+ start_data +", "+ data_per_page +"";
            ResultSet rs = st.executeQuery(query);

            if(!rs.next()){
                found = false;
            }
            else{
                found = true;
                rs.beforeFirst();
                while(rs.next()){
                    if(cabinClass.equals("Economy")) vectorResult.add(new SearchResult(rs.getInt("ticket_id"),rs.getString("airline_name"), rs.getString("from"), rs.getString("to"), rs.getInt("price_economy")));
                    else vectorResult.add(new SearchResult(rs.getInt("ticket_id"),rs.getString("airline_name"), rs.getString("from"), rs.getString("to"), rs.getInt("price_business")));
                }
            }

        }
        catch(Exception e){
            out.println(e);
        }
    }
    
%>

<body>
    <div class="header">
        <div class="home">
            <a href="homePage.jsp">Home</a>
        </div>
        <span class="logInContainer">
            <%
            String name = (String) session.getAttribute("name");

            if(name == null){
                isLoggedIn = false;
                %>
                <span><a href="signIn.jsp">Sign In</a></span>
                <span><a href="register.jsp">Register</a></span>
                <%
            }
            else{
                out.println(name);
            }
            %>
        </span>
    </div>
    
    <div class="content">
        <%
            try{
                String query_totalData = "SELECT COUNT(*) AS 'total_data', t.ticket_id, a.airline_name, cf.city_name AS 'from', ct.city_name AS 'to', t.depart_date, t.price_economy, t.price_business, t.seat  FROM ticket AS t INNER JOIN airline AS a ON t.airline_id=a.airline_id INNER JOIN city AS cf ON t.from_city_id=cf.city_id INNER JOIN city AS ct ON t.to_city_id=ct.city_id WHERE cf.city_name='"+ from +"' AND ct.city_name='"+ to +"' AND t.seat >= "+ qty +" AND t.depart_date LIKE '"+ departDate +"'";
                Statement stTotalData = con.createStatement();
                ResultSet rsTotalData = stTotalData.executeQuery(query_totalData);
                
                if(rsTotalData.next()){
                    total_data = rsTotalData.getInt("total_data");
                }


                if(!found) out.println("Ticket not found");
                else{
                    for(int i=0; i<vectorResult.size(); i++){
                        %>
                            <div class="searchResult">
                                <table>
                                    <tr>
                                        <th>Airline</th>
                                        <th>From</th>
                                        <th>To</th>
                                        <th>Price</th>
                                        <td rowspan="2" class="buttonContainer">
                                        <%-- purchase details --%>
                                        <%
                                        if(isLoggedIn){
                                            %>
                                            <%-- kirim tanggal hari ini, ticket_id --%>
                                            <form action="purchaseDetail.jsp" method="GET">
                                            <input type="hidden" name="id" value="<%= vectorResult.get(i).getTicketId() %>">
                                            <input type="hidden" name="qty" value=<%= qty %>>
                                            <input type="hidden" name="price" value=<%= vectorResult.get(i).getPrice() %>>
                                            <input type="hidden" name="cabinClass" value="<%= cabinClass %>">
                                            <button id="purchaseBtn">+</button>
                                            </form>
                                            <%
                                            }
                                            %>
                                        </td> 
                                    </tr>
                                    
                                    <tr>
                                        <td><%= vectorResult.get(i).getAirline() %></td>
                                        <td><%= vectorResult.get(i).getFrom() %></td>
                                        <td><%= vectorResult.get(i).getTo() %></td>
                                        <td>Rp. <%= vectorResult.get(i).getPrice() %></td>
                                    </tr>
                                </table>
                            </div>
                        <%
                    }
                }                
            }
            catch(Exception e){
                out.println(e);
            }
        %>
    </div>
    <div class="pagination">
        <%
            /*
                memberId = Integer.parseInt(request.getParameter("memberId"));
                from = request.getParameter("homeFrom");
                to = request.getParameter("homeTo");
                departDate = request.getParameter("homeDate");
                qty = Integer.parseInt(request.getParameter("homePassengerQuantity"));
                cabinClass = request.getParameter("homeClass");

                parameternya:
                memberId=1 kalo 0, guest. kalo ga 0, dia member
                homeFrom=Bandung
                homeDate=2019-05-26
                homeTo=Bandung
                homePassengerQuantity=1
                homeClass=Economy
            */
            
            for(int i = 0; i <= total_data / data_per_page; i++){
            %> 
                <a href="search.jsp?src=homePage&page=<%=i+1%>&memberId=<%= memberId %>&homeFrom=<%= from %>&homeDate=<%= departDate %>&homeTo=<%= to %>&homePassengerQuantity=<%= qty %>&homeClass=<%= cabinClass %>"><%= i+1%></a>
            <%
            }
        %>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
    
</body>
</html>