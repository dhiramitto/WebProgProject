<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminTicketListStyle.css">
    <title>Ticket List</title>
</head>

<%@include file="process/connect.jsp" %>
<%@include file="process/model.jsp" %>

<%
    Vector<Ticket> vectorTicket = new Vector<Ticket>();
%>

<body>
    <div class="header">
        <div class="headerMenu">
            <%@include file="includes/adminPages/adminHeaderMenu.jsp" %>
        </div>
        <%@include file="includes/usernameDisplay.jsp" %>
    </div>

    <div class="content">
        <div class="contentHeader">
            <div id="contentHeaderText">Tickets</div>
            <br>
            Ticket lists
        </div>

        <%
            String query = "SELECT t.ticket_id, a.airline_name, cf.city_name AS 'from', ct.city_name AS 'to', t.depart_date, t.price_economy, t.price_business, t.seat  FROM ticket AS t INNER JOIN airline AS a ON t.airline_id=a.airline_id INNER JOIN city AS cf ON t.from_city_id=cf.city_id INNER JOIN city AS ct ON t.to_city_id=ct.city_id";

            ResultSet rs = st.executeQuery(query);

            while(rs.next()){
                vectorTicket.add(new Ticket(rs.getInt("ticket_id"), rs.getString("airline_name"), rs.getString("from"), rs.getString("to"), rs.getString("depart_date"), rs.getInt("price_economy"), rs.getInt("price_business"), rs.getInt("seat")));
            }
        %>

        <div class="contentTable">
            <table>
                <tr>
                    <th rowspan="2">Airline</th>
                    <th rowspan="2">From</th>
                    <th rowspan="2">To</th>
                    <th rowspan="2">Departure Date</th>
                    <th colspan="2">Price</th>
                    <th rowspan="2">Seat</th>
                    <th rowspan="2">Action</th>
                </tr>

                <tr>
                    <th>Economy</th>
                    <th>Business</th>
                </tr>

                <%
                    for(int i=0; i<vectorTicket.size(); i++){
                        %>
                        <tr>
                            <td><%= vectorTicket.get(i).getAirline() %></td>
                            <td><%= vectorTicket.get(i).getFrom() %></td>
                            <td><%= vectorTicket.get(i).getTo() %></td>
                            <td><%= vectorTicket.get(i).getDepartDate() %></td>
                            <td>Rp. <%= vectorTicket.get(i).getPriceEco() %></td>
                            <td>Rp. <%= vectorTicket.get(i).getPriceBusiness() %></td>
                            <td><%= vectorTicket.get(i).getSeat() %></td>
                            <td width=200px>
                                <a href="adminEditTicket.jsp?id=<%= vectorTicket.get(i).getId() %>"><button class="modifyButtons" id="editBtn">Edit</button></a>
                                <a href="process/controller.jsp?src=deleteTicket&id=<%= vectorTicket.get(i).getId() %>"><button class="modifyButtons" id="deleteBtn">Delete</button></a>
                            </td>
                        </tr>
                        <%
                    }
                %>
                <tr id="insertTicket">
                    <td colspan="7"></td>
                    <td>
                        <a href="adminInsertTicket.jsp"><button id="insertBtn">Insert Ticket</button></a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
</body>
</html>