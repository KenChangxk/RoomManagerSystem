package servlet.roomRentInfo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import bean.normal_userBean;
import bean.roomInfoBean;
import bean.roomRentInfoBean;
import dao.normal_userDB;
import dao.roomInfoDB;
import dao.roomRentInfoDB;
import sun.net.www.content.text.plain;

@WebServlet("/insertRoomRentInfo")
public class insertRoomRentInfo extends HttpServlet {

	public insertRoomRentInfo() {
		super();
	}

	public void destroy() {
		super.destroy();
	}
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		// =======================================================
		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("userName");
		String login_level = (String) session.getAttribute("level");
		roomRentInfoDB rdb = new roomRentInfoDB();
		if (login_level.equals("normal")) {
			String select_1 = request.getParameter("select1");
			String select_2 = request.getParameter("select2");
			String select_3 = request.getParameter("select3");
			String select_4 = request.getParameter("select4");
			String roomNum = request.getParameter("roomNum");
			String date = select_1 + "-" + select_2 + "-" + select_3 + "-" + select_4;
			// System.out.println(date);

			try {
				if (rdb.is(roomNum, date)) {
					normal_userDB nud = new normal_userDB();
					normal_userBean nb = nud.queryById(userName);
					roomInfoBean nf = new roomInfoBean();
					roomRentInfoBean rb = new roomRentInfoBean();
					rb.setRent_memberName(userName);
					rb.setRent_email(nb.getNormal_email());
					rb.setRent_memberTel(nb.getNormal_memberTel());
					rb.setRent_period(date);
					rb.setRent_roomNum(roomNum);

					LocalDate nowDate = LocalDate.now();
					DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
					String now = nowDate.format(dateFormatter).toString();
					rb.setRent_Time(now);
					if (rdb.insertData(rb)) {
						System.out.println("roomRentInfo数据插入成功！");
						out.print(
								"<script> alert(\"roomRentInfo add success!\");top.location.href=\"frames/main.jsp\"; </script>");
					} else {
						out.print(
								"<script> alert(\"roomInfo add failure!\");top.location.href=\"frames/main.jsp\"; </script>");
					}
				}
				else{
					out.print(
							"<script> alert(\"room rent conflict!\");top.location.href=\"frames/main.jsp\"; </script>");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if (login_level.equals("admin")) {
			String submit = request.getParameter("submit");
			System.out.println(submit);
			String ispass;
			String roomNum = request.getParameter("roomNum");
			String memberName = request.getParameter("memberName");
			String period = request.getParameter("period"); 
			if(submit.equals("accept")) ispass = "true";
			else ispass = "false";
//			System.out.println(userName);
			try {
				if(rdb.updateRoomRentInfo(roomNum, memberName, period, ispass, userName)){
					System.out.println("审核操作成功！");
					out.print(
							"<script> alert(\"verify success!\");top.location.href=\"frames/main.jsp\"; </script>");
				}
				else{
					out.print(
							"<script> alert(\"verify faliure!\");top.location.href=\"frames/main.jsp\"; </script>");
				}
			} catch (SQLException e) {
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
