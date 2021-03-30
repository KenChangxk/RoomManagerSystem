<%@page import="dao.roomInfoDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="dao.DBJavaBean"%>
<%@page import="dao.normal_userDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看教室信息</title>
</head>

<body bgcolor="CCCFFF">
	<%
		request.setCharacterEncoding("utf-8");
		if (session.getAttribute("level") != null && session.getAttribute("level").equals("admin")) {
	%>
	<br>
	<br>
	<center>
		<table border="1" width="50%" bgcolor="cccfff" align="center">
			<tr>
				<th>教室号</th>
				<th>座位数</th>
				<th>教室类别</th>
				<th>所属部门</th>
				<th>工作需求</th>
			</tr>
			<%
				roomInfoDB rd = new roomInfoDB();
					int intPageSize; //一页显示的记录数
					int intRowCount; //记录总数
					int intPageCount; //总页数
					int intPage; //待显示页码
					String strPage;
					int i;
					intPageSize = 6;
					strPage = request.getParameter("page"); //取得待显示页码
					//System.out.println(strPage);
					if (strPage == null) {
						intPage = 1;
					} else {
						intPage = Integer.valueOf(strPage);
						if (intPage < 1)
							intPage = 1;
					}
					ResultSet rs = rd.queryAll();
					rs.last(); //光标指向查询结果集中最后一条记录
					intRowCount = rs.getRow(); //获取记录总数
					intPageCount = (intRowCount + intPageSize - 1) / intPageSize;
					if (intPage > intPageCount)
						intPage = intPageCount;
					if (intPageCount > 0) {
						rs.absolute((intPage - 1) * intPageSize + 1);
						//将记录指针定位到待显示页的第一条记录上
						//显示数据
						i = 0;
						while (i < intPageSize && !rs.isAfterLast()) {
			%>
			<tr>
				<td><%=rs.getString("roomNum")%></td>
				<td><%=rs.getString("roomSeats")%></td>
				<td><%=rs.getString("roomClass")%></td>
				<td><%=rs.getString("roomDept")%></td>
				<td><%=rs.getString("roomRequire")%></td>
			</tr>
			<%
				rs.next();
							i++;
						}
					}
			%>
		</table>
		<hr>
		<div align="center">
			第<%=intPage%>页 共<%=intPageCount%>页
			<%
			if (intPage < intPageCount) {
		%>
			<a href="look_room.jsp?page=<%=intPage + 1%>">下一页</a>
			<%
				}
					if (intPage > 1) {
			%>
			<a href="look_room.jsp?page=<%=intPage - 1%>">上一页</a>
			<%
				}
			%>
		</div>
	</center>
	<%
		} else if (session.getAttribute("level") != null && session.getAttribute("level").equals("normal")) {
	%>
	<script>
		alert("普通用户，权限不足!");
		top.location.href = "../../frames/main.jsp";
	</script>
	<%
		} else {
	%>
	<script>
		alert("权限不足，请登录!");
		top.location.href = "../../login/login.jsp";
	</script>
	<%
		}
	%>
</body>
</html>