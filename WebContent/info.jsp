<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pers.ZY2018003010152.MySQLModel" %>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Web技术课程网站 - 课程介绍</title>
        <link rel="stylesheet" type="text/css" href="css/identity-base-compact-light.min.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/menu.css" />
        <link rel="stylesheet" type="text/css" href="css/banner.css" />
        <link rel="stylesheet" type="text/css" href="css/category.css" />
        <link rel="stylesheet" type="text/css" href="css/lead.css" />
        <link rel="stylesheet" type="text/css" href="css/content.css" />
        <link rel="stylesheet" type="text/css" href="css/bottom.css" />
    </head>
    <body>
        <%
        MySQLModel.init();
		String username = null;
        String nickname = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null){
			for(int i = 0;i < cookies.length;i++){
				Cookie cookie = cookies[i];
				if(cookie.getName().equals("username")) {
					username = cookie.getValue();
					nickname = MySQLModel.getUserNickname(username);
				}
			}
		}
        %>
        <div class="menu">
            <div class="menu-logo">
                <label><a href="./index.jsp">Web技术课程网站</a></label>
            </div>
            <div class="menu-submenu">
            <% if (username == null){ %>
                <label><a href="./login.jsp" id="login">您好，请登录</a></label>
            <% }else{ %>
                <label><a href="./modify.jsp" id="login"><%="欢迎回来，" + nickname + "&lt;" + username + "&gt;"%></a></label>
            <% } %>
            </div>
        </div>
        <div class="banner">
            <img src="images/banner.jpg" />
        </div>
        <div class="category">
            <a href="./index.jsp"><input type="button" value="教学大纲" /></a><a href="./info.jsp"><input type="button" value="课程介绍"/></a><a href="./chat.jsp"><input type="button" value="讨论专区"/></a><a href="./download.jsp"><input type="button" value="资源下载"/></a>
        </div>
        <div class="lead">
            <label>您的位置：<a href="./index.jsp">首页</a> > 课程介绍</label>
        </div>
        <div class="content">
            <label></label>
            <label style="font-size: 18pt;text-align: center;">课程介绍</label>
            <label></label>
            <label>
                <p>主要内容</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Web前端开发技术</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - HTML5、CSS3、JavaScript</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Java Web 编程技术</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vue前端界面开发</p>
                <p>参考书</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Web前端开发技术</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - HTML5、CSS3、JavaScript（第三版）储久良编著，清华大学出版社</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Java Web 编程技术（第三版）</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - 沈泽刚编著，清华大学出版社</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vue.js实战</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - 梁灏，清华大学出版社</p>
            </label>
        </div>
        <div class="bottom footerNote halfSecTrans">
            <label>201800301015 - 王永睿</label><label> - Java Web Course Design - </label><label>作业1：web技术课程网站</label><label>©2019 Designed by Lagomoro</label>
        </div>
    </body>
</html>
