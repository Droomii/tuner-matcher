<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<ReviewDTO> revList = (List<ReviewDTO>)request.getAttribute("revList");
	Pagination pg = (Pagination)request.getAttribute("pg");
	String user_type = (String)session.getAttribute("user_type");
	boolean admin = false;
	if(user_type.equals("2")){
		admin=true;
	}
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
		<div id="star-msg" style="font-size:1rem;letter-spacing:0;display:inline-block;vertical-align:middle;height:2rem">&nbsp;<%=revDTO.getUser_nick(admin)%><%if(user_type.equals("2")){%><%=revDTO.getUser_state()==4 ? "(탈퇴)" : revDTO.getUser_state()==3 ? "(정지)" : "" %><%} %> | <%=revDTO.getRegdate().substring(0, 10) %></div>
		</div>
		<div class="card-text text-truncate mb-1 review-content">
		<%=CmmUtil.nvl(revDTO.getReview_content(), true) %>
		</div>
		<div class="row">
		<div class="text-muted hidden eval-items col-xs-8">기술 : <%=sat[Integer.parseInt(revDTO.getReview_tech())] %> | 시간 : <%=sat[Integer.parseInt(revDTO.getReview_punctual())] %> | 친절 : <%=sat[Integer.parseInt(revDTO.getReview_kindness())] %></div>
		<%if(user_type.equals("2")){%>
		<div class="hidden float-xs-right text-xs-right col-xs-4 deal-info">
		<button class="btn-sm btn btn-success">거래 정보</button>
		</div>
		<%} %>
		</div>
		<hr style="border-color:gray;margin-bottom:0.2rem;margin-top:0.2rem">
	</div>
<%} %>
<%if(revList.size()==0) {%>
<div class="card-text text-xs-center">- 리뷰가 없습니다. -</div>
<%}else{ %>
<%@include file="/WEB-INF/view/Pagination-ajax.jsp"%>
<%} %>