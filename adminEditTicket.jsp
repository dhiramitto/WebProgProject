<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminEditTicketStyle.css">
    <title>Update Ticket</title>
</head>

<%@include file="process/connect.jsp" %>
<%@include file="process/model.jsp" %>

<%
    String id = request.getParameter("id");

    if(id == null){
        response.sendRedirect("adminTicketList.jsp");
    }

    String query = "SELECT t.ticket_id, a.airline_name, cf.city_name AS 'from', ct.city_name AS 'to', t.depart_date, t.price_economy, t.price_business, t.seat  FROM ticket AS t INNER JOIN airline AS a ON t.airline_id=a.airline_id INNER JOIN city AS cf ON t.from_city_id=cf.city_id INNER JOIN city AS ct ON t.to_city_id=ct.city_id WHERE ticket_id = '"+ id +"'";
    ResultSet rs = st.executeQuery(query);

    String airline_db = "", from_db = "", to_db = "", departDate_db = "";
    int priceEco_db = 0, priceBusiness_db = 0, seat_db = 0;

    if(rs.next()){
        airline_db = rs.getString("airline_name");
        from_db = rs.getString("from");
        to_db = rs.getString("to");
        departDate_db = rs.getString("depart_date");
        priceEco_db = rs.getInt("price_economy");
        priceBusiness_db = rs.getInt("price_business");
        seat_db = rs.getInt("seat");
    }

    Vector<Airline> vectorAirline = new Vector<Airline>();
    Vector<CityName> vectorCity = new Vector<CityName>();

    String query_airline = "SELECT * FROM airline";
    String query_city = "SELECT * FROM city";

    Statement st_airline = con.createStatement();
    Statement st_city = con.createStatement();

    ResultSet rs_airline = st_airline.executeQuery(query_airline);
    ResultSet rs_city = st_city.executeQuery(query_city);

    while(rs_airline.next()){
        vectorAirline.add(new Airline(rs_airline.getString("airline_name")));
    }

    while(rs_city.next()){
        vectorCity.add(new CityName(rs_city.getString("city_name")));
    }
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
            <div id="contentHeaderText">Update Ticket</div>
            <br>
            Update ticket details
        </div>

        <form action="process/controller.jsp?src=editTicket&id=<%= id %>" method="POST">
            <div class="contentEditTicket">

                <div class="componentContainer" id="airlineContainer">
                    <div class="editText">Airline</div>
                    <div class="editField">
                        <select name="editAirline" id="">
                            <%
                                for(int i=0; i<vectorAirline.size(); i++){
                                    if(vectorAirline.get(i).getAirline().equals(airline_db)){
                                        %>
                                            <option value="<%= vectorAirline.get(i).getAirline() %>" selected><%= vectorAirline.get(i).getAirline() %></option>
                                        <%
                                    }
                                    else{
                                        %>
                                            <option value="<%= vectorAirline.get(i).getAirline() %>"><%= vectorAirline.get(i).getAirline() %></option>
                                        <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="formLeft">
                    <div class="componentContainer">
                        <div class="editText">From</div>
                        <div class="editField">
                            <select name="editFrom" id="">
                                <%
                                for(int i=0; i<vectorCity.size(); i++){
                                    if(vectorCity.get(i).getCity().equals(from_db)){
                                        %>
                                            <option value="<%= vectorCity.get(i).getCity() %>" selected><%= vectorCity.get(i).getCity() %></option>
                                        <%
                                    }
                                    else{
                                        %>
                                            <option value="<%= vectorCity.get(i).getCity() %>"><%= vectorCity.get(i).getCity() %></option>
                                        <%
                                    }
                                }
                                %>
                            </select>
                        </div>
                    </div>
                    
                    <div class="inner">
                        <div class="componentContainer">
                            <div class="editText">Price Economy (Rp.)</div>
                            <div class="editField">
                                <input type="text" name="editPriceEco" id="" value="<%= priceEco_db %>">
                            </div>
                        </div>

                        <div class="componentContainer">
                            <div class="editText">Price Business (Rp.)</div>
                            <div class="editField">
                                <input type="text" name="editPriceBusiness" id="" value="<%= priceBusiness_db %>">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="formRight">
                    <div class="componentContainer">
                        <div class="editText">To</div>
                        <div class="editField">
                            <select name="editTo" id="">
                                <%
                                for(int i=0; i<vectorCity.size(); i++){
                                    if(vectorCity.get(i).getCity().equals(to_db)){
                                        %>
                                            <option value="<%= vectorCity.get(i).getCity() %>" selected><%= vectorCity.get(i).getCity() %></option>
                                        <%
                                    }
                                    else{
                                        %>
                                            <option value="<%= vectorCity.get(i).getCity() %>"><%= vectorCity.get(i).getCity() %></option>
                                        <%
                                    }
                                }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="inner">
                         <div class="componentContainer">
                            <div class="editText">Departure Date</div>
                            <div class="editField">
                                <input type="date" name="editDepartDate" id="" value="<%= departDate_db %>">
                            </div>
                        </div>

                        <div class="componentContainer">
                            <div class="editText">Available Seat</div>
                            <div class="editField">
                                <input type="text" name="editAvailableSeat" id="" value="<%= seat_db %>">
                            </div>
                        </div>
                    </div>
                </div>

                <div id="dummyDiv"></div>

                <div class="button">
                    <input type="submit" value="Update Ticket" id="editBtn">
                </div>

                <div class="error">
                    <%
                    String error = request.getParameter("err");

                    if(error != null){
                        if(error.equals("1")){
                            out.println("Price and seat must be number");
                        }
                        else if(error.equals("2")){
                            out.println("Departure date must be minimum today");
                        }
                        else if(error.equals("3")){
                            out.println("All elements must be filled!");
                        }
                    }
                    %>
                </div>
            </div>
        </form>

    </div>
    
    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
    
</body>
</html>