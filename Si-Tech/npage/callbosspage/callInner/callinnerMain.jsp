<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%request.setCharacterEncoding("GBK");%>
<html>
<head>
<title>�ڲ�����תָ������</title>
<style type="text/css">
		body,td{
		font-size:12px
		}
		</style>
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/callInner/pubchgopts.js"></script>
<script language="javascript">
//jiangbing 20090608 �ж���ѡ����뻹���ֶ����� 1��Ϊѡ������
var isRaidoClick = 0;
</script>
</head>
<body onunload="clearInterval(theTimer);"  >
<%
 String mainCCS = request.getParameter("mainCCS");
 String BackCcsIP = request.getParameter("BackCcsIP");
 
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
%>
 
<form name="formbar" method="post" action="callinnerList.jsp" target="frameright">
 
 
    <table width="98%" height="100%" border="0" align="center" cellpadding="1" cellspacing="1">
      <tr height="10%">
         <td class="blue">����</td>
         <td>
         	<select id="org_id" name="org_id" size="1">
         	 <option value="null">--ȫ��--</option>
         	 <wtc:qoption name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode%>" >
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y'order by region_code</wtc:sql>
				  </wtc:qoption>

         	</select>
         </td>
        <td class="blue">����</td>
        <td> 
            <select id="class_id" name="class_id">
             <option value="null">--ȫ��--</option>
             <wtc:qoption name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
				    <wtc:sql>select t.class_name,t.class_name from sCALLCLASS t order by t.class_desc</wtc:sql>
				    </wtc:qoption>
            </select>
        </td>
        <!--
        <td class="blue">������</td>
        <td> 
            <select id="skill_id" name="skill_id">
             <option value="null">--ȫ��--</option>
             <wtc:qoption name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
				    <wtc:sql>select t.class_id,t.class_name from sCALLCLASS t</wtc:sql>
				    </wtc:qoption>
            </select>
        </td>
        -->
        <td class="blue">״̬</td>
        <td> 
            <select id="staffstatus" name="staffstatus">
             <option value="null">--ȫ��--</option>
             <wtc:qoption name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
				    <wtc:sql>select STATUS_CODE ,STATUS_NAME from SSTAFFSTATUSCODE</wtc:sql>
				  </wtc:qoption>
            </select>
        </td>
        <td class="blue">ˢ�¼��ʱ��</td>
        <td> 
        <input name="flashTime" maxlength="8" index="27"  v_must=1 v_maxlength=8 v_type="integer" size="8" value="60"   onchange="resetTimer(this);">��<font class="orange">*</font>
        </td>
        <td class="blue">��ʾ����</td>
        <td> 
        <input  name="endNum" maxlength="8" index="27"  v_must=1 v_maxlength=8 v_type="integer" size="8" value="9999"><font class="orange">*</font>
        </td>
      </tr>
      
      <!-- �б�ҳ��.��ʼ. -->
      <tr height="80%" ><td colspan="10">
       <iframe id="frameright" name="frameright" scrolling=auto src="callinnerList.jsp"  width=100%     height="100%"></iframe>
      </td></tr>
      <!--  �б�ҳ��.����. -->
      
        <tr height="10%"> 
          <td align="right" colspan="10" > 
            <span style="align:left">
			 ����:<input type="text" name="called_no_agent" size="8" onkeydown='isRaidoClick=0;'><font class="orange">*</font>
            <input type=hidden  name="transagent" value="">
            </span>
            <span style="align:right">
            <input class="b_foot" name="btn_refresh" type="button" value="ˢ��" onclick="statusRefreshAgent();">
            <input class="b_foot" name="btn_internalcall" type="button" value="����" onclick="gocalll()">
           <!-- ��סѡ�� qiansheng 20100308--> <input class="b_foot" name="btn_refresh" type="button" value="��סѡ��" onclick="remember();">
       		<input class="b_foot" name="back" type="button" onclick="window.close();" value="�ر�">
       		</span>
          </td>
        </tr>
        
      </table>
      <!--TABLE����.����.  -->
     
</form>
 
</body>
</html>
<script>
/*
 *  ���ڽ��������ȫ�ֱ���
 *  oldsize��ԭʼ�߶� 
 *  flag   ���Ŵ���С���
 *  date   : 20090312
 *  author : fangyuan
 */
var oldsize = document.body.scrollHeight;
var flag = 0;
// �����С�����ķ���
function reSize() {
	var newsize = document.body.scrollHeight;
	if (flag == 0) {
		document.all("frameright").style.height = screen.availHeight - 240;
		flag++;
	} else if (flag == 1) { // �м�仯�������ɵ�flag=3�����
		flag += 2;
	} else if (flag == 3) {
		// alert('С'+flag);
		document.all("frameright").style.height = oldsize - 180;
		flag--;
	} else if (flag == 2) {// �м�仯�������ɵ�flag=0�����
		flag -= 2;
	}
}
/* ��ʱˢ�� */
function statusRefreshAgent() {
	// alert("Begin exec statusRefresh...");
	// document.forms[0].action="callinnerList.jsp";
	// document.forms[0].target="frameright";
	// alert(document.getElementById("org_id").selected);
	// alert(document.getElementById("class_id").value);
	// alert(document.getElementById("staffstatus").value);
	document.forms[0].submit();
	// alert("End exec statusRefresh...");
}
// jiangbing 200090608 Ϊֱ�����빤�ź��е������ѯtransagentֵ
function gocalll() {
	var called_no_agent = document.getElementById("called_no_agent").value;
	if (called_no_agent == '') {
		// alert("��ѡ�񹤺�");
		rdShowMessageDialog("��ѡ�񹤺�!", 1);
		return false;
	}else if(called_no_agent == window.opener.cCcommonTool.getWorkNo()){
		//yanghy 20090918 add .
		rdShowMessageDialog("����ѡ���Լ�!", 1);
		return false;
	}

		var packet = new AJAXPacket(
				"<%=request.getContextPath()%>/npage/callbosspage/callInner/getTransagent.jsp",
				"\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("called_no_agent", called_no_agent);
		core.ajax.sendPacket(packet, doProcessgocalll, true);

}
function doProcessgocalll(packet) {
	var transagent = packet.data.findValueByName("transagent");
	document.getElementById("transagent").value = transagent;
	var staffstatus = packet.data.findValueByName("staffstatus");
	if(staffstatus!='1'){
		rdShowMessageDialog("��ϯ״̬��Ϊ���У��޷�����!", 1);
		return;
	}
	dogocalll();
}
/* ����ѡ������ */
function dogocalll() {
	var called_no_agent = document.getElementById("called_no_agent").value;
	var transagent = document.getElementById("transagent").value;
	window.opener.document.getElementById("transagent").value = transagent;
	// lijin 090313
	window.opener.document.getElementById("called_no_agent").value = called_no_agent;
	// end
	var current_CurState;
	if (window.opener.parPhone.QueryAgentStatusEx(called_no_agent) == 0) {
		current_CurState = window.opener.parPhone.AgentInfoEx_CurState;
		// similarMSNPop("current_CurState"+current_CurState);
	}
	current_CurState = 1;
	// alert("current_CurState"+current_CurState);
	if (current_CurState == 1 || current_CurState == 6) {
		callSwich(transagent);
		// lijin 090319
		window.opener.cCcommonTool.setCaller(window.opener.cCcommonTool
				.getWorkNo());
		window.opener.cCcommonTool.setCalled(called_no_agent);
		// end
		var ret = window.opener.cCcommonTool.CallInnerEx(called_no_agent, 5);
		// alert("ret"+ret);
		if (ret == 0) {
			var arr = new Array();
			var oprTypeAll = arr.join(",");
			var oprType = 41;
			var sign = 1;
			window.opener.recodeTime(oprTypeAll, oprType, sign, called_no_agent);
			// lijin 090311
			window.opener.document.getElementById("contactId").value = "";
			// add by fangyuan ���Ӳ����ɹ����״̬�밴ť��������
			// window.opener.buttonType("K030");
			window.opener.cCcommonTool.setOp_code("K030");
			window.close();
		}
	} else {
		// alert("���ڿ���̬�������Խ����ڲ�����");
		rdShowMessageDialog("���ڿ���̬�������Խ����ڲ�����!", 0);
		return false;
	}
}
// �ڲ�����A��ϯ����
function callSwich(transagent) {
	var called_no_agent = document.getElementById("called_no_agent").value;
	var packet = new AJAXPacket(
			"../../../npage/callbosspage/K029/callSwichInsert.jsp",
			"���ڴ���,���Ժ�...");
	packet.data.add("contactId", "");
	packet.data.add("retType", "chkExample");
	packet.data.add("caller", parent.window.opener.top.cCcommonTool.getWorkNo());
	packet.data.add("called", called_no_agent);
	packet.data.add("transagent", transagent);
	packet.data.add("skillName", parent.window.opener.top.cCcommonTool
			.getSkillInfoExName());
	packet.data.add("transType", "3");
	packet.data.add("op_code", "K030");
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
theTimer = setInterval('statusRefreshAgent()',document.all("flashTime").value * 1000);
// ����Ϊ����
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
// statusRefreshAgent();


/*
*	���Ӽ�סѡ��Ĺ���
*	qiansheng 20100308
*/
function remember(){
	
	var orgId=document.all.org_id.value;//����
	var classId=document.all.class_id.value;//����
	var state=document.all.staffstatus.value;	//״̬
	var flashTime=document.all.flashTime.value;	//ˢ�¼��ʱ��
	var endNum=document.all.endNum.value;//��ʾ����	
	
	var myPacket = new AJAXPacket ("ajax_remember.jsp");
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