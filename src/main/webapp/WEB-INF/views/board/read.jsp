<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<section>
    <div class="container" style="margin-top:100px">
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-body">
                        <div id="board_info">
                            <h4 class="card-title">내용 보기
                            </h4>
                            <div class="form-group">
                                <label>닉네임</label>
                                <input type="text" name="nickname" class="form-control" readonly="readonly"/>
                            </div>
                            <div class="form-group">
                                <label>제목</label>
                                <input type="text" name="title" class="form-control" readonly="readonly"/>
                            </div>
                            <div class="form-group">
                                <label>내용</label>
                                <textarea name="content" class="form-control" rows="10" style="resize:none"
                                          readonly="readonly"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="text-right btn-div">
                                <button class="btn btn-primary float-right" id="modify_btn">수정</button>
                                <button class="btn btn-primary float-right" id="delete_btn">삭제</button>
                                <button class="btn btn-primary float-right" id="list_btn">목록</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

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
    $(document).ready(function () {
        var board_info = $('#board_info');
        var id = ${id};
        console.log(id);
        showBoard();

        function showBoard() {
            read(id, function (board) {
                board_info.find("input[name='nickname']").val(board.nickname);
                board_info.find("input[name='title']").val(board.title);
                board_info.find("textarea[name='content']").val(board.content);
            });
        }
    });

    function read(id, callback, error) {
        $.get("/board/" + id, function (result) {
            if (callback) {
                callback(result);
            }
        }).fail(function (xhr, status, err) {
            if (error) {
                error();
            }
        });
    }
    function read(id, callback, error) {
        $.ajax({
            type: 'get',
            url: '/api/board/' + id,
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
                location.href ="/user/login";
            }
        });
    }
</script>





