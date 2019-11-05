<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="show.ShowDateTimeDAO"%>
<%@ page import="show.ShowDateTime"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Locale"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>티켓바터</title>
<script type="text/javascript" src="js/maketitle.js"></script>
</head>
<body>
	<jsp:include page="header.jsp">
		<jsp:param name="tab" value="1" />
	</jsp:include>
	<%
		//로긴한사람이라면	userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");

		}
	%>
	<%
		//로그인 안한 경우
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");

		}

		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
	%>

	<div class="container col-lg-7">
		<div class="col" style="padding-top: 20px;">
			<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%> ">
				<table class="table table-bordered " style="text-align: center;">
					<thead>
						<tr>
							<th class="align-middle" colspan="3"
								style="background-color: #eeeeee; text-align: center;">글수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="align-middle" rowspan="2">나</td>
							<td class="align-middle">공연일</td>
							<td class="">
								<div class="dropdown">
									<button class="btn btn-dark dropdown-toggle" type="button"
										id="dropdown_my_date" name="dropdown_my_date"
										data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false">날짜 선택</button>
									<div class="dropdown-menu" aria-labelledby="dropdownMenu2">
										<%
											ShowDateTimeDAO showDateTimeDAO = new ShowDateTimeDAO();
											ArrayList<ShowDateTime> list = showDateTimeDAO.getDateTime(1);

											for (int i = 0; i < list.size(); i++) {
												String showDateTime = new java.text.SimpleDateFormat("MM/dd hh:mm aa", new Locale("en", "US"))
														.format(list.get(i).getShowDateTime());
										%>
										<button class="dropdown-item" type="button"
											onclick="make_title(1, this);"><%=showDateTime%></button>
										<%
											}
										%>

									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="align-middle">좌석 정보</td>
							<td></td>
						</tr>
						<tr>
							<td class="w-25 align-middle" rowspan="2">상대</td>
							<td class="align-middle">공연일</td>
							<td>
								<div class="container">
									<div class="col">
										<button tabindex="-1" data-toggle="dropdown"
											class="btn btn-info btn-default dropdown-toggle w-100"
											type="button">날짜 선택</button>
										<ul role="menu" class="dropdown-menu">
											<li>
												<div class="dropdown-item custom-control custom-checkbox">
													&nbsp <input type="checkbox" id="other-ticket-date-cb1"
														name="other-ticket-date-cb" class="custom-control-input">
													<label class="custom-control-label"
														for="other-ticket-date-cb1">8/9(금) 8 PM</label>
												</div>
											</li>
											<li>
												<div class="dropdown-item custom-control custom-checkbox">
													&nbsp <input type="checkbox" id="other-ticket-date-cb2"
														name="other-ticket-date-cb" class="custom-control-input">
													<label class="custom-control-label"
														for="other-ticket-date-cb2">8/10(토) 6 PM</label>
												</div>
											</li>
											<li>
												<div class="dropdown-item custom-control custom-checkbox">
													&nbsp <input type="checkbox" id="other-ticket-date-cb3"
														name="other-ticket-date-cb" class="custom-control-input">
													<label class="custom-control-label"
														for="other-ticket-date-cb3">8/11(일) 5 PM</label>
												</div>
											</li>
										</ul>
									</div>
									<div class="col">
										<input type="text" aria-label="ticket-date"
											class="form-control" name="other-ticket-date" readonly>
									</div>
								</div>



							</td>
						</tr>
						<tr>
							<td class="align-middle">좌석 정보</td>
							<td>
								<div class="input-group mb-2">
									<input type="text" class="form-control"
										name="other-ticket-block" style="text-transform: uppercase"
										placeholder="예: A">
									<div class="input-group-append">
										<span class="input-group-text">구역</span>
									</div>
								</div>
								<div class="input-group">
									<input type="text" class="form-control" name="other-ticket-row"
										style="text-transform: uppercase" placeholder="예: 2">
									<div class="input-group-append">
										<span class="input-group-text">열(번호대)</span>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="align-middle">글 제목</td>
							<td colspan="2">
								<div class="btn btn-dark" name="title_my_ticket_date">내 티켓</div>을
								<div class="btn btn-info" name="title_other_ticket_date">상대
									티켓</div>으로 <input type="text" class="form-control align-middle"
								placeholder="글 제목" name="bbsTitle" maxlength="50"
								value="<%=bbs.getBbsTitle()%>" />
							</td>
						</tr>
						<tr>
							<td colspan="3"><textarea class="form-control align-middle"
									placeholder="글 내용" name="bbsContent" maxlength="2048"
									style="height: 200px;"><%=bbs.getBbsContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<button type="submit" class="btn btn-primary pull-right">글수정</button>
			</form>
		</div>
	</div>

	<link rel="stylesheet"
		href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
		integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
		crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>
	
<script type="text/javascript" src="js/maketitlebtn.js"></script>
</body>
</html>