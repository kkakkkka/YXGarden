<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
Connection conn = null;
try {
	Class.forName("com.mysql.jdbc.Driver");
	String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?useUnicode=true&characterEncoding=UTF-8";
	conn = DriverManager.getConnection(connectionUrl, "user", "123");
} catch (Exception e) {
	out.write("<script>alert('连接数据库出错！');</script>");
	return;
}
Statement stmt;
String msg = "";
String result = "";
String username = null;
String userAvatar = null;
String userID = null;
String motto = null;
String table = "";
String albumID = "";
int articleNum = 0;
int catNum = 0;
int tagNum = 0;
String[] color = {"#FF0066 0%, #FF00CC 100%","#9900FF 0%, #CC66FF 100%","#2196F3 0%, #42A5F5 100%","#00BCD4 0%, #80DEEA 100%","#4CAF50 0%, #81C784 100%","#FFEB3B 0%, #FFF176 100%"};
ArrayList<String> catlist = new ArrayList<String>();
ArrayList<Integer> catlistNum = new ArrayList<Integer>();
ArrayList<String> taglist = new ArrayList<String>();
ArrayList<Integer> tagcount = new ArrayList<Integer>();
String[] inittagcolor = {"#F9EBEA","#F5EEF8","#D5F5E3","#E8F8F5","#FEF9E7", "rgb(163, 238, 217)"};
ArrayList<String> tagcolor = new ArrayList<String>();
for (int i=0; i<inittagcolor.length; i++)
	tagcolor.add(inittagcolor[i]);
ArrayList<String> piclist = new ArrayList<String>();
username = (String)session.getAttribute("userName");
String conStr = "jdbc:mysql://172.18.187.253:3306/boke18329015" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
List<Map<String, String>> ttags = new ArrayList<>();
try {
	Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
	Connection con=DriverManager.getConnection(conStr, "user", "123");
	stmt = con.createStatement(); // 创建MySQL语句的对象
	/* 1.拿到userID */
	//用户头像路径，座右铭及特有ID
	String sql_1 = "select * from user where userName = '"+ username +"';";
	ResultSet rs_1 = stmt.executeQuery(sql_1);//执行查询，返回结果集
	while(rs_1.next()) { //把游标(cursor)移至第一个或下一个记录
		userAvatar = rs_1.getString("userAvatar");
		motto = rs_1.getString("motto");
		userID = rs_1.getString("userID");
	}
	rs_1.close(); 
	stmt.close(); con.close();
}
catch (Exception e){
	msg = e.getMessage();
}
%>

<%
try {
	String newpasswd = new String(request.getParameter("newpasswd"));
	String newmotto = new String(request.getParameter("motto"));
	Class.forName("com.mysql.jdbc.Driver");
	String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?useUnicode=true&characterEncoding=UTF-8";
	conn = DriverManager.getConnection(connectionUrl, "user", "123");
	String SQL = String.format("update user set password = '%s' where userID = %s;", newpasswd, userID);
	stmt = conn.createStatement();
	stmt.executeUpdate(SQL);
	SQL = String.format("update user set motto = '%s' where userID = %s;", newmotto, userID);
	stmt = conn.createStatement();
	stmt.executeUpdate(SQL);	
	out.println("更新成功！");
	response.setStatus(200);
	stmt.close();
	conn.close();
} catch (Exception e) {
	out.println("更新失败！");
	response.setStatus(404);
	out.println(e.getMessage());
}
%>