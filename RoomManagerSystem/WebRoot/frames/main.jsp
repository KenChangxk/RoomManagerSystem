<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>主页面</title>
</head>
<frameset rows="70,*">
	<%
		if (session.getAttribute("userName")==null||session.getAttribute("userName").equals("")) {
			response.sendRedirect("../login/login.jsp");
		}
	%>
	<frameset cols="80%,*">
		<frame src="../frames/topleft.html" name="topleft" scrolling="no">
		<frame src="../frames/topright.jsp" name="topright" scrolling="no">
	</frameset>
	<frameset cols="13%,*">
		<frame src="../frames/left.jsp" name="left" scrolling="auto">
		<frame src="../frames/right.html" name="right" scrolling="yes">
	</frameset>
</frameset>

</html>