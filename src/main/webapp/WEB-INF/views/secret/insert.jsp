<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application"/>

<!-- header include -->
<jsp:include page="../common/header.jsp"/>

        <article class="main_content">
            <!-- 메인 -->
            <h3 class="comunity_title">힘들었던 일 모두 털어놓으세요! </h3>
            
            	<div class="free_search_area">
	                    <div class="search_area">
	                        <div class="search_wrap">
	                            <select name="search_category" id="search_category">
	                                <option value="id">닉네임</option>
	                                <option value="content">내용</option>
	                            </select>
	                            <input type="text" name="freeboard_search">
	                            <button type="button" class="submit_btn light_brown_bg" id="freeboard_search"> 검색 </button>
	                        </div>
	                    </div>
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
		                                <textarea class="grey_bg" name="boardContent" id="post_textarea" rows="5" placeholder="무슨일이 있었나요?"></textarea>
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
		                            
		                            <div class="check_box_wrap">
                                       <select id="anonCheckCode" name="anonCheckCode">
										    <option value="1">닉네임 공개</option>
										    <option value="2">닉네임 비공개</option>
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
			                                            <textarea name="boardContent" id="m_post_text" rows="5" placeholder="무슨일이 있었나요?"></textarea>
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
			                                        
			                                          <div class="check_box_wrap">
				                                       <select id="mAnonCheckCode" name="anonCheckCode">
														    <option value="1">닉네임 공개</option>
														    <option value="2">닉네임 비공개</option>
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
		                            	<div class = "reqLogin" style="text-align: center; color: grey; font-size: 20px; margin: auto;">글은 작성하시려면 로그인 해주세요</div>
		                            </div>
	                            </div>
                           	</div>
               	     	</c:otherwise>
                    </c:choose>
                </article>
                
            </form>


        	<div class="free_board_list_wrap" id="BoardListArea">
            
        </article>
    </div>
</main>


<!-- header include -->
<jsp:include page="../common/footer.jsp"/>
<script src="${contextPath}/resources/js/board/board_common.js"></script> 
<script src="${contextPath}/resources/js/board/comunity_freeboard.js"></script> 



<script>
const loginMemberNo = "${loginMember.memberNo}";
$(function () {
	// list 가져오기
	getFreeList();
});

//검색
const searchSelect = $("#freeboard_search");
searchSelect.on("click", function () {

	const searchText = $("[name='freeboard_search']").val().trim();
	if (searchText != "") {
		const data = {
			"searchCategory" : $("#search_category option:selected").val(),
			"searchText" : searchText
		}
		getFreeList(data);
	} else {
		getFreeList();
	}
});

//페이지네이션(무한스크롤 변수 선언)
var currentPage = 1;
var infinityLimit = 5; // 한번에 보여질 result 수
var pageSize = 10;
var listCount, maxPage, startPage, endPage, prevPage, nextPage, first, last;
// 선 계산(ajax로 넘겨야됨)
last = currentPage * infinityLimit;
first = last - (infinityLimit - 1) <= 0 ? 1 : last - (infinityLimit - 1);
function calcPagination(){

   maxPage = Number.parseInt(Math.floor(listCount / infinityLimit));
   startPage = (currentPage-1) / pageSize * pageSize + 1;
   endPage = startPage + pageSize - 1;

   if(endPage > maxPage)   endPage = maxPage;

   if(currentPage <= infinityLimit)   prevPage = 1;
   else                    prevPage = startPage - 1;

   if(endPage == maxPage) nextPage = maxPage;
   else               nextPage = endPage + 1;

   last = currentPage * infinityLimit;
   first = last - (infinityLimit - 1) <= 0 ? 1 : last - (infinityLimit - 1);
}
calcPagination()


// 무한스크롤
function YesScroll () {
   if(last >= listCount)   return;

   const pagination = document.querySelector('.paginaiton');
   const fullContent = document.querySelector('.main_content');
   const screenHeight = screen.height;

   let oneTime = false;
   document.addEventListener('scroll',OnScroll,{passive:true})
   function OnScroll () {
      const fullHeight = fullContent.clientHeight;
      const scrollPosition = pageYOffset;

	   // console.log(fullHeight - screenHeight/2, scrollPosition)
      
      if (fullHeight-screenHeight/2 - 100<= scrollPosition && !oneTime) {
         oneTime = true;
         currentPage = currentPage + 1;
         calcPagination();
         getFreeList();
      }
   }
}

//list 가져오기
function getFreeList(searchData) {
let data = {};

if (searchData != null) {
	data = searchData;
}

	$.ajax({
		url : "${contextPath}/secret/list",
		type : "POST",
		data : {
			"last":last,
			"first":first
		},
		dataType:"JSON",
		success : function (result) {
			YesScroll();

			let html = "";
			var secretBoardList = $('#BoardListArea')
			let empathyArr;
			let empathyCntArr;
			let iconCnt = {};

			$.each(result, function (i, item) {
				console.log(item)
				if(result.length - 1 == i){
					listCount = Number.parseInt(item.maxValue);
					return;
				}

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

				const board_list_content = $('<div class="board_list_content">');
				html+=   '<div class="board_list_content">'
						+'	<div class="board_flex_wrap">'
						+'		<div class="writer_pic_wrap">'
						+'			<div class="writer_pic light_brown_bg" style="background-image: url();"></div>';

				 if(loginMemberNo != item.memberNo){
					html +='			<ul class="userMenu hidden">'
						+'				<li> <a class="block"> 차단</a> </li>'
						+'				<input class="hidden" value = '+ item.memberNo +'>'
						+'				<li> <a href=""> 검색</a> </li>'
						+'			</ul>'
						+'		</div>';
				}else{
					html+='		</div>';
				}

				
				html+='    </div>'
					+'</div>'
		});
		$(".free_board_list_wrap").append(html);

	},
	error : function(request, status, error){
		console.log("ajax 통신 중 오류 발생");
		console.log(request.responseText);
	}


				html+='		<a href="${contextPath}/secret/view/'+item.boardNo+'">'
					+'			<div class="posting_info">'
					+'				<div class="writer_id">'
					+'					<p class="userInfo">'+item.memberFn+'</p>'
					+'					<p>'+item.createDate+'</p>'
					+'				</div>'
					+'				<div class="posting">'
					+'					<p>'+item.boardContent+'</p>'
					+'				</div>'
					+'			</div>'
					+'		</a>'
					+'	</div>'
					+'	<div class="board_icon_wrap">';
					console.log(typeof item.replyCheckCode);
					if(item.replyCheckCode == 1){
						html += `
							<div class="comment_wrap">
								<i class="far fa-comment dark-brown"> ` + item.replyCount + `</i>
								<p></p>
							</div>
						`
					}else{
						html += '<div class="comment_wrap"></div>';
					}

					if(item.empathyCheckCode == 1){
						html+='		<div class="like_warp">'
							+'            <img src="${contextPath}/resources/images/icon/smile.png" alt="">'
							+'            <p>'+iconCnt[1001]+'</p>'
							+'            <img src="${contextPath}/resources/images/icon/hug.png" alt="">'
							+'            <p>'+iconCnt[1002]+'</p>'
							+'           <img src="${contextPath}/resources/images/icon/amazed.png" alt="">'
							+'           <p>'+iconCnt[1003]+'</p>'
							+'           <img src="${contextPath}/resources/images/icon/angry.png" alt="">'
							+'           <p>'+iconCnt[1004]+'</p>'
							+'           <img src="${contextPath}/resources/images/icon/crying.png" alt="">'
							+'           <p>'+iconCnt[1005]+'</p>'
							+'        </div>';
					}else{
						html+='		<div class="like_warp">'
						+'        </div>';
					}

					html+='    </div>'
						+'</div>'
			});
			$(".free_board_list_wrap").append(html)

		},
		error : function(request, status, error){
			console.log("ajax 통신 중 오류 발생");
			console.log(request.responseText);
		}


	});
}
getFreeList()



//파일 업로드 스크립트
$(document).ready(function()
		// input file 파일 첨부시 fileCheck 함수 실행
		{
			$("#addFileBtn").on("change", fileCheck);
		});
		

//파일 현재 필드 숫자 totalCount랑 비교값
var fileCount = 0;
//해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
var totalCount = 5;
//파일 고유넘버
var fileNum = 0;
//첨부파일 배열
var content_files = new Array();

var delete_files = new Array();

function fileCheck(e) {
  var files = e.target.files;
  
  // 파일 배열 담기
  var filesArr = Array.prototype.slice.call(files);
  
  // 파일 개수 확인 및 제한
  if (fileCount + filesArr.length > totalCount) {
    alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
    return;
  } else {
  	 fileCount = fileCount + filesArr.length;
  }
  
  // 각각의 파일 배열담기 및 기타
  filesArr.forEach(function (f) {
    var reader = new FileReader();
    reader.onload = function (e) {
	
      content_files.push(f);
      
      $('#imgWrap').append(
     		'<div id="img'+fileNum+'"class="boardImg"> <img src="'+ e.target.result+'">'
     		+'<div class="deleteImg" onclick="fileDelete(\'file' + fileNum + '\')"><i class="fas fa-times"></i></div>'
     		+'</div>'
		);
      fileNum ++;
    };
    reader.readAsDataURL(f);
  });
  console.log(content_files);
  //초기화 한다.
  $("#input_file").val("");
}

//파일 부분 삭제 함수
function fileDelete(fileNum){
  var no = fileNum.replace(/[^0-9]/g, "");
  content_files[no].is_delete = true;
  
	$('#img' + no).remove();
	
	fileCount --;
  console.log(content_files);
}



function postingValidate(){
	//사진 배열에 담기
	const form = $("form")[0];
	const formData = new FormData(form);

	for (let i = 0; i < content_files.length; i++) {
		// 삭제 안한것만 담아 준다. 
		if(!content_files[i].is_delete){
			formData.append('images', content_files[i]);
		}else{
			delete_files.push(content_files[i]);
			formData.append('deletImages',delete_files[i]);
		}
	}

	//삽입
	$.ajax({
		type: "POST",
		enctype: "multipart/form-data",
		url: "insert",
		data : formData,
		processData: false,
		contentType: false,
		success: function (result) {
			if(result > 0){
              swal({"title" : "글이 작성되었습니다." , 
                    "icon" : "success"});
 	    		$("#input_file").val("");
 	    		const imgWrap = document.querySelector("#imgWrap");

				while (imgWrap.hasChildNodes()) {	// 부모노드가 자식이 있는지 여부를 알아낸다
					imgWrap.removeChild(
						imgWrap.firstChild
					);
				}

				// 내용삭제
				$("#post_textarea").val(""); 
				$("replyCheckCode").val("1");
				$("scrapCheckCode").val("1");
				$("empathyCheckCode").val("1");

				// 새로 고침
				getFreeList();
				// location.reload();
			} else
			    swal({"title" : "글작성 실패" , 
                    "icon" : "error"});
			},
		error: function (xhr, status, error) {
			    swal({"title" : "서버 연결 오류" , 
                    "icon" : "error"});
		}
  });

	return false;
}
	
	


</script>