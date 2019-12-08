<%@page import="poly.dto.RescheduleDTO"%>
<%@page import="poly.dto.ReviewDTO"%>
<%@page import="poly.util.FormatUtil"%>
<%@page import="poly.dto.UserDTO"%>
<%@page import="poly.dto.DealDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="poly.dto.ReqDTO"%>
<%@page import="poly.dto.PianoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>

<%
	PianoDTO pDTO = (PianoDTO)request.getAttribute("pDTO");
	ReqDTO rDTO = (ReqDTO)request.getAttribute("rDTO");
	DealDTO dDTO = (DealDTO)request.getAttribute("dDTO");	
	String back = (String)request.getAttribute("back");
	back = back==null ? "/deal/TunerDealList.do" : back;
	UserDTO uDTO = (UserDTO)request.getAttribute("uDTO");
	ReviewDTO revDTO = (ReviewDTO)request.getAttribute("revDTO");
	RescheduleDTO resDTO = (RescheduleDTO)request.getAttribute("resDTO");
	
	String deal_state = dDTO.getDeal_state();
	
	String tuner_name = uDTO.getUser_name();
	
	
	String[] weekdays = {"일", "월", "화", "수", "목", "금", "토"};
	
	String date = dDTO.getPossible_date();
	Date d = new SimpleDateFormat("yyyy-M-dd").parse(date.split("h")[0]);
	Calendar c = Calendar.getInstance();
	c.setTime(d);
	int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
	String weekday = weekdays[dayOfWeek-1];
	
	String changeDate = null;
	Date chgDate = null;
	Calendar chgCal = null;
	int chgDayOfWeek;
	String chgWeekday = null;
	
	if(resDTO!=null){
		changeDate = resDTO.getChg_date();
		chgDate = new SimpleDateFormat("yyyy-M-dd").parse(changeDate.split("h")[0]);
		chgCal = Calendar.getInstance();
		chgCal.setTime(chgDate);
		chgDayOfWeek = chgCal.get(Calendar.DAY_OF_WEEK);
		chgWeekday = weekdays[chgDayOfWeek-1];
	}
	
	
	int itemLen = 0;
	Map<String, String> items = new LinkedHashMap<>();
	if(dDTO.getTuning_price()!= null){
		int eaPrice = Integer.parseInt(dDTO.getTuning_price()) * Integer.parseInt(dDTO.getTuning_ea()); 
		items.put("조율", dDTO.getTuning_ea()+","+ Integer.toString(eaPrice));
		itemLen++;
	}
	
	if(dDTO.getRegul_price()!= null){
		int eaPrice = Integer.parseInt(dDTO.getRegul_price()) * Integer.parseInt(dDTO.getRegul_ea()); 
		items.put("조정", dDTO.getRegul_ea()+","+ Integer.toString(eaPrice));
		itemLen++;
	}
	
	if(dDTO.getVoicing_price()!= null){
		int eaPrice = Integer.parseInt(dDTO.getVoicing_price()) * Integer.parseInt(dDTO.getVoicing_ea()); 
		items.put("정음", dDTO.getVoicing_ea()+","+ Integer.toString(eaPrice));
		itemLen++;
	}
	
	if(dDTO.getTransport_price()!= null){
		int eaPrice = Integer.parseInt(dDTO.getTransport_price()) * Integer.parseInt(dDTO.getTransport_ea()); 
		items.put("운반", dDTO.getTransport_ea()+","+ Integer.toString(eaPrice));
		itemLen++;
	}
	
	if(dDTO.getOther_price()!= null){
		int eaPrice = Integer.parseInt(dDTO.getOther_price()); 
		items.put("기타", "1,"+ Integer.toString(eaPrice));
		itemLen++;
	}
	
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>
<style>
	.text-bold-700{
		background-color:rgb(220,220,220);
		padding: 0.3rem;
	}
	.desc{
		padding: 0.3rem;
	}
	.has-error, .has-danger{
    		color:crimson;
    		}
   	.success-msg{
   		color:#3c763d;
   		display:none;
   		line-height:1.8;
   	}
   	table, th, td{
   		border:2px solid rgb(150,150,150);
   	}
   	.checked{
   		color:orange;
   	}
   	
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
</style>


<meta charset="UTF-8">

<title>견적 정보</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="/WEB-INF/view/menu.jsp" %>
	<div class="app-content content container-fluid">
	<div class="content-body"><!-- Basic example section start -->
<!-- Header footer section start -->
<section id="header-footer">
	<div class="row">
			<div class="col-xs-12 col-lg-6 offset-lg-3">
				<div class="card">
					<div class="card-header">
						<h4 class="card-title" id="basic-layout-form">견적 정보</h4>
					</div>
		            <div class="card-body collapse in">
		            <%if(!dDTO.getDeal_state().equals("3")){ %>
			            <div class="card-block">
			            <div>
							<h5 class="form-section text-bold-600 float-xs-left" >고객 정보</h5>
						</div>
							<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">성명</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 desc"><div style="margin:auto"><%=CmmUtil.nvl(uDTO.getUser_name(), true) %></div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">연락처</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 desc"><div style="margin:auto"><%=uDTO.getUser_tel() %></div></div>
								</div>
							</div>
						
						</div>
						<%} %>
						<div class="card-block">
						<h5 class="form-section text-bold-600">피아노 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">브랜드</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getBrand(), true) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">일련번호</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getSerial(), true) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">피아노 타입</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPiano_type()).equals("0")?"업라이트" : "그랜드"%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">용도</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPlayer_type(), true) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">마지막 조율 날짜</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class=" border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getLast_tuned_date()).equals("") ? "모름" : CmmUtil.nvl(pDTO.getLast_tuned_date()).substring(0,10)%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">주소</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc"><%=CmmUtil.nvl(rDTO.getSido_name()) %> <%=CmmUtil.nvl(rDTO.getSgg_name()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700"><span style="margin:auto">사진</span></div>
									<%if(pDTO.getPiano_photo_dir()!=null){ %>
									<div style="border-color:rgb(150,150,150);padding:0" class="border col-xs-9 desc">
									<img class="img-fluid my-0" src="/img/piano/<%=pDTO.getPiano_seq() %>/image.<%=pDTO.getPiano_photo_dir() %>" alt="Card image cap">
									<%}else{ %>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc">사진 없음</div>
									
									<%} %>
									</div>
									
							</div>
							</div>
						
					</div>
					
					<div class="card-block">
						<h5 class="form-section text-bold-600">요청서 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">요청사항</div></div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(rDTO.getReq_content()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700"><span style="margin:auto">참고사진</span></div>
									<%if(rDTO.getPhoto_dir()!=null){ %>
									<div style="border-color:rgb(150,150,150);padding:0" class="border col-xs-9 desc">
									<img class="img-fluid my-0" src="/img/req/<%=rDTO.getReq_seq() %>/image.<%=rDTO.getPhoto_dir() %>" alt="Card image cap"></div>
									<%}else{ %>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc">사진 없음</div>
									<%} %>
									
								</div>
							</div>
						
					</div>
		                <div class="card-block">
						<h5 class="form-section text-bold-600">견적 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
								<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">소견</div></div>
								<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(dDTO.getDiagnosis_content()) %></div>
							</div>
						</div>
					</div>
					<div class="card-block">
						<div class="table mb-0">
                        <div class="table-row" style="background-color:rgb(220,220,220)">
                                <div class="table-head-cell" style="text-align:center">품목</div>
                                <div class="table-head-cell" style="width:8rem;text-align:center">수량</div>
                                <div class="table-head-cell" style="width:10rem;text-align:center">가격</div>
                        </div>
                        <%Iterator<String> itemKeys = items.keySet().iterator(); 
                        String itemKey = itemKeys.next();%>
                            <div class="table-row">
                                <div class="table-cell"><%=itemKey %></div>
                                <div class="table-cell" style="text-align:center"><%=items.get(itemKey).split(",")[0] %></div>
                                <div class="table-cell" style="text-align:right"><%=String.format("%,d", Integer.parseInt(items.get(itemKey).split(",")[1]))%> 원</div>
                            </div>
                            <%while(itemKeys.hasNext()){ 
                            itemKey = itemKeys.next();%>
                            <div class="table-row">
                                <div class="table-cell"><%=itemKey %></div>
                                <div class="table-cell" style="text-align:center"><%=items.get(itemKey).split(",")[0] %></div>
                                <div class="table-cell" style="text-align:right"><%=String.format("%,d", Integer.parseInt(items.get(itemKey).split(",")[1]))%> 원</div>
                            </div>
                            <%} %>
                           
                    </div>
                    <div class='table'>
                    <div class="table-row">
                                <div class="table-cell" style="background-color:rgb(220,220,220);text-align:right"><strong>총합</strong></div>
                                <div class="table-cell" style="width:10rem;text-align:right"><%=dDTO.getTotal() %> 원</div>
                            </div>
                            </div>
					</div>
					<%if(!dDTO.getDeal_state().equals("3")){ %>
					<div class="card-block">
						<h5 class="form-section text-bold-600">위치 및 날짜 정보</h5>
						<div class="col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
								<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">주소</div></div>
								<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getAddr()) %></div>
							</div>
							<div class="row" style="display:flex;">
								<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">희망일시</div></div>
								<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc">
								<%if(dDTO.getDeal_state().equals("10")){%>
								<strong style="color:red"><%=date.split("h")[0] %>(<%=weekday %>) <%=date.split("h")[1] %>:00 → <%=changeDate.split("h")[0] %>(<%=chgWeekday %>) <%=changeDate.split("h")[1] %>:00</strong>
								<%}else{ %>
								<%=date.split("h")[0] %>(<%=weekday %>) <%=date.split("h")[1] %>:00
								<%} %>
								</div>
							</div>
							<%if(dDTO.getDeal_state().equals("10")){%>
							<div class="row" style="display:flex;">
								<div style="border-color:rgb(150,150,150);padding:0.5rem;display:flex" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" ><div style="margin:auto">변경사유</div></div>
								<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(resDTO.getChg_reason()) %></div>
							</div>
							
							<%} %>
						</div>
						<%if(dDTO.getDeal_state().equals("10") && !resDTO.getRequester_seq().equals(user_seq)){%>
						<div class="row text-xs-center">
								<span>
							<button onclick="declineChange();" class="button btn btn-sm btn-danger">거절 </button>
							</span>
							<span>
								<button onclick="acceptChange();" class="button btn btn-sm btn-success">수락</button>
							</span>
							</div>
						<%} %>
						<%if(deal_state.matches("[2]")){ %>
						<div class="float-xs-right">
						<button class="button btn btn-sm btn-success" onclick="location.href='/deal/Reschedule.do?deal_seq=<%=dDTO.getDeal_seq()%>'">날짜 변경 요청</button>
						</div>
						<%} %>
					</div>
					<div class="card-block">
						<div style="height:600px">
							<div id="map" style="width:100%;height:100%;"></div>
						</div>
					</div>
					<%} %>
					
					<%if(deal_state.equals("7")){ %>
					<div id="review-container">
					<%if(revDTO==null){ %>
					<div class="card-block">
						<h5 class="form-section text-bold-600">고객 리뷰</h5>
						<hr>
						<div class="card-text text-xs-center">- 고객이 리뷰를 등록하지 않았습니다 -</div>
					</div>
					<%}else{ %>
					<div class="card-block">
						<h5 class="form-section text-bold-600">고객 리뷰</h5>
						<hr>
						<div style="font-size:1.5rem;color:gray;letter-spacing:-0.3rem;">
						<%
						int stars = Integer.parseInt(revDTO.getReview_star());
						String[] sat = {"불만족", "보통", "만족"};
						for(int i=0; i<5; i++){ %>
							<span><i class="icon-android-star <%=i<stars ? "checked" : "" %>"></i></span>	
						<%} %>
						</div>
						<p>
						<%=CmmUtil.nvl(revDTO.getReview_content(), true) %>
						</p>
						<div class="text-muted float-xs-left">기술 : <%=sat[Integer.parseInt(revDTO.getReview_tech())] %> | 시간 : <%=sat[Integer.parseInt(revDTO.getReview_punctual())] %> | 친절 : <%=sat[Integer.parseInt(revDTO.getReview_kindness())] %></div>
						<%if(user_type.equals("0")){ %>
						<div class="float-xs-right">
							<span>
						<button onclick="reviewDelete();" class="button btn btn-sm btn-danger">삭제 </button>
						</span>
						<span>
							<button onclick="reviewEdit();" class="button btn btn-sm btn-success">수정</button>
						</span>
						</div>
						<%} %>
					</div>
					</div>
					<%} %>
					<%} %>
					<div class="card-footer text-xs-center">
					<span>
						<a href="<%=back %>" class="button btn btn-info">뒤로 </a>
					</span>
					<%if(deal_state.matches("[26]|10")){ %>
					<%if(deal_state.equals("6")){ %>
					<span>
						<button class="button btn btn-success" disabled>완료 대기중</button>
					</span>
					<%}else{ %>
					<span>
						<button onclick="dealCancel();"class="button btn btn-danger">거래 취소 </button>
					</span>
					<span>
						<button onclick="dealConfirm();"class="button btn btn-success">거래 완료</button>
					</span>
					<%} %>
		            </div>
		            
					<%} %>
				</div>
				</div>
			</div>
		</div>
</section>
<!-- Header footer section end -->

        </div>
	</div>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=166a1380ea4bddbad714a838dbb867a6&libraries=services,clusterer,drawing"></script>
	<script type="text/javascript">
	
	<%if(dDTO.getDeal_state().equals("10") && !resDTO.getRequester_seq().equals(user_seq)){%>
	function acceptChange(){
		if(confirm("일정 변경을 수락하시겠습니까?")){
			location.href = "/deal/RescheduleResponse.do?resp=1&deal_seq=<%=dDTO.getDeal_seq()%>";
		}
	}
	function declineChange(){
		if(confirm("일정 변경을 거절하시겠습니까?")){
			location.href = "/deal/RescheduleResponse.do?resp=2&deal_seq=<%=dDTO.getDeal_seq()%>";
		}
	}
	<%}%>
	
	
	
	
	<%if(user_type.equals("0") && revDTO != null){ %>
	function reviewDelete(){
		if(confirm("리뷰를 삭제하시겠습니까?")){
			location.href='/review/ReviewDelete.do?deal_seq=<%=dDTO.getDeal_seq()%>';
		}
	}
	
	function reviewEdit(){
		var query = {deal_seq : "<%=dDTO.getDeal_seq()%>"};
		$.ajax({
			url:"/review/ReviewEdit.do",
			type:"post",
			data:query,
			success:function(data){
				if(data==null){
					alert('비정상적인 접근입니다.');
					return;
				}else{
					$("#review-container").html(data);
				}
			}
		});
		
	}
	
	<%}%>
	
	<%if(deal_state.matches("7")){ %>
	
	function clickStar(el){
		var starNum = parseInt(el.id.substring(5))
		var score = 0;
		for(var i=0; i<5; i++){
			if(i<starNum){
				document.getElementById("star-" + (i+1)).classList.add("checked");
				score++;
			}else{
				document.getElementById("star-" + (i+1)).classList.remove("checked");
			}
			
		}
		document.getElementById("review_star").value = score.toString();
	}
	
	function checkBytes(el, limit){
		var b, i, c;
		var s = el.value;
		var last;
	    for(b=i=0; c=s.charCodeAt(i);i++) {
	    	b+=c>>11?3:c>>7?2:1;
	    	if(b > limit){
	    		alert('글자수를 초과하였습니다.');
		    	el.value = el.value.substring(0, i);
		    	el.parentElement.querySelector('span').innerHTML = last;
		    	return
	    	}
	    	last = b;
	    }
	    el.parentElement.querySelector('span').innerHTML = b;
	    
	    return b
	}
	
	function submitReview(type){
		var form = document.reviewForm;
		if(form.review_star.value=="0"){
			alert("별점을 선택하세요");
			return false;
		}
		if(form.temp_content.value.trim()==""){
			alert("리뷰 내용을 입력하세요");
			return false;
		}
		if(form.review_tech.value=='선택'){
			alert('기술 만족도를 선택해주세요');
			return false;
		}
		if(form.review_punctual.value=='선택'){
			alert('시간 엄수 만족도를 선택해주세요');
			return false;
		}
		if(form.review_kindness.value=='선택'){
			alert('친절 만족도를 선택해주세요');
			return false;
		}
		form.review_content.value = form.temp_content.value.replace(/\n/g, " ");
		if(confirm("리뷰를 " +type+"하시겠습니까?"))
			form.submit();
		
	}
	
	
	<%} %>
	
	<%if(deal_state.matches("[26]")){ %>
	function dealCancel(){
		if(confirm("해당 거래를 취소하시겠습니까?")){
			location.href="/deal/TunerDealCancel.do?deal_seq=<%=dDTO.getDeal_seq()%>";
		}
	}
	
	function dealConfirm(){
		if(confirm("거래를 완료하시겠습니까?")){
			location.href="/deal/TunerDealConfirm.do?deal_seq=<%=dDTO.getDeal_seq()%>";
		}
	}
	<%} %>
	
	<%if(!dDTO.getDeal_state().equals("3")){ %>
	// 지도

	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		level: 6 //지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	var geocoder = new kakao.maps.services.Geocoder();
	
	function init(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        console.log(result);
	        var tunerAddr = result[0];
	        var moveLoc = new kakao.maps.LatLng(tunerAddr.y, tunerAddr.x);
	        map.setCenter(moveLoc);
	        
	        var imageSrc = '/resources/images/help.png', // 마커이미지의 주소입니다    
	        imageSize = new kakao.maps.Size(31, 42), // 마커이미지의 크기입니다
	        imageOption = {offset: new kakao.maps.Point(16, 42)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	        
	        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	        marker = new kakao.maps.Marker({
	            position: moveLoc,
	            image:markerImage
	        });
	        marker.setMap(map);
	    }
	};
	geocoder.addressSearch('<%=CmmUtil.nvl(pDTO.getAddr()).split("&#40")[0].split(",")[0] %>', init);
	
	<%}%>
	</script>
	<script src="/resources/js/validator.js" type="text/javascript"></script>
	<script src="/resources/js/bytechecker.js" type="text/javascript"></script>
</body>
</html>