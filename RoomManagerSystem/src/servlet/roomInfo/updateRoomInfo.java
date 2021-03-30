package servlet.roomInfo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.roomInfoBean;
import dao.roomInfoDB;
@WebServlet("/updateRoomInfo")
public class updateRoomInfo extends HttpServlet {

	public updateRoomInfo() {
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
		String roomNum = request.getParameter("roomNum");
		int roomSeats = Integer.valueOf(request.getParameter("roomSeats"));
		String roomClass = request.getParameter("roomClass");
		String roomDept = request.getParameter("roomDept");
		String roomRequire = request.getParameter("roomRequire");

		roomInfoBean rb = new roomInfoBean();
		roomInfoDB rd = new roomInfoDB();
		rb.setRoomNum(roomNum);
		rb.setRoomSeats(roomSeats);
		rb.setRoomClass(roomClass);
		rb.setRoomDept(roomDept);
		rb.setRoomRequire(roomRequire);
		
		try {
			if(rd.deleteRoomInfoById(roomNum)){
				if(rd.insertData(rb)) {
					System.out.println("教室信息修改成功！");
					out.print("<script > alert(\"update success!\");top.location.href=\"frames/main.jsp\"; </script>");
				}else{
					System.out.println("插入过程中出现错误！");
					out.print("<script > alert(\"update failure!\");top.location.href=\"login/login.jsp\"; </script>");
				}
			}else{
				System.out.println("删除过程中出现错误！");
				out.print("<script > alert(\"update failure!\");location.href=\"frames/main.jsp\"; </script>");
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
	}

}
