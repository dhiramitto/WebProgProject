<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <title>Main Page</title>
</head>
<body>

    <div class="header">
        <div class="headerText">The easiest way to find the cheapest ticket.</div>
        <span class="logInContainer">
            <span>Sign In</span>
            <span>Register</span>
        </span>
    </div>

    <div class="content">
        <div class="contentHeader">
            <h1>Where are you going?</h1>
            <br>
            Ticket anywhere only at TravelPortal
            <br>
            Booking is faster, easier and cheaper
        </div>

        <hr>

        <form action="">
            <div class="contentForm">
                <div class="formHeader"> Where are you going?</div>
                
                <div class="formPic"></div>
                
                <div class="formFromContainer">
                    From
                    <br>
                    <select name="from" id="from">
                        <option value="a">a</option>
                        <option value="b">b</option>
                    </select>
                </div>

                <div class="formToContainer">
                    To
                    <br>
                    <select name="to" id="to">
                        <option value="a">a</option>
                        <option value="b">b</option>
                    </select>
                </div>

                <div class="formDepartureContainer">
                    Departure Date
                    <br>
                    <select name="depart" id="depart">
                        <option value="a">a</option>
                        <option value="b">b</option>
                    </select>
                </div>

                <div class="formPassengersContainer">
                    Passengers
                    <br>
                    <select name="passengers" id="passengers">
                        <option value="1">1</option>
                        <option value="2">2</option>
                    </select>
                </div>

                <div class="formCabinClassContainer">
                    Cabin Class
                    <br>
                    <select name="cabinClass" id="cabinClass">
                        <option value="a">a</option>
                        <option value="b">b</option>
                    </select>
                </div>

                <div class="formSubmitContainer">
                    <input type="submit" value="Search Flight">
                </div>
            </div>
        </form>
    </div>
    
</body>
</html>