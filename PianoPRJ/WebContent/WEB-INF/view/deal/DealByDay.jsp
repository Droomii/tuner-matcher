<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.DealDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<DealDTO> dList = (List<DealDTO>)request.getAttribute("dList");
	String selectedFullDate = (String)request.getAttribute("selectedFullDate");
%>
<div class="card-header">
                <h4 class="card-title" id="schedule-list-title"><%=selectedFullDate %> 일정</h4>
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
                            <%for(DealDTO dDTO : dList){ %>
                            <div class="table-row item" role="button" onclick="location.href='/deal/TunerDealDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>'">
                                    <div class="table-cell"><%=dDTO.getDeal_seq() %></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(dDTO.getRequester_nick()) %></div>
                                    <div class="table-cell"><%=dDTO.getTotal() %>원</div>
                                    <div class="table-cell"><%=dDTO.getFullDate() %></div>
                            </div>
                            <%} %>
                        </div>
                        
                            <div class="card-text text-xs-center" id="no-schedule"><%if(dList.size()==0) {%>- 조율 일정이 없습니다 - <%} %></div>
                            
                </div>
            </div>