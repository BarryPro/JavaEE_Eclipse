<%
   /*
　 * 版权: sitech
   * 修改历史
   * 修改日期:2010-08-19		修改人:songjia    修改目的:黑龙江客服系统框架整合
 　*/
%>
<!--div id="signal" class="s0">强度0</div-->
<!--div id="signal" class="s1">强度1</div-->
<!--div id="signal" class="s2">强度2</div-->
<!--div id="signal" class="s3">强度3</div-->
<!--div id="signal" class="s4">强度4</div-->

<!--(1)客服 songjia add 2010/08/19 begin 获取系统时间-->

<%
String myParams="";
//add by chenhr.
String user_id=(String)session.getAttribute("workNo");

%>

<!--(1)客服 songjia add 2010/08/19 end -->

<!--(2)客服 songjia add 2010/08/19 begin 注释掉信号强度-->
<!--
<div id="signal" class="s5">强度5</div>
-->
<!--(2)客服 songjia add 2010/08/19 end -->
<div id="imdiv">
	
	<!--<a href="javascript:void(0);" onclick="return loginJwchat();" class="im">即时消息系统</a>
	<a href="javascript:void(0);" onclick="return loginbbs();" class="bbs">BBS系统</a>-->
</div>
<%	
    String localURL = com.sitech.crmpd.core.wtc.context.Config.getValue( com.sitech.crmpd.core.wtc.context.Config.WEBLOGIC_1);
	if (localURL != null && localURL.length() > 7){
		localURL = localURL.substring(5, localURL.length() - 6);
	}
	 String urlNew = com.sitech.crmpd.core.wtc.context.Config.getValue( com.sitech.crmpd.core.wtc.context.Config.WEBLOGIC_1);
	 int urlNew_tmp = 0;
   if(urlNew!=null)
   {
   	urlNew_tmp = urlNew.indexOf(":")+1;   	
   	urlNew =urlNew.substring(urlNew_tmp,urlNew.length());
   	
   	urlNew_tmp = urlNew.indexOf(":")+1;
		urlNew =urlNew.substring(urlNew_tmp,urlNew.length());
   }
   %>
<div id="footPanel">
	   <ul>
	   	  <!--(3)客服 songjia add 2010/08/19 begin 修改状态条数据-->
	   	  <!--
	      <li>用户名：<%=session.getAttribute("workName")%></li>
	      <li>工号：<%=session.getAttribute("workNo")%></li>
	      <li>营业厅：<%=lastInfo[0][7]%></li>
	      <li>服务器：<%=localURL%>:<%=urlNew%></li>
	      -->  
	  	<table>
		<tr>
			
			<td style="width:12%;font-size:11px;padding-left:0px;padding-right:0px;"><%=session.getAttribute("workName")%></td>
			<td style="width:6%;font-size:11px;padding-left:0px;padding-right:1px;"><div id="waitDiv">等待数:0</div></td>
			<td style="width:4%;font-size:11px;padding-left:0px;padding-right:1px;"><div id="langDiv">普通话</div></td>
			<td style="width:6%;font-size:11px;padding-left:0px;padding-right:1px;" id="totalCallNum">接续量:0</td>
			<td style="width:11%;font-size:11px;padding-left:0px;padding-right:1px;"><div id="statusDiv">工作态:00:00:00</div></td>
			<td style="width:9%;font-size:11px;padding-left:0px;padding-right:0px;" id="SayBusyNowTime">示忙:00:00:00</td>
			<td style="width:12%;font-size:11px;padding-left:0px;padding-right:0px;"><div id="callDiv">受理时长:00:00:00</div></td>
			<!--td style="width:8%">坐席示忙成功</td-->
			<td style="width:8%;font-size:11px;padding-left:0px;padding-right:1px;"><div id="avgTimeDiv">平均时长:000</div></td>
			<td style="width:12%;font-size:11px;padding-left:0px;padding-right:0px;"><div id="playDiv">放音时长:00:00:00</td>
			<td style="width:5%;font-size:11px;padding-left:0px;padding-right:0px;"><div id="loginStatus"><a href="#" onclick="showLoginStatus();">状态信息</a></td>
			<!-- ///####################yanghy add public and note 2009.09.15 begin -->
			<td style="font-size:11px;padding-left:0px;padding-right:0px;">
			<div id=showNewPublicNoticeDiv style="float: left" style="overflow: hidden;white-space: nowrap;">
			<a href="#" onclick="showMessageDialog('0');">未读公告</a>
			<span style="color: red">0</span>
			<a href="#" onclick="showMessageDialog('1');">未读便签</a>
			<span style="color: red">0</span></div>
			</td>
			<!-- ///####################yanghy add public and note 2009.09.15 end -->
		</tr>	
	</table>		
   </ul>
</div>

<!-- for bbs begin -->
<form id="loginHljbbs" method='post' action='' target='_blank' style="display:none">
    <input type="hidden" name="username" value="<%=workNo%>"/>
    <input type="hidden" name="password" value="" />
    <input type="hidden" name="ck" value="no" />
</form>
<script type="text/javascript">
   function loginbbs(url){
      var form = document.getElementById('loginHljbbs');
          form.action='http://10.110.0.125:35000/hljbbs/LoginPost.htm';
          form.submit();
   }
</script> 
<!-- for bbs end -->
<!-- for im begion -->
<script type="text/javascript">
//展示员工状态	
function showLoginStatus(showId) {
	var url = '<%=request.getContextPath()%>/npage/callbosspage/k170/k17N_callMsgQry.jsp';
	var top = screen.availHeight/2-100;
	var left = screen.availWidth - 800;
  var opts = 'width=' + 750 + ',height=' + 300 +',top='+top+',left='+left;
    sysPopupWinOpen(url,opts);
    url = null;
    top = null;
    left = null;
    opts = null;
}


var jid;
var jwchats = new Array();
var SITENAME='10.110.0.125';
var DEFAULTRESOURCE='jwchat';
function loginJwchat() { 
  jid = "<%=login_no%>" + "@" + SITENAME + "/";
  jid += DEFAULTRESOURCE;

  jwchats[jid] = window.open('http://10.110.0.125:35000/hljim/jwchat.html?jid='+unicode(jid),'_blank','width=180,height=390,resizable=yes');
  return false;
}

function unicode(s){ 
   var len=s.length; 
   var rs=""; 
   for(var i=0;i<len;i++){ 
          var k=s.substring(i,i+1); 
          rs+= (i==0?"":",")+s.charCodeAt(i); 
   } 
   return rs; 
} 
</script>
<!-- for im end -->
<!--(4)客服 songjia add 2010/08/19 begin 时间运行函数及公告便签弹出函数-->
<script language="javascript">

var logintime = new Date();
//showTimesl();
//showWaitings();
//showWorkStatusTimesl();
//getLang();
//clockon();
var now = ""; 
var hour=0;
var minite=0;
var second=0;
function showTime() 
{
var secondVar;
var minitVar;
var hourVar;
second++;
if(second<10)
{
secondVar="0"+second;
}
else
{
  if(second==60)
  {
  second=0;
  secondVar="00";
  minite++;
  }
  else
  {
  secondVar=second+"";
  }
}
if(minite<10)
{
minitVar="0"+minite;
}
else
{
  if(minite==60)
  {
  minite=0;
  minitVar="00";
  hour++;
  }
  else
  {
  minitVar=minite+"";
  }
}
if(hour<10)
{
hourVar="0"+hour;
}
else
{
hourVar=hour+"";
}
now=hourVar+""+":"+minitVar+":"+secondVar;
setTimeout("showTime()",1000); 
appendText(document.getElementById("nowDiv"),"登录时长:"+now,null,0); 
} 


// 登录时长 by xingzhan 20090505

		
function clockon() {
	var logintimeint = logintime.getTime();
	var nowtime= new Date()
	var nowtimeint = nowtime.getTime();
	var num = nowtimeint - logintimeint;
	
	var SecMilli = 1000;
		
	var seconds =Math.floor (num / SecMilli);
	var minutes = Math.floor (seconds / 60);
	var hours = Math.floor (minutes / 60);
	
	seconds = seconds % 60;
	minutes = minutes % 60;
	
	if (eval(hours) < 10) {hours="0"+hours} 
	if (eval(minutes) < 10) {minutes="0"+minutes}
	if (seconds < 10) {seconds="0"+seconds}
	var thistime = hours+":"+minutes+":"+seconds;

	appendText(document.getElementById("nowDiv"),"登录时长:"+thistime,null,0);
	setTimeout("clockon()",200);
}





var nowsl = ""; 
var hoursl=0;
var minitesl=0;
var secondsl=0;
function showTimesl() 
{
var secondVarsl;
var minitVarsl;
var hourVarsl;
secondsl++;
if(secondsl<10)
{
secondVarsl="0"+secondsl;
}
else
{
  if(secondsl==60)
  {
  secondsl=0;
  secondVarsl="00";
  minitesl++;
  }
  else
  {
  secondVarsl=secondsl+"";
  }
}
if(minitesl<10)
{
minitVarsl="0"+minitesl;
}
else
{
  if(minitesl==60)
  {
  minitesl=0;
  minitVarsl="00";
  hoursl++;
  }
  else
  {
  minitVarsl=minitesl+"";
  }
}
if(hoursl<10)
{
hourVarsl="0"+hoursl;
}
else
{
hourVarsl=hoursl+"";
}
nowsl=hourVarsl+""+":"+minitVarsl+":"+secondVarsl;
setTimeout("showTimesl()",1000); 
appendText(document.getElementById("nowDiv"),"登录时长:"+nowsl,null,0); 
} 


/**
 * func:public timer 
 * in variables : id--div's id; tips--tip words;
 * author:fangyuan 20090220
 *
 */
var wnowsll = ""; 
var whoursll=0;
var wminitesll=0;
var wsecondsll=0;
var h_wTimer;
//为整理态延长提供实时已用的秒数 fangyuan 20090316
var g_usedSecs=0;
function showWorkStatusTimesl() 
{
var secondVarsl;
var minitVarsl;
var hourVarsl;
wsecondsll++;
g_usedSecs++;
if(wsecondsll<10)
{
secondVarsl="0"+wsecondsll;
}
else
{
  if(wsecondsll==60)
  {
  wsecondsll=0;
  secondVarsl="00";
  wminitesll++;
  }
  else
  {
  secondVarsl=wsecondsll+"";
  }
}
if(wminitesll<10)
{
minitVarsl="0"+wminitesll;
}
else
{
  if(wminitesll==60)
  {
  wminitesll=0;
  minitVarsl="00";
  whoursll++;
  }
  else
  {
  minitVarsl=wminitesll+"";
  }
}
if(whoursll<10)
{
hourVarsl="0"+whoursll;
}
else
{
hourVarsl=whoursll+"";
}
wnowsll=hourVarsl+""+":"+minitVarsl+":"+secondVarsl;

h_wTimer = setTimeout("showWorkStatusTimesl()",1000);

appendText(document.getElementById("statusDiv"),"工作态:"+wnowsll,null,0); 

} 

var anowsll = ""; 
var ahoursll=0;
var aminitesll=0;
var asecondsll=0;
var h_aTimer;
function showAdjustStatusTimesl() 
{
var secondVarsl;
var minitVarsl;
var hourVarsl;
asecondsll++;
if(asecondsll<10)
{
secondVarsl="0"+asecondsll;
}
else
{
  if(asecondsll==60)
  {
  asecondsll=0;
  secondVarsl="00";
  aminitesll++;
  }
  else
  {
  secondVarsl=asecondsll+"";
  }
}
if(aminitesll<10)
{
minitVarsl="0"+aminitesll;
}
else
{
  if(aminitesll==60)
  {
  aminitesll=0;
  minitVarsl="00";
  ahoursll++;
  }
  else
  {
  minitVarsl=aminitesll+"";
  }
}
if(ahoursll<10)
{
hourVarsl="0"+ahoursll;
}
else
{
hourVarsl=ahoursll+"";
}
anowsll=hourVarsl+""+":"+minitVarsl+":"+secondVarsl;
//modify wangyong 20090824 根据山西0824定版程序调整
cCcommonTool.DebugLog("javascript  showAdjustStatusTimesl  secondVarsl"+secondVarsl);
if(secondVarsl<=20){
h_aTimer = setTimeout("showAdjustStatusTimesl()",1000);
appendText(document.getElementById("statusDiv"),"调整态:"+anowsll,null,0); 
}
if(secondVarsl=='20'){
	clearTimeout(h_aTimer);
	appendText(document.getElementById("statusDiv"),"调整态:00:00:00",null,0);
}
//modify wangyong 20090921 再拿到山西代码后此部分又调整回原有的模式
/*h_aTimer = setTimeout("showAdjustStatusTimesl()",1000);
appendText(document.getElementById("statusDiv"),"调整态:"+anowsll,null,0); */

} 
/**
 * func:reset status's timer  将工作态时间置0 
 * strType : adjust 心态调整时传入，work 整理态时传入
 * author:fangyuan 20090220
 *
 */
function resetStatusTimer(){
	//alert('reset');
cCcommonTool.DebugLog("javascript  resetStatusTimer开始"+h_wTimer+"||"+h_aTimer);
	 clearTimeout(h_wTimer); //h_wTimer 工作态
     clearTimeout(h_aTimer); //h_aTimer 调整态
     h_wTimer = null;
     h_aTimer = null;
     wnowsll = ""; 
	 whoursll=0;
	 wminitesll=0;
	 wsecondsll=0;  
	 anowsll = ""; 
	 ahoursll=0;
	 aminitesll=0;
	 asecondsll=0; 
	 appendText(document.getElementById("statusDiv"),"工作态:00:00:00",null,0);
	 cCcommonTool.DebugLog("javascript  resetStatusTimer结束"+h_wTimer+"||"+h_aTimer);
}



///####################yanghy add public and note 2009.09.15 begin

function sysPopupWinOpen(url,opts){
	opts += ",status=yes,resizable=yes,menubar=no,scrollbars=yes";
	if (popupWin==null){popupWin=window.open( url,'', opts);}
	else if (popupWin.closed){popupWin=window.open( url,'', opts);
	}else
	{popupWin.close();popupWin=window.open( url,'', opts);}
}
var maxNoteId = new Number(-1);
var maxPublicNoticeId = new Number(-1);

//add by chenhr.20101103.为了实现弹出公告
var queryMaxPopPubilicNotice=function(){
			var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/notices/query_popPublicNotice_do.jsp","正在打开页面,请稍候...");
    	chkInfoPacket.data.add("user_id", "<%=user_id%>");
    	core.ajax.sendPacket(chkInfoPacket, submitResult);
			chkInfoPacket = null;
}
function submitResult(packet) {
    		var allid = packet.data.findValueByName("ids");
    		var allids=new Array();
    		allids=allid.split(",");
    		if(allids!=null){
					for(var i=0;i<allids.length;i++){
							if((allids[i]!="")&&(allids[i]!=null)){
						   	var url = '<%=request.getContextPath()%>/../notices/npage/notices/public_notice/PublicNotice_manager_view.jsp?userId=<%=user_id%>&id='+allids[i];
								var top = screen.availHeight/2 - 600;
								var left = screen.availWidth - 800;
								//客服 Modified by tangxlc 2010/09/13 调整公告便签弹出框大小为400 x 300
						   	 var opts = 'width=' + 400 + ',height=' + 300 +',scrollbars=yes,top='+top+',left='+left;
						    window.open(url,'name',opts);	 
						    //updateIsRead(allids[i]);
						    allids[i]=null;
					}	   
				}
		}
				//alert(allids);
 }
var queryMaxIdAjax = function(){
	$.ajax({//ajax begin
		url:'<%=request.getContextPath()%>/npage/callbosspage/notices/query_max_id_ajax_do.jsp',
		type:'get', //
		dataType:'html',//
		data:'',
		success:
			function(data){//funciton begin
				//alert(data);
				var showDiv = "";
				var canAlert = true;//set can alert default true;
				//public notice to do .
				var temp_1 = eval('('+data+')');//trans to json array.
				
				//add by chenhr.20101118.为了获得弹出标志
				//var pop_flag=temp.is_pop+"";
				//add end.
				temp_1 = new Number(temp_1.max_public_notice_id+"");
				var temp_2 = eval('('+data+')');//trans to json array.
				//alert(temp_1);
				temp_2 = temp_2.is_pop+"";
				//alert(maxNoteId+"/"+ temp_1);
				//alert(maxPublicNoticeId+"/"+ temp_1);
				if( temp_1 > maxPublicNoticeId &&(temp_2=="1") ){//
					//showMessageDialog('0');
					canAlert = false;//if here alert return .
				}
				maxPublicNoticeId = temp_1;
				showDiv += "<a href='#' onclick=showMessageDialog('0') >\u672a\u8bfb\u516c\u544a"
					+ "</a><span style='color: red;'>"
					+ maxPublicNoticeId + "</span>";
					
				temp_1 = eval('('+data+')');//trans to json array.
				//alert(temp_1);
				
				temp_1 = new Number(temp_1.max_note_id+"");
				//alert(maxNoteId+"/"+ temp_1);
					
				//note to do .
				if( canAlert && temp_1 > maxNoteId ){//
					//showMessageDialog('1');
				}
				maxNoteId = temp_1;
				showDiv += "&nbsp;<a href='#' onclick=showMessageDialog('1') >\u672a\u8bfb\u4fbf\u7b7e"
					+ "</a><span style='color: red;'>"
					+ maxNoteId + "</span>";
				$("#showNewPublicNoticeDiv").show().html(showDiv)
			}//funciton end ..
		});//ajax end .
}
<%
String userId = (String)request.getSession().getAttribute("workNo");

%>
function showMessageDialog(showId) {
	var url = '<%=request.getContextPath()%>/npage/callbosspage/notices/noticesAlertWindowMain.jsp?userId=<%=userId%>&showId='+showId;
	var top = screen.availHeight/2-100;
	var left = screen.availWidth - 800;
  var opts = 'width=' + 750 + ',height=' + 300 +',top='+top+',left='+left;
    sysPopupWinOpen(url,opts);
    url = null;
    top = null;
    left = null;
    opts = null;
}


//(5)客服 songjia add 2010/08/19 begin 暂时注释掉，公告便签弹出框

/*$(document).ready(function(){
    window.setInterval(function() {
        showMessageDialog();
    	if(canLoopAlertPopupWin){
    		queryMaxIdAjax();
    	}
    }, 10000);
});*/


//(5)客服 songjia add 2010/08/19 end

///####################yanghy add public and note 2009.09.15 end 
</script> 
<!-- yanghy add 20091202  -->
<iframe src="<%=request.getContextPath()%>/npage/callbosspage/notices/loginInitAppCache.jsp" width="0" height="0" frameborder="0"></iframe>
<iframe src="<%=request.getContextPath()%>/npage/module/notices_query_max_id_js.jsp" width="0" height="0" frameborder="0"></iframe>
<!--(4)客服 songjia add 2010/08/19 end 时间运行函数及公告便签弹出函数-->
