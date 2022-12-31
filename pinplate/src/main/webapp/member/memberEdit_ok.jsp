<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@ include file="../login/checkLogin.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberEdit_ok.jsp</title>
</head>
<body>
<jsp:useBean id="memberService" class="com.member.model.memberService"
	scope="session"></jsp:useBean>
<jsp:useBean id="memberVo" class="com.member.model.memberVO"
	scope="page"></jsp:useBean>
<%
	//memberEdit.jsp에서 post-서브밋
	request.setCharacterEncoding("utf-8");
	
	String mem_id=(String)session.getAttribute("mem_id");
	String mem_no=request.getParameter("mem_no");
	
	String mem_pwd=request.getParameter("mem_pwd");
	String mem_addr=request.getParameter("mem_addr");
	String mem_tel=request.getParameter("mem_tel");
	String mem_email1=request.getParameter("mem_email1");
	String mem_email2=request.getParameter("mem_email2");
	String mem_email3=request.getParameter("mem_email3");
	
	String mem_email="";
	
	if(mem_email1 != null && !mem_email1.isEmpty()) {	//이메일1이 있을때
		if(mem_email2.equals("etc")) {					//이메일2가 직접입력일때
			if(mem_email3 != null && !mem_email3.isEmpty()) {	//직접입력값이 있을때
				mem_email = mem_email1 + "@" + mem_email3;
			}
		}else{
			mem_email = mem_email1 + "@" + mem_email2;
		}
	}
	
	memberVo.setMem_id(mem_id);
	memberVo.setMem_no(Integer.parseInt(mem_no));
	memberVo.setMem_pwd(mem_pwd);
	memberVo.setMem_addr(mem_addr);
	memberVo.setMem_tel(mem_tel);
	memberVo.setMem_email(mem_email);
	
	String msg="회원정보 수정 ERROR", url="memberEdit.jsp";
	int result = memberService.loginCheck(mem_id, mem_pwd);
	
	try{
		if(result==memberService.LOGIN_OK){
			int cnt=memberService.updateMember(memberVo);
			if(cnt>0){
				msg="회원정보 수정 성공!";
				url="memberInfo.jsp";
			}else{
				msg="회원정보 수정 실패!";
			}
		}else if(result==memberService.WRONG_PW){
			msg="비밀번호가 틀렸습니다.";
		}
	}catch(SQLException e){
	   e.printStackTrace();
	}
		
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="/common/message.jsp"></jsp:forward>
</body>
</html>