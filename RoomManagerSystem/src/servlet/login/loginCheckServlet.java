package servlet.login;

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

@WebServlet("/loginCheckServlet")
public class loginCheckServlet extends HttpServlet {
	public loginCheckServlet() {
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
		out.println("<html>");
		out.println("  <HEAD>");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />");
		out.println("<TITLE>loginCheckServlet</TITLE></HEAD>");
		out.println("<BODY>");
		//=======================================================
		request.setCharacterEncoding("utf-8");
		String login_name = request.getParameter("userName");
		String login_pwd = request.getParameter("password");
		String login_level = request.getParameter("loginPre");
		HttpSession  session = request.getSession();
		session.setAttribute("userName", "");
		if (login_level.equals("normal")) {
			normal_userDB nub = new normal_userDB();
			normal_userBean nb = new normal_userBean();
			try {
				nb = nub.queryById(login_name);
				if(nb==null) {
					System.out.println("login failure！");
					out.print("<script> alert(\"please confirm your account!\");location.href=\"login/login.jsp\"; </script>");
				}else{
					String pwd = nb.getNormal_memberPassword();
					if(pwd.equals(login_pwd)) {
						session.setAttribute("userName", login_name);
						session.setAttribute("level", login_level);
						System.out.println("登录成功！");
						out.print("<script > alert(\"login success!\");location.href=\"frames/main.jsp\"; </script>");
					}else {
						System.out.println("login failure！");
						out.print("<script> alert(\"please confirm your password!\");location.href=\"login/login.jsp\"; </script>");
					}
				}
			} catch (SQLException e) {
				System.out.println("loginCheckServlet error!");
				e.printStackTrace();
			}
		} else if (login_level.equals("admin")) {
			admin_userDB aud = new admin_userDB();
			admin_userBean ab = new admin_userBean();
			try {
				ab = aud.queryById(login_name);
				if (ab==null) {
					System.out.println("login failure！");
					out.print("<script> alert(\"please confirm your account!\");location.href=\"login/login.jsp\"; </script>");
				}else{
					String pwd = ab.getAdmin_memberPassword();
					if(pwd.equals(login_pwd)) {
						session.setAttribute("userName", login_name);
						session.setAttribute("level", login_level);
						System.out.println("登录成功！");
						out.print("<script > alert(\"login success!\");location.href=\"frames/main.jsp\"; </script>");
					}else {
						System.out.println("login failure！");
						out.print("<script> alert(\"please confirm your password!\");location.href=\"login/login.jsp\"; </script>");
					}
				}
			} catch (SQLException e) {
				System.out.println("loginCheckServlet error!");
				e.printStackTrace();
			}
		}
		//======================================================
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
