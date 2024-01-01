<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>커뮤니티 | ohdogcat</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
            rel="stylesheet" 
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
            crossorigin="anonymous">
    </head>
    <body>
    <!-- header -->
    <%@ include file="../fragments/header.jspf"%>
    
    <div class="container-fluid">
     
        <main class="my-2">
            <div class="card">
                <form class="card-body" id="modifyForm">
                    <div class="d-none">
                        <label class="form-label" for="post_pk">번호</label>
                        <input class="form-control" id="post_pk" name="post_pk"
                            type="text" value="${post.post_pk}" readonly />
                    </div>
                    <div class="my-2">
                        <label class="form-label" for="title">제목</label>
                        <input class="form-control" id="title" name="title"
                            type="text" value="${post.title}" autofocus />
                    </div>
                    <div class="my-2">
                        <label class="form-label" for="content">내용</label>
                        <textarea class="form-control" id="content" name="content">${post.content}</textarea>
                    </div>
                    <div class="my-2">
                        <label class="form-label" for="member_fk">작성자</label>
                        <input class="form-control" id="member_fk" 
                            type="text" value="${post.member_fk}" readonly />
                    </div>
                </form>
                <div class="card-footer">
                        <button class="btn btn-danger" id="btnDelete">삭제</button>
                        <button class="btn btn-success"id="btnUpdate">수정완료</button>
                </div>
                
            </div>
        </main> 
    
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
        crossorigin="anonymous"></script>
        
    <script src="../js/community/post-modify.js"></script>
    </body>
</html>