<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加教室信息</title>
</head>
<body bgcolor="cccfff">
	<%
		request.setCharacterEncoding("UTF-8");
		if (session.getAttribute("level") != null && session.getAttribute("level").equals("admin")) {
	%>
	<br>
	<br>
	<center>
		<form action="../../insertRoomInfo" method="post">
			<table align="center" width="300" border="1">
				<th colspan="2" align="center">添加教室信息</th>
				<tr>
					<td>教室号</td>
					<td><input type="text" name="roomNum" /></td>
				</tr>
				<tr>
					<td>教室座位数</td>
					<td><input type="text" name="roomSeats" /></td>
				</tr>
				<tr>
					<td>教室类别</td>
					<td><input type="text" name="roomClass" /></td>
				</tr>
				<tr>
					<td>所属单位</td>
					<td><input type="text" name="roomDept" /></td>
				</tr>
				<tr>
					<td>工作需求</td>
					<td><input type="text" name="roomRequire" /></td>
				</tr>
				<tr align="center">
					<td colspan="2"><input name="sure" type="submit" value="提交">
						&nbsp; &nbsp; &nbsp; &nbsp; <input name="clear" type="reset"
						value="重置"></td>
				</tr>
			</table>
		</form>
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