<%@page import="poly.dto.DealDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.ReqDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="poly.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="../user/session.jsp" %>
<%
	List<DealDTO> dList = (ArrayList<DealDTO>)request.getAttribute("dList");
	String[] states = {"입찰 진행중", "입찰 취소", "거래중", "낙찰실패", "거래취소(고객)", "거래취소(조율사)", "완료 대기중", "거래완료", "거절(조율사)", "견적 거절"};
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>

<meta charset="UTF-8">
<title>과거 내역 - 도와조율</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="../header.jsp" %>
<style>
	.title{
		max-width: 40%;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    
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
                <h4 class="card-title">조율 현황</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                    <div class="table-responsive">
                        <table class="table table-bordred table-hover">
                            <thead>
                                <tr class="row">
                                    <th>거래번호</th>
                                    <th>조율사</th>
                                    <th>날짜</th>
                                    <th>진행 상태</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%for(DealDTO dDTO : dList){ %>
                                <tr onclick="location.href='/deal/UserDealDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>'" role="button">
                                    <td><%=CmmUtil.nvl(dDTO.getDeal_seq())%></td>
                                    <td><%=CmmUtil.nvl(dDTO.getTuner_name()) %></td>
                                    
                                    <td><%=dDTO.getFullDate()%></td>
                                    <td><%=states[Integer.parseInt(dDTO.getDeal_state())] %></td>
                                </tr>
                            <%} %>
                            </tbody>
                        </table>
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