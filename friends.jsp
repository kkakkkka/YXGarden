<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <% request.setCharacterEncoding("utf-8");
    String msg = "";
    String result = "";
    String userID = null;
   	String username = "";



    ArrayList<String> userNameList = new ArrayList<String>();
    ArrayList<String> userAvatarList = new ArrayList<String>();
    ArrayList<String> mottoList = new ArrayList<String>();
    ArrayList<String> homePageList = new ArrayList<String>();
    
    ArrayList<String> userNameList2 = new ArrayList<String>();
    ArrayList<String> userAvatarList2 = new ArrayList<String>();
    ArrayList<String> mottoList2 = new ArrayList<String>();
    ArrayList<String> homePageList2 = new ArrayList<String>();
    
    username = (String)session.getAttribute("userName");
    String conStr = "jdbc:mysql://172.18.187.253:3306/boke18329015" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	try {
    	Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    	Connection con=DriverManager.getConnection(conStr, "user", "123");
    	Statement stmt = con.createStatement(); // 创建MySQL语句的对象
    	//用户头像路径，座右铭及特有ID
    	String sql_1 = "select userName,userAvatar,motto,homePage from user where userName = '"+username+"';";
    	ResultSet rs_1 = stmt.executeQuery(sql_1);//执行查询，返回结果集
    	while(rs_1.next()){ //把游标(cursor)移至第一个或下一个记录
    		userNameList.add(rs_1.getString("userName"));
    		userAvatarList.add(rs_1.getString("userAvatar"));
    		mottoList.add(rs_1.getString("motto"));
    		homePageList.add(rs_1.getString("homePage"));
    	}  
    	
    	String sql_2 = "select userName,userAvatar,motto,homePage from user where userName <> '"+username+"';";
    	ResultSet rs_2 = stmt.executeQuery(sql_2);//执行查询，返回结果集
    	for(int i=1;i<=3;i++) { //把游标(cursor)移至第一个或下一个记录
    		rs_2.next();
    		userNameList2.add(rs_2.getString("userName"));		
    		userAvatarList2.add(rs_2.getString("userAvatar"));
    		mottoList2.add(rs_2.getString("motto"));
    		homePageList2.add(rs_2.getString("homePage"));
    	}
    	rs_1.close();
    	rs_2.close(); 	
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
                <link rel="icon" type="image/png" href="favicon.ico">
                <link rel="stylesheet" type="text/css" href="./css/awesome/css/all.min.css">
                <link rel="stylesheet" type="text/css" href="./css/materialize/materialize.min.css">
                <link rel="stylesheet" type="text/css" href="./css/animate/animate.min.css">
                <link rel="stylesheet" type="text/css" href="./css/lightGallery/css/lightgallery.min.css">
                <link rel="stylesheet" type="text/css" href="./css/matery.css">
                <link rel="stylesheet" type="text/css" href="./css/my.css">
                <link rel="stylesheet" type="text/css" href="./css/main.css">
                <link rel="stylesheet" type="text/css" href="./css/myaos.css">
                <link rel="stylesheet" type="text/css" href="./css/myfriends.css" />
                <link rel="alternate" href="atom.xml" title="UserName" type="application/atom+xml">
                <script src="./js/myaos.js"></script>
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

                <main class="content" style="margin-bottom: 200px;">
                    <div class="container friends-container">
                        <div class="card">
                            <div class="card-content">
                                <div class="tag-title center-align">
                                    <i class="fas fa-address-book"></i>&nbsp;&nbsp;用户信息
                                </div>

                                <!-- 从这里开始改 -->
                                <div class="row tags-posts friend-all">

                                    <%if (username.equals("tourist")){%>
                                        <div class="col s12 m6 l4 friend-div">
                                            <div class="frind-card1 card myaos">
                                                <div class="frind-ship">
                                                    <div class="title">
                                                        <img src="<%out.print(userAvatarList2.get(0)); %>.jpg" alt="img">
                                                        <div>
                                                            <h1 class="friend-name">
                                                                <%out.print(userNameList2.get(0)); %>
                                                            </h1>
                                                            <p style="position: relative;top: -35px;">
                                                                <%out.print(mottoList2.get(0)); %>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="friend-button">
                                                        <a href="<%out.print(homePageList2.get(0)); %>" target="_blank" class="button button-glow button-rounded button-caution">访问主页</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col s12 m6 l4 friend-div">
                                            <div class="frind-card1 card myaos">
                                                <div class="frind-ship">
                                                    <div class="title">
                                                        <img src="<%out.print(userAvatarList2.get(1)); %>.jpg" alt="img">
                                                        <div>
                                                            <h1 class="friend-name">
                                                                <%out.print(userNameList2.get(1)); %>
                                                            </h1>
                                                            <p style="position: relative;top: -35px;">
                                                                <%out.print(mottoList2.get(1)); %>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="friend-button">
                                                        <a href="<%out.print(homePageList2.get(1)); %>" target="_blank" class="button button-glow button-rounded button-caution">访问主页</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col s12 m6 l4 friend-div">
                                            <div class="frind-card1 card myaos">
                                                <div class="frind-ship">
                                                    <div class="title">
                                                        <img src="<%out.print(userAvatarList2.get(2)); %>.jpg" alt="img">
                                                        <div>
                                                            <h1 class="friend-name">
                                                                <%out.print(userNameList2.get(2)); %>
                                                            </h1>
                                                            <p style="position: relative;top: -35px;">
                                                                <%out.print(mottoList2.get(2)); %>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="friend-button">
                                                        <a href="<%out.print(homePageList2.get(2)); %>" target="_blank" class="button button-glow button-rounded button-caution">访问主页</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%}%>

                                            <%if(username.equals("tourist")==false){%>
                                                <div class="col s12 m6 l4 friend-div">
                                                    <div class="frind-card1 card myaos">
                                                        <div class="frind-ship">
                                                            <div class="title">
                                                                <img src="<%out.print(userAvatarList.get(0)); %>.jpg" alt="img">
                                                                <div>
                                                                    <h1 class="friend-name">
                                                                        <%out.print(userNameList.get(0)); %>
                                                                    </h1>
                                                                    <p style="position: relative;top: -35px;">
                                                                        <%out.print(mottoList.get(0)); %>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="friend-button">
                                                                <a href="<%out.print(homePageList.get(0)); %>" target="_blank" class="button button-glow button-rounded button-caution">访问主页</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%}%>

                                </div>

                                </article>
                            </div>
                        </div>

                        <div class="card">


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