<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>ohdogcat - mypage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
          crossorigin="anonymous">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
          rel="stylesheet"/>
    <link href="../css/order/order-page.css" rel="stylesheet"/>
    <link href="../css/mypage.css" rel="stylesheet"/>
    <link href="../css/font.css" rel="stylesheet">
    <link href="../css/nav.css" rel="stylesheet">
</head>
<body>
<!--top nav -->
<%@ include file="../fragments/top-nav.jspf" %>
<%@ include file="../fragments/header.jspf" %>
<%@ include file="../fragments/bottom-nav.jspf" %>

<main class="outer-container row">
    <div class="col-2">
        <%@include file="../fragments/MyPageNav.jsp" %>
    </div>
    <div class="my-page-container container col-8">
        <h4 class="display-6">구매 이력보기</h4>
        <!-- End Page Title -->
        <c:if test="${not empty purchaseList}">
            <div>
                <section class="section">
                    <div class="card-body">
                        <!-- Table with stripped rows -->
                        <p class="lead pb-2">주인놈 떡에 너무 행복한 삶이다냥~</p>
                        <table class="table datatable py-3">
                            <thead>
                            <tr>
                                <th><b>주문명</b></th>
                                <th>주문번호</th>
                                <th>주문상태</th>
                                <th>결제방법</th>
                                <th data-type="date" data-format="YYYY/DD/MM">주문날짜</th>
                                <th>주문취소</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="purchase" items="${purchaseList}">
                                <tr class="purchase-list-item" data-id="${purchase.purchase_pk}">
                                    <td>
                                        <a
                                                class="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover text-dark"
                                                href="../order/${purchase.purchase_pk}"
                                        >
                                            <img
                                                    src="${purchase.img_url}"
                                                    alt=""
                                                    class="mx-3"
                                                    width="50px"
                                                    height="50px"
                                                    style="border: 1px solid gray"
                                            />
                                                ${purchase.order_name}</a
                                        >
                                    </td>
                                    <td class="align-middle">${purchase.purchase_pk}</td>
                                    <td class="align-middle">
                                        <c:choose>
                                            <c:when test="${purchase.status_pk eq 6}">
                                                <span class="badge bg-success fs-6">${purchase.purchase_status}</span>
                                            </c:when>
                                            <c:when test="${purchase.status_pk eq 7 or purchase.status_pk eq 8}">
                                                <span class="badge bg-danger fs-6">${purchase.purchase_status}</span>
                                            </c:when>
                                            <c:when test="${purchase.status_pk eq 5}">
                                                <span class="badge bg-primary fs-6">${purchase.purchase_status}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary fs-6">${purchase.purchase_status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="align-middle">${purchase.pay_method}</td>
                                    <td class="align-middle"
                                    >${purchase.purchase_date.year}/${purchase.purchase_date.monthValue}/${purchase.purchase_date.dayOfMonth}</td>


                                    <td class="align-middle">
                                        <div class="d-flex"
                                             style="flex-direction: column;align-items: flex-start;">
                                            <button id="delete-btn"
                                                    <c:choose>
                                                        <c:when test="${purchase.status_pk eq 1 or purchase.status_pk eq 2 or purchase.status_pk eq 3}">
                                                            class="btn btn-warning btn-smaller-custom mb-1"
                                                            style="opacity: 0.7"
                                                        </c:when>
                                                        <c:otherwise>
                                                            class="btn btn-secondary btn-smaller-custom mb-1"
                                                            disabled
                                                        </c:otherwise>
                                                    </c:choose>
                                            >주문 취소
                                            </button>
                                            <button id="confirm-btn"
                                                    <c:choose>
                                                        <c:when test="${purchase.status_pk ne 5}">
                                                            class="btn btn-secondary btn-smaller-custom"
                                                            disabled
                                                        </c:when>
                                                        <c:otherwise>
                                                            class="btn btn-primary btn-smaller-custom"
                                                        </c:otherwise>
                                                    </c:choose>
                                                    style="opacity: 0.95">구매 확정
                                            </button>
                                        </div>
                                    </td>

                                </tr>
                            </c:forEach>

                                <%--                    --%>
                            </tbody>
                        </table>
                        <!-- End Table with stripped rows -->
                    </div>
                </section>
                <nav aria-label="Page navigation my-3" style="margin-bottom: 50px">
                    <ul class="pagination justify-content-center">

                        <c:url var="listPageUrlByPaginationPrev" value="./purchaseList">
                            <c:param name="curPage" value="${curPage-1}"/>
                        </c:url>
                        <c:url var="listPageUrlByPaginationNext" value="./purchaseList">
                            <c:param name="curPage" value="${curPage+1}"/>
                        </c:url>
                        <c:choose>
                        <c:when test="${curPage eq 1}">
                        <li class="page-item" id="paginationPrev"><a class="page-link"
                                                                     href="#none"
                        >
                            </c:when>
                            <c:otherwise>
                            <li class="page-item" id="paginationPrev"><a class="page-link"
                                                                         href="${listPageUrlByPaginationPrev}">
                                </c:otherwise>
                                </c:choose>
                                Previous</a></li>
                            <c:forEach begin="1" end="${page}" var="pageCount" step="1">
                            <c:url var="listPageUrlByPagination" value="./purchaseList">
                                <c:param name="curPage" value="${pageCount}"/>
                            </c:url>

                            <c:if test="${pageCount eq curPage}">
                            <li class="page-item active" aria-current="page"><a class="page-link"
                                                                                href="${listPageUrlByPagination}">${pageCount}</a>
                            </li>
                            </c:if>
                            <c:if test="${pageCount ne curPage}">
                            <li class="page-item"><a class="page-link"
                                                     href="${listPageUrlByPagination}">${pageCount}</a>
                            </li>
                            </c:if>
                            </c:forEach>
                            <c:choose>
                            <c:when test="${curPage eq page}">
                            <li class="page-item" id="paginationNext"><a class="page-link"
                                                                         href="#none">Next</a>
                            </li>
                            </c:when>
                            <c:otherwise>
                            <li class="page-item" id="paginationNext"><a class="page-link"
                                                                         href="${listPageUrlByPaginationNext}">Next</a>
                            </li>
                            </c:otherwise>
                            </c:choose>
                    </ul>
                </nav>
            </div>
        </c:if>
        <c:if test="${empty purchaseList}">
            <div class="container card my-5 border-0"
                 id="emptyCart"
                 style="border-radius: 24px; box-shadow: 0px 0px 10px 0px rgb(230, 230, 230);">
                <div class="card-body py-5">
                    <div class="row fw-semibold text-center"
                         style="font-size: 20px;">
                        <div class="col my-5">
                            <p style="font-size: 50px">📝</p>
                            구매 내역이 없습니다.
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</main>


<%@ include file="../fragments/footer.jspf" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script src="../js/order/orderList.js"></script>
<script src="../js/navcart-count.js"></script>
<script src="../js/cart-list.js"></script>
<script src="../js/member/memberPointNav.js"></script>
</body>
</html>
