<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script> -->
<style>
/*  *{
 border: red solid 1px;
        } */
table {
	border-bottom: solid darkgray 1px;
	border-top: solid darkgray 1px;
	padding-right: 15px;
	margin-bottom: 10%;
}

.td1 {
	border-right: darkgray solid 1px;
	text-align: right;
	padding-right: 15px;
}

.td2 {
	padding-left: 15px;
}

td {
	border-bottom: solid darkgray 1px;
	padding-bottom: 1.5%;
	padding-top: 1.5%;
}

tr {
	vertical-align: middle;
}

.btn {
	float: right;
	background-color: white;
	/* border-color: lightgray solid 0.5px; */
}

.phone {
	width: 20%;
	height: 95%;
	display: inline;
}

.address1 {
	width: 30%;
	display: inline;
	height: 30%;
}

.address2 {
	width: 75%;
	height: 30%;
	margin-top: 5px;
}

.bank {
	width: 75%;
	height: 20%;
}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<div class="container" style="margin-top: 5%">
	<!-- title -->
	<div style="margin-bottom: 5%;">
		<h2>| 개인정보 수정</h2>
	</div>
	<hr>

	<!-- table -->
	<div style="margin: 0 auto;">
		<form action="" id="form">
			<table style="width: 100%;">
				<tr>
					<!-- 아이디 -->
					<td class="td1">
						<span style="color: orange">*</span>
						아이디
					</td>
					<td class="td2">${member.memId}</td>
				</tr>
				<tr>
					<!-- 이름 -->
					<td class="td1">
						<span style="color: orange">*</span>
						이름
					</td>
					<td class="td2">
						<input type="hidden" id="name" name="memName" value="${member.memName}">${member.memName}</td>
				</tr>
				<tr>
					<!-- 연락처 수정 -->
					<td class="td1">
						<span style="color: orange">*</span>
						연락처
					</td>
					<td class="td2">
						<input type="text" id="memTel" name="memTel" class="form-control input" value="${member.memTel}" required>
					</td>
				</tr>

				<tr>
					<!-- 주소수정 -->
					<td class="td1">주소</td>
					<td class="td2">
						<!-- <input type="button" class="btn" id="address" value="?"> -->
						<label style="width: 91%;">
							<input type="text" name="postalCode" id="postalCode" class="form-control input" value="${address.postalCode}" readonly="readonly" />
						</label>
						<label>
							<button type="button" class="button_postnumber" onclick="sample4_execDaumPostcode();" style="padding-left: 9px; left: 0px;">주소 검색</button>
						</label>
						<br> <input type="text" name="address1" id="address1" class="form-control input" value="${address.address1}" style="margin-top: 20px;">
						<br> <input type="text" name="address2" id="address2" class="form-control input" value="${address.address2}"> <br> <input
							type="text" name="address3" id="address3" class="form-control input" value="${address.address3}"
						> <br> <input type="text" name="address4" id="address4" class="form-control input" readonly="readonly" value="${address.address4}">
						<input type="hidden" name="mem_address4">
					</td>
				</tr>

				<tr>
					<!-- 계좌수정 -->
					<td class="td1">계좌</td>
					<td class="td2">
						은행선택 :
						<!-- <input type="button" class="btn" id="bank" value="?">  -->
						<select name="bankName" id="bankName" class="form-control input">
							<option value="" selected="${account.bankName}">은행을 선택하세요</option>
							<option value="국민은행">국민은행</option>
							<option value="우리은행">우리은행</option>
							<option value="신한은행">신한은행</option>
							<option value="농협은행">농협은행</option>
							<option value="카카오뱅크">카카오뱅크</option>
						</select> <br> <input type="text" id="accountName" name="accountName" class="form-control input" value="${account.accountName}"> <br> <input
							type="text" id="accountNumber" name="accountNumber" class="form-control input" value="${account.accountNumber}"
						>
				</tr>


			</table>

			<!-- table end -->
			<!-- 동의서 -->
			<div class="col-lg-12 col-sm-12" style="margin-bottom: 5%;">
				<h5>| 마케팅정보 제공동의</h5>
				<hr>
				<textarea class="col-lg-12 col-sm-12" name="" id="" style="resize: none;"></textarea>
				<hr>
			</div>



			<div class="upButtonWrap" role="group" aria-label="..." style="margin: 0 auto;">

				<a href="/main"><input type="button" class="uploadButton" value="취소하기"></a> <a href="/main"><input type="button" class="uploadButton"
					onclick="update(this)" value="저장하기"
				></a>

			</div>

		</form>
	</div>
</div>


<!-- <script>
	$('#address').click(function() {
		alert("공백은 회원가입 시 저장 안해서 그럼");
	});

	$('#bank').click(function() {
		alert("공백은 회원가입 시 저장 안해서 그럼");
	});
</script> -->
<script>
	function update(elClickedObj) {
		alert("들어옴");
		var phone = document.getElementById('memTel').value;
		var postalCode = document.getElementById('postalCode').value; //우편번호
		var address3 = document.getElementById('address3').value; //상세주소
		var bankName = document.getElementById('bankName').value; //은행명
		var accountName = document.getElementById('accountName').value; //예금주
		var accountNumber = document.getElementById('accountNumber').value; //계좌번호

		if (phone == "") {
			alert("전화번호를 입력해주세요");
			$("#memTel").focus();
		} else if (postalCode == "") {
			alert("우편번호를 입력해주세요.");
			$("#postalCode").focus();
		} else if (address3 == "") {
			alert("상세주소를 입력해주세요.");
			$("#address3").focus();
		} else if (bankName == "") {
			alert("은행을 선택해주세요.");
			$("#bankName").focus();
		} else if (accountName == "") {
			alert("예금주를 입력해주세요.");
			$("#accountName").focus();
		} else if (accountNumber == "") {
			alert("계좌번호를 입력해주세요.");
			$("#accountNumber").focus();
		} else {
			$.ajax({
				type : "put",
				url : "memUpdateRequest",
				data : $('#form').serialize(),
				success : function() {
					alert("회원정보가 수정되었습니다.");
				}
			});
			alert("개인정보수정이 완료되었습니다.");

		}
	}
</script>
<script>
	function sample4_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} /* else { // 사용자가 지번 주소를 선택했을 경우(J)
				               addr = data.jibunAddress;
				           } */

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postalCode').value = data.zonecode;
				document.getElementById("address1").value = roadAddr;
				document.getElementById("address2").value = data.jibunAddress;

				// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
				if (roadAddr !== '') {
					document.getElementById("address4").value = extraRoadAddr;
				} else {
					document.getElementById("address4").value = '';
				}

				var guideTextBox = document.getElementById("address1");
				// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
				if (data.autoRoadAddress) {
					var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
					guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
					guideTextBox.style.display = 'block';

				} else if (data.autoJibunAddress) {
					var expJibunAddr = data.autoJibunAddress;
					guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
					guideTextBox.style.display = 'block';
				} else {
					guideTextBox.innerHTML = '';
					guideTextBox.style.display = 'none';
				}
			}
		}).open();
	}
</script>