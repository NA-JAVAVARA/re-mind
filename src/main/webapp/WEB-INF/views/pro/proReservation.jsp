<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application" />

<!-- header include -->
<jsp:include page="../common/header.jsp"></jsp:include>

<article class="main_content22">
	 <div id="reservation_confirm_wrap" class="float-left">
	     <div id="reservation_confirm">
	         <div style="height: 125px;">
	             <img src="${contextPath}/resources/images/pro/pro_img/pro_img1_1.png" class="float-left" style="width:125px; height: 125px;">
	             <div class="reservation_confirm_proname float-left">
	                 <p style="font-size: 13px; font-weight: 500; color:#a59999">추천상담사</p>
	                 <h1>김효린상담사</h1>
	             </div> 
	         </div>
	         
	         <div id="tuition" class="clear-both box_style">
	             <div class="pro_reservation">
	                 <table class="pro_reservation_select">
	                     <tr>
	                        <th>테라피 선택</th>
	                         <td>
	                         <select class="select_box">
	                             <option value="0">선택</option>
	                             <option value="25000">텍스트테라피</option>
	                             <option value="50000">페이스테라피</option>
	                             <option value="35000">보이스테라피</option>
	                         </select> 
	                         </td> 
	                     </tr>
	                     <tr>
	                         <th>횟수</th>
	                         <td>
	                         <select class="select_box">
	                             <option value="0">선택</option>
	                             <option value="1">1회</option>
	                             <option value="5">3회</option>
	                             <option value="10">5회</option>
	                             <option value="20">20회</option>
	                         </select> 
	                         </td> 
	                     </tr>
	                 </table>
	             </div>
	         </div>
	         
	         <div id="tuition_date" class="box_style">
	             <p class="tuition_font">첫번째 상담 날짜 선택 <span class="tuition_sub">*두번째 상담부터는 마이페이지에서 지정해 주세요.</span></p>
				 <div style="text-align: center; font-width: bold;">
					 <div style="float: left; font-width: bold; "><</div>
					 <div style="display: inline-block; font-size: 20px;">2022년 1월</div>
					 <div style="float: right; font-width: bold;">></div>
				 </div>
				 <table>
					 <thead>
					 	<tr>
							<td>일</td>
							<td>월</td>
							<td>화</td>
							<td>수</td>
							<td>목</td>
							<td>금</td>
							<td>토</td>
						</tr>
					 </thead>
					 <tbody>
					 	<tr>
							<td>1</td>
							<td>2</td>
						</tr>
					 </tbody>
				 </table>
	         </div>
	         
	         <div id="tuition_time_wrap" class="box_style">
	             <p class="tuition_font">시간 선택</p>
	             <div id="tuition_time">
	                 <select id="time_select">
	                     <option>선택</option>
	                     <option>08:00</option>
	                     <option>10:00</option>
	                     <option>12:00</option>
	                     <option>14:00</option>
	                     <option>16:00</option>
	                     <option>18:00</option>
	                 </select> 
	                      
	             </div>
	         </div>
	     </div>
	</div>
	<div id="reservation_pay_wrap" class="float-right">
	    <div id="reservation_pay">
	        <div class="pro_price">
	             <p class="float-left pro_price_title">테라피 선택</p>
	             <p id="therapy_chk" class="float-right">보이스테라피</p>
	         </div>
	
	         <div class="pro_price clear-both">
	             <p class="float-left pro_price_title">횟수 합계</p>
	             <p id="therapy_count_chk" class="float-right">5회</p>
	         </div>
	
	         <div class="pro_price clear-both">
	             <p class="float-left pro_price_title">첫번째 수강 날짜</p>
	             <p id="date_chk" class="float-right">1월 27일</p>
	         </div>
	
	         <div class="pro_price clear-both">
	             <p class="float-left pro_price_title">시간</p>
	             <p id="time_chk" class="float-right">10:00</p>
	         </div>
	    </div>
	     
	     <div class="pro_price clear-both">
	         <p class="float-left pro_price_title">수강료 합계</p>
	         <p id="price" class="float-right">0<span>원</span></p>
	     </div>
	
	     <div class="final_pay clear-both">
	         <button onclick="requestPay();">
	             결제하기
	         </button>
	     </div>
	</div>
</article>

<!-- header include -->
<jsp:include page="../common/footer.jsp"></jsp:include>
<!-- js -->
<script type="text/javascript" src="${contextPath}/resources/js/pro/pro.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-{SDK-최신버전}.js"></script>



</body>
</html>