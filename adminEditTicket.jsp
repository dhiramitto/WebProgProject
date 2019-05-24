<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminEditTicketStyle.css">
    <title>Update Ticket</title>
</head>
<body>

    <div class="header">
        <div class="headerMenu">
            <%@include file="includes/adminPages/adminHeaderMenu.jsp" %>
        </div>
        <%@include file = "includes/usernameDisplay.jsp" %>
    </div>
    
    <div class="content">
        <div class="contentHeader">
            <div id="contentHeaderText">Update Ticket</div>
            <br>
            Update ticket details
        </div>

        <form action="">
            <div class="contentEditTicket">

                <div class="componentContainer" id="airlineContainer">
                    <div class="editText">Airline</div>
                    <div class="editField">
                        <select name="editAirline" id="">
                            <option value="sriwijaya">Sriwijaya Airline</option>
                            <option value="garuda">Garuda Airline</option>
                        </select>
                    </div>
                </div>

                <div class="formLeft">
                    <div class="componentContainer">
                        <div class="editText">From</div>
                        <div class="editField">
                            <select name="editFrom" id="">
                                <option value="jakarta">Jakarta</option>
                                <option value="bali">Bali</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="inner">
                        <div class="componentContainer">
                            <div class="editText">Price Economy (Rp.)</div>
                            <div class="editField">
                                <input type="text" name="editPriceEco" id="">
                            </div>
                        </div>

                        <div class="componentContainer">
                            <div class="editText">Price Business (Rp.)</div>
                            <div class="editField">
                                <input type="text" name="editPriceBusiness" id="">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="formRight">
                    <div class="componentContainer">
                        <div class="editText">To</div>
                        <div class="editField">
                            <select name="editTo" id="">
                                <option value="jakarta">Jakarta</option>
                                <option value="bali">Bali</option>
                            </select>
                        </div>
                    </div>

                    <div class="inner">
                         <div class="componentContainer">
                            <div class="editText">Departure Date</div>
                            <div class="editField">
                                <input type="text" name="editDepartDate" id="">
                            </div>
                        </div>

                        <div class="componentContainer">
                            <div class="editText">Available Seat</div>
                            <div class="editField">
                                <input type="text" name="editAvailableSeat" id="">
                            </div>
                        </div>
                    </div>
                </div>

                <div id="dummyDiv"></div>

                <div class="button">
                    <input type="submit" value="Update Ticket" id="editBtn">
                </div>
            </div>
        </form>

    </div>
    
    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: 0</div>
    
</body>
</html>