<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Bootstrap framework -->
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="bootstrap/css/bootstrap-responsive.min.css" />
<!-- jQuery UI theme -->
<link rel="stylesheet" href="lib/jquery-ui/css/Aristo/Aristo.css" />
<!-- theme color-->
<link rel="stylesheet" href="css/blue.css" id="link_theme" />
<!-- tooltips-->
<link rel="stylesheet" href="lib/jBreadcrumbs/css/BreadCrumb.css" />
<!-- tooltips-->
<link rel="stylesheet" href="lib/qtip2/jquery.qtip.min.css" />
<!-- colorbox -->
<link rel="stylesheet" href="lib/colorbox/colorbox.css" />
<!-- code prettify -->
<link rel="stylesheet" href="lib/google-code-prettify/prettify.css" />
<!-- notifications -->
<link rel="stylesheet" href="lib/sticky/sticky.css" />
<!-- aditional icons -->
<link rel="stylesheet" href="img/splashy/splashy.css" />
<!-- flags -->
<link rel="stylesheet" href="img/flags/flags.css" />
<!-- calendar -->
<link rel="stylesheet" href="lib/fullcalendar/fullcalendar_gebo.css" />
<!-- datepicker -->
<link rel="stylesheet" href="lib/datepicker/datepicker.css" />
<!-- tag handler -->
<link rel="stylesheet" href="lib/tag_handler/css/jquery.taghandler.css" />
<!-- uniform -->
<link rel="stylesheet" href="lib/uniform/Aristo/uniform.aristo.css" />
<!-- multiselect -->
<link rel="stylesheet" href="lib/multi-select/css/multi-select.css" />
<!-- enhanced select -->
<link rel="stylesheet" href="lib/chosen/chosen.css" />
<!-- wizard -->
<link rel="stylesheet" href="lib/stepy/css/jquery.stepy.css" />
<!-- upload -->
<link rel="stylesheet"
      href="lib/plupload/js/jquery.plupload.queue/css/plupload-gebo.css" />
<!-- CLEditor -->
<link rel="stylesheet" href="lib/CLEditor/jquery.cleditor.css" />
<!-- colorpicker -->
<link rel="stylesheet" href="lib/colorpicker/css/colorpicker.css" />
<!-- smoke_js -->
<link rel="stylesheet" href="lib/smoke/themes/gebo.css" />



<!-- main styles -->
<link rel="stylesheet" href="css/style.css" />



<!-- favicon -->
<link rel="shortcut icon" href="favicon.ico" />

<link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet"
      type="text/css" />


<!-- CKeditor -->

<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="ckfinder/ckfinder.js"></script>


<script type="text/javascript" src="js/jquery.cookie.js"></script><!-- js cookie plugin -->
<script src="js/jquery.cookie.min.js"></script>
<script src="js/ajax.js"></script>
<script src="js/information.js"></script>
<link rel="stylesheet" type="text/css" href="css/default.css" />

<!--必要样式-->
<link rel="stylesheet" type="text/css" href="css/search-form.css" />

<!-- favicon -->
<link rel="shortcut icon" href="favicon.ico"/>

<link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet"
      type="text/css"/>
<body class="sidebar_hidden">
<!-- 布局 -->
<div id="maincontainer" class="clearfix">
    <header>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="brand" href="http://www.papaok.org"><i
                            class="icon-home icon-white"></i> 易圣通灌水大乐园 <span class="sml_t">2.0</span></a>
                    <ul class="nav user_menu pull-right">
                        <li class="hidden-phone hidden-tablet">
                            <div class="nb_boxes clearfix">
                                <a data-toggle="modal" data-backdrop="static" href="#login"
                                   class="label ttip_b" title="登录"
                                   onclick="javascript:document.getElementById('submenu').innerHTML='登录'">
                                    <i class="splashy-calendar_week"></i>
                                </a>
                            </div>
                        </li>
                        <li class="divider-vertical hidden-phone hidden-tablet"></li>
                        <li class="dropdown"><a href="#" class="dropdown-toggle"
                                                data-toggle="dropdown">
                                <img src="img/user_avatar.png" alt="请登录" class="user_avatar"/>
                                游客
                            <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a data-toggle="modal" id="my"
                                       data-backdrop="static"
                                       href="#login" title="登录"
                                       onclick="javascript:document.getElementById('submenu').innerHTML='登录'">登录
                                </a></li>
                                <li><a data-toggle="modal" id="myf" data-backdrop="static"
                                       href="#register" title="注册"
                                       onclick="javascript:document.getElementById('submenu').innerHTML='注册'">注册</a>
                                </li>
                                <li><a href="#post" title="灌水" data-toggle="modal"
                                       id="myp" data-backdrop="static"
                                       onclick="javascript:addz();document.getElementById('submenu').innerHTML='灌水'">灌水</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="loginout.jsp"
                                       onclick="javascript:document.getElementById('submenu').innerHTML='${txt_ini}'">退出当前用户</a>
                                </li>
                            </ul>
                        </li>
                    </ul>

                </div>
            </div>
        </div>
    </header>