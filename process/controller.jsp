<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.text.SimpleDateFormat" errorPage="" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.Date" errorPage="" %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.Vector" errorPage="" %>
<%@ include file = "connect.jsp" %>
<%@ include file = "model.jsp" %>

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

    public boolean isNum(String str){
        for(int i=0; i<str.length(); i++){
            if(!Character.isDigit(str.charAt(i))) return false;
        }
        return true;
    }

    //cek tanggal harus minimal hari ini
    public boolean checkDate(String date){
        String year = "", month = "", day = "";
        String todayYear = "", todayMonth = "", todayDay = "";

        Date todayDate = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String today = formatter.format(todayDate);

        for(int i=0; i<date.length(); i++){
            if(date.charAt(i) == '-') continue;

            if(i<4) year += date.charAt(i);
            else if(i>4 && i<7) month += date.charAt(i);
            else if(i>7) day += date.charAt(i);
        }

        for(int i=0; i<today.length(); i++){
            if(today.charAt(i) == '-') continue;

            if(i<4) todayYear += today.charAt(i);
            else if(i>4 && i<7) todayMonth += today.charAt(i);
            else if(i>7) todayDay += today.charAt(i);
        }
        

        int paramYear = Integer.parseInt(year), paramMonth = Integer.parseInt(month), paramDay = Integer.parseInt(day);
        int todayYearInt = Integer.parseInt(todayYear), todayMonthInt = Integer.parseInt(todayMonth), todayDayInt = Integer.parseInt(todayDay);

        if(paramYear > todayYearInt) return true;
        else{
            if(paramMonth < todayMonthInt){
                return false;
            }
            else if(paramMonth == todayMonthInt){
                if(paramDay < todayDayInt) return false;
            }
        }
        return true;
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
                        int user_id = rs.getInt("user_id");
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

                        session.setAttribute("userID", user_id+"");
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
                        
                        
                        //kalo remember me dicentang
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
        else if(fromPage.equals("editTicket")){
            try{   
                int id = Integer.parseInt(request.getParameter("id"));

                String airline = request.getParameter("editAirline");
                String from = request.getParameter("editFrom");
                String to = request.getParameter("editTo");
                String depart = request.getParameter("editDepartDate");
                //nanti di-parse ke integer
                String priceEco = request.getParameter("editPriceEco");
                String priceBusiness = request.getParameter("editPriceBusiness");
                String seat = request.getParameter("editAvailableSeat");

                if(!isNum(priceEco) || !isNum(priceBusiness) || !isNum(seat)){
                    response.sendRedirect("../adminEditTicket.jsp?err=1&id="+ id +"");
                }
                //cek tanggal minimal hari ini
                else if(!checkDate(depart)){
                    response.sendRedirect("../adminEditTicket.jsp?err=2&id="+ id +"");
                }
                else if(priceEco.equals("") || priceBusiness.equals("") || seat.equals("") || depart.equals("")){
                    response.sendRedirect("../adminEditTicket.jsp?err=3&id="+ id +"");
                }
                else{
                    //cari id dari tiap airline dan city dulu
                    String searchAirlineId = "SELECT * FROM airline WHERE airline_name = '"+ airline +"'";
                    Statement stAirlineID = con.createStatement();
                    ResultSet searchAirlineRS = stAirlineID.executeQuery(searchAirlineId);
                    int airlineID = 0;
                    if(searchAirlineRS.next()){
                        airlineID = searchAirlineRS.getInt("airline_id");
                    }

                    String searchFromId = "SELECT * FROM city WHERE city_name = '"+ from +"'";
                    Statement stFromID = con.createStatement();
                    ResultSet searchFromRS = stFromID.executeQuery(searchFromId);
                    int fromID = 0;
                    if(searchFromRS.next()){
                        fromID = searchFromRS.getInt("city_id");
                    }

                    String searchToId = "SELECT * FROM city WHERE city_name = '"+ to +"'";
                    Statement stToID = con.createStatement();
                    ResultSet searchToRS = stToID.executeQuery(searchToId);
                    int toID = 0;
                    if(searchToRS.next()){
                        toID = searchToRS.getInt("city_id");
                    }

                    //dimasukkin ke prepared statement
                    String query = "UPDATE ticket SET airline_id = ?, from_city_id = ?, to_city_id = ?, depart_date = ?, price_economy = ?, price_business = ?, seat = ? WHERE ticket_id = ?";
                    PreparedStatement stmt = con.prepareStatement(query);

                    int eco = Integer.parseInt(priceEco);
                    int business = Integer.parseInt(priceBusiness);
                    int seat_int = Integer.parseInt(seat);
                        
                    stmt.setInt(1, airlineID);
                    stmt.setInt(2, fromID);
                    stmt.setInt(3, toID);
                    stmt.setString(4, depart);
                    stmt.setInt(5, eco);
                    stmt.setInt(6, business);
                    stmt.setInt(7, seat_int);
                    stmt.setInt(8, id);
                                
                        
                    stmt.executeUpdate();
                      
                    response.sendRedirect("../adminTicketList.jsp");
                }
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("deleteTicket")){
            try{
                int id = Integer.parseInt(request.getParameter("id"));

                String query = "DELETE FROM ticket WHERE ticket_id = ?";
                PreparedStatement stmt = con.prepareStatement(query);

                stmt.setInt(1, id);

                stmt.executeUpdate();

                response.sendRedirect("../adminTicketList.jsp");
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("insertTicket")){
            try{
                String airline = request.getParameter("insertAirline");
                String from = request.getParameter("insertFrom");
                String to = request.getParameter("insertTo");
                String depart = request.getParameter("insertDepartDate");
                //nanti di-parse ke integer
                String priceEco = request.getParameter("insertPriceEco");
                String priceBusiness = request.getParameter("insertPriceBusiness");
                String seat = request.getParameter("insertAvailableSeat");

                if(!isNum(priceEco) || !isNum(priceBusiness) || !isNum(seat)){
                    response.sendRedirect("../adminInsertTicket.jsp?err=1");
                }
                //cek tanggal minimal hari ini
                else if(!checkDate(depart)){
                    response.sendRedirect("../adminInsertTicket.jsp?err=2");
                }
                else if(priceEco.equals("") || priceBusiness.equals("") || seat.equals("") || depart.equals("")){
                    response.sendRedirect("../adminInsertTicket.jsp?err=3");
                }
                else{
                    //cari id dari tiap airline dan city dulu
                    String searchAirlineId = "SELECT * FROM airline WHERE airline_name = '"+ airline +"'";
                    Statement stAirlineID = con.createStatement();
                    ResultSet searchAirlineRS = stAirlineID.executeQuery(searchAirlineId);
                    int airlineID = 0;
                    if(searchAirlineRS.next()){
                        airlineID = searchAirlineRS.getInt("airline_id");
                    }

                    String searchFromId = "SELECT * FROM city WHERE city_name = '"+ from +"'";
                    Statement stFromID = con.createStatement();
                    ResultSet searchFromRS = stFromID.executeQuery(searchFromId);
                    int fromID = 0;
                    if(searchFromRS.next()){
                        fromID = searchFromRS.getInt("city_id");
                    }

                    String searchToId = "SELECT * FROM city WHERE city_name = '"+ to +"'";
                    Statement stToID = con.createStatement();
                    ResultSet searchToRS = stToID.executeQuery(searchToId);
                    int toID = 0;
                    if(searchToRS.next()){
                        toID = searchToRS.getInt("city_id");
                    }

                    //dimasukkin ke prepared statement
                    String query = "INSERT INTO ticket (airline_id, from_city_id, to_city_id, depart_date, price_economy, price_business, seat) VALUES(?,?,?,?,?,?,?)";
                    PreparedStatement stmt = con.prepareStatement(query);

                    int eco = Integer.parseInt(priceEco);
                    int business = Integer.parseInt(priceBusiness);
                    int seat_int = Integer.parseInt(seat);
                        
                    stmt.setInt(1, airlineID);
                    stmt.setInt(2, fromID);
                    stmt.setInt(3, toID);
                    stmt.setString(4, depart);
                    stmt.setInt(5, eco);
                    stmt.setInt(6, business);
                    stmt.setInt(7, seat_int);
                        
                    stmt.executeUpdate();
                      
                    response.sendRedirect("../adminTicketList.jsp");
                }
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("insertTransaction")){
            String pay = request.getParameter("pay");
            String cancel = request.getParameter("cancel");

            /*
                ticketid=2
                qty=2
                userid=1
                detailName1=Aldo
                detailNationality1=Indonesian
                detailName2=Andy
                detailNationality2=Indonesian
            */

            if(cancel != null){
                if(cancel.equals("true")){
                    try{
                        String ticketIdParam = request.getParameter("ticketid");
                        String qtyParam = request.getParameter("qty");
                        String useridParam = request.getParameter("userid");
                        String cabinClass = request.getParameter("cabinClass");

                        int ticket_id = Integer.parseInt(ticketIdParam);
                        int qty = Integer.parseInt(qtyParam);
                        int user_id = Integer.parseInt(useridParam);

                        Vector<PurchaseConfirmation> vectorNameNationality = new Vector<PurchaseConfirmation>();
                        String nameParam = "", nationalityParam = "", titleParam = "";
                        for(int i=0; i<qty; i++){
                            titleParam = request.getParameter("detailTitle"+(i+1));
                            nameParam = request.getParameter("detailName"+(i+1));
                            nationalityParam = request.getParameter("detailNationality"+(i+1));
                            vectorNameNationality.add(new PurchaseConfirmation(titleParam, nameParam, nationalityParam));
                        }

                        Date todayDate = new Date();
                        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                        String today = formatter.format(todayDate);
                        
                        String insertHeader = "INSERT INTO transaction_header (ticket_id, buyer, status, cabin_class, order_date) VALUES (?,?,?,?,?)";
                        PreparedStatement stInsertHeader = con.prepareStatement(insertHeader);

                        stInsertHeader.setInt(1, ticket_id);
                        stInsertHeader.setInt(2, user_id);
                        stInsertHeader.setString(3, "Canceled");
                        stInsertHeader.setString(4, cabinClass);
                        stInsertHeader.setString(5, today);

                        stInsertHeader.executeUpdate();
                        

                        //untuk insert id transaction_header ke dlm transaction_detail
                        String query_totalData = "SELECT COUNT(*) AS 'total_data' FROM ticket";
                        
                        int totalHeader = 0;
                        String totalHeaderQuery = "SELECT COUNT(*) AS 'total_header' FROM transaction_header";
                        Statement stTotalHeader = con.createStatement();
                        ResultSet rsTotalHeader = stTotalHeader.executeQuery(totalHeaderQuery);

                        if(rsTotalHeader.next()) totalHeader = Integer.parseInt((String) rsTotalHeader.getString("total_header"));
                        else totalHeader = 0;

                        
                        for(int i=0; i<qty; i++){
                            String insertDetail = "INSERT INTO transaction_detail (transaction_header_id, title, name, nationality) VALUES (?,?,?,?)";
                            PreparedStatement stInsertDetail = con.prepareStatement(insertDetail);

                            stInsertDetail.setInt(1, totalHeader);
                            stInsertDetail.setString(2, vectorNameNationality.get(i).getTitle());
                            stInsertDetail.setString(3, vectorNameNationality.get(i).getName());
                            stInsertDetail.setString(4, vectorNameNationality.get(i).getNationality());

                            stInsertDetail.executeUpdate();
                        }
                        
                        response.sendRedirect("../homePage.jsp");
                    }
                    catch(Exception e){
                        System.out.println(e);
                    }
                }
            }

            if(pay!=null){
                try{
                    String ticketIdParam = request.getParameter("ticketid");
                    String qtyParam = request.getParameter("qty");
                    String useridParam = request.getParameter("userid");
                    String cabinClass = request.getParameter("cabinClass");

                    int ticket_id = Integer.parseInt(ticketIdParam);
                    int qty = Integer.parseInt(qtyParam);
                    int user_id = Integer.parseInt(useridParam);

                    Vector<PurchaseConfirmation> vectorNameNationality = new Vector<PurchaseConfirmation>();
                    String nameParam = "", nationalityParam = "", titleParam = "";
                    for(int i=0; i<qty; i++){
                        titleParam = request.getParameter("detailTitle"+(i+1));
                        nameParam = request.getParameter("detailName"+(i+1));
                        nationalityParam = request.getParameter("detailNationality"+(i+1));
                        vectorNameNationality.add(new PurchaseConfirmation(titleParam, nameParam, nationalityParam));
                    }

                    Date todayDate = new Date();
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    String today = formatter.format(todayDate);
                    
                    //comment dulu biar ga redundant
                    
                    String insertHeader = "INSERT INTO transaction_header (ticket_id, buyer, status, cabin_class, order_date) VALUES (?,?,?,?,?)";
                    PreparedStatement stInsertHeader = con.prepareStatement(insertHeader);

                    stInsertHeader.setInt(1, ticket_id);
                    stInsertHeader.setInt(2, user_id);
                    stInsertHeader.setString(3, "Pending");
                    stInsertHeader.setString(4, cabinClass);
                    stInsertHeader.setString(5, today);

                    stInsertHeader.executeUpdate();
                    
                    

                    //untuk insert id transaction_header ke dlm transaction_detail
                    //ambil max-nya
                    int totalHeader = 0;
                    String totalHeaderQuery = "SELECT MAX(transaction_header_id) AS 'max_header_id' FROM transaction_header";
                    Statement stTotalHeader = con.createStatement();
                    ResultSet rsTotalHeader = stTotalHeader.executeQuery(totalHeaderQuery);
                    out.println(totalHeader);

                    if(rsTotalHeader.next()) totalHeader = Integer.parseInt((String) rsTotalHeader.getString("max_header_id"));
                    else totalHeader = 0;
                    out.println(totalHeader);

                    
                    for(int i=0; i<qty; i++){
                        String insertDetail = "INSERT INTO transaction_detail (transaction_header_id, title, name, nationality) VALUES (?,?,?,?)";
                        PreparedStatement stInsertDetail = con.prepareStatement(insertDetail);

                        stInsertDetail.setInt(1, totalHeader);
                        stInsertDetail.setString(2, vectorNameNationality.get(i).getTitle());
                        stInsertDetail.setString(3, vectorNameNationality.get(i).getName());
                        stInsertDetail.setString(4, vectorNameNationality.get(i).getNationality());

                        stInsertDetail.executeUpdate();
                    }
                    

                    //update available seat di table ticket
                    int totalSeat = -1;
                    
                    String getSeatQuery = "SELECT seat FROM ticket WHERE ticket_id="+ticket_id;
                    Statement stGetSeat = con.createStatement();
                    ResultSet rsGetSeat = stGetSeat.executeQuery(getSeatQuery);
                    

                    if(rsGetSeat.next()){
                        totalSeat = rsGetSeat.getInt("seat");
                    }


                    if(totalSeat > -1){
                        totalSeat -= qty;
                        if(totalSeat < 0) totalSeat = 0;

                        String setSeatQuery = "UPDATE ticket SET seat = "+totalSeat+" WHERE ticket_id="+ticket_id;
                        Statement stSetSeat = con.createStatement();
                        stSetSeat.executeUpdate(setSeatQuery);
                        
                    }

                    response.sendRedirect("../homePage.jsp");
                    
                }
                catch(Exception e){
                    System.out.println(e);
                }
            }
        }
        else if(fromPage.equals("transactionList")){
            try{
                /*
                    btn=delete&id=5
                */
                int headerId = Integer.parseInt(request.getParameter("id"));

                //delete detailnya dulu, bisa jalan, tp comment dulu
                
                String deleteDetail = "DELETE FROM transaction_detail WHERE transaction_header_id="+headerId;
                st.executeUpdate(deleteDetail);
                

                //delete yg di header
                String deleteHeader = "DELETE FROM transaction_header WHERE transaction_header_id="+headerId;
                Statement stDeleteHeader = con.createStatement();
                stDeleteHeader.executeUpdate(deleteHeader);

                response.sendRedirect("../adminTransactionList.jsp");
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("transactionDetail")){
            try{
                /*
                    btnType=approve
                    headerId=1
                */

                String btnType = request.getParameter("btnType");
                
                if(btnType != null){
                    if(btnType.equals("approve")){
                        int headerId = Integer.parseInt(request.getParameter("headerId"));
                        
                        String query_update = "UPDATE transaction_header SET status = 'Approved' WHERE transaction_header_id="+headerId;
                        st.executeUpdate(query_update);
                        response.sendRedirect("../adminTransactionList.jsp");
                    }
                    else if(btnType.equals("reject")){
                        int headerId = Integer.parseInt(request.getParameter("headerId"));

                        //dapetin ticket_id dari headerId di table transaction_header
                        int ticket_id=0;
                        String getTicketId = "SELECT ticket_id FROM transaction_header WHERE transaction_header_id="+headerId;
                        Statement stGetTicketId = con.createStatement();
                        ResultSet rsTicketId = stGetTicketId.executeQuery(getTicketId);

                        if(rsTicketId.next()){
                            ticket_id = rsTicketId.getInt("ticket_id");
                        }
                        
                        //update lagi seat nya
                        int qty=0;
                        String getQty = "SELECT COUNT(*) AS 'qty' FROM transaction_detail WHERE transaction_header_id="+headerId;
                        Statement stGetQty = con.createStatement();
                        ResultSet rsQty = stGetQty.executeQuery(getQty);

                        if(rsQty.next()){
                            qty = rsQty.getInt("qty");
                        }

                        int totalSeat = -1;
                        String getSeatQuery = "SELECT seat FROM ticket WHERE ticket_id="+ticket_id;
                        Statement stGetSeat = con.createStatement();
                        ResultSet rsGetSeat = stGetSeat.executeQuery(getSeatQuery);
                        
                        if(rsGetSeat.next()) totalSeat = rsGetSeat.getInt("seat");
                        totalSeat += qty;
                        

                        
                        String setSeatQuery = "UPDATE ticket SET seat = "+totalSeat+" WHERE ticket_id="+ticket_id;
                        Statement stSetSeat = con.createStatement();
                        stSetSeat.executeUpdate(setSeatQuery);
                        

                        String query_update = "UPDATE transaction_header SET status = 'Rejected' WHERE transaction_header_id="+headerId;
                        st.executeUpdate(query_update);
                        
                        response.sendRedirect("../adminTransactionList.jsp");
                    }
                    else if(btnType.equals("delete")){
                        int detailId = Integer.parseInt(request.getParameter("detailId"));

                        String delete = "DELETE FROM transaction_detail WHERE transaction_detail_id="+detailId;
                        st.executeUpdate(delete);
                        response.sendRedirect("../adminTransactionList.jsp");
                    }
                }
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
        else if(fromPage.equals("trackOrder")){
            try{
                //user cancel sendiri order-an nya dr page track order
                int headerId = Integer.parseInt(request.getParameter("id"));

                //update lagi seat nya
                int qty=0;
                String getQty = "SELECT COUNT(*) AS 'qty' FROM transaction_detail WHERE transaction_header_id="+headerId;
                Statement stGetQty = con.createStatement();
                ResultSet rsQty = stGetQty.executeQuery(getQty);

                if(rsQty.next()){
                    qty = rsQty.getInt("qty");
                }

                //dapetin ticket_id dari headerId
                int ticket_id = 0;
                String getTicketId = "SELECT ticket_id FROM transaction_header WHERE transaction_header_id="+headerId;
                Statement stTicketId = con.createStatement();
                ResultSet rsTicketId = stTicketId.executeQuery(getTicketId);

                if(rsTicketId.next()) ticket_id = rsTicketId.getInt("ticket_id");

                int totalSeat = -1;
                String getSeatQuery = "SELECT seat FROM ticket WHERE ticket_id="+ticket_id;
                Statement stGetSeat = con.createStatement();
                ResultSet rsGetSeat = stGetSeat.executeQuery(getSeatQuery);
                        
                if(rsGetSeat.next()) totalSeat = rsGetSeat.getInt("seat");
                out.println(totalSeat);
                totalSeat += qty;
                out.println(totalSeat);

                
                String setSeatQuery = "UPDATE ticket SET seat = "+totalSeat+" WHERE ticket_id="+ticket_id;
                Statement stSetSeat = con.createStatement();
                stSetSeat.executeUpdate(setSeatQuery);
                

                String query = "UPDATE transaction_header SET status='Canceled' WHERE transaction_header_id="+headerId;
                st.executeUpdate(query);

                response.sendRedirect("../homePage.jsp");
            }
            catch(Exception e){
                System.out.println(e);
            }
        }
    }      
%>