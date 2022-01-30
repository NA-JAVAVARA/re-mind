<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application" />

<!-- header include -->
<jsp:include page="../common/header.jsp"></jsp:include>

	         <section class="main_content">    
	            <!-- 메인 -->
	
	            <div class="back_btn">
	                <a href="">
	                    <i class="fas fa-arrow-left"></i> 
	                </a>
	            </div>
	
	
	            <button type="button" class="submit_btn dark_brown_bg" id="worryCategoryBtn">카테고리</button>
	
	
	            <form action="">
	                <div class="worry_category_wrap hidden">
	                    <div class="worry_category">
	
	                        <div class="check_box_wrap">
	                            <label for="normal" class="dark-brown dark_brown_border"> 
	                                일반고민
	                                <input type="radio" id="normal" name="worryCategory" value="normal">
	                            </label>
	                        </div>
	                        <div class="check_box_wrap">
	                            <label for="normal" class="dark-brown dark_brown_border"> 
	                                일반고민
	                                <input type="radio" id="normal" name="worryCategory" value="normal">
	                            </label>
	                        </div>
	                        <div class="check_box_wrap">
	                            <label for="normal" class="dark-brown dark_brown_border"> 
	                                일반고민
	                                <input type="radio" id="normal" name="worryCategory" value="normal">
	                            </label>
	                        </div>
	                        <div class="check_box_wrap">
	                            <label for="normal" class="dark-brown dark_brown_border"> 
	                                일반고민
	                                <input type="radio" id="normal" name="worryCategory" value="normal">
	                            </label>
	                        </div>
	                        <div class="check_box_wrap">
	                            <label for="normal" class="dark-brown dark_brown_border"> 
	                                일반고민
	                                <input type="radio" id="normal" name="worryCategory" value="normal">
	                            </label>
	                        </div>
	                        <div class="check_box_wrap">
	                            <label for="normal" class="dark-brown dark_brown_border"> 
	                                일반고민
	                                <input type="radio" id="normal" name="worryCategory" value="normal">
	                            </label>
	                        </div>
	                        <div class="check_box_wrap">
	                            <label for="normal" class="dark-brown dark_brown_border"> 
	                                일반고민
	                                <input type="radio" id="normal" name="worryCategory" value="normal">
	                            </label>
	                        </div>
	                        
	                    </div>
	                </div>
	
	                <article class="board_update_wrap">
	<!--                         <div class="profile_wrap">
	                            <div class="writer_pic light_brown_bg" style="background-image: url();">
	                            </div>
	
	                            <div class="writer_id">
	                                <p>아이디</p>
	                            </div>
	                        </div> -->
	                    
	
	
	                    <div class=" posting">
	                        <textarea>dlknfa'wiendl/gnper</textarea>
	                        <div class="post_img"></div>
	                    </div> 
	                    
	                    
	                    <div class="btn_area">
	                        <a>
	                            <i class="fas fa-image dark-brown"></i>
	                        </a>
	                        
	                        <div class="write_option_area">
		                        <div class="check_box_wrap">
	                                <label for="comment" class="option_btn light_brown_bg">댓글허용
	                                    <input type="checkbox" name="writeOption" value="" id="comment">
	                                </label>
	                            </div>
	
	                            <div class="check_box_wrap">
	                                <label for="scrap" class="option_btn light_brown_bg">스크랩허용
	                                    <input type="checkbox"  name="writeOption" value="" id="scarp">
	                                    
	                                </label>
	                            </div>
	                            
	                            <div class="check_box_wrap">
	                                <label for="like" class="option_btn light_brown_bg"> 공감 허용
	                                    <input type="checkbox"  name="writeOption" value="" id="like">
	
	                                </label>
	                        	</div>	
	                        </div>
	                        
	                    </div>
	                </article>
	
	                <div class="edit_btn_wrap">
	                    <button type="button" class="dark-brown edit_btn" onclick=""> 수정 </button>
	                    <button type="button" class="dark-brown edit_btn" onclick=""> 취소  </button>
	                </div>
	            </form>
	
	        </section>
	    </div>
	
	</main>
<!-- header include -->
<jsp:include page="../common/footer.jsp"></jsp:include>
<script type="text/javascript" src="${contextPath}/resources/js/board/comunity_worry_board.js"></script>

</body>
</html>