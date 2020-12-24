<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container">
	<div>
		<h4>주문 및 결제</h4>
	</div>
	<hr>
	<br>

	<div>
		<h5>| 참여 정보</h5>
		<div class="d-flex border">
			<div class="col-8">
				<table>
					<tr>
						<th class="col-3">프로젝트</th>
						<td colspan="2">
							<b class="fs-4">${project.proTitle}</b>
						</td>
					</tr>
					<tr>
						<th>옵션</th>
						<td>${option.opName}</td>
						<td class="text-end">${option.price}원*${order.count}개</td>
					</tr>
					<tr>
						<th>총액</th>
						<td colspan="2" class="text-end">
							<strong>${order.totalPrice}원</strong>
						</td>
					</tr>
				</table>
			</div>
			<div class="col-4" style="background-image: url('${project.proThumb}'); background-size:100% 100%;">
				<img src="https://place-hold.it/294x114/FFFFFF/C0C0C0.png&text=Ecofun&fontsize=10" alt="이미지" class="hidden">
			</div>
		</div>
		<br> <br>

		<form action="/order" method="POST">
			<input type="text" hidden="hidden" name="proType" value="펀딩">
			<input type="number" hidden="hidden" name="memNo" value="${member.memNo}">
			<input type="number" hidden="hidden" name="proNo" value="${project.proNo}">
			<input type="number" hidden="hidden" name="opNo" value="${option.opNo}">
			<input type="number" hidden="hidden" name="count" value="${order.count}">

			<h5>| 참여자 정보</h5>
			<div>
				<table class="border">
					<tr>
						<th class="col-2">이름</th>
						<td>
							<input type="text" name="none" maxlength="8" value="${member.memName}">
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input type="text" name="memTel" maxlength="11" value="${member.memTel}" placeholder="'-' 없이 숫자만 입력해주세요." oninput="maxLengthCheck(this)">
						</td>
					</tr>
				</table>
			</div>
			<br> <br>

			<h5>| 배송지 정보</h5>
			<div>
				<table>
					<tr>
						<th class="col-2">이름</th>
						<td>
							<input type="text" class="form-control name" name="toName" value="${member.memName}" maxlength="10">
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input type="number" class="form-control" name="toTel" maxlength="11" placeholder="'-' 없이 숫자만 입력해주세요." oninput="maxLengthCheck(this)">
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<label style="width: 70%;">
								<input type="number" name="postalCode" id="postalCode" placeholder="우편번호" readonly="readonly" />
							</label>
							<label style="width: 20%">
								<button type="button" class="button_postnumber" onclick="sample4_execDaumPostcode();" style="width: 75%;">주소 검색</button>
							</label>
							<br>
							<input type="text" class="form-control input" name="address1" id="address1" placeholder="도로명주소" style="margin-top: 20px;">
							<br>
							<input type="text" class="form-control input" name="address2" id="address2" placeholder="기본주소">
							<br>
							<input type="text" class="form-control input" name="address3" id="address3" placeholder="상세주소">
							<br>
							<input type="text" class="form-control input" name="address4" id="address4" readonly placeholder="참고항목">
						</td>
					</tr>
					<tr>
						<th>요청사항</th>
						<td>
							<input type="text" name="request" placeholder="20자 이내">
						</td>
					</tr>
				</table>
			</div>
			<br> <br>

			<h5>| 결제금액 / 결제방법</h5>
			<div>
				<table class="border">
					<tr>
						<th class="col-2">결제금액</th>
						<td>
							<input type="text" name="totalPrice" value="${order.totalPrice}" style="width: 20%;" readonly>
							원
						</td>
					</tr>
					<tr>
						<th>결제방법</th>
						<td>
							<input type="radio" id="card" name="pay" value="card" required>
							<label for="card">카드결제</label>
							<input type="radio" id="kakaopay" name="pay" value="kakaopay">
							<label for="kakaopay">카카오페이</label>
						</td>
					</tr>
				</table>
			</div>
			<br> <br>

			<!-- 하단 확인 버튼 -->
			<div style="text-align: center;">
				<button type="button" onclick="history.back();">뒤로가기</button>
				<button type="submit">결제하기</button>
			</div>
		</form>
	</div>
</div>

<script>
	function sample4_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수

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

	function maxLengthCheck(object) {
		if (object.value.length > object.maxLength) {
			object.value = object.value.slice(0, object.maxLength);
		}
	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/js/address.js"></script>