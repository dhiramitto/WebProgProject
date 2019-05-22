<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="assets/css/purchaseDetailStyle.css">
    <title>Purchase Detail</title>
</head>
<body>

    <div class="header">
        <div class="home">
            <a href="">Home</a>
        </div>
        <span class="headerContainer">
            <%-- nanti diganti jadi nama user dan track order kalo udh sign in --%>
            <span>Pablo Picasso</span>
        </span>
    </div>

    <%--
        dapetin parameter jumlah passenger dari homepage
        nanti loop utk jumlah field yg dapat diisi
     --%>
    <div class="content">
        <%-- form berdasarkan jumlah orangnya --%>
        <form action="">
            <%-- loop here --%>
            <div class="formPurchase">
            <%-- ada angka di sini --%> Passenger Information
            <br>
                <div class="formInput">
                    <div class="componentContainer">
                        <div class="detailText">Title</div>
                        <div class="detailField">
                            <select name="detailTitle" id="">
                                <option value="Mr. ">Mr.</option>
                                <option value="Mrs. ">Mrs.</option>
                                <option value="Ms. ">Ms.</option>
                            </select>
                        </div>
                    </div>

                    <div class="componentContainer">
                        <div class="detailText">Name</div>
                        <div class="detailField"><input type="text" name="detailName"></div>
                    </div>

                    <div class="componentContainer">
                        <div class="detailText">Nationality</div>
                        <div class="detailField">
                            <%-- ambil dari database kayaknya --%>
                            <select name="detailNationality" id="">
                                <option value="Indonesian">Indonesian</option>
                                <option value="American">American</option>
                                <option value="Chinese">Chinese</option>
                            </select>
                        </div>
                    </div>
                </div>
                <%-- end of loop --%>
                <button>Purchase Ticket(s)</button>
            </div>
        </form>
        
    </div>

    <div class="footer">Copyright &copy; 2018 TravelPortal | User Online: 0</div>
    
</body>
</html>