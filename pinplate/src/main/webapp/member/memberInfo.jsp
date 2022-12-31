<%@page import="java.sql.SQLException"%>
<%@page import="com.member.model.memberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../login/checkLogin.jsp" %>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%
	//세션정보 읽어오기
	String mem_id=(String)session.getAttribute("mem_id");
	//2
	memberVO vo= null;
	try{
		vo=memberService.selectByUserid(mem_id);
	}catch(SQLException e){
		e.printStackTrace();
	}
	int mem_no=vo.getMem_no();
	String mem_name=vo.getMem_name();
	String mem_ssn=vo.getMem_ssn();
	String mem_addr=vo.getMem_addr();
	String mem_tel=vo.getMem_tel();
	String mem_email=vo.getMem_email();
	if(mem_email==null || mem_email.isEmpty()){
		mem_email=" ";
	}
	String mem_ssn1=mem_ssn.substring(0, 6);
%>

<%@ include file="/inc/Top.jsp"%>
<main class="mainDiv">
	<div class="mainDivGr2">
		<form name="frm1" method="post" action="<%=request.getContextPath() %>/member/memberEdit.jsp">
			<p class="p c">회원 정보</p>
			<input type="hidden" name="mem_no" id="mem_no" value="<%=mem_no %>">
			
		    <div style="overflow:hidden;border-top:1px solid gray;border-bottom:1px solid lightgray;">        
		        <div class="sp1">이름</div>
		        <div class="sp2"><%=mem_name %></div>
		    </div>
		    
		    <div style="overflow:hidden;border-bottom:1px solid lightgray;">        
		        <div class="sp1">아이디</div>
		        <div class="sp2"><%=mem_id %></div>
		    </div>
		    
		    <div style="overflow:hidden;border-bottom:1px solid lightgray;">        
		        <div class="sp1">주민등록번호</div>
		        <div class="sp2"><%=mem_ssn1 %>-*******</div>
		    </div>

			<div style="overflow:hidden;border-bottom:1px solid lightgray;">        
		        <div class="sp1">주소</div>
		        <div class="sp2"><%=mem_addr %></div>
		    </div>
	
			<div style="overflow:hidden;border-bottom:1px solid lightgray;">        
		        <div class="sp1">연락처</div>
		        <div class="sp2"><%=mem_tel %></div>
		    </div>
		    
		    <div style="overflow:hidden;border-bottom:1px solid gray;">
		    	<div class="sp1">이메일</div>
		        <div class="sp2"><%=mem_email %></div>
		    </div>

		    <div style="margin-top: 10px;">
		         <input type="submit" value="회원정보 수정" id="edit"
					class="btn btn-sm btn-block loginBt mt-1"> 				
		         <input type="button" value="회원탈퇴" id="unregister"
					onClick="location.href='<%=request.getContextPath() %>/member/memberUnregister.jsp'"
					class="btn btn-sm btn-block regist mt-2">
		    </div>
		</form>
	</div>
</main>

<%@ include file="/inc/Bottom.jsp"%>