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
                    //cek emailnya udh ada atau belom
                    String cek = "SELECT * FROM user WHERE email='"+ email +"' ";
                    ResultSet rs = st.executeQuery(cek);

                    if(rs.next()){
                        response.sendRedirect("../register.jsp?err=4");
                    }
                    //lalu baru masukkin ke database
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
                        session.setAttribute("role", role_id_db); //1 admin, 2 user biasa

                        if(rememberMe == null){
                            if(role_id_db == 1){
                                response.sendRedirect("../adminUserList.jsp");
                            }
                            else{
                                response.sendRedirect("../homePage.jsp");
                            }
                        }
                        //cookie belakangan urusnya
                        /*
                        else if(rememberMe.equals("on")){
                            Cookie newCookie = new Cookie("email", email);
                            newCookie.setMaxAge(900);
                            newCookie.setPath("/");
                            response.addCookie(newCookie);

                            if(role_id_db == 1){
                                response.sendRedirect("../adminUserList.jsp");
                            }
                            else{
                                response.sendRedirect("../homePage.jsp");
                            }
                        }
                        */
                                              
                        
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
        else if(fromPage.equals("editUser")){
            try{
                
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("editName");
                String email = request.getParameter("editEmail");
                String password = request.getParameter("editPassword");
                String gender = request.getParameter("editGender");
                
                
                if(name.equals("") || email.equals("") || password.equals("") || gender.equals("")){
                    response.sendRedirect("../adminEditUser.jsp?err=1&id="+ id +"");
                }
                else if(!isEmailValid(email)){
                    response.sendRedirect("../adminEditUser.jsp?err=2&id="+ id +"");
                }
                else{
                    
                    //edit user berdasarkan id
                    
                    String query = "UPDATE user SET name = ?, email = ?, password = ?, gender = ? WHERE user_id = ?";
                    PreparedStatement stmt = con.prepareStatement(query);
                        
                    stmt.setString(1, name);
                    stmt.setString(2, email);
                    stmt.setString(3, password);
                    stmt.setString(4, gender);
                    stmt.setInt(5, id);
                                
                        
                    stmt.executeUpdate();
                      
                    response.sendRedirect("../adminUserList.jsp");
                    
                        
                }

            }
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("deleteUser")){
            try{
                int id = Integer.parseInt(request.getParameter("id"));

                String query = "DELETE FROM user WHERE user_id = ?";
                PreparedStatement stmt = con.prepareStatement(query);

                stmt.setInt(1, id);

                stmt.executeUpdate();

                response.sendRedirect("../adminUserList.jsp");
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("insertUser")){
            try{
                String name = request.getParameter("insertName");
                String email = request.getParameter("insertEmail");
                String password = request.getParameter("insertPassword");
                String gender = request.getParameter("insertGender");
            
                if(name.equals("") || email.equals("") || password.equals("") || gender.equals("")){
                    response.sendRedirect("../adminInsertUser.jsp?err=1");
                }
                else if(!isEmailValid(email)){
                    response.sendRedirect("../adminInsertUser.jsp?err=2");
                }
                else{
                    //cek emailnya udh ada atau belom
                    String cek = "SELECT * FROM user WHERE email='"+ email +"' ";
                    ResultSet rs = st.executeQuery(cek);

                    if(rs.next()){
                        response.sendRedirect("../adminInsertUser.jsp?err=3");
                    }
                    //lalu baru masukkin ke database
                    else{
                        String query = "INSERT INTO user (role_id, name, email, password, gender) VALUES (?, ?, ?, ?, ?)";
                        PreparedStatement stmt = con.prepareStatement(query);
                            
                        stmt.setInt(1, 2);
                        stmt.setString(2, name);
                        stmt.setString(3, email);
                        stmt.setString(4, password);
                        stmt.setString(5, gender);
                                
                        stmt.executeUpdate();
                                
                        response.sendRedirect("../adminUserList.jsp");
                    }
                        
                }
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("editCity")){
            try{
                
                int id = Integer.parseInt(request.getParameter("id"));
                String cityName = request.getParameter("editCity");
                String countryName = request.getParameter("editCountry");
                
                
                if(cityName.equals("") || countryName.equals("")){
                    response.sendRedirect("../adminEditCity.jsp?err=1&id="+ id +"");
                }
                else{
                    
                    //edit user berdasarkan id
                    
                    String query = "UPDATE city SET city_name = ?, country_name = ? WHERE city_id = ?";
                    PreparedStatement stmt = con.prepareStatement(query);
                        
                    stmt.setString(1, cityName);
                    stmt.setString(2, countryName);
                    stmt.setInt(3, id);
                                
                        
                    stmt.executeUpdate();
                      
                    response.sendRedirect("../adminCityList.jsp");
                    
                        
                }

            }
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("deleteCity")){
            try{
                int id = Integer.parseInt(request.getParameter("id"));

                String query = "DELETE FROM city WHERE city_id = ?";
                PreparedStatement stmt = con.prepareStatement(query);

                stmt.setInt(1, id);

                stmt.executeUpdate();

                response.sendRedirect("../adminCityList.jsp");
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("insertCity")){
            try{
                System.out.println(fromPage);
                String cityName = request.getParameter("insertCityName");
                String countryName = request.getParameter("insertCountryName");

                if(cityName.equals("") || countryName.equals("")){
                    response.sendRedirect("../adminInsertCity.jsp?err=1");
                }
                else{
                    String query = "INSERT INTO city (city_name, country_name) VALUES (?,?)";
                    PreparedStatement stmt = con.prepareStatement(query);

                    stmt.setString(1, cityName);
                    stmt.setString(2, countryName);

                    stmt.executeUpdate();

                    response.sendRedirect("../adminCityList.jsp");
                }
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
    }
    
        
%>