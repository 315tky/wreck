
document.addEventListener("DOMContentLoaded", function(){
  var login = document.getElementById("login");

  login.addEventListener("click", myFunction);

  function myFunction() {

    console.log("hello world")
    fetch('https://pokill.saigos.space', {
      mode: 'no-cors' // suppress 'cors' warning for now
    })
    .then((response) => {
      return response;
    })
    .then((data) => {
      console.log(data);
    })
    .catch(function(error) {
      console.log('Looks like there was a problem: \n', error);
    });
  };
});
