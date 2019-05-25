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

%>