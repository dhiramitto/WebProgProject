<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file = "connect.jsp" %>

<%
    try{

        String name = request.getParameter("regName");
        String email = request.getParameter("regEmail");
        String password = request.getParameter("regPassword");
        String confPassword = request.getParameter("regConfPassword");
        String gender = request.getParameter("gender");
    
        if(name.equals("") || email.equals("") || password.equals("") || confPassword.equals("") || gender.equals("")){
            response.sendRedirect("../register.jsp?err=1");
        }
        else if(!password.equals(confPassword)){
            response.sendRedirect("../register.jsp?err=2");
        }
        else{
            //cek email dulu
            int countAt = 0, emailLen = email.length();

            for(int i=0; i<emailLen; i++){
                if(email.charAt(i) == '@') countAt++;
            }

            if(email.length() < 4 || (!email.contains("@") || !email.contains(".")) || countAt > 1 || Math.abs(email.indexOf("@") - email.indexOf(".")) == 1){
                response.sendRedirect("../register.jsp?err=3");
            }
            
            //abis itu baru masukkin ke database
            else{

                String query = "INSERT INTO user (role_id, name, email, password, gender) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement stmt = con.prepareStatement(query);
                
                stmt.setInt(1, 2);
                stmt.setString(2, name);
                stmt.setString(3, email);
                stmt.setString(4, password);
                stmt.setString(5, gender);
                
                stmt.executeUpdate();
                
                
                response.sendRedirect("../signIn.jsp");
            }
        }
    }
    catch(Exception e){
        System.out.println(e);
    }
        
%>