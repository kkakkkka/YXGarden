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
        <div class="tit" style="margin-bottom: 22px">修改用户信息</div>
        <form class="login-table" style="box-shadow:none" action="makechange.jsp" method="post" onsubmit="return ifsame()" enctype="multipart/form-data">
        <input id="password" name="password" required="required" type="password" placeholder="新密码(不少于3位)">
        <input id="re-password" name="re-password" required="required" type="password" placeholder="请重复输入新密码">
        <input id="motto" name="motto" type="text" placeholder="个性签名(选填)" />
        <input id="homepage" name="homepage" type="text" placeholder="个人主页URL(选填)" />
        <br>
        <a href="javascript:;" class="a-upload" style="color: gray;" id="ava_a">
            <input type="file" name="avatar" accept="image/*" id="avafile">点击这里上传头像
        </a>
        <button type="submit" id="submitbutton">提交</button>
        </form>
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
    	window.setInterval(function(){
    		var img = document.getElementById('avafile');
			if(img.files){
				if(img.files[0]){
					var txtnode = document.getElementById('ava_a').lastChild;
        			txtnode.nodeValue = img.files[0].name;
				}
			}
    	}, 100);
        function ifsame() {
            var motto = document.getElementById("motto").value;
            var rePassword = document.getElementById("re-password").value;
            var password = document.getElementById("password").value;
            var homepage = document.getElementById("homepage").value;
            var registerButton = document.getElementById("submitbutton");
            if (!homepage)
            	homepage = "about:blank";
            else if (homepage.startsWith("www.")) // 有www，没有https
            	homepage = "https://"+homepage;
            else if (homepage.search("://") == -1) // 既没有www，又没有https或http或其他绝对路径
            	homepage = "https://www."+homepage;
            
            // 防止SQL注入
            motto = motto.replaceAll(".*([';]+|(--)+).*", " ");
            homepage = homepage.replaceAll(".*([';]+|(--)+).*", " ");
            
            var zg = new RegExp(/^((?![0-9]+$)|(?![a-zA-Z]+$))[0-9A-Za-z]*$/);
            if (!zg.test(password)) { // 检查密码组成
            	alert("密码只能由数字和字母组成，请重新输入！");
                document.getElementById("re-password").value = "";
                document.getElementById("password").value = "";
            } else if (rePassword != password && rePassword != "" && password != "") { // 检查两次密码是否相同
                alert("两次密码输入不相同，请重新输入！");
                document.getElementById("re-password").value = "";
                document.getElementById("password").value = "";
            } else if (password.length < 3) { // 检查密码长度
                alert("密码少于3位，请重新输入！");
            } else if (password == "") {  // 检查用户是否输入新密码
                alert("新密码不能为空！");
            } else if (rePassword == "") { // 检查用户是否重复输入新密码
                alert("请重复输入新密码！");
            } else { // 没问题了，执行相关操作
				return true;
            }
            return false;
        }
    </script>
</body>
<footer>
    <a href="home.jsp"><img src="medias/home.png" style="width: 50px;height: 50px; position: fixed; top: 20px; left: 30px;"></a>
</footer>
</html>
