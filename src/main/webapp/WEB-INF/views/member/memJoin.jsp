<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container">
  <br>
  <div>
    <h4>| 회원가입</h4>
  </div>
  <hr>
  <br>

  <div class="register">
    <form action="/member/join" method="post" onsubmit="return formCheck()">
      <div class="d-flex-wrap div-id-check">
        <input type="text" class="form-control not col-6" id="mem-id" name="memId"
          placeholder="아이디*" required>
        <button type="button" class="btn-id-check col-3">중복체크</button>
      </div>
      <div>
        <input type="password" class="form-control col-9 pw-check memPwLabel" id="mem-pw"
          placeholder="비밀번호*" maxlength="20" /> <input type="password"
          class="form-control col-9 pw-check" id="mem-pw-re" placeholder="비밀번호 확인*" maxlength="20" />
      </div>
      <br>

      <div>
        <input type="text" class="form-control col-9" id="mem-name" name="memName" placeholder="이름*"
          required>
      </div>
      <div>
        <input type="text" class="form-control col-9" id="mem-tel" name="memTel" maxlength="11"
          placeholder="연락처*" required>
      </div>
      <br>

      <div class="d-flex-wrap">
        <span class="register-label">주소</span> <input type="text" class="form-control not col-6"
          name="postalCode" id="postal-code" placeholder="우편번호*" readonly="readonly" />
        <button type="button" onclick="sample4_execDaumPostcode();" class="btn-zipCode col-3">주소
          검색</button>
        <input type="text" class="form-control col-9" name="address1" id="address1"
          placeholder="도로명주소*" /> <input type="text" class="form-control col-9" name="address2"
          id="address2" placeholder="기본주소*" /> <input type="text" class="form-control col-9"
          name="address3" id="address3" placeholder="상세주소*" required /> <input type="text"
          class="form-control col-9" name="address4" id="address4" placeholder="참고항목"
          readonly="readonly" />
      </div>
      <br>

      <div>
        <span class="register-label"> 계좌 <span class="red">*</span>
        </span> <select name="bankName" class="form-control" required>
          <option value="">은행을 선택하세요 *</option>
          <option value="국민은행">국민은행</option>
          <option value="우리은행">우리은행</option>
          <option value="신한은행">신한은행</option>
          <option value="농협은행">농협은행</option>
          <option value="카카오뱅크">카카오뱅크</option>
        </select> <input type="text" class="form-control col-9" id="account-name" name="accountName"
          maxlength="10" placeholder="계좌주*" required> <input type="text"
          class="form-control col-9" id="account-number" name="accountNumber" maxlength="14"
          placeholder="계좌번호*" required>
      </div>
      <br> <br>

      <div class="text-center">
        <button type="submit" class="btn-register">가입하기</button>
      </div>
    </form>
  </div>
</div>

<script>
  document.querySelector("#mem-id").addEventListener(
    "keyup",
    function() {
      $(".span-id-check").remove();
      const mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
      if (!mailformat.test(this.value)) {
        $(".btn-id-check").after(
          '<span class="span-id-check">입력하신 값은 이메일 형식이 아닙니다.</span>');
      }
    });
</script>
<script>
  document
    .querySelector("#mem-pw-re")
    .addEventListener(
      "keyup",
      function() {
        $(".pw-check-result").remove();
        const memPw = document.querySelector("#mem-pw").value;
        const memPwRe = document.querySelector("#mem-pw-re").value;
        if (memPw.length > 0 && memPwRe.length > 0) {
          if (memPw == memPwRe) {
            $(".memPwLabel")
              .after(
                '<span class="pw-check-result" id="pw-check-sucess">비밀번호 일치</span>');
          } else {
            $(".memPwLabel")
              .after(
                '<span class="pw-check-result" id="pw-check-fail">비밀번호 불일치</span>');
          }
        }
      });
</script>
<script>
  document.querySelector("#mem-tel").addEventListener("keyup", function() {
    this.value = this.value.replace(/[^0-9]/g, '');
  });
  document.querySelector("#account-number").addEventListener("keyup",
    function() {
      this.value = this.value.replace(/[^0-9]/g, '');
    });
</script>
<script>
  document.querySelector(".btn-id-check").addEventListener("click", function() {
    idCheck(this.form);
  });

  function idCheck(form) {
    if (form.mem - id.value == "") {
      alert("아이디를 입력해주세요.");
      return;
    }

    $(".id-check-result").remove();
    $
      .ajax({
        type : "post",
        url : "idCheck",
        data : $(form).serialize(),
        success : function(data) {
          if (data == 0) {
            isIdCheck.flag = 0;
            isIdCheck.id = form.mem - id.value;
            $(".btn-id-check")
              .after(
                '<br><span class="id-check-result" id="id-check-sucess">사용 가능한 아이디</span>');
          } else {
            $(".btn-id-check")
              .after(
                '<br><span class="id-check-result" id="id-check-fail">중복된 아이디</span>');
          }
        },
        dataType : "text"
      });
  }
  var isIdCheck = {
    flag : 1, // 1 중복된 아이디 or 중복체크 안했음, 0 사용 가능한 아이디
    id : "" // 중복체크에 사용된 아이디
  }
  function formCheck() {
    if (isIdCheck.flag == 1 || isIdCheck.id != this.mem - id.value) {
      $(".id-check-result").remove();
      alert("아이디 중복체크를 해주세요.");
      return false;
    }

    if (this.accountNumber.value == "") {
      this.accountNumber.value = 0;
    }

    if (this.postalCode.value == "") {
      alert("우편번호를 입력해주세요.");
      return false;
    }
  }
</script>
<script>
  function sample4_execDaumPostcode() {
    new daum.Postcode({
      oncomplete : function(data) {
        const roadAddr = data.roadAddress; // 도로명 주소 변수
        const extraRoadAddr = ''; // 참고 항목 변수
        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
          extraRoadAddr += data.bname;
        }
        // 건물명이 있고, 공동주택일 경우 추가
        if (data.buildingName !== '' && data.apartment === 'Y') {
          extraRoadAddr +=
            (extraRoadAddr !== '' ? ', ' + data.buildingName
              : data.buildingName);
        }
        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
        if (extraRoadAddr !== '') {
          extraRoadAddr = ' (' + extraRoadAddr + ')';
        }
        // 우편번호와 주소 정보를 해당 필드에 입력
        document.querySelector("#postal-code").value = data.zonecode;
        document.querySelector("#address1").value = roadAddr;
        document.querySelector("#address2").value = data.jibunAddress;
        // 참고항목 문자열이 있을 경우 추가
        if (roadAddr !== '') {
          document.querySelector("#address4").value = extraRoadAddr;
        } else {
          document.querySelector("#address4").value = '';
        }
        const guideTextBox = document.querySelector("#address1");
        // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
        if (data.autoRoadAddress) {
          const expRoadAddr = data.autoRoadAddress + extraRoadAddr;
          guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
          guideTextBox.style.display = 'block';

        } else if (data.autoJibunAddress) {
          const expJibunAddr = data.autoJibunAddress;
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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/js/address.js"></script>
