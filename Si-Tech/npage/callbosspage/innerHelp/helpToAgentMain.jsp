<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%request.setCharacterEncoding("GBK");
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

%>
<html>
<head>
<title>תָ������</title>
<style type="text/css">
		body,td{
		font-size:12px
		}
		</style>
<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
</head>
<body onunload="clearInterval(theTimer);" >


<form name="formbar" method="post" action="helpToAgentList.jsp" target="frameright">
 
    <table width="98%" height="100%" border="0" align="center" cellpadding="1" cellspacing="1" id=tb0>
      <tr height="10%">
         <td class="blue">����</td>
         <td>
         	<select id="org_id" name="org_id"">
         	  <option value="">--ȫ��--</option>
         	 <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y'order by region_code</wtc:sql>
				  </wtc:qoption>
         	</select>
         </td>
        <td class="blue">����</td>
        <td> 
            <select id="class_id" name="class_id">
             <option value="null">--ȫ��--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select t.class_name,t.class_name from sCALLCLASS t order by t.class_desc</wtc:sql>
				    </wtc:qoption>
            </select>
        </td>
        <td class="blue">״̬</td>
        <td> 
            <select id="staffstatus" name="staffstatus">
             <option value="null">--ȫ��--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
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
      
      <!-- �б�ҳ��.��ʼ. -->
      <tr height="80%"><td colspan="10">
       <iframe id="frameright" name="frameright" scrolling=auto src="helpToAgentList.jsp" width="100%" height="100%"></iframe>
      </td></tr>
      <!--  �б�ҳ��.����. -->
      
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
            <input class="b_foot" name="btn_internalcall" type="button" value="����" onclick="gocalll()">
       		<input class="b_foot" name="back" type="button" onclick="window.close();" value="�ر�">
       		</span>
          </td>
        </tr>  
      
    <!--TABLE����.����.  -->
 
 
 
</table>
 
</form>
</body>
</html>
<script>

/*��ʱˢ��*/
function statusRefreshAgent(){
//alert("Begin exec statusRefresh...");
//document.forms[0].action="helpToAgentList.jsp";
//document.forms[0].target="frameright";
//alert(document.getElementById("org_id").selected);
//alert(document.getElementById("class_id").value);
//alert(document.getElementById("staffstatus").value);
document.forms[0].submit();
//alert("End exec statusRefresh...");
}
/*����ѡ������*/
function gocalll(){
	var called_no_agent=document.getElementById("called_no_agent").value;
	if(called_no_agent=='')
	{
		//alert("��ѡ�񹤺�");
		rdShowMessageDialog("��ѡ�񹤺�!",1);
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
function dogocalll() {
	var called_no_agent = document.getElementById("called_no_agent").value;
	var transagent=document.getElementById("transagent").value;
	window.opener.document.getElementById("transagent").value=transagent;
	window.opener.document.getElementById("threePerson").value=called_no_agent;
	window.opener.document.getElementById("called_no_agent").value=called_no_agent;
	callSwich(transagent);
	var transeType="2";
	// var els1=document.all("transeType")
	 //for(var i=0;i<els1.length;i++){
	 //  if(els1[i].checked){
	 //  transeType=els1[i].value;
	  // }
	// }
	//lijin 090319
	window.opener.cCcommonTool.setCaller(window.opener.cCcommonTool.getWorkNo());
	window.opener.cCcommonTool.setCalled(called_no_agent);
	//end 
	var ret= window.opener.cCcommonTool.InternalHelpEx(5, called_no_agent, 1);
	//����ط�ִ�к��еĲ���.
	 // var ret=window.opener.cCcommonTool.CallInnerEx(called_no_agent,5);
	if(ret==0)
	{			
	       var arr=new Array();
		  var oprTypeAll=arr.join(",");
	       var oprType=40;
		  var sign=1;
		  window.opener.recodeTime(oprTypeAll,oprType,sign,called_no_agent);
	       // alert("����״̬");
	       parent.window.opener.top.chgStatus("5","�ڲ������ɹ�ͨ��״̬");
	       //add by fangyuan ���Ӳ����ɹ����״̬�밴ť��������
	       window.opener.buttonType("K014");
		  window.opener.cCcommonTool.setOp_code("K014");
		  window.close();
	}
	else
	{
	//alert("û�гɹ������ø���״̬");
	parent.window.opener.top.callSwichupdat("N");
	}
}
//����ת��A��ϯ����
	function callSwich(transagent)
	{
	    var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K029/callSwichInsert.jsp","���ڴ���,���Ժ�...");
	    packet.data.add("contactId" ,parent.window.opener.top.document.getElementById("contactId").value);
	    packet.data.add("retType" ,  "chkExample");
	    packet.data.add("caller" ,  parent.window.opener.top.cCcommonTool.getWorkNo());
	    packet.data.add("called" ,  parent.window.opener.top.cCcommonTool.getCalled());
	    packet.data.add("transagent" ,transagent);
	    packet.data.add("skillName" ,parent.window.opener.top.cCcommonTool.getSkillInfoExName());
	    packet.data.add("transType" ,"2");
	     packet.data.add("op_code" ,"K014");
	    core.ajax.sendPacket(packet,doProcessNavcomring,true);
			packet =null;
	}  
  //��������ص�
function doProcessNavcomring(packet)	 
	 {
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("11����ɹ�!");
	    		//rdShowMessageDialog("����ɹ�!",1);
	    	}else{
	    		//alert("����ʧ��!");
	    		rdShowMessageDialog("����ʧ��!",0);
	    		return false;
	    	}
	    }
	 }
var theTimer;

theTimer=setInterval('statusRefreshAgent()',document.all("flashTime").value*1000);//����Ϊ����
/**
  * ���ö�ʱˢ�¹���
  * fangyuan 20090305
  */
function resetTimer(el){
//tancf 20090523//Ĭ����Сֵ��15��.
	var interval = el.value*1;
	if(interval > 15){
		clearInterval(theTimer);
		theTimer = setInterval('statusRefreshAgent()',interval*1000);
	}else{
		el.value = 15;
	}
}

</script>