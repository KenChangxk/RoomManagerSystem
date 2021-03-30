<%@page import="java.sql.ResultSet"%>
<%@page import="bean.admin_userBean"%>
<%@page import="dao.admin_userDB"%>
<%@page import="bean.normal_userBean"%>
<%@page import="dao.normal_userDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改管理员信息</title>
</head>
<body>
	<center>
		<%
			request.setCharacterEncoding("utf-8");
			//	session.setAttribute("userName", "123");
			//	session.setAttribute("level", "normal");
			String level = String.valueOf(session.getAttribute("level"));
			if (level.equals("admin")) {
				admin_userDB aud = new admin_userDB();
				String name = String.valueOf(session.getAttribute("userName"));
				admin_userBean ab = aud.queryById(name);
				if (ab.getAdmin_level() == 0) {
					String url = "../../updateAdmin_user?oldName=" + name;
		%>
		<form action="<%=url%>" method="post">
			<%
				request.setAttribute("oldName", name);
			%>
			<table border="1" width="50%" bgcolor="cccfff" align="center">
				<tr>
					<th>用户名（不可修改）</th>
					<th>口令</th>
					<th>性别</th>
					<th>邮箱</th>
					<th>电话</th>
				</tr>
				<tr>
					<td><input type="text" name="memberName"
						value="<%=ab.getAdmin_memberName()%>" readonly="readonly"></td>
					<td><input type="text" name="password"
						value="<%=ab.getAdmin_memberPassword()%>"></td>
					<td>
						<%
							if (ab.getAdmin_memberSex().equals("男")) {
						%> 男<input type="radio" name="gender" value="男" checked="checked">
						女<input type="radio" name="gender" value="女"> <%
 	} else {
 %> 男<input type="radio" name="gender" value="男"> 女<input
						type="radio" name="gender" value="女" checked="checked"> <%
 	}
 %>
					</td>
					<td><input type="text" name="email"
						value="<%=ab.getAdmin_email()%>"></td>
					<td><input type="text" name="memberTel"
						value="<%=ab.getAdmin_memberTel()%>"</td>
				</tr>
				<tr>
					<td colspan="5" align="center"><input type="submit" value="提交">
					</td>
				</tr>
			</table>
		</form>
		<%
			} else {
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
								String name2 = rs.getString("admin_memberName");
								String url = "../../updateAdmin_user?oldName=" + name2;
			%>
			<form action="<%=url%>" method="post">
			<tr>
				<td><input type="text" name="memberName"
					value="<%=rs.getString("admin_memberName")%>"></td>
				<td><input type="text" name="password"
					value="<%=rs.getString("admin_memberPassword")%>"></td>
				<td>
					<%
						if (rs.getString("admin_memberSex").equals("男")) {
					%> 男<input type="radio" name="gender" value="男" checked="checked">
					女<input type="radio" name="gender" value="女"> <%
 	} else {
 %> 男<input type="radio" name="gender" value="男"> 女<input
					type="radio" name="gender" value="女" checked="checked"> <%
 	}
 %>
				</td>
				<td><input type="text" name="email"
					value="<%=rs.getString("admin_email")%>"></td>
				<td><input type="text" name="memberTel"
					value="<%=rs.getString("admin_memberTel")%>"></td>
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
			<a href="update_admin.jsp?page=<%=intPage + 1%>">下一页</a>
			<%
				}
						if (intPage > 1) {
			%>
			<a href="update_admin.jsp?page=<%=intPage - 1%>">上一页</a>
			<%
				}
			%>
		</div>
		<%
			}
			} else if (level.equals("normal")) {
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