<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/searchStyle.css">
    <title>Search Result</title>
</head>
<body>

    <div class="header">
        <div class="home">
            <a href="">Home</a>
        </div>
        <span class="logInContainer">
            <%@include file = "includes/usernameDisplay.jsp" %>
        </span>
    </div>
    <%-- search result, bakal ada loop kayaknya --%>
    <div class="content">
        <div class="searchResult">
            <table>
                <tr>
                    <th>Airline</th>
                    <th>From</th>
                    <th>To</th>
                    <th>Price</th>
                    <td rowspan="2" class="buttonContainer">
                        <%-- purchase details --%>
                        <form action="">
                            <button id="purchaseBtn">+</button>
                        </form>
                    </td> 
                </tr>
                <tr>
                    <td>Airline</td>
                    <td>From</td>
                    <td>To</td>
                    <td>Price</td>
                </tr>
            </table>
            
            <div class="pagination">
                <table>
                    <%-- loop column aja --%>
                    <tr>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                        <td>5</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
    
</body>
</html>