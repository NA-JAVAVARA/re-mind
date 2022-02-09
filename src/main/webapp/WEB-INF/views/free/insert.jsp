<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application"/>

<!-- header include -->
<jsp:include page="../common/header.jsp"/>

        <section class="main_content">    
            <!-- 메인 -->
            <h3 class="comunity_title">자유롭게 글을 남겨주세요</h3>
            
              <div class="search_area">
              <select name="search_category" id="">
                  <option value="">아이디</option>
                  <option value="">내용</option>
              </select>
              <input type="text" name="freeboard_search">
              <button class="submit_btn light_brown_bg"> 검색 </button>
              </div>
              
			<form action="insert" method="post" enctype="multipart/form-data" role="form" onsubmit="return postingValidate()">
                <article id="free_borad_wrap">
                    <!-- 글작성 -->
                    <c:choose>
						<c:when test="${!empty loginMember}">
	                   	 	<div class="board_write_warp grey_bg " >
		                        <div id="free_board_write">
		                            <div class="writer_pic_wrap">
		                                <div class="my_pic light_brown_bg" style="background-image: url(${contextPath}/resources/images/member/${loginMember.memberImage});"> </div>
		                            </div>
		                            <div class="writing">
		                                <textarea class="grey_bg" name="boardContent" id="post_textarea" rows="5" onkeydown="resize(this)" onkeyup="resize(this)" placeholder="무슨일이 있었나요?"></textarea>
		                            </div>
		                        </div>
		                        
		                        <div id="imgWrap">
								</div>
		                        
		                        <div class="write_option_area">
		                            <div class="check_box_wrap">
                                       <select id="replyCheckCode" name="replyCheckCode">
										    <option value="1">댓글 허용</option>
										    <option value="2">댓글 비허용</option>
									    </select>  		                            
		                            </div>
		
		                            <div class="check_box_wrap">
                                       <select id="scrapCheckCode" name="scrapCheckCode">
										    <option value="1">스크랩 허용</option>
										    <option value="2">스크랩 비허용</option>
									    </select>  		                            
		                            </div>
		                            
		                            <div class="check_box_wrap">
                                       <select id="empathyCheckCode" name="empathyCheckCode">
										    <option value="1">공감 허용</option>
										    <option value="2">공감 비허용</option>
									    </select>  		                            
		                            </div>
		                        </div>
		                        
		                        <hr>
		                        <div class="btn_area">
		                            <label for="addFileBtn">
		                                <i class="fas fa-image dark-brown" ></i>
		                            </label>
		                            	<!-- name="images" -->
										<input type="file"  id='addFileBtn' accept="audio/*, video/*, image/*" multiple style="display: none"> 
		                            <button class="submit_btn light_brown_bg">작성</button>
		                        </div>
		                    </div> 
                        <!-- 모바일 글쓰기 모달창 -->
			                <div class="posting_modal_warp hidden">
			                    <div class="modal">
			                        <article id="m_free_borad_wrap">
			                            <!-- 글작성 -->
			                            <div class="m_board_write_warp ">
			                                <div id="m_free_board_write">
			                                    <i class="fas fa-times" id="closeModal"></i>
			                                    <div class="writer_wrap">
			                                        <div class="my_pic light_brown_bg" style="background-image: url();">
			                                        </div>
			                                        <div class="m_writing">
			                                            <textarea name="boardContent" id="m_post_text" rows="5" onkeydown="resize(this)" onkeyup="resize(this)" placeholder="무슨일이 있었나요?" ></textarea>
			                                        </div>
			                                    </div>
			                                </div>
			                                
			                               <div class="m_write_option_area">
			
			                                    <div class="write_option_area">
			                                       <div class="check_box_wrap">
			                                       <select id="mReplyCheckCode" name="replyCheckCode">
													    <option value="1">댓글 허용</option>
													    <option value="2">댓글 비허용</option>
												    </select>  
												    </div>
			
			                                        <div class="check_box_wrap">
				                                       <select id="mScrapCheckCode" name="scrapCheckCode">
														    <option value="1">스크랩 허용</option>
														    <option value="2">스크랩 비허용</option>
													    </select>  
			                                        </div>
			                                        
			                                        <div class="check_box_wrap">
				                                       <select id="mEmpathyCheckCode" name="empathyCheckCode">
														    <option value="1">공감 허용</option>
														    <option value="2">공감 비허용</option>
													    </select>  
			                                        </div>
			                              		</div>
			                                
				                                <hr>
				
				                                <div class="m_submit_btn_wrap">
						                          	<label for="mfile">
						                               <i class="fas fa-image dark-brown"></i>
						                           	</label>
						                           	<!-- name="images" -->
													<input type="file"  id='mfile' accept="audio/*, video/*, image/*" multiple onchange="loadImg();" style="display: none"> 
				
				                                    <div class="m_btn_area">
				                                        <button class="submit_btn light_brown_bg">작성</button>
				                                        <button class="submit_btn dark_brown_bg" button type="button" onclick="">취소</button>
				                                    </div>
				                                </div>
			                           		</div>
			                        	</div>
	                        		</article>
	                        	 </div>
		                     </div>
               	     	</c:when>
               	     	<c:otherwise>
               	     		<div class="board_write_warp grey_bg " >
               	     			<div id="free_board_write">
		                            <div class="writing" style="min-height: 100px;">
		                            	<div  class = "reqLogin" style="text-align: center; color: grey; font-size: 20px; margin: auto;">글은 작성하시려면 로그인 해주세요</div>
		                            </div>
	                            </div>
                           	</div>
               	     	</c:otherwise>
                    </c:choose>
                </article>
                
            </form>

			 <div class="free_board_list_wrap" id="BoardListArea">
			 
			 </div>
            <!-- 게시판 리스트 -->
          <%--   <jsp:include page="list.jsp"/>  --%>
            
        </section>
    </div>
</main>


<!-- header include -->
<jsp:include page="../common/footer.jsp"/>
<script src="${contextPath}/resources/js/board/board_common.js"></script>
<script src="${contextPath}/resources/js/board/comunity_freeboard.js"></script>

<script>
$(function () {
	// list 가져오기
	getFreeList();
})


	// 검색
	const searchSelect = $("#freeboard_search");
	searchSelect.on("click", function () {
		
		const data = {
			"searchCategory" : $("#search_category option:selected").val(),
			"searchText" : $("[name='freeboard_search']").val()
		}

		getFreeList(data);
	});
	
	// list 가져오기
	function getFreeList(searchData) {
		let data = {};

		if (searchData != null) {
			data = searchData;
		}

		$.ajax({
			url : "${contextPath}/free/list",
			type : "POST",
			data : data,
			success : function (result) {

				let html = "";
				let empathyArr;
				let empathyCntArr;
				let iconCnt = {};

				$.each(result.freeBoardList, function (i, item) {

					// empathy 초기화
					empathyArr = [];
					empathyCntArr = [];
					iconCnt = {
						"1001" : 0,
						"1002" : 0,
						"1003" : 0,
						"1004" : 0,
						"1005" : 0
					};

					if (item.worryEmpathyArray != null) {
						empathyArr = (item.worryEmpathyArray).split(",");
						empathyCntArr = (item.worryCntArray).split(",");
					}

					for(i=0; i<empathyArr.length; i++) {
						iconCnt[empathyArr[i]] = empathyCntArr[i];
					}

					html += `
						<div class="board_list_content">
							<div class="board_flex_wrap">
								<div class="writer_pic_wrap">
									<div class="writer_pic light_brown_bg" style="background-image: url();"></div>
									<ul class="userMenu hidden">
										<li> <a href=""> 차단</a> </li>
										<li> <a href=""> 검색</a> </li>
									</ul>
								</div>
								<a href="">
									<div class="posting_info">
										<div class="writer_id">
											<p class="userInfo">` + item.memberId + `</p>
											<p> ` + item.createDate + `</p>
										</div>
										<div class="posting">
											<p>` + item.boardTitle + `</p>
										</div>
									</div>
								</a>
							</div>
							<div class="board_icon_wrap">
								<div class="comment_wrap">
	                                <i class="far fa-comment dark-brown"></i>
	                                <p>` + 5 + `</p>
	                            </div>
								<div class="like_warp">
	                                <img src="${contextPath}/resources/images/icon/smile.png" alt="" data-icon="1001">
	                                <p>`+ iconCnt[1001] +`</p>
	                                <img src="${contextPath}/resources/images/icon/hug.png" alt="" data-icon="1002">
	                                <p>`+ iconCnt[1002] +`</p>
	                                <img src="${contextPath}/resources/images/icon/amazed.png" alt="" data-icon="1003">
	                                <p>`+ iconCnt[1003] +`</p>
	                                <img src="${contextPath}/resources/images/icon/angry.png" alt="" data-icon="1004">
	                                <p>`+ iconCnt[1004] +`</p>
	                                <img src="${contextPath}/resources/images/icon/crying.png" alt="" data-icon="1005">
	                                <p>`+ iconCnt[1005] +`</p>
	                            </div>
	                        </div>
						</div>
					`;
					});
				$(".free_board_list_wrap").html(html);
				
				


			},
			error : function(request, status, error){
				console.log("ajax 통신 중 오류 발생");
				console.log(request.responseText);
			}


		});
	}

</script>
