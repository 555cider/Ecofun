<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
	// more 관련
	function openMemberDetail(memNo) {
		$(".member-detail").empty();
		$.ajax({
			type : "get",
			url : "/admin/memberDetail/" + memNo,
			success : function(data) {
				$(".member-detail").append(data);
			},
			dataType : "html"
		});

		var layerHeight = $(window).height();
		var layerWidth = $(window).width();
		$(".layer-background").css({
			"width" : layerWidth,
			"height" : layerHeight
		});
		$(".layer-background").fadeTo("slow", 0.8);

		var left = 10;
		var top = 10;
		$(".member-detail").css({
			"position" : "absolute"
		});
		$(".member-detail").fadeTo("slow", 1);
	}

	$(function() {
		$(".open-member-detail").click(function(e) {
			e.preventDefault();
			openMemberDetail($(this).data("mem-no"));
		});

		$(".layer-background").click(function() {
			$(this).hide();
			$(".member-detail").hide();
		});

		// 정렬 관련
		$(".member-order").click(function() {
			$(location).attr("href", $(this).attr("href"));
		});
		var orderValue = "";
		$.each($("#headerSortParam").val().split(","), function(index, item) {
			var param1 = $.trim(item.split(":")[0]);
			var param2 = $.trim(item.split(":")[1].toLowerCase());
			if (param1 == "memNo") {
				return true; // true = $.each continue;
			}
			orderValue += "&sort=" + param1 + "," + param2;
			$(".member-order." + param1).data("direction", param2);
		});

		$(".member-order").each(function(index, item) {
			var orderValueAppend = "";
			var thisDataDirection = $(this).data("direction").toLowerCase();
			var thisDataParam = $(this).data("param");
			$(this).empty();
			orderValueAppend = orderValue.replace("&sort=" + thisDataParam + ",asc", "");
			orderValueAppend = orderValueAppend.replace("&sort=" + thisDataParam + ",desc", "");
			if (thisDataDirection == "") {
				$(this).append($(this).data("title") + " △▽");
				orderValueAppend += "&sort=" + thisDataParam + ",asc";
			} else if (thisDataDirection == "asc") {
				$(this).append($(this).data("title") + " ▲▽");
				orderValueAppend += "&sort=" + thisDataParam + ",desc";
			} else if (thisDataDirection == "desc") {
				$(this).append($(this).data("title") + " △▼");
			}

			$(this).attr("href", "/admin/memberList?page=" + $("#headerPageParam").val() + orderValueAppend);
		});

		// 페이징 처리 부분에 정렬 파라미터 추가
		$(".page-item:not(.active) a").each(function(index, item) {
			$(this).attr("href", $(this).attr("href") + orderValue);
		});
	});
</script>

<div class="container">
	<!-- Content-Header (회원 관리) -->
	<div class="row">
		<div class="col">
			<h4>| 회원 관리</h4>
		</div>
		<div class="col" style="text-align: right;">
			<span>가입 ${todayCount}명</span>
			<span>| 총 ${list.totalElements}명</span>
		</div>
	</div>
	<hr>

	<!-- 문의 -->
	<div>
		<input type="hidden" id="headerSortParam" value="${list.sort}"> <input type="hidden" id="headerPageParam" value="${list.number}">
		<table class="table table-striped" style="width: 100%; text-align: center;">
			<tr style="background-color: rgb(228, 224, 224);">
				<th style="width: 10%;">no</th>
				<th style="width: 20%;">
					<a href="#" class="member-order memId" data-param="memId" data-title="아이디" data-direction=""></a>
				</th>
				<th style="width: 10%;">
					<a href="#" class="member-order memName" data-param="memName" data-title="이름" data-direction=""></a>
				</th>
				<th style="width: 15%;">
					<a href="#" class="member-order memJoinDate" data-param="memJoinDate" data-title="가입일" data-direction=""></a>
				</th>
				<th style="width: 10%;">횟수</th>
				<th style="width: 10%;">더보기</th>
			</tr>
			<c:forEach items="${list.content}" var="memberDto" varStatus="status">
				<fmt:parseDate value="${memberDto.memJoinDate}" var="dateValue" pattern="yyyy-MM-dd'T'HH:mm" />
				<tr>
					<td>${list.totalElements - status.index - (list.size * list.number)}</td>
					<td>${memberDto.memId}</td>
					<td>${memberDto.memName}</td>
					<td>
						<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
					</td>
					<td>${memberDto.projectOrderCount}</td>
					<td>
						<a href="#" class="open-member-detail" data-mem-no="${memberDto.memNo}"><strong><i>MORE</i></strong></a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<br>

	<!-- Pagination -->
	<div class="text-center">
		<ul class="pagination justify-center" style="justify-content: center;">
			<c:if test="${!list.first}">
				<li class="page-item">
					<a href="?" class="page-link">&laquo;</a>
				</li>
				<li class="page-item">
					<a href="?page=${list.number - 1}" class="page-link">&lt;</a>
				</li>
			</c:if>
			<c:set var="pageRange" scope="session" value="5" />
			<fmt:parseNumber var="pageIndex" integerOnly="true" value="${list.number div pageRange}" />
			<c:choose>
				<c:when test="${pageIndex * pageRange + pageRange > list.totalPages - 1}">
					<c:set var="lastPage" scope="session" value="${list.totalPages}" />
				</c:when>
				<c:otherwise>
					<c:set var="lastPage" scope="session" value="${pageIndex * pageRange + pageRange}" />
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${pageIndex * pageRange + 1}" end="${lastPage}">
				<c:choose>
					<c:when test="${list.number + 1 == i}">
						<li class="page-item active">
							<a href="#" class="page-link"><c:out value="${i}" /></a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="?page=${i - 1}" class="page-link"><c:out value="${i}" /></a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${!list.last}">
				<li class="page-item">
					<a href="?page=${list.number + 1}" class="page-link">&gt;</a>
				</li>
				<li class="page-item">
					<a href="?page=${list.totalPages - 1}" class="page-link">&raquo;</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
<div class="layer-background"></div>
<div class="member-detail"></div>