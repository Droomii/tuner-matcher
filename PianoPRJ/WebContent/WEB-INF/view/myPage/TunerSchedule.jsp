<%@page import="poly.dto.DealDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<String> rList = (List<String>)request.getAttribute("rList");
	List<DealDTO> dList = (List<DealDTO>)request.getAttribute("dList");
	String selectedFullDate = (String)request.getAttribute("selectedFullDate");
%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>
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
<link rel="stylesheet" type="text/css" href="/css/hello.week.min.css" />
<link rel="stylesheet" type="text/css" href="/css/hello.week.theme.min.css" />
<script type="text/javascript" src="/js/calendar.js"></script>
<meta charset="UTF-8">
<title>페이지 타이틀</title>
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
					<h4 class="card-title">조율 일정</h4>
				</div>
				<div class="card-body">
					<div class="card-block">
						<div class="hello-week">
						    <div class="navigation">
						        <button class="prev button btn-sm btn-secondary">◀</button>
						        <div class="period"></div>
						        <button class="next button btn-sm btn-secondary">▶</button>
						    </div>
						    <div class="week"></div>
						    <div class="month"></div>
						</div>
					</div>					
				</div>
			</div>
		</div>
	</div>
	<div class="row match-height">
		<div class="col-xs-12 col-md-10 offset-md-1 col-lg-8 offset-lg-2">
			<div class="card" id="list-container">
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
                            <div class="table-row item" role="button" onclick="location.href='/deal/TunerDealDetail.do?deal_seq=<%=dDTO.getDeal_seq()%>&back=schedule'">
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
            
        </div>
		</div>
	</div>
	
	
		
	</div>
	</div>
	</div>
	<script type="text/javascript">
	var calendar = new HelloWeek({
	    selector: '.hello-week',
	    lang: 'ko',
	    langFolder: '/js/',
	    format: 'YYYY/MM/DD',
	    weekShort: true,
	    monthShort: false,
	    multiplePick: false,
	    defaultDate: null,
	    todayHighlight: true,
	    disablePastDays: true,
	    disabledDaysOfWeek: null,
	    disableDates: null,
	    weekStart: 0, // week start on Sunday
	    <%if(rList.size()==0){%>
	    daysHighlight: null,
	    <%}else{%>
	    daysHighlight: [
	    	<%for(Iterator<String> it = rList.iterator(); it.hasNext();){%>
	    	{
	    	days: ['<%=it.next()%>'],
            backgroundColor: '#91d1ff'
            <%if(it.hasNext()){%>
	    	},
	    	<%}else{%>
	    	}],
	    	<%}%>
	    <%}%>
	    <%}%>
	    
	    daysSelected: null,
	    range: false,
	    rtl: false,
	    locked: false,
	    minDate: null,
	    maxDate: null,
	    nav: ['◀', '▶'],
	    onLoad: () => { /** callback function */ },
	    onChange: () => { /** callback function */ },
	    onSelect: () => {
	    	var hlDays = [];
	    	for(var i = 0; i<calendar.daysHighlight.length; i++){
	    		hlDays.push(calendar.daysHighlight[i].days[0])
	    	}
	    	var day = calendar.getDays()[0].replace(/\//g, "-");
	    	if(hlDays.includes(day)){
	    		$.ajax({
	    			url:"/myPage/GetDealByDay.do",
	    			type:"post",
	    			data:{date : day},
	    			success:function(data){
	    				if(data==null){
	    					alert('세션이 만료되었습니다.');
	    					location.href = "/index.do";
	    				}else{
	    					$("#list-container").html(data)
	    				}
	    			}
	    		});
	    		
	    	}else{
	    		var d = new Date(day);
	    		var weekday = d.getDay()
	    		var weekdays = ['일', '월', '화', '수', '목', '금', '토'];
	    		$(".item").remove();
	    		$("#no-schedule").text("- 조율 일정이 없습니다 -");
	    		$("#schedule-list-title").text(day + "("+weekdays[weekday] + ") 일정")
	    	}
	    		
	    },
	    onClear: () => { /** callback function */ }
	});
	
	
	
	</script>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
</body>
</html>