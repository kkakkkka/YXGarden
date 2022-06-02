<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">

    <title>登录界面</title>
    <link rel="stylesheet" href="css/57.css">
</head>

<body>

	<%
	Connection conn = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		conn = DriverManager.getConnection(connectionUrl, "user", "123");
	} catch (Exception e) {
		out.write("<script>alert('连接数据库出错！');</script>");
		return;
	}
	String SQL = "select userID,password,userName from user;";
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(SQL);
	List<Map<String, String>> user = new ArrayList<>();
	while (rs.next()) {
		Map<String, String> map = new HashMap<>();
		map.put("userID", rs.getString("userID"));
		map.put("password", rs.getString("password"));
		map.put("userName", rs.getString("userName"));
		/* map.put("catName", rs.getString("catName"));/* 
		map.put("tagName", rs.getString("tagName")); */
		user.add(map);
	}
	pageContext.setAttribute("user", user);
	rs.close();
	stmt.close();
	conn.close();
	
	%>
    <form action='check.jsp' method='post'>
        <div class="login-table">
            <div class="tit">登录</div>
            <input type="userID" name="userID" placeholder="账号">
            <input type="password" name="password" placeholder="密码">
            <button type='submit'>登录</button>
            <button type='button' onclick="window.location.href = 'home.jsp'">游客访问</button>                
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
    </form>
</body>
<footer>
    <a href="home.jsp"><img src="medias/home.png" style="width: 50px;height: 50px; position: fixed; top: 20px; left: 30px;"></a>
</footer>
</html>