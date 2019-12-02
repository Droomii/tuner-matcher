<%@page import="poly.util.Pagination"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="poly.dto.TunerDTO"%>
<%@page import="poly.dto.UserDTO"%>
<%@page import="poly.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.RepuDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>
<%
	List<ReviewDTO> revList = (List<ReviewDTO>)request.getAttribute("revList");  
	Pagination pg = (Pagination)request.getAttribute("pg");
	boolean admin = false;
	if(user_type.equals("2")){
		admin = true;
	}
	
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>
<style>
.checked{
   		color:orange;
   	}
</style>
<meta charset="UTF-8">
<title>리뷰 목록</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="/WEB-INF/view/menu.jsp" %>
	<div class="app-content content container-fluid">
	<div class="content-wrapper">
		<div class="content-body">
			<div class="row match-height">
				<div class="col-xs-12 col-md-10 offset-md-1 col-lg-8 offset-lg-2">
					
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">조율사 정보</h4>
						</div>
						<div class="card-body">
							<div class="card-block">
							<div class="card-text"><strong>리뷰 목록</strong></div>
								<hr style="border-color:gray;margin-top:0.2rem;margin-bottom:0.2rem">
								<!-- 리뷰 -->
								<div id="review-container">
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
										<div class="text-muted hidden eval-items">기술 : <%=sat[Integer.parseInt(revDTO.getReview_tech())] %> | 시간 : <%=sat[Integer.parseInt(revDTO.getReview_punctual())] %> | 친절 : <%=sat[Integer.parseInt(revDTO.getReview_kindness())] %></div>
										<hr style="border-color:gray;margin-bottom:0.2rem;margin-top:0.2rem">
									</div>
								<%} %>
								<%if(revList.size()==0) {%>
								<div class="card-text text-xs-center">- 리뷰가 없습니다. -</div>
								<%}else{ %>
	                        <%@include file="/WEB-INF/view/Pagination-ajax.jsp"%>
	                        <%} %>
	                        </div>
								<!-- /리뷰 -->
							
						</div>
					</div>
				</div>
			</div>
			</div>
		<!-- Header footer section end -->
		
		        </div>
	</div>
	</div>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
	<script type="text/javascript">
	
	// 리뷰 열고 닫고
	function toggleReview(el){
		var state = el.getAttribute('data-toggle');
		var content = el.getElementsByClassName('review-content')[0];
		var evalItems = el.getElementsByClassName('eval-items')[0];
		if(state=="0"){
			content.classList.remove('text-truncate');
			evalItems.classList.remove('hidden');
			el.setAttribute('data-toggle', "1");
			
			var reviews = document.getElementsByClassName('review');
			for(var i = 0 ; i < reviews.length; i++){
				if(reviews[i]!=el)
					closeOthers(reviews[i]);
			}
			
		}else{
			content.classList.add('text-truncate');
			evalItems.classList.add('hidden');
			el.setAttribute('data-toggle', "0");
		}
		
	}
	function closeOthers(el){
		var content = el.getElementsByClassName('review-content')[0];
		var evalItems = el.getElementsByClassName('eval-items')[0];
		content.classList.add('text-truncate');
		evalItems.classList.add('hidden');
		el.setAttribute('data-toggle', "0");
	}
	
	function gotoPage(el){
		var page = el.getAttribute('data-page');
		$.ajax({
			url : "/repu/RepuReviewList.do",
			data : {page : page,
				tuner_seq : "0"},
			type : "post",
			success : function(data){
				$("#review-container").html(data);
			}
			
		})
	}
	
	</script>
	<script type="text/javascript" src="/resources/js/bytechecker.js"></script>
</body>
</html>