<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pers.ZY2018003010152.MySQLModel" %>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Web技术课程网站 - 教学大纲</title>
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
            <label>您的位置：<a href="./index.jsp">首页</a> > 教学大纲</label>
        </div>
        <div class="content">
            <label></label>
            <label style="font-size: 18pt;text-align: center;">教学大纲</label>
            <label></label>
            <label>
                <p>一、作业提交</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本学期作业要求大家提交三个可运行的程序包：</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（1）采用HTML, CSS, JS开发Web技术课程网站，网站主要实现教学大纲、课程介绍等教学内容的浏览，教学课件和视频资料的浏览下载，简单的留言和回复功能。Tomcat可运行的目录为ZY学号1（例如：ZY2015003012701， 这里201500301270为学生学号）, 作业以压缩文件ZY学号1.zip（例如ZY2015003012701.zip）形式提交。</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（2）采用Java Web技术开发Web技术课程网站，网站主要实现教学大纲、课程介绍等教学内容的浏览，教学课件和视频资料的浏览下载，简单的留言和回复功能。Tomcat可运行的目录为ZY学号2（例如：ZY2015003012702）, 作业以压缩文件ZY学号2.zip（例如：ZY2015003012702.zip）形式提交。</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（3）选用一种与课程相关的技术开发已电子商务系统，实现商户对网上商品的管理以及客户在平台上购物等基本功能。Tomcat可运行的目录为ZY学号3（例如：ZY2015003012703）, 作业以压缩文件ZY学号3.zip（例如：ZY2015003012703.zip）形式提交</p>
                <p>备注：</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（1）作业1，2要求至少有一个实验实现内容板块相对丰富的课程资源网站，另外一个可以只完成一个基本的框架。</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（2）作业中使用的数据库需直接访问课程提供的公共MYSQL数据IP：202.194.14.120，用户名，密码和数据名称均为webteach，学生可以在里面创建自己使用的表，实验中使用的数据表需要以web序号_（例如：web201500301270_）作为前缀，以防止同学们各自使用的表相互冲突。</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（3）上面所说的学号的位置，以自己的学号替换。</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（4）上机考试的当天将上述三个文件拷贝监考老师。</p>
                <p>二、本学期的考试</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本学期笔试考试和上机考试在17周同一时间统一地点进行，笔试考试1小时，上机考试2~3小时，笔试考试结束后进行上级考试，考试地点在实验中心，具体考试时间和机房另行通知，考试时间机器不能上网，只能访问数据库服务器，同学可以带纸质的参考资料，不允许带电子的资料，Tomcat可运行的目录为KS学号（例如：KS201500301270）, 考试程序以压缩文件KS学号.zip（例如：KS201500301270.zip）形式考试结束拷贝监考老师：</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;运行环境：应用服务器Tomcat8 浏览器Google Chrome</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;开发环境：Eclipse </p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;数据库服务器：202.194.14.120 数据库的用户名，密码和数据库名均为webteach</p>
                <p>成绩组成：</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（1）实验1与2 成绩20分</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（2）实验3 成绩30分</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（3）笔试成绩 20 分</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（4）上机成绩30分</p>
            </label>
        </div>
        <div class="bottom footerNote halfSecTrans">
            <label>201800301015 - 王永睿</label><label> - Java Web Course Design - </label><label>作业1：web技术课程网站</label><label>©2019 Designed by Lagomoro</label>
        </div>
    </body>
</html>