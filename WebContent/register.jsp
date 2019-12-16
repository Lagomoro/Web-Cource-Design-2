<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pers.ZY2018003010152.MySQLModel" %>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Web技术课程网站 - 注册</title>
        <link rel="stylesheet" type="text/css" href="css/identity-base-compact-light.min.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/menu.css" />
        <link rel="stylesheet" type="text/css" href="css/banner.css" />
        <link rel="stylesheet" type="text/css" href="css/category.css" />
        <link rel="stylesheet" type="text/css" href="css/lead.css" />
        <link rel="stylesheet" type="text/css" href="css/content.css" />
        <link rel="stylesheet" type="text/css" href="css/bottom.css" />
        <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="js/md5.min.js"></script>
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
            <label>您的位置：<a href="./index.jsp">首页</a> > 注册</label>
        </div>
        <div class="content" style="width: 480px;">
            <label></label>
            <label style="font-size: 18pt;text-align: center;">注册web技术课程账户</label>
            <label></label>
            <label style="padding-left: 2px;color: red;font-size: 10pt;text-align: center;display: none;" id="warning"></label>
            <form action="register.do" method="post" onsubmit='return checkRegisterForm()' target="registerBackContent"  accept-charset="UTF-8">
                <label style="padding-left: 2px;color: darkgray;">用户名</label><br>
                <div>
                    <input type="text" id="username" name="username" placeholder="请输入用户名" autofocus="autofocus" class="form-control customInput2 valid"/>
                </div>
                <label></label>
                <label style="padding-left: 2px;color: darkgray;">昵称</label><br>
                <div>
                    <input type="text" id="nickname" name="nickname" placeholder="请输入昵称" autofocus="autofocus" class="form-control customInput2 valid"/>
                </div>
                <label></label>
                <label style="padding-left: 2px;color: darkgray;">密码</label><br>
                <div>
                    <input type="password" id="password" placeholder="请输入密码" class="form-control customInput2 valid"/>
                </div>
                <label></label>
                <label style="padding-left: 2px;color: darkgray;">确认密码</label><br>
                <div>
                    <input type="password" id="confirm_password" placeholder="请再次输入密码" class="form-control customInput2 valid"/>
                </div>
                <input type="hidden" id="md5_password" name="password"/>
                <label></label>
                <input type="submit" id="confirm" value="下一步" class="btn btn-primary btn-lg btn-block"/>
            </form>
            <iframe src="" frameborder="0" name="registerBackContent" style="display: none;"></iframe> 
            <label></label>
            <label style="text-align: center;"><a href="./login.html">已有帐户？前往登录 >></a></label>
            <label></label>
            <label></label>
            <label></label>
            <label></label>
            <label></label>
            <label></label>
        </div>
        <script type="text/javascript" src="js/register.js"></script>
        <div class="bottom footerNote halfSecTrans">
            <label>201800301015 - 王永睿</label><label> - Java Web Course Design - </label><label>作业1：web技术课程网站</label><label>©2019 Designed by Lagomoro</label>
        </div>
    </body>
</html>