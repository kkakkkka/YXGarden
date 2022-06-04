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
                            <title>博客页</title>
                            <link rel="icon" type="image/png" href="./favicon.ico">
                            <link rel="stylesheet" type="text/css" href="./css/awesome/css/all.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/materialize/materialize.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/animate/animate.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/lightGallery/css/lightgallery.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/matery.css">
                            <link rel="stylesheet" type="text/css" href="./css/my.css">
                            <link rel="stylesheet" type="text/css" href="./css/tocbot.css">
                            <link rel="stylesheet" type="text/css" href="./css/myaos.css">
                            <script src="./js/myaos.js"></script>
                        </head>

                        <%
String blogID_str = request.getParameter("blogID");
if (blogID_str == null || blogID_str == "") {
	out.write("<script>alert('沒有blogID！');window.location.href='home.jsp';</script>");
	return;
}
int blogID = Integer.parseInt(blogID_str);
Connection conn = null;
try {
	Class.forName("com.mysql.jdbc.Driver");
	String connectionUrl = "jdbc:mysql://172.18.187.253:3306/boke18329015?useUnicode=true&characterEncoding=UTF-8";
	conn = DriverManager.getConnection(connectionUrl, "user", "123");
} catch (Exception e) {
	out.write("<script>alert('连接数据库出错！');</script>");
	return;
}
String SQL = String.format("select * from blog natural join user natural join cat natural join tag where blogID = %d;",
		blogID);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(SQL);
Map<String, String> article = new HashMap<>();
if (rs.next()) {
	article.put("userName", rs.getString("userName"));
	article.put("tagName", rs.getString("tagName"));
	article.put("catName", rs.getString("catName"));
	article.put("title", rs.getString("title"));
	String content = rs.getString("content");
	int wordCnt = content.length();
	String releaseTime = new SimpleDateFormat("yyyy-MM-dd").format(rs.getTimestamp("releaseTime"));
	String updateTime = new SimpleDateFormat("yyyy-MM-dd").format(rs.getTimestamp("updateTime"));
	article.put("content", content);
	article.put("releaseTime", releaseTime);
	article.put("updateTime", updateTime);
	article.put("wordCnt", Integer.toString(wordCnt));
	article.put("readTime", String.format("%.1f 分钟",(double)wordCnt / 500));
} else {
	out.write("<script>alert('blog不存在！');window.location.href='home.jsp';</script>");
	return;
}
pageContext.setAttribute("article", article);
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
                                    <link rel="stylesheet" href="./css/tocbot.css">
                                    <style>
                                        #articleContent h1::before,
                                        #articleContent h2::before,
                                        #articleContent h3::before,
                                        #articleContent h4::before,
                                        #articleContent h5::before,
                                        #articleContent h6::before {
                                            display: block;
                                            content: " ";
                                            height: 100px;
                                            margin-top: -100px;
                                            visibility: hidden;
                                        }
                                        
                                        #articleContent :focus {
                                            outline: none;
                                        }
                                        
                                        .toc-fixed {
                                            position: fixed;
                                            top: 64px;
                                        }
                                        
                                        .toc-widget {
                                            width: 345px;
                                            padding-left: 20px;
                                        }
                                        
                                        .toc-widget .toc-title {
                                            padding: 35px 0 15px 17px;
                                            font-size: 1.5rem;
                                            font-weight: bold;
                                            line-height: 1.5rem;
                                        }
                                        
                                        .toc-widget ol {
                                            padding: 0;
                                            list-style: none;
                                        }
                                        
                                        #toc-content {
                                            padding-bottom: 30px;
                                            overflow: auto;
                                        }
                                        
                                        #toc-content ol {
                                            padding-left: 10px;
                                        }
                                        
                                        #toc-content ol li {
                                            padding-left: 10px;
                                        }
                                        
                                        #toc-content .toc-link:hover {
                                            color: #42b983;
                                            font-weight: 700;
                                            text-decoration: underline;
                                        }
                                        
                                        #toc-content .toc-link::before {
                                            background-color: transparent;
                                            max-height: 25px;
                                            position: absolute;
                                            right: 23.5vw;
                                            display: block;
                                        }
                                        
                                        #toc-content .is-active-link {
                                            color: #42b983;
                                        }
                                        
                                        #floating-toc-btn {
                                            position: fixed;
                                            right: 15px;
                                            bottom: 76px;
                                            padding-top: 15px;
                                            margin-bottom: 0;
                                            z-index: 998;
                                        }
                                        
                                        #floating-toc-btn .btn-floating {
                                            width: 48px;
                                            height: 48px;
                                        }
                                        
                                        #floating-toc-btn .btn-floating i {
                                            line-height: 48px;
                                            font-size: 1.4rem;
                                        }
                                        
                                        #artDetail {
                                            text-align: center;
                                        }
                                    </style>
                                    <div class="row">
                                        <div  id="main-content"  class="s12 m12">
                                            <!-- 文章内容详情 -->
                                            <div id="artDetail" style="width: 70%; margin: auto;"  >
                                                <div class="card">
                                                    <div class="card-content article-info">
                                                        <div class="row tag-cate">
                                                            <div class="col s7">
                                                                <div class="article-tag" style="width: 30%; margin: left;">
                                                                    <a href="tags.jsp"> <span class="chip bg-color"><c:out
													value="${article.get('tagName')}"></c:out></span>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <div class="col s5 right-align">
                                                                <div class="post-cate">
                                                                    <i class="fas fa-bookmark fa-fw icon-category"></i>
                                                                    <a href="categories.jsp" class="post-category">
                                                                        <c:out value="${article.get('catName')}"></c:out>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="post-info">
                                                            <div class="post-date info-break-policy">
                                                                <i class="far fa-calendar-minus fa-fw"></i>发布日期:&nbsp;&nbsp;
                                                                <c:out value="${article.get('releaseTime')}"></c:out>
                                                            </div>
                                                            <div class="post-date info-break-policy">
                                                                <i class="far fa-calendar-check fa-fw"></i>更新日期:&nbsp;&nbsp;
                                                                <c:out value="${article.get('updateTime')}"></c:out>
                                                            </div>
                                                            <div class="info-break-policy">
                                                                <i class="far fa-file-word fa-fw"></i>文章字数:&nbsp;&nbsp;
                                                                <c:out value="${article.get('wordCnt')}"></c:out>
                                                            </div>
                                                            <div class="info-break-policy">
                                                                <i class="far fa-clock fa-fw"></i>阅读时长:&nbsp;&nbsp;
                                                                <c:out value="${article.get('readTime')}"></c:out>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <hr class="clearfix">
                                                    <div class="card-content article-card-content">
                                                        <div id="articleContent">
                                                            <h2 id="Abstract">
                                                                <a href="#Abstract" class="headerlink" title="Abstract"></a>
                                                                <c:out value="${article.get('title')}"></c:out>
                                                            </h2>
                                                            <p style="text-align: left;">
                                                                <c:out value="${article.get('content')}"></c:out>
                                                            </p>
                                                        </div>
                                                        <hr />
                                                        <div class="reprint" id="reprint-statement">
                                                            <div class="reprint__author">
                                                                <span class="reprint-meta" style="font-weight: bold;"> <i
										class="fas fa-user"> 文章作者: </i>
									</span> <span class="reprint-info"> <a href="about.jsp"
										rel="external nofollow noreferrer"><c:out value="${article.get('userName')}"></c:out></a>
									</span>
                                                            </div>
                                                            <div class="reprint__type">
                                                                <span class="reprint-meta" style="font-weight: bold;">
								</div>
								<div class="reprint__notice">
									<span class="reprint-meta" style="font-weight: bold;"> <i
										class="fas fa-copyright"> 版权声明: </i>
									</span> <span class="reprint-info"> 本博客所有文章除特別声明外，均采用 <a
										href="https://creativecommons.org/licenses/by/4.0/deed.zh"
										rel="external nofollow noreferrer" target="_blank">CC BY
											4.0</a> 许可协议。转载请注明来源 <a href="about.jsp" target="_blank"><c:out value="${article.get('userName')}"></c:out></a>
										!
									</span>
                                                            </div>

                                                        </div>
                                                        <div class="tag_share" style="display: block;">
                                                            <div class="post-meta__tag-list" style="display: inline-block;">
                                                                <div class="article-tag">
                                                                    <a href="tags.jsp"> <span class="chip bg-color"><c:out
													value="${article.get('tagName')}"></c:out></span>
                                                                    </a>

                                                                </div>

                                                            </div>
                                                            <div class="post_share" style="zoom: 80%; width: fit-content; display: inline-block; float: right; margin: -0.15rem 0;">
                                                                <link rel="stylesheet" type="text/css" href="./css/share/css/share.min.css">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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
                                            Copyright&nbsp;&copy; <span id="year">2022</span> <a href="about.jsp" target="_blank">逸仙苑</a> |&nbsp;Powered by&nbsp;<a href="https://www.sysu.edu.cn/" target="_blank">SYSU</a> |&nbsp;Organization&nbsp; <a href="https://cse.sysu.edu.cn/"
                                                target="_blank">CSE</a> <br>
                                        </div>
                                    </div>
                                </footer>
                            </body>

                        </html>