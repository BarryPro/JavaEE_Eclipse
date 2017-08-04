<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="index.jsp"><h1><img src="images/logo.png" alt=""/></h1></a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
        <div class="top-search">
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
                <input type="submit" value=" ">
            </form>
            <div align="right" id="mydiv">
                <label id="label1">${msg}</label>
            </div>
        </div>
        <div class="header-top-right" style="position: relative">
            <div class="container-fluid">
                <ul class="nav user_menu pull-right">
                    <li class="divider-vertical hidden-phone hidden-tablet"></li>
                    <li class="dropdown"><a href="#" class="dropdown-toggle"
                                            data-toggle="dropdown">
                        <c:if test="${user==null}">
                            <img src="img/user_avatar.png" alt="请登录" class="user_avatar"/>
                            游客
                        </c:if>
                        <c:if test="${user!=null}">
                            <img src="UserControl?action=pic&userid=${user.id}" alt="请登录" class="user_avatar"/>
                            ${user.username}

                        </c:if>
                        <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="#small-dialog" class="play-icon popup-with-zoom-anim">登录</a></li>
                            <li class="divider"></li>
                            <li><a href="#small-dialog3" class="play-icon popup-with-zoom-anim">注册</a></li>
                            <li class="divider"></li>
                            <li><a href="UserControl?action=loginout">登出</a></li>
                            <li class="divider"></li>
                            <li><a href="#small-dialog2" class="play-icon popup-with-zoom-anim">上传</a></li>
                            <li class="divider"></li>
                            <li><a href="#" onclick="disappear()">隐藏提示</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>