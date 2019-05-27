<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminTransactionListStyle.css">
    <title>Transaction List</title>
</head>

<%@include file="process/connect.jsp" %>
<%@include file="process/model.jsp" %>

<%
    Vector<TransactionHeader> vectorTransactionHeader = new Vector<TransactionHeader>();
    //invoiceNumber buat sendiri entar
    String query = "SELECT * FROM transaction_header";
    ResultSet rs = st.executeQuery(query);

    while(rs.next()){
        vectorTransactionHeader.add(new TransactionHeader(rs.getInt("transaction_header_id"), rs.getString("order_date"), rs.getInt("buyer"), rs.getString("status")));
    }
%>

<body>
    <div class="header">
        <div class="headerMenu">
            <%@include file="includes/adminPages/adminHeaderMenu.jsp" %>
        </div>
        <%@include file="includes/usernameDisplay.jsp" %>
    </div>

    <div class="content">
        <div class="contentHeader">
            <div id="contentHeaderText">Transactions</div>
            <br>
            On Progress Transaction
        </div>

        <div class="contentTable">
            <table>
                <thead>
                    <td>Invoice Number</td>
                    <td>Date</td>
                    <td>Buyer</td>
                    <td>Status</td>
                    <td>Action</td>
                </thead>

                <%
                    for(int i=0; i<vectorTransactionHeader.size(); i++){
                        String invoiceNumber = "INV/";
                        for(int j=0; j<vectorTransactionHeader.get(i).getOrderDate().length(); j++){
                            if(vectorTransactionHeader.get(i).getOrderDate().charAt(j) == '-') continue;
                            else invoiceNumber+=vectorTransactionHeader.get(i).getOrderDate().charAt(j);
                        }
                        invoiceNumber= invoiceNumber + "/" + vectorTransactionHeader.get(i).getId();

                        //cari buyer name dari id user
                        String buyerName = "";
                        String query_search_buyer = "SELECT * FROM user WHERE user_id='"+vectorTransactionHeader.get(i).getBuyer()+"'";
                        Statement searchBuyer = con.createStatement();
                        ResultSet buyerNameRs = searchBuyer.executeQuery(query_search_buyer);

                        if(buyerNameRs.next()){
                            buyerName = buyerNameRs.getString("name");
                        }
                        %>
                            <tr>
                                <td><%= invoiceNumber %></td>
                                <td><%= vectorTransactionHeader.get(i).getOrderDate() %></td>
                                <td><%= buyerName %></td>
                                <td><%= vectorTransactionHeader.get(i).getStatus() %></td>
                                <td width=300px>
                                    <a href="adminTransactionDetail.jsp?btn=view&id=<%= vectorTransactionHeader.get(i).getId() %>&invoice=<%= invoiceNumber %>&status=<%= vectorTransactionHeader.get(i).getStatus() %>"><button class="modifyButtons" id="viewBtn">View</button></a>
                                    <a href="adminTransactionDetail.jsp?btn=edit&id=<%= vectorTransactionHeader.get(i).getId() %>&invoice=<%= invoiceNumber %>&status=<%= vectorTransactionHeader.get(i).getStatus() %>"><button class="modifyButtons" id="editBtn">Edit</button></a>
                                    <a href="process/controller.jsp?src=transactionList&btn=delete&id=<%= vectorTransactionHeader.get(i).getId() %>"><button class="modifyButtons" id="deleteBtn">Delete</button></a>
                                </td>
                            </tr>
                        <%
                    }
                %>

            </table>
        </div>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
</body>
</html>