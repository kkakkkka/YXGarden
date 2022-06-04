<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*"%>
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
while (rs.next()) {
	Map<String, String> map = new HashMap<>();
	map.put("blogID", Integer.toString(rs.getInt("blogID")));
	map.put("title", rs.getString("title"));
	map.put("content", rs.getString("content"));
	map.put("backgroundImg", rs.getString("backgroundImg"));
	map.put("catName", rs.getString("catName"));
	map.put("tagName", rs.getString("tagName"));
	String releaseTime = new SimpleDateFormat("yyyy-MM-dd").format(rs.getTimestamp("releaseTime"));
	map.put("releaseTime", releaseTime);
	articles.add(map);
}
pageContext.setAttribute("articles", articles);
rs.close();
stmt.close();
conn.close();
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
                                        <link rel="stylesheet" type="text/css" href="./css/header.css?t=1">
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

                                    <div id="indexCard" class="index-card">
                                        <div class="container ">
                                            <div class="card">
                                                <div class="card-content">
                                                    <div class="dream">
                                                        <div class="title center-align">
                                                            <i class="far fa-lightbulb"></i>&nbsp;&nbsp;我的梦想
                                                        </div>
                                                        <div class="row">
                                                            <div class="col l8 offset-l2 m10 offset-m1 s10 offset-s1 center-align text">
                                                                不是每个人都应该像我这样去建造一座水晶大教堂，但是每个人都应该拥有自己的梦想，设计自己的梦想，追求自己的梦想，实现自己的梦想。梦想是生命的灵魂，是心灵的灯塔，是引导人走向成功的信仰。有了崇高的梦想，只要矢志不渝地追求，梦想就会成为现实，奋斗就会变成壮举，生命就会创造奇迹。——罗伯·舒乐
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="recommend-sections" class="recommend"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 所有文章卡片 -->
                                    <article id="articles" class="container articles">
                                        <div class="row article-row">

                                            <!-- 单个文章 -->
                                            <c:forEach items="${articles}" var="article">
                                                <div class="article col s12 m6 l4 myaos">
                                                    <div class="card">
                                                        <a href="blog.jsp?blogID=<c:out
											value=" ${article.get( 'blogID')} "></c:out>">
                                                            <div class="card-image">
                                                                <img src=<c:out value="${article.get('backgroundImg')}"></c:out>
                                                                class="responsive-img" alt=
                                                                <c:out value="${article.get('title')}"></c:out>>
                                                                <span class="card-title"><c:out
											value="${article.get('title')}"></c:out></span>
                                                            </div>
                                                        </a>
                                                        <div class="card-content article-content">
                                                            <div class="summary block-with-text">
                                                                <c:out value="${article.get('content')}"></c:out>
                                                            </div>
                                                            <div class="publish-info">
                                                                <span class="publish-date"> <i
										class="far fa-clock fa-fw icon-date"></i> <c:out
											value="${article.get('releaseTime')}"></c:out>
									</span> <span class="publish-author"> <i
										class="fas fa-bookmark fa-fw icon-category"></i> <a
										href="categories.jsp" class="post-category"> <c:out
												value="${article.get('catName')}"></c:out>
									</a>
									</span>
                                                            </div>
                                                        </div>
                                                        <div class="card-action article-tags" style="position: relative;">
                                                            <a href="tags.jsp"> <span class="chip bg-color"><c:out
											value="${article.get('tagName')}"></c:out></span>
                                                            </a> <img src="./medias/trash.png" onclick=delBlog(<c:out value="${article.get('blogID')}"></c:out>) style="position: absolute; right: 10px; width: 20px; height: 20px; cursor: pointer;">
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
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
                            </body>

                        </html>