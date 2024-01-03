<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이 펫</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet" />
    <link href="../css/font.css" rel="stylesheet" >
    <link href="../css/nav.css" rel="stylesheet" >
    <link href="../css/mypage.css" rel="stylesheet">

</head>
<body>
<!--top nav -->
<%@ include file="../fragments/top-nav.jspf" %>
<!-- Header-->
<%@ include file="../fragments/header.jspf" %>
<!-- bottom nav-->
<%@ include file="../fragments/bottom-nav.jspf" %>


<main class="outer-container row">
    <div class="col-2">
    <%@include file="../fragments/MyPageNav.jsp" %>
    </div>

    <div class="container pb-3 my-page-container col-8">
        <div class="card-body bg-opacity-10"
             style="display: flex;  justify-content: space-between;">
            <h2 class="text-center display-6 my-3" style="display: inline-block; width: 100%">
                😸반려미야옹과 반려멍 소개하기🐶
            </h2>

        </div>
        <div class="card">
            <table class="table table-hover table align-middle">
                <thead>
                <tr class="text-center">
                    <th>사진</th>
                    <th>이름</th>
                    <th>🐶🐱</th>
                    <th>나이</th>
                    <th>성별</th>
                    <th>체형</th>
                    <th>삭제/수정</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pet" items="${petList}">
                    <tr class="text-center">
                        <td><c:url var="imgGetUrl"
                                   value="/image">
                            <c:param name="imgUrl"
                                     value="${pet.img}"/>
                        </c:url> <c:choose>
                            <c:when
                                    test="${empty pet.img}">
                                <img
                                        class="img-fluid card-img"
                                        src="../images/pet_default_img.png"
                                        style="height: 200px; width: 200px"
                                        alt="이미지 X">
                            </c:when>
                            <c:otherwise>
                                <img
                                        class="img-fluid card-img"
                                        src="${imgGetUrl}"
                                        style="height: 200px; width: 200px"
                                        alt="펫 이미지">
                            </c:otherwise>
                        </c:choose></td>
                        <td>${pet.pet_name}</td>
                        <td>${pet.pet_type}</td>
                        <td>${pet.age}</td>
                        <td>${pet.gender}</td>
                        <td>${pet.chehyeong}</td>
                        <td><c:url var="modifyPet"
                                   value="/mypage/modifypet">
                            <c:param name="pet_pk"
                                     value="${pet.pet_pk}"/>
                        </c:url><c:url var="deletePet"
                                       value="/mypage/deletepet">
                            <c:param
                                    name="pet_delete_pk"
                                    value="${pet.pet_pk}"/>
                        </c:url>
                            <a
                                    class="btn btn-outline-secondary"
                                    id="modifyPet"
                                    role="button"
                                    href="${modifyPet}">🔧</a>
                            <a
                                    class="btn btn-outline-danger"
                                    onclick="return confirm('삭제하시겠습니까?')"
                                    id="deletePet"
                                    role="button"
                                    href="${deletePet}">❌</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="text-center">
                <a class="btn btn-success mb-2" style="width: 10%; height: 100%;" role="button"
                   href="${addPetUrl}">Add</a>
            </div>
        </div>
    </div>
</main>

<!-- Footer-->
<%@ include file="../fragments/footer.jspf"%>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<!--axios없는 jsp에는 axios도 넣어주세용 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="../js/navcart-count.js"></script>
<script src="../js/cart-list.js"></script>
</body>
</html>