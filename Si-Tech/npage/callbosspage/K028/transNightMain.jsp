<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>
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
<title>��ָ������</title>


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
<body onunload="clearInterval(theTimer);" onresize="reSize()">


<form name="formbar" method="post" action="transNightList.jsp" target="frameright">
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B><font face="Arial"></font>��ָ������</B></div>
    <div id="Operation_Table">
    <div class="title">תָ������</div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <tr>
         <td class="blue">����</td>
         <td>
         	<select id="org_id" name="org_id" size="1">
         	 <option value="null">--ȫ��--</option>
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
				    <wtc:sql>select t.class_id,t.class_name from sCALLCLASS t</wtc:sql>
				    </wtc:qoption>
            </select>
        </td>
        <td class="blue">������</td>
        <td> 
            <select id="skill_id" name="skill_id">
             <option value="null">--ȫ��--</option>
             <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select t.class_id,t.class_name from sCALLCLASS t</wtc:sql>
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
        <input name="flashTime" maxlength="8" index="27"  v_must=1 v_maxlength=8 v_type="integer" size="8" value="8" onchange="resetTimer(this)">��<font class="orange">*</font>
        </td>
        <td class="blue">��ʾ����</td>
        <td> 
        <input name="endNum" maxlength="8" index="27"  v_must=1 v_maxlength=8 v_type="integer" size="8" value="9999"><font class="orange">*</font>
        </td>
      </tr>
     </table>
      
      <table id="dataTable" width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <tr>
       <iframe id="frameright" name="frameright" scrolling=auto src="transNightList.jsp" width=100% height=270 frameBorder=0 marginheight=0 marginwidth=0></iframe>
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
            <input class="b_foot" name="btn_internalcall" type="button" value="����" onclick="gocalll()">
       		<input class="b_foot" name="back" type="button" onclick="window.close();" value="ȡ��" >
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
//document.forms[0].action="transNightList.jsp";
//document.forms[0].target="frameright";
//alert(document.getElementById("org_id").selected);
//alert(document.getElementById("class_id").value);
//alert(document.getElementById("staffstatus").value);
//window.location.reload();
document.forms[0].submit();
}

/*����ѡ������*/
function gocalll(){
var called_no_agent=document.getElementById("called_no_agent").value;
var transagent=document.getElementById("transagent").value;
var ret=window.opener.cCcommonTool.PickupCallEx(called_no_agent);
if(ret==0)
{
callSwich(transagent,"Y");
parent.window.opener.top.chgStatus("5","ҹ������ɹ�ͨ��״̬");
//add by fangyuan ���Ӳ����ɹ����״̬�밴ť��������
window.opener.buttonType("K028");
window.opener.cCcommonTool.setOp_code("K028");
window.close();
}
else
{
callSwich(transagent,"N");
}
}
//����ת��A��ϯ����
	function callSwich(transagent,type1)
	{
	    var packet = new AJAXPacket("../../../npage/callbosspage/K028/transInsert.jsp","���ڴ���,���Ժ�...");
	    packet.data.add("contactId" ,window.opener.top.document.getElementById("contactId").value);
	    packet.data.add("retType" ,  "chkExample");
	     packet.data.add("type1" ,  type1);
	    packet.data.add("caller" ,  window.opener.top.cCcommonTool.getCaller());
	    packet.data.add("called" ,  window.opener.top.cCcommonTool.getCalled());
	    packet.data.add("transType" ,"5");
	    packet.data.add("transagent" ,transagent);
	    packet.data.add("skillName" ,cCcommonTool.getSkillInfoExName());
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
	    		//alert("����ɹ�!");
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
	var interval = el.value;
	if(interval<8){
		interval = 8;
		document.all("flashTime").value=8;
	}
	clearInterval(theTimer);
	theTimer=setInterval('statusRefreshAgent()',interval*1000);
}	 

/*
 *  ���ڽ��������ȫ�ֱ���
 *  oldsize��ԭʼ�߶� 
 *  flag   ���Ŵ���С���
 *  date   : 20090312
 *  author : fangyuan
 */	
var oldsize=document.body.scrollHeight;
var flag=0;
//�����С�����ķ���
function reSize(){
	var newsize=document.body.scrollHeight;

	if(flag==0){
		document.all("frameright").style.height=screen.availHeight-240;	
		flag++;
	}else if(flag==1){ //�м�仯�������ɵ�flag=3�����
		flag+=2;
	}else if(flag==3){
		//alert('С'+flag);
		document.all("frameright").style.height=oldsize-180;	
		flag--;
	}else if(flag==2){//�м�仯�������ɵ�flag=0�����
		flag-=2;
	}	
}
</script>



