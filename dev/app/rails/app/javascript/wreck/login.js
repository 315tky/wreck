
document.addEventListener("DOMContentLoaded", function(){
  var login = document.getElementById("login");

  login.addEventListener("click", myFunction);

  function myFunction() {
    location.href = "https://login.eveonline.com/v2/oauth/authorize?response_type=code&redirect_uri=http://localhost:8080/user/login&client_id=0ad0f6f59d594782b795023d1d6ec5d3&scope=esi-characters.read_standings.v1&state=thisistheuniquestring";
    console.log("hello world")
    //fetch('https://login.eveonline.com/oauth/authorize?response_type=code&redirect_uri=http://pokill.saigos.space&client_id=0ad0f6f59d594782b795023d1d6ec5d3&scope=esi-characters.read_standings.v1', {
    //  mode: 'no-cors' // suppress 'cors' warning for now
    //})
    //.then((response) => {
    //  return response;
    //})
    //.then((data) => {
    //  console.log(data);
    //})
    //.catch(function(error) {
    //  console.log('Looks like there was a problem: \n', error);
    //});
  };
});
