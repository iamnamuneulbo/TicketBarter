<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
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
	<!-- 게시판 -->
	<div class="container col-lg-7">
		<div class="col" style="padding-top: 20px;">
			<form method="post" action="writeAction.jsp">
				<table class="table table-bordered " style="text-align: center;">
					<thead>
						<tr>
							<th class="align-middle" colspan="3"
								style="background-color: #eeeeee; text-align: center;">글쓰기</th>
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
											onclick="make_title(this, 1);"><%=showDateTime%></button>
										<%
											}
										%>

									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="align-middle">좌석 정보</td>
							<td>
								<div class="input-group mb-2">
									<input type="text" class="form-control"
										name="my-ticket-block" style="text-transform: uppercase"
										onchange="make_title(this, 2);" maxlength="10" placeholder="예: A">
									<div class="input-group-append">
										<span class="input-group-text">구역</span>
									</div>
								</div>
								<div class="input-group">
									<input type="text" class="form-control" name="my-ticket-row"
										style="text-transform: uppercase" onchange="make_title(this, 3);" maxlength="10" placeholder="예: 2">
									<div class="input-group-append">
										<span class="input-group-text">열(번호대)</span>
									</div>
								</div>
							</td>
						</tr>
						<tr class="bg-light">
							<td class="w-25 align-middle" rowspan="2">상대</td>
							<td class="align-middle">공연일</td>
							<td>
								<div class="container">
									<div class="col">
										<button tabindex="-1" data-toggle="dropdown"
											class="btn btn-info btn-default dropdown-toggle w-100"
											type="button">날짜 선택</button>
										<ul role="menu" class="dropdown-menu">
											
										<%
											for (int i = 0; i < list.size(); i++) {
												String showDateTime = new java.text.SimpleDateFormat("MM/dd hh:mm aa", new Locale("en", "US"))
													.format(list.get(i).getShowDateTime());
										%>
											<li>
												<div class="dropdown-item custom-control custom-checkbox">
													&nbsp <input type="checkbox" id="other-ticket-date-cb<%=i+1%>"
														name="other-ticket-date-cb" class="custom-control-input">
													<label class="custom-control-label"
														for="other-ticket-date-cb<%=i+1%>"><%=showDateTime%></label>
												</div>
											</li>
										<%
											}
										%>
										</ul>
									</div>
									<div class="col">
										<input type="text" aria-label="ticket-date"
											class="form-control" name="other-ticket-date" readonly>
									</div>
								</div>
							</td>
						</tr>
						<tr class="bg-light">
							<td class="align-middle">좌석 정보</td>
							<td>
								<div class="input-group mb-2">
									<input type="text" class="form-control"
										name="other-ticket-block" style="text-transform: uppercase"
										onchange="make_title2(1);" maxlength="10" placeholder="예: B">
									<div class="input-group-append">
										<span class="input-group-text">구역</span>
									</div>
								</div>
								<div class="input-group">
									<input type="text" class="form-control" name="other-ticket-row"
										style="text-transform: uppercase" onchange="make_title2(2);" maxlength="10" placeholder="예: 2">
									<div class="input-group-append">
										<span class="input-group-text">열(번호대)</span>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="align-middle">글 제목</td>
							<td colspan="2">
								<div class="mb-2">
									<div class="btn btn-dark" name="title_my_ticket" style="text-transform: uppercase">내 티켓</div>
									<div class="btn btn-outline-dark" name="title_my_seat">좌석</div>을<br/>
								</div>
								<div class="mb-2">
									<div class="btn-group-vertical" name="title_other_tickets">
									  <div class="btn btn-info">상대 티켓</div>
									</div>
									<div class="btn btn-outline-info" name="title_other_seat">좌석</div>으로 교환
								</div>
								<input type="text" class="form-control align-middle"
								placeholder="추가 정보(최대 20자)" name="bbsTitle" maxlength="20" />
							</td>
						</tr>
						<tr>
							<td colspan="3"><textarea class="form-control align-middle"
									placeholder="글 내용" name="bbsContent" maxlength="2048"
									style="height: 200px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary float-right" value="글쓰기" />
			</form>
		</div>
	</div>



	<link rel="stylesheet"
		href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
		integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
		crossorigin="anonymous">
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>

</body>
</html>