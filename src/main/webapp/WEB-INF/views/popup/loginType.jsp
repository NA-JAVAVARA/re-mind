<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application" />

<!-- 구글 로그인 API  -->
<%--<meta name="google-signin-scope" content="profile email openid ">--%>
<meta name ="google-signin-client_id" content="251812285867-iarbblabr07shf2kvjjmuaoa3tuv6n8r.apps.googleusercontent.com">
<%-- 구글 api 사용을 위한 라이브러리 --%>
<script src="https://apis.google.com/js/platform.js" async defer></script>


<script>
	function onSignIn(googleUser) {
		var profile = googleUser.getBasicProfile();
		var id_token = googleUser.getAuthResponse().id_token;
		console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
		console.log('Name: ' + profile.getName());
		console.log('Image URL: ' + profile.getImageUrl());
		console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
		console.log(id_token);

		/*window.location.replace("http://localhost:9000/mind?" +
				"client_id=251812285867-osc8dhqrlc0f5tu31kiike62ehrro734.apps.googleusercontent.com&" +
				"redirect_uri=http://localhost:9000/mind&" +
				"response_type=code&" +
				"scope=email%20profile%20openid&" +
				"access_type=offline");*/
	}

	// function onSignIn(googleUser) {
	// 	var profile = googleUser.getBasicProfile();
	// 	var id_token = googleUser.getAuthResponse().id_token;
	// }//onSignIn

	/*function onSignIn(){
		var auth2 = gapi.auth2.getAuthInstance()
		if(auth2.isSignedIn.get()){
			var profile = auth2.currentUser.get().getBasicProfile();
			googleLoginPro(profile)


		}
		console.log(auth2);
		console.log(profile);


	}*/

	function signOut() {
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.signOut().then(function () {
			console.log('User signed out.');
		});
	}

</script>


<div id="login_area">
	<div class="top_title_wrap">
		<h2 class="title">로그인</h2>
	</div>
	<div class="login_box">
		<div class="login_method">
<%--			<a href="javascript:kakaoLogin();">카카오 로그인</a>--%>
			<a href="https://kauth.kakao.com/oauth/authorize?client_id=b862240d0cf0e40922fb9312954ca3a2&redirect_uri=http://localhost:9000/mind/oauth_kakao/callback&response_type=code">카카오 로그인</a>
			<a href="javascript:unlinkApp();">카카오 탈퇴하기</a>
<%--			<a href="javascript:kakaoLogout();">카카오 로그아웃</a>--%>
			<a href="javascript:kakaoLogoutt();">카카오 로그아웃</a>
<%--			<a href="#self">네이버 로그인</a>--%>
	<div id="naverIdLogin"></div>
<%--	<a id="custom-login-btn" href="javascript:void(0);" onclick="window.open('${googleUrl}','googleLogin','width=430,height=500,location=no,status=no,scrollbars=yes');""> <img src="/images/btn_google_signin_dark_normal_web.png" width="300"/> </a>--%>

<%--			<a href="javascript:googleLogin();">구글 로그인</a>--%>
<%--			<div class="g-signin2 googleLoginBtn" data-onsuccess="onSignIn">구글 로그인</div>--%>
			<button class="btn btn-primary" id="googleLoginBtn">구글 로그인</button>
<%--			<a class="g-signin2"  onClick="onSignIn()">Google Login</a>--%>

			<a href="#" onclick="signOut();">구글 로그아웃</a>
			<a href="#self">이메일 로그인</a>
		</div>
		<div class="sign_up_wrap">
			<span>아직 계정이 없으신가요?</span>
			<a href="javascript:layerPopup('signUp');">회원가입</a>
		</div>
	</div>
</div>

<script>
	var naverLogin = new naver.LoginWithNaverId(
			{
				clientId: "bCW4VaBNrrKJO0dNnbwX",
				callbackUrl: "http://localhost:9000/mind/oauth_kakao/naverLogin",
				isPopup: false, /* 팝업을 통한 연동처리 여부 */
				loginButton: {color: "green", type: 3, height: 60} /* 로그인 버튼의 타입을 지정 */
			}
	);

	/* 설정정보를 초기화하고 연동을 준비 */
	naverLogin.init();


	document.getElementById("googleLoginBtn").addEventListener("click", function (){
		//구글서버로 인증코드 발급 요청
		window.location.replace("https://accounts.google.com/o/oauth2/v2/auth?"+
				"client_id=251812285867-iarbblabr07shf2kvjjmuaoa3tuv6n8r.apps.googleusercontent.com&"+
				"redirect_uri=http://localhost:9000/mind/oauth_kakao/googleLogin&"+
				"response_type=code&"+
				"scope=email%20profile%20openid&"+
				"access_type=offline");
	});
	const onClickGoogleLogin = function(e) {
		//구글서버로 인증코드 발급 요청
		window.location.replace("https://accounts.google.com/o/oauth2/v2/auth?"+
		"client_id=251812285867-iarbblabr07shf2kvjjmuaoa3tuv6n8r.apps.googleusercontent.com&"+
		"redirect_uri=http://localhost:9000/mind/oauth_kakao/googleLogin&"+
		"response_type=code&"+
		"scope=email%20profile%20openid&"+
		"access_type=offline");
	}

	function init() {
		gapi.load('auth2', function() {
			gapi.auth2.init();
			options = new gapi.auth2.SigninOptionsBuilder();
			options.setPrompt('select_account');
			// 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
			options.setScope('email profile openid');
			// 인스턴스의 함수 호출 - element에 로그인 기능 추가
			// GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
			gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
		})
	}


	Kakao.init('f9cc932f2cb179a77079e2c667dab98a');
	Kakao.isInitialized();
	// console.log(Kakao.isInitialized()); // sdk초기화여부판단

	function unlinkApp() {
		Kakao.API.request({
			url: '/v1/user/unlink',
			success: function(res) {
				alert('success: ' + JSON.stringify(res))
			},
			fail: function(err) {
				alert('fail: ' + JSON.stringify(err))
			},
		})
	}


	//카카오로그인
	function kakaoLogin() {
		Kakao.Auth.login({
			// scope: 'profile_nickname, profile_image, account_email, gender, age_range, birthday', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
			success: function(response) {
				console.log(response)
				Kakao.Auth.setAccessToken(response.access_token);

				// console.log(Kakao.Auth.getAccessToken());
				const urll = 'https://kauth.kakao.com/oauth/authorize?client_id=b862240d0cf0e40922fb9312954ca3a2' +
				'&redirect_uri=http://localhost:9000/mind/oauth_kakao/callback&response_type=code';
				window.location.href=urll; //리다이렉트 되는 코드

				// window.Kakao.API.request({ // 사용자 정보 가져오기
				// 	url: '/v2/user/me',
				// 	success: (res) => {
				// 		console.log(res)
				// 		const kakaoAccount = res.kakao_account;
				// 		window.location.href=urll; //리다이렉트 되는 코드
				//
				// 	}
				// });
			},
			fail: function(error) {
				console.log(error);
			}
		});
	}

	function kakaoLogout() {
		if (!Kakao.Auth.getAccessToken()) {
			console.log('Not logged in.');
			return;
		}
		Kakao.Auth.logout(function(response) {
			Kakao.Auth.setAccessToken(undefined); // 로그아웃
			alert(response +' logout');
			window.location.href='/mind'
		});
	};

</script>
