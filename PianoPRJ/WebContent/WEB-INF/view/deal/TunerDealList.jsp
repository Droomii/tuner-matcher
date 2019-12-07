<%@page import="poly.dto.DealDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.ReqDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="poly.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../user/session.jsp"%>
<%
	List<DealDTO> dList = (ArrayList<DealDTO>) request.getAttribute("dList");
	String[] states = { "입찰 진행중", "입찰 취소", "거래중", "낙찰실패", "거래취소(고객)", "거래취소(조율사)", "완료 대기중", "거래완료", "거절(조율사)",
			"견적 거절" };
	Pagination pg = (Pagination) request.getAttribute("pg");
	String pageName = "TunerDealList";
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>과거 내역 - 도와조율</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp"%>
<style>
.title {
	max-width: 40%;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.table {
	display: table;
}

.table-row {
	display: table-row;
}

.table-head-cell {
	display: table-cell;
	padding: 10px 20px 10px 20px;
	border-bottom: 2px solid rgb(200, 200, 200);
	border-top: 1px solid rgb(200, 200, 200);
}

.table-cell {
	display: table-cell;
	padding: 10px 20px 10px 20px;
	border-bottom: 1px solid lightgray;
}

.item:hover {
	background-color: rgb(240, 240, 240);
}
</style>
</head>
<body data-open="click" data-menu="vertical-menu" data-col="2-columns"
	class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp"%>
	<div class="app-content content container-fluid">
		<div class="content-wrapper">
			<div class="content-body">
				<!-- Basic Tables start -->
				<div class="row">
					<div class="col-xs-12">
						<div class="card">
							<div class="card-header">
								<h4 class="card-title">조율 현황</h4>
								<a class="heading-elements-toggle"><i
									class="icon-ellipsis font-medium-3"></i></a>
							</div>
							<div class="card-body collapse in">
								<div class="card-block card-dashboard">
									<div class="table">
										<div class="table-row">
											<div class="table-head-cell">
												<strong>거래번호</strong>
											</div>
											<div class="table-head-cell">
												<strong>고객명</strong>
											</div>
											<div class="table-head-cell">
												<strong>견적가</strong>
											</div>
											<div class="table-head-cell">
												<strong>약속일시</strong>
											</div>
											<div class="table-head-cell">
												<strong>진행상태</strong>
											</div>
										</div>

										<%
											for (DealDTO dDTO : dList) {
										%>
										<div class="table-row item" role="button"
											onclick="location.href='/deal/TunerDealDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>'">
											<div class="table-cell"><%=CmmUtil.nvl(dDTO.getDeal_seq())%></div>
											<div class="table-cell"><%=CmmUtil.nvl(dDTO.getRequester_nick(), true)%></div>
											<div class="table-cell"><%=dDTO.getTotal()%>원
											</div>
											<div class="table-cell"><%=dDTO.getFullDate()%></div>
											<div class="table-cell"><%=dDTO.getDeal_state().equals("2") ? "진행중" : dDTO.getDeal_state().equals("10") ? "날짜변경요청" : "완료대기중"%></div>
										</div>
										<%
											}
										%>
									</div>
									<%
										if (dList.size() == 0) {
									%>
									<div class="card-text text-xs-center">- 진행중인 거래가 없습니다 -</div>
									<%
										} else {
									%>
									<%@include file="/WEB-INF/view/Pagination.jsp"%>
									<%
										}
									%>
								</div>
							</div>

						</div>
					</div>
				</div>
				<!-- Basic Tables end -->
			</div>
		</div>
	</div>





	<!-- footer.jsp 경로설정 -->
	<%@include file="../footer.jsp"%>
</body>
</html>