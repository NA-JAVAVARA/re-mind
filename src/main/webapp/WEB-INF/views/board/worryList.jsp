<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application" />

<!-- header include -->
<jsp:include page="../common/header.jsp"></jsp:include>

	        <section class="main_content">    
	            <!-- 메인 -->
	            <div  class="comunity_title">
	                <h3>고민을 나눠보면 어떨까요?</h3>
	                <p> 회원분들과 전문가분들이 여러분을 도와주실거에요.</p>
	                <button id="openModal" class="submit_btn"> 고민 작성하기 </button>
	            </div>
	            
	
	            <form action="/list" method="post" onsubmit="return ostingValidate()">
	                <div class="worry_top_wrap">
	                    <div class="worry_category" >
	                        <button type="button" class="submit_btn dark_brown_bg" id="worryCategoryBtn" >카테고리</button>
	                    </div>
	
	                    <div class="search_area">
	                    
	                        <div class="search_wrap">
	                            <select name="search_category" id="search_category">
	                                <option value="">아이디</option>
	                                <option value="">내용</option>
	                            </select>
	                            <input type="text" name="freeboard_search">
	                            <button class="submit_btn light_brown_bg"> 검색 </button>
	                        </div>
	                    </div>
	                </div>
	                <!-- 카테고리 숨김 -->
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
	
	                <!-- 글작성 모달창 -->
	                <div class="postModal hidden">
	                    <div class="postModal_overlay"></div>
	                    <div class="board_write_warp">
	                        <div id="free_board_write">
	                            <i id="closeModal" class="fas fa-times"></i>
	                            <h4>고민 작성하기</h4>
	
	                            <button type="button" class="submit_btn dark_brown_bg" id="openCategoryBtn" >카테고리</button>
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
								<div class="post_title">
									<input type="text" id="postTitle" name="postTitle" placeholder="제목을 입력해주세요">
								</div>
	                            <div class="writing">
	                                <textarea class="grey_bg" name="" id="post_textarea" rows="15" placeholder="무슨 고민이 있나요?"></textarea>
	                            </div>
	                        </div>
	                        
	                        <div class="write_option_area">
	                            <div class="check_box_wrap">
	                                <label for="comment" class="light_brown_bg white">댓글허용
	                                    <input type="checkbox" id="comment" name="write_option" value="comment">
	                                </label>
	                            </div>
	
	                            <div class="check_box_wrap">
	                                <label for="scrap" class="light_brown_bg white">스크랩허용
	                                    <input type="checkbox" id="scarp"  name="write_option" value="scarp">
	                                    
	                                </label>
	                            </div>
	                            
	                            <div class="check_box_wrap">
	                                <label for="like" class="light_brown_bg white"> 공감 허용
	                                    <input type="checkbox" id="like"  name="write_option" value="like" >
	
	                                </label>
	                            </div>
	                            
	                        </div>
	                        
	                        <hr>
	                        <div class="btn_area">
	                            <a>
	                                <i class="fas fa-image dark-brown"></i>
	                            </a>
	                            <button class="submit_btn light_brown_bg">작성</button>
	                        </div>
	                    </div>
	                </div>
	            </form>
	
	            <article id="free_borad_wrap">
	
	                <!-- 게시판 리스트 -->
	                <div class="free_board_list_wrap">
	
	                        <!-- 게시판 하나 시작  -->
	                        <div class="board_list_content">
	                            <a href="">
	                            <!-- 프로필 시작 -->
	                            <div class="board_flex_wrap">
	                                <div class="writer_pic_wrap">
	                                    <div class="writer_pic light_brown_bg" style="background-image: url();">
	                                    </div>
	                                </div>
	
	                                <!-- 포스트 시작 -->
	                                <div class="posting_info">
	                                    <div class="writer_id">
	                                        <p>아이디</p> 
	                                        <p> 5분전</p>
	                                    </div>
	                                    <div class="posting">
	                                        <p>저는 오늘 마라탕을 시켰는데요 마라마라마라탕~~~ </p>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="board_icon_wrap">
	                                <!-- 댓글 아이콘 -->
	                                <div class="commnet_wrap">
	                                    <i class="far fa-comment dark-brown"></i>
	                                    <p>3</p>
	                                </div>
	
	                            <!-- 공감수 표시 -->
	                                <div class="like_warp">
	                                    <img src="${contextPath}/resources/images/icon/smile.png" alt="">
	                                    <p>2</p>
	                                    <img src="${contextPath}/resources/images/icon/hug.png" alt="">
	                                    <p>2</p>
	                                    <img src="${contextPath}/resources/images/icon/amazed.png" alt="">
	                                    <p>2</p>
	                                    <img src="${contextPath}/resources/images/icon/angry.png" alt="">
	                                    <p>2</p>
	                                    <img src="${contextPath}/resources/images/icon/crying.png" alt="">
	                                    <p>2</p>
	                                </div>
	                            </div>
	                            </a>
	                        </div>
	
	                </div>
	
	            </article>
	        
	        </section>
	    </div>
	</main>

<!-- header include -->
<jsp:include page="../common/footer.jsp"></jsp:include>
<script type="text/javascript" src="${contextPath}/resources/js/board/comunity_worry_board.js"></script>

