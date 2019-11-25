<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- session.jsp 경로 설정 -->
<%@ include file="/WEB-INF/view/user/session.jsp" %>
<!DOCTYPE html>
<html lang="en" data-textdirection="ltr" class="loading">
<head>
<link rel="stylesheet" type="text/css" href="/css/hello.week.min.css" />
<link rel="stylesheet" type="text/css" href="/css/hello.week.theme.min.css" />
<script type="text/javascript" src="/js/hello.week.min.js"></script>
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
		<div class="col-xs-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title">조율 일정</h4>
				</div>
				<div class="card-body">
					<div class="card-block">
						<div class="hello-week">
						    <div class="navigation">
						        <button class="prev">Prev</button>
						        <div class="period"></div>
						        <button class="next">Next</button>
						    </div>
						    <div class="week"></div>
						    <div class="month"></div>
						</div>
					</div>					
				</div>
			</div>
		</div>
	</div>
	
	
		
	</div>
	</div>
	</div>
	<script type="text/javascript">
	new HelloWeek({
	    selector: '.hello-week',
	    lang: 'en',
	    langFolder: '/js/',
	    format: 'DD/MM/YYYY',
	    weekShort: true,
	    monthShort: false,
	    multiplePick: false,
	    defaultDate: null,
	    todayHighlight: true,
	    disablePastDays: false,
	    disabledDaysOfWeek: null,
	    disableDates: null,
	    weekStart: 0, // week start on Sunday
	    daysHighlight: null,
	    daysSelected: null,
	    range: false,
	    rtl: false,
	    locked: false,
	    minDate: null,
	    maxDate: null,
	    nav: ['◀', '▶'],
	    onLoad: () => { /** callback function */ },
	    onChange: () => { /** callback function */ },
	    onSelect: () => { /** callback function */ },
	    onClear: () => { /** callback function */ }
	});
	</script>
	<!-- footer.jsp 경로설정 -->
	<%@include file="/WEB-INF/view/footer.jsp" %>
</body>
</html>