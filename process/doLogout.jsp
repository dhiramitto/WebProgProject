<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<%
   session.invalidate();
   int online = (Integer) application.getAttribute("online");

   if(online != 0)
   {
       online--;
       application.setAttribute("online", online);
   }

   Cookie[] cookieS = request.getCookies();

   for(int i = 0 ; i < cookieS.length; i++){

        if(cookieS[i].getName().equals("email")){
           cookieS[i].setMaxAge(0);
           cookieS[i].setPath("/");
           response.addCookie(cookieS[i]);
           break;
       }
   }

   response.sendRedirect("../signIn.jsp");
%>