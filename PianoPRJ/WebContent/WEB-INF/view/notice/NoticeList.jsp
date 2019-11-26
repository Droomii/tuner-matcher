<%@page import="java.util.ArrayList"%>
<%@page import="poly.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../user/session.jsp" %>
<%
	ArrayList<NoticeDTO> rList = (ArrayList<NoticeDTO>)request.getAttribute("rList");
	ArrayList<NoticeDTO> topList = (ArrayList<NoticeDTO>)request.getAttribute("topList");
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>공지사항 - 도와조율</title>
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
                <h4 class="card-title">공지사항</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                        <div class="table">
                            <div class="table-row">
									<div class="table-head-cell"><strong>글번호</strong></div>
                                    <div class="table-head-cell"><strong>제목</strong></div>
                                    <div class="table-head-cell"><strong>작성자</strong></div>
                                    <div class="table-head-cell"><strong>작성일</strong></div>
                                    <div class="table-head-cell"><strong>조회수</strong></div>
                            </div>
                             <%for(NoticeDTO nDTO : topList){ %>
                                <div class="table-row item" role="button" onclick="location.href='/notice/NoticeInfo.do?notice_seq=<%=nDTO.getNotice_seq()%>'">
                                    <div class="table-cell"><strong>상단공지</strong></div>
                                    <div class="table-cell"><strong><%=nDTO.getNotice_title() %></strong></div>
                                    <div class="table-cell"><strong>관리자</strong></div>
                                    <div class="table-cell"><strong><%=nDTO.getRegdate().substring(0,11) %></strong></div>
                                    <div class="table-cell"><strong><%=nDTO.getNotice_count() %></strong></div>
                                </div>
                            <%} %>
                            <%for(NoticeDTO nDTO : rList){ %>
                                <div class="table-row item" role="button" onclick="location.href='/notice/NoticeInfo.do?notice_seq=<%=nDTO.getNotice_seq()%>'">
                                    <div class="table-cell"><%=nDTO.getNotice_seq() %></div>
                                    <div class="table-cell"><%=nDTO.getNotice_title() %></div>
                                    <div class="table-cell">관리자</div>
                                    <div class="table-cell"><%=nDTO.getRegdate().substring(0,11) %></div>
                                    <div class="table-cell"><%=nDTO.getNotice_count() %></div>
                                </div>
                            <%} %>
                        </div>
                        <%if(rList.size()==0 && topList.size()==0) {%>
                            <div class="card-text text-xs-center">- 공지가 없습니다 - </div>
                            <%} %>
	                <div class="float-xs-right">
	                <%if(user_type.equals("2")){ %><button class="btn btn-primary" onclick="location.href='/notice/NoticeReg.do'">새 공지</button><%} %>
	                
	                </div>
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