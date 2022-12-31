<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String adminCheck=(String)session.getAttribute("mem_auth");

	if(!adminCheck.equals("1")){ %>
		<script type="text/javascript">
			alert('이 페이지는 관리자페이지 입니다.');
			location.href="<%=request.getContextPath()%>/login/login.jsp";
		</script>
	<% return; 
	} %>
