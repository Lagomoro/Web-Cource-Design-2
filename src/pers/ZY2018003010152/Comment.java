package pers.ZY2018003010152;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class Comment {
	
	private int id;
	private String username;
	private String content;
	private int father;
	private Timestamp timestamp;
	
	private ArrayList<Comment> childs;
	
	public Comment(int id, String username, String content, int father, Timestamp timestamp) {
		this.id = id;
		this.username = username;
		this.content = content;
		this.father = father;
		this.timestamp = timestamp;
		
		this.childs = new ArrayList<Comment>();
	}
	
	public boolean haveFather() {
		return this.father >= 0;
	}
	
	public int getFather() {
		return this.father;
	}
	
	public Comment getFatherComment(ArrayList<Comment> comments) {
		if(!this.haveFather()) return null;
		for (Comment comment : comments) {
			if(comment.getId() == this.getFather()){
				return comment;
			}
		}
		return null;
	}
	
	public Comment getSuperFatherComment(ArrayList<Comment> comments) {
		if(!this.haveFather()) return this;
		for (Comment comment : comments) {
			if(comment.getId() == this.getFather()){
				return comment.getSuperFatherComment(comments);
			}
		}
		return null;
	}
	
	public int getId() {
		return id;
	}
	
	public void addChild(Comment comment) {
		this.childs.add(comment);
	}
	
	public String getReplaceContent() {
		String content = this.content;
		content = content.replace("<br>", " ");
		return content;
	}
	
	public String getStar() {
		return this.username.equals("webteach") ? "<font style=\\\"color: gold; font-size: 10px\\\">官方认证：任课教师</font>" : "";
	}
	
	public String getJspStar() {
		return this.username.equals("webteach") ? "<font style=\"color: gold; font-size: 10px\">官方认证：任课教师</font>" : "";
	}
	
	public void toHtml(ArrayList<Comment> comments, StringBuilder builder) {
		if(this.haveFather()) {
			Comment fatherComment = this.getFatherComment(comments);
			if(fatherComment != null) {
				builder.append("<div><label>" + MySQLModel.getUserNickname(this.username) + "&lt;" + this.username + "&gt;" + this.getStar() + " " + 
						new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(this.timestamp) + " &nbsp;&nbsp;&nbsp;&nbsp;" + 
						"<a href=\\\"javascript:void(0)\\\" onclick=\\\"showReply(" + this.getId() + ", \'" + 
						this.getReplyHtml(30) + "\')\\\">回复</a></label>");
				builder.append(fatherComment.haveFather() ? fatherComment.getCallbackHtml(0) : "");
				builder.append("<label>" + this.content + "</label></div>");
			}
		} else {
			builder.append("<div><label>" + MySQLModel.getUserNickname(this.username) + "&lt;" + this.username + "&gt;" + this.getStar() + " " + 
					new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(this.timestamp) + " &nbsp;&nbsp;&nbsp;&nbsp;" + 
					"<a href=\\\"javascript:void(0)\\\" onclick=\\\"showReply(" + this.getId() + ", \'" + 
					this.getReplyHtml(30) +  "\')\\\">回复</a></label>");
			builder.append("<label>" + this.content + "</label>");
			for (Comment comment : childs) {
				comment.toHtml(comments, builder);
			}
			builder.append("</div>");
		}
	}
	
	public void toJspHtml(ArrayList<Comment> comments, StringBuilder builder) {
		if(this.haveFather()) {
			Comment fatherComment = this.getFatherComment(comments);
			if(fatherComment != null) {
				builder.append("<div><label>" + MySQLModel.getUserNickname(this.username) + "&lt;" + this.username + "&gt;" + this.getJspStar() + " " + 
						new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(this.timestamp) + " &nbsp;&nbsp;&nbsp;&nbsp;" + 
						"<a href=\"javascript:void(0)\" onclick=\"showReply(" + this.getId() + ", '" + 
						this.getReplyHtml(30) + "')\">回复</a></label>");
				builder.append(fatherComment.haveFather() ? fatherComment.getCallbackHtml(0) : "");
				builder.append("<label>" + this.content + "</label></div>");
			}
		} else {
			builder.append("<div><label>" + MySQLModel.getUserNickname(this.username) + "&lt;" + this.username + "&gt;" + this.getJspStar() + " " + 
					new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(this.timestamp) + " &nbsp;&nbsp;&nbsp;&nbsp;" + 
					"<a href=\"javascript:void(0)\" onclick=\"showReply(" + this.getId() + ", \'" + 
					this.getReplyHtml(30) +  "\')\">回复</a></label>");
			builder.append("<label>" + this.content + "</label>");
			for (Comment comment : childs) {
				comment.toJspHtml(comments, builder);
			}
			builder.append("</div>");
		}
	}
	
	public String getCallbackHtml(int length) {
		String callbackHtml = "<div><label>回复：" + MySQLModel.getUserNickname(this.username) + "&lt;" + this.username + "&gt;" + this.getStar() + " " + 
				new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(this.timestamp) + "<br>";
		if(length <= 0) {
			callbackHtml += this.content;
		}else {
			callbackHtml += this.content.length() > length ? this.content.substring(0, length) + "…" : this.content;
		}
		return callbackHtml + "</label></div>";
	}
	
	public String getReplyHtml(int length) {
		String content = this.getReplaceContent();
		String replyHtml = "回复：" + MySQLModel.getUserNickname(this.username) + "<br>";
		if(length <= 0) {
			replyHtml += content;
		}else {
			replyHtml += content.length() > length ? content.substring(0, length) + "…" : content;
		}
		return replyHtml;
	}
	
}
