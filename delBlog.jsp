<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%
try {
	int blogID = Integer.parseInt(request.getParameter("blogID"));
	Connection conn = null;
	Class.forName("com.mysql.jdbc.Driver");
	String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?useUnicode=true&characterEncoding=UTF-8";
	conn = DriverManager.getConnection(connectionUrl, "user", "123");
	String SQL = String.format("delete from blog where blogID = %d;", blogID);
	Statement stmt = conn.createStatement();
	stmt.executeUpdate(SQL);
	out.println("删除成功！");
	response.setStatus(200);
	stmt.close();
	conn.close();
} catch (Exception e) {
	out.println("删除失败！");
	response.setStatus(404);
	out.println(e.getMessage());
}
%>