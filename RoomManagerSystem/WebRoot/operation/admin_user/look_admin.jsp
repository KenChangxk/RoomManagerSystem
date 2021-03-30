<%@page import="dao.admin_userDB"%>
<%@page import="bean.admin_userBean"%>
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
<title>查看管理员信息</title>
</head>

<body bgcolor="CCCFFF">
	<center>
		<%
			request.setCharacterEncoding("utf-8");
			//session.setAttribute("userName", "555");
			//session.setAttribute("level", "admin");
			System.out.println(session.getAttribute("level"));
			if (session.getAttribute("level") != null && session.getAttribute("level").equals("admin")) {
				admin_userBean aub = new admin_userBean();
				admin_userDB aud = new admin_userDB();
				String name = String.valueOf(session.getAttribute("userName"));
				aub = aud.queryById(name);
				if (aub.getAdmin_level() == 0) {
		%>
		<br> <br>
		<table border="1" width="50%" bgcolor="cccfff" align="center">
			<tr>
				<th>用户名</th>
				<th>口令</th>
				<th>性别</th>
				<th>邮箱</th>
				<th>电话</th>
			</tr>
			<tr>
				<td><%=aub.getAdmin_memberName()%></td>
				<td><%=aub.getAdmin_memberPassword()%></td>
				<td><%=aub.getAdmin_memberSex()%></td>
				<td><%=aub.getAdmin_email()%></td>
				<td><%=aub.getAdmin_memberTel()%></td>
			</tr>
		</table>
		<%
			} else {
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
				int intPageSize; //一页显示的记录数
						int intRowCount; //记录总数
						int intPageCount; //总页数
						int intPage; //待显示页码
						String strPage;
						int i;
						intPageSize = 6;
						strPage = request.getParameter("page"); //取得待显示页码
						if (strPage == null) {
							intPage = 1;
						} else {
							intPage = Integer.valueOf(strPage);
							if (intPage < 1)
								intPage = 1;
						}
						ResultSet rs = aud.queryAll();
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
				<td><%=rs.getString("admin_memberName")%></td>
				<td><%=rs.getString("admin_memberPassword")%></td>
				<td><%=rs.getString("admin_memberSex")%></td>
				<td><%=rs.getString("admin_email")%></td>
				<td><%=rs.getString("admin_memberTel")%></td>
				<%
					String jumpurl = "../../deleteAdmin_user?" + "admin_memberName="
											+ rs.getString("admin_memberName") + "&admin_memberPassword="
											+ rs.getString("admin_memberPassword") + "&admin_memberSex="
											+ rs.getString("admin_memberSex") + "&admin_email=" + rs.getString("admin_email")
											+ "&admin_memberTel=" + rs.getString("admin_memberTel");
									System.out.println("url = " + jumpurl);
					if(rs.getInt("admin_level")==0){
				%>
				<td><a href="<%=jumpurl%>">删除</a></td>
				<%} %>
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
			<a href="look_admin.jsp?page=<%=intPage + 1%>">下一页</a>
			<%
				}
						if (intPage > 1) {
			%>
			<a href="look_admin.jsp?page=<%=intPage - 1%>">上一页</a>
			<%
				}
			%>
		</div>
		<%
			}
		%>
		<%
			} else if(session.getAttribute("level") != null && session.getAttribute("level").equals("normal")) {
		%>
		<script>alert("普通用户，权限不足!");
			top.location.href = "../../frames/main.jsp";
		</script>
		<%
			}else{
		%>
		<script>alert("权限不足，请登录!");
			location.href = "../../login/login.jsp";
		</script>
		<%} %>
	</center>
</body>
</html>