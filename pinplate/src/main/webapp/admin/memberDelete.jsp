<%@page import="com.member.model.memberVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="checkAdmin.jsp" %>

<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%
	//memberDetail.jsp에서 get방식
	String mem_no=request.getParameter("no");
	
	//
	memberVO vo = new memberVO();
	try{
		vo=memberService.selectByNo(Integer.parseInt(mem_no));
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<%@ include file="/inc/Top.jsp"%>
	<main class="mainDiv">
		<div class="mainDivGr">
			<p class="p c">회원 삭제</p>
			<form name="frm" method="post" action="memberDelete_ok.jsp">
				<input type="hidden" name="mem_no" id="mem_no" value="<%=mem_no %>">
				회원번호 : <%=mem_no %><br>
				<%=vo.getMem_name() %> 회원님을 삭제하시겠습니까?<br>
				<br>
				<input type="submit" value="삭제" id="edit_submit"
					class="btn btn-sm btn-block loginBt mt-1"> 
				<input type="button" value="취소"
					onclick="history.back()"
					class="btn btn-sm btn-block regist mt-2">
			</form>
		</div>
	</main>
<%@ include file="/inc/Bottom.jsp"%>