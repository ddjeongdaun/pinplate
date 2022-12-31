<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.logging.SimpleFormatter"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.member.model.memberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../login/checkLogin.jsp" %>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%
	//memberList.jsp에서 get방식으로
	
	String mem_no=request.getParameter("no");
	
	memberVO vo= null;
	try{
		vo=memberService.selectByNo(Integer.parseInt(mem_no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String mem_name=vo.getMem_name();
	String mem_id=vo.getMem_id();
	String mem_ssn=vo.getMem_ssn();
	String mem_addr=vo.getMem_addr();
	String mem_tel=vo.getMem_tel();
	String mem_use=vo.getMem_use();
	Timestamp mem_regdate=vo.getMem_regdate();
	
	String mem_email=vo.getMem_email();
	
	String mem_ssn1=mem_ssn.substring(0, 6);
	mem_ssn=mem_ssn1+"-*******";
	
	String[] emailList={"naver.com","hanmail.net","nate.com","gmail.com"};
	boolean isEtc=false;
	int count=0;
	
	String mem_email1="";
	String mem_email2="";
	
	if(mem_email==null || mem_email.isEmpty()){
		mem_email=" ";
	}else{
		String[] email = mem_email.split("@");
		mem_email1=email[0];
		mem_email2=email[1];
		
		for(int i=0;i<emailList.length;i++){
			if(mem_email2.equals(emailList[i])){
				count++;	
				break;
			}
			if(count==0){
				isEtc=true;
			}
		}
	}
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
%>
<%@ include file="/inc/Top.jsp"%>
<script type="text/javascript">
$(function(){
	
	$("#mem_email2").change(function() {
			if ($("#mem_email2").val() == "etc") {
				$("#mem_email3").val("");
				$("#mem_email3").css("visibility", "visible");
				$("#mem_email3").focus();
			} else {
				$("#mem_email3").css("visibility", "hidden");
			}
		});

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
		    
		    <div style="overflow:hidden;border-bottom:1px solid gray;margin-bottom:8px">        
		        <div class="sp1">주민등록번호</div>
		        <div class="sp2"><%=mem_ssn1 %>-*******</div>
		    </div>
		    
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
		            		selected="selected">
		            	<% } %>
		            >직접입력</option>
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
         	<input type="submit" value="수정" id="edit_submit"
					class="btn btn-sm btn-block loginBt mt-1"> 
					
         	<input type="button" id="deleteMember" value="회원 삭제"
         		onclick="location.href='memberDelete.jsp?no=<%=mem_no%>'"
         		class="btn btn-sm btn-block regist mt-2">
         
			<input type="button" value="취소"
					onclick="history.back()"
					class="btn btn-sm btn-block regist mt-2">
    		</div>	
		</form>
	</div>
</main>

<%@ include file="/inc/Bottom.jsp"%>