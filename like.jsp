<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%
try {
	Statement stmt;
	Class.forName("com.mysql.jdbc.Driver");
	String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?useUnicode=true&characterEncoding=UTF-8";
	Connection conn = null;
	conn = DriverManager.getConnection(connectionUrl, "user", "123");
	String blogid = new String(request.getParameter("blogid"));
	String userid = new String(request.getParameter("userid"));
	// 康康这个用户有没有记录先
	String sql_1 = "select count(*) from likes where userID = " + userid + " and blogid = " + blogid +  ";";
	stmt = conn.createStatement();
	ResultSet rs_1 = stmt.executeQuery(sql_1);//执行查询，返回结果集
	String count = "0";
	while (rs_1.next()) { //把游标(cursor)移至第一个或下一个记录
		count = rs_1.getString("count(*)");
	}
	String SQL;
	// 没记录就插入
	if (count.equals("0")) {
		SQL = String.format("insert into likes(userID, blogID, likeorNot) values(%s, %s, 1);", userid, blogid);
		stmt = conn.createStatement();
		stmt.executeUpdate(SQL);
		out.println("点赞成功！");
	} else { // 有记录就更新
		SQL = String.format("update likes set likeornot = 1 where userid=%s and blogID=%s;", userid, blogid);
		stmt = conn.createStatement();
		stmt.executeUpdate(SQL);
		out.println("您已经点赞过这个博客了！");
	}
	response.setStatus(200);
	stmt.close();
	conn.close();
} catch (Exception e) {
	out.println("点赞失败！");
	response.setStatus(404);
	out.println(e.getMessage());
}
%>