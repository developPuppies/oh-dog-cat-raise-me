<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New Post | ohdogcat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
          crossorigin="anonymous">
<style>
    .form-select {
        font-weight: bold;

    }
    .form-control {
        width: 100%; /* 원하는 너비로 조절 */
    }
    
    /* 버튼 스타일 */
    .custom-btn {
        /* 버튼 배경 색상 #ffd700; */
        color: white; /* 버튼 텍스트 색상 */
        width: 180px; 
        height: 52px;
        font-weight: bold; /* 글씨 굵게 */
    }
    
    .custom-btn:hover {
        background-color: #ffd700; /* 호버 상태일 때의 배경 색상 */
        color: white;
    }
    
    .form-select, .form-control {
        width: 90%; /* 너비를 90%로 설정 */
        margin: auto; /* 중앙 정렬 */
    }
    
    

    
</style>
</head>
<body>
    <%@ include file="../fragments/header.jspf"%>
    
    <main class="container mt-5 mb-5">
        <div class="" style="margin: auto; width:60%">
            <div class="card">
                <div class="card-body">
                    <form action="../community/createPost" method="post">
                        <div class="" style="width: 90%; margin: auto;">
                            <label for="post_category_fk" class="form-label"></label> 
                            <select class="form-select " id="category" name="post_category_fk" required>
                                <option value="" disabled selected>게시판 선택</option>
                                <option value="1">내새꾸 자랑</option>
                                <option value="2">[입양]키워주개</option>
                                <option value="3">[입양]키워주냥</option>
                                <option value="4">[실종/제보]길잃은멍</option>
                                <option value="5">[실종/제보]길잃은냥</option>
                            </select>
                        </div>
                        <div class="" style="width: 90%;  margin: auto;">
                            <label for="title" class="form-label"></label>
                            <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요." required autofocus >
                        </div>
                        <div class="" style="width: 90%;  margin: auto;">
                            <input type="" class="form-control" id="member_fk" name="member_fk" placeholder="userId(member_fk Long타입이다 은겸아)" required>
                        </div>
                        <div style="width: 90%;  margin: auto;">
                            <label for="content" class="form-label"></label>
                            <textarea class="form-control" id="content" name="content" required style="height: 300px; margin-bottom: 20px;"></textarea>
                        </div>
                        <div style="text-align: center;">
                            <button type="submit" class="btn custom-btn btn-warning">등록</button>
                        </div>
                    </form>
                </div> 
            </div>
        </div>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
            
    <!-- Footer-->
    <%@ include file="../fragments/footer.jspf"%>
    
</body>
</html>
