<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join_ok</title>
</head>
<body>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<jsp:useBean id="memberVo" class="com.member.model.memberVO" scope="page"></jsp:useBean>
<%
//join.jsp에서 post방식 서브밋
	request.setCharacterEncoding("utf-8");
	//1
	String mem_name=request.getParameter("mem_name");
	String mem_id=request.getParameter("mem_id");
	String mem_pwd1=request.getParameter("mem_pwd1");
	String mem_pwd=mem_pwd1;
	
	String mem_ssn1=request.getParameter("mem_ssn1");
	String mem_ssn2=request.getParameter("mem_ssn2");
	String mem_ssn=mem_ssn1+"-"+mem_ssn2;
	
	String mem_addr=request.getParameter("mem_addr");
	
	String mem_tel1=request.getParameter("mem_tel1");
	String mem_tel2=request.getParameter("mem_tel2");
	String mem_tel3=request.getParameter("mem_tel3");
	String mem_tel=mem_tel1+"-"+mem_tel2+"-"+mem_tel3;
	
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

	memberVo.setMem_name(mem_name);
	memberVo.setMem_id(mem_id);
	memberVo.setMem_pwd(mem_pwd);
	memberVo.setMem_ssn(mem_ssn);
	memberVo.setMem_addr(mem_addr);
	memberVo.setMem_tel(mem_tel);
	memberVo.setMem_email(mem_email);

	//2
	String msg = "회원가입에 실패하였습니다. 등록한 정보를 확인해주세요.", url = "join.jsp";

	try {
		int result = memberService.joinMember(memberVo);
		if (result > 0) {
	msg = "회원가입 되었습니다.";
	url=request.getContextPath()+"/index.jsp";
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}

	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="/common/message.jsp"></jsp:forward>
</body>
</html>