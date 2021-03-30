<%@page import="dao.roomRentInfoDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dao.roomInfoDB"%>
<%@page import="dao.normal_userDB"%>
<%@page import="bean.normal_userBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加和修改申请信息</title>
</head>
<body bgcolor="cccfff">
	<center>
		<%
			request.setCharacterEncoding("utf-8");
			String userName = String.valueOf(session.getAttribute("userName"));
			if (session.getAttribute("level") != null) {
				String login_level = String.valueOf(session.getAttribute("level"));
				roomInfoDB rd = new roomInfoDB();
				if (login_level.equals("normal")) {
					normal_userDB nud = new normal_userDB();
					normal_userBean nub = (normal_userBean) nud.queryById(userName);
		%>
		<br> <br>
		<center>
			<table border="1" width="50%" bgcolor="cccfff" align="center">
				<tr>
					<th>教室号</th>
					<th>座位数</th>
					<th>教室类别</th>
					<th>所属部门</th>
					<th>工作需求</th>
					<th colspan="6">使用日期</th>
					<th>使用课时</th>
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
							//System.out.println(strPage);
							if (strPage == null) {
								intPage = 1;
							} else {
								intPage = Integer.valueOf(strPage);
								if (intPage < 1)
									intPage = 1;
							}
							ResultSet rs = rd.queryAll();
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
				<form action="../../insertRoomRentInfo" method="post">
					<tr>
						<td><input type="text" value="<%=rs.getString("roomNum")%>"
							readonly="readonly" name="roomNum"></td>
						<td><input type="text" value="<%=rs.getString("roomSeats")%>"
							disabled="disabled" name="roomSeats"></td>
						<td><input type="text" value="<%=rs.getString("roomClass")%>"
							disabled="disabled" name="roomClass"></td>
						<td><input type="text" value="<%=rs.getString("roomDept")%>"
							disabled="disabled" name="roomDept"></td>
						<td><input type="text"
							value="<%=rs.getString("roomRequire")%>" disabled="disabled"
							name="roomRequire"></td>
						<td><select name="select1">
								<option value="2020">2020</option>
								<option value="2021">2021</option>
						</select>
						<td>年</td>
						</td>

						<td><select name="select2">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
						</select>
						<td>月</td>
						</td>
						<td><select name="select3">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">13</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
								<option value="24">24</option>
								<option value="25">25</option>
								<option value="26">26</option>
								<option value="27">27</option>
								<option value="28">28</option>
								<option value="29">29</option>
								<option value="30">30</option>
								<option value="31">31</option>
						</select>
						<td>日</td>
						</td>
						<td><select name="select4">
								<option value="12">12 </option>
								<option value="34">34 </option>
								<option value="56">56 </option>
								<option value="78">78 </option>
								<option value="910">910 </option>
						</select></td>
						<td><input type="submit" value="申请"></td>
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
				<a href="add_RentInfo.jsp?page=<%=intPage + 1%>">下一页</a>
				<%
					}
							if (intPage > 1) {
				%>
				<a href="add_RentInfo.jsp?page=<%=intPage - 1%>">上一页</a>
				<%
					}
				%>
			</div>

			<%
				} else if (login_level.equals("admin")) {
			%>
			<script type="text/javascript">
				function button1_click() {
					document.form1.action = "../../insertRoomRentInfo" + "?ispass=true";
					document.form1.submit();
				}
			
				function button2_click() {
					document.form1.action = "../../insertRoomRentInfo" + "?ispass=false";
					document.form1.submit();
				}
			</script>
			<br> <br>
			<h3 align="center">审核教室租赁申请</h3>
			<hr>
			<table border="1" width="50%" bgcolor="cccfff" align="center">
				<tr>
					<th>教室号</th>
					<th>申请人</th>
					<th>申请人邮箱</th>
					<th>申请人电话</th>
					<th>申请时间段</th>
					<th>申请提交时间</th>
					<th colspan="2">审核</th>
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
								if(rs.getInt("rent_verify")!=1){
									rs.next();
									i++;
									continue;
								}
				%>
				<form name="form1" action="../../insertRoomRentInfo" method="post">
					<tr>
						<td><input type="text"
							value="<%=rs.getString("rent_roomNum")%>" readonly="readonly"
							name="roomNum"></td>
						<td><input type="text"
							value="<%=rs.getString("rent_memberName")%>" readonly="readonly"
							name="memberName"></td>
						<td><input type="text"
							value="<%=rs.getString("rent_email")%>" readonly="readonly"
							name="email"></td>
						<td><input type="text"
							value="<%=rs.getString("rent_memberTel")%>" readonly="readonly"
							name="memberTel"></td>
						<td><input type="text"
							value="<%=rs.getString("rent_period")%>" readonly="readonly"
							name="period"></td>
						<td><input type="text" value="<%=rs.getString("rent_time")%>"
							readonly="readonly" name="time"></td>
						<td><input type="submit" value="accept" name="submit"></td>
						<td><input type="submit" value="unaccept" name="submit"></td>
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
				<a href="add_RentInfo.jsp?page=<%=intPage + 1%>">下一页</a>
				<%
					}
							if (intPage > 1) {
				%>
				<a href="add_RentInfo.jsp?page=<%=intPage - 1%>">上一页</a>
				<%
					}
				%>
			</div>
			<%
				}

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