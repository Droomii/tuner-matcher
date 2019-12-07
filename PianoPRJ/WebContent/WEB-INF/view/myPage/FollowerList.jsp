<%@page import="poly.dto.FollowDTO"%>
<%@page import="poly.dto.UserDTO"%>
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
	List<FollowDTO> fList = (List<FollowDTO>)request.getAttribute("fList");
	
	Pagination pg = (Pagination)request.getAttribute("pg");
	String pageName = "FollowerList";
	String[] user_states = {"승인 대기중", "정상", "반려", "정지", "탈퇴"};
	
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>단골고객 목록</title>
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
    <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8 offset-sm-2 offset-md-2 offset-lg-2">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title">단골고객 목록</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
            
            
                <div class="card-block card-dashboard">
                        <div class="table">
                            <div class="table-row">
                                    <div class="table-head-cell"><strong>고객 닉네임</strong></div>
                                    <div class="table-head-cell"><strong>거래 횟수</strong></div>
                                    <div class="table-head-cell"><strong>추가날짜</strong></div>
                            </div>
                            
                            <%for(FollowDTO fDTO : fList){ %>
                            <div class="table-row item" role="button" onclick="location.href='/myPage/FollowerDetail.do?user_seq=<%=fDTO.getUser_seq()%>'">
                                    <div class="table-cell"><%=CmmUtil.nvl(fDTO.getUser_nick(), true)%></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(fDTO.getDeals(), true)%>회</div>
                                    <div class="table-cell"><%=CmmUtil.nvl(fDTO.getAdd_date(), true).substring(0,10)%></div>
                            </div>
                            <%} %>
                        </div>
                        <%if(fList.size()==0) {%>
                            <div class="card-text text-xs-center">- 회원이 없습니다 - </div>
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