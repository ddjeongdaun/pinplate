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
	
	String mem_ssn1=mem_ssn.substring(0, 6);
	
	String[] emailList = {"naver.com","hanmail.net","nate.com","gmail.com"};
	boolean isEtc=false;	//true:직접입력
	int cnt=0;
	
	String mem_email=vo.getMem_email();
	String mem_email1="", mem_email2="";
	
	if(mem_email!=null && !mem_email.isEmpty()){	//email이 있을때
		String[] emailArr=mem_email.split("@");
		mem_email1=emailArr[0];
		mem_email2=emailArr[1];
		
		for(int i=0; i<emailList.length; i++){
			if(mem_email2.equals(emailList[i])){
				cnt++;
				break;
			}
		}
		
		if(cnt==0){
			isEtc=true;
		}
	}//if
	
%>

<%@ include file="/inc/Top.jsp"%>

<script type="text/javascript" src="../js/member.js"></script>
<script type="text/javascript">
$(function(){

	$('#edit_submit').click(function(){
		if($('#mem_pwd1').val().length<1){		//비밀번호 미입력
			alert('비밀번호를 입력하세요.');
			$('#mem_pwd1').focus();
			event.preventDefault();
		}else if($('#mem_pwd1').val()!=$('#mem_pwd2').val()){		//비밀번호 미일치
			alert('비밀번호가 일치하지 않습니다.');
			$('#mem_pwd2').focus();
			event.preventDefault();
		}else if(!validate_phone($('#mem_tel2').val()) || !validate_phone($('#mem_tel3').val())){	//전화번호 validate
			alert('전화번호는 숫자만 가능합니다.');
			$('#mem_tel2').focus();
			event.preventDefault();
		}
	});//edit_submit
	
	$("#mem_email2").change(function() {
		if ($("#mem_email2").val() == "etc") {
			$("#mem_email3").val("");
			$("#mem_email3").css("visibility", "visible");
			$("#mem_email3").focus();
		} else {
			$("#mem_email3").css("visibility", "hidden");
		}
	}); //email function

});
</script>

<main class="mainDiv">
	<div class="mainDivGr2">
		<form name="frm1" method="post" action="<%=request.getContextPath() %>/member/memberEdit_ok.jsp">
			<p class="p c">회원 정보 수정</p>
			<input type="hidden" name="mem_no" id="mem_no" value="<%=mem_no %>">
			
		    <div style="overflow:hidden;border-top:1px solid gray;border-bottom:1px solid lightgray;">        
		        <div class="sp1">이름</div>
		        <div class="sp2"><%=mem_name %></div>
		    </div>
		    
		    <div style="overflow:hidden;border-bottom:1px solid lightgray;">        
		        <div class="sp1">아이디</div>
		        <div class="sp2"><%=mem_id %></div>
		    </div>
		    
		    <div style="overflow:hidden;border-bottom:1px solid lightgray;margin-bottom:8px">        
		        <div class="sp1">주민등록번호</div>
		        <div class="sp2"><%=mem_ssn1 %>-*******</div>
		    </div>
		    
		    <input type="password" id="mem_pwd" name="mem_pwd" placeholder="비밀번호를 입력하세요"
					class="form-control inputbox2">
		    
			<input type="password" id="mem_pwd2" name="mem_pwd2" placeholder="비밀번호를 확인을 입력하세요"
					class="form-control inputbox2">
			
			<input type="text" id="mem_addr" name="mem_addr" placeholder="수정할 주소를 입력하세요" value="<%=mem_addr %>"
					class="form-control inputbox2">
		    
			<input type="text" id="mem_tel" name="mem_tel" placeholder="수정할 휴대폰 번호를 입력하세요" value="<%=mem_tel %>"
					class="form-control inputbox2">
		   
		   
		   	<div style="overflow: hidden">
		        <input type="text" name="mem_email1"  id="mem_email1" value="<%=mem_email1 %>"
		        	class="form-control inputbox6" style="float: left">
		        <p style="float: left"> @ </p>
		        <select name="mem_email2" id="mem_email2"
		        	class="form-control inputbox7" style="float: left">
		             <option value="naver.com"
		            	<%if(mem_email2.equals("naver.com")){ %>
		            		selected="selected"
		            	<% } %>
		            >naver.com</option>
		            <option value="hanmail.net"
		            	<%if(mem_email2.equals("hanmail.net")){ %>
		            		selected="selected"
		            	<% } %>
		            >hanmail.net</option>
		            <option value="nate.com"
		            	<%if(mem_email2.equals("nate.com")){ %>
		            		selected="selected"
		            	<% } %>
		            >nate.com</option>
		            <option value="gmail.com"
		            	<%if(mem_email2.equals("gmail.com")){ %>
		            		selected="selected"
		            	<% } %>
		            >gmail.com</option>
		            <option value="etc"
		            	<% if(isEtc){ %>
		            		selected="selected"
		            	<% } %>
		            > 직접입력</option>
		        </select>
		        <input type="text" name="mem_email3" id="mem_email3"
		        	<% if(isEtc){ %>
			        	style="visibility:visible"
		       		 	value="<%=mem_email2 %>"
		        	<% }else{ %>
			        	style="visibility:hidden"
		        	<% } %>
		        class="form-control inputbox6" style="float:right">
		    </div>
		    <div>
		        <input type="submit" value="회원 정보 수정" id="edit_submit"
					class="btn btn-sm btn-block loginBt mt-1"> 
				<input type="button" value="수정 취소"
					onclick="history.back()"
					class="btn btn-sm btn-block regist mt-2">
		    </div>
		</form>
	</div>
</main>
<%@ include file="/inc/Bottom.jsp"%>