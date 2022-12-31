<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../login/checkLogin.jsp" %>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%
	//memberUnregister.jsp에서 post방식
	request.setCharacterEncoding("utf-8");
	//
	String mem_id=(String)session.getAttribute("mem_id");
	//db처리
	
	int cnt=0;
	try{
		cnt=memberService.deleteMember2(mem_id);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String msg="회원 탈퇴 처리 중 오류 발생!", url="memberUnregister.jsp";
	if(cnt>0){
		msg="회원 탈퇴하였습니다.";
		url="../login/logout.jsp";
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="/common/message.jsp"></jsp:forward>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberUnregister_ok.jsp</title>

</head>
<body>
</body>
</html>