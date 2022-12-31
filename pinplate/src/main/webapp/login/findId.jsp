<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/inc/Top.jsp"%>

<main class="mainDiv">
	<form name="findId" method="post" action="<%=request.getContextPath()%>/login/findId_ok.jsp">
		<div class="mainDivGr">
		<p class="p c">아이디 찾기</p>
			<input type="text" name="mem_name" placeholder="이름을 입력하세요"
				class="form-control inputbox2">
			<input type="text" name="mem_ssn" placeholder="(-하이픈 포함) 주민등록번호를 입럭하세요"
				class="form-control inputbox2">
			<div class="btnSearch">
				<input type="submit" value="아이디 찾기"
					class="btn btn-sm btn-block loginBt mt-1"> 
				<input type="button" value="메인페이지로 이동"
					onClick="location.href='<%=request.getContextPath()%>/index.jsp'"
					class="btn btn-sm btn-block regist mt-2">
			</div>
		</div>
	</form>
</main>

<%@ include file="/inc/Bottom.jsp"%>