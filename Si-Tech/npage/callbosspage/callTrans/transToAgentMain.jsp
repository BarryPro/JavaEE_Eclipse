<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%request.setCharacterEncoding("GBK");%>
<%
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
%>
<html>
<head>
<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>
<title>转指定工号</title>
<style type="text/css">
		body,td{
		font-size:12px;background-color: #eef2f7;
		}
		</style>
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
</head>
<body onunload="clearInterval(theTimer);">

<form name="formbar" method="post" action="transToAgentList.jsp" target="frameright">
    <table width="98%" height="100%" border="0" align="center" cellpadding="1" cellspacing="1">
      <tr height="10%">
         <td class="blue">地市</td>
         <td>
         	<select id="org_id" name="org_id" size="1">
         	 <option value="null">--全部--</option>
         	 <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y'order by region_code</wtc:sql>
				  </wtc:qoption>

         	</select>
         </td>
        <td class="blue">班组</td>
        <td> 
            <select id="class_id" name="class_id">
             <option value="null">--全部--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select t.class_name,t.class_name from sCALLCLASS t order by t.class_desc</wtc:sql>
				    </wtc:qoption>
            </select>
        </td>
        <!--
        <td class="blue">技能组</td>
        <td> 
            <select id="skill_id" name="skill_id">
             <option value="null">--全部--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select t.class_id,t.class_name from sCALLCLASS t</wtc:sql>
				    </wtc:qoption>
            </select>
        </td>
        -->
        <td class="blue">状态</td>
        <td> 
            <select id="staffstatus" name="staffstatus">
             <option value="null">--全部--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select STATUS_CODE ,STATUS_NAME from SSTAFFSTATUSCODE</wtc:sql>
				  </wtc:qoption>
            </select>
        </td>
        <td class="blue">刷新间隔时间</td>
        <td> 
        <input name="flashTime" maxlength="8" index="27"  v_must=1 v_maxlength=8 v_type="integer" size="8" value="60" onchange="resetTimer(this);">秒<font class="orange">*</font>
        </td>
        <td class="blue">显示行数</td>
        <td> 
        <input name="endNum" maxlength="8" index="27"  v_must=1 v_maxlength=8 v_type="integer" size="8" value="9999"><font class="orange">*</font>
        </td>
      </tr>
      
      <tr height="80%"><td colspan="10">
       <iframe id="frameright" name="frameright" scrolling=auto src="transToAgentList.jsp" width="100%" height="100%"></iframe>
      </td></tr>
      
        <tr height="10%"> 
          <td align="right" colspan="10"> 
            <span style="align:left">
           	<!--
            <input type="radio" name="transeType" value="0" checked>释放转
            <input type="radio" name="transeType" value="2">成功转
            -->
			 工号:<input type="text" name="called_no_agent" size="8"><font class="orange">*</font>
            <input type=hidden  name="transagent" value="">
            </span>
            <span style="align:right">
            <input class="b_foot" name="btn_refresh" type="button" value="刷新" onclick="statusRefreshAgent();">
            <input class="b_foot" name="btn_internalcall" type="button" value="转移" onclick="gocalll()">
       		<input class="b_foot" name="back" type="reset" value="取消">
        <!-- 记住选项 qiansheng 20100308--> <input class="b_foot" name="btn_refresh" type="button" value="记住选项" onclick="remember();">
       		<input class="b_foot" name="back" type="button" onclick="parent.window.close();" value="关闭">
       		</span>
          </td>
        </tr>  
        
     </table>
      <!--TABLE主体.结束.  -->
</form>
</body>
</html>
<script>
/*定时刷新*/
function statusRefreshAgent() {
	document.forms[0].submit();
}
/* 呼叫选定工号########BEGIN */// yanghy 20090917
function gocalll() {
	// alert("retTransToAgent开始");
	var called_no_agent = document.getElementById("called_no_agent").value;
	if (called_no_agent == '') {
		// alert("请选择工号");
		rdShowMessageDialog("请选择工号!", 1);
		return false;
	}else if(called_no_agent == window.parent.opener.top.cCcommonTool.getWorkNo()){
		//yanghy 20090918 add .
		rdShowMessageDialog("不能选择自己!", 1);
		return false;
	}
	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/callInner/getTransagent.jsp", "\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("called_no_agent" , called_no_agent);
	core.ajax.sendPacket(packet, doProcessgocalll, true);
	
}
function doProcessgocalll(packet){
	var transagent = packet.data.findValueByName("transagent");
	var staffstatus = packet.data.findValueByName("staffstatus");
	document.getElementById("transagent").value = transagent;
	if(staffstatus!='1'){
		rdShowMessageDialog("坐席状态不为空闲，无法转移!", 1);
		return;
	}
	dogocalll();
}
function dogocalll(){
	var called_no_agent = document.getElementById("called_no_agent").value;
	var transagent = document.getElementById("transagent").value;
	window.parent.opener.top.document.getElementById("transagent").value = transagent;
	callSwich(transagent);

	var transeType = "2";
	// alert("called_no_agent"+called_no_agent);
	var ret = window.parent.opener.top.cCcommonTool.TransToAgent(5, transeType,
			called_no_agent);
	// alert("retTransToAgent"+ret);
	if (ret == 0) {
		// 如果状态正确在进行日志的插入.

		var arr = new Array();
		var oprTypeAll = arr.join(",");
		var oprType = 45;
		var sign = 1;
		window.parent.opener.top.recodeTime(oprTypeAll, oprType, sign,
				called_no_agent);
		// add by fangyuan 增加操作成功后的状态与按钮明暗控制
		window.parent.opener.top.buttonType("K029");
		window.parent.opener.top.cCcommonTool.setOp_code("K029");
		window.parent.close();
	} else {
		rdShowMessageDialog("呼叫转移错误,请检测工号状态!", 1);
	}
}
/* 呼叫选定工号########END */
// 呼叫转移A坐席插入
function callSwich(transagent) {
	var packet = new AJAXPacket(
			"../../../npage/callbosspage/K029/callSwichInsert.jsp",
			"正在处理,请稍后...");
	packet.data.add("contactId", parent.window.parent.opener.top.document.getElementById("contactId").value);
	packet.data.add("retType", "chkExample");
	packet.data.add("caller", parent.window.parent.opener.top.cCcommonTool.getCaller());
	packet.data.add("called", parent.window.parent.opener.top.cCcommonTool.getCalled());
	packet.data.add("transagent", transagent);
	packet.data.add("skillName", parent.window.parent.opener.top.cCcommonTool.getSkillInfoExName());
	packet.data.add("transType", "0");
	packet.data.add("op_code", "K029");
	core.ajax.sendPacket(packet, doProcessNavcomring, false);
	packet = null;
}
// 公共处理回调
function doProcessNavcomring(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if (retType == "chkExample") {
		if (retCode == "000000") {
			// alert("处理成功!");
			// rdShowMessageDialog("处理成功!",1);
		} else {
			// alert("处理失败!");
			rdShowMessageDialog("处理失败!", 0);
			return false;
		}
	}
}
var theTimer;
theTimer = setInterval('statusRefreshAgent()',
		document.all("flashTime").value * 1000);// 数字为毫秒
/**
 * 重置定时刷新功能 fangyuan 20090305
 */
function resetTimer(el) {
	// tancf 20090523//默认最小值是15秒.
	var interval = el.value * 1;
	if (interval > 15) {
		clearInterval(theTimer);
		theTimer = setInterval('statusRefreshAgent()', interval * 1000);
	} else {
		el.value = 15;
	}
}
function sendmsg(value){
	var iHeight=480;
	var iWidth =640;
	var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	window.parent.opener.showMsg_temp=window.open("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_commNoteSend.jsp?loginno_call="+value,"通知发送",'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',scrollbars=auto, resizable=no,location=no, status=yes');
}

function remember(){
	
	var orgId=document.all.org_id.value;//地市
	var classId=document.all.class_id.value;//班组
	var state=document.all.staffstatus.value;	//状态
	var flashTime=document.all.flashTime.value;	//刷新间隔时间
	var endNum=document.all.endNum.value;//显示行数	
	
	var myPacket = new AJAXPacket ("<%=request.getContextPath()%>/npage/callbosspage/callInner/ajax_remember.jsp");
	myPacket.data.add("orgId"  , orgId);
	myPacket.data.add("classId"  , classId);
	myPacket.data.add("state"  , state);
	myPacket.data.add("flashTime"  , flashTime);
	myPacket.data.add("endNum"  , endNum);
	core.ajax.sendPacket(myPacket,doRemember);
	myPacket=null; 
	
}


function doRemember(){
	
		rdShowMessageDialog("操作成功!",1);

}

</script>



<%
/*
*	增加记住选项的功能
*	qiansheng 20100308
*/
	Map map =(Map)session.getAttribute("rememberMap");
	String orgId=WtcUtil.repNull((String)map.get("orgId"));//地市
	String classId=WtcUtil.repNull((String)map.get("classId"));//班组
	String state=	WtcUtil.repNull((String)map.get("state"));//状态
	String flashTime=WtcUtil.repNull((String)map.get("flashTime"));//刷新间隔时间
	String endNum=WtcUtil.repNull((String)map.get("endNum"));//显示行数	
	
	if(map!=null){
%>
		<script type="text/javascript">
						
					$(document).ready(function(){
						document.all.org_id.value="<%=orgId%>";//地市
					  document.all.class_id.value="<%=classId%>";//班组
						document.all.staffstatus.value="<%=state%>";	//状态
						document.all.flashTime.value="<%=flashTime%>";//刷新间隔时间
						document.all.flashTime.onchange();
						document.all.endNum.value="<%=endNum%>";;//显示行数	
					});	
		</script>
<%		
	}
%>