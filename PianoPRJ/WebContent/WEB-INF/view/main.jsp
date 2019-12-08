<%@page import="poly.dto.TunerDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.DealDTO"%>
<%@page import="poly.dto.MainDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%
	MainDTO mDTO = (MainDTO)request.getAttribute("mDTO");
	List<DealDTO> dList = (List<DealDTO>)request.getAttribute("dList");
	List<TunerDTO> tList = (List<TunerDTO>)request.getAttribute("tList");
	String reject_reason = (String)request.getAttribute("reject_reason");
%>
<!DOCTYPE html>

<html lang="en" data-textdirection="ltr" class="loading">
<head>
<style>
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
		padding: 10px;
		border-bottom : 2px solid rgb(200,200,200);
		border-top : 1px solid rgb(200,200,200);
	}
	.table-cell {
	  display: table-cell;
	  padding: 10px;
	  border-bottom: 1px solid lightgray;
	}
	.item:hover{
		background-color:rgb(240,240,240);
	}
</style>
<%@ include file="./user/session.jsp" %>
<meta charset="UTF-8">
<title>페이지 타이틀</title>
<!-- header.jsp 경로 설정 -->
<%@ include file="header.jsp" %>
</head>
<body  data-open="click" data-menu="vertical-menu" data-col="2-columns" class="vertical-layout vertical-menu 2-columns  fixed-navbar">
	<!-- menu.jsp 경로설정 -->
	<%@ include file="menu.jsp" %>
	
	
<!-- 조율사 메인 -->
<%if(user_type.equals("1")){
	if(user_state==1){%>
	
	<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
        </div>
        <div class="content-body"><!-- stats -->
<div class="row">
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/req/TunerPublicReqList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="pink"><%=mDTO.getNear_request() %>건</h3>
                            <span>내 주변 요청</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-bag2 pink font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/req/TunerPrivateReqList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="teal"><%=mDTO.getPrivate_request() %>건</h3>
                            <span>1:1 요청</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-user1 teal font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/deal/TunerDealList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="deep-orange"><%=mDTO.getOngoing_deals() %>건</h3>
                            <span>진행중인 거래</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-diagram deep-orange font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/myPage/MyRepu.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="cyan"><%=mDTO.getRepu() %>점</h3>
                            <span>내 평판</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-ios-help-outline cyan font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row match-height">
    <div class="col-xl-12 col-lg-12">
        <div class="card" id="list-container">
            <div class="card-header">
                <h4 class="card-title" id="schedule-list-title">다가오는 일정</h4>
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
                            <%
                            int i = 0;
                            DealDTO dDTO = null;
                            for(Iterator<DealDTO> it = dList.iterator(); it.hasNext() && i < 5; i++){
                            	dDTO = it.next();
                            	%>
                            <div class="table-row item" role="button" onclick="location.href='/deal/TunerDealDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>&back=main'">
                                    <div class="table-cell"><%=dDTO.getDeal_seq() %></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(dDTO.getRequester_nick()) %></div>
                                    <div class="table-cell"><%=dDTO.getTotal() %>원</div>
                                    <div class="table-cell"><%=dDTO.getFullDate() %></div>
                            </div>
                            <%} %>
                        </div>
                        <div class="card-text text-xs-center" id="no-schedule"><%if(dList.size()==0) {%>- 조율 일정이 없습니다 - <%} %></div>
                </div>
                <div class="card-block">
                    <p><span class="float-xs-right"><a href="/myPage/TunerSchedule.do">조율 일정 <i class="icon-arrow-right2"></i></a></span></p>
                </div>
            </div>
            
        </div>
    </div>
</div>
<!-- Recent invoice with Statistics -->


        </div>
      </div>
    </div>
    <%}else{ %>
	<div class="app-content content container-fluid">
		<div class="content-wrapper">
			<div class="content-header row"></div>
			<div class="content-body">
				<!-- stats -->
				<div class="row">
					<div class="text-xs-center" style="color: rgb(100, 100, 100)">
						<div>
							<i class="icon-android-alert" style="font-size: 10rem;"></i>
						</div>
						<%if(user_state==0){ %>
						<div style="font-size: 1.5rem;">가입 미승인 조율사입니다.<br>승인 이후 서비스를 사용하실 수 있습니다.</div>
						<%}else{ %>
						<div style="font-size: 1.5rem;">가입 요청이 반려되었습니다.</div>
						<div style="font-size: 1.5rem;">개인정보 수정을 통해 다시 요청할 수 있습니다.</div>
						<div style="font-size: 1.2em;">반려사유 : <%=CmmUtil.nvl(reject_reason, true) %></div>
						<%} %>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%} %>
<%}else if(user_type.equals("0")){%>
<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
        </div>
        <div class="content-body"><!-- stats -->
<div class="row">
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/req/UserPublicReqList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="pink"><%=mDTO.getNew_bids() %>건</h3>
                            <span>새 입찰</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-bag2 pink font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/req/UserPrivateReqList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="teal"><%=mDTO.getPrivate_estimates() %>건</h3>
                            <span>1:1 견적</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-user1 teal font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/deal/UserDealList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="deep-orange"><%=mDTO.getOngoing_deals() %>건</h3>
                            <span>진행중인 거래</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-diagram deep-orange font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/deal/UserDealList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="cyan"><%=mDTO.getPending_deal() %>건</h3>
                            <span>완료대기 거래</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-ios-help-outline cyan font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row match-height">
    <div class="col-xl-12 col-lg-12">
        <div class="card" id="list-container">
            <div class="card-header">
                <h4 class="card-title" id="schedule-list-title">다가오는 일정</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                        <div class="table">
                            <div class="table-row">
									<div class="table-head-cell"><strong>거래번호</strong></div>
                                    <div class="table-head-cell"><strong>조율사 성함</strong></div>
                                    <div class="table-head-cell"><strong>견적가</strong></div>
                                    <div class="table-head-cell"><strong>일시</strong></div>
                            </div>
                            <%
                            int i = 0;
                            DealDTO dDTO = null;
                            for(Iterator<DealDTO> it = dList.iterator(); it.hasNext() && i < 5; i++){
                            	dDTO = it.next();
                            	%>
                            <div class="table-row item" role="button" onclick="location.href='/deal/UserDealDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>&back=main'">
                                    <div class="table-cell"><%=dDTO.getDeal_seq() %></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(dDTO.getTuner_name()) %></div>
                                    <div class="table-cell"><%=dDTO.getTotal() %>원</div>
                                    <div class="table-cell"><%=dDTO.getFullDate() %></div>
                            </div>
                            <%} %>
                        </div>
                        <div class="card-text text-xs-center" id="no-schedule"><%if(dList.size()==0) {%>- 조율 일정이 없습니다 - <%} %></div>
                </div>
                <div class="card-block">
                    <p><span class="float-xs-right"><a href="/myPage/TunerSchedule.do">조율 일정 <i class="icon-arrow-right2"></i></a></span></p>
                </div>
            </div>
            
        </div>
    </div>
</div>
<!-- Recent invoice with Statistics -->


        </div>
      </div>
    </div>
<%}else{ %>
<div class="app-content content container-fluid">
      <div class="content-wrapper">
        <div class="content-header row">
        </div>
        <div class="content-body"><!-- stats -->
<div class="row">
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/deal/DealList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="pink"><%=mDTO.getSuccess_deals() %>건</h3>
                            <span>성사된 거래</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-bag2 pink font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/user/UserList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="teal"><%=mDTO.getNew_users() %>명</h3>
                            <span>신규 가입</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-user1 teal font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/review/ReviewList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="deep-orange"><%=mDTO.getNew_reviews() %>건</h3>
                            <span>신규 리뷰</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-diagram deep-orange font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-xs-12">
        <div class="card item" role="button" onclick="location.href='/user/PendingTunerList.do'">
            <div class="card-body">
                <div class="card-block">
                    <div class="media">
                        <div class="media-body text-xs-left">
                            <h3 class="cyan"><%=mDTO.getPending_tuner() %>건</h3>
                            <span>조율사 가입요청</span>
                        </div>
                        <div class="media-right media-middle">
                            <i class="icon-ios-help-outline cyan font-large-2 float-xs-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row match-height">
    <div class="col-xl-12 col-lg-12">
        <div class="card" id="list-container">
            <div class="card-header">
                <h4 class="card-title" id="schedule-list-title">승인대기 조율사 목록</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                        <div class="table">
                            <div class="table-row">
									<div class="table-head-cell"><strong>회원번호</strong></div>
                                    <div class="table-head-cell"><strong>이름</strong></div>
                                    <div class="table-head-cell"><strong>기술등급</strong></div>
                                    <div class="table-head-cell"><strong>가입일</strong></div>
                            </div>
                            <%for(TunerDTO tDTO : tList){ %>
                            <div class="table-row item" role="button" onclick="location.href='/user/PendingTunerDetail.do?tuner_seq=<%=tDTO.getTuner_seq()%>'">
                                    <div class="table-cell"><%=CmmUtil.nvl(tDTO.getTuner_seq()) %></div>
                                    <div class="table-cell"><%=CmmUtil.nvl(tDTO.getTuner_name()) %></div>
                                    <div class="table-cell"><%=tDTO.getTuner_level().equals("0") ? "기능사" : "산업기사" %></div>
                                    <div class="table-cell"><%=tDTO.getRegdate().substring(0, 10)%></div>
                            </div>
                            <%} %>
                        </div>
                        <div class="card-text text-xs-center" id="no-schedule"><%if(tList.size()==0) {%>- 조율사 가입 요청이 없습니다 - <%} %></div>
                </div>
                <div class="card-block">
                    <p><span class="float-xs-right"><a href="/user/PendingTunerList.do">더보기 <i class="icon-arrow-right2"></i></a></span></p>
                </div>
            </div>
            
        </div>
    </div>
</div>
<div class="row match-height">
    <div class="col-xl-12 col-lg-12">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title" id="schedule-list-title">서비스 시세</h4>
                <a class="heading-elements-toggle"><i class="icon-ellipsis font-medium-3"></i></a>
            </div>
            <div class="card-body collapse in">
                <div class="card-block card-dashboard">
                <div id="chartdiv" style="width:100%;height:600px"></div>
                </div>
            </div>
            
        </div>
    </div>
</div>
<!-- Recent invoice with Statistics -->


        </div>
      </div>
    </div>
<%} %>
<!-- 조율사 메인 끝 -->
	
	
	
	
	
	<!-- footer.jsp 경로설정 -->
	<%@include file="footer.jsp" %>
	<script src="//www.amcharts.com/lib/4/core.js"></script>
	<script src="//www.amcharts.com/lib/4/charts.js"></script>
	<%if(user_type.equals("2")){ %>
	<script type="text/javascript">
	window.onload = function(){
		var obj;
		
		$.ajax({
			url:"/price/GetMarketPrice.do",
			type:"post",
			success:function(data){
				obj = data;
				for(var i=0; i<obj.length; i++){
					obj[i].deal_date = new Date(obj[i].deal_date);
				}
				

				// Create chart instance
				var chart = am4core.create("chartdiv", am4charts.XYChart);
				chart.paddingRight = 20;

				// Add data
				chart.data = obj;
				
				// Create axes
				var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
				dateAxis.renderer.minGridDistance = 50;
				dateAxis.renderer.grid.template.location = 0.5;
				dateAxis.startLocation = 0.5;
				dateAxis.endLocation = 0.5;
				dateAxis.dateFormats.setKey("day", "MM/dd");
				dateAxis.dateFormatter = new am4core.DateFormatter();
				
				// Create value axis
				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.numberFormatter = new am4core.NumberFormatter();
				valueAxis.numberFormatter.numberFormat = "#,###원"; 
				
				//Create series
				var tuningSeries = chart.series.push(new am4charts.LineSeries());
				tuningSeries.name = "조율";
				tuningSeries.dataFields.valueY = "tuning_avg";
				tuningSeries.dataFields.dateX = "deal_date";
				tuningSeries.strokeWidth = 3;
				tuningSeries.tensionX = 0.8;
				tuningSeries.tooltipText = "조율 : {tuning_avg.formatNumber('#,###원')}";
				tuningSeries.tooltip.pointerOrientation = "vertical";
				tuningSeries.stroke = am4core.color("#4272f5");
				tuningSeries.tooltip.getFillFromObject = false;
				tuningSeries.tooltip.background.fill = am4core.color("#4272f5");

				var regulSeries = chart.series.push(new am4charts.LineSeries());
				regulSeries.name = "조정";
				regulSeries.dataFields.valueY = "regul_avg";
				regulSeries.dataFields.dateX = "deal_date";
				regulSeries.strokeWidth = 3;
				regulSeries.tensionX = 0.8;
				regulSeries.stroke = am4core.color("#f55d42");
				regulSeries.tooltipText = "조정 : {regul_avg.formatNumber('#,###원')}";
				regulSeries.tooltip.getFillFromObject = false;
				regulSeries.tooltip.background.fill = am4core.color("#f55d42");

				var voicingSeries = chart.series.push(new am4charts.LineSeries());
				voicingSeries.name= "정음";
				voicingSeries.dataFields.valueY = "voicing_avg";
				voicingSeries.dataFields.dateX = "deal_date";
				voicingSeries.strokeWidth = 3;
				voicingSeries.tensionX = 0.8;
				voicingSeries.stroke = am4core.color("#26bd00");
				voicingSeries.tooltipText = "정음 : {voicing_avg.formatNumber('#,###원')}";
				voicingSeries.tooltip.getFillFromObject = false;
				voicingSeries.tooltip.background.fill = am4core.color("#26bd00");

				var transportSeries = chart.series.push(new am4charts.LineSeries());
				transportSeries.name = "운반"
				transportSeries.dataFields.valueY = "transport_avg";
				transportSeries.dataFields.dateX = "deal_date";
				transportSeries.strokeWidth = 3;
				transportSeries.tensionX = 0.8;
				transportSeries.stroke = am4core.color("#bd00a4");
				transportSeries.tooltipText = "운반 : {transport_avg.formatNumber('#,###원')}";
				transportSeries.tooltip.getFillFromObject = false;
				transportSeries.tooltip.background.fill = am4core.color("#bd00a4");
		
				chart.legend = new am4charts.Legend();
				chart.cursor = new am4charts.XYCursor();
				
			}
		});
		
	}
	</script>
	<%} %>
</body>
</html>