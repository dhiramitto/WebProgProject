<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/registerStyle.css">
    <title>Register</title>
</head>
<body>

    <div class="content">
        <div class="contentHeader">
            <div id="contentHeaderText">Sign in to our application</div>
        </div>

        <form action="">
            <div class="contentReg">
                <div class="componentContainer">
                    <div class="regText">Name</div>
                    <div class="regField"><input type="text" name="regName" id="regName"></div>
                </div>

                <div class="componentContainer">
                    <div class="regText">Email</div>
                    <div class="regField"><input type="text" name="regEmail" id="regEmail" placeholder="example@travel.dev"></div>
                </div>
                
                <div class="componentContainer">
                    <div class="regText">Password</div>
                    <div class="regField"><input type="password" name="regPassword" id="regPassword"></div>
                </div>

                <div class="componentContainer">
                    <div class="regText">Password Confirmation</div>
                    <div class="regField"><input type="password" name="regConfPassword" id="regConfPassword"></div>
                </div>


                <div class="componentContainer">
                    <div class="regText">Gender</div>
                    <div class="radio">
                        <input type="radio" name="gender" id="gender" value="Male"> Male
                        <input type="radio" name="gender" id="gender" value="Female" id="radioFemale"> Female
                    </div>
                </div>
                
                <div class="button">
                    <input type="submit" value="Sign Up" id="submitBtn">
                </div>
            </div>
        </form>

        <div class="contentSignin">Already have an account? <a href="signIn.jsp">Sign in</a> now</div>

    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal</div>
    
</body>
</html>