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
	String userTypeName = user_type.equals("0") ? "User" : "Tuner";
	String proc = CmmUtil.nvl((String)session.getAttribute("proc"));
	String back = proc.equals("public") ? "/req/" + userTypeName + "PublicReqList"
										:"/req/" + userTypeName + "PrivateReqList";
	ReqDTO rDTO = (ReqDTO)request.getAttribute("rDTO");
	Map<String, List<String>> prefDates = (LinkedHashMap<String, List<String>>)request.getAttribute("prefDates");
	String[] weekdays = {"일", "월", "화", "수", "목", "금", "토"}; 
	
%>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>
<style>
	.text-bold-700{
		background-color:rgb(220,220,220);
		padding: 0.2rem;
	}
	.desc{
		padding: 0.2rem;
	}
	.has-error, .has-danger{
    		color:crimson;
    		}
   	.success-msg{
   		color:#3c763d;
   		display:none;
   		line-height:1.8;
</style>


<meta charset="UTF-8">

<title>요청 정보</title>
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
	<div class="row match-height">
		<div class="col-xs-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title">요청 정보</h4>
				</div>
				<div class="card-body">
					<div class="card-block">
						<h5 class="form-section text-bold-600">피아노 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" >브랜드</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getBrand()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">일련번호</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getSerial()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">피아노 타입</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPiano_type()).equals("0")?"업라이트" : "그랜드"%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">용도</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getPlayer_type()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">마지막 조율 날짜</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class=" border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getLast_tuned_date()).equals("") ? "모름" : CmmUtil.nvl(pDTO.getLast_tuned_date()).substring(0,10)%></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-3 text-xs-left text-sm-center text-bold-700">주소</div>
									<%if(user_type.equals("1")){ %>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc"><%=CmmUtil.nvl(rDTO.getSido_name()) %> <%=CmmUtil.nvl(rDTO.getSgg_name()) %></div>
									<%}else{ %>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getAddr()) %></div>
									<%} %>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-3 text-xs-left text-sm-center text-bold-700">사진</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="  border col-xs-9 desc">asd</div>
									
							</div>
							</div>
						
					</div>
					
					<div class="card-block">
						<h5 class="form-section text-bold-600">요청서 정보</h5>
						<div class="piano-table col-xs-12 border" style="border-color:rgb(150,150,150);">
							<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700" >요청사항</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;"class="border col-xs-9 desc"><%=CmmUtil.nvl(rDTO.getReq_content()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">참고사진</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc"><%=CmmUtil.nvl(pDTO.getSerial()) %></div>
								</div>
								<div class="row" style="display:flex;">
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-3 text-xs-left text-sm-center text-bold-700">가능일시</div>
									<div style="border-color:rgb(150,150,150);padding:0.5rem;" class="border col-xs-9 desc">
									<%
									String s = null;
									for(Iterator<String> keyIter = prefDates.keySet().iterator();keyIter.hasNext();){
										s = keyIter.next();
										List<String> hours = prefDates.get(s);
										Date d = new SimpleDateFormat("yyyy-M-dd").parse(s);
										Calendar c = Calendar.getInstance();
										c.setTime(d);
										int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
									%>
									<%=s %>(<%=weekdays[dayOfWeek-1] %>) : <br>
									&nbsp;&nbsp;- <%=String.join(":00, ", hours)%>:00<br><%if(keyIter.hasNext()){ %><br><%} %>
									<%} %>
									</div>
								</div>
							</div>
						
					</div>
				</div>
				<form method="post" hidden="hidden" name="req_action">
					<input value="<%=rDTO.getReq_seq() %>" name="req_seq">
					<input value="<%=rDTO.getReq_type() %>" name="req_type">
				</form>
				<div class="card-footer text-xs-center">
					<span>
					<%if(user_type.equals("0")){ %>
						<a href="<%=back %>.do" class="button btn btn-info">뒤로 </a>
						<button onclick="editReq()" class="button btn btn-success">수정 </button>
						<button onclick="deleteConfirm()" class="button btn btn-danger">삭제</button>
					<%}else{ %>
						<a href="<%=back %>.do" class="button btn btn-info">뒤로 </a>
					<%} %>
					</span>
				</div>
			</div>
		</div>
	</div>
	<%if(rDTO.getReq_type().equals("0") && user_type.equals("0")) {%>
	<div class="row">
		<div class="col-xs-12 col-lg-6 offset-lg-3">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title" id="basic-layout-form">입찰 현황</h4>
				</div>
			</div>
		</div>
	</div>
	<%}else if(user_type.equals("1")){%>
		<div class="row">
					<div class="col-xs-12 col-lg-6 offset-lg-3">
					<div class="card">
				<div class="card-header">
					<h4 class="card-title" id="basic-layout-form">견적서 작성</h4>
				</div>
				<div class="card-body collapse in">
					<div class="card-block">
					<form onsubmit="return submitBid();" data-toggle="validator" role="form" name="regForm" class="form" action="/deal/PlaceBid.do" method="post" autocomplete="off">
							<input hidden="hidden" id="req_content" name="req_content">
							<input value="<%=rDTO.getReq_seq() %>" name="req_seq" hidden>
							<div class="form-body">
								<div class="form-group has-feedback">
									<label for="req_content">소견</label>
									<textarea id="temp_content" rows="10" class="form-control" placeholder="요청사항을 입력해주세요" required></textarea>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
							</div>
							<div id="date-group has-feedback">
									<div class="form-group" style="margin-bottom:0" >
									<label>희망일시<span class="red">*</span></label>
									<div>
									<%
									String ss = null;
									for(Iterator<String> keyIter = prefDates.keySet().iterator();keyIter.hasNext();){
										ss = keyIter.next();
										List<String> hours = prefDates.get(ss);
										Date d = new SimpleDateFormat("yyyy-M-dd").parse(ss);
										Calendar c = Calendar.getInstance();
										c.setTime(d);
										int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
									%>
									<div class="card-text full-date text-bold-600"><%=ss %>(<%=weekdays[dayOfWeek-1] %>)</div>
									<div class="row">
									<%for(String hour : hours){ %>
										<div class="col-xs-3">
										<label class="checkbox-inline"><input type="radio" name="pref_date" class="pref-hour" value="<%=ss %>h<%=hour%>"><%=hour %>:00</label>
										</div>
									<%} %>
									</div>
									<%if(keyIter.hasNext()){ %><hr style="margin:0 0 0.5rem 0"><%} %>
									<%} %>
									</div>
									</div>

		
								<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
								<div class="help-block with-errors"></div>
								</div>
							
							<div class="card-footer text-xs-center">
								<a href="<%=back %>.do" class="button btn btn-info">뒤로 </a>
								<button type="submit" class="button btn btn-success">입찰하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
					</div>
			</div>
	<%} %>
</section>
<!-- Header footer section end -->

        </div>
	</div>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
	
	
	<script>
	<%if(user_type.equals("2") || user_seq.equals(rDTO.getUser_seq())){%>
	function deleteConfirm(){
		if(confirm("요청서를 삭제하시겠습니까?")){
			var form = document.req_action;
			form.action = "/req/DeleteReq.do";
			form.submit();
		}
	}
	
	function editReq(){
		var form = document.req_action;
		form.action = "/req/EditReq.do";
		form.submit();
	}
	
	<%}%>
	<%if(user_type.equals("1")){%>
	function submitBid(){
		var checklen = document.querySelectorAll('.pref-hour:checked').length;
		if(checklen==0){
			alert("최소 하나의 희망일시는 선택해야 합니다.");
			return false;
		}
		
		$("#req_content").val(document.getElementById('temp_content').value.replace(/\n/g, "<br>"));
		$("#req_title").val($("#req_title").val().replace(/<br>/g, " "));
	}
	
	<%}%>
	
	</script>
</body>
</html>