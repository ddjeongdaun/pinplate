<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<script type="text/javascript" src="../js/member.js"></script>
<script type="text/javascript">
$(function(){
	$('#mem_name').focus();
	//유효성 검사
	$('#joinBtn').click(function(){
		if($('#mem_name').val().length<1){			//이름 미입력
			alert('이름을 입력해야합니다.');
			$('#mem_name').focus();
			event.preventDefault();
		}else if(!validate_userid($('#mem_id').val())){		//아이디 validate
			alert('아이디는 영문,숫자,문자(_)만 사용가능합니다.');
			$('#mem_id').focus();
			event.preventDefault();
		}else if($('#mem_pwd1').val().length<1){		//비밀번호 미입력
			alert('비밀번호를 입력하세요.');
			$('#mem_pwd1').focus();
			event.preventDefault();
		}else if($('#mem_pwd1').val()!=$('#mem_pwd2').val()){		//비밀번호 미일치
			alert('비밀번호가 일치하지 않습니다.');
			$('#mem_pwd2').focus();
			event.preventDefault();
		}else if($('#mem_ssn1').val().length<1 || $('#mem_ssn2').val().length<1){	//주민번호 미입력
			alert('주민번호를 입력해야 합니다.');
			$('#mem_ssn1').focus();
			event.preventDefault();
		}else if( !validate_phone($('#mem_ssn1').val())
				|| !validate_phone($('#mem_ssn2').val()) ){		//주민번호 validate
			alert('주민번호는 숫자만 가능합니다.');
			$('#mem_ssn1').focus();
			event.preventDefault();
		}else if(!validate_phone($('#mem_tel2').val()) || !validate_phone($('#mem_tel3').val())){	//전화번호 validate
			alert('전화번호는 숫자만 가능합니다.');
			$('#mem_tel2').focus();
			event.preventDefault();
		}else if($('#chkId').val()!='Y'){		//아이디 중복확인
			alert('아이디 중복확인을 해야 합니다.'	);
			$('#btnChkId').focus();
			event.preventDefault();
		}
	});
	
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
	<form name="frm" method="post" action="<%=request.getContextPath()%>/join/join_ok.jsp">
		<div class="mainDivGr">
			<div style="position:relative;height:65px;">
					<p class="p c">회원가입</p>
					<p class="subP" style="position:absolute;left:0;">(*은 필수 입력)</p>
			</div>
			<div style="position:relative;">
				<input type="text" id="mem_id" name="mem_id" placeholder="* 아이디를 입력하세요"
					class="form-control inputbox3" style="position:absolute;left:1px;top:1px;">
				<input type="button" value="중복확인" id="btnChkId" style="position:absolute;right:1px;top:-6px;"
					class="btn btn-sm btn-block btnChkId mt-2">
			</div>
			<input type="text" id="mem_name" name="mem_name" placeholder="* 이름을 입력하세요"
				class="form-control inputbox2" style="clear: both;margin-top:40px;">
			<input type="password" id="mem_pwd1" name="mem_pwd1" placeholder="* 비밀번호를 입력하세요"
					class="form-control inputbox2">
			<input type="password" id="mem_pwd2" name="mem_pwd2" placeholder="* 비밀번호를 확인을 입력하세요"
					class="form-control inputbox2">
					
			<div style="overflow: hidden">
				<input type="text" id="mem_ssn1" name="mem_ssn1" placeholder="* 주민번호 앞자리 입력"
					class="form-control inputbox4" style="float: left"><p style="float: left">-</p>
				<input type="text" id="mem_ssn2" name="mem_ssn2" placeholder="주민번호 뒷자리 입력"
					class="form-control inputbox4" style="float: right">
			</div>								
			<input type="text" id="mem_addr" name="mem_addr" placeholder="* 주소를 입력하세요"
					class="form-control inputbox2">
					
			<div style="overflow: hidden">
				<select name="mem_tel1" id="mem_tel1" title="휴대폰 앞자리" class="form-control selectbox1" style="float: left">
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="018">018</option>
					<option value="019">019</option>
				</select>
				<div style="overflow: hidden">
					<p style="float: left"> - </p>
						<input type="text" name="mem_tel2" id="mem_tel2" maxlength="4" placeholder="가운데 번호"
							class="form-control inputbox5" style="float: left;text-align: center;">
					<p style="float: left"> -</p>
						<input type="text" name="mem_tel3" id="mem_tel3" maxlength="4" placeholder="뒷자리 번호"
							class="form-control inputbox5" style="float: right;text-align: center;">
				</div>
			</div>
			
		   	<div style="overflow: hidden">
		        <input type="text" name="mem_email1"  id="mem_email1" 
		        	class="form-control inputbox6" style="float: left">
		        <p style="float: left"> @ </p>
		        <select name="mem_email2" id="mem_email2"
		        	class="form-control inputbox7" style="float: left">
		            <option value="naver.com">naver.com</option>
		            <option value="hanmail.net">hanmail.net</option>
		            <option value="nate.com">nate.com</option>
		            <option value="gmail.com">gmail.com</option>
		            <option value="etc">직접입력</option>
		        </select>
		        <input type="text" name="mem_email3" id="mem_email3" style="visibility:hidden"
		        	class="form-control inputbox6" style="float:right">
		    </div>
			<input type="submit" value="회원가입하기" id="joinBtn"
				class="btn btn-sm btn-block loginBt mt-1"> 
			<input type="button" value="메인페이지로 이동"
				onClick="location.href='<%=request.getContextPath()%>/index.jsp'"
				class="btn btn-sm btn-block regist mt-2">
		</div>
		<input type ="hidden" name="chkId" id="chkId">
	</form>
</main>
<%@ include file="/inc/Bottom.jsp"%>