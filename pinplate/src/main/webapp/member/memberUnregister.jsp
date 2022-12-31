<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../login/checkLogin.jsp" %>

<%
	String mem_id=(String)session.getAttribute("mem_id");
%>

<%@ include file="/inc/Top.jsp"%>

<main class="mainDiv">
	<div class="mainDivGr3">
		<form id="frm" method="post" action="<%=request.getContextPath()%>/member/memberUnregister_ok.jsp">
			<p class="p c">회원 탈퇴 안내</p>
			<p style="font-size: 16px;">
			회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.<br>
			사용하고 계신 아이디 (<%=mem_id %>) 는 탈퇴할 경우 재사용 및 복구가 불가능합니다.<br>
			탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가하오니 신중하게 선택하시기 바랍니다.<br>
			탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.<br>
			</p>
			<input type="submit" value="안내사항 확인 및 탈퇴" id="unregister"
					onClick="location.href='<%=request.getContextPath() %>/member/memberUnregister.jsp'"
					class="btn btn-sm btn-block regist mt-2">
		</form>
	</div>
</main>

<%@ include file="/inc/Bottom.jsp"%>