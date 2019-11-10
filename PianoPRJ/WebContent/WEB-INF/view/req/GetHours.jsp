<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="poly.dto.SggDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String date = (String)request.getAttribute("date");
	Date d = new SimpleDateFormat("yyyy-M-dd").parse(date);
	Calendar c = Calendar.getInstance();
	c.setTime(d);
	int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
	String[] weekdays = {"일", "월", "화", "수", "목", "금", "토"};
	
%>
<div class="date-option">
<hr>
<div class="card-text full-date text-bold-600"><%=date %>(<%=weekdays[dayOfWeek-1] %>)</div>
	<div class="row">
		<div class="col-xs-3">
		<label class="checkbox-inline"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h10">10시</label>
		</div>
		<div class="col-xs-3">
		<label class="checkbox-inline"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h11">11시</label>
		</div>
		<div class="col-xs-3">
		<label class="checkbox-inline"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h12">12시</label>
		</div>
		<div class="col-xs-3">
		<label class="checkbox-inline"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h13">13시</label>
		</div>
	</div>
		<div class="row">
		<div class="col-xs-3">
		<label class="checkbox-inline"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h14">14시</label>
		</div>
		<div class="col-xs-3">
		<label class="checkbox-inline"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h15">15시</label>
		</div>
		<div class="col-xs-3">
		<label class="checkbox-inline"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h16">16시</label>
		</div>
		<div class="col-xs-3">
		<label class="checkbox-inline"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h17">17시</label>
		
		</div>
		<div class="col-xs-12">
		<button type="button" class="btn btn-danger btn-sm float-xs-right" onclick="delDate(this);">
			<i class="icon-cross2"></i> 날짜 삭제
		</button>
	</div>
	
	
	</div>
	
</div>