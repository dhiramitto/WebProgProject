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

%>