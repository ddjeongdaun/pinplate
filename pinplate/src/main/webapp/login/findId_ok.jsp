<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%@ include file="/inc/Top.jsp"%>
<%
	//findId.jsp에서 post방식으로 서브밋
	request.setCharacterEncoding("utf-8");
	
	String mem_name=request.getParameter("mem_name");
	String mem_ssn=request.getParameter("mem_ssn");
	
	String result="";
	try{
		result=memberService.findId(mem_name, mem_ssn);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	if(result==null || result.isEmpty()){
		result="회원정보를 찾을 수 없습니다.";
	}
%>
<main class="mainDiv">
	<div class="mainDivGr">
		<p class="p c">아이디 찾기 결과</p>
		<p class="c strong"><%=result %></p>
		<input type="button" value="비밀번호 찾기"
			onclick="location.href='<%=request.getContextPath() %>/login/findPw.jsp'"
			class="btn btn-sm btn-block loginBt mt-1">	
		<input type="button" value="메인페이지로 이동"
						onClick="location.href='<%=request.getContextPath()%>/index.jsp'"
						class="btn btn-sm btn-block regist mt-2">
	</div>
</main>

<%@ include file="/inc/Bottom.jsp"%>