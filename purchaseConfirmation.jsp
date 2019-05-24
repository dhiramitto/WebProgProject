<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/purchaseConfirmationStyle.css">
    <title>Purchase Confirmation</title>
</head>
<body>

    <div class="header">
        <div class="home">
            <a href="homePage.jsp">Home</a>
        </div>
        
        <%@include file="includes/usernameDisplay.jsp" %>
    </div>

    <div class="content">
        <div class="contentHeader">
            <div id="contentHeaderText">Purchase Confirmation</div>
            <br>
            Confirm your tickets
        </div>
        <div class="contentWrapper">
            
            <%-- tampilin jumlah orang yg muncul, mgkn dgn loop --%>
            <div class="left">
                <%-- class passenger yang di-loop --%>
                <div class="passengers">
                    <%-- nomor --%> Passenger Information
                    <div class="passengerDetail">
                        <div class="detail">
                            Name <br> <%-- isi namanya di sini --%>
                        </div>
                        
                        <div class="detail">
                            Nationality <br> <%-- isi namanya di sini --%>
                        </div>

                        <div class="detail">
                            Departure <br> <%-- isi namanya di sini --%>
                        </div>

                        <div class="detail">
                            Arrival <br> <%-- isi namanya di sini --%>
                        </div>
                    </div>
                </div>
                
            </div>

            <%-- form untuk buy atau cancel --%>
            <div class="right">
                <form action="">
                    <div class="userDetail">
                        <h2>Buyer Information</h2>
                        <div style="font-weight: bold;">Name</div>
                        <div class="userName">Pablo Picasso</div>

                        <div style="font-weight: bold; font-size: 36px;">Total Price(s)</div>
                        <div class="userPay">Rp. 10.000.000,00</div>
                        <%-- nanti di-if aja untuk tiap buttonnya, cek value dari parameternya --%>
                        <div>
                            <button type="submit" id="payBtn" name="pay" value="true" class="buttons">Pay</button>
                        </div>
                        
                        <div>
                            <button type="submit" id="cancelBtn" name="cancel" value="true" class="buttons">Cancel</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
    
</body>
</html>