<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminTransactionDetailStyle.css">
    <title>Transaction Details</title>
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
            <div id="contentHeaderText">Transaction Details</div>
            <br>
            Detail of selected transaction
        </div>

        <div class="contentTable">
            <div> <span id="invoice">invoice</span> <%-- if utk status di span status --%> <span id="status">status</span></div>
            <table>
                <thead>
                    <td>Person Title</td>
                    <td>Person Name</td>
                    <td>Person Nationality</td>
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
            <div class="buttonContainer">
                <div></div>
                <div class="buttons">
                    <%-- if here --%>                    
                    <button id="approveBtn">Approve</button>
                    <button id="rejectBtn">Reject</button>
                    <button id="backBtn">Back</button>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: 0</div>
</body>
</html>