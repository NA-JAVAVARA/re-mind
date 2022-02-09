<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application" />

<!-- header include -->
<jsp:include page="../common/header.jsp"></jsp:include>


<article class="main_content">
	<div class="appointment">
		<div class="title">상담 예약 조회</div>
		<div class="select-area">
			<select>
				<option>전체</option>
				<option>상담 대기</option>
				<option>상담 완료</option>
				<option>상담 취소</option>
			</select>
		</div>
		<div class="appointment_list">
			<ul>
				<li>
					<div>예약 날짜</div>
					<div>예약 시간</div>
					<div>상담사</div>
					<div>상담 유형</div>
					<div>상태</div>
				</li>
				<c:forEach items="${reservationList}" var="reservation">
					<li>
						<div class="img_div"><img src="${contextPath}/resource/images/sample1.jpg"></div>
						<div class="date_div">${reservation.reservationEnrollDate}2022-01-22</div>
						<div class="time_div">${reservation.reservationEnrollTime}:00</div>
						<div class="profession_div">${reservation.professionNo}</div>

						<div class="category_div">채팅</div>
						<c:choose>
							<c:when test="${reservation.reservationStatusCode == 1}">
								<div class="status_div">예약</div>
							</c:when>
							<c:when test="${reservation.reservationStatusCode == 3}">
								<div class="status_div">예약 취소</div>
							</c:when>
							<c:otherwise>
								<div class="status_div">상담 완료</div>
							</c:otherwise>
						</c:choose>
					</li>
				</c:forEach>
			</ul>
		</div>


	</div>


</article>

<!-- header include -->
<jsp:include page="../common/footer.jsp"></jsp:include>

<script>
	$(".profession_div").on("click", function () {
		layerPopup("signUp");
	})



</script>

</body>
</html>



