<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<style type="text/css">
    *{margin:0;padding:0;list-style-type:none;}
    a,img{border:0;}
    body{font:12px/180% Arial,Lucida,Verdana,"宋体",Helvetica,sans-serif;font-size:13px;color:#211922;text-shadow:0 1px rgba(255,255,255,0.9);}
    /* 分页数字链接样式 */
    .pagebox{padding:30px 20px 20px 20px;}
    .paging a,.paging span.Bg,.paging a:hover,.paging a.cur,.paging a:hover span.Bg,.paging a.cur span.Bg{background:url(${my_path}/static/img/pagebg.png) no-repeat;}
    .paging{text-align:center;font-size:13px;}
    .paging a{padding-bottom:4px;display:inline-block;background-position:0 -134px;padding-bottom:11px;}
    .paging a:hover{text-decoration:none;}
    .paging b{font-weight:100;opacity:0;*visibility:hidden;}
    .paging span.Bg{
        width:58px;height:17px;line-height:17px;padding-left:5px;text-align:left;margin-right:1px;display:inline-block;background-position:0px 11px;cursor:pointer;
        -moz-transition:all 0.3s ease;
        -webkit-transition:all 0.3s ease;
        -o-transition:all 0.3s ease;
    }
    .paging a:link,.paging a:visited{color:#266EB0;}
    .paging a:hover,.paging a.cur{color:#fff;background-position:0px -93px;}
    .paging a:hover span.Bg,.paging a.cur span.Bg{background-position:0px -63px;}
    .paging a:hover span.Bg b,.paging a.cur span.Bg b{opacity:1;*visibility:visible;}
    /* 上下翻页样式 */
    .paging a.previous,.paging a.previous span.Bg,.paging a.previous b,.paging a.previous:hover,.paging a.previous:hover span.Bg,.paging a.previous:hover b,.paging a.nextpage,.paging a.nextpage span.Bg,.paging a.nextpage b,.paging a.nextpage:hover,.paging a.nextpage:hover span.Bg,.paging a.nextpage:hover b{background:url(${my_path}/static/img/prev-next-bg.png) no-repeat}
    .paging a.previous{background-position:0px -72px;}
    .paging a.previous span.Bg{width:61px;padding-left:0px;background-position:0px -121px;}
    .paging a.previous b{background-position:0px 17px;}
    .paging a.previous:hover{background-position:0px -25px;}
    .paging a.previous:hover span.Bg{background-position:0px -108px;}
    .paging a.previous:hover b{background-position:0px 4px;opacity:1;*visibility:visible;}
    .paging a.nextpage{background-position:-61px -72px;}
    .paging a.nextpage span.Bg{width:61px;padding-left:0px;background-position:-61px -121px;}
    .paging a.nextpage b{background-position:-61px 17px;}
    .paging a.nextpage:hover{background-position:-61px -25px;}
    .paging a.nextpage:hover span.Bg{background-position:-61px -108px;}
    .paging a.nextpage:hover b{background-position:-61px 4px;opacity:1;*visibility:visible;}
    .paging a.previous b,.paging a.nextpage b{
        width:61px;display:inline-block;height:17px;opacity:1;*visibility:visible;
        -moz-transition:all 0.6s ease;
        -webkit-transition:all 0.6s ease;
        -o-transition:all 0.6s ease;
    }
</style>
<div class="page_box">
    <div class="paging">
        <span id="header"></span>
        <span id="middle"></span>
        <span id="tail"></span>
    </div>
</div>
</body>
</html>
