<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.DealDTO"%>
<%@page import="poly.dto.MainDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%
	MainDTO mDTO = (MainDTO)request.getAttribute("mDTO");
List<DealDTO> dList = (List<DealDTO>)request.getAttribute("dList");
%>
<!DOCTYPE html>

<html lang="en" data-textdirection="ltr" class="loading">
<head>
<style>
	.title{
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
		padding: 10px;
		border-bottom : 2px solid rgb(200,200,200);
		border-top : 1px solid rgb(200,200,200);
	}
	.table-cell {
	  display: table-cell;
	  padding: 10px;
	  border-bottom: 1px solid lightgray;
	}
	.item:hover{
		background-color:rgb(240,240,240);
	}
</style>
<%@ include file="./user/session.jsp" %>
<meta charset="UTF-8">
<title>페이지 타이틀</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="menu.jsp" %>
	
	
<!-- 조율사 메인 -->
<%if(user_type.equals("1")){
	
	%>
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
        </div>
        <div class="content-body"><!-- stats -->
<div class="row">
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/req/TunerPublicReqList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="pink"><%=mDTO.getNear_request() %>건</h3>
                            <span>내 주변 요청</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-bag2 pink font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/req/TunerPrivateReqList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="teal"><%=mDTO.getPrivate_request() %>건</h3>
                            <span>1:1 요청</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-user1 teal font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/deal/TunerDealList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="deep-orange"><%=mDTO.getOngoing_deals() %>건</h3>
                            <span>진행중인 거래</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-diagram deep-orange font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/myPage/MyRepu.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="cyan"><%=mDTO.getRepu() %>점</h3>
                            <span>내 평판</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-ios-help-outline cyan font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row match-height">
    <div class="col-xl-12 col-lg-12">
        <div class="card" id="list-container">
            <div class="card-header">
                <h4 class="card-title" id="schedule-list-title">다가오는 일정</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                        <div class="table">
                            <div class="table-row">
									<div class="table-head-cell"><strong>거래번호</strong></div>
                                    <div class="table-head-cell"><strong>고객 닉네임</strong></div>
                                    <div class="table-head-cell"><strong>견적가</strong></div>
                                    <div class="table-head-cell"><strong>일시</strong></div>
                            </div>
                            <%
                            int i = 0;
                            DealDTO dDTO = null;
                            for(Iterator<DealDTO> it = dList.iterator(); it.hasNext() && i < 5; i++){
                            	dDTO = it.next();
                            	%>
                            <div class="table-row item" role="button" onclick="location.href='/deal/TunerDealDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>&back=main'">
                                    <div class="table-cell"><%=dDTO.getDeal_seq() %></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(dDTO.getRequester_nick()) %></div>
                                    <div class="table-cell"><%=dDTO.getTotal() %>원</div>
                                    <div class="table-cell"><%=dDTO.getFullDate() %></div>
                            </div>
                            <%} %>
                        </div>
                        <div class="card-text text-xs-center" id="no-schedule"><%if(dList.size()==0) {%>- 조율 일정이 없습니다 - <%} %></div>
                </div>
                <div class="card-block">
                    <p><span class="float-xs-right"><a href="/myPage/TunerSchedule.do">조율 일정 <i class="icon-arrow-right2"></i></a></span></p>
                </div>
            </div>
            
        </div>
    </div>
</div>
<!-- Recent invoice with Statistics -->


        </div>
      </div>
    </div>
<%}else if(user_type.equals("0")){%>
<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
        </div>
        <div class="content-body"><!-- stats -->
<div class="row">
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/req/UserPublicReqList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="pink"><%=mDTO.getNew_bids() %>건</h3>
                            <span>새 입찰</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-bag2 pink font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/req/UserPrivateReqList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="teal"><%=mDTO.getPrivate_estimates() %>건</h3>
                            <span>1:1 견적</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-user1 teal font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/deal/UserDealList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="deep-orange"><%=mDTO.getOngoing_deals() %>건</h3>
                            <span>진행중인 거래</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-diagram deep-orange font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/deal/UserDealList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="cyan"><%=mDTO.getPending_deal() %>건</h3>
                            <span>완료대기 거래</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-ios-help-outline cyan font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row match-height">
    <div class="col-xl-12 col-lg-12">
        <div class="card" id="list-container">
            <div class="card-header">
                <h4 class="card-title" id="schedule-list-title">다가오는 일정</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                        <div class="table">
                            <div class="table-row">
									<div class="table-head-cell"><strong>거래번호</strong></div>
                                    <div class="table-head-cell"><strong>조율사 성함</strong></div>
                                    <div class="table-head-cell"><strong>견적가</strong></div>
                                    <div class="table-head-cell"><strong>일시</strong></div>
                            </div>
                            <%
                            int i = 0;
                            DealDTO dDTO = null;
                            for(Iterator<DealDTO> it = dList.iterator(); it.hasNext() && i < 5; i++){
                            	dDTO = it.next();
                            	%>
                            <div class="table-row item" role="button" onclick="location.href='/deal/UserDealDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>&back=main'">
                                    <div class="table-cell"><%=dDTO.getDeal_seq() %></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(dDTO.getTuner_name()) %></div>
                                    <div class="table-cell"><%=dDTO.getTotal() %>원</div>
                                    <div class="table-cell"><%=dDTO.getFullDate() %></div>
                            </div>
                            <%} %>
                        </div>
                        <div class="card-text text-xs-center" id="no-schedule"><%if(dList.size()==0) {%>- 조율 일정이 없습니다 - <%} %></div>
                </div>
                <div class="card-block">
                    <p><span class="float-xs-right"><a href="/myPage/TunerSchedule.do">조율 일정 <i class="icon-arrow-right2"></i></a></span></p>
                </div>
            </div>
            
        </div>
    </div>
</div>
<!-- Recent invoice with Statistics -->


        </div>
      </div>
    </div>
<%} %>
<!-- 조율사 메인 끝 -->
	
	
	
	
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="footer.jsp" %>
</body>
</html>