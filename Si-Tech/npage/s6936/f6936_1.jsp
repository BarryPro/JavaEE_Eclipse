<%
  /* *********************
   * ����:�ֻ����ӹ���ϵͳ
   * �汾: 1.0
   * ����: 2009/7/30
   * ����: fengry
   * ��Ȩ: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>�ֻ����ӹ���ϵͳ</title>
<%
	//String opCode = "6940";
 	//String opName = "�ֻ�����ҵ�񶩹�";
	String work_no = (String) session.getAttribute("workNo");
	String org_code = (String) session.getAttribute("orgCode");
	String loginName = (String) session.getAttribute("workName");
	//String regionCode = org_code.substring(0,2);  
	String printAccept="";
	printAccept = getMaxAccept();
	//int srvStrIndex = 0;
	activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
	String srv_no = WtcUtil.repNull(request.getParameter("srv_no"));
	String op_Code = WtcUtil.repNull(request.getParameter("opcode"));
	String op_Name = WtcUtil.repNull(request.getParameter("opName"));
	String querytype = WtcUtil.repNull(request.getParameter("querytype"));
	
	String opCode = op_Code;
 	String opName = op_Name;	
	System.out.println("srv_no==="+srv_no+"op_code==="+op_Code);
%>

<wtc:service name="s6936Init" routerKey="phone" routerValue="<%=srv_no%>" retCode="initRetCode" retMsg="initRetMsg" outnum="11">
	<wtc:param value="<%=srv_no%>"/>
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=org_code%>"/>
	<wtc:param value="<%=op_Code%>"/>
</wtc:service>
<wtc:array id="initStr" scope="end"/>
<%
	System.out.println("initRetCode==="+initRetCode);
	System.out.println("initRetMsg==="+initRetMsg);
	if (!(initRetCode.equals("000000")))
	{
%>
		<script language=javascript>
			rdShowMessageDialog("<%=initRetMsg%>");
			window.location="f6936_login.jsp?opCode=<%=op_Code%>&opName=<%=op_Name%>&activePhone=<%=srv_no%>";
		</script>
<%
		return;
	}
	
	if((initStr==null) || (initStr.length==0))
	{
%>
		<script language=javascript>
			rdShowMessageDialog("<%=initStr[0][1]%>");
		</script>	
<%			
		return;
	}
%>

<%
  String sqlSpidCode = "SELECT spid, spname FROM ddsmpspinfo WHERE biztype = '53'";
  System.out.println("sqlSpidCode==="+sqlSpidCode);
%>
<wtc:pubselect name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" retcode="SpidRetCode" retmsg="SpidRetMsg" outnum="2">
	<wtc:sql><%=sqlSpidCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="SpidStr" scope="end" />
<%
	if(SpidRetCode.equals("0") || SpidRetCode.equals("000000"))
	{
		System.out.println("���÷���sPubSelect in f6936_1.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");	        	
	}
	else
	{
		System.out.println("���÷���sPubSelect in f6936_1.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
		<script language="JavaScript">
		rdShowMessageDialog("�������ʧ�ܣ�");
		history.go(-1);
		</script>
<%}%>


<script language=javascript>
onload=function()
{
	if(document.all.opCode.value == "6937")
	{
		document.all.id6937.style.display="none";
		document.all.id6940.style.display="none";
		document.all.other.style.display="none";
	}/* by lichaoa 20100824
	else if(document.all.opCode.value == "6940")
	{
		document.all.id6937.style.display="none";
		document.all.id6940.style.display="";
		document.all.other.style.display="none";
	}*/
	else
	{
		document.all.id6937.style.display="none";
		document.all.id6940.style.display="none";
		document.all.other.style.display="";
	}
}
function printprint()
{
	/*if(document.all.sInBizCode0.value == "" && document.all.sInBizCode2.value != "")
	{
		document.all.sInBizCode.value = document.all.sInBizCode2.value ;
	}
	else if(document.all.sInBizCode0.value != "" && document.all.sInBizCode2.value == "")
	{
		document.all.sInBizCode.value = document.all.sInBizCode0.value ;
	}
	else if(document.all.sInBizCode0.value == "" && document.all.sInBizCode2.value == "")
	{
		document.all.sInBizCode.value = "0000000000000000" ;
	}*/
	if(document.all.opCode.value == "6937")
	{
		document.all.sInBizCode.value = "";
	}
	/* by lichaoa 20100824
	else if(document.all.opCode.value == "6940")
	{
		document.all.sInBizCode.value = "0000000000000000" ;
	}*/
	else
	{
		document.all.sInBizCode.value = document.all.sInBizCode2.value ;
	}
	
	

	if(document.frm1.sInSpid.value=="")
	{
		rdShowMessageDialog("��ѡ����ҵ���룡");
		document.frm1.sInSpid.focus();
		return false;
	}
	if(document.all.opCode.value != "6937" /*&& document.all.opCode.value != "6940"*/)
	{
		if(document.all.sInBizCode.value=="")
		{
			rdShowMessageDialog("��ѡ��ҵ����룡");
			document.all.sInBizCode2.focus();
			return false;
		}
	}
	printCommit();	
}
function printCommit()
{
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			{
				doCfm();
			}
		}
		if(ret=="continueSub")
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			{
				doCfm();
			}
		}
	}
	else
	{
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		{
			doCfm();
		}
	}
}

function spidchg()
{
	if(document.all.sInSpid.value != "")
	{
		/************20100823 lichaoa �ֻ�����ϵͳ�����Ż�����**********
		***BOSS��ҵ�񶩹�������������ҵ��Ŀ�ͨ/ȡ��/��ͣ/�ָ�����*****/
		var sql = "SELECT bizcode, servname FROM ddsmpspbizinfo WHERE spid = :spid and bizcode <> '0000000000000000'";
		var sqlParam = "spid="+document.all.sInSpid.value;
		var rpc_flag = "1";
		sendRpc(sql,sqlParam,rpc_flag);
	}
}

function sendRpc(sql,sqlparam,rpc_flag)
{
	var myPacket = new AJAXPacket("rpc_select.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
	myPacket.data.add("sql",sql);
	myPacket.data.add("sqlParam",sqlparam);
	myPacket.data.add("rpc_flag", rpc_flag);
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

function doProcess(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var rpc_flag = packet.data.findValueByName("rpc_flag");
	self.status="";
	
	if(retCode != "000000")
	{
		rdShowMessageDialog(retMsg);
		return;
	}
	if(rpc_flag == "1")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelectAdd(document.all.sInBizCode2,code,text);
	}
}

function fillSelectAdd(obj,code,text)
{
	obj.length=0;
	var option1 = new Option("--��ѡ��--","");
	obj.add(option1);
	for(var i=0; i<code.length; i++)
	{
		var option2 = new Option(code[i]+"-->"+text[i],code[i]);
		obj.add(option2);
	}
}

function doCfm()
{	
	frm1.submit();
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var printStr = printInfo(printType);
   
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept=<%=printAccept%>&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{
   var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
  
	 var retInfo = "";
	 
	cust_info+="�ֻ����룺   "+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������   "+document.all.custName.value+"|";
	cust_info+="�ͻ���ַ��	 "+document.all.custAdress.value+"|";
	cust_info+="֤�����룺	 "+document.all.idIccid.value+"|";
	
	opr_info+="������ˮ: <%=printAccept%>"+"|";
	opr_info+="��������: "+document.all.opName.value+"|";
	note_info1+="��ע��"+document.all.opName.value+"|";
  	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}


function FixWidth(selectObj)
{
	/* ��� ningtn */
	if (navigator.userAgent.toLowerCase().indexOf("firefox") > 0) {
		return;
	}

	var newSelectObj = document.createElement("select");
	newSelectObj = selectObj.cloneNode(true);
	newSelectObj.selectedIndex = selectObj.selectedIndex;
	newSelectObj.id="newSelectObj";
  
	var e = selectObj;
	var absTop = e.offsetTop;
	var absLeft = e.offsetLeft;
	while(e = e.offsetParent)
	{
	    absTop += e.offsetTop;
	    absLeft += e.offsetLeft;
	}
	with (newSelectObj.style)
	{
	    position = "absolute";
	    top = absTop + "px";
	    left = absLeft + "px";
	    width = "auto";
	}
   
	var rollback = function(){ RollbackWidth(selectObj, newSelectObj); };
	if(window.addEventListener)
	{
	    newSelectObj.addEventListener("blur", rollback, false);
	    newSelectObj.addEventListener("change", rollback, false);
	}
	else
	{
	    newSelectObj.attachEvent("onblur", rollback);
	    newSelectObj.attachEvent("onchange", rollback);
	}
	
	selectObj.style.visibility = "hidden";
	document.body.appendChild(newSelectObj);
	
	var newDiv = document.createElement("div");
	with (newDiv.style)
	{
	    position = "absolute";
	    top = (absTop-10) + "px";
	    left = (absLeft-10) + "px";
	    width = newSelectObj.offsetWidth+20;
	    height= newSelectObj.offsetHeight+20;;
	    background = "transparent";
	    //background = "green";
	}
	document.body.appendChild(newDiv);
	newSelectObj.focus();
	var enterSel="false";
	var enter = function(){enterSel=enterSelect();};
	newSelectObj.onmouseover = enter;
	
	var leavDiv="false";
	var leave = function(){leavDiv=leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel);};
	newDiv.onmouseleave = leave;
}

function RollbackWidth(selectObj, newSelectObj)
{
    selectObj.selectedIndex = newSelectObj.selectedIndex;
    selectObj.style.visibility = "visible";
    if(document.getElementById("newSelectObj") != null){
       document.body.removeChild(newSelectObj);
    }
}

function removeNewDiv(newDiv)
{
	document.body.removeChild(newDiv);
}

function enterSelect(){
	return "true";
}

function leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel){
	if(enterSel == "true" ){
		RollbackWidth(selectObj, newSelectObj);
		removeNewDiv(newDiv);
	}
}
</script>
</head>

<body>
<form name="frm1" method="POST" action="f6936Cfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">�û���Ϣ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="15%" nowrap>�ֻ�����</td>
			<td nowrap colspan="2" width="35%"><%=srv_no%></td>
			<td class="blue" width="15%" nowrap>�û�ID</td>
			<td nowrap colspan="2"><%=initStr[0][2]%></td>
		</tr>
		<tr>
			<td class="blue" width="15%" nowrap>�ͻ�����</td>
			<td nowrap colspan="2" width="35%"><%=initStr[0][3]%></td>
			<td class="blue" width="15%" nowrap>�ͻ���ַ</td>
			<td nowrap colspan="2"><%=initStr[0][4]%></td>
		</tr>
		<tr>
			<td class="blue" width="15%" nowrap>��ǰ״̬</td>
			<td nowrap colspan="2" width="35%"><%=initStr[0][5]%></td>
			<td nowrap class="blue" width="15%">ҵ��Ʒ��</td>
			<td nowrap colspan="2"><%=initStr[0][6]%></td>
		</tr>
		<tr>
			<td class="blue" width="15%" nowrap>֤������</td>
			<td nowrap colspan="2" width="35%"><%=initStr[0][8]%></td>
			<td class="blue" width="15%" nowrap>֤������</td>
			<td nowrap colspan="2"><%=initStr[0][7]%></td>
		</tr>
		<tr>
			<td class="blue" width="15%" nowrap>��ǰǷ��</td>
			<td nowrap colspan="2" width="35%"><%=initStr[0][9]%></td>
			<td class="blue" width="15%" nowrap>��ǰԤ��</td>
			<td nowrap colspan="2"><%=initStr[0][10]%></td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="15%" nowrap>��ҵ����</td>
			<td nowrap colspan="2" width="85%">
				<select class="button" type="select" name="sInSpid" onchange="spidchg();">
					<option value="">--��ѡ��--</option>
					<%for(int i=0; i<SpidStr.length; i++){%>
						<option value="<%=SpidStr[i][0]%>"> <%=SpidStr[i][0]%>--><%=SpidStr[i][1]%> </option>
					<%}%>
				</select>
				<font class="orange">*</font>	
			</td>
		</tr>

		<tr id="id6937">
			<td class="blue" width="15%" nowrap>ҵ�����</td>
			<td nowrap colspan="5" width="85%">
				<select class="button" type="select" name="sInBizCode0" onmouseover="FixWidth(this)">
					<option value="">--��ѡ��--</option>
				</select>
				<font class="orange">*</font>	
			</td>
		</tr>
		<tr id="id6940">
			<td class="blue" width="15%" nowrap>ҵ�����</td>
			<td nowrap colspan="5" width="85%">
				<select class="button" type="select" name="sInBizCode1" onmouseover="FixWidth(this)">
					<option value="">0000000000000000-->�����ײ�</option>
				</select>
				<font class="orange">*</font>	
			</td>
		</tr>
		<tr id="other">
			<td class="blue" width="15%" nowrap>ҵ�����</td>
			<td nowrap colspan="5" width="85%">
				<select class="button" type="select" name="sInBizCode2" onmouseover="FixWidth(this)">
					<option value="">--��ѡ��--</option>
				</select>
				<font class="orange">*</font>
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td colspan="6" id="footer">
				<input class="b_foot" type="button" name="b_print" value="ȷ��&��ӡ" onClick="printprint();">&nbsp;
				<input class="b_foot" type="button" name="b_clear" value="����" onClick="history.go(-1);">
			</td>
		</tr>
	</table>

<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >
<input type="hidden" name="phoneNo" value="<%=srv_no%>" >
<input type="hidden" name="printAccept" value="<%=printAccept%>">
<input type="hidden" name="custName" value="<%=initStr[0][3]%>" >
<input type="hidden" name="custAdress" value="<%=initStr[0][4]%>" >
<input type="hidden" name="idIccid" value="<%=initStr[0][7]%>" >
<input type="hidden" name="sInBizCode" value="" >
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
