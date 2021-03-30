package servlet.normal_user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.normal_userBean;
import dao.normal_userDB;

@WebServlet("/deleteNormal_user")
public class deleteNormal_user extends HttpServlet {

	public deleteNormal_user() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>deleteNormal_user</TITLE></HEAD>");
		out.println("  <BODY>");
		// =======================================================

		String memberName = request.getParameter("normal_memberName");
		String memberPassword = request.getParameter("normal_memberPassword");
		String memberSex = request.getParameter("normal_memberSex");
		String email = request.getParameter("normal_email");
		String memberTel = request.getParameter("normal_memberTel");
		normal_userBean nub  =new normal_userBean();
		normal_userDB nud = new normal_userDB();
 		System.out.println("接收值：" + memberName + " " + memberPassword + " " + memberSex + " " + email + " " + memberTel);
		nub.setNormal_memberName(memberName);
		nub.setNormal_memberPassword(memberPassword);
		nub.setNormal_memberSex(memberSex);
		nub.setNormal_email(email);
		nub.setNormal_memberTel(memberTel);
		try {
			if(nud.deleteUser(nub)){
				out.print("<script> alert(\"delete success!\");top.location.href=\"frames/main.jsp\"; </script>");
			}else {
				out.print("<script> alert(\"delete failure!\");top.location.href=\"frames/main.jsp\"; </script>");
			}
		} catch (SQLException e) {
			System.out.println("删除异常！");
			e.printStackTrace();
		}

		// =======================================================
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
