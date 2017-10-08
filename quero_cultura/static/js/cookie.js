function writeCookie(name, value, days) {
    //by default, there is no expiration, the cookie is temporary
    var expires = "";

    //Specifie the number of days to save the cookie
    if(days){
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    }

    if(value != "" && value != null && value != "null") {
        //sets the cookie with the name, value, and expiration date
        document.cookie = name + "=" + value + expires + "; path=/";
    }
}

function readCookie (name) {
    //finds the specified cookie and returns its value
    var searchName = name + "=";
    var cookies = document.cookie.split(';');
    for(var i=0; i < cookies.length; i++){
        var c = cookies[i];
        while (c.charAt(0) == ' ')
            c = c.substring(1, c.length);
        if (c.indexOf(searchName) == 0)
            return c.substring(searchName.length, c.length);
    }
    return null;
}

function eraseCookie(name) {
    //delete the cookie
    writeCookie(name, "", -1);
}
