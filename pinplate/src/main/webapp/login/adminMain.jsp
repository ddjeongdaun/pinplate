<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/admin/checkAdmin.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>관리자 페이지 - 메인</title>
<%

	String mem_id=(String)session.getAttribute("mem_id");
	String mem_name=(String)session.getAttribute("mem_name");
	String mem_auth=(String)session.getAttribute("mem_auth");

%>
</head>
<body>
<h2>관리자 페이지 입니다.</h2>
mem_id = <%=mem_id %><br>
mem_name = <%=mem_name %><br>
mem_auth = <%=mem_auth %><br>

<input type="button" value="회원관리페이지" onclick="location.href='<%=request.getContextPath()%>/admin/memberList.jsp'">
<input type="button" value="나의 페이지" onclick="location.href='<%=request.getContextPath()%>/member/memberEdit.jsp'">
<input type="button" value="로그아웃" onclick="location.href='<%=request.getContextPath()%>/login/logout.jsp'">

</body>
</html>