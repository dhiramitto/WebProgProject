<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminCityListStyle.css">
    <title>Cities List</title>
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
            <div id="contentHeaderText">Cities</div>
            <br>
            Available city list
        </div>

        <div class="contentTable">
            <table>
                <thead>
                    <td>City</td>
                    <td>Country</td>
                    <td>Action</td>
                </thead>

                <tr>
                    <td>Name</td>
                    <td>Email</td>
                    <td>Password</td>            
                </tr>

                <tr>
                    <td>Name</td>
                    <td>Email</td>
                    <td>Password</td>
                </tr>

            </table>
        </div>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: 0</div>
</body>
</html>