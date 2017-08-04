/**
 * Created by belong on 2017/4/29.
 */

var $=function(id){
    return document.getElementById(id);
};

var vid = window.parent.param[1];
var pid = window.parent.param[0];
var data = window.parent.VideoListJson;
var surl = window.parent.urlinfo;
var isshowlist = window.parent.xShowList;
var tit = window.parent.xTitle;
var playurl = '';
var nextpurl = '';
var nextlink = '';
var pHeight = window.parent.xHeight;
var jNum = 0;

var adtime = window.parent.xADtime;
var adurl = window.parent.xADurl;


function ShowVideo(){
    var vArr = data[pid][1][vid].split("$");
    var sStr = GetplayList(data);
    jNum = data[pid][1].length;
    if(vid<jNum-1){
        nextpurl = data[pid][1][vid-1+2];
    }
    nextlink = GetNextLink(jNum);
    $("pbox").style.height = (window.parent.xHeight-30)+"px";
    $("pbox").style.width = window.parent.xWidth+"px";

    $("plist").style.height = (window.parent.xHeight-30)+"px";
    $("tit").style.width = (window.parent.xWidth-290)+"px";
    $("tit").innerHTML = tit+" "+vArr[0];


    if(isshowlist==0){
        $("plist").style.display="none";
        $("glist").innerHTML = '<a href="javascript:;" onclick="ShowList(this); return false;">展开/缩进选集</a>';
        $("viframe").width = window.parent.xWidth;
    }else{
        $("plist").style.display="block";
        $("glist").innerHTML = '<a href="javascript:;" onclick="ShowList(this); return false;">缩进/展开选集</a>';
        $("viframe").width = window.parent.xWidth-200;
    }
    $("viframe").height = window.parent.xHeight-30;

    $("gurl").innerHTML = GetNextUrl(jNum,0)+' '+GetNextUrl(jNum,1);
    $("plist").innerHTML = sStr;
    playurl = vArr[1];

    $("viframe").src = "playdy/"+vArr[2]+".html";
}

function GetplayList(data){
    var m = data.length;
    var S = '';
    for(var i=0;i<m;i++){
        var tstyle = '';
        var lstyle = 'none';
        if(i==pid){
            tstyle = ' tthis';
            lstyle = 'block';
        }
        S += '<div class="tit'+tstyle+'"><a href="javascript:;" onclick="ShowListGroup('+i+'); return false;">　> '+data[i][0]+'</a></div>';
        S += '<div class="list" style="display:'+lstyle+';" id="plist_'+i+'"><ul>';
        var n = data[i][1].length;
        for(var j=0;j<n;j++){
            var jArr = data[i][1][j].split("$");
            S += GetUrls(i,j,jArr[0]);
        }
        S +='</ul></div>';
    }
    return S;
}

function GetUrls(i,j,t){
    var u = surl;
    var s = '';
    u = u.replace("<from>",i);
    u = u.replace("<pos>",j);
    if(i==pid&&j==vid){
        s = ' class="jthis"';
    }
    return '<li'+s+'><a href="'+u+'" title="'+t+'" target="_top">'+t+'</a></li>';
}

function ShowListGroup(i){
    var obj = $("plist_"+i);
    if(obj.style.display=="block"){
        obj.style.display = "none";
    }else{
        obj.style.display = "block";
    }
}

function ShowList(obj){
    if(obj.innerHTML=="展开/缩进选集"){
        obj.innerHTML="缩进/展开选集";
        $("plist").style.display = "block";
        $("viframe").width = window.parent.xWidth-200;
    }else{
        obj.innerHTML="展开/缩进选集";
        $("plist").style.display = "none";
        $("viframe").width = window.parent.xWidth;
    }
}

function GetNextUrl(jnum,t){
    var u = surl;
    var s = '';
    u = u.replace("<from>",pid);
    if(t==1){
        if(vid<jnum-1){
            u = u.replace("<pos>",vid-1+2);
            s = '<a href="'+u+'" target="_top">下一集</a>'
        }else{
            s = '<span>下一集</span>';
        }
    }else{
        if(vid>0){
            u = u.replace("<pos>",vid-1);
            s = '<a href="'+u+'" target="_top">上一集</a>'
        }else{
            s = '<span>上一集</span>';
        }
    }
    return s;
}

function GetNextLink(jnum){
    var u = surl;
    u = u.replace("<from>",pid);
    if(vid<jnum-1){
        u = u.replace("<pos>",vid-1+2);
    }else{
        u = '';
    }
    return u;
}


document.write('<iframe src="/js/loading.html" id="Gxbuffer" scrolling="no" width="100%" height="100%" frameborder="0" marginheight="0" marginwidth="0" style="display:block;position:absolute;z-index:100;left:0%;top:30px;"></iframe>');

function close_ad(){
    document.getElementById('Gxbuffer').style.display='none';
}
setTimeout("close_ad()",6000);
