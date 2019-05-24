<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminTicketListStyle.css">
    <title>Ticket List</title>
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
            <div id="contentHeaderText">Tickets</div>
            <br>
            Ticket lists
        </div>

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

                <tr>
                    <td>Airline</td>
                    <td>From</td>
                    <td>To</td>
                    <td>Departure Date</td>
                    <td>Economy</td>
                    <td>Business</td>
                    <td>Seat</td>
                    <td>Action</td>
                </tr>

                <tr>
                    <td>Airline</td>
                    <td>From</td>
                    <td>To</td>
                    <td>Departure Date</td>
                    <td>Economy</td>
                    <td>Business</td>
                    <td>Seat</td>
                    <td>Action</td>
                </tr>
            </table>
        </div>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: 0</div>
</body>
</html>