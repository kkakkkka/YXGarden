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

    <title>后台管理</title>
    <link rel="stylesheet" href="./css/57.css">
</head>
<style>
input:checked+span {
	color: red;
}
div.muteornot input {
	width: 15px;
	height: 15px;
	margin-left: 5px;
	margin-right: 5px;
	margin-top: 25px;
	margin-bottom: 0;
}
</style>
<body>
    <div class="login-table" style="height:350px;">
        <div class="tit" style="margin-bottom: 50px">设置用户发言状态</div>
        <input id="username" name="username" required="required" type="text" placeholder="用户名">
       	<div>
			<div class="muteornot" style="padding: 0; margin: 0; border: 0;">
				<input type="radio" name="muteornot" value="0" class="muteornot" id="muteornot"><span>设置禁言</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="muteornot" value="1" class="muteornot" id="muteornot"><span>解除禁言</span>
			</div>
       	</div>
		<br>
        <button type="submit" id="submitbutton" onclick="ifsame()" style="margin-top:0" >提交</button>
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
            var muteornot = document.getElementsByName("muteornot");
            var prefix = null;
            for(i=0;i<muteornot.length;i++){
            	if(muteornot[i].checked){
            		prefix = muteornot[i].value;
            		break;
                }
            }
            if (username.length == 0) {
                alert("用户名不能为空，请重新输入！");
            } else if (!prefix) {
            	alert("请选择用户发言状态！");
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
				xmlhttp.open("get", "mute.jsp?username=" + username + "&muteornot=" + prefix, true);
				xmlhttp.send(null);
            }
        }
    </script>
</body>
<footer>
    <a href="home.jsp"><img src="medias/home.png" style="width: 50px;height: 50px; position: fixed; top: 20px; left: 30px;"></a>
</footer>
</html>
