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
<section>
    <div class="container" style="margin-top:100px">
        <div class="row">
            <div class="col-sm-3"></div>
            <div class="col-sm-6">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">로그인</h4>
                        <div id="login_form">
                            <div class="form-group">
                                <label>아이디</label>
                                <input type="text" name="account_id" class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label>비밀번호</label>
                                <input type="password" name="password" class="form-control"/>
                            </div>
                            <div class="form-group text-right">
                                <button class="btn btn-primary" id="login_btn">로그인</button>
                                <button class="btn btn-primary" id="join_btn">회원가입</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-3"></div>
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
        var login_form = $("#login_form");

        $("#login_btn").on("click", function (e) {
            e.preventDefault();

            var login_info = {
                account_id: login_form.find("input[name='account_id']").val(),
                password: login_form.find("input[name='password']").val(),
            }
            login(login_info, function (result) {
                alert("success");
                console.log(result);
                sessionStorage.setItem("token", result)
                document.location.href = "/main"
            })
        });

        $("#join_btn").on("click", function (e) {
            document.location.href = "/user/join"
        });

    });

    function login(user, callback, error) {
        console.log("user = " + user);
        $.ajax({
            type: 'post',
            url: '/user/login',
            data: JSON.stringify(user),
            contentType: "application/json; charset=utf-8",
            success: function (result, status, xhr) {
                if(callback){
                    callback(result);
                }
            },
            error: function (xhr, status, er) {
                if(error){
                    error(er);
                }
            }
        });
    }
</script>
