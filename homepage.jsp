<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.Vector" errorPage="" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.Date" errorPage="" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.text.SimpleDateFormat" errorPage="" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/homePageStyle.css">
    <title>Main Page</title>
</head>

<%@include file="process/connect.jsp" %>
<%@include file="process/model.jsp" %>

<%
    //kalo logged in, ambil user_id nya dari database

    Vector<CityName> vectorCity = new Vector<CityName>();

    String query = "SELECT * FROM city ORDER BY city_name";
    ResultSet rs = st.executeQuery(query);

    while(rs.next()){
        vectorCity.add(new CityName(rs.getString("city_name")));
    }

    String userId = (String) session.getAttribute("userID");    
    int userIDint = 0;

    if(userId != null){
        userIDint = Integer.parseInt(userId);
    }

    Date today = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String todayDate = sdf.format(today);
%>
<body>

    <div class="header">
        <div class="headerText">The easiest way to find the cheapest ticket.</div>
        <span class="logInContainer">
            <%
                String name = (String) session.getAttribute("name");

                if(name == null){
                    %>
                    <span><a href="signIn.jsp">Sign In</a></span>
                    <span><a href="register.jsp">Register</a></span>
                    <%-- dummy dulu logout nya karena msh blm bisa handle kalo session nya abis, lgsg ke-logout --%>
                    <a href="process/doLogout.jsp">Logout</a>
                    <%
                }
                else{
                    int role = (Integer) session.getAttribute("role");
                    if(role == 1){
                        %>
                            <a href="adminUserList.jsp">Dashboard</a>
                        <%
                    }
                    
                    %>
                        <div><a href="trackOrder.jsp">Track Order</a></div>
                        <div class="usernameDisplay">
                            <%= name %>
                            <div class="headerMenuContent">
                                <a href="process/doLogout.jsp">Logout</a>
                            </div>
                        </div>
                    <%
                }
            %>
        </span>
    </div>

    <div class="content">
        <div class="contentHeader">
            <div id="contentHeaderText">Where are you going?</div>
            <br>
            Ticket anywhere only at TravelPortal
            <br>
            Booking is faster, easier and cheaper
            <hr>
        </div>


        <form action="search.jsp" method="GET">
            <input type="hidden" name="src" value="homePage">
            
            <%-- kalo 0, dia guest, kalo ga 0, dia member --%>
            <input type="hidden" name="memberId" value="<%= userIDint %>">

            <div class="contentForm">
                <div class="formHeader">Where are you going?</div>
                <div class="formPic"> <img src="assets/img/plane.png" alt="" height="100px" width="100px"> </div>

                <div class="formLeft">
                    <div class="formFrom">
                        <div class="formText">From</div>
                        <div class="formSelect">
                            <select name="homeFrom" id="fromHome">
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

                    <div class="departForm">
                        <div class="formText">Departure Date</div>
                        <div class="formSelect">
                            <input type="date" name="homeDate" id="" value="<%= todayDate %>">
                        </div>
                    </div>                    
                </div>

                <div class="formRight">
                    <div class="formTo">
                        <div class="formText">To</div>
                        <div class="formSelect">
                            <select name="homeTo" id="selectTo">
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

                    <div class="twoCol">
                        <div class="formPassengers">
                            <div class="formText">Passengers</div>
                            <div class="formSelect"> 
                                <select name="homePassengerQuantity" id="passengerHome">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                </select>
                            </div>
                        </div>

                        <div class="formClass">
                            <div class="formText">Cabin Class</div>
                            <div class="formSelect">
                                <select name="homeClass" id="classHome">
                                    <option value="Economy">Economy</option>
                                    <option value="Business">Business</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="button">
                        <input type="submit" value="Search Flight" id="searchBtn">
                    </div>

                </div>

            </div>
        </form>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <% if(application.getAttribute("online") == null) out.println("0"); else out.println(application.getAttribute("online"));%></div>
    
</body>
</html>