<%@page import="bean.admin_userBean"%>
<%@page import="dao.admin_userDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户面板</title>
</head>
<body bgcolor="CCCFFF">
	<%
		String userName = String.valueOf(session.getAttribute("userName"));
		String login_level = String.valueOf(session.getAttribute("level"));
		if(login_level.equals("admin")){
			admin_userDB ad = new admin_userDB();
			admin_userBean ab = ad.queryById(userName);
			if(ab.getAdmin_level()==1) login_level = "super";
		}
	%>
	<h3 align="center">
		用户名：<%=userName%><br> 用户等级：<%=login_level%> 
		<a href="../login/exit.jsp" target="_parent"> 退出</a>
	</h3>
</body>
</html>