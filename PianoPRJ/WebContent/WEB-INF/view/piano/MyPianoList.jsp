<%@page import="poly.dto.PianoDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>

<%
	List<PianoDTO> pList = (List<PianoDTO>)request.getAttribute("pList"); 
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>페이지 타이틀</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="/WEB-INF/view/menu.jsp" %>
	<div class="app-content content container-fluid">
	<div class="content-wrapper">
	<div class="content-header row">
          <div class="content-header-left col-xs-7">
            <h2 class="content-header-title">내 피아노 정보</h2>
          </div>
          <div class="content-header-right col-xs-5">
            <button onclick="location.href='/piano/AddPiano.do';" class="btn btn-success float-xs-right">피아노 추가하기</button>
          </div>
        </div>
	<div class="content-body">
	<div class="row match-height">
		<%for(PianoDTO pDTO : pList){ %>
		<div class="col-xl-3">
		<div class="card">
				<div class="card-body">
					<div class="card-block">
						<h4 class="card-title"><%=CmmUtil.nvl(pDTO.getPiano_name()) %></h4>
						<h6 class="card-subtitle text-muted"><%=CmmUtil.nvl(pDTO.getPiano_desc(), "설명 없음")  %></h6>
						<img class="img-fluid my-1" src="/resources/app-assets/images/carousel/09.jpg" alt="Card image cap">
						<div class="card-text"><%=pDTO.getBrand() %></div>
						<div class="card-text"><%=pDTO.getPiano_type().equals("0") ? "업라이트" : "그랜드"%></div>
						<div class="card-text">마지막 조율 날짜: <%=pDTO.getLast_tuned_date()!=null? pDTO.getLast_tuned_date().substring(0, 10) : "모름" %></div>
					</div>
				</div>
			</div>
			</div>
			<%} %>
		</div>
	</div>
	</div>
	</div>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
</body>
</html>