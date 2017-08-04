<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%request.setCharacterEncoding("GBK");%>
<%
    String typeNum = request.getParameter("typeNum");
      /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

%>
<html>
<head>
<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>
<title><%if(typeNum.equals("K050")){%>强制示闲<%}else if(typeNum.equals("K051")){%>强制示忙<%}else if(typeNum.equals("K052")){%>强制签出<%}%></title>
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
	<style type="text/css">
		body,td{
		font-size:12px
		}
		</style>
</head>
<body onunload="clearInterval(theTimer);">
<form name="formbar" method="post" action="intergrepList.jsp" target="frameright">
<table width="98%" height="100%" border="0" align="center" cellpadding="1" cellspacing="1">
 
      <tr height="10%">
         <td class="blue">地市</td>
         <td>
         	<select id="org_id" name="org_id" size="1">
         	 <option value="">--全部--</option>
         	 <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y'order by region_code</wtc:sql>
				  </wtc:qoption>

         	</select>
         </td>
        <td class="blue">班组</td>
        <td> 
            <select id="class_id" name="class_id">
             <option value="null">--全部--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select t.class_name,t.class_name from sCALLCLASS t order by t.class_desc</wtc:sql>
				    </wtc:qoption>
            </select>
        </td>

        <td class="blue">状态</td>
        <td> 
            <select id="staffstatus" name="staffstatus">
             <option value="null">--全部--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select STATUS_CODE ,STATUS_NAME from SSTAFFSTATUSCODE</wtc:sql>
				  </wtc:qoption>
            </select>
        </td>
        <td class="blue">刷新间隔时间</td>
        <td> 
        <input name="flashTime" maxlength="8" index="27"  v_must=1 v_maxlength=8 v_type="integer" size="8" value="60" onchange="resetTimer(this)">秒<font class="orange">*</font>
        </td>
        <td class="blue">显示行数</td>
        <td> 
        <input name="endNum" maxlength="8" index="27"  v_must=1 v_maxlength=8 v_type="integer" size="8" value="9999"><font class="orange">*</font>
        </td>
      </tr>    
      <tr height="80%"><td colspan="10">
       <iframe id="frameright" name="frameright" scrolling=auto src="intergrepList.jsp" width=100% height=100% ></iframe>
      </td></tr>
 
      <tr height="10%"> 
          <td align="right" colspan="10"> 
            <span style="align:left">
            <input type="text" name="called_no_agent" size="8" readonly="true"><font class="orange">*</font>
             <input type=hidden  name="transagent" value="">
            </span>
            <span style="align:right">
            <input class="b_foot" name="btn_refresh" type="button" value="刷新" onclick="statusRefreshAgent();">
            <input class="b_foot" name="btn_internalcall" type="button" value="<%if(typeNum.equals("K050")){%>强制示闲<%}else if(typeNum.equals("K051")){%>强制示忙<%}else if(typeNum.equals("K052")){%>强制签出<%}%>" onclick="gocalll()">
       		<input class="b_foot" name="back" type="button" onclick="window.close();" value="关闭">
       		</span>
          </td>
      </tr>  
</table>

</form>
</body>
</html>
 
<script>


/*定时刷新*/
function statusRefreshAgent(){
//alert("Begin exec statusRefresh...");

//document.forms[0].action="intergrepList.jsp";
//document.forms[0].target="frameright";

//alert(document.getElementById("org_id").selected);
//alert(document.getElementById("class_id").value);
//alert(document.getElementById("staffstatus").value);

document.forms[0].submit();
}

/*呼叫选定工号*/
function gocalll(){
var called_no_agent=document.getElementById("called_no_agent").value;

if(called_no_agent=='')
{
	//alert("请选择工号");
	rdShowMessageDialog("请选择工号!",1);
	return false;
}else if(called_no_agent == window.opener.cCcommonTool.getWorkNo()){
	//yanghy 20090918 add .
	rdShowMessageDialog("不能选择自己!", 1);
	return false;
}
var transagent=document.getElementById("transagent").value;
window.opener.document.getElementById("transagent").value=transagent;
<%if(typeNum.equals("K050")){%>
var ret=window.opener.cCcommonTool.BeginAgentForceIdle(called_no_agent);

<%}
else if(typeNum.equals("K051")){%>
var ret=window.opener.cCcommonTool.BeginAgentForceBusy(called_no_agent);
//如果强制示忙成功，判断被示忙得工号之前示忙得状态，并更新这条记录，同时再插入强制示闲
 if(ret==0){
 var arr=new Array("'30'");
 var oprTypeAll=arr.join(",");
 var oprType=31;
 var sign=1;
	 window.opener.recodeTime(oprTypeAll,oprType,sign,called_no_agent); 
 //add by fangyuan 增加操作成功后的状态与按钮明暗控制
 //window.opener.buttonType("K051");
 window.opener.cCcommonTool.setOp_code("K051");
 //window.close(); 
}
<%}
else if(typeNum.equals("K052")){%>
var ret=window.opener.cCcommonTool.BeginAgentForceOut(called_no_agent);
  if(ret==0){
    var arr=new Array();
    var oprTypeAll=arr.join(",");
    var oprType=29;
    var sign=1;
	  window.opener.recodeTime(oprTypeAll,oprType,sign,called_no_agent); 
    //add by fangyuan 增加操作成功后的状态与按钮明暗控制
    //window.opener.buttonType("K052");
    window.opener.cCcommonTool.setOp_code("K052");
    //window.close();
}
<%}%>

callSwich(transagent);
if(ret==0)
{
//alert("更改状态");
callLisen("Y",transagent);
}
else
{
callLisen("N",transagent);
//alert("没有成功，不用更改状态");
}
}



//呼叫转移A坐席插入
	function callSwich(transagent)
	{
		  
	    var packet = new AJAXPacket("../../../npage/callbosspage/K050/insertK050.jsp","正在处理,请稍后...");
	    packet.data.add("contactId" ,parent.window.opener.top.document.getElementById("contactId").value);
	    packet.data.add("retType" ,  "chkExample");
	    <%if(typeNum.equals("K050")){%>
	     packet.data.add("op_code" ,"K050");
	     packet.data.add("oper_type" ,"30");
	     packet.data.add("transType" ,"10");  /*add by yinzx 20091004*/
	    <%}else if(typeNum.equals("K051")){%>
	     packet.data.add("op_code" ,"K051");
	     packet.data.add("oper_type" ,"31");
	     packet.data.add("transType" ,"11");  /*add by yinzx 20091004*/
	    <%}else if(typeNum.equals("K052")){%>
	     packet.data.add("op_code" ,"K052");
	     packet.data.add("oper_type" ,"29");
	     packet.data.add("transType" ,"12");  /*add by yinzx 20091004*/
	     <%}%>
	    packet.data.add("transagent" ,transagent);
	    packet.data.add("skillName" ,parent.window.opener.top.cCcommonTool.getSkillInfoExName());
	    core.ajax.sendPacket(packet,doProcessNavcomring,false);
			packet =null;
	}  
  //公共处理回调
function doProcessNavcomring(packet)	 
	 {
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("处理成功1!");
	    	}else{
	    		//alert("处理失败!");
	    		//rdShowMessageDialog("处理失败!",0);
	    		return false;
	    	}
	    }
	 }
//呼叫转移A坐席转移后更新
function callLisen(sucssece,transagent) {
	var packet = new AJAXPacket("../../../npage/callbosspage/K047/updatePublic.jsp", "\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType", "chkExample");
	packet.data.add("sucssece", sucssece);
	packet.data.add("loginNo", transagent);
	core.ajax.sendPacket(packet, doProcessNavcomring, true);
	packet = null;
}

var theTimer;

theTimer=setInterval('statusRefreshAgent()',document.all("flashTime").value*1000);//数字为毫秒
/**
  * 重置定时刷新功能
  * fangyuan 20090305
  */
function resetTimer(el){
	var interval = el.value;
	if(interval<15){
		interval = 15;
		document.all("flashTime").value=15;
	}
	clearInterval(theTimer);
	theTimer=setInterval('statusRefreshAgent()',interval*1000);
}

/*
 *  用于界面调整的全局变量
 *  oldsize：原始高度 
 *  flag   ：放大、缩小标记
 *  date   : 20090312
 *  author : fangyuan
 */	
var oldsize=document.body.scrollHeight;
var flag=0;
//界面大小调整的方法
function reSize(){
	var newsize=document.body.scrollHeight;

	if(flag==0){
		document.all("frameright").style.height=screen.availHeight-240;	
		flag++;
	}else if(flag==1){ //中间变化量，过渡到flag=3的情况
		flag+=2;
	}else if(flag==3){
		//alert('小'+flag);
		document.all("frameright").style.height=oldsize-260;	
		flag--;
	}else if(flag==2){//中间变化量，过渡到flag=0的情况
		flag-=2;
	}	
}
</script> 






