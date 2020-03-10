document.addEventListener("DOMContentLoaded", function(){
  var logout = document.getElementById("logout");
  var element = document.getElementById("login");
  element.parentNode.removeChild(element);
  logout.addEventListener("click", myFunction);

  function myFunction() {
    location.href = "http://localhost:8080/user/logout";
  };
});
