<div style="display:none ">
	<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6
		VIEWASTEXT></OBJECT>
	<OBJECT id='varMacObject'
		classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>
</div>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%
request.setCharacterEncoding("GBK");
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

%>
<html>
	<head>
		<title>ǿ��ʾ��</title>
		<style type="text/css">
		body,td{
		font-size:12px
		}
		</style>
	</head>
	<body onunload="clearInterval(theTimer);">
		<form name="formbar" method="post" action="intergrepList.jsp" target="frameright">
			<!--<DIV id="Operation_Table" width="98%">-->
				<table width="98%" height="100%" border="0" align="center" cellpadding="1" cellspacing="1">
					<tr height="10%">
						<td nowrap>����</td>
						<td>
							<select id="org_id" name="org_id" size="1">
								<option value="">--ȫ��--</option>
									<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
										<wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y'order by region_code</wtc:sql>
									</wtc:qoption>
							</select>
						</td>
						<td nowrap>����</td>
						<td>
							<select id="class_id" name="class_id">
								<option value="null">--ȫ��--</option>
									<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
										<wtc:sql>select t.class_name,t.class_name from sCALLCLASS t order by t.class_desc</wtc:sql>
									</wtc:qoption>
							</select>
						</td>
						<td nowrap>״̬</td>
						<td>
							<select id="staffstatus" name="staffstatus">
								<option value="null">--ȫ��--</option>
									<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
										<wtc:sql>select STATUS_CODE ,STATUS_NAME from SSTAFFSTATUSCODE</wtc:sql>
									</wtc:qoption>
							</select>
						</td>
						<td nowrap>ˢ��ʱ��</td>
						<td nowrap>
							<input name="flashTime" maxlength="8" index="27" v_must=1 v_maxlength=8 v_type="integer" size="4" value="60" onchange="resetTimer(this)">��
	
						</td>
						<td nowrap>��ʾ����</td>
						<td nowrap>
							<input name="endNum" maxlength="8" index="27" v_must=1 v_maxlength=8 v_type="integer" size="8" value="9999">
						</td>
						<!--<td>������ͨ��̬</td>-->
						<td colspan="2" nowrap>
							������ͨ��̬&nbsp;<input type="checkbox" name="noNatural" id="noNatural" onClick="insertValue();" value="">
							<br>
							�Զ�ʾ��&nbsp;&nbsp;&nbsp;<input type="checkbox" name="autoForceIdle" id="autoForceIdle" onClick="autoForce(this);">
				  	</td>
				  </tr>
					<tr height="80%">
						<td colspan="12">
							<iframe id="frameright" name="frameright" scrolling=auto src="intergrepList.jsp" width="100%" height="100%">
							</iframe>
						</td>
					</tr>
					<tr height="10%">
						<td align="right" colspan="12">
							<span style="align:left"> 
							<input type="text" name="called_no_agent" size="20" readonly>
							<font class="orange">*</font> 
							<input type=hidden name="transagent" value="">
							</span>
							<span style="align:right">
							<input class="b_foot" name="btn_refresh" type="button" value="ˢ��" onclick="statusRefreshAgent();">
							<input class="b_foot" name="btn_internalcall" type="button" value="ǿ��ʾ��" onclick="gocalll()">
							<input class="b_foot" name="back" type="button" onclick="window.close();" value="�ر�">
							</span>
							
						</td>
					</tr>
				</table>
			<!--</div>-->
		</form>
	</body>
</html>

<script>
	
	function insertValue(){
		var ck = document.getElementById("noNatural").value;
		if(ck == "Y"){
			document.getElementById("noNatural").value = "";
		}else{
			document.getElementById("noNatural").value = "Y";
		}
	}
	
	var autotime;
	
	function autoForce(obj){
		if(obj.checked){
			autotime = setInterval('gocallExtends()',1000);
		}else{
			clearInterval(autotime);
		}
	}
	
	function gocallExtends(){
		gocalll();
	}
	
/*��ʱˢ��*/
function statusRefreshAgent(){
//alert("Begin exec statusRefresh...");

//document.forms[0].action="intergrepList.jsp";
//document.forms[0].target="frameright";

//alert(document.getElementById("org_id").selected);
//alert(document.getElementById("class_id").value);
//alert(document.getElementById("staffstatus").value);

document.forms[0].submit();
}

/*����ѡ������*/
function gocalll(){
	
	var called_no_agent=document.getElementById("called_no_agent").value;
	
	if(called_no_agent==''){
		//window.opener.parent.similarMSNPop("���޷�����ͨ��̬����");
		rdShowMessageDialog("��ѡ�񹤺�!", 1);
		return false;
	}else if(called_no_agent == window.opener.cCcommonTool.getWorkNo()){
		//yanghy 20090918 add .
		rdShowMessageDialog("����ѡ���Լ�!", 1);
		return false;
	}
	var current_CurState;
	if(window.opener.parPhone.QueryAgentStatusEx(called_no_agent)==0){
		current_CurState=window.opener.parPhone.AgentInfoEx_CurState;
	}
	if(current_CurState==1){
		window.opener.parent.similarMSNPop("��ϯ���ڿ���̬");
		setTimeout("statusRefreshAgent()", 300);
		return false;
	}
	if(current_CurState==2){
		window.opener.parent.similarMSNPop("��ϯ����Ԥռ��̬");
		setTimeout("statusRefreshAgent()", 300);
		return false;
	}
	if(current_CurState==3){
		window.opener.parent.similarMSNPop("��ϯ����ռ��̬");
		setTimeout("statusRefreshAgent()", 300);
		return false;
	}
	if(current_CurState==4){
		window.opener.parent.similarMSNPop("��ϯ����Ӧ��̬");
		setTimeout("statusRefreshAgent()", 300);
		return false;
	}
	if(current_CurState==5){
		window.opener.parent.similarMSNPop("��ϯ����ͨ��̬");
		setTimeout("statusRefreshAgent()", 300);
		return false;
	}
	
	
	
	var ret=window.opener.cCcommonTool.BeginAgentForceIdle(called_no_agent);
	if(ret==0){
	   var arrStr=new Array("'3','31'");
	   var oprTypeAll=arrStr.join(",");
	   var oprType=30;
		 var sign=1;
		 window.opener.recodeTime(oprTypeAll,oprType,sign,called_no_agent);
		 window.opener.cCcommonTool.setOp_code("K050");
	}
	setTimeout("statusRefreshAgent()", 300);
}

/*˫��ʾ��*/
function dbonclickcanle(cn){
	//var workNo=window.opener.cCcommonTool.getWorkNo();
	var current_CurState;
	if(window.opener.parPhone.QueryAgentStatusEx(cn)==0){
		current_CurState=window.opener.parPhone.AgentInfoEx_CurState;
	}
	
	if(current_CurState==1){
		window.opener.parent.similarMSNPop("��ϯ���ڿ���̬");
		setTimeout("statusRefreshAgent()", 300);
		return false;
	}
	if(current_CurState==2){
		window.opener.parent.similarMSNPop("��ϯ����Ԥռ��̬");
		setTimeout("statusRefreshAgent()", 300);
		return false;
	}
	if(current_CurState==3){
		window.opener.parent.similarMSNPop("��ϯ����ռ��̬");
		setTimeout("statusRefreshAgent()", 300);
		return false;
	}
	if(current_CurState==4){
		window.opener.parent.similarMSNPop("��ϯ����Ӧ��̬");
		setTimeout("statusRefreshAgent()", 300);
		return false;
	}
	if(current_CurState==5){
		window.opener.parent.similarMSNPop("��ϯ����ͨ��̬");
		setTimeout("statusRefreshAgent()", 300);
		return false;
	}
	var ret=window.opener.cCcommonTool.BeginAgentForceIdle(cn);
	if(ret==0){
	   var arrStr=new Array("'3','31'");
	   var oprTypeAll=arrStr.join(",");
	   var oprType=30;
		 var sign=1;
		 window.opener.recodeTime(oprTypeAll,oprType,sign,cn);
		 window.opener.cCcommonTool.setOp_code("K050");
	}
	setTimeout("statusRefreshAgent()", 300);
}

var theTimer;

theTimer=setInterval('statusRefreshAgent()',document.all("flashTime").value*1000);//����Ϊ����

/**
  * ���ö�ʱˢ�¹���
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

</script>