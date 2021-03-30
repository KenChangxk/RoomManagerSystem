<%@page import="java.sql.ResultSet"%>
<%@page import="dao.roomInfoDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除教室信息</title>
</head>
<body bgcolor="cccfff">
	<center>
		<%
			request.setCharacterEncoding("utf-8");
			if (session.getAttribute("level") != null && session.getAttribute("level").equals("admin")) {
		%>
		<br> <br>
		<form action="../../deleteRoomInfo" method="post">
			<table border="1" width="300px">
				<th colspan="2" align="center">教室信息删除</th>
				<tr>
					<td>教室号</td>
					<td><select name="select0" size="1">
							<%
								roomInfoDB rd = new roomInfoDB();
									ResultSet rs = rd.queryAll();
									while (rs.next()) {
							%>
							<option value="<%=rs.getString("roomNum")%>"><%=rs.getString("roomNum")%></option>
							<%
								}
									rs.close();
							%>
					</select></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="提交">
					</td>
				</tr>
			</table>
		</form>
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
	</center>
</body>
</html>