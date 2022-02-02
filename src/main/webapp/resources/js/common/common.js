// 모바일 헤더 메뉴
const togle = document.querySelector('.headermenu_togle')
const menu = document.querySelector('.dep1')
const sub_menu = document.querySelectorAll('.dep2')

togle.addEventListener('click', ()=>{
    menu.classList.toggle('active')
})

// menu.addEventListener('click',()=>{
    
// })


// modal close + popup close
const closePopup = document.querySelectorAll(".close_popup_btn");
const modal = document.querySelector(".modal");
const popupWrap = document.querySelector(".popup_wrap");
const layerPopupContent = document.querySelector(".layer_popup_content");
for(let i =0; i< closePopup.length; i++) {
    closePopup[i].addEventListener("click", () => {
        // 모달 close
        modal.style.display = "none";
        popupWrap.style.display = "none";

        // 팝업 내용 지우기
        layerPopupContent.innerHTML = "";
    });
}

// popup open
function layerPopup (layerPopup) {
    $(".layer_popup_content").load(contextPath + "/popup/" + layerPopup, function () {
        $(".modal").show();
        $(".popup_wrap").show();
    });
}

// login button
const loginBtn = document.querySelector(".login_btn");
loginBtn.addEventListener("click", () => {

   layerPopup("loginType");
});