<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	//아이디 파라미터 읽어오기
	String mem_id=request.getParameter("mem_id");
	//유효성검사
	int result=0;
	if(mem_id!=null && !mem_id.isEmpty()){
		try{
			result=memberService.duplicateId(mem_id);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/sidebars/">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/css/main2.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<title>아이디 중복확인</title>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btUse').click(function(){	//사용하기 버튼 클릭
			$(opener.document).find("#mem_id").val("<%=mem_id%>");
			$(opener.document).find("#chkId").val("Y");
			
			self.close();
		});
	});
</script>
</head>
<body class="mainDiv">
	<form name="frmUserid" method="post" action="checkUserid.jsp">
		<div class="mainDivGr">
			<p class="p c">아이디 중복검사</p>
			<input type="text" id="mem_id" name="mem_id" placeholder="중복검사할 아이디를 입력하세요"
							class="form-control inputbox2" value="<%=mem_id%>">
			<input type="submit" value="아이디확인"
				class="btn btn-sm btn-block regist mt-2"> 
				
			<%if(result==memberService.EXIST_ID){ %>
				<p class="p c strong" style="margin-top:20px;">이미 등록된 아이디입니다.</p>
			<%}else if(result==memberService.NON_EXIST_ID){ %>
			
				<input type="button" value="사용하기" id="btUse"
					class="btn btn-sm btn-block loginBt mt-1">	
				<p class="p c strong" style="margin-top:20px;">사용가능한 아이디입니다.<br> [사용하기] 버튼을 클릭하세요.</p>
			<%} %>
		</div>
	</form>
</body >
</html>