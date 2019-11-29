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

	UserDTO uDTO = (UserDTO)request.getAttribute("uDTO");
	TunerDTO tDTO = (TunerDTO)request.getAttribute("tDTO");
	Map<String, ArrayList<String>> sggGrouped = null;
	Set<String> sggKeys = null;

	
	sggGrouped = (Map<String, ArrayList<String>>)request.getAttribute("sggGrouped");
	sggKeys = sggGrouped.keySet();

	

	RepuDTO rDTO = (RepuDTO)request.getAttribute("rDTO");
	int[] techRates = rDTO.getTechRates();
	int[] timeRates = rDTO.getPunctualRates();
	int[] kindnessRates = rDTO.getKindnessRates();
	
	List<ReviewDTO> revList = (List<ReviewDTO>)request.getAttribute("revList");  
	Pagination pg = (Pagination)request.getAttribute("pg");
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
<title>조율사 정보</title>
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
						<img class="rounded float-xs-left img-thumbnail" style="height:160px" src="/img/tuner/<%=tDTO.getTuner_seq() %>/profile.<%=tDTO.getId_photo_dir() %>" alt="Card image cap">
						<div class="card-text valign-top ml-1 float-xs-left">
							<h5><strong><%=CmmUtil.nvl(rDTO.getTuner_name(), true) %></strong></h5>
							<div class="card-text">획득 별 : <%=rDTO.getScore() %><i class="icon-android-star" style="font-size:1.2rem;color:orange"></i></div>
							<div class="card-text">거래 성사율 : <%=rDTO.getSuccessRate()%>%</div>
							<div class="card-text">긍정적 평판 : <%=rDTO.getPositive_rate()%>%</div>
						</div>
						</div>
						<div class="card-block">
						<p class="card-text">이름 : <%=CmmUtil.nvl(uDTO.getUser_name(), true) %></p>
						<p class="card-text">이메일 : <%=CmmUtil.nvl(uDTO.getEmail(), true) %></p>
						<p class="card-text">전화번호 : <%=CmmUtil.nvl(uDTO.getUser_tel(), true) %></p>
						<p class="card-text">자격증 등급 : <%=tDTO.getTuner_level().equals("0") ? "기능사" : "산업기사" %></p>
						<p class="card-text">소속 : <%=CmmUtil.nvl(tDTO.getAffiliation(), true) %></p>
						<p class="card-text">근무지 : <%=CmmUtil.nvl(tDTO.getAddr(), true) %></p>
						<%if(!sggKeys.contains("전국")) { %>
						<p class="card-text">활동지역 : </p>
						<%} %>
						<%String sggString;%>
						<%for(String key : sggKeys){
							if(key.equals("전국")){ %>
							<p class="card-text">활동지역 : 전국</p><%break; }%>
							<%sggString = sggGrouped.get(key).toString(); %>
						<p class="card-text">&nbsp;&nbsp;&nbsp;- <%=key %> : <%=sggString.substring(1, sggString.length()-1) %></p>
						<%} %>
						<br>
						<p class="card-text">한줄소개 : <%=CmmUtil.nvl(tDTO.getTuner_comment(), "없음", true) %></p>
						<p class="card-text">이력 : <%if(CmmUtil.nvl(tDTO.getTuner_exp()).equals("")){ out.print("없음");%></p>
						<%}else{ %>
						<p class="card-text"><%=CmmUtil.nvl(tDTO.getTuner_exp()) %></p>
						<%} %>

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
						<%if(user_type.equals("0")){ %>
						<div class="card-footer">
						<div class="float-xs-left">
						<a class="button btn btn-info" href="/myPage/FollowingList.do">목록</a>
						</div>						
						<div class="float-xs-right">
						<button class="button btn btn-danger" onclick="followingRemove();">목록에서 제거</button>
						<a class="button btn btn-success" href="/req/NewPrivateReq.do?tuner_seq=<%=tDTO.getTuner_seq()%>">1:1 요청</a>
						</div>
						</div>
						<%}else{%>
						<div class="card-footer">
						<div class="float-xs-left">
						<a class="button btn btn-info" href="/user/TunerList.do">목록</a>
						</div>						
						<div class="float-xs-right">
						<button class="button btn btn-danger" data-toggle="modal" data-target="#decline-form">회원 정지</button>
						<a class="button btn btn-success" href="/user/AEditTuner.do?tuner_seq=<%=tDTO.getTuner_seq()%>">회원정보 수정</a>
						</div>
						</div>
						<!-- 회원쩡찌 모달 -->
						<div class="modal fade text-xs-left" id="decline-form" tabindex="-1" role="dialog" aria-labelledby="serialHelpLabel" style="display: none;" aria-hidden="true">
						  <div class="modal-dialog" role="document">
							<div class="modal-content">
							  <div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								  <span aria-hidden="true">×</span>
								</button>
								<h4 class="modal-title " id="serialHelpLabel">정지사유 입력</h4>
							  </div>
							  <div class="modal-body no-border">
								<form onsubmit="return suspendUser();" autocomplete="off" data-toggle="validator" role="form" name="suspendForm" class="form no-border" action="/user/UserSuspend.do" method="post" autocomplete="off">
							<!-- 리뷰 내용 -->
							<input hidden value="<%=tDTO.getTuner_seq() %>" name="user_seq">
							<input hidden value="tuner" name="type">
							<div class="form-group col-xs-12 has-feedback no-border">
								<input hidden="hidden" id="suspend_reason" name="suspend_reason">
								<textarea onchange="checkBytesNoNl(this, 200);" onKeyUp="checkBytesNoNl(this, 200);" id="temp_content" rows="5" class="form-control" placeholder="정지 사유를 입력해주세요"></textarea>
								<div class="float-xs-right"><span class="byte">0</span>/200 bytes</div>
								
							</div>
	                        <div class="modal-footer">
	                        <button type="submit" class="button btn btn-danger float-xs-right">정지</button>
								<button type="button" class="btn grey btn-outline-secondary float-xs-left" data-dismiss="modal">닫기</button>
							  </div>
							</form>
							  </div>
							  
							</div>
						  </div>
						</div>
						<!-- /반려 모달 -->
						<%} %>
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
	<%if(user_type.equals("2")){%>
	function suspendUser(){
		if($("#temp_content").val().trim().length==0){
			alert("정지 사유를 입력해주세요");
			return false;
		}
		
		if(confirm("회원을 정지하시겠습니까?")){
			var form = document.suspendForm;
			form.suspend_reason.value = form.temp_content.value.trim().replace(/\n/g, " ");
		}else{
			return false;
		}
	}
	<%}%>
	
	
	// 목록에서 삭제 확인
	function followingRemove(){
		if(confirm("자주 찾는 조율사 목록에서 제거하시겠습니까?")){
			location.href = "/follow/FollowingRemove.do?tuner_seq=<%=tDTO.getTuner_seq()%>";
		}
	}
	
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
				tuner_seq : "<%=tDTO.getTuner_seq()%>"},
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