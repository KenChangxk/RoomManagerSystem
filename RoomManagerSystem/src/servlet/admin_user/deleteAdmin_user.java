package servlet.admin_user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.admin_userBean;
import bean.normal_userBean;
import dao.admin_userDB;
import dao.normal_userDB;
@WebServlet("/deleteAdmin_user")
public class deleteAdmin_user extends HttpServlet {

	public deleteAdmin_user() {
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
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		// =======================================================
		String memberName = request.getParameter("admin_memberName");
		String memberPassword = request.getParameter("admin_memberPassword");
		String memberSex = request.getParameter("admin_memberSex");
		String email = request.getParameter("admin_email");
		String memberTel = request.getParameter("admin_memberTel");
		admin_userBean aub = new admin_userBean();
		admin_userDB aud = new admin_userDB();
//		System.out.println("接收值：" + memberName + " " + memberPassword + " " + memberSex + " " + email + " " + memberTel);
		aub.setAdmin_memberName(memberName);
		aub.setAdmin_memberPassword(memberPassword);
		aub.setAdmin_memberSex(memberSex);
		aub.setAdmin_email(email);
		aub.setAdmin_memberTel(memberTel);
		try {
			if (aud.deleteUser(aub)) {
				out.print("<script> alert(\"delete success!\");top.location.href=\"frames/main.jsp\"; </script>");
			} else {
				out.print("<script> alert(\"delete failure!\");top.location.href=\"frames/main.jsp\"; </script>");
			}
		} catch (SQLException e) {
			System.out.println("删除异常！");
			e.printStackTrace();
		}


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
