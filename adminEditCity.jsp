<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminEditCityStyle.css">
    <title>Edit City</title>
</head>

<%@include file="process/connect.jsp"%>

<%
    String id = request.getParameter("id");

    if(id == null){
        response.sendRedirect("adminCityList.jsp");
    }

    String query = "SELECT * FROM city WHERE city_id = '"+ id +"'" ;
    ResultSet rs = st.executeQuery(query);

    String city_name_db = "", country_name_db = "";

    if(rs.next()){
        city_name_db = rs.getString("city_name");
        country_name_db = rs.getString("country_name");
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
            <div id="contentHeaderText">Update City</div>
            <br>
            Update active city
        </div>

        <form action="process/controller.jsp?src=editCity&id=<%= id %>" method="POST">
            <div class="contentEditCity">
                <div class="componentContainer">
                    <div class="editText">City</div>
                    <div class="editField"><input type="text" name="editCity" id="editCity" value="<%= city_name_db %>"></div>
                </div>

                <div class="componentContainer">
                    <div class="editText">Country</div>
                    <div class="editField"><input type="text" name="editCountry" id="editCountry" value="<%= country_name_db %>"></div>
                </div>

                <div class="button">
                    <input type="submit" value="Update City" id="editBtn">
                </div>

                <div class="error">
                    <%
                    String error = request.getParameter("err");

                    if(error != null){
                        if(error.equals("1")){
                            out.println("All elements must be filled!");
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