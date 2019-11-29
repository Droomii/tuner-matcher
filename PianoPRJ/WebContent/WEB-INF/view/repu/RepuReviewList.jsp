<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<ReviewDTO> revList = (List<ReviewDTO>)request.getAttribute("revList");
	Pagination pg = (Pagination)request.getAttribute("pg");
%>


<%for(ReviewDTO revDTO : revList){ %>
	<div role="button" class="review" onclick="toggleReview(this);" data-toggle="0">
		<div style="font-size:1.5rem;color:gray;letter-spacing:-0.3rem;">
		<div style="display:inline-block">
		<%
		int stars = Integer.parseInt(revDTO.getReview_star());
		String[] sat = {"불만족", "보통", "만족"};
		for(int i=0; i<5; i++){ %>
			<span><i class="icon-android-star <%=i<stars ? "checked" : "" %>"></i></span>	
		<%} %>
		</div>
		<div id="star-msg" style="font-size:1rem;letter-spacing:0;display:inline-block;vertical-align:middle;height:2rem">&nbsp;<%=revDTO.getUser_nick()%> | <%=revDTO.getRegdate().substring(0, 10) %></div>
		</div>
		<div class="card-text text-truncate mb-1 review-content">
		<%=CmmUtil.nvl(revDTO.getReview_content(), true) %>
		</div>
		<div class="text-muted hidden eval-items">기술 : <%=sat[Integer.parseInt(revDTO.getReview_tech())] %> | 시간 : <%=sat[Integer.parseInt(revDTO.getReview_punctual())] %> | 친절 : <%=sat[Integer.parseInt(revDTO.getReview_kindness())] %></div>
		<hr style="border-color:gray;margin-bottom:0.2rem;margin-top:0.2rem">
	</div>
<%} %>
<%if(revList.size()==0) {%>
<div class="card-text text-xs-center">- 리뷰가 없습니다. -</div>
<%}else{ %>
<%@include file="/WEB-INF/view/Pagination-ajax.jsp"%>
<%} %>