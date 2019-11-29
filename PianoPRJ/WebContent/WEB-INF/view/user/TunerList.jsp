<%@page import="poly.dto.TunerDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.util.Pagination"%>
<%@page import="poly.dto.ReqDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="poly.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../user/session.jsp" %>
<%
	List<TunerDTO> tList = (List<TunerDTO>)request.getAttribute("tList");
	
	Pagination pg = (Pagination)request.getAttribute("pg");
	String pageName = "TunerList";
	String[] user_states = {"승인 대기중", "정상", "반려", "정지"};
	
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>가입승인 대기 조율사</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp" %>
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
		padding: 10px 20px 10px 20px;
		border-bottom : 2px solid rgb(200,200,200);
		border-top : 1px solid rgb(200,200,200);
	}
	.table-cell {
	  display: table-cell;
	  padding: 10px 20px 10px 20px;
	  border-bottom: 1px solid lightgray;
	}
	.item:hover{
		background-color:rgb(240,240,240);
	}
	
</style>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="../menu.jsp" %>
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-body"><!-- Basic Tables start -->
<div class="row">
    <div class="col-xs-12">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title">조율사 목록</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
            
            
                <div class="card-block card-dashboard">
                        <div class="table">
                            <div class="table-row">
									<div class="table-head-cell"><strong>회원번호</strong></div>
                                    <div class="table-head-cell"><strong>이름</strong></div>
                                    <div class="table-head-cell"><strong>기술등급</strong></div>
                                    <div class="table-head-cell"><strong>가입일</strong></div>
                                    <div class="table-head-cell"><strong>계정상태</strong></div>
                            </div>
                            
                            <%for(TunerDTO tDTO : tList){ %>
                            <div class="table-row item" role="button" onclick="location.href='/user/TunerDetail.do?tuner_seq=<%=tDTO.getTuner_seq()%>'">
                                    <div class="table-cell"><%=CmmUtil.nvl(tDTO.getTuner_seq()) %></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(tDTO.getTuner_name()) %></div>
                                    <div class="table-cell"><%=tDTO.getTuner_level().equals("0") ? "기능사" : "산업기사" %></div>
                                    <div class="table-cell"><%=tDTO.getRegdate().substring(0, 10)%></div>
                                    <div class="table-cell"><%=user_states[Integer.parseInt(tDTO.getUser_state())]%></div>
                            </div>
                            <%} %>
                        </div>
                        <%if(tList.size()==0) {%>
                            <div class="card-text text-xs-center">- 조율사 가입 요청이 없습니다 - </div>
                            <%}else{ %>
                        <%@include file="/WEB-INF/view/Pagination.jsp"%>
                        <%} %>
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
	<%@include file="../footer.jsp" %>
</body>
</html>