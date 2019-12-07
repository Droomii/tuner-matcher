<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
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
	Map<String, String> weatherMap = (Map<String, String>)request.getAttribute("weatherMap");
	Set<String> dateSet = weatherMap.keySet();
	
%>
<div class="date-option">
<hr>
<div class="card-text full-date text-bold-600 <%=date%>"><%=date %>(<%=weekdays[dayOfWeek-1] %>)</div>
	<div class="row">
	<%for(int i=10;i<14;i++) {
		String value = date + "h" + Integer.toString(i);
	%>
		<div class="col-xs-3">
		<%if(dateSet.contains(value) && !weatherMap.get(value).equals("0")){%>
		<label class="checkbox-inline" data-toggle="tooltip" data-placement="right" data-original-title="강수 확률 : <%=weatherMap.get(value)%>%"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h<%=i%>"><%=i%>시&nbsp;<i class="icon-rainy4" style="color:skyblue;"></i></label>
		<%}else{ %>
		<label class="checkbox-inline"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h<%=i%>"><%=i%>시</label>
		<%} %>
		</div>
	<%} %>
	</div>
	<div class="row">
	<%for(int i=14;i<18;i++) {
		String value = date + "h" + Integer.toString(i);
	%>
		<div class="col-xs-3">
		<%if(dateSet.contains(value) && !weatherMap.get(value).equals("0")){%>
		<label class="checkbox-inline" data-toggle="tooltip" data-placement="right" data-original-title="강수 확률 : <%=weatherMap.get(value)%>%"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h<%=i%>"><%=i%>시&nbsp;<i class="icon-rainy4" style="color:skyblue;"></i></label>
		<%}else{ %>
		<label class="checkbox-inline"><input type="checkbox" name="pref_date" class="pref-hour" value="<%=date%>h<%=i%>"><%=i%>시</label>
		<%} %>
		</div>
	<%} %>
		<div class="col-xs-12">
			<button type="button" class="btn btn-danger btn-sm float-xs-right" onclick="delDate(this);">
				<i class="icon-cross2"></i> 날짜 삭제
			</button>
		</div>
	</div>
	
</div>