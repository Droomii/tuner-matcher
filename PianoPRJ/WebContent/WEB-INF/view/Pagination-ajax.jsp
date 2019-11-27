<%@page import="poly.util.Pagination"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="text-xs-center">
<ul class="pagination">
<%if(pg.getCurRange()!=1){ %>
	<li class="page-item">
		<a class="page-link" data-page="1" aria-label="Previous">
			<span aria-hidden="true">&lt;&lt;</span>
		</a>
	</li>
	<%} %>
<%if(pg.getCurPage()!=1){ %>
	<li class="page-item">
		<a class="page-link" data-page="<%=pg.getPrevPage() %>" aria-label="Previous">
			<span aria-hidden="true">&lt;</span>
			<span class="sr-only">Previous</span>
		</a>
	</li>
	<%} %>
	<%for(int i=pg.getStartPage(); i< pg.getEndPage()+1; i++) {%>
	<li class="page-item <%=pg.getCurPage()==i ?  "active" : ""%>"><a class="page-link" data-page="<%=i%>"><%=i %></a></li>
	<%} %>
	<%if((pg.getCurPage() != pg.getPageCnt()) && (pg.getPageCnt() > 0) ) {%>
	<li class="page-item">
		<a class="page-link" data-page="<%=pg.getNextPage() %>" aria-label="Next">
			<span aria-hidden="true">&gt;</span>
		</a>
	</li>
	<%} %>
	<%if((pg.getCurRange() != pg.getRangeCnt()) && (pg.getRangeCnt() > 0) ) {%>
	<li class="page-item">
		<a class="page-link" data-page="<%=pg.getPageCnt() %>" aria-label="Next">
			<span aria-hidden="true">&gt;&gt;</span>
		</a>
	</li>
	<%} %>
</ul>
</div>
<script></script>