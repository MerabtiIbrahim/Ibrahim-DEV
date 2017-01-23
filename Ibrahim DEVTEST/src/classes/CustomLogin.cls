global class CustomLogin {
    public Integer inputname { get; set; } 
global CustomLogin () {
    inputname = (Integer)Cache.Session.get('counter');
}
}