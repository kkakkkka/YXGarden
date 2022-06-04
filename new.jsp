<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*"%>
        <%@ page import="java.sql.*"%>
            <%@ page import="java.text.SimpleDateFormat"%>
                <%@ page import="org.apache.commons.io.*"%>
                    <%@ page import="org.apache.commons.fileupload.*"%>
                        <%@ page import="org.apache.commons.fileupload.disk.*"%>
                            <%@ page import="org.apache.commons.fileupload.servlet.*"%>
                                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
                                    <%@ page trimDirectiveWhitespaces="true"%>
                                        <!DOCTYPE HTML>
                                        <html lang="zh-CN">

                                        <head>
                                            <meta charset="utf-8">
                                            <title>写博文</title>
                                            <link rel="icon" type="image/png" href="./favicon.ico">
                                            <link rel="stylesheet" type="text/css" href="./css/awesome/css/all.min.css">
                                            <link rel="stylesheet" type="text/css" href="./css/materialize/materialize.min.css">
                                            <link rel="stylesheet" type="text/css" href="./css/animate/animate.min.css">
                                            <link rel="stylesheet" type="text/css" href="./css/lightGallery/css/lightgallery.min.css">
                                            <link rel="stylesheet" type="text/css" href="./css/matery.css">
                                            <link rel="stylesheet" type="text/css" href="./css/skin.css">
                                            <link rel="stylesheet" type="text/css" href="./css/my.css">
                                            <link rel="stylesheet" type="text/css" href="./css/blog.css">
                                            <link rel="stylesheet" type="text/css" href="./css/myaos.css">
                                            <script src="./js/myaos.js"></script>

                                        </head>

                                        <style>
                                            select {
                                                display: block !important;
                                            }
                                        </style>
                                        <script type="text/javascript">
                                            function check() {
                                                var cat = document.getElementById("cat").value.replace(' ', '');
                                                var tag = document.getElementById("tag").value.replace(' ', '');
                                                var title = document.getElementById("title").value;
                                                document.getElementById("mytextarea").value = document.getElementById("richedit").innerHTML;
                                                if (cat.length > 20 || tag.length > 20) {
                                                    alert("分类或标签的长度不能大于20！");
                                                    return false;
                                                }
                                                return true;
                                            }
                                        </script>

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
	if(uname == "tourist"){
		out.write("<script>alert('游客不能发博文，请先登录');window.location.href='home.jsp';</script>");
		return;
	}
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
                                                                <div class="title center-align">新建文章</div>
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

                                            <%
request.setCharacterEncoding("utf-8");
if (request.getMethod().equalsIgnoreCase("post")){
	String cat=null,tag=null,title=null,body=null;
	String uid = session.getAttribute("userID").toString();
	String imgUrl = "medias/featureimages/" + (int)(Math.random()*24) + ".jpg";
	FileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	List items = upload.parseRequest(request);
	for (int i = 0; i < items.size(); i++) {
		FileItem fi = (FileItem) items.get(i);
		if (fi.isFormField()){
			if(fi.getFieldName().equals("Cat")) cat = fi.getString("utf-8");
			if(fi.getFieldName().equals("Tag")) tag = fi.getString("utf-8");
			if(fi.getFieldName().equals("Title")) title = fi.getString("utf-8");
			if(fi.getFieldName().equals("Body")){
				body = fi.getString("utf-8");
				body = body.replace("\\","\\\\");
				body = body.replace("\"","\\\"");
			}
		}else{
			DiskFileItem dfi = (DiskFileItem) fi;
			if (!dfi.getName().trim().equals("")) {
				//TODO
// 				String fileName=application.getRealPath("/");
// 				out.print(fileName);
// 				dfi.write(new File(fileName));
			}
		}
	}
	Connection conn = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?useUnicode=true&characterEncoding=UTF-8";
		conn = DriverManager.getConnection(connectionUrl, "user", "123");
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		stmt.executeUpdate(String.format("insert into tag(userID,tagName) values(%s,\"%s\");",uid,tag));
		stmt.executeUpdate(String.format("insert into cat(userID,catName) values(%s,\"%s\");",uid,cat));
		stmt.executeQuery(String.format("select max(tagID) from tag where userID=%s and tagName=\"%s\" into @tid;",uid,tag));
		stmt.executeQuery(String.format("select max(catID) from cat where userID=%s and catName=\"%s\" into @cid;",uid,cat));
		stmt.executeUpdate(String.format("insert into blog(userID,catID,tagID,title,content,backgroundImg) values(%s,@cid,@tid,\"%s\",\"%s\",\"%s\");",
		uid,title,body,imgUrl));
		conn.commit();
		out.write("<script>alert('发布博文成功！');window.location.href='home.jsp';</script>");
		stmt.close();
		conn.close();
	} catch (Exception e) {
		if(conn!=null) conn.rollback();
		out.write("<script>alert('提交失败！');</script>");
	}
}
%>
                                                <main class="content">
                                                    <div id="aboutme" class="container about-container">
                                                        <div class="card">
                                                            <div class="card-content">
                                                                <div class="row">
                                                                    <div class="">
                                                                        <div class="blogprofile center-align">
                                                                            <div class="">
                                                                                <img src="./medias/barrager/logo.png" alt="UserName" class="circle responsive-img avatar-img">
                                                                            </div>
                                                                            <div style="font-size: 30px;">Write a blog, which contains your love.</div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <form action="" method="post" onsubmit="return check()" enctype="multipart/form-data">
                                                                <div class="input-group" style="width: 80%; margin: auto; display: block !important;">
                                                                    <div class="form-row">
                                                                        <div class="name">分类</div>
                                                                        <div class="value">
                                                                            <div class="input-group">
                                                                                <input id="cat" class="input--style-6" type="text" name="Cat" placeholder="在这里输入分类" required="required">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <br>
                                                                    <div class="form-row">
                                                                        <div class="name">标签</div>
                                                                        <div class="value">
                                                                            <div class="input-group">
                                                                                <input id="tag" class="input--style-6" type="text" name="Tag" placeholder="在这里输入标签" required="required">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <br>
                                                                    <div class="form-row">
                                                                        <div class="name">标题</div>
                                                                        <div class="value">
                                                                            <div class="input-group">
                                                                                <input id="title" class="input--style-6" type="text" name="Title" placeholder="在这里输入标题" required="required">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <br>
                                                                    <div class="name">正文</div>
                                                                    <textarea id="mytextarea" style="display:none" name="Body"></textarea>
                                                                    <div class="editable" id="richedit" contenteditable="true" style="padding:10px;width:1000px;height:200px;border:solid 1px black"></div>


                                                                    <div class="name" style="padding-top: 5px; padding-bottom: 5px; padding-left: 9px;">上传图片(若不上传，则使用随机图片作为背景图)</div>
                                                                    <div class="value">
                                                                        <div class="input-group js-input-file">
                                                                            <input class="input-file" type="file" name="fileToUpload" id="file" accept="image/*">
                                                                        </div>
                                                                    </div>

                                                                    <input type="submit" value="提交">
                                                                </div>
                                                            </form>
                                                            <br>
                                                            <div class="introduction center-align">If you wish to succeed, you should use persistence as your good friend, experience as your reference, prudence as your brother and hope as your sentry.</div>
                                                        </div>
                                                    </div>
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
                                                            Copyright&nbsp;&copy; <span id="year">2022</span> <a href="about.jsp" target="_blank">逸仙苑</a> |&nbsp;Powered by&nbsp;
                                                            <a href="https://www.sysu.edu.cn/" target="_blank">SYSU</a> |&nbsp;Organization&nbsp; <a href="https://cse.sysu.edu.cn/" target="_blank">CSE</a> <br>
                                                        </div>
                                                    </div>
                                                </footer>
                                        </body>

                                        </html>