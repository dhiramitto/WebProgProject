<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.Vector" errorPage="" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/purchaseDetailStyle.css">
    <title>Purchase Detail</title>
</head>

<%@include file="process/connect.jsp" %>

<%
        String ticketId = request.getParameter("id");
        String qtyParam = request.getParameter("qty");
        String price = request.getParameter("price");
        int qty = 0;
        
        if(qtyParam != null){
            qty = Integer.parseInt(qtyParam);
        }

        Vector<String> nationality = new Vector<String>();

        try{
            String query = "SELECT * FROM nationality";
            ResultSet rs = st.executeQuery(query);

            while(rs.next()){
                nationality.add(rs.getString("nationality_name"));
            }
        }
        catch(Exception e){
            System.out.println(e);
        }
%>

<body>

    <div class="header">
        <div class="home">
            <a href="homePage.jsp">Home</a>
        </div>
        <span class="headerContainer">
            <%-- nanti diganti jadi nama user dan track order kalo udh sign in --%>
            <%@include file="includes/usernameDisplay.jsp" %>
        </span>
    </div>

    <%--
        dapetin parameter jumlah passenger dari homepage
        nanti loop utk jumlah field yg dapat diisi
     --%>
    <div class="content">
        <%-- form berdasarkan jumlah orangnya --%>
        <form action="purchaseConfirmation.jsp" method="GET">
            <input type="hidden" name="id" value="<%= ticketId %>">
            <input type="hidden" name="qty" value="<%= qty %>">
            <input type="hidden" name="price" value="<%= price %>">
            <%-- loop here --%>
            <div class="formPurchase">
            <%
                for(int i=0; i<qty; i++){
                    %>
                        <%= i+1 %> Passenger Information
                        <br>
                            <div class="formInput">
                                <div class="componentContainer">
                                    <div class="detailText">Title</div>
                                    <div class="detailField">
                                        <select name="detailTitle<%= i+1 %>" id="">
                                            <option value="Mr. ">Mr.</option>
                                            <option value="Mrs. ">Mrs.</option>
                                            <option value="Ms. ">Ms.</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="componentContainer">
                                    <div class="detailText">Name</div>
                                    <div class="detailField"><input type="text" name="detailName<%= i+1 %>"></div>
                                </div>

                                <div class="componentContainer">
                                    <div class="detailText">Nationality</div>
                                    <div class="detailField">
                                        
                                        <select name="detailNationality<%= i+1 %>" id="">
                                            <%
                                                for(int j=0; j<nationality.size(); j++){
                                                    %>
                                                        <option value="<%= nationality.get(j) %>"><%= nationality.get(j) %></option>
                                                    <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <%-- end of loop --%>
                            <%
                            if(i+1 == qty){
                                %>

                                <div class="end">

                                    <div class="error">
                                        <%
                                            String error = request.getParameter("err");

                                            if(error != null){
                                                if(error.equals("1")){
                                                    out.println("All names must be filled!");
                                                }
                                            }
                                        %>
                                    </div>

                                    <button>Purchase Ticket(s)</button>
                                </div>
                                <%
                            }
                }
            %>
            </div>
        </form>
        
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
    
</body>
</html>