<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<% request.setCharacterEncoding("utf-8");
    String conStr = "jdbc:mysql://172.18.187.253:3306/boke18329015" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    try {
        Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    	Connection con=DriverManager.getConnection(conStr, "user", "123");
    	Statement stmt = con.createStatement(); // 创建MySQL语句的对象

        String username = (String)session.getAttribute("userName"); // 用户名
        String msgdel = request.getParameter("number"); // 删除的id
        String comUser = null; // 评论的主人
        int isRoot = 0; // 是否是管理员

        String sql_0 = "select userName from user where userID = (select userID from webcomment where msgID = " + msgdel + ");";
    	out.write(sql_0 + "<br>");
        ResultSet rs_0 = stmt.executeQuery(sql_0); //执行查询，返回结果集
        while (rs_0.next()) {
            comUser = rs_0.getString("userName");
        }
        rs_0.close();

        String sql_1 = "select * from user where userName = '"+ username +"';";
    	ResultSet rs_1 = stmt.executeQuery(sql_1);//执行查询，返回结果集
    	while(rs_1.next()) { //把游标(cursor)移至第一个或下一个记录
            isRoot = rs_1.getInt("isRoot");
    	}
        rs_1.close();

        if (isRoot == 1 || comUser.equals(username)) {
            String sql_3 = "delete from webcomment where msgID = " + msgdel + ";";
    	    out.write(sql_3);
            int count = stmt.executeUpdate(sql_3);
        }

        stmt.close();
        con.close();
    } catch (Exception e) {
        out.write("<script>alert('连接数据库出错！');</script>");
        return;
    }
%>

</body>
<script>
    window.history.go(-1);
</script>

</html>