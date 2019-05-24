<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminInsertCityStyle.css">
    <title>Insert City</title>
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
            <div id="contentHeaderText">Insert City</div>
            <br>
            Insert new city
        </div>

        <form action="">
            <div class="contentInsertCity">
                <div class="componentContainer">
                    <div class="insertText">City</div>
                    <div class="insertField"><input type="text" name="insertCity" id="insertCity"></div>
                </div>

                <div class="componentContainer">
                    <div class="insertText">Country</div>
                    <div class="insertField"><input type="text" name="insertCountry" id="insertCountry"></div>
                </div>

                <div id="dummyDiv"></div>

                <div class="button">
                    <input type="submit" value="Add City" id="insertBtn">
                </div>
            </div>
        </form>

    </div>
    
    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
    
</body>
</html>