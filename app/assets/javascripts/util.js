function all_params(new_param, new_val, params){
  if( params === undefined ){
    params = window.location.search.substring(1);
  }
  var a_params = params.split("&");

  if (a_params.length == 1 && a_params[0].length <= 1){
    a_params[0] = new_param+'='+new_val;
  } else {
    for (var i = 0; i < a_params.length; i++) {
      //se elimina el parametro antiguo para agregar el nuevo y también se eliman los parametros sin valor
      if ( a_params[i].indexOf("texto") > -1 || a_params[i].indexOf("commit") > -1
        || a_params[i].indexOf("utf8") > -1 || a_params[i].indexOf("page") > -1
        || (a_params[i].indexOf(new_param) > -1  && a_params[i].indexOf(new_param) < a_params[i].indexOf("="))
        || a_params[i].indexOf("=") == a_params[i].length - 1){ 
        a_params.splice(i, 1);
        i--;
      }
    } //end for
    if( new_val != undefined && new_val !== ""){  //espacio es igual a false por eso el doble ==
      a_params.push(new_param+'='+new_val);
    }
  } //end else
  if (a_params.length > 0){
    return a_params.join('&');
  } else {
    return "";
  }
};