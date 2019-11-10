<%@page import="poly.dto.SggDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	List<SggDTO> sggList = (List<SggDTO>)request.getAttribute("sggList");
	String sidoCode = (String)request.getAttribute("sidoCode");

%>
	<%if(sggList.size()>1){ %>
	<label class="checkbox-inline col-xs-4 col-md-3"><input type="checkbox" name="sgg_code" class="sgg-detail select-all sido-<%=sidoCode %>" value=<%=sidoCode %> onclick="toggleAll(this);">전체</label>
	    <%for(SggDTO sDTO : sggList){  %>
	    
	    <label class="checkbox-inline col-xs-4 col-md-3"><input onclick="checkAllChecked(this);" type="checkbox" name="sgg_code" class="sgg-detail sub-detail" value=<%=sDTO.getSggCode()%>><%=sDTO.getSggName()%></label>
	    
	    <%}
	}else if(sidoCode.equals("00")){ %>
		<input type="checkbox" name="sgg_code" class="sgg-detail sido-all" value="00" checked hidden>
	<%}else{%>
		<div class="col-xs-4">세부지역 없음</div><label class="checkbox-inline col-xs-4 col-md-3"><input type="checkbox" name="sgg_code" class="sgg-detail" value=<%=sidoCode %> checked hidden></label>
	<%}%>