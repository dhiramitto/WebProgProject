<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminEditUserStyle.css">
    <title>Insert User</title>
</head>
<body>

    <div class="header">
        <div class="headerMenu">
            <%@include file="includes/adminPages/adminHeaderMenu.jsp" %>
        </div>
        <div class="usernameDisplay">Pablo Picasso</div>
    </div>
    
    <div class="content">
        <div class="contentHeader">
            <div id="contentHeaderText">Update User</div>
            <br>
            Update active user
        </div>

        <form action="">
            <div class="contentEditUser">
                <div class="componentContainer">
                    <div class="editText">Name</div>
                    <div class="editField"><input type="text" name="editName" id="editName"></div>
                </div>

                <div class="componentContainer">
                    <div class="editText">Email</div>
                    <div class="editField"><input type="text" name="editEmail" id="editEmail"></div>
                </div>

                <div class="componentContainer">
                    <div class="editText">Gender</div>
                    <div class="radio">
                        <input type="radio" name="gender" id="gender" value="Male"> Male
                        <input type="radio" name="gender" id="gender" value="Female"> Female
                    </div>
                </div>

                <div class="componentContainer">
                    <div class="editText">Password</div>
                    <div class="editField"><input type="password" name="editPassword" id="editPassword"></div>
                </div>

                <div class="button">
                    <input type="submit" value="Update User" id="editBtn">
                </div>
            </div>
        </form>

    </div>
    
    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: 0</div>
    
</body>
</html>