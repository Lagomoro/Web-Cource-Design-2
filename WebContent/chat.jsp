<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pers.ZY2018003010152.MySQLModel" %>
<%@ page import="pers.ZY2018003010152.Comment" %>
<%@ page import="java.util.ArrayList" %>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Web技术课程网站 - 讨论专区</title>
        <link rel="stylesheet" type="text/css" href="css/identity-base-compact-light.min.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/menu.css" />
        <link rel="stylesheet" type="text/css" href="css/banner.css" />
        <link rel="stylesheet" type="text/css" href="css/category.css" />
        <link rel="stylesheet" type="text/css" href="css/lead.css" />
        <link rel="stylesheet" type="text/css" href="css/content.css" />
        <link rel="stylesheet" type="text/css" href="css/chatbox.css" />
        <link rel="stylesheet" type="text/css" href="css/reply.css" />
        <link rel="stylesheet" type="text/css" href="css/bottom.css" />
        <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
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
            <label>您的位置：<a href="./index.jsp">首页</a> > 讨论专区</label>
        </div>
        <div class="content">
            <label></label>
            <label style="font-size: 18pt;text-align: center;">讨论专区</label>
            <label style="text-align: center;"><a href = "javascript:void(0)" onclick="showReply(-1, '发布新讨论：<br>在这里写下你的话题。')">发布新讨论</a></label>
            <label></label>
            <div id="chatContent" class="chatbox">
                <%
                MySQLModel.init();
        		ArrayList<Comment> comments = MySQLModel.getAllComment();
                StringBuilder builder = new StringBuilder();
                for (Comment comment : comments) {
                    if(!comment.haveFather()) {
                        comment.toHtml(comments, builder);
                    }
                }
		        %>
                <%=builder.toString()%>
            </div>
        </div>
        <div id="replyWindow" class="reply_window">
            <label id="replyInfo"></label>
            <form action="comment.do" method="post" onsubmit='return checkCommentForm()' target="replyBackContent" accept-charset="UTF-8">
                <textarea autofocus="autofocus" id="content" placeholder="请输入回复内容" required="true" class="form-control customInput2 valid"></textarea>
                <input type="hidden" id="father" name="father"/>
                <input type="hidden" id="content_data" name="content"/>
                <input type="button" value="关闭" onclick = "hideReply()" class="btn btn-lg reply_button_left"/><input type="submit" id="confirm" value="下一步" class="btn btn-primary btn-lg reply_button_right"/>
            </form>
            <iframe src="" frameborder="0" name="replyBackContent" style="display: none;"></iframe> 
        </div> 
        <script type="text/javascript" src="js/reply.js"></script>
        <div id="replyFade" class="black_overlay"></div> 
        <div class="bottom footerNote halfSecTrans">
            <label>201800301015 - 王永睿</label><label> - Java Web Course Design - </label><label>作业1：web技术课程网站</label><label>©2019 Designed by Lagomoro</label>
        </div>
    </body>
</html>
