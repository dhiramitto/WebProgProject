<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminUserListStyle.css">
    <title>User List</title>
</head>

<%-- biar html dan jsp tidak tercampur --%>
<%@include file="process/connect.jsp" %>
<%@include file="process/model.jsp" %>

<%
    Vector<User> vectorUser = new Vector<User>();
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
            <div id="contentHeaderText">Users</div>
            <br>
            Active user list
        </div>

        <%
            String query = "SELECT * FROM user WHERE role_id = 2";
            ResultSet rs = st.executeQuery(query);

            while(rs.next()){
                vectorUser.add(new User(rs.getInt("user_id"), rs.getString("name"), rs.getString("email"), rs.getString("password"), rs.getString("gender")));
            }
        %>

        <div class="contentTable">
            <table>
                <thead>
                    <td>Name</td>
                    <td>Email</td>
                    <td>Password</td>
                    <td>Gender</td>
                    <td>Action</td>
                </thead>

                <%-- loop here --%>
                <%
                    for(int i=0; i<vectorUser.size(); i++){
                    %>
                    <tr>
                        <td><%= vectorUser.get(i).getName()  %></td>
                        <td width=200px><%= vectorUser.get(i).getEmail() %></td>
                        <td width=200px><%= vectorUser.get(i).getPassword() %></td>
                        <td><%= vectorUser.get(i).getGender() %></td>
                        <td width=200px>
                            <a href="adminEditUser.jsp?id=<%= vectorUser.get(i).getId() %>"><button id="editBtn">Edit</button></a>
                            <a href="process/controller.jsp?src=deleteUser&id=<%= vectorUser.get(i).getId() %>"><button id="deleteBtn">Delete</button></a>
                        </td>
                    </tr>
                    <%
                    }
                %>

            </table>
        </div>
    </div>

    

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %> </div>
</body>
</html>