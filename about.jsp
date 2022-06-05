<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <% request.setCharacterEncoding("utf-8");
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
    ArrayList<String> piclist = new ArrayList<String>();
    username = (String)session.getAttribute("userName");
    String conStr = "jdbc:mysql://172.18.187.253:3306/boke18329015" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	try {
    	Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    	Connection con=DriverManager.getConnection(conStr, "user", "123");
    	Statement stmt = con.createStatement(); // 创建MySQL语句的对象
    	//用户头像路径，座右铭及特有ID
    	String sql_1 = "select * from user where userName = '"+ username +"';";
    	ResultSet rs_1 = stmt.executeQuery(sql_1);//执行查询，返回结果集
    	while(rs_1.next()) { //把游标(cursor)移至第一个或下一个记录
    		userAvatar = rs_1.getString("userAvatar");
    		motto = rs_1.getString("motto");
    		userID = rs_1.getString("userID");
    	}
    	//用户博文数量
    	String sql_2 = "select count(blogID) from blog where userID = "+ userID +";";
    	ResultSet rs_2 = stmt.executeQuery(sql_2);//执行查询，返回结果集
    	while(rs_2.next()) { //把游标(cursor)移至第一个或下一个记录
    		articleNum = rs_2.getInt("count(blogID)");
    	}
    	//用户分类数量
    	String sql_3 = "select count(catID) from cat where userID = "+ userID +";";
    	ResultSet rs_3 = stmt.executeQuery(sql_3);//执行查询，返回结果集
    	while(rs_3.next()) { //把游标(cursor)移至第一个或下一个记录
    		catNum = rs_3.getInt("count(catID)");
    	}
    	//用户标签数量
    	String sql_4 = "select count(tagID) from tag where userID = "+ userID +";";
    	ResultSet rs_4 = stmt.executeQuery(sql_4);//执行查询，返回结果集
    	while(rs_4.next()) { //把游标(cursor)移至第一个或下一个记录
    		tagNum = rs_4.getInt("count(tagID)");
    	}
    	
    	//技术分布
    	String sql_5 = "select catName,count(catName) from cat where userID = "+ userID +" group by catName;";
    	ResultSet rs_5 = stmt.executeQuery(sql_5);//执行查询，返回结果集
    	while(rs_5.next()) { //把游标(cursor)移至第一个或下一个记录
    		catlist.add(rs_5.getString("catName"));
    		catlistNum.add(rs_5.getInt("count(catName)"));
    	}
    	
    	//文章标签内容
    	String sql_6 = "select distinct tagName from tag where userID = "+ userID +";";
    	ResultSet rs_6 = stmt.executeQuery(sql_6);//执行查询，返回结果集
    	while(rs_6.next()) { //把游标(cursor)移至第一个或下一个记录
    		taglist.add(rs_6.getString("tagName"));
    	}
    	
    	String sql_7 = "select albumID from album where userID = "+ userID +";";
    	ResultSet rs_7=stmt.executeQuery(sql_7);//执行查询，返回结果集
    	while(rs_7.next()) { //把游标(cursor)移至第一个或下一个记录
    		albumID = rs_7.getString("albumID");
    	}
    	
    	String sql_8 = "select content from pic where albumID = "+ albumID +";";
    	ResultSet rs_8=stmt.executeQuery(sql_8);//执行查询，返回结果集
    	while(rs_8.next()) { //把游标(cursor)移至第一个或下一个记录
    		piclist.add(rs_8.getString("content"));
    	}
	    	
    	rs_1.close(); 
    	rs_2.close();
    	rs_3.close(); 
    	rs_4.close();
    	rs_5.close(); 
    	rs_6.close();
    	rs_7.close(); 
    	rs_8.close();
    	
    	stmt.close(); con.close();
	}
    catch (Exception e){
    	msg = e.getMessage();
    }
%>
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

                    <div id="aboutme" class="container about-container">
                        <div class="card">
                            <div class="card-content">
                                <div class="row">
                                    <div class="post-statis col l4 hide-on-med-and-down">

                                        <div class="statis">
                                            <span class="count"><a href="home.jsp"><% out.print(articleNum); %></a></span>
                                            <span class="name">文章</span>
                                        </div>

                                        <div class="statis">
                                            <span class="count"><a href="categories.jsp"><% out.print(catNum); %></a></span>
                                            <span class="name">分类</span>
                                        </div>

                                        <div class="statis">
                                            <span class="count"><a href="tags.jsp"><% out.print(tagNum); %></a></span>
                                            <span class="name">标签</span>
                                        </div>


                                    </div>
                                    <div class="col s12 m12 l4">
                                        <div class="profile center-align">
                                            <div class="avatar">
                                                <img src="<%
                                    out.print(userAvatar);
                                    %>" alt="<%out.print(username); %>" class="circle responsive-img avatar-img">
                                            </div>
                                            <div class="author">
                                                <div class="post-statis hide-on-large-only">

                                                    <div class="statis">
                                                        <span class="count"><a href="home.jsp"><% out.print(articleNum); %></a></span>
                                                        <span class="name">文章</span>
                                                    </div>



                                                    <div class="statis">
                                                        <span class="count"><a href="categories.jsp"><% out.print(catNum); %></a></span>
                                                        <span class="name">分类</span>
                                                    </div>



                                                    <div class="statis">
                                                        <span class="count"><a href="tags.jsp"><% out.print(tagNum); %></a></span>
                                                        <span class="name">标签</span>
                                                    </div>


                                                </div>
                                                <div class="title">
                                                    <% out.print(username); %>
                                                </div>
                                                <div class="career">Software Engineer</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="introduction center-align">
                                    <% out.print(motto); %>
                                </div>

                                <style type="text/css">
                                    #posts-chart,
                                    #categories-chart,
                                    #tags-chart {
                                        width: 100%;
                                        height: 300px;
                                        margin: 0.5rem auto;
                                        padding: 0.5rem;
                                    }
                                </style>

                                <div class="my-skills">
                                    <div class="title center-align">
                                        <i class="fas fa-wrench"></i>&nbsp;&nbsp;技术分布
                                    </div>
                                    <div class="row">
                                        <%for (int i=0;i<=catlistNum.size()-1;i++){%>
                                            <div class="col s12 m6 l6">
                                                <div class="skillbar">
                                                    <div class="skillbar-title" style="background: linear-gradient(to right, <%out.print(color[i%6]); %>); width: <%out.print((int)(1.0*catlistNum.get(i)/catNum*100)*0.5+50);%>%">
                                                        <span><%out.print(catlist.get(i));%></span>
                                                    </div>
                                                    <div class="skill-bar-percent">
                                                        <%if(catNum == 0){%>
                                                            <%out.print(0);%>%
                                                                <%}%>
                                                                    <%if(catNum != 0){%>
                                                                        <%out.print((int)(1.0*catlistNum.get(i)/catNum*100));%>%
                                                                            <%}%>
                                                    </div>
                                                </div>
                                            </div>
                                            <%}%>
                                    </div>

                                    <div class="other-skills chip-container">
                                        <div class="sub-title center-align"><i class="fa fa-book"></i>&nbsp;&nbsp;文章标签</div>
                                        <div class="tag-chips center-align">
                                            <%for(int i=0;i<=taglist.size()-1;i++){%>
                                                <a href="chooseTag.jsp?tagName=<%out.print(taglist.get(i)); %>">
                                                    <span class="chip center-align waves-effect waves-light chip-default"><%out.print(taglist.get(i));%></span>
                                                </a>
                                                <%}%>
                                        </div>
                                    </div>
                                </div>

                                <div id="myGallery" class="my-gallery">
                                    <div class="title center-align">
                                        <i class="far fa-image"></i>&nbsp;&nbsp;相册
                                    </div>
                                    <div class="row">

                                        <%for(int i=0;i<=piclist.size()-1&i<=2;i++){ %>
                                            <div class="photo col s12 m6 l4 myaos">

                                                <div class="img-item" data-src="<%out.print(piclist.get(i));%>">
                                                    <img src="<%out.print(piclist.get(i));%>" class="responsive-img">
                                                </div>

                                            </div>
                                            <%} %>
                                    </div>
                                </div>

                                <script>
                                    $(function() {
                                        let animateClass = 'animated pulse';
                                        $('#myGallery .photo').hover(function() {
                                            $(this).addClass(animateClass);
                                        }, function() {
                                            $(this).removeClass(animateClass);
                                        });
                                    });
                                </script>
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
            </body>

            </html>