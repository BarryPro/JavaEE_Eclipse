
<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>

<html>
<head>
<title>IVR����</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">

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
<body>
<form name="formbar" method="post" action="allIVRList.jsp" target="frameright">
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B><font face="Arial"></font>IVR����</B></div>
    <div id="Operation_Table">
      <table id="dataTable" width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <tr>
       <iframe id="frameright" name="frameright" scrolling=auto src="allIVRList.jsp" width=100% height=300 frameBorder=0 marginheight=0 marginwidth=0></iframe>
      </tr>
      </table>
      
      <table width="100%"  border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td align="right"> 
            <span style="align:left">
            <input type="text" name="called_no_agent" size="8"><font class="orange">*</font>
             <input type=hidden  name="transagent" value="">
            </span>
            <span style="align:right">
            <input class="b_foot" name="btn_refresh" type="button" value="ˢ��" onclick="statusRefreshAgent();">
            <input class="b_foot" name="btn_internalcall" type="button" value="ȷ��" onclick="gocalll()">
       		<input class="b_foot" name="back" type="button" onclick="window.close();" value="ȡ��">
       		</span>
          </td>
        </tr>  
      </table>
      
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>
</div>
</form>
</body>
</html>
 
<script>


/*��ʱˢ��*/
function statusRefreshAgent(){
document.forms[0].submit();
}

/*����ѡ������*/
function gocalll(){
var called_no_agent=document.getElementById("called_no_agent").value;
if(called_no_agent=='')
{
alert("��ѡ�񹤺�");
return false;
}
var transagent=document.getElementById("transagent").value;
window.opener.document.getElementById("transagent").value=transagent;
window.opener.document.getElementById("threePerson").value=called_no_agent;
callSwich(transagent);
var ret=window.opener.cCcommonTool.BeginListen(called_no_agent);
if(ret==0)
{
alert("����״̬");
callLisen("Y",transagent);
parent.window.opener.top.chgStatus("3","��ʼ����");
}
else
{
alert("û�гɹ������ø���״̬");
callLisen("N",transagent);
}

}



//����ת��A��ϯ����
	function callSwich(transagent)
	{
	    var packet = new AJAXPacket("../../../npage/callbosspage/K047/insertPublic.jsp","���ڴ���,���Ժ�...");
	    packet.data.add("contactId" ,parent.window.opener.top.document.getElementById("contactId").value);
	    packet.data.add("retType" ,  "chkExample");
	    packet.data.add("caller" ,  parent.window.opener.top.cCcommonTool.getCaller());
	    packet.data.add("called" ,  parent.window.opener.top.cCcommonTool.getCalled());
	    packet.data.add("transagent" ,transagent);
	    packet.data.add("oper_type" ,"3");
	     packet.data.add("op_code" ,"K047");
	    core.ajax.sendPacket(packet,doProcessNavcomring,false);
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
	    		alert("����ɹ�1!");
	    	}else{
	    		alert("����ʧ��1!");
	    		return false;
	    	}
	    }
	 }
	 
	 
//����ת��A��ϯת�ƺ����
function callLisen(sucssece,trasect) {
	var packet = new AJAXPacket("../../../npage/callbosspage/K047/updatePublic.jsp", "\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType", "chkExample");
	packet.data.add("sucssece", sucssece);
	packet.data.add("loginNo", trasect);
	core.ajax.sendPacket(packet, doProcessNavcomring, true);
	packet = null;
}

</script>



