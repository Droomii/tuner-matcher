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
	String userTypeName = user_type.equals("0") ? "User" : "Tuner";
	ReqDTO rDTO = (ReqDTO)request.getAttribute("rDTO");
	Map<String, List<String>> prefDates = (LinkedHashMap<String, List<String>>)request.getAttribute("prefDates");
	String[] weekdays = {"일", "월", "화", "수", "목", "금", "토"}; 
	String deal_seq = (String)request.getAttribute("deal_seq");
	String prev_date = (String)request.getAttribute("prev_date");
	
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
</style>


<meta charset="UTF-8">

<title>일정 변경 요청</title>
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
					<h4 class="card-title" id="basic-layout-form">일정 변경 요청</h4>
				</div>
				<div class="card-body collapse in">
					<div class="card-block">
					<form onsubmit="return submitReschedule();" autocomplete="off" data-toggle="validator" role="form" name="rescheduleForm" class="form" action="/deal/RescheduleProc.do" method="post" autocomplete="off">
							<input hidden="hidden" id="chg_reason" name="chg_reason">
							<input value="<%=deal_seq %>" name="deal_seq" hidden>
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
										<label class="checkbox-inline"><input type="radio" name="chg_date" class="pref-hour" value="<%=ss %>h<%=hour%>" <%=String.format("%sh%s", ss, hour).equals(prev_date) ? "disabled" : ""%>><%=hour %>:00</label>
										</div>
									<%} %>
									</div>
									<hr style="margin:0 0 0.5rem 0">
									<%} %>
									</div>
									</div>
								<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
								<div class="help-block with-errors"></div>
								</div>
							<%if(!user_type.equals("2")){ %>
							<div class="form-body">
								<div class="form-group has-feedback">
									<label for="temp_content">변경사유<span class="red">*</span></label>
									<textarea id="temp_content" rows="10" class="form-control" placeholder="사유을 입력해주세요" required></textarea>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
									<div class="help-block with-errors"></div>
								</div>
															
							</div>
							<p class="card-text" style="color:crimson">
							주의 : <%=user_type.equals("0") ? "조율사가" : "고객이"%> 거절할 경우 변경이 되지 않습니다.
							</p>
							<%} %>
							<div class="card-footer text-xs-center">
								<a href="/deal/<%=user_type.equals("0") ? "User" : "Tuner" %>DealDetail.do?deal_seq=<%=deal_seq %>" class="button btn btn-info">뒤로 </a>
								<button type="submit" class="button btn btn-success"><%=user_type.equals("2") ? "변경" : "변경 요청"%></button>
							</div>
						</form>
					</div>
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
	
	
	<script>
	function submitReschedule(){
		var checklen = document.querySelectorAll('.pref-hour:checked').length;
		if(checklen==0){
			alert("변경일시를 선택해주세요.");
			return false;
		}
		<%if(!user_type.equals("2")){%>
		if($("#temp_content").val().trim()==""){
			alert("변경사유를 입력해주세요.")
			return false;
		}
		<%}%>
		if(!confirm("날짜변경을 요청하시겠습니까?")){
			return false;
		}
		<%if(!user_type.equals("2")){%>
		$("#chg_reason").val(document.getElementById('temp_content').value.trim().replace(/\n/g, " "));
		<%}%>
	}
	
	</script>
	<script src="/resources/js/validator.js" type="text/javascript"></script>
	<script src="/resources/js/bytechecker.js" type="text/javascript"></script>
</body>
</html>