<html>
<#include "common/head.ftl" encoding="utf-8" parse="true"/>
<body>
<nav class="top-area">

    <div class="search-tr">
        <table class="top-table">
            <tr>
                <td class="logo-table">
                    <div><i><label class="logo-B"></label><span class="logo"></span><label class="logo-G"></label></i>
                    </div>
                </td>
                <td class="search-table">
                    <div class="search">
                        <input type="text" placeholder="Search...">
                        <button type="submit"></button>
                    </div>
                </td>
                <td class="login-table">
                    <div class="label-div">
                        <label class="email-area" id="email-area"></label><span>|</span>
                        <label class="message-area" id="message-area"></label><span>|</span>
                        <label class="user-area"></label>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</nav>

<div class="display-area-group">
    <div class="video-window" id="video-window">
        <span id="close-video"></span>
        <video controls class="video-player" id="video-player" >
            <source src="" type="video/mp4">
        </video>
    </div>
    <div class="menu-area" id="menu-area">
        <ul>
            <li class="home"><span id="home">首页</span></li>
            <li class="movie"><span id="movie">电影</span></li>
            <li class="tv"><span id="ju">电视剧</span></li>
            <li class="codiepie"><span id="dm">动漫</span></li>
            <li class="diamond"><span id="zy">综艺</span></li>
            <li class="music"><span id="mv">音乐mv</span></li>
            <li class="video"><span id="video">视频短片</span></li>
            <li class="caret-"><span id="course">公开课</span></li>
            <li class="fire"><span id="hot">热门影片</span></li>
            <li class="map-signs"><span id="zhuanti">电影专题</span></li>
        </ul>
        <div class="chart-area">
            <img src="../80sHome/chart" alt="图表" class="chart-size" id="chart">
        </div>
    </div>
    <div class="display-area">
        <div class="display-setting">
            <div class="video-view">
                <table>
                    <tr>
                        <td><a href="http://www.80s.tw/movie/14976"><img src="http://t.dyxz.la/upload/img/201506/14976_b.jpg!list"/></a></td>
                    </tr>
                    <tr class="span-title"><td><span>belong放到和更符合规范</span></td></tr>
                    <tr><td>评分</td></tr>
                </table>
            </div>
        </div>
        <div class="display-page">
            <a>上一页</a>
            <a>1</a>
            <a>2</a>
            <a>3</a>
            <a>下一页</a>
        </div>
    </div>
    <div class="setting-area" id="setting-area">
        <h5 class="theme"><span>主题</span></h5>
        <h5 class="setting-h5"><span>设置</span></h5>
    </div>
    <div class="setting-btn" id="setting-btn">

    </div>
    <div class="info-area" id="info-area"></div>
    <div class="display-img" id="display-img"></div>
</div>
<div class="other-area">
    ＨＥＬＬＯＷＯＲＬＤ
</div>
</body>
</html>
