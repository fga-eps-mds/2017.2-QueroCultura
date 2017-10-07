function writeCookie(name, value, days) {
    //por default, não existe expiração, ou seja o cookie é temporário
    var expires = "";

    //especifica o número de dias para guardar o cookie
    if(days){
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    }

    if(value != "" && value != null && value != "null") {
        //define o cookie com o nome, valor e data de expiração
        document.cookie = name + "=" + value + expires + "; path=/";
    }
}

function readCookie (name) {
    //encontra o cookie especificado e retorna o seu valor
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
    //exclui o cookie
    writeCookie(name, "", -1);
}
