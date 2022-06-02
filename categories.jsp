<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="zh-CN">


<head>
    <meta charset="utf-8">

    <title>About | UserName</title>
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
</head>


<body>
	<%
	Connection conn = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		conn = DriverManager.getConnection(connectionUrl, "user", "123");
	} catch (Exception e) {
		out.write("<script>alert('连接数据库出错！');</script>");
		return;
	}
	String SQL = "select title,content,releaseTime,backgroundImg,catName,tagName from blog natural join user natural join cat natural join tag;";
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(SQL);
	List<Map<String, String>> articles = new ArrayList<>();
	while (rs.next()) {
		Map<String, String> map = new HashMap<>();
		map.put("title", rs.getString("title"));
		map.put("content", rs.getString("content"));
		map.put("backgroundImg", rs.getString("backgroundImg"));
		map.put("catName", rs.getString("catName"));
		map.put("tagName", rs.getString("tagName"));
		articles.add(map);
	}
	pageContext.setAttribute("articles", articles);
	rs.close();
	stmt.close();
	conn.close();
	%>
	<header class="navbar-fixed">
        <link rel="stylesheet" type="text/css" href="./css/header.css">
        <script src="./js/header.js"></script>
        <nav id="nav_header" class="bg-color nav-transparent">
            <div id="navContainer" class="nav-wrapper container">
                <div class="brand-logo">
                    <a href="home.jsp" class="waves-effect waves-light">
                        <img src="./medias/logo.png" class="logo-img" alt="LOGO">
                    </a>
                    <div id="login_to_change" style="display: inline;">
                        <!-- <span class="logo-span">UserName</span> -->
                        <div class="login"><a href="login.jsp"><span>登录</span></a></div>
                        <div class="login"><a href="register.jsp"><span>注册</span></a></div>
                    </div>
                </div>
                <a href="#" data-target="mobile-nav" class="sidenav-trigger button-collapse"><i class="fas fa-bars"></i></a>
                <ul class="right nav-menu">
                    <li class="hide-on-med-and-down nav-item">
                        <a href="home.jsp" class="waves-effect waves-light">
                            <i class="fas fa-home" style="zoom: 0.6;"></i>
                            <span>首页</span>
                        </a>
                    </li>

                    <li class="hide-on-med-and-down nav-item">
                        <a href="tags.jsp" class="waves-effect waves-light">
                            <i class="fas fa-tags" style="zoom: 0.6;"></i>
                            <span>标签</span>
                        </a>
                    </li>

                    <li class="hide-on-med-and-down nav-item">
                        <a href="categories.jsp" class="waves-effect waves-light">
                            <i class="fas fa-bookmark" style="zoom: 0.6;"></i>
                            <span>分类</span>
                        </a>
                    </li>

                    <li class="hide-on-med-and-down nav-item">
                        <a href="archives-1.jsp" class="waves-effect waves-light">
                            <i class="fas fa-archive" style="zoom: 0.6;"></i>
                            <span>归档</span>
                        </a>
                    </li>

                    <li class="hide-on-med-and-down nav-item">
                        <a href="about.jsp" class="waves-effect waves-light">
                            <i class="fas fa-user-circle" style="zoom: 0.6;"></i>
                            <span>关于</span>
                        </a>
                    </li>

                    <li class="hide-on-med-and-down nav-item">
                        <a href="comment.jsp" class="waves-effect waves-light">
                            <i class="fas fa-comments" style="zoom: 0.6;"></i>
                            <span>留言板</span>
                        </a>
                    </li>

                    <li class="hide-on-med-and-down nav-item">
                        <a href="friends.jsp" class="waves-effect waves-light">
                            <i class="fas fa-address-book" style="zoom: 0.6;"></i>
                            <span>用户信息</span>
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

    <main class="content">
        <div id="category-cloud" class="container chip-container">
            <div class="card">
                <div class="card-content">
                    <div class="tag-title center-align">
                        <i class="fas fa-bookmark"></i>&nbsp;&nbsp;文章分类
                    </div>
                    <div class="tag-chips">
                        <a href="categories.jsp" title="杂七杂八: 2">
                            <span class="chip center-align waves-effect waves-light
                             chip-default " style="background-color: #F9EBEA;">杂七杂八
                        <span class="tag-length">2</span>
                            </span>
                        </a>

                        <a href="categories.jsp" title="C++: 1">
                            <span class="chip center-align waves-effect waves-light
                             chip-default " style="background-color: #F5EEF8;">C++
                        <span class="tag-length">1</span>
                            </span>
                        </a>

                        <a href="categories.jsp" title="集群: 1">
                            <span class="chip center-align waves-effect waves-light
                             chip-default " style="background-color: #D5F5E3;">集群
                        <span class="tag-length">1</span>
                            </span>
                        </a>

                        <a href="categories.jsp" title="深度学习: 6">
                            <span class="chip center-align waves-effect waves-light
                             chip-default " style="background-color: #E8F8F5;">深度学习
                        <span class="tag-length">6</span>
                            </span>
                        </a>

                        <a href="categories.jsp" title="算法: 1">
                            <span class="chip center-align waves-effect waves-light
                             chip-default " style="background-color: #FEF9E7;">算法
                        <span class="tag-length">1</span>
                            </span>
                        </a>

                    </div>
                </div>
            </div>
        </div>

        <style type="text/css">
            #category-radar {
                width: 100%;
                height: 360px;
            }
            
            #category-radar img {
                margin: 0 auto;
                text-align: center;
            }
        </style>

        <div class="container">
            <div class="card">
                <div class="myaos"  style="margin-left: 28%;">
					<canvas id="curve" width="500" height="300"></canvas>
                </div>
            </div>
        </div>

    </main>

    <footer class="page-footer bg-color">
        <a href="new.jsp"><img src="./medias/add.png" style="width: 37px;height: 37px; position: fixed; bottom: 60px; right: 11px;"></a>

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
                <a href="about.jsp" target="_blank">逸仙苑</a> |&nbsp;Powered by&nbsp;<a href="https://www.sysu.edu.cn/" target="_blank">SYSU</a> |&nbsp;Organization&nbsp;
                <a href="https://cse.sysu.edu.cn/" target="_blank">CSE</a>
                <br>
            </div>
        </div>
    </footer>

    <script src="./js/myaos.js"></script>
    <script type="text/javascript" src="./js/meChart.js" ></script>
	<script type="text/javascript" src="./js/curve.js" ></script>
</body>

</html>