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
	List<UserDTO> uList = (List<UserDTO>)request.getAttribute("uList");
	
	Pagination pg = (Pagination)request.getAttribute("pg");
	String pageName = "UserList";
	String[] user_states = {"승인 대기중", "정상", "반려", "정지"};
	
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>일반회원 목록</title>
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
                <h4 class="card-title">일반회원 목록</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
            
            
                <div class="card-block card-dashboard">
                        <div class="table">
                            <div class="table-row">
									<div class="table-head-cell"><strong>회원번호</strong></div>
                                    <div class="table-head-cell"><strong>이름</strong></div>
                                    <div class="table-head-cell"><strong>닉네임</strong></div>
                                    <div class="table-head-cell"><strong>가입일</strong></div>
                                    <div class="table-head-cell"><strong>계정상태</strong></div>
                            </div>
                            
                            <%for(UserDTO uDTO : uList){ %>
                            <div class="table-row item" role="button" onclick="location.href='/user/UserDetail.do?user_seq=<%=uDTO.getUser_seq()%>'">
                                    <div class="table-cell"><%=CmmUtil.nvl(uDTO.getUser_seq()) %></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(uDTO.getUser_name()) %></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(uDTO.getUser_nick(), true)%></div>
                                    <div class="table-cell"><%=uDTO.getRegdate().substring(0, 10)%></div>
                                    <div class="table-cell"><%=user_states[Integer.parseInt(uDTO.getUser_state())]%></div>
                            </div>
                            <%} %>
                        </div>
                        <%if(uList.size()==0) {%>
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