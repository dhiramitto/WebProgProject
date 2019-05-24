<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminEditUserStyle.css">
    <title>Edit User</title>
</head>

<%@include file="process/connect.jsp" %>

<%
    String id = request.getParameter("id");

    if(id == null){
        response.sendRedirect("adminUserList.jsp");
    }

    String query = "SELECT * FROM user WHERE user_id = '"+ id +"'" ;
    ResultSet rs = st.executeQuery(query);

    String name_db = "", email_db = "", gender_db = "", password_db = "";

    if(rs.next()){
        name_db = rs.getString("name");
        email_db = rs.getString("email");
        gender_db = rs.getString("gender");
        password_db = rs.getString("password");
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
            <div id="contentHeaderText">Update User</div>
            <br>
            Update active user
        </div>

        <form action="process/controller.jsp?src=editUser&id=<%= id %>" method="POST">
            <div class="contentEditUser">
                <div class="componentContainer">
                    <div class="editText">Name</div>
                    <div class="editField"><input type="text" name="editName" id="editName" value="<%= name_db %>"></div>
                </div>

                <div class="componentContainer">
                    <div class="editText">Email</div>
                    <div class="editField"><input type="text" name="editEmail" id="editEmail" value="<%= email_db %>"></div>
                </div>

                <div class="componentContainer">
                    <div class="editText">Gender</div>
                    <div class="radio">
                        <%
                            if(gender_db.equals("Male")){
                                %>
                                <input type="radio" name="editGender" id="gender" value="Male" checked="true"> Male
                                <input type="radio" name="editGender" id="gender" value="Female"> Female
                                <%
                            }
                            else{
                                %>
                                <input type="radio" name="editGender" id="gender" value="Male"> Male
                                <input type="radio" name="editGender" id="gender" value="Female" checked="true"> Female
                                <%
                            }
                        %>
                        
                    </div>
                </div>

                <div class="componentContainer">
                    <div class="editText">Password</div>
                    <div class="editField"><input type="password" name="editPassword" id="editPassword" value="<%= password_db %>"></div>
                </div>

                <div class="button">
                    <input type="submit" value="Update User" id="editBtn">
                </div>

                <div class="error">
                    <%
                    String error = request.getParameter("err");

                    if(error != null){
                        if(error.equals("1")){
                            out.println("All elements must be filled!");
                        }
                        else if(error.equals("2")){
                            out.println("Invalid email format");
                        }
                    }
                    %>
                </div>
            </div>
        </form>

    </div>
    
    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
    
</body>
</html>