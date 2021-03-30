<%@page import="bean.normal_userBean"%>
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
<title>查看用户信息</title>
</head>

<body bgcolor="CCCFFF">
	<center>
		<%
			request.setCharacterEncoding("utf-8");
			if (session.getAttribute("level") != null && session.getAttribute("level").equals("admin")) {
		%>
		<br> <br>
		<table border="1" width="50%" bgcolor="cccfff" align="center">
			<tr>
				<th>用户名</th>
				<th>口令</th>
				<th>性别</th>
				<th>邮箱</th>
				<th>电话</th>
				<th>操作</th>
			</tr>
			<%
				normal_userDB nud = new normal_userDB();
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
					ResultSet rs = nud.queryAll();
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
				<td><%=rs.getString("normal_memberName")%></td>
				<td><%=rs.getString("normal_memberPassword")%></td>
				<td><%=rs.getString("normal_memberSex")%></td>
				<td><%=rs.getString("normal_email")%></td>
				<td><%=rs.getString("normal_memberTel")%></td>
				<%
					String jumpurl = "../../deleteNormal_user?" + "normal_memberName="
										+ rs.getString("normal_memberName") + "&normal_memberPassword="
										+ rs.getString("normal_memberPassword") + "&normal_memberSex="
										+ rs.getString("normal_memberSex") + "&normal_email=" + rs.getString("normal_email")
										+ "&normal_memberTel=" + rs.getString("normal_memberTel");
								System.out.println("url = " + jumpurl);
				%>
				<td><a href="<%=jumpurl%>">删除</a></td>
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
			<a href="look_normal.jsp?page=<%=intPage + 1%>">下一页</a>
			<%
				}
					if (intPage > 1) {
			%>
			<a href="look_normal.jsp?page=<%=intPage - 1%>">上一页</a>
			<%
				}
			%>
		</div>
		<%
			} else if (session.getAttribute("level") != null && session.getAttribute("level").equals("normal")) {
		%>
		<br><br>
		<table border="1" width="50%" bgcolor="cccfff" align="center">
			<tr>
				<th>用户名</th>
				<th>口令</th>
				<th>性别</th>
				<th>邮箱</th>
				<th>电话</th>
			</tr>
			<%
				String name = String.valueOf(session.getAttribute("userName"));
					normal_userDB nud = new normal_userDB();
					normal_userBean nb = nud.queryById(name);
			%>
			<tr>
				<td><%=nb.getNormal_memberName()%></td>
				<td><%=nb.getNormal_memberPassword()%></td>
				<td><%=nb.getNormal_memberSex()%></td>
				<td><%=nb.getNormal_email()%></td>
				<td><%=nb.getNormal_memberTel()%></td>
			</tr>
		</table>
		<%
			} else {
		%>
		<script>
			alert("权限不足,请登录!");
			top.location.href = "../../login/login.jsp";
		</script>
		<%
			}
		%>
	</center>
</body>
</html>