<%@page import="dao.roomRentInfoDB"%>
<%@page import="dao.roomInfoDB"%>
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
<title>查看教室租用信息</title>
</head>

<body bgcolor="CCCFFF">
	<center>
		<%
			request.setCharacterEncoding("utf-8");
			String userName = (String)session.getAttribute("userName");
			if (session.getAttribute("level") != null && session.getAttribute("level").equals("admin")) {
		%>
		<br> <br>
		<h3 align="center">已通过信息</h3>
		<hr>
		<table border="1" width="50%" bgcolor="cccfff" align="center">
			<tr>
				<th>教室号</th>
				<th>申请人</th>
				<th>申请人邮箱</th>
				<th>申请人电话</th>
				<th>申请时间段</th>
				<th>申请提交时间</th>
				<th>操作</th>
			</tr>
			<%
				roomRentInfoDB rdb = new roomRentInfoDB();
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
					ResultSet rs = rdb.queryAll();
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
							if(rs.getInt("rent_verify") != 0){
								rs.next();
								i++;
								continue;
							}
			%>

			<form action="../../insertRoomRentInfo" method="post">
				<tr>
					<td><input type="text"
						value="<%=rs.getString("rent_roomNum")%>" readonly="readonly"
						name="roomNum"></td>
					<td><input type="text"
						value="<%=rs.getString("rent_memberName")%>" readonly="readonly"
						name="memberName"></td>
					<td><input type="text" value="<%=rs.getString("rent_email")%>"
						readonly="readonly" name="email"></td>
					<td><input type="text"
						value="<%=rs.getString("rent_memberTel")%>" readonly="readonly"
						name="memberTel"></td>
					<td><input type="text"
						value="<%=rs.getString("rent_period")%>" readonly="readonly"
						name="period"></td>
					<td><input type="text" value="<%=rs.getString("rent_time")%>"
						readonly="readonly" name="time"></td>
					<td><input type="submit" name="submit"
						value="unaccept"></td>
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
			<a href="look_RentInfo.jsp?page=<%=intPage + 1%>">下一页</a>
			<%
				}
					if (intPage > 1) {
			%>
			<a href="look_RentInfo.jsp?page=<%=intPage - 1%>">上一页</a>
			<%
				}
			%>
		</div>
		<hr>
		<br> <br>
		<h3 align="center">所有教室租用申请</h3>
		<hr>
		<table border="1" width="50%" bgcolor="cccfff" align="center">
			<tr>
				<th>教室号</th>
				<th>申请人</th>
				<th>申请人邮箱</th>
				<th>申请人电话</th>
				<th>申请时间段</th>
				<th>申请提交时间</th>
				<th>审核状态</th>
			</tr>
			<%
					int intPageSize2; //一页显示的记录数
					int intRowCount2; //记录总数
					int intPageCount2; //总页数
					int intPage2; //待显示页码
					String strPage2;
					intPageSize = 10;
					strPage2 = request.getParameter("page2"); //取得待显示页码
					//System.out.println(strPage);
					if (strPage2 == null) {
						intPage2 = 1;
					} else {
						intPage2 = Integer.valueOf(strPage2);
						if (intPage2 < 1)
							intPage2 = 1;
					}
					rs.last(); //光标指向查询结果集中最后一条记录
					intRowCount2 = rs.getRow(); //获取记录总数
					intPageCount2 = (intRowCount2 + intPageSize - 1) / intPageSize;
					if (intPage2 > intPageCount2)
						intPage2 = intPageCount2;
					if (intPageCount2 > 0) {
						rs.absolute((intPage2 - 1) * intPageSize + 1);
						//将记录指针定位到待显示页的第一条记录上
						//显示数据
						i = 0;
						while (i < intPageSize && !rs.isAfterLast()) {
			%>
				<tr>
					<td><%=rs.getString("rent_roomNum")%></td>
					<td><%=rs.getString("rent_memberName")%></td>
					<td><%=rs.getString("rent_email")%></td>
					<td><%=rs.getString("rent_memberTel")%></td>
					<td><%=rs.getString("rent_period")%></td>
					<td><%=rs.getString("rent_time")%></td>
					<%if(rs.getInt("rent_verify")==0) {%>
					<td>审核通过</td>
					<%}else if(rs.getInt("rent_verify")==1){ %>
					<td>未审核</td>
					<%}else if(rs.getInt("rent_verify")==-1){ %>
					<td>审核未通过</td>
					<%} %>
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
			第<%=intPage2%>页 共<%=intPageCount2%>页
			<%
			if (intPage2 < intPageCount2) {
		%>
			<a href="look_RentInfo.jsp?page=<%=intPage2 + 1%>">下一页</a>
			<%
				}
					if (intPage2 > 1) {
			%>
			<a href="look_RentInfo.jsp?page=<%=intPage2 - 1%>">上一页</a>
			<%
				}
			%>
		</div>
		<%
			} else if (session.getAttribute("level") != null && session.getAttribute("level").equals("normal")) {
		%>
		<br> <br>
		<h3 align="center">已申请教室</h3>
		<hr>
		<table border="1" width="50%" bgcolor="cccfff" align="center">
			<tr>
				<th>教室号</th>
				<th>申请人</th>
				<th>申请人邮箱</th>
				<th>申请人电话</th>
				<th>申请时间段</th>
				<th>申请提交时间</th>
				<th>审核状态</th>
				<th>审核人</th>
				<th>操作</th>
			</tr>
			<%
				roomRentInfoDB rdb = new roomRentInfoDB();
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
					ResultSet rs = rdb.queryAll();
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
							if(!rs.getString("rent_memberName").equals(userName)){
								rs.next();
								i++;
								continue;
							}
			%>

			<form action="../../deleteRoomRentInfo" method="post">
				<tr>
					<td><input type="text"
						value="<%=rs.getString("rent_roomNum")%>" readonly="readonly"
						name="roomNum"></td>
					<td><input type="text"
						value="<%=rs.getString("rent_memberName")%>" readonly="readonly"
						name="memberName"></td>
					<td><input type="text" value="<%=rs.getString("rent_email")%>"
						readonly="readonly" name="email"></td>
					<td><input type="text"
						value="<%=rs.getString("rent_memberTel")%>" readonly="readonly"
						name="memberTel"></td>
					<td><input type="text"
						value="<%=rs.getString("rent_period")%>" readonly="readonly"
						name="period"></td>
					<td><input type="text" value="<%=rs.getString("rent_time")%>"
						readonly="readonly" name="time"></td>
					<%if(rs.getInt("rent_verify")==0) {%>
					<td><input type="text" value="审核通过"
						readonly="readonly"></td>
					<%}else if(rs.getInt("rent_verify")==1){ %>
					<td><input type="text" value="未审核" readonly="readonly"></td>
					<%}else if(rs.getInt("rent_verify")==-1){ %>
					<td><input type="text" value="审核未通过" readonly="readonly"></td>
					<%} %>
					<td><input type="text"
						value="<%=rs.getString("rent_adminName")%>" readonly="readonly"
						name="period"></td>
					<%if(rs.getInt("rent_verify")!=-1){%>
					<td><input type="submit" value="取消申请"></td>
					<%}else{ %>
						<td><input type="submit" value="删除记录"></td>
					<%} %>
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
			<a href="look_RentInfo.jsp?page=<%=intPage + 1%>">下一页</a>
			<%
				}
					if (intPage > 1) {
			%>
			<a href="look_RentInfo.jsp?page=<%=intPage - 1%>">上一页</a>
			<%
				}
			%>
		</div>
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