<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

        <% request.setCharacterEncoding("utf-8");
    String conStr = "jdbc:mysql://172.18.187.253:3306/boke18329015" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String username = (String)session.getAttribute("userName"); // 用户名
    String userAvatar = null; // 用户头像
    String userID = null; // 用户id
    String motto = null; // 用户格言
    int userCnt = 0; // 用户数量
    int blogCnt = 0; // 文章数量
    int myCnt = 0; // 你发表的文章数量
    int nowPage = (int)session.getAttribute("page");
    ArrayList <String> yearList = new ArrayList<String>(); // 发表的年
    ArrayList <String> monthList = new ArrayList<String>(); // 发表的月
    ArrayList <String> dayList = new ArrayList<String>(); // 发表的日
    ArrayList <String> titleList = new ArrayList<String>(); // 文章标题
    ArrayList <String> contentList = new ArrayList<String>(); // 文章简介
    ArrayList <String> catList = new ArrayList<String>(); // 文章分类
    ArrayList <String> catIDList = new ArrayList<String>(); // 文章分类的ID
    ArrayList <String> tagList = new ArrayList<String>(); // 文章标签
    ArrayList <String> tagIDList = new ArrayList<String>(); // 文章标签的ID
    ArrayList <String> bkList = new ArrayList<String>(); // 文章背景的ID
    ArrayList <String> blogIDList = new ArrayList<String>(); // 文章背景的ID
    try {
        Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    	Connection con=DriverManager.getConnection(conStr, "user", "123");
    	Statement stmt = con.createStatement(); // 创建MySQL语句的对象
        //用户头像路径，座右铭及特有ID
    	String sql_0 = "select * from user where userName = '"+ username +"';";
    	ResultSet rs_0 = stmt.executeQuery(sql_0);//执行查询，返回结果集
    	while (rs_0.next()) { //把游标(cursor)移至第一个或下一个记录
    		userAvatar = rs_0.getString("userAvatar");
    		motto = rs_0.getString("motto");
    		userID = rs_0.getString("userID");
    	}
        rs_0.close();
        
        // 用户数量
        String sql_1 = "select count(*) from user;";
        ResultSet rs_1 = stmt.executeQuery(sql_1);
        while (rs_1.next()) {
            userCnt = rs_1.getInt("count(*)");
        }
        rs_1.close();
        // 文章数量
        String sql_2 = "select count(*) from blog;";
        ResultSet rs_2 = stmt.executeQuery(sql_2);
        while (rs_2.next()) {
            blogCnt = rs_2.getInt("count(*)");
        }
        rs_2.close();
        // 当前用户发表的文章数量
        String sql_3 = "select count(*) from blog where userID = (select userID from user where userName = '" +
                        username + "')";
        ResultSet rs_3 = stmt.executeQuery(sql_3);
        while (rs_3.next()) {
            myCnt = rs_3.getInt("count(*)");
        }
        rs_3.close();
        // 获取文章
        String sql_4 = "select blogID, releaseTime, title, content, catID, tagID, backgroundImg from blog";
        ResultSet rs_4 = stmt.executeQuery(sql_4);
        while (rs_4.next()) {
            blogIDList.add(rs_4.getString("blogID"));
            String times = rs_4.getString("releaseTime");
            yearList.add(times.substring(0, 4));
            monthList.add(times.substring(5, 7));
            dayList.add(times.substring(8, 10));
            titleList.add(rs_4.getString("title"));
            String blogs = rs_4.getString("content");
            contentList.add(blogs.substring(0, Math.min(70, blogs.length())) + "...");
            catIDList.add(rs_4.getString("catID"));
            tagIDList.add(rs_4.getString("tagID"));
            bkList.add(rs_4.getString("backgroundImg"));
        }
        rs_4.close();
        // 获取cat
        for (int i = 0; i < yearList.size(); i++) {
            String sql_5 = "select catName from cat where catID = " + catIDList.get(i) + ";";
            ResultSet rs_5 = stmt.executeQuery(sql_5);
            while (rs_5.next()) {
                catList.add(rs_5.getString("catName"));
            }
        }
        // 获取tag
        for (int i = 0; i < yearList.size(); i++) {
            String sql_6 = "select tagName from tag where tagID = " + tagIDList.get(i) + ";";
            ResultSet rs_6 = stmt.executeQuery(sql_6);
            while (rs_6.next()) {
                tagList.add(rs_6.getString("tagName"));
            }
        }
        
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
                <title>Archives | UserName</title>
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
                    <div class="container archive-calendar">
                        <div class="card">
                            <div class="date-line1">
                                本站已经有
                                <a class="date-number0">
                                    <%=userCnt%>
                                </a>名用户发布了
                                <a class="date-number1">
                                    <%=blogCnt%>
                                </a>篇文章~
                            </div>
                            <div class="date-line2">
                                其中，你一共贡献了
                                <a class="date-number3">
                                    <%=myCnt%>
                                </a>篇文章!<br> 继续加油吧~~
                            </div>
                        </div>
                    </div>

                    <div id="cd-timeline" class="container">
                        <%
            for (int i = 0; i < 5; i++) {
                int j = (nowPage - 1) * 5 + i;
                if (j >= yearList.size()) break;
                out.write("<div class='cd-timeline-block'>");
            %>
                            <%-- <div class="cd-timeline-block"> --%>
                                <%
                if (i == 0 || !yearList.get(j).equals(yearList.get(j - 1))) {
                    out.write("<div class='cd-timeline-img year myaos'>");
                    out.write("<a>" + yearList.get(j) + "</a>");
                    out.write("</div>");
                }
                %>
                                    <%-- <div class="cd-timeline-img year myaos">
                    <a>2022</a>
                </div> --%>

                                        <%
                if (i == 0 || !monthList.get(j).equals(monthList.get(j - 1))) {
                    out.write("<div class='cd-timeline-img month myaos'>");
                    out.write("<a>" + monthList.get(j) + "</a>");
                    out.write("</div>");
                }
                %>
                                            <%-- <div class="cd-timeline-img month myaos">
                    <a>05</a>
                </div> --%>

                                                <%
                out.write("<div class='cd-timeline-img day myaos'>");
                out.write("<a>" + dayList.get(j) + "</a>");
                out.write("</div>");
                %>
                                                    <%-- <div class="cd-timeline-img day myaos">
                    <span>09</span>
                </div> --%>
                                                        <article class="cd-timeline-content myaos">
                                                            <div class="article col s12 m6">
                                                                <div class="card">
                                                                    <a href="blog.jsp?blogID=<%=blogIDList.get(j)%>">
                                                                        <div class="card-image">
                                                                            <%
                                    out.write("<img src='./" + bkList.get(j) + "' ");
                                    out.write("class='responsive-img' alt='" + titleList.get(j) + "'>");
                                    %>
                                                                                <%-- <img src="./<%bkList.get(j)%>" class="responsive-img" alt="
                                                                                    <%=titleList.get(j)%>"> --%>
                                                                                        <span class="card-title"><%=titleList.get(j)%></span>
                                                                        </div>
                                                                    </a>
                                                                    <div class="card-content article-content">
                                                                        <div class="summary block-with-text">
                                                                            <%=contentList.get(j)%>
                                                                        </div>
                                                                        <div class="publish-info">
                                                                            <span class="publish-date">
                                        <i class="far fa-clock fa-fw icon-date"></i>
                                        <%
                                        String d = yearList.get(j) + "-" + monthList.get(j) + "-" + dayList.get(j);
                                        out.write(d);
                                        %>
                                    </span>
                                                                            <span class="publish-author">
                                        <i class="fas fa-bookmark fa-fw icon-category"></i>
                                        <a href="categories.jsp" class="post-category">
                                            <%=catList.get(j)%>
                                        </a>
                                    </span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-action article-tags">
                                                                        <a href="tags.jsp"><span class="chip bg-color"><%=tagList.get(j)%></span></a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </article>
                    </div>
                    <%}%>

                        </div>
                </main>
                <%
    int cnt = yearList.size();
    int pages = cnt / 5 + (cnt % 5 == 0 ? 0 : 1);
    String left = null;
    String right = null;
    String laction = "";
    String raction = "";
    if (nowPage == 1)
        left = "disabled";
    else {
        left = "waves-effect waves-light bg-color";
        laction = "href='archives-2.jsp'";
    }
    if (nowPage == pages)
        right = "disabled";
    else {
        right = "waves-effect waves-light bg-color";
        raction = "href='archives-3.jsp'";
    }
    %>
                    <div class="container paging">
                        <div class="row">
                            <div class="col s6 m4 l4">
                                <%
                out.write("<a " + laction + "class='left btn-floating btn-large " + left + "'/>");
                %>
                                    <%-- <a class="left btn-floating btn-large <%=left%>"> --%>
                                        <i class="fas fa-angle-left"></i>
                                        </a>
                            </div>
                            <div class="page-info col m4 l4 hide-on-small-only">
                                <div class="center-align b-text-gray">
                                    <%=nowPage%> /
                                        <%=pages%>
                                </div>
                            </div>
                            <div class="col s6 m4 l4">
                                <%
                out.write("<a " + raction + " class='right btn-floating btn-large " + right + "'/>");
                %>
                                    <%-- <a class="right btn-floating btn-large <%=right%>"> --%>
                                        <i class="fas fa-angle-right"></i>
                                        </a>
                            </div>
                        </div>
                    </div>
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
                } else {
                    window.name = "";
                }
            </script>

            </html>