<div class="usernameDisplay">
    <%
        String name = (String) session.getAttribute("name");

        if(name == null){
            response.sendRedirect("signIn.jsp?err=4");
        }
        else{
            out.println(name);
        }
    %>            
    
    <div class="headerMenuContent">
        <a href="process/doLogout.jsp">Logout</a>
    </div>
</div>