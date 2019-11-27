<%@page import="poly.dto.TunerDTO"%>
<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.RepuDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	RepuDTO rDTO = (RepuDTO)request.getAttribute("rDTO");
	int[] techRates = rDTO.getTechRates();
	int[] timeRates = rDTO.getPunctualRates();
	int[] kindnessRates = rDTO.getKindnessRates();
	TunerDTO tDTO = (TunerDTO)request.getAttribute("tDTO");
	
	List<ReviewDTO> revList = (List<ReviewDTO>)request.getAttribute("revList");
	Pagination pg = (Pagination)request.getAttribute("pg");
%>
    
<div class="modal fade text-xs-left" id="tuner-detail" tabindex="-1" role="dialog" aria-labelledby="tuner-detail-title" style="display: none;" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
	  <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		  <span aria-hidden="true">×</span>
		</button>
		<h6 class="modal-title" id="tuner-detail-title"><strong>조율사 상세정보</strong></h6>
	  </div>
	  <div class="modal-body">
						<div class="card-block">
						<img class="rounded float-xs-left img-thumbnail" style="height:160px" src="/img/tuner/<%=tDTO.getTuner_seq() %>/profile.<%=tDTO.getId_photo_dir() %>" alt="Card image cap">
						<div class="card-text valign-top ml-1 float-xs-left">
							<h5><strong><%=rDTO.getTuner_name() %></strong></h5>
							<div class="card-text">획득 별 : <%=rDTO.getScore() %><i class="icon-android-star" style="font-size:1.2rem;color:orange"></i></div>
							<div class="card-text">거래 성사율 : <%=rDTO.getSuccessRate()%>%</div>
							<div class="card-text">긍정적 평판 : <%=rDTO.getPositive_rate()%>%</div>
						</div>
						</div>
							<div class="card-block">
								<div class="card-text"><strong>리뷰 요약정보(<%=rDTO.getTotal_reviews() %>건)</strong></div>
								<hr style="border-color:gray;margin-top:0.2rem">
								<div class="row">
									<div class="col-xs-4 border-right">
										<h6><strong>기술 만족도</strong></h6>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=techRates[0]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=techRates[0]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											보통&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=techRates[1]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=techRates[1]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											불만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=techRates[2]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=techRates[2]%>% 
											</div>
										</div>
									</div>
									<div class="col-xs-4 border-right">
										<h6><strong>시간 만족도</strong></h6>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=timeRates[0]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=timeRates[0]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											보통&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=timeRates[1]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=timeRates[1]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											불만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=timeRates[2]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=timeRates[2]%>% 
											</div>
										</div>
									</div>
									<div class="col-xs-4">
										<h6><strong>친절도</strong></h6>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=kindnessRates[0]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=kindnessRates[0]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											보통&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=kindnessRates[1]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=kindnessRates[1]%>% 
											</div>
										</div>
										<div class="row mb-1" style="display:flex;align-items:center">
											<div class="card-text col-xs-3 text-xs-right pr-0" style="font-size:0.8rem">
											불만족&nbsp;
											</div>
											<div class="col-xs-6 pr-0 pl-0 text-xs-left" style="height:0.8rem;background-color:gray;display:flex">
												<div style="background-color:skyblue;height:100%;width:<%=kindnessRates[2]%>%"></div>
											</div>
											<div class="card-text col-xs-3 text-xs-left pl-0" style="font-size:0.8rem">
											&nbsp;<%=kindnessRates[2]%>% 
											</div>
										</div>
									</div>
									
								</div>
							</div>
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
										<div id="star-msg" style="font-size:1rem;letter-spacing:0;display:inline-block;vertical-align:middle;height:2rem">&nbsp;<%=revDTO.getUser_nick()%> | <%=revDTO.getRegdate().substring(0, 10) %></div>
										</div>
										<div class="card-text text-truncate mb-1 review-content">
										<%=CmmUtil.nvl(revDTO.getReview_content()) %>
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
	  <div class="modal-footer">
		<button type="button" class="btn grey btn-outline-secondary" data-dismiss="modal">닫기</button>
	  </div>
	</div>
  </div>
</div>
<script>
//리뷰 열고 닫고
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
			tuner_seq : "<%=tDTO.getTuner_seq()%>"},
		type : "post",
		success : function(data){
			$("#review-container").html(data);
		}
		
	})
}
</script>