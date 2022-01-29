<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application" />

<!-- header include -->
<jsp:include page="../common/header.jsp"></jsp:include>

        <section class="main_content">    
            <!-- 메인 -->
            <h3 class="comunity_title">자유롭게 글을 남겨주세요</h3>
            
            <form action="/list" method="post" onsubmit="return ostingValidate()">
            
                <div class="search_area">
                <select name="search_category" id="">
                    <option value="">아이디</option>
                    <option value="">내용</option>
                </select>
                <input type="text" name="freeboard_search">
                <button class="submit_btn light_brown_bg"> 검색 </button>
                </div>

                <article id="free_borad_wrap">
                    <!-- 글작성 -->
                    <div class="board_write_warp grey_bg " >
                        <div id="free_board_write">
                            <div class="writer_pic_wrap">
                                <div class="writer_pic light_brown_bg" style="background-image: url();">
                                    
                                </div>
                            </div>
                            <div class="writing">
                                <textarea class="grey_bg" name="" id="post_textarea" rows="5" placeholder="무슨일이 있었나요?"></textarea>
                            </div>
                        </div>
                        
                        <div class="write_option_area">
                            <div class="check_box_wrap">
                                <label for="mComment" class="light_brown_bg">댓글허용
                                    <input type="checkbox"  name="writeOption" value="" id="mComment" checked>
                                </label>
                            </div>

                            <div class="check_box_wrap">
                                <label for="mScrap" class="light_brown_bg">스크랩허용
                                    <input type="checkbox"  name="writeOption" value="" id="mScarp" checked>
                                    
                                </label>
                            </div>
                            
                            <div class="check_box_wrap">
                                <label for="mLike" class="light_brown_bg"> 공감 허용
                                    <input type="checkbox"  name="writeOption" value="" id="mLike" checked>

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

                        <!-- 모바일 글쓰기 모달창 -->
                    <div class="posting_modal_warp hidden">
                        <div class="modal">
                            <article id="m_free_borad_wrap">
                                <!-- 글작성 -->
                                <div class="m_board_write_warp " >
                                    <div id="m_free_board_write">
                                        <i class="fas fa-times" id="closeModal"></i>
                                        <div class="writer_wrap">
                                            <div class="writer_pic light_brown_bg" style="background-image: url();">
                                            </div>
                                            <div class="m_writing">
                                                <textarea name="writePost" id="m_post_text" rows="5" placeholder="무슨일이 있었나요?"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="m_write_option_area">
    
                                        <div class="write_option_area">
                                            <div class="check_box_wrap">
                                                <label for="comment" class="light_brown_bg">댓글허용
                                                    <input type="checkbox" name="writeOption" value="" id="comment" checked>
                                                </label>
                                            </div>
    
                                            <div class="check_box_wrap">
                                                <label for="scrap" class="light_brown_bg">스크랩허용
                                                    <input type="checkbox"  name="writeOption" value="" id="scarp" checked>
                                                    
                                                </label>
                                            </div>
                                            
                                            <div class="check_box_wrap">
                                                <label for="like" class="light_brown_bg"> 공감 허용
                                                    <input type="checkbox"  name="writeOption" value="" id="like" checked>
    
                                                </label>
                                            </div>
                                    </div>
                                    
                                    <hr>
    
                                    <div class="m_submit_btn_wrap">
                                        <a>
                                            <i class="fas fa-image dark-brown"></i>
                                        </a>
    
                                        <div class="m_btn_area">
                                            <button class="submit_btn light_brown_bg">작성</button>
                                            
                                            <button class="submit_btn dark_brown_bg"  button type="button" onclick="">취소</button>
                                        </div>
                                    </div>
                                </div>
    
                        </div>
                    </div>
                </article>
                
            </form>



            <!-- 게시판 리스트 -->
            <div class="free_board_list_wrap">

                <!-- 게시판 하나 시작  -->
                <div class="board_list_content">
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
                </div>
            </div>    
        </section>
    </div>
</main>


<!-- header include -->
<jsp:include page="../common/footer.jsp"></jsp:include>
<script type="text/javascript" src="${contextPath}/resources/js/board/comunity_freeboard.js"></script>

</body>
</html>
