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
<title>תָ������</title>
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
         <td class="blue">����</td>
         <td>
         	<select id="org_id" name="org_id" size="1">
         	 <option value="null">--ȫ��--</option>
         	 <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y'order by region_code</wtc:sql>
				  </wtc:qoption>

         	</select>
         </td>
        <td class="blue">����</td>
        <td> 
            <select id="class_id" name="class_id">
             <option value="null">--ȫ��--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select t.class_name,t.class_name from sCALLCLASS t order by t.class_desc</wtc:sql>
				    </wtc:qoption>
            </select>
        </td>
        <!--
        <td class="blue">������</td>
        <td> 
            <select id="skill_id" name="skill_id">
             <option value="null">--ȫ��--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select t.class_id,t.class_name from sCALLCLASS t</wtc:sql>
				    </wtc:qoption>
            </select>
        </td>
        -->
        <td class="blue">״̬</td>
        <td> 
            <select id="staffstatus" name="staffstatus">
             <option value="null">--ȫ��--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select STATUS_CODE ,STATUS_NAME from SSTAFFSTATUSCODE</wtc:sql>
				  </wtc:qoption>
            </select>
        </td>
        <td class="blue">ˢ�¼��ʱ��</td>
        <td> 
        <input name="flashTime" maxlength="8" index="27"  v_must=1 v_maxlength=8 v_type="integer" size="8" value="60" onchange="resetTimer(this);">��<font class="orange">*</font>
        </td>
        <td class="blue">��ʾ����</td>
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
            <input type="radio" name="transeType" value="0" checked>�ͷ�ת
            <input type="radio" name="transeType" value="2">�ɹ�ת
            -->
			 ����:<input type="text" name="called_no_agent" size="8"><font class="orange">*</font>
            <input type=hidden  name="transagent" value="">
            </span>
            <span style="align:right">
            <input class="b_foot" name="btn_refresh" type="button" value="ˢ��" onclick="statusRefreshAgent();">
            <input class="b_foot" name="btn_internalcall" type="button" value="ת��" onclick="gocalll()">
       		<input class="b_foot" name="back" type="reset" value="ȡ��">
        <!-- ��סѡ�� qiansheng 20100308--> <input class="b_foot" name="btn_refresh" type="button" value="��סѡ��" onclick="remember();">
       		<input class="b_foot" name="back" type="button" onclick="parent.window.close();" value="�ر�">
       		</span>
          </td>
        </tr>  
        
     </table>
      <!--TABLE����.����.  -->
</form>
</body>
</html>
<script>
/*��ʱˢ��*/
function statusRefreshAgent() {
	document.forms[0].submit();
}
/* ����ѡ������########BEGIN */// yanghy 20090917
function gocalll() {
	// alert("retTransToAgent��ʼ");
	var called_no_agent = document.getElementById("called_no_agent").value;
	if (called_no_agent == '') {
		// alert("��ѡ�񹤺�");
		rdShowMessageDialog("��ѡ�񹤺�!", 1);
		return false;
	}else if(called_no_agent == window.parent.opener.top.cCcommonTool.getWorkNo()){
		//yanghy 20090918 add .
		rdShowMessageDialog("����ѡ���Լ�!", 1);
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
		rdShowMessageDialog("��ϯ״̬��Ϊ���У��޷�ת��!", 1);
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
		// ���״̬��ȷ�ڽ�����־�Ĳ���.

		var arr = new Array();
		var oprTypeAll = arr.join(",");
		var oprType = 45;
		var sign = 1;
		window.parent.opener.top.recodeTime(oprTypeAll, oprType, sign,
				called_no_agent);
		// add by fangyuan ���Ӳ����ɹ����״̬�밴ť��������
		window.parent.opener.top.buttonType("K029");
		window.parent.opener.top.cCcommonTool.setOp_code("K029");
		window.parent.close();
	} else {
		rdShowMessageDialog("����ת�ƴ���,���⹤��״̬!", 1);
	}
}
/* ����ѡ������########END */
// ����ת��A��ϯ����
function callSwich(transagent) {
	var packet = new AJAXPacket(
			"../../../npage/callbosspage/K029/callSwichInsert.jsp",
			"���ڴ���,���Ժ�...");
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
// ��������ص�
function doProcessNavcomring(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if (retType == "chkExample") {
		if (retCode == "000000") {
			// alert("����ɹ�!");
			// rdShowMessageDialog("����ɹ�!",1);
		} else {
			// alert("����ʧ��!");
			rdShowMessageDialog("����ʧ��!", 0);
			return false;
		}
	}
}
var theTimer;
theTimer = setInterval('statusRefreshAgent()',
		document.all("flashTime").value * 1000);// ����Ϊ����
/**
 * ���ö�ʱˢ�¹��� fangyuan 20090305
 */
function resetTimer(el) {
	// tancf 20090523//Ĭ����Сֵ��15��.
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
	var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
	window.parent.opener.showMsg_temp=window.open("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_commNoteSend.jsp?loginno_call="+value,"֪ͨ����",'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',scrollbars=auto, resizable=no,location=no, status=yes');
}

function remember(){
	
	var orgId=document.all.org_id.value;//����
	var classId=document.all.class_id.value;//����
	var state=document.all.staffstatus.value;	//״̬
	var flashTime=document.all.flashTime.value;	//ˢ�¼��ʱ��
	var endNum=document.all.endNum.value;//��ʾ����	
	
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
	
		rdShowMessageDialog("�����ɹ�!",1);

}

</script>



<%
/*
*	���Ӽ�סѡ��Ĺ���
*	qiansheng 20100308
*/
	Map map =(Map)session.getAttribute("rememberMap");
	String orgId=WtcUtil.repNull((String)map.get("orgId"));//����
	String classId=WtcUtil.repNull((String)map.get("classId"));//����
	String state=	WtcUtil.repNull((String)map.get("state"));//״̬
	String flashTime=WtcUtil.repNull((String)map.get("flashTime"));//ˢ�¼��ʱ��
	String endNum=WtcUtil.repNull((String)map.get("endNum"));//��ʾ����	
	
	if(map!=null){
%>
		<script type="text/javascript">
						
					$(document).ready(function(){
						document.all.org_id.value="<%=orgId%>";//����
					  document.all.class_id.value="<%=classId%>";//����
						document.all.staffstatus.value="<%=state%>";	//״̬
						document.all.flashTime.value="<%=flashTime%>";//ˢ�¼��ʱ��
						document.all.flashTime.onchange();
						document.all.endNum.value="<%=endNum%>";;//��ʾ����	
					});	
		</script>
<%		
	}
%>