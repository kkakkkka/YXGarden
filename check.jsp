<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>  
    <% 
       String userID=request.getParameter("userID");
       String password=request.getParameter("password");
       out.println("your userID is:"+userID+"<br/>");
       out.println("your password is:"+password+"<br/>");
	    Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
			conn = DriverManager.getConnection(connectionUrl, "user", "123");
			out.println("数据库连接成功!"+"<br/>");  
		} catch (Exception e) {
			out.write("<script>alert('连接数据库出错！');</script>");
			return;
		}
          // 判断 数据库连接是否为空  
       
        String sql="select * from user where userID='"+userID+"' and password='"+password+ "'";  
        Statement stmt = conn.createStatement();
        ResultSet rs=stmt.executeQuery(sql);
        if(rs.next()){
        	session.putValue("userID",userID);
            response.sendRedirect("home.jsp");
        }else{  
            out.print("用户名或密码错误，请重新输入！");  %>
     <       <a href="sign_in.jsp">返回登录界面</a> 
            <%
        }
        // 输出连接信息  
        //out.println("数据库连接成功！");  
        // 关闭数据库连接  
        conn.close();  
           
               %>
    </body>  
</html>