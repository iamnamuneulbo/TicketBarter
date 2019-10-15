<%@page import="com.mysql.cj.ParseInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
<body>

<script>
	function selectTab(flag) {
		$("#bs-example-navbar-collapse-1 ul li:eq(" + flag + ")").addClass('active');
	}
</script>
	<%
		//로긴한사람이라면	userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<%
		String tab = request.getParameter("tab");
	%>
	<!-- 네비게이션  -->
	<nav class="navbar navbar-expand-md bg-light navbar-light">
		<a class="navbar-brand" href="main.jsp">티켓바터</a>
		<button type="button"
			class="navbar-toggler navbar-toggler-right collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-controls="navbarSupportedContent" aria-expaned="true"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="main.jsp">메인</a></li>
				<li class="nav-item"><a class="nav-link" href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				//라긴안된경우
				if (userID == null) {
			%>

			<ul class="nav navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href="join.jsp"><span
						class="fas fa-user"></span> Sign Up</a></li>
				<li class="nav-item"><a class="nav-link" href="login.jsp"><span
						class="fas fa-sign-in-alt"></span> Login</a></li>
			</ul>

			<%
				} else {
			%>
			<ul class="nav navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link"
					href="logoutAction.jsp"><span class="fas fa-sign-out-alt"></span>
						Logout</a></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<script type="text/javascript">selectTab(<%=tab%>);</script>