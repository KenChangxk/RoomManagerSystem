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
<title>修改教室信息</title>
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
				<th>教室号（不可修改）</th>
				<th>座位数</th>
				<th>教室类别</th>
				<th>所属部门</th>
				<th>工作需求</th>
				<th colspan="2">操作</th>
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
			<form action="../../updateRoomInfo" method="post">
				<tr>
					<td><input type="text" name="roomNum"
						value="<%=rs.getString("roomNum")%>" readonly="readnoly"></td>
					<td><input type="text" name="roomSeats"
						value="<%=rs.getString("roomSeats")%>"</td>
					<td><input type="text" name="roomClass"
						value="<%=rs.getString("roomClass")%>"></td>
					<td><input type="text" name="roomDept"
						value="<%=rs.getString("roomDept")%>"></td>
					<td><input type="text" name="roomRequire"
						value="<%=rs.getString("roomRequire")%>"></td>

					<td><input type="submit" value="修改"></td>
					<td><input type="reset" value="重置"></td>
				</tr>
			</form>
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
			<a href="update_room.jsp?page=<%=intPage + 1%>">下一页</a>
			<%
				}
					if (intPage > 1) {
			%>
			<a href="update_room.jsp?page=<%=intPage - 1%>">上一页</a>
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