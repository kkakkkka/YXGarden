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

        // userID
        String username = (String)session.getAttribute("userName"); // 用户名
        String userID = null;
        String sql_1 = "select * from user where userName = '"+ username +"';";
    	ResultSet rs_1 = stmt.executeQuery(sql_1);
    	while(rs_1.next()) {
    		userID = rs_1.getString("userID");
    	}
        rs_1.close();
        out.write(userID + "<br>");

        // content
        String comment = request.getParameter("comment");
        out.write(comment + "<br>");
        
        // userPlace
        String ip = "中山大学"; // https://www.cnblogs.com/face-ghost-coder/p/8867855.html, later to translate ip to place
        out.write(ip + "<br>");
        
        // update
        String sql_3 = "insert into webcomment(userID, userPlace, content) values(" + userID + ", '" 
                        + ip + "', '" + comment + "');";
        out.write(sql_3 + "<br>");
        int count = stmt.executeUpdate(sql_3);
        stmt.close();
    } catch (Exception e) {
        out.write("<script>alert('连接数据库出错！');</script>");
        return;
    }

    response.sendRedirect("comment.jsp");
    if(true){
    	return;
    }
%>

</body>
<%-- <script>
    window.self.location = "comment.jsp";
</script> --%>

</html>