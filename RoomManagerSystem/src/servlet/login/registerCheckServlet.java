package servlet.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.admin_userBean;
import bean.normal_userBean;
import dao.admin_userDB;
import dao.normal_userDB;

@WebServlet("/registerCheckServlet")
public class registerCheckServlet extends HttpServlet {

	public registerCheckServlet() {
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
		out.println("  <HEAD><meta charset=\"UTF-8\"><TITLE>registerCheckServlet</TITLE></HEAD>");
		out.println("  <BODY>");
		// =======================================================
		request.setCharacterEncoding("utf-8");
		String memberName = request.getParameter("memberName");
		String memberPassword = request.getParameter("password1");
		String memberSex = request.getParameter("memberSex");
		String email = request.getParameter("email");
		String memberTel = request.getParameter("memberTel");
		String loginPre = request.getParameter("loginPre");

		if (loginPre.equals("normal")) {
			
			normal_userBean nub = new normal_userBean();
			normal_userDB nud = new normal_userDB();
			nub.setNormal_memberName(memberName);
			nub.setNormal_memberPassword(memberPassword);
			nub.setNormal_memberSex(memberSex);
			nub.setNormal_email(email);
			nub.setNormal_memberTel(memberTel);
			try {
				if(nud.queryById(memberName)!=null){
					out.print("<script> alert(\"memberName conflict!\");location.href=\"login/register.html\"; </script>");
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			try {
				if (nud.insertData(nub)) {
					System.out.println("normal_user数据插入成功！");
					out.print("<script> alert(\"register success!\");top.location.href=\"login/login.jsp\"; </script>");
					// response.sendRedirect("../../../login/login.jsp");
				} else {
					out.print("<script> alert(\"register failure!\");top.location.href=\"login/login.jsp\"; </script>");
				}
			} catch (SQLException e) {
				System.out.println("registerCheckServlet error!");
				e.printStackTrace();
			}
		}
		else if(loginPre.equals("admin")) {
			
			admin_userBean aub = new admin_userBean();
			admin_userDB aud = new admin_userDB();
			try {
				if(aud.queryById(memberName)!=null){
					out.print("<script> alert(\"memberName conflict!\");location.href=\"login/register.html\"; </script>");
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			aub.setAdmin_memberName(memberName);
			aub.setAdmin_memberPassword(memberPassword);
			aub.setAdmin_memberSex(memberSex);
			aub.setAdmin_email(email);
			aub.setAdmin_memberTel(memberTel);
			try {
				if (aud.insertData(aub)) {
					System.out.println("admin_user数据插入成功！");
					out.print("<script> alert(\"register success!\");location.href=\"login/login.jsp\"; </script>");
					// response.sendRedirect("../../../login/login.jsp");
				} else {
					out.print("<script> alert(\"register failure!\");location.href=\"login/login.jsp\"; </script>");
				}
			} catch (SQLException e) {
				System.out.println("registerCheckServlet error!");
				e.printStackTrace();
			}
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
