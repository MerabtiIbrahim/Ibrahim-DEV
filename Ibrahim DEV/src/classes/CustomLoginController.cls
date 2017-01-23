/**
 * An apex page controller that exposes the site login functionality
 */
global with sharing class CustomLoginController {
    global Integer test{get;set;}
    global String username{get;set;}
    global String password{get;set;}
    global Integer counter { get; set; }
    global CustomLoginController () {}

    global PageReference login() {
    if(username == '1' && password == '1' ){
     if (!Cache.Session.contains('counter')) {
            Cache.Session.put('counter', 3);
        } else {
            Cache.Session.put('counter', 2);
        }
    }  
    test = 5;
return new PageReference('/apex/CustomLogin?id = test');
}
}