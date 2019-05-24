<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file = "connect.jsp" %>

<%!
    public boolean isEmailValid(String email){
        int countAt = 0, emailLen = email.length();

        for(int i=0; i<emailLen; i++){
            if(email.charAt(i) == '@') countAt++;
        }

        if(email.length() < 4 || (!email.contains("@") || !email.contains(".")) || countAt > 1 || Math.abs(email.indexOf("@") - email.indexOf(".")) == 1){
            return false;
        }
        else return true;

    }
%>

<%
    String fromPage = request.getParameter("src");

    if(fromPage != null){
        if(fromPage.equals("register")){
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
                else if(!isEmailValid(email)){
                    response.sendRedirect("../register.jsp?err=3");
                }
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
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("signin")){

            try{
                String email = request.getParameter("loginEmail");
                String password = request.getParameter("loginPassword");
                
                //on kalo centang atau null kalo ga dicentang
                String rememberMe = request.getParameter("rememberMe");

                if(email.equals("") || password.equals("")){
                    response.sendRedirect("../signIn.jsp?err=1");
                }
                else if(!isEmailValid(email)){
                    response.sendRedirect("../signIn.jsp?err=2");
                }
                //yg err=3 utk beda dgn database
                else{

                    int online = 0;
                    
                    String query = "SELECT * FROM user WHERE email = '"+ email +"' AND password = '"+ password +"'";
                    ResultSet rs = st.executeQuery(query);
                    

                    if(rs.next()){
                        int role_id_db = rs.getInt("role_id"); //1 admin, 2 user biasa
                        String name_db = rs.getString("name");

                        if(application.getAttribute("online") == null){
                            online = 0;
                        }
                        else{
                            online = (Integer) application.getAttribute("online");
                        }

                        online++;
                        application.setAttribute("online", online);

                        session.setAttribute("name", name_db);

                        if(rememberMe.equals("on")){
                            Cookie newCookie = new Cookie("email", email);
                            newCookie.setMaxAge(900);
                            newCookie.setPath("/");
                            response.addCookie(newCookie);
                        }
                        
                        if(role_id_db == 1){
                            response.sendRedirect("../adminUserList.jsp");
                        }
                        else{
                            response.sendRedirect("../homePage.jsp");
                        }
                    }
                    else{
                        response.sendRedirect("../signIn.jsp?err=3");
                    }
                }
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
    }
    
        
%>