<%@page import="java.sql.SQLException"%>
<%@page import="com.member.model.memberVO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%
	//memberDetail.jsp 에서 post방식으로 서브밋
	request.setCharacterEncoding("utf-8");
	
	//
	String mem_no=request.getParameter("mem_no");
	String mem_addr=request.getParameter("mem_addr");
	String mem_tel=request.getParameter("mem_tel");
	String mem_use=request.getParameter("mem_use");
	
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
	
	//
	memberVO vo = new memberVO();
	vo.setMem_no(Integer.parseInt(mem_no));
	vo.setMem_addr(mem_addr);
	vo.setMem_tel(mem_tel);
	vo.setMem_email(mem_email);
	vo.setMem_use(mem_use);
	
	
	int cnt=0;
	try{
		cnt=memberService.admin_updateMember(vo);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String msg="회원 수정 중 오류 발생!", url="memberDetail.jsp?no="+mem_no;
	if(cnt>0){
		msg="회원 수정 성공";
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