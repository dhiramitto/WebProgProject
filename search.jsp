<%@ page contentType="text/html; charset=utf-8" language="java" import="java.text.SimpleDateFormat" errorPage="" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.Date" errorPage="" %>

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

    if(fromPage!=null){
        try{
            String pg = request.getParameter("page");
            
            int curr_page = 1;
            
            start_data = data_per_page * (curr_page-1);

            if (pg == "" || pg == null) curr_page = 1;
            else curr_page = Integer.parseInt(pg);
            

            //Vector<SearchResult> vectorResult = new Vector<SearchResult>();

            Date todayDate = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String today = formatter.format(todayDate); //untuk tau kapan order_date nya
            
            memberId = Integer.parseInt(request.getParameter("memberId"));
            from = request.getParameter("homeFrom");
            to = request.getParameter("homeTo");
            departDate = request.getParameter("homeDate");
            qty = Integer.parseInt(request.getParameter("homePassengerQuantity"));
            cabinClass = request.getParameter("homeClass");
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
            <%@include file="includes/usernameDisplay.jsp" %>
        </span>
    </div>
    
    <div class="content">
        <%
            try{
                String query_totalData = "SELECT COUNT(*) AS 'total_data' FROM ticket";
                Statement stTotalData = con.createStatement();
                ResultSet rsTotalData = stTotalData.executeQuery(query_totalData);
                if(rsTotalData.next()){
                    String count = (String) rsTotalData.getString("total_data");
                    total_data = Integer.parseInt(count);
                }
                
                String query = "SELECT t.ticket_id, a.airline_name, cf.city_name AS 'from', ct.city_name AS 'to', t.depart_date, t.price_economy, t.price_business, t.seat  FROM ticket AS t INNER JOIN airline AS a ON t.airline_id=a.airline_id INNER JOIN city AS cf ON t.from_city_id=cf.city_id INNER JOIN city AS ct ON t.to_city_id=ct.city_id WHERE cf.city_name='"+ from +"' AND ct.city_name='"+ to +"' LIMIT "+ start_data +", "+ data_per_page +"";
                ResultSet rs = st.executeQuery(query);

                if(!rs.next()){
                    out.println("No ticket found");
                }
                else{
                    rs.beforeFirst();
                    while(rs.next()){
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
                                        <form action="">
                                            <button id="purchaseBtn">+</button>
                                        </form>
                                    </td> 
                                </tr>
                                <tr>
                                    <td><%= rs.getString("airline_name") %></td>
                                    <td><%= rs.getString("from") %></td>
                                    <td><%= rs.getString("to") %></td>
                                    <%
                                        if(cabinClass.equals("Economy")){
                                            %>
                                                <td><%= rs.getInt("price_economy") %></td>
                                            <%
                                        }
                                        else if(cabinClass.equals("Business")){
                                            %>
                                                <td><%= rs.getInt("price_business") %></td>
                                            <%
                                        }
                                    %>
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
            
            for(int i = 0; i < total_data / data_per_page; i++){
            %> 
                <a href="search.jsp?page=<%=i+1%>"><%= i+1%></a>
            <%
            }
        %>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
    
</body>
</html>