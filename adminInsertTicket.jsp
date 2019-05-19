<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminInsertTicketStyle.css">
    <title>Insert Ticket</title>
</head>
<body>

    <div class="header">
        <div class="headerMenu">
            <%@include file="includes/adminPages/adminHeaderMenu.jsp" %>
        </div>
        <div class="usernameDisplay">Pablo Picasso</div>
    </div>
    
    <div class="content">
        <div class="contentHeader">
            <div id="contentHeaderText">Insert Ticket</div>
            <br>
            Insert new ticket for airlines
        </div>

        <form action="">
            <div class="contentInsertTicket">

                <div class="componentContainer" id="airlineContainer">
                    <div class="insertText">Airline</div>
                    <div class="insertField">
                        <select name="insertAirline" id="">
                            <option value="sriwijaya">Sriwijaya Airline</option>
                            <option value="garuda">Garuda Airline</option>
                        </select>
                    </div>
                </div>

                <div class="formLeft">
                    <div class="componentContainer">
                        <div class="insertText">From</div>
                        <div class="insertField">
                            <select name="insertFrom" id="">
                                <option value="jakarta">Jakarta</option>
                                <option value="bali">Bali</option>
                            </select>
                        </div>
                    </div>

                    <div class="inner">
                        <div class="componentContainer">
                            <div class="insertText">Price Economy (Rp.)</div>
                            <div class="insertField">
                                <input type="text" name="insertPriceEco" id="">
                            </div>
                        </div>

                        <div class="componentContainer">
                            <div class="insertText">Price Business (Rp.)</div>
                            <div class="insertField">
                                <input type="text" name="insertPriceBusiness" id="">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="formRight">
                    <div class="componentContainer">
                        <div class="insertText">To</div>
                        <div class="insertField">
                            <select name="insertTo" id="">
                                <option value="jakarta">Jakarta</option>
                                <option value="bali">Bali</option>
                            </select>
                        </div>
                    </div>

                    <div class="inner">
                         <div class="componentContainer">
                            <div class="insertText">Departure Date</div>
                            <div class="insertField">
                                <input type="text" name="insertDepartDate" id="">
                            </div>
                        </div>

                        <div class="componentContainer">
                            <div class="insertText">Available Seat</div>
                            <div class="insertField">
                                <input type="text" name="insertAvailableSeat" id="">
                            </div>
                        </div>
                    </div>
                </div>

                <div id="dummyDiv"></div>

                <div class="button">
                    <input type="submit" value="Insert Ticket" id="insertBtn">
                </div>
            </div>
        </form>

    </div>
    
    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: 0</div>
    
</body>
</html>