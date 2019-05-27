<%
    class User{
        private int id;
        private String name;
        private String email;
        private String password;
        private String gender;

        public User(int id, String name, String email, String password, String gender){
            this.id = id;
            this.name = name;
            this.email = email;
            this.password = password;
            this.gender = gender;
        }

        public int getId(){
            return id;
        }

        public String getName(){
            return name;
        }

        public String getEmail(){
            return email;
        }

        public String getPassword(){
            return password;
        }

        public String getGender(){
            return gender;
        }
    }

    class City{
        private int id;
        private String cityName;
        private String countryName;

        public City(int id, String city, String country){
            this.id = id;
            cityName = city;
            countryName = country;
        }

        public int getId(){
            return id;
        }

        public String getCityName(){
            return cityName;
        }

        public String getCountryName(){
            return countryName;
        }
    }

    class Ticket{
        private int id;
        private String airline;
        private String from;
        private String to;
        private String departDate;
        private int priceEco;
        private int priceBusiness;
        private int seat;

        public Ticket(int id, String airline, String from, String to, String departDate, int priceEco, int priceBusiness, int seat){
            this.id = id;
            this.airline = airline;
            this.from = from;
            this.to = to;
            this.departDate = departDate;
            this.priceEco = priceEco;
            this.priceBusiness = priceBusiness;
            this.seat = seat;
        }

        public int getId(){
            return id;
        }

        public String getAirline(){
            return airline;
        }

        public String getFrom(){
            return from;
        }

        public String getTo(){
            return to;
        }

        public String getDepartDate(){
            return departDate;
        }

        public int getPriceEco(){
            return priceEco;
        }

        public int getPriceBusiness(){
            return priceBusiness;
        }

        public int getSeat(){
            return seat;
        }
    }

    class Airline{
        private String airlineName;

        public Airline(String airline){
            this.airlineName = airline;
        }

        public String getAirline(){
            return airlineName;
        }
    }

    class CityName{
        private String cityName;

        public CityName(String city){
            cityName = city;
        }

        public String getCity(){
            return cityName;
        }

    }

    class TransactionHeader{
        private int id;
        private String orderDate;
        private int buyer;
        private String status;

        public TransactionHeader(int id, String orderDate, int buyer, String status){
            this.id = id;
            this.orderDate = orderDate;
            this.buyer = buyer;
            this.status = status;
        }

        public int getId(){
            return id;
        }

        public String getOrderDate(){
            return orderDate;
        }

        public int getBuyer(){
            return buyer;
        }

        public String getStatus(){
            return status;
        }
    }

    class SearchResult{
        private int ticketId;
        private String airline;
        private String from;
        private String to;
        private int price;

        public SearchResult(int ticketId, String airline, String from, String to, int price){
            this.ticketId = ticketId;
            this.airline = airline;
            this.from = from;
            this.to = to;
            this.price = price;
        }

        public int getTicketId(){
            return ticketId;
        }

        public String getAirline(){
            return airline;
        }

        public String getFrom(){
            return from;
        }

        public String getTo(){
            return to;
        }

        public int getPrice(){
            return price;
        }
    }

    class PurchaseConfirmation{
        private String title;
        private String name;
        private String nationality;

        public PurchaseConfirmation(String title, String name, String nationality){
            this.title = title;
            this.name = name;
            this.nationality = nationality;
        }
        
        public String getTitle(){
            return title;
        }

        public String getName(){
            return name;
        }

        public String getNationality(){
            return nationality;
        }
    }

%>