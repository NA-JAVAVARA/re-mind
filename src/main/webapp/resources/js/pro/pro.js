// 상담사 목록페이지 카테고리 선택(pc)
$(".cate_btn").on("click",function(){
    
    if($(this).hasClass('cate_btn_click')){
        $(this).removeClass('cate_btn_click'); 
    }else{ 
        if($(".cate_btn_click").length > 4){
            alert("최대 5개만 선택할 수 있어요!");
        }else{
            $(this).addClass('cate_btn_click');
        }    
    }    
});    

// 상담사 목록페이지 카테고리 선택(모바일)
$(".mobile_cate_btn").on("click",function(){

    if($(this).hasClass('mobile_cate_btn_click')){
        $(this).removeClass('mobile_cate_btn_click'); 
    }else{ 
        if($(".mobile_cate_btn_click").length > 4){
            alert("최대 5개만 선택할 수 있어요!");
        }else{
            $(this).addClass('mobile_cate_btn_click');
        }
    }
});

// 상담사 상세페이지 네비게이션 (상담사 한마디, 후기)
$(".detail_btn").on("click",function(){
    
    $(".detail_btn").removeClass("detail_contents_click");
    $(this).addClass("detail_contents_click");

});    

// 예상 수강료
let therapySelect;
let therapyCount;
let finallyPrice; // 최종 가격

// ********** 상담사 별 가격 가지고 올 예정
let textTherapy = 100;
let faceTherapy = 100;
let voiceTherapy = 100;
// **********

$("#therapy_select").change(function(){
    therapySelect = $(this).val();
  
    if(therapySelect == 1){
        finallyPrice = textTherapy*therapyCount;
    }else if(therapySelect == 2){
        finallyPrice = faceTherapy*therapyCount;
    }else if(therapySelect == 3){
        finallyPrice = voiceTherapy*therapyCount;
    }

    

    calc();
    
    therapySelectText = $("#therapy_select option:selected").text();
    $("#therapy_chk").text(therapySelectText);
});    

$("#therapy_count").change(function(){ 
    therapyCount = $(this).val();

    if(therapySelect == 1){
        finallyPrice = textTherapy*therapyCount;
    }else if(therapySelect == 2){
        finallyPrice = faceTherapy*therapyCount;
    }else if(therapySelect == 3){
        finallyPrice = voiceTherapy*therapyCount;
    }


    calc();
    
    therapyCountText = $("#therapy_count option:selected").text();
    $("#therapy_count_chk").text(therapyCountText);
});    

// 상담가격 , 천단위 콤마
function calc(){
    if(finallyPrice != undefined && finallyPrice != 0 && finallyPrice != NaN){
        if(therapyCount != undefined && therapyCount != 0){
            var price = Number(finallyPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            $("#price").html(price + "<span>원</span>");
        }else{

        }    
    }    
}    

// 시간 선택
$("#time_select").change(function(){
    timeSelect = $("#time_select option:selected").text();

    $("#time_chk").text(timeSelect);
});    

// 날짜 선택
let asff;
let splitYear;
let splitMonth;
let splitDate;


$(document).on("click", "#calendar td", function (){
    const index = $("#calendar td").index($(this));

    if(index < 7)   return;
    if($(this).css("color") == "rgb(197, 202, 205)")    return;

    asff= $("#ym").text().split("년 ");
    splitYear = asff[0];
    splitMonth = asff[1].split("월");
    splitDate = $(this).attr("id");
    

    if(splitDate != undefined && $(this).css("color") != "rgb(197, 202, 205)"){
        $("#date_chk").text(splitYear +"-"+splitMonth[0]+"-"+ splitDate);
    }
});

// 상담사 목록페이지 카테고리 선택(모바일)
$("#mobile_category_btn").on("click",function(){
    $("#mobile_pro_category").css("display","block");
    $("#header").css("display","none");
    $("#mobile_category_btn").css("display","none");
});    

$("#category_cancel_btn").on("click",function(){
    
    $("#mobile_pro_category").css("display","none");
    $("#header").css("display","block");
    $("#mobile_category_btn").css("display","block");
});    


// 결제
function requestPay(){
   
    if($("#therapy_chk").text() == "선택"){
        alert("테라피를 선택해주세요");
        return;
    }else if($("#therapy_count_chk").text() == "선택"){
        alert("횟수를 선택해주세요");
        return;
    }else if($("#date_chk").text() == "선택"){
        alert("상담 날짜를 선택해주세요");
        return;
    }else if($("#time_chk").text() == "선택"){
        alert("상담 시간을 선택해주세요");
        return;
    }else{

        const count = $("#therapy_count_chk").text().split("회");
        const therapyCount = Number.parseInt(count[0]);
        
         // 1.주문정보 테이블에 인서트 에이젝스
         $.ajax({
            url : contextPath + "/pro/priceInsert",
            type : "POST",
            // 전문가 번호, 텍스트 테라피 종류 , 횟수
            data : {"therapySelect":therapySelect, "therapyCount": therapyCount},

            success : function(payNo){

                //2 . ajax 성공 시 아이포트 수행
                IMP.init("imp11319218"); // 예: imp00000000
                IMP.request_pay({
                    pg : 'inicis', // version 1.1.0부터 지원.
                    pay_method : 'card',
                    merchant_uid : 'merchant_' + new Date().getTime(),
                    name : '마음연구소 re:mind',
                    amount : Number(finallyPrice), //판매 가격
                    buyer_email : '1234@naver.com',
                    buyer_name : '홍두깨',
                    buyer_tel : '010-1234-5678'
                    
                }, function(rsp) {

                    if ( rsp.success ) { // 결제에 성공했을경우
                            
                        // 3. 주문번호를 이용하여 db에 select 됐던 총 금액 조회
                        $.ajax({
                            url : contextPath + "/pro/priceSelect",
                            type : "POST",
                            data : {"payNo":payNo},

                            success : function(price){

                                // 4. DB 조회된 총금액과 rsp.paid_amount 가 같으면 결제 성공
                                if(price == rsp.paid_amount){
                                    alert("결제가 완료되었습니다.");
                                    
                                    const reservationEnrollDate = $("#date_chk").text();
                                    const reservationEnrollTime = $("#time_chk").text().split(":")[0];
                                    const counselCategoryNm = $("#therapy_chk").text();

                                    var formData = new FormData();
                                    formData.append('payNo',payNo);
                                    formData.append('reservationEnrollDate',reservationEnrollDate); // 날짜
                                    formData.append('reservationEnrollTime',reservationEnrollTime); // 시간
                                    formData.append('counselCategoryNm',counselCategoryNm); // 테라피 종류

                                    // update와 insert 동시 진행
                                    $.ajax({
                                        url : contextPath + "/pro/reservationUpdate",
                                        type : "POST",
                                        data : formData,
                                        processData: false,
		                                contentType: false,
                                        success:function(result){
                                            console.log(result);
                                            // 여기서 결제 완료창으로 넘어갈지 , 아님 마이페이지로 들어갈지 고민
                                        },

                                    });

                                }else{
                                    
                                    // 임의로 삭제버튼을 누르거나 금액이 안맞을떄 PAYMENT, RESERVATION_PAYMENT 삭제 처리
                                    $.ajax({
                                        url : contextPath + "/pro/paymentDelete",
                                        type : "POST",
                                        data : {"payNo":payNo},

                                        success:function(result){

                                            if(result>0){
                                                // 5.  DB 조회된 총금액과 rsp.paid_amount 가 같지 않으면 삭제 ajax
                                                alert("결제 실패 하였습니다.");
                                            }
                                        },
                                    });
                                }
                                
                            }, 

                        });
                       
                    } else { // 결제에 실패했을경우
                        var msg = '결제에 실패하였습니다.';
                        msg += '에러내용 : ' + rsp.error_msg;

                        // 임의로 삭제버튼을 누르거나 금액이 안맞을떄 PAYMENT, RESERVATION_PAYMENT 삭제 처리
                        $.ajax({
                            url : contextPath + "/pro/paymentDelete",
                            type : "POST",
                            data : {"payNo":payNo},

                            success:function(result){
                                console.log(result);
                            },
                        });
                    }
                }); 
            },
        });

    } //else end
    
}






// 달력
const redColor = "#be153d";
const blueColor = "#193ea0";

var today = new Date();
let year = today.getFullYear();
let month = today.getMonth();
let backupMonthFirstDay;

// 달력에 블록표시해주는 함수입니다.
function setBlock(){
    let seeYear = $(".YM").text().split("년 ")[0];
    let seeMonth = $(".YM").text().split("년 ")[1].split("월")[0];
    let date = today.getDate();

    let monthFirstDay = new Date(year, month, 1).getDay();

    // 현재날짜보다 보고 있는 달력의 년도가 낮을 시 블록처리합니다.
    if(seeYear < today.getFullYear()){
        for(let i = 0; i < $("#calendar td").length; i++){
            if(i < 7) continue;
            $("#calendar td").eq(i + monthFirstDay).css("color", "#c5cacd");
        }
    }else{// 현재년도와 보고있는 년도가 같거나 더 높을 시
        // 현재날짜보다 보고있는 달력의 월이 낮을 시 블록처리합니다.
        if(seeMonth <= today.getMonth() + 1){
            if(seeMonth == today.getMonth() + 1){
                for(let i = 0; i < $("#calendar td").length; i++) {
                    if ($("#calendar td").eq(i).attr("id") <= date)
                        $("#calendar td").eq(i).css("color", "#c5cacd");
                }
            }else{ // 현재 월보다 보고있는 월이 낮을 시
                for(let i = monthFirstDay; i < $("#calendar td").length; i++){
                    $("#calendar td").eq(i + monthFirstDay).css("color", "#c5cacd");
                }
            }
        }
    }
}

// 달력을 만들어주는 함수입니다.
const calendar = document.getElementById("calendar");
function makeCalendar(el, yearNo, monthNo) {

    year = Number.parseInt(yearNo);
    month = Number.parseInt(monthNo);

    let YM = year + "년 " + (month + 1) + "월";
    $(".YM").text(YM);

    $(".calendar").attr("id", year + "-" + month);

    let endDay = new Date(year, month + 1, 0);
    let nextDate = endDay.getDate();

    // 오늘은 무슨요일
    const WEEKDAY = ['일', '월', '화', '수', '목', '금', '토'];
    let monthFirstDay = new Date(year, month, 1).getDay();
    backupMonthFirstDay = monthFirstDay;
    let row = el.insertRow();
    let cell;

    // 일 ~ 토 요일을 표시해주고 색을 칠해줍니다.
    for(let i = 0; i < 7; i++){
        cell = row.insertCell();
        cell.innerHTML = WEEKDAY[i]
        if(i == 0)      cell.style.color = redColor;
        else if(i == 6) cell.style.color = blueColor;
    }
    row = el.insertRow();

    for(let i = 0; i < monthFirstDay; i++){
        cell = row.insertCell();
    }

    for(let i = 1; i <= nextDate; i++){
        if(monthFirstDay != 7){
            cell = row.insertCell();
            cell.setAttribute("id", i);
            cell.innerHTML = i;

            if(monthFirstDay == 0 && i == 1)    cell.style.color = redColor;
            else if(monthFirstDay == 6)         cell.style.color = blueColor;
            monthFirstDay += 1;
        }else{
            row = el.insertRow();
            cell = row.insertCell();
            cell.setAttribute("id", i);

            cell.innerHTML = i;
            cell.style.color = redColor;
            monthFirstDay = monthFirstDay - 6;
        }
    }
    setHgight();
    setBlock();
}

function beforeCalendar() {
    $("#calendar").empty();

    let id = $(".calendar").attr("id");
    let splitId = id.split("-");

    let yearNo = splitId[0];
    let monthNo = splitId[1];

    // 현재 1월이면
    if(splitId[1] == 0){
        yearNo = Number.parseInt(yearNo) - 1;
        monthNo = Number.parseInt(monthNo) + 12;
    }
    monthNo = Number.parseInt(monthNo) - 1;

    makeCalendar(calendar, yearNo, monthNo);
}

function nextCalendar() {
    $("#calendar").empty();

    let id = $(".calendar").attr("id");
    let splitId = id.split("-");

    let yearNo = splitId[0];
    let monthNo = splitId[1];

    // 현재 12월이면
    if(splitId[1] == 11){
        yearNo = Number.parseInt(yearNo) + 1;
        monthNo = Number.parseInt(monthNo) - 12;
    }
    monthNo = Number.parseInt(monthNo) + 1;

    makeCalendar(calendar, yearNo, monthNo);
}

makeCalendar(calendar, year, month);

$(document).on("click", "#calendar td", function (){
    const index = $("#calendar td").index($(this));

    if($(this).css("color") == "rgb(197, 202, 205)") return;
    if(index < 7 + backupMonthFirstDay) return;

    $("#calendar td").removeClass("YMcss");
    $(this).addClass("YMcss");
});


function setHgight(){
    if($("#calendar tr").length > 6){
        $("#tuition_date").css("height","630px");
        $("#reservation_confirm_wrap").css("height","1197px");
    }else{
        $("#tuition_date").css("height","560px");
        $("#reservation_confirm_wrap").css("height","1120px");
    }
}