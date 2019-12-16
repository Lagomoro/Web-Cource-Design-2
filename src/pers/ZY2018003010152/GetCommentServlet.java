package pers.ZY2018003010152;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "GetCommentServlet", urlPatterns = { "/getComment.do" })
public class GetCommentServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
	    getServletContext().log("获取讨论请求");
        
		MySQLModel.init();
		
		ArrayList<Comment> comments = MySQLModel.getAllComment();
		StringBuilder builder = new StringBuilder();
		for (Comment comment : comments) {
			if(!comment.haveFather()) {
				comment.toHtml(comments, builder);
			}
		}
		
		response.setContentType("text/plain;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("{\"err_code\":0,\"err_msg\":\"" + builder.toString() + "\"}");
		getServletContext().log("获取讨论请求：获取成功");
	}

}
