<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.DealDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<DealDTO> dList = (List<DealDTO>)request.getAttribute("dList");
	Pagination pg = (Pagination)request.getAttribute("pg");
%>
<div class="table">
    <div class="table-row">
            <div class="table-head-cell"><strong>조율사 성명</strong></div>
            <div class="table-head-cell"><strong>견적가</strong></div>
            <div class="table-head-cell"><strong>희망일시</strong></div>
    </div>
    
    <%for(DealDTO dDTO : dList){ %>
    <div class="table-row item" role="button" onclick="location.href='/req/ReqBidDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>'">
            <div class="table-cell"><%=CmmUtil.nvl(dDTO.getTuner_name(), true)%></div>
            <div class="table-cell"><%=CmmUtil.nvl(dDTO.getTotal()) %>원</div>
            <div class="table-cell"><%=CmmUtil.nvl(dDTO.getFullDate()) %></div>
    </div>
    <%} %>
</div>
<%if(dList.size()==0) {%>
    <div class="card-text text-xs-center">- 아무도 입찰하지 않았습니다 - </div>
    <%}else{ %>
 <%@include file="/WEB-INF/view/Pagination-ajax.jsp"%>
 <%} %>