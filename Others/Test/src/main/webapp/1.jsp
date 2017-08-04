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

<header>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container-fluid">
                <table align="center" class="table">
                    <tr>
                        <td>
                            <div class="navbar-header">
                                <a class="navbar-brand" href="index.jsp"><h1><img src="images/logo.png" alt=""/></h1>
                                </a>
                            </div>
                        </td>
                        <td>
                            <form onSubmit="submitFn(this, event);">
                                <div class="search-wrapper">
                                    <div class="input-holder">
                                        <input type="text" class="search-input" placeholder="请输入关键词" />
                                        <button class="search-icon" onClick="searchToggle(this, event);"><span></span></button>
                                    </div>
                                    <span class="close" onClick="searchToggle(this, event);"></span>
                                    <div class="result-container">
                                    </div>
                                </div>
                            </form>
                        </td>
                        <td>
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
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</header>
<script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function searchToggle(obj, evt){
        var container = $(obj).closest('.search-wrapper');

        if(!container.hasClass('active')){
            container.addClass('active');
            evt.preventDefault();
        }
        else if(container.hasClass('active') && $(obj).closest('.input-holder').length == 0){
            container.removeClass('active');
            // clear input
            container.find('.search-input').val('');
            // clear and hide result container when we press close
            container.find('.result-container').fadeOut(100, function(){$(this).empty();});
        }
    }
    function submitFn(obj, evt){
        value = $(obj).find('.search-input').val().trim();

        _html = "您搜索的关键词： ";
        if(!value.length){
            _html = "关键词不能为空。";
        }
        else{
            _html += "<b>" + value + "</b>";
        }
        $(obj).find('.result-container').html('<span>' + _html + '</span>');
        $(obj).find('.result-container').fadeIn(100);
        evt.preventDefault();
    }
</script>
