<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
          crossorigin="anonymous">
</head>
<body>
<%@include file="../../../fragments/header.jspf" %>


<main id="login-form-wrapper m-3" style="width: 50%; margin: auto; padding-top: 3%;">
    <div id="searchDiv" class="mb-3 card p-3" style="width: 70%; margin:auto">
        <h2 class="my-4" style="margin: auto">비밀번호 재설정하기</h2>
        <form class="mb-3 card-body">
            <div class="">
                <div class="mb-3 my-3">
                    <label for="input-pw" class="form-label py-2">새로운 비밀번호</label>
                    <input type="password" class="form-control my-1" id="input-pw"
                           required>
                    <div id="pwHelp" class="form-text mx-2">1) 영문 숫자 혼합. 2)공백 제외 6글자 이상.</div>
                </div>
                <div class="mb-3 my-3">
                    <label for="input-pw-check" class="form-label py-2">비밀번호 확인</label>
                    <input type="password" class="form-control my-1"
                           id="input-pw-check"
                           required>
                    <div id="pwCheckHelp" class="form-text mx-2"></div>
                </div>
                <div class="d-none">
                    <input type="hidden" id="input-email" class="form-control my-1"
                           value="${param.email}"
                           required>
                    <input type="hidden" id="input-memberid" class="form-control my-1"
                           value="${param.member_id}"
                           required>
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <c:url var="signInUrl" value="/user/signin"/>
                    <a class="btn btn-primary btn-sm" href="${signInUrl}">로그인하러 고고</a>
                    <c:url var="signUpUrl" value="/user/signup"/>
                    <a class="btn btn-primary btn-sm" href="${signUpUrl}">회원가입할래요!</a>
                </div>
            </div>
        </form>
        <div class="mb-1" style="margin-top: 4%;">
            <input type="submit" id="pwResetBtn" class="btn btn-outline-success form-control"
                   value="비밀번호 재설정"/>
        </div>
    </div>
</main>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="../../../js/member/find/result/resetPassword.js"></script>

</body>
</html>
