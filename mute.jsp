<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%
try {
	String username = new String(request.getParameter("username"));
	String muteornot = new String(request.getParameter("muteornot"));
	Statement stmt;
	Class.forName("com.mysql.jdbc.Driver");
	String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?useUnicode=true&characterEncoding=UTF-8";
	Connection conn = null;
	conn = DriverManager.getConnection(connectionUrl, "user", "123");
	String SQL = String.format("update user set speechStatus = %s where userName='%s';", muteornot, username);
	stmt = conn.createStatement();
	stmt.executeUpdate(SQL);
	if (muteornot.equals("0")) {
		out.println("禁言成功！");
		out.println("用户【"+username+"】已被禁言");
	} else {
		out.println("解除禁言成功！");
		out.println("用户【"+username+"】已可以发言");	
	}
	response.setStatus(200);
	stmt.close();
	conn.close();
} catch (Exception e) {
	out.println("禁言失败！");
	response.setStatus(404);
	out.println(e.getMessage());
}
%>