<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-dark navbar-dark fixed-top">
    <a class="navbar-brand" href="/main">Beginner_Example</a>
    <%--    화면 작아졌을 때 생기는 아이콘--%>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navMenu">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navMenu">
        <ul class="navbar-nav">
            <a href='/board/list' class='nav-link'>메뉴</a>
        </ul>
        <ul class="navbar-nav ml-auto">
            <a href='/user/login' class='nav-link'>로그인</a>
        </ul>
    </div>
</nav>

<%--<%@include file="../includes/header.jsp" %>--%>

<section>
    <div class="container" style="margin-top: 100px">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">게시판 예제</h4>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성날짜</th>
                    </tr>
                    </thead>
                    <tbody id="board_tbody">
                    <%--                showList();--%>
                    </tbody>
                </table>
                <div class="text-right">
                    <a href="/board/write"  class="btn btn-secondary">글쓰기</a>
                </div>
                <div>
                    <div class='d-flex justify-content-center'>
                        <nav aria-label='Page navigation example'>
                            <ul class='pagination'>
                                <li class='page-item'><a class='page-link' href='#'>이전</a>
                                </li>
                                <li class='page-item'><a class='page-link' href='#'>1</a>
                                </li>
                                <li class='page-item'><a class='page-link' href='#'>2</a>
                                </li>
                                <li class='page-item'><a class='page-link' href='#'>3</a>
                                </li>
                                <li class='page-item'><a class='page-link' href='#'>4</a>
                                </li>
                                <li class='page-item'><a class='page-link' href='#'>5</a>
                                </li>
                                <li class='page-item'><a class='page-link' href='#'>다음</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>

                <div class="d-flex justify-content-center" style="margin-top: 15px">
                    <form class="form-inline" id="searchForm" action="/board/list" method="get">
                        <select class="custom-select mr-2" name="type">
                            <option selected>조건1</option>
                            <option>조건2</option>
                            <option>조건3</option>
                        </select>
                        <input class="form-control mr-2" type="text"/>
                        <button class="btn btn-secondary  mr-2 search-btn" type="submit">찾기</button>
                    </form>
                </div>

            </div>
        </div>
    </div>
</section>

<%--<%@include file="../includes/footer.jsp" %>--%>

<footer>
    <div class="container-fluid text-white"
         style="margin-top:50px;padding-top:30px;padding-bottom:30px;">
        <div class="container">
            <p>비기너 프로젝트 예시자료</p>
            <a href="https://www.koreatech.ac.kr/kor/Main.do" style="color: white; font-weight: bold">코리아텍 바로가기</a> /
            <a href="https://portal.koreatech.ac.kr/login.jsp" style="color: white; font-weight: bold">아우누리 바로가기</a>
        </div>
    </div>
</footer>
</body>
</html>

<script>

    function getList(callback, error) {
        $.ajax({
            type: 'get',
            url: '/boards/',
            contentType: "application/json; charset=utf-8",
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + sessionStorage.getItem("token"))
            },
            success: function (result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            },
            error: function (xhr, status, er) {
                if (error) {
                    error(er);
                }
            }
        });
    }

    $(document).ready(function () {
        console.log("Ready");
        showBoardList();
        function showBoardList() {
            getList(function (list) {
                var board_tbody = $('#board_tbody');
                var str = "";
                for (var i = 0, len = list.length; i < len; i++) {
                    str += "<tr>";
                    str += "<td>" + list[i].id + "</td>";
                    str += "<td><a href='board/read?id="+list[i].id+"'</a>" + list[i].title + "</td>";
                    str += "<td>" + list[i].nickname + "</td>";
                    str += "<td>" + list[i].created_at + "</td>";
                    str += "</tr>";
                }
                board_tbody.html(str);
            });
        }
    })

</script>





