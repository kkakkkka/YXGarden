<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">

    <title>登录失败</title>
    <link rel="stylesheet" href="css/57.css">
    
</head>

<body>
	<%!
		public static String TransactSQLInjection(String str)
	    {
	          return str.replaceAll(".*([';]+|(--)+).*", " ");
	
	    }
	%>
    <% 
    	
       String userName=request.getParameter("userName");
       String password=request.getParameter("password");
       userName=TransactSQLInjection(userName);
       password=TransactSQLInjection(password);
       
	    Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
			conn = DriverManager.getConnection(connectionUrl, "user", "123");
		} catch (Exception e) {
			out.write("<script>alert('连接数据库出错！');</script>");
			return;
		}
          // 判断 数据库连接是否为空  
       
        String sql="select * from user where userName='"+userName+"' and password='"+password+ "'";  
        Statement stmt = conn.createStatement();
        ResultSet rs=stmt.executeQuery(sql);
        if(rs.next()){
        	session.putValue("userName",userName);
            response.sendRedirect("home.jsp");
        }
        // 输出连接信息  
        //out.println("数据库连接成功！");  
        // 关闭数据库连接  
        conn.close();  
           
         %>
        <div class="login-table" style="height:250px;">
        	<div class="tit" style="margin: 15px auto 10px auto;">登录失败</div>
        	<div class="baocuo" style="font-size: 20px;margin: 50px auto 80px auto;">提示：密码错误</div>
        	<a href="login.jsp">返回登录界面</a>
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
    </body>  
</html>