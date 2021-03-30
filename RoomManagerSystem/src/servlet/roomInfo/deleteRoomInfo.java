package servlet.roomInfo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.roomInfoDB;

@WebServlet("/deleteRoomInfo")
public class deleteRoomInfo extends HttpServlet {

	public deleteRoomInfo() {
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
		//=======================================================
			String roomNum = request.getParameter("select0");
			roomInfoDB rd = new roomInfoDB();
			try {
				if(rd.deleteRoomInfoById(roomNum)){
					System.out.println("roomInfo数据删除成功！");
					out.print("<script> alert(\"roomInfo delete success!\");top.location.href=\"frames/main.jsp\"; </script>");
				}else {
					System.out.println("roomInfo数据删除失败！");
					out.print("<script> alert(\"roomInfo delete failure!\");top.location.href=\"frames/main.jsp\"; </script>");
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
