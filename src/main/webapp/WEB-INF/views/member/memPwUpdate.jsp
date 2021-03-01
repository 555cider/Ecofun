<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
  function ready(callbackFunc) {
    if (document.readyState !== 'loading') {
      // Document is already ready, call the callback directly
      callbackFunc();
    } else if (document.addEventListener) {
      // All modern browsers to register DOMContentLoaded
      document.addEventListener('DOMContentLoaded', callbackFunc);
    } else {
      // Old IE browsers
      document.attachEvent('onreadystatechange', function() {
        if (document.readyState === 'complete') {
          callbackFunc();
        }
      });
    }
  }

  ready(function() {
    document.querySelector(".password-check").onkeyup =
      function() {
        document.querySelector(".pw-check-result").remove();
        const memPw = document.querySelector("#mem-pw").value;
        const memPwRe = document.querySelector("#mem-pw-re").value;
        if (memPw.length > 0 && memPwRe.length > 0) {
          if (memPw == memPwRe) {
            $(".memPwLabel").after(
              '<span class="pw-check-result id-check-sucess">비밀번호 일치</span>');
          } else {
            $(".memPwLabel").after(
              '<span class="pw-check-result id-check-fail">비밀번호 불일치</span>');
          }
        }
      };
  });
</script>

<div class="container">
  <!-- title -->
  <div>
    <h4>| 비밀번호 변경</h4>
  </div>
  <hr>
  <br>

  <!-- 변경 폼 -->
  <div class="register">
    <form action="/memPwUpdate" method="post" class="register-form">
      <!-- 비밀번호 -->
      <div>
        <input type="password" id="mem-pw" name="memPw" class="password-check" placeholder="비밀번호*"
          pattern=".{6,20}" title="6 to 20 characters" required>
        <!-- <p class="help-block">비밀번호는 6자리 이상이어야 합니다</p> -->
      </div>
      <!-- 비밀번호 확인 -->
      <div>
        <input type="password" id="mem-pw-re" class="memPwLabel password-check" placeholder="비밀번호*"
          pattern=".{6,20}" title="6 to 20 characters" required>
      </div>

      <div>
        <h6>※ 영문 숫자, 특수문자를 조합하여 6~20자 이내로 입력</h6>
      </div>
      <br> <br>

      <!-- 하단 변경 버튼 -->
      <div class="text-center" role="group">
        <button type="button" onclick="history.back();">취소하기</button>
        <button type="submit">저장하기</button>
      </div>
    </form>
  </div>
</div>