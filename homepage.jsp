<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/homePageStyle.css">
    <title>Main Page</title>
</head>
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
                    <%
                }
                else{
                    %>
                        <div class="usernameDisplay">
                            <%= name %>
                            <div class="headerMenuContent">
                                <%
                                    int role = (Integer) session.getAttribute("role");

                                    if(role == 1){
                                        %>
                                            <a href="adminUserList.jsp">Dashboard</a>
                                        <%
                                    }
                                %>
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


        <form action="">
            <div class="contentForm">
                <div class="formHeader">Where are you going?</div>
                <div class="formPic"> <img src="assets/img/plane.png" alt="" height="100px" width="100px"> </div>

                <div class="formLeft">
                    <div class="formFrom">
                        <div class="formText">From</div>
                        <div class="formSelect">
                            <select name="fromHome" id="fromHome">
                                <option value="Jakarta">Jakarta</option>
                                <option value="Bandung">Bandung</option>
                                <option value="Semarang">Semarang</option>
                            </select>
                        </div>
                    </div>

                    <div class="departForm">
                        <div class="formText">Departure Date</div>
                        <div class="formSelect">
                            <select name="departHome" id="departHome">
                                <option value="1">Date1</option>
                                <option value="2">Date2</option>
                                <option value="3">Date3</option>
                            </select>
                        </div>
                    </div>                    
                </div>

                <div class="formRight">
                    <div class="formTo">
                        <div class="formText">To</div>
                        <div class="formSelect">
                            <select name="selectTo" id="selectTo">
                                <option value="Jakarta">Jakarta</option>
                                <option value="Bandung">Bandung</option>
                                <option value="Semarang">Semarang</option>
                            </select>
                        </div>
                    </div>

                    <div class="twoCol">
                        <div class="formPassengers">
                            <div class="formText">Passengers</div>
                            <div class="formSelect"> 
                                <select name="passengerHome" id="passengerHome">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>
                            </div>
                        </div>

                        <div class="formClass">
                            <div class="formText">Cabin Class</div>
                            <div class="formSelect">
                                <select name="classHome" id="classHome">
                                    <option value="Economy">Economy</option>
                                    <option value="Business">Business</option>
                                    <option value="Executive">Executive</option>
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