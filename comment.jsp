<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("utf-8");
    String conStr = "jdbc:mysql://172.18.187.253:3306/boke18329015" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String username = (String)session.getAttribute("userName"); // 用户名
    String userAvatar = null; // 用户头像
    String userID = null; // 用户id
    String motto = null; // 用户格言
    ArrayList <String> msgidList = new ArrayList<String>(); // 评论号
    ArrayList <String> userList = new ArrayList<String>(); // 用户名
    ArrayList <String> userIDList = new ArrayList<String>(); // 用户ID
    ArrayList <String> avatarList = new ArrayList<String>(); // 用户头像
    ArrayList <String> palceList = new ArrayList<String>(); // 评论地点
    ArrayList <String> contentList = new ArrayList<String>(); // 评论内容
    ArrayList <String> timeList = new ArrayList<String>(); // 评论时间

    try {
        Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    	Connection con=DriverManager.getConnection(conStr, "user", "123");
    	Statement stmt = con.createStatement(); // 创建MySQL语句的对象

        //用户头像路径，座右铭及特有ID
    	String sql_0 = "select * from user where userName = '"+ username +"';";
    	ResultSet rs_0 = stmt.executeQuery(sql_0);//执行查询，返回结果集
    	while(rs_0.next()) { //把游标(cursor)移至第一个或下一个记录
    		userAvatar = rs_0.getString("userAvatar");
    		motto = rs_0.getString("motto");
    		userID = rs_0.getString("userID");
    	}
        rs_0.close();
        
        // 获取评论
        String sql_1 = "select * from webcomment order by msgID desc;";
        ResultSet rs_1 = stmt.executeQuery(sql_1);
        while (rs_1.next()) {
            msgidList.add(rs_1.getString("msgID"));
            palceList.add(rs_1.getString("userPlace"));
            contentList.add(rs_1.getString("content"));
            timeList.add(rs_1.getString("time"));
            userIDList.add(rs_1.getString("userID"));
        }
        rs_1.close();

        for (int i = 0; i < msgidList.size(); i++) {
            String tempUserID = userIDList.get(i);
            String sql_2 = "select * from user where userID = " + tempUserID + ";";
            ResultSet rs_2 = stmt.executeQuery(sql_2);
            while (rs_2.next()) {
                userList.add(rs_2.getString("userName"));
                avatarList.add(rs_2.getString("userAvatar"));
            }
            rs_2.close();
        }

        stmt.close();
        con.close();
    } catch (Exception e) {
        out.write(e.getMessage() + "<br>");
        e.printStackTrace();
        out.write("<script>alert('连接数据库出错！');</script>");
        return;
    }
%>

<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>Comment | UserName</title>
    <link rel="icon" type="image/png" href="./favicon.ico">
    <link rel="stylesheet" type="text/css" href="./css/awesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="./css/materialize/materialize.min.css">
    <link rel="stylesheet" type="text/css" href="./css/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="./css/lightGallery/css/lightgallery.min.css">
    <link rel="stylesheet" type="text/css" href="./css/matery.css">
    <link rel="stylesheet" type="text/css" href="./css/my.css">
    <link rel="stylesheet" type="text/css" href="./css/myaos.css">
    <script src="./js/myaos.js"></script>

    <link rel="alternate" href="atom.xml" title="UserName" type="application/atom+xml">
</head>


<body>
    <header class="navbar-fixed">
	<%
	Object obj = session.getAttribute("userName");
	String uname;
	if(obj==null){
		response.sendRedirect("login.jsp");
		return;
	}
	uname = obj.toString();
	pageContext.setAttribute("uname", uname);
	%>
		<link rel="stylesheet" type="text/css" href="./css/header.css?t=2">
		<script src="./js/header.js"></script>
		<nav id="nav_header" class="bg-color nav-transparent">
			<div id="navContainer" class="nav-wrapper container">
				<div class="brand-logo">
					<a href="home.jsp" class="waves-effect waves-light"> <img
						src="./medias/logo.png" class="logo-img" alt="LOGO">
					</a>
					<div id="login_to_change" style="display: inline;">
						<span class="logo-span" style="position:relative;bottom:24px;left:5px">
						<c:out value="${uname}"></c:out></span>
						<div class="login">
							<a href="login.jsp"><span>切换用户</span></a>
						</div>
					</div>
				</div>
				<a href="#" data-target="mobile-nav"
					class="sidenav-trigger button-collapse"><i class="fas fa-bars"></i></a>
				<ul class="right nav-menu">
					<li class="hide-on-med-and-down nav-item"><a href="home.jsp"
						class="waves-effect waves-light"> <i class="fas fa-home"
							style="zoom: 0.6;"></i> <span>首页</span>
					</a></li>

					<li class="hide-on-med-and-down nav-item"><a href="tags.jsp"
						class="waves-effect waves-light"> <i class="fas fa-tags"
							style="zoom: 0.6;"></i> <span>标签</span>
					</a></li>

					<li class="hide-on-med-and-down nav-item"><a
						href="categories.jsp" class="waves-effect waves-light"> <i
							class="fas fa-bookmark" style="zoom: 0.6;"></i> <span>分类</span>
					</a></li>

					<li class="hide-on-med-and-down nav-item"><a
						href="archives-1.jsp" class="waves-effect waves-light"> <i
							class="fas fa-archive" style="zoom: 0.6;"></i> <span>归档</span>
					</a></li>

					<li class="hide-on-med-and-down nav-item"><a href="about.jsp"
						class="waves-effect waves-light"> <i
							class="fas fa-user-circle" style="zoom: 0.6;"></i> <span>关于</span>
					</a></li>

					<li class="hide-on-med-and-down nav-item"><a
						href="comment.jsp" class="waves-effect waves-light"> <i
							class="fas fa-comments" style="zoom: 0.6;"></i> <span>留言板</span>
					</a></li>

					<li class="hide-on-med-and-down nav-item"><a
						href="friends.jsp" class="waves-effect waves-light"> <i
							class="fas fa-address-book" style="zoom: 0.6;"></i> <span>用户信息</span>
					</a></li>
				</ul>
			</div>
		</nav>
	</header>

    <div class="bg-cover pd-header about-cover">
        <div class="container">
            <div class="row">
                <div class="col s10 offset-s1 m8 offset-m2 l8 offset-l2">
                    <div class="brand">
                        <div class="title center-align">
                            记录一些过程
                        </div>
                        <div class="description center-align">
                            <span id="subtitle"></span>
                            <script src="./js/myTyped.js"></script>
                            <script>
                                var typed = new Typed("#subtitle", {
                                    strings: [
                                        "从来没有真正的绝境, 只有心灵的迷途",
                                        "Never really desperate, only the lost of the soul",
                                    ],
                                    startDelay: 300,
                                    typeSpeed: 100,
                                    loop: true,
                                    backSpeed: 50,
                                    showCursor: true
                                });
                            </script>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                // 每天切换 banner 图.  Switch banner image every day.
                var bannerUrl = "./medias/banner/" + new Date().getDay() + '.jpg';
                var pick = Math.floor(Math.random() * 7);
                var bannerUrl = "./medias/banner/" + pick + '.jpg';
                var csstext = document.getElementsByClassName("bg-cover")[0];
                csstext.style.cssText += "background-image: url( " + bannerUrl + "  )";
            </script>
        </div>
    </div>

    <main class="content" style="min-height: 584px;">
    <script src="./js/comments.js"></script>
    <div id="contact" class="container chip-container">
        <div class="card">
            <div class="card-content">
                <div class="tag-title center-align">
                    <i class="fas fa-comments"></i>&nbsp;&nbsp;留言板
                </div>
                <div class="comment-container">
                    <div class="comment-send">
                        <form id="commentForm" action="comment_insert.jsp" method="post">
                            <span class="comment-avatar">
                                <img src="<%=userAvatar%>.jpg" alt="avatar">
                            </span>
                            <textarea class="comment-send-input" name="comment" form="commentForm" cols="80" rows="5" placeholder="请自觉遵守互联网相关的政策法规，严禁发布色情、暴力、反动的言论。"></textarea>
                            <input class="comment-send-button" type="submit" value="发表留言">
                        </form>
                    </div>
                    <%
                    for (int i = 0; i < msgidList.size(); i++) {
                    %>
                    <div class="comment-list" id="commentList">
                        <div class="comment">
                            <span class="comment-avatar">
                                <img src="<%=avatarList.get(i)%>.jpg" alt="avatar">
                            </span>
                            <div class="comment-content">
                                <p class="comment-content-name"><%=userList.get(i)%></p>
                                <p class="comment-content-article"><%=contentList.get(i)%></p>
                                <p class="comment-content-footer">
                                    <span class="comment-content-footer-id">#<%=msgidList.get(i)%></span>
                                    <span class="comment-content-footer-device"><%=palceList.get(i)%></span>
                                    <span class="comment-content-footer-timestamp"><%=timeList.get(i)%></span>
                                </p>
                            </div>
                            <div class="comment-cls"></div>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <div class="card"></div>
    </div>
    </main>

    <footer class="page-footer bg-color">
        <a href="new.html"><img src="./medias/add.png" style="width: 37px;height: 37px; position: fixed; bottom: 60px; right: 11px;"></a>

        <div id="toTopButton" style="position: fixed;right: 10px;bottom:10px;cursor: pointer;display: none;" onclick="returnToTop()">
            <img src="./medias/arrow.png" style="width: 40px;height: 40px; ">
            <script>
                function returnToTop() {
                    document.body.scrollTop = 0;
                    document.documentElement.scrollTop = 0;
                }
            </script>
        </div>
        <div class="container row center-align" style="margin-bottom: 15px !important;">
            <div class="s12 copy-right">
                Copyright&nbsp;&copy;
                <span id="year">2022</span>
                <a href="about.html" target="_blank">逸仙苑</a> |&nbsp;Powered by&nbsp;<a href="https://www.sysu.edu.cn/" target="_blank">SYSU</a> |&nbsp;Organization&nbsp;
                <a href="https://cse.sysu.edu.cn/" target="_blank">CSE</a>
                <br>
            </div>
        </div>
    </footer>
</body>

<script>
    if (window.name != "bencalie") {
        location.reload();
        window.name = "bencalie";
    }
    else {
        window.name = "";
    }
</script>

</html>