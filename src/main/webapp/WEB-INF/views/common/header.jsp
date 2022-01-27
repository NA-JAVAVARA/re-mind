<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/common.css">

    <!-- modal + popup -->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/my.css">

    <!-- 아이콘 -->
    <script src="https://kit.fontawesome.com/5e0a99db98.js" crossorigin="anonymous"></script>
</head>
<body>
<!--
1. 태그는 되도록이면 section -> article -> div 순으로 작성해 주세요!
2. html,css, js 모두 tab(띄어쓰기)은 4칸입니다.
3. common.css에 기본 적인 폰트, 버튼, 컬러 클래스가 작성되어있습니다.
4. 만약 와이어프레임이 정확하지 않거나 헷갈리는 부분은 피그마에서 확인 후 단톡에 질문해 주세요
5.  width는 %로 정해줍니다.
-->

<header>
    <!-- 헤더 -->
    <section class="header_wrap">
        <article class="header_logo_wrap">
            <img src="" alt="">
        </article>


        <!-- 헤더 메뉴 -->
        <article class="header_menu_wrap">
            <ul class="dep1">
                <li>
                    <a href="#">상담예약123</a> <p class="menu_toggle">+</p>
                    <ul class="dep2">
                        <li><a href="#">상담사 찾기</a></li>
                        <li><a href="#">상담센터 찾기</a></li>
                        <li><a href="#">자가진단</a></li>
                    </ul>

                </li>
                <li>
                    <a href="#">커뮤니티</a> <p class="menu_toggle">+</p>
                    <ul class="dep2">
                        <li><a href="#">자유게시판</a></li>
                        <li><a href="#">고민상담 게시판</a></li>
                        <li><a href="#">마인드 포스팃</a></li>
                        <li><a href="#">털어놓기</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">공지사항</a> <p class="menu_toggle">+</p>
                    <ul class="dep2">
                        <li><a href="#">자유게시판</a></li>
                        <li><a href="#">고민상담 게시판</a></li>
                        <li><a href="#">마인드 포스팃</a></li>
                        <li><a href="#">털어놓기</a></li>
                    </ul>
                </li>
                <li><!-- 로그인 안했으면 로그인 버튼 -->
                    <!-- <a href="">로그인</a> -->
                    <a href="#">마이페이지</a> <p class="menu_toggle">+</p>
                    <ul class="dep2">
                        <li><a href="#">감정기록</a></li>
                        <li><a href="#">마이 상담</a></li>
                        <li><a href="#">마이 활동</a></li>
                        <li><a href="#">마이 정보</a></li>
                    </ul>
                </li>
                <li ><!-- 로그인 했으면 로그아웃 버튼 보이기
                            로그인 안했으면 회원가입 -->
                    <!-- <a href=""> 회원가입 </a>  -->
                    <a href="#">로그아웃</a>
                </li>
            </ul>
            <a href="#" class="headermenu_togle">
                <i class="fas fa-bars"></i>
            </a>
            <a href="#" class="headermenu_bell">
                <i class="far fa-bell"></i>
            </a>
        </article>
    </section>
</header>

<main>
    <section class="main_wrap">
        <!-- 사이드 메뉴가 없는 부분은 지우고 사용 -->
        <article class="dark-brown side_menu">
            <h3>마이페이지</h3>
            <ul>
                <li><a href="#">증상기록</a></li>
                <hr>
                <li><a href="#">마이상담</a>
                    <ul>
                        <li><a href="#">상담 예약 조회</a></li>
                        <li><a href="#">지난 상담 내역</a></li>
                        <li><a href="#">상담후기</a></li>
                        <li><a href="#">찜한 상담사</a></li>
                    </ul>
                </li>
                <hr>
                <li><a href="#">마이활동</a>
                    <ul>
                        <li><a href="#">게시글 내역</a></li>
                        <li><a href="#">쪽지</a></li>
                        <li><a href="#">문의사항</a></li>
                        <li><a href="#">차단한 회원</a></li>
                    </ul>
                </li>
                <hr>
                <li><a href="#">마이정보</a>
                    <ul>
                        <li><a href="">회원정보 수정</a></li>
                        <li><a href="">회원탈퇴</a></li>
                    </ul>
                </li>
            </ul>
        </article>


