var clickable = [];

$(".cate_btn").on("click", function (){
    let val = $(this).val();

    if(val.length == 1)	val = 100 + val;
    else				val = 10 + val;

    if( $(this).attr("id") == undefined ){
        if(clickable.length > 4)	return;
        $(this).attr("id", val).css("backgroundColor", "rgb(166 166 168)").css("color", "white");
    }else if( $(this).attr("id") != undefined ){
        $(this).removeAttr("id").css("backgroundColor", "white").css("color", "black");
    }

    let count = 0;
    for(let i = 0; i < $(".cate_btn").length; i++){
        if($(".cate_btn").eq(i).attr("id") != undefined){
            clickable[count] = $(".cate_btn").eq(i).attr("id");
            $(".cate_btn").eq(i).attr("class", "cate_btn_click cate_btn");
            count = count + 1;
        }else{
            clickable.splice(count, 1);
        }
    }
    // 정렬
    clickable.sort(function (a, b){return a-b;});

    makePro();
});

function makeComma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}


const replyCheckCode = $("#comment, #mComment")
const checkbox = $("input[type='checkbox']")
replyCheckCode.val(1)

calcPagination();
function makePro(){

    let nameValue;

    $("#nameSearch").on("click", function (){
        nameValue = $("#pro_searchInput").val();

        if(nameValue.length < 1)	return false;


    });

    $.ajax({
        url:"proCategory",
        data:{
            "worryCtCd": clickable,
            "last":last,
            "first":first
        },
        dataType:"JSON",
        success:function (result){
            YesScroll();
            const ul = $("#pro_list");
            // ul.empty();
            $.each(result, function (i, item){

                if(result.length - 1 == i){
                    listCount = Number.parseInt(item.maxValue);
                    return;
                }

                let category = item.counselCategoryCode.split(",");
                let price = item.counselPrice.split(",");

                if(category[0] != 1 && category[0] == 2){
                    category.splice(0, 0, "undefined");
                    price.splice(0, 0, "undefined");
                }
                else if(category[0] != 1 && category[0] == 3){
                    category.splice(0, 0, "undefined", "undefined");
                    price.splice(0, 0, "undefined", "undefined");
                }
                if(category[1] != 2 && category[1] == 3){
                    category.splice(1, 0, "undefined");
                    price.splice(1, 0, "undefined");
                }

                const li = $('<li class="pro">');
                const aHref = $('<a href= '+contextPath+'/pro/proView/'+item.professionNo+' onclick="reviewList();">');

                const pro_profile = $('<div class="pro_profile">');
                const pro_profile_img1 = $('<img src="/mind/resources/images/pro/best.png" class="pro_best">');
                let pro_profile_img2;
                if(item.imagePath == undefined)//기본프로필이 없으면
                    pro_profile_img2 = $('<img src="'+contextPath+'/resources/images/basicProfile.png" class="profile">');
                else // 있으면 경로로 이미지이름 추가로 가져와야됨
                    pro_profile_img2 = $('<img src="'+contextPath+item.imagePath+'/'+item.imageName+'" class="profile">');

                pro_profile.append(pro_profile_img1, pro_profile_img2);

                const pro_intro_wrap = $('<div class="pro_intro_wrap">');
                const pro_intro_wrap_div = $("<div>");
                const pro_name = $('<div class="pro_name float-left">');
                const pro_name_h1 = $('<h1>'+item.professionName+'</h1>');
                pro_name.append(pro_name_h1)
                const pro_score_wrap = $('<div class="pro_score_wrap float-left">');
                const pro_score_wrap_span = $('<span>추천 전문가</span>');
                const pro_score = $('<ul class="pro_score">');

                // for(let i = 1; i <= 5; i++){
                //     if(item.starAvg > i * 2){
                //
                //     }else{
                //
                //     }
                // }
                const pro_score_li1 = $('<li><img src="/mind/resources/images/pro/star.png"></li>');
                const pro_score_li2 = $('<li><img src="/mind/resources/images/pro/star.png"></li>');
                const pro_score_li3 = $('<li><img src="/mind/resources/images/pro/star.png"></li>');
                const pro_score_li4 = $('<li><img src="/mind/resources/images/pro/star.png"></li>');
                const pro_score_li5 = $('<li><img src="/mind/resources/images/pro/star-half.png"></li>');
                pro_score.append(pro_score_li1, pro_score_li2, pro_score_li3, pro_score_li4, pro_score_li5);
                pro_score_wrap.append(pro_score_wrap_span, pro_score);
                pro_intro_wrap_div.append(pro_name, pro_score_wrap);
                const pro_intro = $('<div class="pro_intro">');
                const pro_intro_p1 = $('<p>' + item.professionIntro + '</p>');
                const pro_intro_p2 = $('<p>#가족 #대인관계 #자존감상실 #연인</p>');
                pro_intro.append(pro_intro_p1, pro_intro_p2);
                pro_intro_wrap.append(pro_intro_wrap_div, pro_intro);




                const pro_price_wrap = $('<div class="pro_price_wrap">');
                const text_price = $('<div class="text_price">');
                const text_price_img = $('<img src="/mind/resources/images/pro/text_therapy.png" class="float-left">');
                let text_price_p;
                if(category[0] == 1){
                    text_price_p = $('<p class="float-right">'+makeComma(price[0])+'<span>원</span></p>');
                }else{
                    text_price_p = $('<p class="float-right">-</p>');
                }
                text_price.append(text_price_img, text_price_p);

                const voice_price = $('<div class="voice_price clear-both">');
                const voice_price_img = $('<img src="/mind/resources/images/pro/voice_therapy.png" class="float-left">');
                let voice_price_p;
                if(category[1] == 2){
                    voice_price_p = $('<p class="float-right">'+makeComma(price[1])+'<span>원</span></p>');
                }else{
                    voice_price_p = $('<p class="float-right">-</p>');
                }
                voice_price.append(voice_price_img, voice_price_p);

                const face_price = $('<div class="face_price clear-both">');
                const face_price_img = $('<img src="/mind/resources/images/pro/face_therapy.png" class="float-left">');
                let face_price_p;
                if(category[2] == 3){
                    face_price_p = $('<p class="float-right">'+makeComma(price[2])+'<span>원</span></p>');
                }else{
                    face_price_p = $('<p class="float-right">-</p>');
                }
                face_price.append(face_price_img, face_price_p);
                pro_price_wrap.append(text_price, voice_price, face_price);

                aHref.append(pro_profile, pro_intro_wrap, pro_price_wrap);
                li.append(aHref);
                ul.append(li);

            });
        }
    });
}
makePro();


