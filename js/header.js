function scrollTop() {
  return Math.max(document.body.scrollTop, document.documentElement.scrollTop);
}
window.onscroll = function () {
  var top = scrollTop();
  var nav = document.getElementById("nav_header");
  var toTopButton = document.getElementById("toTopButton");
  if (top > 0) {
    nav.classList.remove("nav-transparent");
    toTopButton.style.display = "block";
  } else {
    nav.classList.add("nav-transparent");
    toTopButton.style.display = "none";
  }
}
