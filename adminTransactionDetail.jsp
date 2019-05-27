<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminTransactionDetailStyle.css">
    <title>Transaction Details</title>
</head>

<%@include file="process/connect.jsp" %>
<%@include file="process/model.jsp" %>

<%
    /*
        btn=view
        id=1 -> mksdnya ticket_id
        invoice= 
    */
    String btnType = request.getParameter("btn");
    int header_id = Integer.parseInt(request.getParameter("id"));
    String invoiceNumber = request.getParameter("invoice");
    String status = request.getParameter("status");

    Vector<TransactionDetail> vectorDetail = new Vector<TransactionDetail>();

    String query = "SELECT * FROM transaction_detail WHERE transaction_header_id = "+header_id;
    ResultSet rs = st.executeQuery(query);

    while(rs.next()){
        vectorDetail.add(new TransactionDetail(rs.getInt("transaction_detail_id"), rs.getInt("transaction_header_id"), rs.getString("title"), rs.getString("name"), rs.getString("nationality")));
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
            <div id="contentHeaderText">Transaction Details</div>
            <br>
            Detail of selected transaction
        </div>

        <div class="contentTable">
            <div class="headerTable"> <span id="invoice"><%= invoiceNumber %></span> <%-- if utk status di span status --%> <span id="status"><%= status %></span></div>
            <%
                if(btnType != null){
                    if(btnType.equals("view")){
                        %>
                            <table>
                                <thead>
                                    <td>Person Title</td>
                                    <td>Person Name</td>
                                    <td>Person Nationality</td>
                                </thead>

                                <%
                                    for(int i=0; i<vectorDetail.size(); i++){
                                        %>
                                            <tr>
                                                <td><%= vectorDetail.get(i).getTitle() %></td>
                                                <td><%= vectorDetail.get(i).getName() %></td>
                                                <td><%= vectorDetail.get(i).getNationality() %></td>
                                            </tr>
                                        <%
                                    }
                                %>

                            </table>
                            <div class="buttonContainer">
                                <div class="dummy"></div>
                                <div class="buttons">
                                    <%
                                        if(status.equals("Pending")){
                                            %>
                                                <a href="process/controller.jsp?src=transactionDetail&btnType=approve&headerId=<%= header_id %>"><button id="approveBtn">Approve</button></a>
                                                <a href="process/controller.jsp?src=transactionDetail&btnType=reject&headerId=<%= header_id %>"><button id="rejectBtn">Reject</button></a>
                                                <a href="adminTransactionList.jsp"><button id="backBtn">Back</button></a>
                                            <%
                                        }
                                        else if(status.equals("Approved") || status.equals("Rejected") || status.equals("Canceled")){
                                            %>
                                                <a href="adminTransactionList.jsp"><button id="backBtn">Back</button></a>
                                            <%
                                        }
                                    %>
                                </div>
                            </div>                        
                        <%
                    }
                    else if(btnType.equals("edit")){
                        %>
                            <table>
                                <thead>
                                    <td>Person Title</td>
                                    <td>Person Name</td>
                                    <td>Person Nationality</td>
                                    <td>Action</td>
                                </thead>

                                <%
                                    for(int i=0; i<vectorDetail.size(); i++){
                                        %>
                                            <tr>
                                                <td><%= vectorDetail.get(i).getTitle() %></td>
                                                <td><%= vectorDetail.get(i).getName() %></td>
                                                <td><%= vectorDetail.get(i).getNationality() %></td>
                                                <td><a href="process/controller.jsp?src=transactionDetail&btnType=delete&detailId=<%= vectorDetail.get(i).getId() %>"><button id="deleteBtn">Delete</button></a></td>
                                            </tr>
                                        <%
                                    }
                                %>
                            </table>
                            <div class="buttonContainer">
                                <div class="dummy"></div>
                                <div class="buttons">          
                                    <a href="adminTransactionList.jsp"><button id="backBtn">Back</button></a>
                                </div>
                            </div>
                        <%
                    }
                }
            %>

        </div>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
</body>
</html>