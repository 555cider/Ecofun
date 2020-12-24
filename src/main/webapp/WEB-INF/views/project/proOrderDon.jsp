<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	Long memNo = (Long) session.getAttribute("memNo");
%>

<div class="container">
	<div>
		<h4>| 주문 및 결제</h4>
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

		<form action="/project/order" method="POST">
			<input type="text" hidden="hidden" name="proType" value="기부">
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

			<h5>| 결제금액 / 결제방법</h5>
			<div>
				<table class="border">
					<tr>
						<th class="col-2">결제금액</th>
						<td colspan="3">
							<input type="text" name="totalPrice" value="${order.totalPrice}" readonly>
							원
						</td>
					</tr>
					<tr>
						<th>입금은행</th>
						<td>
							<input type="radio" name="pay" value="banking" checked>
							<label for="pay">무통장입금</label>
						</td>
						<td>
							<label for="bankName">입금은행</label>
							<select name="bankName" required>
								<option value="" selected="selected">-선택하세요-</option>
								<option value="신한은행">신한은행</option>
								<option value="기업은행">기업은행</option>
								<option value="국민은행">국민은행</option>
								<option value="우리은행">우리은행</option>
								<option value="제일은행">제일은행</option>
								<option value="농협은행">농협은행</option>
							</select>
						</td>
						<td>
							<label for="accountName">입금자명</label>
							<input type="text" name="accountName" required>
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
	function maxLengthCheck(object) {
		if (object.value.length > object.maxLength) {
			object.value = object.value.slice(0, object.maxLength);
		}
	}
</script>