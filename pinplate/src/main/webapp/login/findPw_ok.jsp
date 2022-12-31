<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%
	//findPw.jsp에서 post방식 서브밋
	request.setCharacterEncoding("utf-8");

	//
	String mem_id=request.getParameter("mem_id");
	String mem_name=request.getParameter("mem_name");
	String mem_ssn=request.getParameter("mem_ssn");
	String mem_pwd=request.getParameter("mem_pwd");
	
	//
	int cnt=0;
	try{
		cnt=memberService.changePw(mem_id, mem_name, mem_ssn, mem_pwd);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String msg="비밀번호 변경 중 오류 발생!", url="findPw.jsp";
	if(cnt>0){
		msg="비밀번호 변경 성공!";
		url=request.getContextPath()+"/index.jsp";
	}else{
		msg="입력 정보가 잘못되었습니다.";
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
	
%>
<jsp:forward page="/common/message.jsp"></jsp:forward>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>