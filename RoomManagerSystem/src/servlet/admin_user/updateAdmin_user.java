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

@WebServlet("/updateAdmin_user")
public class updateAdmin_user extends HttpServlet {

	public updateAdmin_user() {
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
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String oldName = (String) request.getParameter("oldName");
//		System.out.println("servlet接受值："+oldName);
		String memberName = request.getParameter("memberName");
		String memberPassword = request.getParameter("password");
		String memberSex = request.getParameter("gender");
		String email = request.getParameter("email");
		String memberTel = request.getParameter("memberTel");
		admin_userBean aub = new admin_userBean();
		aub.setAdmin_memberName(memberName);
		aub.setAdmin_memberPassword(memberPassword);
		aub.setAdmin_memberSex(memberSex);
		aub.setAdmin_email(email);
		aub.setAdmin_memberTel(memberTel);
		admin_userDB aud = new admin_userDB();
		try {
			if(aud.updateUser(aub, oldName)){
				System.out.println("数据修改成功！");
				if(oldName.equals(memberName))
					out.print("<script > alert(\"update success!\");top.location.href=\"frames/main.jsp\"; </script>");
				else
					out.print("<script > alert(\"update success,login again!\");top.location.href=\"login/login.jsp\"; </script>");
					
			}else{
				System.out.println("数据修改失败！");
				out.print("<script > alert(\"update faliure!\");location.href=\"frames/main.jsp\"; </script>");
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
