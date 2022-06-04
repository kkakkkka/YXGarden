<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">

    <title>修改用户信息</title>
    <link rel="stylesheet" href="./css/57.css">
</head>

<body>
    <div class="login-table">
        <div class="tit">修改用户信息</div>
        <input id="password" name="password" required="required" type="password" placeholder="新密码(不少于3位)">
        <input id="re-password" name="password" required="required" type="password" placeholder="请重复输入新密码">
        <input id="username" name="motto" type="text" placeholder="个性签名(选填)" />
        <br>
        <a href="javascript:;" class="a-upload" style="color: gray;">
            <input type="file" name="uploadfile">点击这里上传文件
        </a>
        <button type="submit" id="submitbutton" onclick="ifsame()" >提交</button>
    </div>
    <div class="square">
        <ul>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
    <div class="circle">
        <ul>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
    <script type="text/javascript">
        function ifsame() {
            var username = document.getElementById("username").value;
            var rePassword = document.getElementById("re-password").value;
            var password = document.getElementById("password").value;
            var registerButton = document.getElementById("submitbutton");
            if (rePassword != password && rePassword != "" && password != "") {
                alert("两次密码输入不相同，请重新输入！");
                document.getElementById("re-password").value = "";
                document.getElementById("password").value = "";
            }
            if (password.length < 3) {
                alert("密码少于3位，请重新输入！");
            } else if (password == "") {
                alert("新密码不能为空！");
            } else if (rePassword == "") {
                alert("请重复输入新密码！");
            } else {
				var xmlhttp = new XMLHttpRequest();
				xmlhttp.onreadystatechange = function () {
				  if (xmlhttp.readyState == 4) {
				    alert(xmlhttp.responseText);
				    if (xmlhttp.status == 200) {
				      location.reload();
				    }
				  }
				};
				xmlhttp.open("get", "makechange.jsp?newpasswd=" + password, true);
				xmlhttp.send(null);
            }
        }
    </script>
</body>
<footer>
    <a href="home.jsp"><img src="medias/home.png" style="width: 50px;height: 50px; position: fixed; top: 20px; left: 30px;"></a>
</footer>
</html>