<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function() {
		$(".pc-login-button").click(function() {
			loginSubmit($(this.form).serialize());
		});

		$(".login-button").click(function() {
			loginSubmit($(this.form).serialize());
		});
	});

	var loginFail = '<div class="alert alert-warning" role="alert">회원 아이디와 패스워드가 서로 맞지 않습니다.</div>';

	function loginSubmit(formData) {
		$.ajax({
			type : "post",
			url : "login",
			data : formData,
			success : function(data) {
				if (data.memId != "") {
					$(location).attr("href", "/");
				}
			},
			dataType : "json"
		}).fail(function() {
			$(".alert.alert-warning").remove();
			$(".login_contain").prepend(loginFail);
		});
	}
</script>

<div class="section auto">
	<div class="wrap_container">
		<div class="login center">
			<form>
				<ul class="login_contain pc-login">
					<li>
						<h2>로그인 하세요</h2>
					</li>
					<li class="login_area">
						<input class="login_form email" type="text" name="memId" placeholder="아이디" maxlength="25" required>
					</li>
					<li class="login_area">
						<input class="login_form password" type="password" name="memPw" placeholder="비밀번호 (6자 이상)" maxlength="20" required>
					</li>
					<li class="login_sub">
						<label class="payment_agree_contain auto_login">
							자동로그인 <input type="checkbox" name="payment_agree" required="required">
							<span class="payment_agree_checkmark auto_login_chk"></span>
						</label>
						<a class="find_account" href="/member/pwFind">아이디/비밀번호 찾기 &#187;</a>
					</li>
					<li>
						<button class="pc-login-button hover auto">로그인</button>
					</li>
					<li class="login_line"></li>
					<li>
						<a onclick="changeView(2)"><button class="pc-join-button hover auto">회원가입</button></a>
					</li>

				</ul>
			</form>
			<form>
				<ul class="login_contain mobile-login">
					<li class="login_area">
						<input class="login_form email" type="text" name="memId" placeholder="아이디" maxlength="25" required>
					</li>
					<li class="login_area">
						<input class="login_form password" type="password" name="memPw" placeholder="비밀번호 (6자 이상)" maxlength="20" required>
					</li>
					<li class="login_sub">
						<label class="payment_agree_contain auto_login">
							자동로그인 <input type="checkbox" name="payment_agree" required="required">
							<span class="payment_agree_checkmark auto_login_chk"></span>
						</label>
						<a class="find_account" href="/member/pwFind">아이디/비밀번호 찾기 &#187;</a>
					</li>
					<li>
						<button class="login-button hover auto">로그인</button>
					</li>
					<li class="login_line"></li>
					<li>
						<button class="join-button hover auto" onclick="changeView(3)">회원가입</button>
					</li>
				</ul>
			</form>
		</div>
	</div>
</div>
