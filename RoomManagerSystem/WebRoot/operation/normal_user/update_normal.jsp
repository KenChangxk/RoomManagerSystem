<%@page import="java.sql.ResultSet"%>
<%@page import="bean.normal_userBean"%>
<%@page import="dao.normal_userDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息</title>
</head>
<body>
	<center>
		<%
			request.setCharacterEncoding("utf-8");
			String level = String.valueOf(session.getAttribute("level"));
			if (level.equals("normal")) {
				String name = String.valueOf(session.getAttribute("userName"));
				normal_userDB nud = new normal_userDB();
				normal_userBean nb = nud.queryById(name);
				session.setAttribute("normal_userBean", nb);
		%>
		<form action="../../updateNormal_user" method="post">
			<table border="1" width="50%" bgcolor="cccfff" align="center">
				<tr>
					<th>用户名(不可修改)</th>
					<th>口令</th>
					<th>性别</th>
					<th>邮箱</th>
					<th>电话</th>
				</tr>
				<tr>
					<td><input type="text" name="memberName" readonly="readonly"
						value="<%=nb.getNormal_memberName()%>"></td>
					<td><input type="text" name="password"
						value="<%=nb.getNormal_memberPassword()%>"></td>
					<td><%
						if (nb.getNormal_memberSex().equals("男")) {
					%> 男<input type="radio" name="gender" value="男" checked="checked">
						女<input type="radio" name="gender" value="女"> <%
 	} else {
 %> 男<input type="radio" name="gender" value="男"> 女<input
						type="radio" name="gender" value="女" checked="checked"> <%
 	}
 %>
					</td>
					<td><input type="text" name="email"
						value="<%=nb.getNormal_email()%>"></td>
					<td><input type="text" name="memberTel"
						value="<%=nb.getNormal_memberTel()%>"</td>
				</tr>
				<tr>
					<td colspan="5" align="center"><input type="submit" value="提交">
					</td>
				</tr>
			</table>
		</form>
		<%
			} else if (level.equals("admin")) {
		%>
			<table border="1" width="50%" align="center">
			<tr>
				<th>用户名（不可修改）</th>
				<th>口令</th>
				<th>性别</th>
				<th>邮箱</th>
				<th>电话号</th>
				<th colspan="2">操作</th>
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
			<form action="../../updateNormal_user" method="post">
			<tr>
					<td><input type="text" name="memberName" readonly="readonly"
						value="<%=rs.getString("normal_memberName")%>"></td>
					<td><input type="text" name="password"
						value="<%=rs.getString("normal_memberPassword")%>"></td>
					<td>
						<%
							if (rs.getString("normal_memberSex").equals("男")) {
						%> 男<input type="radio" name="gender" value="男" checked="checked">
						女<input type="radio" name="gender" value="女"> <%
 	} else {
 %> 男<input type="radio" name="gender" value="男"> 女<input
						type="radio" name="gender" value="女" checked="checked"> <%
 	}
 %>
					</td>
					<td><input type="text" name="email"
						value="<%=rs.getString("normal_email")%>"></td>
					<td><input type="text" name="memberTel"
						value="<%=rs.getString("normal_memberTel")%>"></td>
						<td align="center"><input type="submit" value="修改"></td>
						<td align="center"><input type="reset" value="重置"></td>
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
			<a href="update_normal.jsp?page=<%=intPage + 1%>">下一页</a>
			<%
				}
					if (intPage > 1) {
			%>
			<a href="update_normal.jsp?page=<%=intPage - 1%>">上一页</a>
			<%
				}
			%>
		</div>
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