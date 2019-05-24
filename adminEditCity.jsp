<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminEditCityStyle.css">
    <title>Edit City</title>
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
            <div id="contentHeaderText">Update City</div>
            <br>
            Update active city
        </div>

        <form action="">
            <div class="contentEditCity">
                <div class="componentContainer">
                    <div class="editText">City</div>
                    <div class="editField"><input type="text" name="editCity" id="editCity"></div>
                </div>

                <div class="componentContainer">
                    <div class="editText">Country</div>
                    <div class="editField"><input type="text" name="editCountry" id="editCountry"></div>
                </div>

                <div class="button">
                    <input type="submit" value="Update City" id="editBtn">
                </div>
            </div>
        </form>

    </div>
    
    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: 0</div>
    
</body>
</html>