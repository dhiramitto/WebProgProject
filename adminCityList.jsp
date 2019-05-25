<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/adminCityListStyle.css">
    <title>Cities List</title>
</head>

<%@include file="process/connect.jsp"%>
<%@include file="process/model.jsp"%>

<%
    Vector<City> vectorCity= new Vector<City>();
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
            <div id="contentHeaderText">Cities</div>
            <br>
            Available city list
        </div>

        <%
            String query = "SELECT * FROM City";
            ResultSet rs = st.executeQuery(query);

            while(rs.next()){
                vectorCity.add(new City(rs.getInt("city_id"), rs.getString("city_name"), rs.getString("country_name")));
            }
        %>

        <div class="contentTable">
            <table>
                <thead>
                    <td>City</td>
                    <td>Country</td>
                    <td>Action</td>
                </thead>

                <%
                    for(int i=0; i<vectorCity.size(); i++){
                        %>
                        <tr>
                            <td><%= vectorCity.get(i).getCityName() %></td>
                            <td><%= vectorCity.get(i).getCountryName() %></td>
                            <td width=200px>
                                <a href="adminEditCity.jsp?id=<%= vectorCity.get(i).getId() %>"><button class="modifyButtons" id="editBtn">Edit</button></a>
                                <a href="process/controller.jsp?src=deleteCity&id=<%= vectorCity.get(i).getId() %>"><button class="modifyButtons" id="deleteBtn">Delete</button></a>
                            </td>
                        </tr>
                        <%
                    }
                %>

                <tr>
                    <td colspan="2"></td>
                    <td>
                        <a href="adminInsertCity.jsp"><button id="insertBtn">Insert City</button></a>
                    </td>
                </tr>
                
            </table>
        </div>
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: <%= application.getAttribute("online") %></div>
</body>
</html>