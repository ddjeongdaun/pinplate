<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="checkAdmin.jsp" %>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	
	String mem_no=request.getParameter("mem_no");
	
	int cnt=0;
	try{
		cnt=memberService.deleteMember(Integer.parseInt(mem_no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String msg="회원 수정 중 오류 발생!", url="memberDetail.jsp?no="+mem_no;
	if(cnt>0){
		msg="회원 삭제 성공";
		url="memberList.jsp";
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>