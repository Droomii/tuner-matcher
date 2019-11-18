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
	String[] states = {"입찰 진행중", "입찰 취소", "거래중", "낙찰실패", "거래중", "거래취소", "거래성사"};
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
                <h4 class="card-title">과거 내역</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                    <div class="table-responsive">
                        <table class="table table-bordred table-hover">
                            <thead>
                                <tr class="row">
                                    <th>거래번호</th>
                                    <th>고객 닉네임</th>
                                    <th>견적가</th>
                                    <th>결과</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%for(DealDTO dDTO : dList){ %>
                                <tr onclick="location.href='/deal/BidDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>&back=past'" role="button">
                                    <td><%=CmmUtil.nvl(dDTO.getDeal_seq())%></td>
                                    <td><%=CmmUtil.nvl(dDTO.getRequester_nick()) %></td>
                                    
                                    <td><%=dDTO.getTotal() %>원</td>
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