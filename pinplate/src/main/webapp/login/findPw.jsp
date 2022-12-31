<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%>
<script type="text/javascript" src="../js/member.js"></script>
<script type="text/javascript">
	$(function(){
		//비밀번호 유효성 검사
		$('#Btnchange').click(function(){
			if($('#mem_name').val().length<1){			//이름 미입력
				alert('이름을 입력해야합니다.');
				$('#mem_name').focus();
				event.preventDefault();
			}else if(!validate_userid($('#mem_id').val())){		//아이디 validate
				alert('아이디는 영문,숫자,문자(_)만 사용가능합니다.');
				$('#mem_id').focus();
				event.preventDefault();
			}else if($('#mem_pwd').val().length<1){		//비밀번호 미입력
				alert('비밀번호를 입력하세요.');
				$('#mem_pwd1').focus();
				event.preventDefault();
			}else if($('#mem_pwd').val()!=$('#mem_pwd2').val()){		//비밀번호 미일치
				alert('비밀번호가 일치하지 않습니다.');
				$('#mem_pwd2').focus();
				event.preventDefault();
			}else if($('#mem_ssn1').val().length<1 || $('#mem_ssn2').val().length<1){	//주민번호 미입력
				alert('주민번호를 입력해야 합니다.');
				$('#mem_ssn1').focus();
				event.preventDefault();
			}else if( !validate_phone($('#mem_ssn1').val())
					|| !validate_phone($('#mem_ssn2').val()) ){		//주민번호 validate
				alert('주민번호는 숫자 및 하이픈만 가능합니다.');
				$('#mem_ssn1').focus();
				event.preventDefault();
			}
		});
	});
</script>

<main class="mainDiv">
	<form name="findPw" method="post" action="<%=request.getContextPath() %>/login/findPw_ok.jsp">
		<div class="mainDivGr">
			<p class="p c">비밀번호 찾기</p>
					<input type="text" name="mem_name" placeholder="이름을 입력하세요"
						class="form-control inputbox2">
					<input type="text" name="mem_id" placeholder="아이디를 입력하세요"
						class="form-control inputbox2">
					<input type="text" name="mem_ssn" placeholder="(-하이픈 포함) 주민등록번호를 입럭하세요"
						class="form-control inputbox2">
					<input type="password" name="mem_pwd" placeholder="변경할 비밀번호를 입력하세요"
						class="form-control inputbox2">
					<input type="password" name="mem_pwd2" placeholder="변경할 비밀번호를 한번 더 입력하세요"
						class="form-control inputbox2">
			<div class="btnSearch">
				<input type="submit" value="비밀번호 변경하기" id="Btnchange"
					class="btn btn-sm btn-block loginBt mt-1"> 
				<input type="button" value="메인페이지로 이동"
					onClick="location.href='<%=request.getContextPath()%>/index.jsp'"
					class="btn btn-sm btn-block regist mt-2">
			</div>
		</div>
	</form>
</main>
<%@ include file="/inc/Bottom.jsp"%>