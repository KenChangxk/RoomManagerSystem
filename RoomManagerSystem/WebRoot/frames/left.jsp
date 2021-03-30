<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>导航栏页面</title>
</head>
<body bgcolor="cccfff">
	<%
		String name = (String)session.getAttribute("userName");
		if(session.getAttribute("level").equals("normal")){
	 %>
	 	<br>
	 	<a href="../operation/normal_user/look_normal.jsp" target="right">查看个人信息</a>
	 	<br>
	 	<br>
	 	<a href="../operation/normal_user/update_normal.jsp" target="right">修改个人信息</a>
	 	<br>
	 	<br>
	 	<a href="../operation/roomRentInfo/add_updateRentInfo.jsp" target="right">申请教室操作</a>
	 	<br>
	 	<br>
	 	<a href="../operation/roomRentInfo/look_deleteRentInfo.jsp" target="right">查看申请情况</a>
	 <%}else if(session.getAttribute("level").equals("admin")){ %>
	 	<br>
	 	<a href="../operation/admin_user/look_admin.jsp" target="right">查看管理员信息</a>
	 	<br>
	 	<br>
	 	<a href="../operation/admin_user/update_admin.jsp" target="right">修改管理员信息</a>
	 	<br>
	 	<br>
	 	<a href="../operation/normal_user/look_normal.jsp" target="right">查看用户信息</a>
	 	<br>
	 	<br>
	 	<a href="../operation/normal_user/update_normal.jsp" target="right">修改用户信息</a>
	 	<br>
	 	<br>
	 	<a href="../operation/roomInfo/insert_room.jsp" target="right">添加教室信息</a>
	 	<br>
	 	<br>
	 	<a href="../operation/roomInfo/delete_room.jsp" target="right">删除教室信息</a>
	 	<br>
	 	<br>
	 	<a href="../operation/roomInfo/update_room.jsp" target="right">修改教室信息</a>
	 	<br>
	 	<br>
	 	<a href="../operation/roomInfo/look_room.jsp" target="right">查看教室信息</a>
	 	<br>
	 	<br>
	 	<a href="../operation/roomRentInfo/look_deleteRentInfo.jsp" target="right">查看申请情况</a>
	 	<br>
	 	<br>
	 	<a href="../operation/roomRentInfo/add_updateRentInfo.jsp" target="right">审核申请情况</a>
	 <%}%>
</body>
</html>