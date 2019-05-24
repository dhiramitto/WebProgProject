<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/signInStyle.css">
    <title>Sign In</title>
</head>
<body>
    <%-- cek cookies --%>
    <%
        Cookie[] cookies = request.getCookies();

        String emailCookie = "";
        for(int i = 0; i < cookies.length; i++){
            if(cookies[i].getName().equals("email")){
                emailCookie = (String) cookies[i].getValue();
                break;
            }
        }

        if(!emailCookie.equals("")) response.sendRedirect("homePage.jsp");
    %>

    <div class="content">
        <div class="contentHeader">
            <div id="contentHeaderText">Sign in to our application</div>
        </div>

        <form action="process/controller.jsp?src=signin" method="POST">
            <div class="contentLogin">
                <div class="componentContainer">
                    <div class="loginText">Email</div>
                    <div class="loginField"><input type="text" name="loginEmail" id="loginEmail" placeholder="example@travel.dev"></div>
                </div>
                
                <div class="componentContainer">
                    <div class="loginText">Password</div>
                    <div class="loginField"><input type="password" name="loginPassword" id="loginPassword"></div>
                </div>


                <div class="checkboxContainer">
                    <input type="checkbox" name="rememberMe" id="rememberMe">Remember Me
                </div>

                <div class="error">
                    <%
                        String err = request.getParameter("err");

                        if(err != null){
                            if(err.equals("1")){
                                out.println("All elements must be filled!");
                            }
                            else if(err.equals("2")){
                                out.println("Invalid email format");
                            }
                            else if(err.equals("3")){
                                out.println("Incorrect email or password");
                            }
                            else if(err.equals("4")){
                                out.println("You must logged in first");
                            }
                        }
                    %>
                </div>
                
                <div class="button">
                    <input type="submit" value="Sign In" id="submitBtn">
                </div>
            </div>
        </form>

        <div class="contentSignup">Don't have an account yet? <a href="register.jsp">Sign up</a> now</div>

    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal</div>
    
</body>
</html>