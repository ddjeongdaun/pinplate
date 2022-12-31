<%@page import="com.member.model.memberVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PinPlate</title>
</head>
<body>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%
	//login.jsp에서 post방식 서브밋
	request.setCharacterEncoding("utf-8");
	//1
	String mem_id=request.getParameter("mem_id");
	String mem_pwd=request.getParameter("mem_pwd");
	String chkSave=request.getParameter("chkSave");
	
	// 프라이머리키, 이름, 관리자여부 session에 저장
	memberVO vo=memberService.memberInfo(mem_id);
	
	int mem_no=vo.getMem_no();
	String mem_name=vo.getMem_name();
	String mem_auth=vo.getMem_auth();
	
	//2
	String msg="로그인 처리 실패", url=request.getContextPath()+"/index.jsp";
	try{
		int result=memberService.loginCheck(mem_id, mem_pwd);
		
		if(result==memberService.LOGIN_OK){
			// [1] session에 저장(아이디,이름,번호,관리자여부)
			session.setAttribute("mem_id", mem_id);
			session.setAttribute("mem_no", mem_no);
			session.setAttribute("mem_name", mem_name);
			session.setAttribute("mem_auth", mem_auth);
			
			
			// [2] 쿠키에 저장 - 아이디 저장하기
			Cookie ck= new Cookie("mem_id", mem_id);
			ck.setPath("/");
			
			if(chkSave != null){ 				//체크
				ck.setMaxAge(1000*24*60*60);	//쿠키저장-1000일
				response.addCookie(ck);
			}else{								//비체크
				ck.setMaxAge(0);				//쿠키 삭제
				response.addCookie(ck);
			}
			
			if(memberService.checkMember(mem_id)==0){
				msg=mem_id+"님 환영합니다.";
				url=request.getContextPath()+"/index.jsp";
			}else{
				msg="관리자로 로그인되었습니다.";
				url=request.getContextPath()+"/index.jsp";
			}
			
		}else if(result==memberService.WRONG_PW){
			msg="비밀번호가 틀립니다.";
		}else if(result==memberService.WRONG_PW){
			msg="해당 아이디는 존재하지 않습니다.";
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