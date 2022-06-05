<!-- 此页面无法单独运行，需要由其他页面调用执行，单独执行会出错！！！ -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.util.Random.*"%>
        <%@ page import="java.sql.*"%>
            <%@ page import="java.text.SimpleDateFormat"%>
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
                    <%@ page trimDirectiveWhitespaces="true"%>
                        <!DOCTYPE HTML>
                        <html lang="zh-CN">

                        <head>
                            <meta charset="utf-8">
                            <title>首页</title>
                            <link rel="icon" type="image/png" href="./favicon.ico">
                            <link rel="stylesheet" type="text/css" href="./css/awesome/css/all.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/materialize/materialize.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/animate/animate.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/lightGallery/css/lightgallery.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/matery.css">
                            <link rel="stylesheet" type="text/css" href="./css/my.css">
                            <link rel="stylesheet" type="text/css" href="./css/main.css">
                            <link rel="stylesheet" type="text/css" href="./css/myaos.css">
                            <link rel="stylesheet" type="text/css" href="./css/meChart.css" />
                            <script src="js/delBlog.js"></script>
                        </head>

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
String SQL = "select blogID,title,content,releaseTime,backgroundImg,catName,tagName from blog natural join user natural join cat natural join tag;";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(SQL);
List<Map<String, String>> articles = new ArrayList<>();
rs.close();
stmt.close();
conn.close();
/////////////////////////////////////////////////////////////////////////////////////////
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
String[] inittagcolor = {"#F9EBEA","#F5EEF8","#D5F5E3","#E8F8F5","#FEF9E7", "rgb(150, 249, 147)"};
ArrayList<String> tagcolor = new ArrayList<String>();
for (int i=0; i<inittagcolor.length; i++)
	tagcolor.add(inittagcolor[i]);
ArrayList<String> piclist = new ArrayList<String>();
username = (String)session.getAttribute("userName");
String conStr = "jdbc:mysql://172.18.187.253:3306/boke18329015" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
String tagName = new String(request.getParameter("tagName"));
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
	/* 2.统计出类别的数量和每个类别的名称、文章数 */
	//用户标签数量
	String sql_4;
	if (username.equals("admin") || username.equals("tourist"))
		sql_4 = "select count(distinct tagName) from tag;";
	else
		sql_4 = "select count(distinct tagName) from tag where userID = " + userID + ";";
	ResultSet rs_4 = stmt.executeQuery(sql_4);//执行查询，返回结果集
	while(rs_4.next()) { //把游标(cursor)移至第一个或下一个记录
		tagNum = rs_4.getInt("count(distinct tagName)");
	}
	Random random = new Random();
	while (tagcolor.size() < tagNum) {
        int r = random.nextInt(256);
        int g = random.nextInt(256);
        int b = random.nextInt(256);
        tagcolor.add(String.format("rgb(%d, %d, %d)", r, g, b));
	}
	//文章标签内容
	String sql_6;
	if (username.equals("admin") || username.equals("tourist"))
		sql_6 = "select distinct tagName from tag;";
	else
		sql_6 = "select distinct tagName from tag where userID = " + userID + ";";
	ResultSet rs_6 = stmt.executeQuery(sql_6);//执行查询，返回结果集
	while(rs_6.next()) { //把游标(cursor)移至第一个或下一个记录
		taglist.add(rs_6.getString("tagName"));
	}
	// 每个标签的次数
	String sql_2;
	for (int i=0; i<taglist.size(); i++) {
		if (username.equals("admin") || username.equals("tourist"))
	sql_2 = "select count(*) from tag where tagName = '" + taglist.get(i) + "';";
		else
	sql_2 = "select count(*) from tag where userID = " + userID + " and tagName = '" + taglist.get(i) + "';";
		ResultSet rs_2 = stmt.executeQuery(sql_2);//执行查询，返回结果集
		while(rs_2.next()) { //把游标(cursor)移至第一个或下一个记录
			tagcount.add(rs_2.getInt("count(*)"));
		}
		rs_2.close();
	}
	
	// 当前标签下的文章信息
	if (username.equals("admin") || username.equals("tourist"))
		sql_2 = String.format("select blogID,title,content,releaseTime,backgroundImg,catName,tagName from blog natural join user natural join cat natural join tag where tagID in (select tagID from tag where tagName = '%s')", tagName);
	else
		sql_2 = String.format("select blogID,title,content,releaseTime,backgroundImg,catName,tagName from blog natural join user natural join cat natural join tag where tagID in (select tagID from tag where userID = %s and tagName = '%s')", userID, tagName);
	ResultSet rs_2 = stmt.executeQuery(sql_2);//执行查询，返回结果集
	while(rs_2.next()) { //把游标(cursor)移至第一个或下一个记录
		Map<String, String> map = new HashMap<>();
		map.put("blogID", Integer.toString(rs_2.getInt("blogID")));
		map.put("title", rs_2.getString("title"));
		map.put("content", rs_2.getString("content"));
		map.put("backgroundImg", rs_2.getString("backgroundImg"));
		map.put("catName", rs_2.getString("catName"));
		map.put("tagName", rs_2.getString("tagName"));
		String releaseTime = new SimpleDateFormat("yyyy-MM-dd").format(rs_2.getTimestamp("releaseTime"));
		map.put("releaseTime", releaseTime);
		articles.add(map);
	}
	rs_2.close();
	rs_1.close(); 
	rs_4.close();
	rs_6.close();
	
	stmt.close(); con.close();
}
catch (Exception e){
	msg = e.getMessage();
}
%>

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
                                                    <a href="home.jsp" class="waves-effect waves-light"> <img src="./medias/logo.png" class="logo-img" alt="LOGO">
                                                    </a>
                                                    <div id="login_to_change" style="display: inline;">
                                                        <span class="logo-span" style="position:relative;bottom:24px;left:5px">
						<c:out value="${uname}"></c:out></span>
                                                        <div class="login">
                                                            <a href="login.jsp"><span>切换用户</span></a>
                                                        </div>
                                                        <div class="login">
                                                            <a href="changeinfo.jsp"><span>修改信息</span></a>
                                                        </div>
                                                        <%if (uname.equals("admin")) {%>
                                                            <div class="login">
                                                                <a href="manage.jsp"><span>后台管理</span></a>
                                                            </div>
                                                            <%}%>
                                                    </div>
                                                </div>
                                                <a href="#" data-target="mobile-nav" class="sidenav-trigger button-collapse"><i class="fas fa-bars"></i></a>
                                                <ul class="right nav-menu">
                                                    <li class="hide-on-med-and-down nav-item">
                                                        <a href="home.jsp" class="waves-effect waves-light"> <i class="fas fa-home" style="zoom: 0.6;"></i> <span>首页</span>
                                                        </a>
                                                    </li>

                                                    <li class="hide-on-med-and-down nav-item">
                                                        <a href="tags.jsp" class="waves-effect waves-light"> <i class="fas fa-tags" style="zoom: 0.6;"></i> <span>标签</span>
                                                        </a>
                                                    </li>

                                                    <li class="hide-on-med-and-down nav-item">
                                                        <a href="categories.jsp" class="waves-effect waves-light"> <i class="fas fa-bookmark" style="zoom: 0.6;"></i> <span>分类</span>
                                                        </a>
                                                    </li>

                                                    <li class="hide-on-med-and-down nav-item">
                                                        <a href="archives-1.jsp" class="waves-effect waves-light"> <i class="fas fa-archive" style="zoom: 0.6;"></i> <span>归档</span>
                                                        </a>
                                                    </li>

                                                    <li class="hide-on-med-and-down nav-item">
                                                        <a href="about.jsp" class="waves-effect waves-light"> <i class="fas fa-user-circle" style="zoom: 0.6;"></i> <span>关于</span>
                                                        </a>
                                                    </li>

                                                    <li class="hide-on-med-and-down nav-item">
                                                        <a href="comment.jsp" class="waves-effect waves-light"> <i class="fas fa-comments" style="zoom: 0.6;"></i> <span>留言板</span>
                                                        </a>
                                                    </li>

                                                    <li class="hide-on-med-and-down nav-item">
                                                        <a href="friends.jsp" class="waves-effect waves-light"> <i class="fas fa-address-book" style="zoom: 0.6;"></i> <span>用户信息</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </nav>
                                </header>

                                <div class="bg-cover pd-header about-cover">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col s10 offset-s1 m8 offset-m2 l8 offset-l2">
                                                <div class="brand">
                                                    <div class="title center-align">记录一些过程</div>
                                                    <div class="description center-align">
                                                        <span id="subtitle"></span>
                                                        <script src="./js/myTyped.js"></script>
                                                        <script>
                                                            var typed = new Typed(
                                                                "#subtitle", {
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
                                            var bannerUrl = "./medias/banner/" + new Date().getDay() +
                                                '.jpg';
                                            var pick = Math.floor(Math.random() * 7);
                                            var bannerUrl = "./medias/banner/" + pick + '.jpg';
                                            var csstext = document.getElementsByClassName("bg-cover")[0];
                                            csstext.style.cssText += "background-image: url( " + bannerUrl +
                                                "  )";
                                        </script>
                                    </div>
                                </div>

                                <main class="content">

                                    <div id="tags" class="container chip-container">
                                        <div class="card">
                                            <div class="card-content">
                                                <div class="tag-title center-align">
                                                    <i class="fas fa-tags"></i>&nbsp;&nbsp;文章标签
                                                </div>
                                                <div class="tag-chips">
                                                    <%for (int i=0;i<=tagNum-1;i++){%>
                                                        <a href="chooseTag.jsp?tagName=<%out.print(taglist.get(i)); %>" title="<%out.print(taglist.get(i)); %>:<%out.print(tagcount.get(i)); %>">
	                            <span class="chip center-align waves-effect waves-light
	                             chip-default " data-tagname="<%out.print(taglist.get(i)); %>" 
	                             style="background-color: <%out.print(tagcolor.get(i)); %>;"><%out.print(taglist.get(i)); %>
	                        <span class="tag-length"><%out.print(tagcount.get(i)); %></span>
	                            </span>
	                        </a>
                                                        <%}%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <style type="text/css">
                                        #tag-wordcloud {
                                            width: 100%;
                                            height: 300px;
                                        }
                                    </style>

                                    <article id="articles" class="container articles">
                                        <div class="row article-row">
                                            <!-- 单个文章 -->
                                            <%for(int i=0;i<articles.size();i++){%>
                                                <div class="article col s12 m6 l4 myaos">
                                                    <div class="card">
                                                        <a href="blog.jsp?blogID=<%out.print(articles.get(i).get("blogID")); %>">
                                                            <div class="card-image">
                                                                <img src=<%out.print(articles.get(i).get( "backgroundImg")); %> class="responsive-img" alt=
                                                                <%out.print(articles.get(i).get("title")); %> /> <span class="card-title">
									<%out.print(articles.get(i).get("title")); %>
								</span>
                                                            </div>
                                                        </a>
                                                        <div class="card-content article-content">
                                                            <div class="summary block-with-text">
                                                                <%out.print(articles.get(i).get("content")); %>
                                                            </div>
                                                            <div class="publish-info">
                                                                <span class="publish-date"> <i
										class="far fa-clock fa-fw icon-date"></i> 
										<%out.print(articles.get(i).get("releaseTime")); %>
									</span> <span class="publish-author"> <i
										class="fas fa-bookmark fa-fw icon-category"></i> <a
										href="categories.jsp" class="post-category">
										<%out.print(articles.get(i).get("catName")); %>
									</a>
									</span>
                                                            </div>
                                                        </div>
                                                        <div class="card-action article-tags" style="position: relative;">
                                                            <a href="tags.jsp"> <span class="chip bg-color">
								<%out.print(articles.get(i).get("tagName")); %>
											</span>
                                                            </a> <img src="./medias/trash.png" onclick=delBlog(<%out.print(articles.get(i).get( "blogID")); %>) style="position: absolute; right: 10px; width: 20px; height: 20px; cursor: pointer;">
                                                        </div>
                                                    </div>
                                                </div>
                                                <%}%>
                                                    <!-- 单个文章 -->
                                        </div>
                                    </article>

                                </main>


                                <footer class="page-footer bg-color">
                                    <a href="new.jsp"><img src="./medias/add.png" style="width: 37px; height: 37px; position: fixed; bottom: 60px; right: 11px;"></a>

                                    <div id="toTopButton" style="position: fixed; right: 10px; bottom: 10px; cursor: pointer; display: none;" onclick="returnToTop()">
                                        <img src="./medias/arrow.png" style="width: 40px; height: 40px;">
                                        <script>
                                            function returnToTop() {
                                                document.body.scrollTop = 0;
                                                document.documentElement.scrollTop = 0;
                                            }
                                        </script>
                                    </div>
                                    <div class="container row center-align" style="margin-bottom: 15px !important;">
                                        <div class="s12 copy-right">
                                            Copyright&nbsp;&copy; <span id="year">2022</span> <a href="about.jsp" target="_blank">逸仙苑</a> |&nbsp;Powered by&nbsp;<a href="https://www.sysu.edu.cn/" target="_blank">SYSU</a> |&nbsp;Organization&nbsp; <a href="https://cse.sysu.edu.cn/"
                                                target="_blank">CSE</a> <br>
                                        </div>
                                    </div>
                                </footer>

                                <script src="./js/myaos.js"></script>
                                <script type="text/javascript" src="./js/meChart.js"></script>

                            </body>

                        </html>