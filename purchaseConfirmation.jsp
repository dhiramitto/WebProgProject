<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/purchaseConfirmationStyle.css">
    <title>Purchase Confirmation</title>
</head>

<%@include file="process/connect.jsp" %>
<%@include file="process/model.jsp" %>

<%
    /*
        id=5
        qty=2
        detailTitle1=Mr.+
        detailName1=Jeffrey
        detailNationality1=Indonesian
        
        detailTitle2=Mr.+
        detailName2=Andre
        detailNationality2=Indonesian
    */

    //cek dulu sudah keisi atau belum nama"nya
    Vector<String> vectorInputName = new Vector<String>();
    String qtyParam = request.getParameter("qty");
    String ticketIdParam = request.getParameter("id");
    String priceParam = request.getParameter("price");
    int qty = 0;
    int ticketId = 0;
    int price = 0;

    if(qtyParam!=null && ticketIdParam!=null){
        String temp;
        qty = Integer.parseInt(qtyParam);
        ticketId = Integer.parseInt(ticketIdParam);
        price = Integer.parseInt(priceParam);
        for(int i=0; i<qty; i++){
            temp = request.getParameter("detailName" + (i+1));
            if(!temp.equals("")) vectorInputName.add(temp);
        }
        
        if(vectorInputName.size() < qty){
            response.sendRedirect("purchaseDetail.jsp?err=1&id="+ticketId+"&qty="+qty+"&price="+price+"");
        }
    }
    
        

    //dari parameter dan di-loop sesuai qty
    //perlu vector of class
    Vector<PurchaseConfirmation> vectorNameNationality = new Vector<PurchaseConfirmation>();
    String nationality = "";
    for(int i=0; i<qty; i++){
        nationality = request.getParameter("detailNationality"+(i+1));
        vectorNameNationality.add(new PurchaseConfirmation(vectorInputName.get(i), nationality));
    }
    
    
    //dari ticketid
    String from = "";
    String to = "";

    String searchTicket = "SELECT t.ticket_id, a.airline_name, cf.city_name AS 'from', ct.city_name AS 'to', t.depart_date, t.price_economy, t.price_business, t.seat  FROM ticket AS t INNER JOIN airline AS a ON t.airline_id=a.airline_id INNER JOIN city AS cf ON t.from_city_id=cf.city_id INNER JOIN city AS ct ON t.to_city_id=ct.city_id WHERE ticket_id = '"+ ticketId +"'";
    ResultSet rs = st.executeQuery(searchTicket);
    if(rs.next()){
        from = rs.getString("from");
        to = rs.getString("to");
    }


    //userID ambil dari session.getAttribute("user_id")
    String buyer = "";
    String userId = (String) session.getAttribute("userID");
    String searchBuyerId = "SELECT * FROM user WHERE user_id="+userId+"";
    Statement stSearchBuyerName = con.createStatement();
    ResultSet rsSearchBuyerName = stSearchBuyerName.executeQuery(searchBuyerId);
    if(rsSearchBuyerName.next()) buyer = rsSearchBuyerName.getString("name");

    //price * qty
    int totalPrice = qty * price;
%>

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
        <form action="process/controller.jsp" method="GET">
            <div class="contentWrapper">
                <%-- tampilin jumlah orang yg muncul dgn loop --%>
                <div class="left">
                    <%-- class passenger yang di-loop --%>
                    <%
                        for(int i=0; i<qty; i++){
                            %>
                                <div class="passengers">
                                    <%= i+1 %> Passenger Information
                                    <div class="passengerDetail">
                                        <div class="detail">
                                            <div class="detailHeader">Name</div>
                                            <div class="detailContent"><%= vectorNameNationality.get(i).getName() %></div>
                                            <%-- buat input hidden di sini utk nama dan nationality --%>
                                        </div>
                                                            
                                        <div class="detail">
                                            <div class="detailHeader"> Nationality </div>
                                            <div class="detailContent"> <%= vectorNameNationality.get(i).getNationality() %> </div>
                                        </div>

                                        <div class="detail">
                                            <div class="detailHeader"> Departure </div>
                                            <div class="detailContent"> <%= from %> </div>
                                        </div>

                                        <div class="detail">
                                            <div class="detailHeader"> Arrival </div>
                                            <div class="detailContent"> <%= to %> </div>
                                        </div>
                                    </div>
                                </div>
                            <%
                        }
                    %>
                    
                </div>

                <%-- form untuk buy atau cancel --%>
                <div class="right">
                    <form action="purchaseConfirmation.jsp" method="GET">
                        <div class="userDetail">
                            <h2>Buyer Information</h2>
                            <div style="font-weight: bold;">Name</div>
                            <div class="userName"> <%= buyer %> </div>

                            <div style="font-weight: bold; font-size: 36px;">Total Price(s)</div>
                            <div class="userPay">Rp. <%= totalPrice %> </div>
                            <%-- nanti di-if aja untuk tiap buttonnya, cek value dari parameternya --%>
                            <input type="hidden" name="src" value="purchaseConfirmation">
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
        </form>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
    
</body>
</html>