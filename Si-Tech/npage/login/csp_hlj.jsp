<%@ page language="java" import="java.net.*" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%
System.out.println("-----------------csp_hlj.jsp------------------------");
 
	 /**add by  yinzx 0727 begin**/
	 String bossworkno=(String)session.getAttribute("workNo");

	 System.out.println("-----------------bossworkno------------------------"+bossworkno);
	 String orgCode =(String)session.getAttribute("orgCode");
	 String regionCode = orgCode.substring(0,2);
	 String myParams="boss_login_no="+bossworkno;
	
if(bossworkno==null){
%>
  <script>
    window.location="/npage/login/login.jsp";
  </script>
<%
}%>	 

	
<%
 String kf_login_no=(String)session.getAttribute("kf_login_no");
 session.setAttribute("kfWorkNo",kf_login_no);  
 String  sqlpowercode="SELECT TRIM(a.role_code)||','  FROM sLoginRoalRelation a,sPowerCode b  WHERE   SYSDATE BETWEEN a.begin_date AND a.end_date  AND TRIM(a.role_code) = TRIM(b.power_code)  and a.login_no = :boss_login_no";
%>	 
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=sqlpowercode%>"/>
		<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="powerrows" scope="end" />
<%
	  String powerCodex = "";
    for(int i=0;i<powerrows.length;i++)
    {
  	    powerCodex=powerCodex+powerrows[i][0];
    }

   session.setAttribute("powerCodekf",powerCodex);
   System.out.println("------------------powerCodekf------------------"+(String)session.getAttribute("powerCodekf"));
	
%>

<%
  /*add by yinzx 0713 begin*/
     session.setAttribute("kfFlag","kfFlag");
   /*add by yinzx 0713 end*/
  
 /*ȡ��ǰ��½���ŵĽ�ɫID��Ϊ���ŷָ���ַ��� hanjc add 20090423*/
 /*	String  powerCode = (String)session.getAttribute("powerCode"); modify yinzx 090801 */
	
	String[]  powerCodeArr = powerCodex.split(",");
	String isCommonLogin="N";	
	/*
	 *�Ƿ��ǻ���Ա ���Ի�����[0100020H] ����������[01120O02]��   ����ʱ��һ��
	 *
	 */
	for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<HUAWUYUAN_ID.length; j++){
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
				isCommonLogin="Y";
			}
		}
	}
  
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>
<div style="display:none">
	
//object��������ǩ��һ����ý��Ԫ�أ�codebase�����ںδ����ҵ���������Ĵ��룬�ṩһ����׼ URL
/*�˴���ָ����һ��ID='icdCfgObject'��OBJECT����������/ocx/localId.cabĿ¼�µ��������*/
/*CLSID:7F3929A0-C455-43EC-ACF0-8B1AD46873DC������HTMLҳ���С�*/
<OBJECT id='icdCfgObject' classid="CLSID:7F3929A0-C455-43EC-ACF0-8B1AD46873DC"
codebase="/ocx/localId.cab#version=1,1,0,0"
	  width=20
	  height=20
	  align=center
	  hspace=0
	  vspace=0>
</OBJECT>
</div>
 
<%
/**************��ȡ���ݿ�����ϵͳʱ��begin****************/
String sqlGetOracleHostTime = "SELECT to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') FROM dual";
String oracleHostTime = ""; 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
<wtc:param value="<%=sqlGetOracleHostTime%>"/>
</wtc:service>
<wtc:array id="oracleHostTimeList" scope="end"/>
<%
if(oracleHostTimeList.length > 0){
	oracleHostTime = oracleHostTimeList[0][0];
}
/**************��ȡ���ݿ�����ϵͳʱ��end****************/
%>
 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>��¼����ѡ�����</title>
	<link href="/nresources/default/css/main.css" rel="stylesheet" type="text/css" />
	
	<script>
	var i = 0;
	</script>

	<script language=javascript event=OnObjectReady(objObject,objAsyncContext) for=varMacObject>
	   if(objObject.IPEnabled != null && objObject.IPEnabled != "undefined" && objObject.IPEnabled == true){
	    //���mac��ַ
	    if(objObject.MACAddress != null && objObject.MACAddress != "undefined" && objObject.MACAddress != ""){
	      i++;
	      if(i == 1){
	    }
	    }
	   }
	</script>
	
	<script>	
	
	function countccno()
	{
	 var localIp=icdCfgObject.getLocalIp();
	 if(localIp!=null&&localIp!='')
	 {
	   var packet = new AJAXPacket("../../npage/callbosspage/public/getCCSNo.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	   packet.data.add("localIp", localIp);
		 core.ajax.sendPacket(packet,dogetCCSNo,true);
	   packet =null;	
	 } 
	}
	function dogetCCSNo(packet){	
	var rowCountNo =packet.data.findValueByName("rowCountNo");
	if(rowCountNo==2)
		{
		document.getElementById("callCenterno").style.display='';
		selectCCS(2); 
		}
	else
		{
		selectCCS(0); 
		}
	}
	
	countccno();
    /*��ת����ҳ��*/
	function customOnsubmit()
	{ 
		setLocalHostTime();
		window.open("main_kfnew.jsp?sign_phone_no=" + document.getElementById("cellphone").value + 
		            "&mainCCSIp=" + document.getElementById("mainCCSIp").value + 
		            "&mainCCSIp2=" + document.getElementById("mainCCSIp2").value + 
		            "&agentType=" + document.getElementById('agentType').value + 
		            "&CCSId=" + document.getElementById('CCSId').value +  
		            "&localIp=" + document.getElementById('localIp').value + 
		            "&p=" +document.getElementById('passwd').value +
		            "&loginStatus=" + document.getElementById('loginStatus').value + 
		            "&ccno=" + document.getElementById('ccno').value,
		            ''
		            ,'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
		window.opener=null;		
		window.open("","_self");
		window.close();		 
	}
	
	//�ж�ѡ�����ϯ���ͣ��������ͨ��ϯ����ʾ�绰������һ�ı�����Ϊ�绰��ϯ����ʾ��
	function changeLoginType(ob){
	  var el=document.getElementById("loginPhone");	
	  if(ob.value=="2"){
	  	 el.style.display="none"
	  }else if(ob.value=="4"){
	  	 el.style.display="block";
	  }	
	}	
	//����ע��������õ�ip����ѯ��Ӧ������
	function selectCCS(ccno){
	 var localIp=icdCfgObject.getLocalIp();
	 if(localIp!=null&&localIp!='')
	 {
	   var packet = new AJAXPacket("../../npage/callbosspage/public/selectCCSInfo_hlj.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	   packet.data.add("localIp", localIp);
	   packet.data.add("ccno", ccno);
		 core.ajax.sendPacket(packet,doSelectCCS,true);
	   packet =null;	
	 }
	}
	
		/**
	  *author:mixh
	  *date  :20090803
	  *�������ݿ�����ʱ��������ϯʱ��
	  */
	function setLocalHostTime(){
		icdCfgObject.setLocalTime('<%=oracleHostTime%>');
	}	
	
	function doSelectCCS(packet){
	document.getElementById('mainCCSIp').value=packet.data.findValueByName("mainccsip");
	document.getElementById('CCSId').value=packet.data.findValueByName("ccsid");
	document.getElementById('mainCCSIp2').value=packet.data.findValueByName("mainccsip2");
	document.getElementById('ccno').value=packet.data.findValueByName("ccno");
	document.getElementById('localIp').value=icdCfgObject.getLocalIp();
	var agenttype=packet.data.findValueByName("agenttype");
	var callerno=packet.data.findValueByName("callerno");
	var callinnerflag=packet.data.findValueByName("callinnerflag"); 
	getPasswd(document.getElementById('ccno').value);	
}



// 20090413 by fangyuan ȡ����ϯ����passwd
function getPasswd(ccno){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/getpasswd_hlj.jsp","���ڻ�ȡ������Ϣ,���Ժ�...");
	 packet.data.add("ccno", ccno);
	core.ajax.sendPacket(packet,handleCfg,true);
	packet = null;
}	

function handleCfg(packet){
	var retCode = packet.data.findValueByName("retCode");	
	var passwd = packet.data.findValueByName("passwd");	
	if(retCode=="000000"){
		document.getElementById('passwd').value = passwd;
	}else{
		//rdShowMessageDialog("��ȡ������Ϣʧ��!",0);
		return false;
	}
}
//tancf 20100201
function changeccno(){
var select_cc=document.getElementById("select_cc").value;
selectCCS(select_cc);
}

	</script>	 
</head>

<body>
<form action="/csp/bsf/afterLogin.action" onsubmit="customOnsubmit(); return validateForm_passwordForm();" method="post" id="passwordForm">
 
 
 <iframe src="ssouse.jsp" style="display:none" width="100" height="100"></iframe>
 
  <input type="hidden" id="mainCCSIp" value=""/>
	<input type="hidden" id="mainCCSIp2" value=""/>
	<input type="hidden" id="CCSId" value=""/>
	<input type="hidden" id="localIp" value=""/>
	<input type="hidden" id="ccno" value=""/>
	
	<!--
	<input type="hidden" id="WorkNo" value="102"/>
	-->
	<input type="hidden" id="Password" value="102"/>
		<table width="400" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td height="25" class="basicinfo_bg">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="title_boldtext">
								��������ѡ��
							</td>
							<td width="100%">
								&nbsp;
							</td>
							<td class="basic_arrow">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		    <tr>
		        <td height="2"></td>
		    </tr>
		</table>
			<table width="400" align="center" border="0" cellpadding="0" cellspacing="0" class="table_listoutline" style="display: black;">
				<tr>
				    <td width="100"><span><label id="null_">��¼����</label></span></td>
					<td>
					    <select id="loginTypeSelect" name="agentType"  onchange="changeLoginType(this)" style="width:170px">
						    <option value="2" selected >��ͨ��ϯ</option>
						    <option value="4" >�绰��ϯ</option>
						</select>
					</td>
				</tr>
				<tr id="loginPhone" style="display:none">
				    <td id="teleTitle" width="100"><span><label id="null_">�绰����</label></span></td>
					<td>
					    <input type="text" id="cellphone" name="cellphone" style="width:166px"/>
					</td>
				</tr>
			    <tr>		
				    <td width="100">��¼״̬</td>
					<td>
					    <select id="loginstatus" name="loginStatus" style="width:170px">
						    <option value="1" selected>����̬</option>
						    <%
						    	if("N".equals(isCommonLogin)){
						    %>
						    <!--<option value="9">ѧϰ̬</option>-->
						    <option value="7">ʾæ̬</option>
						    <%
						    	}
						    %>
					    </select>
					</td>
				</tr>

				<tr id="callCenterno" style="display: none;">
					<td width="100">
						�������ı��
					</td>
					<td>
						</span><select name="select_cc" id="select_cc" style="width:170px" onchange="changeccno()"><option value="2">�����ͷ�����</option><option value="1">���ݿͷ�����</option></select>
					</td>
				</tr>

				<tr>
					<td colspan="2" align="center">
						<input type="button" value="ȷ��" name="modify" id="submitBtn" class="button_38px" onClick="customOnsubmit()" onmouseover="this.className='button_38px_over'" onmouseout="this.className='button_38px'"/>
					</td>
				</tr>
			</table>
            <input type="hidden" id="loginIp" name="loginIp" value=""/>
            <input type="hidden" id="passwd" name="passwd" value=""/>
		</form>

</html>
