function delBlog(blogID) {
  var xmlhttp = new XMLHttpRequest();
  xmlhttp.onreadystatechange = function () {
    if (xmlhttp.readyState == 4) {
      alert(xmlhttp.responseText);
      if (xmlhttp.status == 200) {
        location.reload();
      }
    }
  };
  xmlhttp.open("get", "delBlog.jsp?blogID=" + blogID, true);
  xmlhttp.send(null);
}