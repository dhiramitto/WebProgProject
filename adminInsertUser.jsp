<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminInsertUserStyle.css">
    <title>Insert User</title>
</head>
<body>

    <div class="header">
        <div class="headerMenu">
            <%@include file="includes/adminPages/adminHeaderMenu.jsp" %>
        </div>
        <%@include file="includes/usernameDisplay.jsp" %>
    </div>
    
    <div class="content">
        <div class="contentHeader">
            <div id="contentHeaderText">Insert User</div>
            <br>
            Insert new user
        </div>

        <form action="process/controller.jsp?src=insertUser" method="POST">
            <div class="contentInsertUser">
                <div class="componentContainer">
                    <div class="insertText">Name</div>
                    <div class="insertField"><input type="text" name="insertName" id="insertName"></div>
                </div>

                <div class="componentContainer">
                    <div class="insertText">Email</div>
                    <div class="insertField"><input type="text" name="insertEmail" id="insertEmail"></div>
                </div>

                <div class="componentContainer">
                    <div class="insertText">Gender</div>
                    <div class="radio">
                        <input type="radio" name="insertGender" id="gender" value="Male"> Male
                        <input type="radio" name="insertGender" id="gender" value="Female"> Female
                    </div>
                </div>

                <div class="componentContainer">
                    <div class="insertText">Password</div>
                    <div class="insertField"><input type="password" name="insertPassword" id="insertPassword"></div>
                </div>

                <div class="button">
                    <input type="submit" value="Add User" id="insertBtn">
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
                        else if(error.equals("3")){
                            out.println("Email already exists");
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