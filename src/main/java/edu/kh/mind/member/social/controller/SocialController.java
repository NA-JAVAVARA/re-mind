package edu.kh.mind.member.social.controller;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.github.scribejava.core.model.OAuth2AccessToken;
import edu.kh.mind.member.social.google.GoogleOAuthRequest;
import edu.kh.mind.member.social.google.GoogleOAuthResponse;
import edu.kh.mind.member.social.kakao.KakaoLoginBO;
import edu.kh.mind.member.social.naver.NaverLoginBO;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.OAuth2Parameters;

// 리다이렉트 주소 변경
@Controller
@RequestMapping("/social/*")
public class SocialController {

    /* NaverLoginBO */
    @Autowired
    private NaverLoginBO naverLoginBO;

    private String apiResult = null;

    @Autowired
    private KakaoLoginBO kakaoLoginBO;

    @Autowired
    private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }

    @Autowired
    private void setKakaoLoginBO(KakaoLoginBO kakaoLoginBO) {
        this.kakaoLoginBO = kakaoLoginBO;
    }

    @Autowired
    private GoogleConnectionFactory googleConnectionFactory;
    @Autowired
    private OAuth2Parameters googleOAuth2Parameters;

    // 로그인 첫 화면 요청 메소드
    @GetMapping("googleLogin")
    @ResponseBody
    public String login(Model model, HttpSession session) {

        /* 구글code 발행 */
        OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
        String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

        System.out.println("구글:" + url);

        model.addAttribute("google_url", url);

        /* 생성한 인증 URL을 View로 전달 */
        return url;
    }
//    @GetMapping("googleLogin")
//    @ResponseBody
//    public String googleLogin(Model model, HttpSession session, HttpServletRequest request) {
//
//        String serverUrl = request.getScheme()+"://"+request.getServerName();
//        if(request.getServerPort() != 80) {
//            serverUrl = serverUrl + ":" + request.getServerPort();
//        }
//
//        String googleAuthUrl = kakaoLoginBO.getAuthorizationUrl(session, serverUrl);
//        model.addAttribute("kakaoAuthUrl", googleAuthUrl);
//
//        return googleAuthUrl;
//    }
    // 네이버 로그인 첫 화면 요청 메소드
    @GetMapping("naverlogin")
    @ResponseBody
    public String login(HttpSession session) {

        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

        System.out.println("============== Naver OAuth2 URI ==============");
        System.out.println(naverAuthUrl);

        return naverAuthUrl;
    }
    // 카카오 로그인 첫 화면 요청 메소드
    @GetMapping("kakaoLogin")
    @ResponseBody
    public String login(Model model, HttpSession session, HttpServletRequest request) {

        String serverUrl = request.getScheme()+"://"+request.getServerName();
        if(request.getServerPort() != 80) {
            serverUrl = serverUrl + ":" + request.getServerPort();
        }

        String kakaoAuthUrl = kakaoLoginBO.getAuthorizationUrl(session, serverUrl);
        model.addAttribute("kakaoAuthUrl", kakaoAuthUrl);

        return kakaoAuthUrl;
    }

    //네이버 로그인 성공시 callback호출 메소드
    @RequestMapping(value = "naverCallback", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model, @RequestParam(value = "code", required = false) String code,
                           @RequestParam String state,
                           HttpSession session) throws IOException {
        System.out.println("============== callback ==============");
        OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        System.out.println("[AccessToken : " + oauthToken.getAccessToken() + "]");
        System.out.println("[RefreshToken : " + oauthToken.getRefreshToken() + "]");

//        naverLoginBO.getNaverAccessToken(session, code, state);

        apiResult = naverLoginBO.getUserProfile(oauthToken);
        System.out.println(naverLoginBO.getUserProfile(oauthToken).toString());
        model.addAttribute("result", apiResult);
        System.out.println("result"+apiResult);

        return "socialSuccess";
    }


    // 카카오 로그인 성공시 callback
    @RequestMapping(value = "kakaoCallback", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(HttpServletRequest request, HttpServletResponse response, Model model,
                                            @RequestParam(value = "code", required = false) String code,
                                            @RequestParam(value = "state", required = false) String state, HttpSession session) throws Exception {

        String serverUrl = request.getScheme() + "://" + request.getServerName();
        if (request.getServerPort() != 80) {
            serverUrl = serverUrl + ":" + request.getServerPort();
        }

        OAuth2AccessToken oauthToken;
        oauthToken = kakaoLoginBO.getAccessToken(session, code, state, serverUrl);
        if (oauthToken == null) {
            model.addAttribute("msg", "카카오 로그인 access 토큰 발급 오류 입니다.");
            model.addAttribute("url", "/");
            return "/common/redirect";
        }

        System.out.println("AccessToken : " + oauthToken.getAccessToken());
        System.out.println("RefreshToken : " + oauthToken.getRefreshToken());

        // 로그인 사용자 정보를 읽어온다
        String apiResult = kakaoLoginBO.getUserProfile(oauthToken, serverUrl);
        System.out.println("apiResult : " + apiResult.toString());

        JSONParser jsonParser = new JSONParser();
        Object obj = jsonParser.parse(apiResult);
        JSONObject jsonObj = (JSONObject) obj;
        System.out.println("jsonObj : " + jsonObj);

        JSONObject response_obj = (JSONObject) jsonObj.get("kakao_account");
        System.out.println("response_obj : " + response_obj);

        // 프로필 조회
        String id = (String) response_obj.get("id");
        String gender = (String) response_obj.get("gender");

        // 세션에 사용자 정보 등록
        session.setAttribute("islogin_r", "Y");
        session.setAttribute("id", id);
        session.setAttribute("gender", gender);

        return "socialSuccess";
    }







    @RequestMapping(value = "googleCallback", method = { RequestMethod.GET, RequestMethod.POST })
    public String googleAuth(Model model, @RequestParam(value = "code") String authCode, HttpServletRequest request)
            throws Exception {

        //HTTP Request를 위한 RestTemplate
        RestTemplate restTemplate = new RestTemplate();

        //Google OAuth Access Token 요청을 위한 파라미터 세팅
        GoogleOAuthRequest googleOAuthRequestParam =  new GoogleOAuthRequest();
        googleOAuthRequestParam.setCode(authCode);
        googleOAuthRequestParam.setClientId("251812285867-iarbblabr07shf2kvjjmuaoa3tuv6n8r.apps.googleusercontent.com");
        googleOAuthRequestParam.setClientSecret("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");
        googleOAuthRequestParam.setRedirectUri("http://localhost:9000/mind/social/googleCallback");
        googleOAuthRequestParam.setGrantType("authorization_code");

        //JSON 파싱을 위한 기본값 세팅
        //요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
        ObjectMapper mapper = new ObjectMapper();
        mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
//        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);

        //AccessToken 발급 요청
        ResponseEntity<String> resultEntity = restTemplate.postForEntity("https://www.googleapis.com/oauth2/v4/token", googleOAuthRequestParam, String.class);
        System.out.println("resultEntity : " + resultEntity);
        //https://oauth2.googleapis.com/token
        // https://accounts.google.com/o/oauth2/token
        // https://www.googleapis.com/oauth2/v4/token

        //Token Request
        GoogleOAuthResponse result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleOAuthResponse>() {
        });

        //ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다)
        String jwtToken = result.getIdToken();
        String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo").queryParam("id_token", jwtToken).toUriString();

        String resultJson = restTemplate.getForObject(requestUrl, String.class);

        Map<String,String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>(){});
        model.addAllAttributes(userInfo);
        model.addAttribute("token", result.getAccessToken());

        System.out.println("userInfo : " + userInfo);
        System.out.println("AccessToken : " + result.getAccessToken());
        System.out.println("code : " + googleOAuthRequestParam.getCode());
        System.out.println("AccessType : " + googleOAuthRequestParam.getAccessType());
        System.out.println("GrantType : " + googleOAuthRequestParam.getGrantType());
        System.out.println("refreshToken : " + result.getRefreshToken());
        // refreshToken 재발급 하려면 access권한 삭제해야함
        // https://developers.google.com/identity/gsi/web/guides/revoke

        return "redirect:/";
    }


}
