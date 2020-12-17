<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container">
	<div>
		<h6>| 문의하기</h6>
	</div>
	<hr>
	<br>

	<div style="text-align: center;">
		<h6>작성완료를 누르면 관리자에게 전송됩니다. 답변은 나의 문의내역에서 확인 가능합니다.</h6>
	</div>

	<div>
		<form action="/askRequest" method="POST" style="width: 100%;">
			<!-- 제목 -->
			<div style="margin-bottom: 5%;">
				<input class="form-control" type="text" id="title" name="askTitle" placeholder="제목을 입력해주세요!" style="width: 100%; padding: 5px;">
			</div>

			<!-- 에디터 -->
			<div style="width: 100%; margin-bottom: 5%;">
				<textarea class="form-control" id="content" name="askContent" placeholder="내용을 입력해주세요!" style="width: 100%; resize: none;" rows="20;"></textarea>
			</div>

			<!-- 등록/취소 -->
			<div style="text-align: center; font-size: 1em; margin-bottom: 5%;">
				<button type="button" style="width: 15%;" onclick="history.back()">취소</button>
				<button type="button" style="width: 15%;" onclick="submitContents(this)">문의</button>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
	function submitContents(elClickedObj) {
		var title = document.getElementById('title').value;
		var content = document.getElementById('content').value;
		if (title == "" || title == null || title == '&nbsp;' || title == '<br>' || title == '<br />' || title == '<p>&nbsp;</p>') {
			alert("제목을 입력해주세요.");
			$("#title").focus();
		} else if (content == "" || content == null || content == '&nbsp;' || content == '<br>' || content == '<br />' || content == '<p>&nbsp;</p>') {
			alert("내용을 입력해주세요.");
			$("#content").focus();
		} else {
			elClickedObj.form.submit();
			alert("문의하기가 완료되었습니다.");
		}
	}
</script>