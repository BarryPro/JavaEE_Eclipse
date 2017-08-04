<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="My Play Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template,
    Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design"/>
    <script type="application/x-javascript"> addEventListener("load", function () {
        setTimeout(hideURLbar, 0);
    }, false);
    function hideURLbar() {
        window.scrollTo(0, 1);
    } </script>
    <!-- bootstrap -->
    <link href="css/bootstrap.min.css" rel='stylesheet' type='text/css' media="all"/>
    <!-- //bootstrap -->
    <link href="css/dashboard.css" rel="stylesheet">
    <!-- Custom Theme files -->
    <link href="css/style.css" rel='stylesheet' type='text/css' media="all"/>
    <script src="js/jquery-1.11.1.min.js"></script>
    <!-- js cookie plugin -->
    <script src="js/jquery.cookie.min.js"></script>
    <script src="js/ajax.js"></script>
    <script src="js/information.js"></script>
    <link href="css/upload.css" rel="stylesheet" type='text/css' media="all">
</head>
<body class="sidebar_hidden">
<nav class="navbar navbar-inverse navbar-fixed-top">
    <!-- 登录dropdown-->
    <%@include file="dropdown.jsp" %>
    <!-- pop-up-box -->
    <script type="text/javascript" src="js/modernizr.custom.min.js"></script>
    <link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all"/>
    <script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
    <!--//pop-up-box -->
    <div id="small-dialog3" class="mfp-hide">
        <h3>注册</h3>

        <div class="social-sits">
            <div class="facebook-button">
                <a href="#">Connect with Facebook</a>
            </div>
            <div class="chrome-button">
                <a href="#">Connect with Google</a>
            </div>
            <div class="button-bottom">
                <p>Already have an account? <a href="#small-dialog"
                                               class="play-icon popup-with-zoom-anim">登录</a></p>
            </div>
        </div>
        <div class="signup">
            <form action="UserControl" id="form2" method="post" enctype="multipart/form-data">
                <input type="text" class="email" placeholder="用户名" id="r_user" name="reusername"/>
                <input type="password" class="email" placeholder="至少6位密码" name="repassword" id="r_pwd"/>
                <input type="password" placeholder="两次密码要一至哦" name="repwd" id="r_repwd"/>
                <a href="#" class="file">选择用户文件
                    <input type="file" name="file0" id="file0">
                </a><br><br><br><br>
                <hr>
                <input type="button" id="my_reg" class="button" value="注册" onclick="register1()"/>
            </form>
        </div>
        <div class="clearfix"></div>
    </div>
    <div id="small-dialog7" class="mfp-hide">
        <h3>Create Account</h3>

        <div class="social-sits">
            <div class="facebook-button">
                <a href="#">Connect with Facebook</a>
            </div>
            <div class="chrome-button">
                <a href="#">Connect with Google</a>
            </div>
            <div class="button-bottom">
                <p>Already have an account? <a href="#small-dialog"
                                               class="play-icon popup-with-zoom-anim">Login</a></p>
            </div>
        </div>
        <div class="signup">
            <form action="upload.jsp">
                <input type="text" class="email" placeholder="Email" required="required"
                       pattern="([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?" title="Enter a valid email"/>
                <input type="password" placeholder="Password" required="required" pattern=".{6,}"
                       title="Minimum 6 characters required" autocomplete="off"/>
                <input type="submit" value="Sign In"/>
            </form>
        </div>
        <div class="clearfix"></div>
    </div>
    <div id="small-dialog4" class="mfp-hide">
        <h3>Feedback</h3>

        <div class="feedback-grids">
            <div class="feedback-grid">
                <p>Suspendisse tristique magna ut urna pellentesque, ut egestas velit faucibus. Nullam mattis
                    lectus ullamcorper dui dignissim, sit amet egestas orci ullamcorper.</p>
            </div>
            <div class="button-bottom">
                <p><a href="#small-dialog" class="play-icon popup-with-zoom-anim">登录</a> to get started.</p>
            </div>
        </div>
    </div>
    <div id="small-dialog5" class="mfp-hide">
        <h3>Help</h3>

        <div class="help-grid">
            <p>Suspendisse tristique magna ut urna pellentesque, ut egestas velit faucibus. Nullam mattis lectus
                ullamcorper dui dignissim, sit amet egestas orci ullamcorper.</p>
        </div>
        <div class="help-grids">
            <div class="help-button-bottom">
                <p><a href="#small-dialog4" class="play-icon popup-with-zoom-anim">Feedback</a></p>
            </div>
            <div class="help-button-bottom">
                <p><a href="#small-dialog6" class="play-icon popup-with-zoom-anim">Lorem ipsum dolor sit
                    amet</a></p>
            </div>
            <div class="help-button-bottom">
                <p><a href="#small-dialog6" class="play-icon popup-with-zoom-anim">Nunc vitae rutrum enim</a>
                </p>
            </div>
            <div class="help-button-bottom">
                <p><a href="#small-dialog6" class="play-icon popup-with-zoom-anim">Mauris at volutpat leo</a>
                </p>
            </div>
            <div class="help-button-bottom">
                <p><a href="#small-dialog6" class="play-icon popup-with-zoom-anim">Mauris vehicula rutrum
                    velit</a></p>
            </div>
            <div class="help-button-bottom">
                <p><a href="#small-dialog6" class="play-icon popup-with-zoom-anim">Aliquam eget ante non orci
                    fac</a></p>
            </div>
        </div>
    </div>
    <div id="small-dialog6" class="mfp-hide">
        <div class="video-information-text">
            <h4>Video information & settings</h4>

            <p>Suspendisse tristique magna ut urna pellentesque, ut egestas velit faucibus. Nullam mattis lectus
                ullamcorper dui dignissim, sit amet egestas orci ullamcorper.</p>
            <ol>
                <li>Nunc vitae rutrum enim. Mauris at volutpat leo. Vivamus dapibus mi ut elit fermentum
                    tincidunt.
                </li>
                <li>Nunc vitae rutrum enim. Mauris at volutpat leo. Vivamus dapibus mi ut elit fermentum
                    tincidunt.
                </li>
                <li>Nunc vitae rutrum enim. Mauris at volutpat leo. Vivamus dapibus mi ut elit fermentum
                    tincidunt.
                </li>
                <li>Nunc vitae rutrum enim. Mauris at volutpat leo. Vivamus dapibus mi ut elit fermentum
                    tincidunt.
                </li>
                <li>Nunc vitae rutrum enim. Mauris at volutpat leo. Vivamus dapibus mi ut elit fermentum
                    tincidunt.
                </li>
            </ol>
        </div>
    </div>
    </div>
    <div class="signin">
        <div id="small-dialog" class="mfp-hide">
            <h3>登录</h3>

            <div class="social-sits">
                <div class="facebook-button">
                    <a href="#">Connect with Facebook</a>
                </div>
                <div class="chrome-button">
                    <a href="#">Connect with Google</a>
                </div>
                <div class="button-bottom">
                    <p>New account? <a href="#small-dialog2" class="play-icon popup-with-zoom-anim">登录</a></p>
                </div>
            </div>
            <div class="signup">
                <form action="UserControl">
                    <input type="hidden" name="action" value="login"/>
                    <input type="text" class="email" placeholder="用户名" id="username" name="username"/>
                    <input type="password" placeholder="密码" name="password" id="password"/></br>
                    <input type="checkbox" id="sun" name="sun"/>记住一星期</label></br>
                    <input type="submit" value="登录"/>
                </form>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="signin">
        <div id="small-dialog2" class="mfp-hide">
            <h3>上传</h3>

            <div class="social-sits">
                <div class="facebook-button">
                    <a href="#">Connect with Facebook</a>
                </div>
                <div class="chrome-button">
                    <a href="#">Connect with Google</a>
                </div>
                <div class="button-bottom">
                    <p>Already have an account? <a href="#small-dialog"
                                                   class="play-icon popup-with-zoom-anim">登录</a></p>
                </div>
            </div>
            <div class="signup">
                <form action="UserControl">
                    <input type="hidden" name="action" value="upload"/>
                    <a href="#" class="file">选择电影海报图片
                        <input type="file" name="" >
                    </a><br><br><br><br>
                    <a href="#" class="file">选择上传电影文件
                        <input type="file" name="" >
                    </a><br><br><br><br>
                    <hr>
                    <input type="button" class="button" value="上传" align="left"/>
                </form>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="clearfix"></div>
    </div>
    </div>
    <div class="clearfix"></div>
    </div>
</nav>

