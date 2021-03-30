package servlet.normal_user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import bean.normal_userBean;
import dao.normal_userDB;

@WebServlet("/updateNormal_user")
public class updateNormal_user extends HttpServlet {

	public updateNormal_user() {
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
		out.println("  <HEAD><TITLE>updateNormal_user</TITLE></HEAD>");
		out.println("  <BODY>");
		// =======================================================
		request.setCharacterEncoding("utf-8");
		String memberName = request.getParameter("memberName");
		String memberPassword = request.getParameter("password");
		String memberSex = request.getParameter("gender");
		String email = request.getParameter("email");
		String memberTel = request.getParameter("memberTel");
		normal_userBean nub = new normal_userBean();
		nub.setNormal_memberName(memberName);
		nub.setNormal_memberPassword(memberPassword);
		nub.setNormal_memberSex(memberSex);
		nub.setNormal_email(email);
		nub.setNormal_memberTel(memberTel);
		HttpSession session = request.getSession();
		normal_userDB nud = new normal_userDB();
		try {
			if (nud.updateUser(nub)) {
				System.out.println("数据修改成功！");
				out.print("<script > alert(\"update success!\");top.location.href=\"frames/main.jsp\"; </script>");
			} else {
				System.out.println("数据修改失败！");
				out.print("<script > alert(\"update failure!\");top.location.href=\"frames/main.jsp\"; </script>");
			}
		} catch (SQLException e) {
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
