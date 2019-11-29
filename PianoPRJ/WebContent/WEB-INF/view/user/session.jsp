<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_seq = CmmUtil.nvl((String)session.getAttribute("user_seq"));
	String user_type = CmmUtil.nvl((String)session.getAttribute("user_type"));
	String user_nick = CmmUtil.nvl((String)session.getAttribute("user_nick"));
	Integer user_state = (Integer)session.getAttribute("user_state");
%>
<%if(CmmUtil.nvl(user_seq).equals("")){ %>
<script>
alert("세션이 만료되었습니다.");
location.href = "/index.do";
</script>
<%}%>