<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.Vector" errorPage="" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.Date" errorPage="" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.text.SimpleDateFormat" errorPage="" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminInsertTicketStyle.css">
    <title>Insert Ticket</title>
</head>

<%@include file="process/connect.jsp" %>
<%@include file="process/model.jsp" %>

<%
    Vector<Airline> vectorAirline = new Vector<Airline>();
    Vector<CityName> vectorCity = new Vector<CityName>();

    String query_airline = "SELECT * FROM airline ORDER BY airline_name";
    String query_city = "SELECT * FROM city ORDER BY city_name";

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

    Date today = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String todayDate = sdf.format(today);
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
            <div id="contentHeaderText">Insert Ticket</div>
            <br>
            Insert new ticket for airlines
        </div>

        <form action="process/controller.jsp?src=insertTicket" method="POST">
            <div class="contentInsertTicket">

                <div class="componentContainer" id="airlineContainer">
                    <div class="insertText">Airline</div>
                    <div class="insertField">
                        <select name="insertAirline" id="">
                            <%
                                for(int i=0; i<vectorAirline.size(); i++){
                                    %>
                                        <option value="<%= vectorAirline.get(i).getAirline() %>"><%= vectorAirline.get(i).getAirline() %></option>
                                    <%
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="formLeft">
                    <div class="componentContainer">
                        <div class="insertText">From</div>
                        <div class="insertField">
                            <select name="insertFrom" id="">
                                <%
                                for(int i=0; i<vectorCity.size(); i++){
                                    %>
                                        <option value="<%= vectorCity.get(i).getCity() %>"><%= vectorCity.get(i).getCity() %></option>
                                    <%
                                    
                                    
                                }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="inner">
                        <div class="componentContainer">
                            <div class="insertText">Price Economy (Rp.)</div>
                            <div class="insertField">
                                <input type="text" name="insertPriceEco" id="" value="0">
                            </div>
                        </div>

                        <div class="componentContainer">
                            <div class="insertText">Price Business (Rp.)</div>
                            <div class="insertField">
                                <input type="text" name="insertPriceBusiness" id="" value="0">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="formRight">
                    <div class="componentContainer">
                        <div class="insertText">To</div>
                        <div class="insertField">
                            <select name="insertTo" id="">
                                <%
                                for(int i=0; i<vectorCity.size(); i++){
                                    %>
                                        <option value="<%= vectorCity.get(i).getCity() %>"><%= vectorCity.get(i).getCity() %></option>
                                    <%
                                }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="inner">
                         <div class="componentContainer">
                            <div class="insertText">Departure Date</div>
                            <div class="insertField">
                                <input type="text" name="insertDepartDate" id="" value="<%= todayDate %>">
                            </div>
                        </div>

                        <div class="componentContainer">
                            <div class="insertText">Available Seat</div>
                            <div class="insertField">
                                <input type="text" name="insertAvailableSeat" id="" value="0">
                            </div>
                        </div>
                    </div>
                </div>

                <div id="dummyDiv"></div>

                <div class="button">
                    <input type="submit" value="Insert Ticket" id="insertBtn">
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