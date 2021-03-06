<%@ page import="domain.CollectPage" %>
<%@ page import="domain.User" %>
<%@ page import="service.userOption.UserOptionImp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <script src="../js/jquery-3.2.1.min.js"></script>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
        <title>用户个人中心</title>

        <!-- Bootstrap -->
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
        <script src="../js/jquery-3.2.1.min.js"></script>
        <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
        <script src="../js/bootstrap.min.js"></script>
        <!--[endif]-->

        <script src="../js/user/User.js"></script>
        <script src="../js/user/user_collect.js"></script>
        <link href="../css/user/User.css" rel="stylesheet">
        <link href="../css/user/user_collect.css" rel="stylesheet">

        <%
            CollectPage collectPage = null;
            collectPage = (CollectPage)session.getAttribute("collectPage");
            if(null == collectPage){
                response.sendRedirect("/CheckUserCollect?start=0");
            }else{
                User user = (User)session.getAttribute("user");
                int num = new UserOptionImp().getNum(3, user.getId(), 1);
                int pages = new UserOptionImp().getPages(num, 4);
                if(pages != collectPage.getPages()){
                    response.sendRedirect("/CheckUserCollect?start=0");
                }
            }

            session.removeAttribute("checkBlog");
        %>
    </head>

    <body background="../img/ARC%20X%20Windows%2010%20Theme简约4k风景壁纸3840x2160_彼岸图网.jpg">
    <!-- 顶部 -->
     <nav class="navbar navbar-default" style="background: white; width: 100%">
        <div class="container-fluid" id = "top">
            <!-- 首页 -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/CheckHome?labelId=0&&sortId=1">首页</a>
            </div>

            <!-- 创作中心 搜索框 搜索按钮 登陆注册按钮 -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <!-- 为管理员 -->
                <c:if test="${user.rank >= 1}">
                    <ul class="nav navbar-nav" style="width: 13%">
                        <li><a href="/ToCreateSpace?userId=${user.id}">创作中心</a></li>
                    </ul>
                    <ul class="nav navbar-nav" style="width: 9.5%" >
                        <li>
                            <a href="/CheckManager?sortId=1&&start=0&&rank=${user.rank}">管理员</a>
                        </li>
                    </ul>
                </c:if>
                <!-- 不为管理员 -->
                <c:if test="${user.rank == 0 || empty user.rank}">
                    <ul class="nav navbar-nav" style="width: 22.5%">
                        <li><a href="/ToCreateSpace?userId=${user.id}">创作中心</a></li>
                    </ul>
                </c:if>
                <form class="navbar-form navbar-left" style="width: 60%" method="post" action="/CheckSearch?idAuthor=false&&start=0&&sortId=1" onsubmit="return regSearch();">
                    <div class="form-group" style="width: 75%">
                        <input type="text" class="form-control" id = "searchContent" name="searchContent" placeholder="请开始搜索" value="${search.searchContent}" style="width: 100%">
                    </div>
                    <button type="submit" class="btn btn-default" id = "search">搜索</button>
                </form>
                <c:if test="${empty user}">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="LOGIN.jsp" id="login">登录</a></li>
                    </ul>
                </c:if>
                <c:if test="${not empty user}">
                    <ul class="nav navbar-nav navbar-right">
                        <img src=${user.head_img} alt="" class="img-circle" id = "right_head_img" onclick="javascrtpt:window.location.href='/CheckMyself?flag=1'">
                    </ul>
                </c:if>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
        <!-- 展开按钮 -->
        <button type="button" class="btn btn-primary" id="show_btn" onclick="show_()">》</button>
        <!-- 左边面板 -->
        <div class="row left" style="display: none">
            <div class="name row">
                <span id="name_span">@${user.user_name}</span>
            </div>

            <div class="list-group">
                <a href="/CheckMyself?flag=1" class="list-group-item" id="user_inf">个人资料</a>
                <a href="/CheckUserBlogs?start=0&&flag=1" class="list-group-item" id="user_blogs">我的博客</a>
                <a href="/CheckUserFollow?start=0" class="list-group-item" id="user_att">我的关注</a>
                <a href="/CheckUserFans?start=0" class="list-group-item" id="user_fans">我的粉丝</a>
                <a href="/CheckUserCollect?start=0" class="list-group-item" id="user_collect">我的收藏</a>
                <a href="/CheckUserColumns?userId=${user.id}&&start=0" class="list-group-item" id="user_columns">我的分类专栏</a>
            </div>
            <!-- 注销登录 -->
            <div class="row">
                <button type="button" class="btn btn-primary" onclick="javascrtpt:window.location.href='../main_jsp/LOGIN.jsp'">
                    注销登录
                </button>
            </div>

            <div class="row hide_div">
                <button type="button" class="btn btn-success" id="hide_btn" style="margin-top: 10px" onclick="hide_()">《
                </button>
            </div>
        </div>

        <div class="main row">
            <%-- 主体部 --%>
            <div class="main_center row">
                <!-- 标题 -->
                <div class="row collect_title">
                    我的收藏
                </div>
                <!-- 收藏栏 -->
                <div class="row show_collect">
                    <c:if test="${not empty collectPage.collect}">
                        <c:forEach items="${collectPage.collect}" var="theCollect" varStatus="status">
                            <!-- 具体收藏 -->
                            <div class="row collect">
                                <!-- 收藏数据 -->
                                <div class="row theCollect_data">
                                    <!-- 收藏名字 -->
                                    <div class="row theCollect_nhsuc">
                                        <!-- 博客标题 -->
                                        <div class="row theCollect_name" onclick="checkTheCollect(${status.index})">
                                            ${theCollect.blog_title}
                                        </div>
                                        <!-- 博客其他数据 -->
                                        <div class="row theCollect_other_data">
                                            <!-- 博客访客量 -->
                                            <div class="row theCollect_data_div">
                                                <img src="../img/articleReadEyes.png" class="data_img">
                                                ${theCollect.blog_scan_num}
                                            </div>
                                            <!-- 博客点赞量 -->
                                            <div class="row theCollect_data_div">
                                                <img src="../img/tobarThumbUpactive.png" class="data_img">
                                                    ${theCollect.blog_up_num}
                                            </div>
                                            <!-- 博客收藏量 -->
                                            <div class="row theCollect_data_div">
                                                <img src="../img/取消收藏.png" class="data_img">
                                                    ${theCollect.blog_collect_num}
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 关注是否取消收藏 -->
                                    <div class="row theCollect_collect">
                                        <!-- 取消收藏 -->
                                        <button type="button" class="btn btn-default" id="theCollect_collect_button" onclick="downTheCollect(${status.index})">取消收藏</button>
                                    </div>
                                </div>
                            </div>
                            <hr>
                        </c:forEach>
                    </c:if>
                </div>
                <!-- 分页 -->
                <div class="row page">
                    <c:if test="${collectPage.pages > 0}">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <!-- 为首页 -->
                                <c:if test="${collectPage.start / 4 == 0}">
                                    <li class="disabled">
                                        <a href="#" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                <!-- 不为首页 -->
                                <c:if test="${collectPage.start / 4 != 0}">
                                    <li>
                                        <a href="/CheckUserCollect?start=${(collectPage.now - 1) * 4}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                <!-- 获取页码 -->
                                <!-- 前半部分有多余页 -->
                                <c:if test="${collectPage.now - 2 > 1}">
                                    <!-- 为选中页 -->
                                    <c:if test="${0 == (collectPage.now)}">
                                        <li class="active">
                                            <span>${1} <span class="sr-only">(current)</span></span>
                                        </li>
                                    </c:if>
                                    <!-- 不为选中页 -->
                                    <c:if test="${0 != (collectPage.now)}">
                                        <li><a href="/CheckUserCollect?start=0">${1}</a></li>
                                    </c:if>
                                    <li><a>...</a></li>
                                    <c:forEach begin="${collectPage.now - 2}" end="${collectPage.now}" var="i" step="1">
                                        <!-- 为选中页 -->
                                        <c:if test="${(i) == (collectPage.now)}">
                                            <li class="active">
                                                <span>${i+1} <span class="sr-only">(current)</span></span>
                                            </li>
                                        </c:if>
                                        <!-- 不为选中页 -->
                                        <c:if test="${(i) != (collectPage.now)}">
                                            <li><a href="/CheckUserCollect?start=${i * 4}">${i+1}</a></li>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <!-- 前半部分无多余页 -->
                                <c:if test="${collectPage.now - 2 <= 1}">
                                    <c:forEach begin="0" end="${collectPage.now}" var="i" step="1">
                                        <!-- 为选中页 -->
                                        <c:if test="${(i) == (collectPage.now)}">
                                            <li class="active">
                                                <span>${i+1} <span class="sr-only">(current)</span></span>
                                            </li>
                                        </c:if>
                                        <!-- 不为选中页 -->
                                        <c:if test="${(i) != (collectPage.now)}">
                                            <li><a href="/CheckUserCollect?start=${i * 4}">${i+1}</a></li>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <!-- 后半部分有多余页 -->
                                <c:if test="${(collectPage.now + 2) < (collectPage.pages - 2)}">
                                    <c:forEach begin="${collectPage.now + 1}" end="${collectPage.now + 2}" var="i" step="1">
                                        <!-- 为选中页 -->
                                        <c:if test="${(i) == (collectPage.now)}">
                                            <li class="active">
                                                <span>${i+1} <span class="sr-only">(current)</span></span>
                                            </li>
                                        </c:if>
                                        <!-- 不为选中页 -->
                                        <c:if test="${(i) != (collectPage.now)}">
                                            <li><a href="/CheckUserCollect?start=${i * 4}">${i+1}</a></li>
                                        </c:if>
                                    </c:forEach>
                                    <li><a>...</a></li>
                                    <!-- 为选中页 -->
                                    <c:if test="${collectPage.pages - 1 == (collectPage.now)}">
                                        <li class="active">
                                            <span>${collectPage.pages} <span class="sr-only">(current)</span></span>
                                        </li>
                                    </c:if>
                                    <!-- 不为选中页 -->
                                    <c:if test="${collectPage.pages - 1 != (collectPage.now)}">
                                        <li><a href="/CheckUserCollect?start=${(collectPage.pages - 1) * 4}">${collectPage.pages}</a></li>
                                    </c:if>
                                </c:if>
                                <!-- 后半部分无多余页 -->
                                <c:if test="${(collectPage.now + 2) >= (collectPage.pages - 2)}">
                                    <c:forEach begin="${collectPage.now + 1}" end="${collectPage.pages - 1}" var="i" step="1">
                                        <!-- 为选中页 -->
                                        <c:if test="${(i) == (collectPage.now)}">
                                            <li class="active">
                                                <span>${i+1} <span class="sr-only">(current)</span></span>
                                            </li>
                                        </c:if>
                                        <!-- 不为选中页 -->
                                        <c:if test="${(i) != (collectPage.now)}">
                                            <li><a href="/CheckUserCollect?start=${i * 4}">${i+1}</a></li>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <!-- 不为尾页 -->
                                <c:if test="${collectPage.now != collectPage.pages - 1}">
                                    <li>
                                        <a href="/CheckUserCollect?start=${(collectPage.now + 1) * 4}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                <!-- 为尾页 -->
                                <c:if test="${collectPage.now == collectPage.pages - 1}">
                                    <li class="disabled">
                                        <a href="#" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>
    </body>
</html>
