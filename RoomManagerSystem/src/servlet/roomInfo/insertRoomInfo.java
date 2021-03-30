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
@WebServlet("/insertRoomInfo")
public class insertRoomInfo extends HttpServlet {
	public insertRoomInfo() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		//=======================================================
			
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
				if (rd.insertData(rb)) {
					System.out.println("roomInfo数据插入成功！");
					out.print("<script> alert(\"roomInfo add success!\");top.location.href=\"frames/main.jsp\"; </script>");
				} else {
					out.print("<script> alert(\"roomInfo add failure!\");top.location.href=\"frames/main.jsp\"; </script>");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		//=======================================================
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
