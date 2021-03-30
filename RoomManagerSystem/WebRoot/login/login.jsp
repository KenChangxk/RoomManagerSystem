<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.normal_userBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<link href="css/style.css" rel='stylesheet' type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>登录</title>
</head>
<script>
	function check() {
		if (document.forms[0].elements[0].value.length == 0) {
			alert('用户名不能为空！');
			return false;
		} else if (document.forms[0].elements[1].value.length == 0) {
			alert('用户密码不能为空！');
			return false;
		} else if (document.forms[0].elements[2].checked == false &&
			document.forms[0].elements[3].checked == false
		) {
			alert('请选择登录级别！');
			return false;
		} else {
			return true;
		}
	}
</script>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>
	<!-----start-main---->
	<div class="main">
		<div class="login-form">
			<h1>用户登录</h1>
			<div class="head">
				<img src="images/user.png" alt="" />
			</div>
			<form action="../loginCheckServlet" name="form1"
				onSubmit="return check();" method="POST">
				<input type="text" class="text" name="userName" placeholder="请输入用户名"
					size="16"><input type="password" name="password"
					placeholder="请输入密码" size="18">
				<div align="left"
					style="margin: 0px 40px 10px 40px;border-bottom: 1px solid rgb(215,215,215); ">
					普通用户<input type="radio" name="loginPre" value="normal"
						checked="checked" />&nbsp; 管理员<input type="radio" name="loginPre"
						value="admin" />
				</div>
				<div class="submit">
					<input type="submit" value="登录">
				</div>
				<div class="submit">
					<input type="reset" value="重置">
				</div>
				<div class="submit">
					<input type="button" value="注册"
						onclick="javascript:location.href='register.html';" />
				</div>
			</form>
		</div>
		<!--//End-login-form-->
		<!-----start-copyright---->
		<div class="copy-right">
			<p></p>
		</div>
		<!-----//end-copyright---->
	</div>
	<!-----//end-main---->

</body>
</html>