<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-07 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode = WtcUtil.repNull(request.getParameter("opCode"))==""?"2897":WtcUtil.repNull(request.getParameter("opCode"));	
		String opName = WtcUtil.repNull(request.getParameter("opName"))==""?"�ڰ���������":WtcUtil.repNull(request.getParameter("opName"));
		
		String ipAddress = (String)session.getAttribute("ipAddr");
		String loginNo = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String loginPwd  = (String)session.getAttribute("password");
		String Department = (String)session.getAttribute("orgCode");
		String regionCode = Department.substring(0,2);
		String districtCode = Department.substring(2,4);
		String strDate=new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		System.out.println(")))))))))))))))))))))))))))))0="+strDate);
%>
<HTML>
<HEAD>
	<TITLE>�ڰ���������</TITLE>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<SCRIPT type=text/javascript>
	
function OpCodeChange()
{
	if (document.frm.opCode.value == "2898")
	{
		document.frm.sysNote.value="���������";
		document.frm.opNote.value="���������";
	}
	else if (document.frm.opCode.value == "2899")
	{
		document.frm.sysNote.value="������ɾ��";
		document.frm.opNote.value="������ɾ��";
	}
	else if (document.frm.opCode.value == "2900")
	{
		document.frm.sysNote.value="���������";
		document.frm.opNote.value="���������";
	}
	else if (document.frm.opCode.value == "2901")
	{
		document.frm.sysNote.value="������ɾ��";
		document.frm.opNote.value="������ɾ��";
	}
	ChgCurrStep("custQuery");
	beforePrompt(document.frm.opCode.value);
}
function beforePrompt(op_code){
	var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,op_code);
	core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
	packet =null;
}
function doGetBeforePrompt(data)
{
	$('#wait').hide();
	$('#beforePrompt').html(data);
}
function getAfterPrompt(op_code)
{
	var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,op_code);
    core.ajax.sendPacket(packet,doGetAfterPrompt,false);//ͬ��
	packet =null;
}

function doGetAfterPrompt(packet)
{
	var retCode = packet.data.findValueByName("retCode"); 
	var retMsg = packet.data.findValueByName("retMsg"); 
	if(retCode=="000000"){
		promtFrame(retMsg);
	}
}
function ChgCurrStep(currStep)
{
	if (currStep == "custQuery")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = true;
	}
	else if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
	}
	else if (currStep == "qryPhone")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
	}
	else if (currStep == "chkUserPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
	}
}

function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	self.status="";
	if(retType == "checkPwd") //���ſͻ�����У
	{
		if(retCode == 0)
		{
			var retResult = packet.data.findValueByName("retResult");
			if (retResult == "false")
			{
				ChgCurrStep("chkGrpPwd");
				frm.grpPwd.value = "";
				frm.grpPwd.focus();
				rdShowMessageDialog(retMessage);
				return false;
			}else{
				ChgCurrStep("qryPhone");
				rdShowMessageDialog("�ͻ�����У��ɹ���",2);
				document.all.doSubmit.disabled=false;
			}
		}else{
			rdShowMessageDialog(retMessage+retCode);
			return false;
		}
	}

	//ȡ��ˮ
	if(retType == "getSysAccept")
	{
		if(retCode == "000000")
		{
			var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.loginAccept.value=sysAccept;

		}else{
			rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��");
			return false;
		}
	}
}


//���ù������棬���м��ſͻ�ѡ��
function 	getInfo_Cust()
{
	var pageTitle = "���ſͻ�ѡ��";
	var fieldName = "֤������|���ſͻ�ID|���ű��|��������|�����û�����|��Ʒ����|��Ʒ����|��Ʒ����|aa|aa|";
	var sqlStr = "";
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "8|0|1|2|3|4|5|6|7|";
	var retToField = "idIccid|custId|unitId|grpName|grpOutNo|grpIdNo|smName|aa|aa|";
	var custId = document.frm.custId.value;

	if(document.frm.idIccid.value == "" &&
	document.frm.custId.value == "" &&
	document.frm.unitId.value == "" &&
	document.frm.grpOutNo.value == "")
	{
		rdShowMessageDialog("������֤�����롢���ſͻ��ͻ�ID�����ű�Ż����û���Ž��в�ѯ��",0);
		document.frm.idIccid.focus();
		return false;
	}

	if(document.frm.custId.value != "" && forNonNegInt(frm.custId) == false)
	{
		frm.custId.value = "";
		rdShowMessageDialog("���������֣�",0);
		return false;
	}

	if(document.frm.unitId.value != "" && forNonNegInt(frm.unitId) == false)
	{
		frm.unitId.value = "";
		rdShowMessageDialog("���������֣�",0);
		return false;
	}

	if(document.frm.grpOutNo.value == "0")
	{
		frm.grpOutNo.value = "";
		rdShowMessageDialog("�����û���Ų���Ϊ0��",0);
		return false;
	}

	PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "<%=request.getContextPath()%>/npage/s2897/fpubgrpusr_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&idIccid=" + document.all.idIccid.value;
	path = path + "&custId=" + document.all.custId.value;
	path = path + "&unitId=" + document.all.unitId.value;
	path = path + "&grpOutNo=" + document.all.grpOutNo.value
	path = path + "&pageOpCode=<%=opCode%>&pageOpName=<%=opName%>";

	retInfo = window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
	var retToField = "idIccid|custId|unitId|grpName|grpOutNo|grpIdNo|smName|";
	if(retInfo ==undefined)      
	{
		ChgCurrStep("custQuery");
		return false;
	}
	
	var chPos_field = retToField.indexOf("|");
	var chPos_retStr;
	var valueStr;
	var obj;
	while(chPos_field > -1)
	{
		obj = retToField.substring(0,chPos_field);
		chPos_retInfo = retInfo.indexOf("|");
		valueStr = retInfo.substring(0,chPos_retInfo);
		document.all(obj).value = valueStr;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");
	}
	ChgCurrStep("chkGrpPwd");
}

function check_HidPwd()
{
	var grpIdNo = document.frm.grpIdNo.value;
	var inPwd = document.frm.grpPwd.value;
	var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("GRP_ID",grpIdNo);
	checkPwd_Packet.data.add("inPwd",inPwd);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

//��ӡ��Ϣ
function printInfo(printType)
{ 
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		var tmpOpCode=document.all.opCode.value;
		if (tmpOpCode=="2898" || tmpOpCode=="2899"|| tmpOpCode=="2900"|| tmpOpCode=="2901")
		{
    		cust_info+="֤�����룺"+document.frm.idIccid.value+"|";
    		cust_info+="�ͻ�������"+document.frm.grpName.value+"|";
    		cust_info+="���ſͻ����룺"+document.frm.grpOutNo.value+"|";

	    	opr_info+="ҵ�����ͣ�"+document.frm.opCode.options[document.frm.opCode.selectedIndex].text+"|";
	    	opr_info+="��ˮ��"+document.frm.loginAccept.value+"|";
			
			note_info1="��ע��"+"|";
	    	note_info1+=document.frm.sysNote.value+"|";
	    	note_info1+=document.all.simBell.value+"|";
	    	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	    	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		 	return retInfo;
	 }
}

//��ʾ��ӡ�Ի���
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="print";   
	var billType="1";  
	var sysAccept = document.frm.loginAccept.value;
	var printStr = printInfo(printType);
	var opCode = document.all.opCode.value;
	if(printStr == "failed")
	{
		return false;
	}
	var mode_code=null;
	var fav_code=null;
	var area_code=null
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=xxxx&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
}


	//ѡ��¼�뷽ʽ
function inputByNo(){
	if(document.frm.byNo.checked == true){
    window.document.frm.byFile.checked = false;
	}
	document.all.tableNo.style.display="";
	document.all.tableFile.style.display="none"; 
}
function inputByFile(){
	if(document.frm.byFile.checked == true){
    window.document.frm.byNo.checked = false;
	}
	document.all.tableNo.style.display="none";
	document.all.tableFile.style.display=""; 
}

//ȡ��ˮ
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet=null;
}

function refMain()
{
	var op_code=document.frm.opCode.value;
    getAfterPrompt(op_code);//add by qidp
	var nowDate= "<%=strDate%>";
	var expect_time=document.frm.expect_time.value;
	//add by rendi for���Ӷ�txt�ļ����жϣ��Ա����̨����core
	var uploadfile = document.all.PosFile.value;
	var ext = "*.txt";
	var file_name = uploadfile.substr(uploadfile.lastIndexOf(".")); 
	if(ext.indexOf("*"+file_name)==-1)   
    {   
    rdShowMessageDialog("����ֻ֧��txt��ʽ�ļ�(*.txt)��");  
    return;  
    }    
	if(parseInt(expect_time)<parseInt(nowDate))
	{
		rdShowMessageDialog("�������ڲ���С�ڵ�ǰ���ڣ�");
		return;
	}
	
	if (document.frm.byNo.checked==true)
	{
		document.frm.opType.value="no";
	}
	else
	{
		document.frm.opType.value="file";
	}
	
	if(  document.frm.grpIdNo.value == "" )
	{
		rdShowMessageDialog("��Ʒ���벻��Ϊ��!!");
		document.frm.idIccid.select();
		return false;
	}
	if( frm.all.byNo.checked==true && document.frm.phoneNo.value == "" )
	{
		rdShowMessageDialog("���������");
		document.frm.phoneNo.focus();
		return false;
	}
	
		if (!forDate(document.all.expect_time))
	{
		document.all.expect_time.focus();
		return false;
	}
	
	if (document.frm.expect_time.value == "" )
	{
		rdShowMessageDialog("������������Ч����!");
		document.all.expect_time.focus();
		return false;
	}

	getSysAccept();
	showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
	if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1)
	{
		page = "s2897_2.jsp?opType="+document.frm.opType.value;
		frm.action=page;
		frm.method="post";
		frm.submit();
	}
	else{ 
		return false;
	}
}
</script>

</HEAD>
<BODY>
	<FORM action="" method="post" name="frm" ENCTYPE="multipart/form-data">
		<input type="hidden" name="loginAccept"  value="0"> <!-- ������ˮ�� -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="smName"  value="">
		<input type="hidden" name="grpName"  value="">
		<input type="hidden" name="opType"  value="124">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		<input type=hidden name=simBell value="   �ֻ�������ѡ�ײ��Żݵ�GPRS������ָCMWAP�ڵ����������.  �������أ�1.��������꿨,�ͼ�ֵ88Ԫ������ء�  2.��½������ɣ�wap.hljmonternet.com��ʹ���ֻ�����������ͼ�����ء�������Ѷ�����������������������������ʱ������,������Ϣ�ѣ�����1860��ͨGPRS ��">
		<input type=hidden name=worldSimBell value="    �������ҵ��󣬼���Ϊ�ҹ�˾ȫ��ͨǩԼ�ͻ�����ǩԼ������ʹ���ҹ�˾ҵ�񼰲�Ʒ��ͬʱִ���µ����������ߡ������ɵ�Ԥ�����������������������ϣ�ͬʱ�������Ļ����ڻ���ʹ�����޺󷽿�ʹ�á�       ��Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�       ��Ϊȫ��ͨ�ͻ������������ҹ�˾Ϊ���ṩ��������">
		<input type="hidden" name="pageOpCode" value="<%=opCode%>">
		<input type="hidden" name="pageOpName" value="<%=opName%>">
					<%@ include file="/npage/include/header.jsp" %>
						<div class="title">
						    <div id="title_zi">��ѡ���������</div>
						</div>
						<TABLE cellSpacing="0">
							<tr>
								<TD width=12% class="blue">
									<div align="left">��������</div>
								</TD>
								<TD width="32%" colspan="3">
									<SELECT name="opCode" id="opCode" onChange="OpCodeChange()">
										<option value="2898">��������� </option>
										<option value="2899">������ɾ�� </option>
										<option value="2900">��������� </option>
										<option value="2901">������ɾ�� </option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
							</TR>
							<tr>
								<TD width=12% class="blue">
									<div align="left">֤������</div>
								</TD>
								<TD width="32%">
									<input name="idIccid" id="idIccid" size="24" maxlength="18" v_type="string" v_must=1 index="1" value="">
									<input name=custQuery type=button class="b_text" id="custQuery" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor��hand" value=��ѯ>
									<font class="orange">*</font>
								</TD>
								<TD class="blue">���ſͻ�ID</TD>
								<TD width="32%">
									<input type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1 index="2" value="" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
									<font class="orange">*</font>
								</TD>
							</TR>
							<tr>
								<TD width=12% class="blue">
									<div align="left">���ű��</div>
								</TD>
								<TD>
									<input name=unitId id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1 index="3" value="" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">�����û����</TD>
								<TD>
									<input name="grpOutNo" size="20" v_must=1 v_type=string index="4" value="" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
									<font class="orange">*</font>
								</TD>
							</TR>
							<tr>
								<TD class="blue">��Ʒ����</TD>
								<TD COLSPAN="1">
									<input name="grpIdNo" size="20" readonly v_must=1 v_type=string index="4" value="">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">���ſͻ�����</TD>
								<TD colspan="1">
									<jsp:include page="/npage/common/pwd_1.jsp">
									<jsp:param name="width1" value="16%"  />
									<jsp:param name="width2" value="34%"  />
									<jsp:param name="pname" value="grpPwd"  />
									<jsp:param name="pwd" value=""  />
									</jsp:include>
									<input name=chkGrpPwd type=button class="b_text" onClick="check_HidPwd();" style="cursor��hand" id="chkGrpPwd" value=У��>
									<font class="orange">*</font>
								</TD>
							</TR>
							<Tr> 
            		<TD width="12%" class="blue"> 
									<div align="left">���ӷ�ʽ</div>
								</TD>
            		<TD colspan="3"> 
									<input name="byNo" onClick="inputByNo()" type="radio" value="no" checked index="2">
									������
									<input name="byFile" onClick="inputByFile()"  type="radio"  value="file" index="3">
									���ļ�
								</TD>
          		</TR>
							<TR id="tableNo">
								<TD class="blue">����</TD>
								<TD colspan="1">
									<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string" v_name="�ֻ�����" index="8"></textarea>
								</TD>
								<TD colspan="2">
									ע���������Ӻ���ʱ,����"|"��Ϊ�ָ���,�������һ������Ҳ����"|"��Ϊ����.
									<br>���磺
									<br>&nbsp;&nbsp;&nbsp;&nbsp;20200000000|
									<br>&nbsp;&nbsp;&nbsp;&nbsp;20200654321|
								</TD>
							</TR>			
							<TR id="tableFile" style=display:none>
								<TD align="left" width=12% class="blue">¼���ļ�</TD>	   
        				<TD> 
          				<input type="file" name="PosFile">
        				</TD>
								<TD colspan="2">�ļ�˵��:һ������һ��</TD>
							</TR>

	         
	          <TR id="expect_time_txt"> 
						<TD width=12% class="blue"> ��������</TD>
	            <TD width=20% colspan="3">
	              	<input type="text"  name="expect_time" v_format="yyyyMMdd" maxlength="8" value="" v_type="date" v_must="1" size="9" >
	              	<font class="orange">*</font>&nbsp;(��ʽ:YYYYMMDD)&nbsp;            	
	            </TD> 					            	              
	         </TR>
							<tr>
								<TD class="blue">ϵͳ��ע</TD>
								<TD colspan="3">
									<input name="sysNote" size="60" value="�ڰ���������" readonly >
								</TD>
							</TR>
							<tr style="display:none">
								<TD class="blue">�û���ע</TD>
								<TD colspan="3">
									<input name="opNote" size="60" value="�ڰ���������" >
								</TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing="0">
							<tr>
								<TD align=center id="footer">
									<input class="b_foot" name="doSubmit" type=button value="ȷ��" onclick="refMain()" disabled >
									<input class="b_foot" name="reset1"  onClick="" type=reset value="���" >
									<input class="b_foot" name="kkkk"  onClick="removeCurrentTab();" type=button value="�ر�" >
								</TD>
							</TR>
						</TABLE>
			        <div id="relationArea" style="display:none"></div>
						<div id="wait" style="display:none">
						<img  src="/nresources/default/images/blue-loading.gif" />
					</div>
					<div id="beforePrompt"></div>   						
					<%@ include file="/npage/include/footer_simple.jsp" %>
					<jsp:include page="/npage/common/pwd_comm.jsp"/>
				</FORM>
		<script language="JavaScript">
			document.frm.idIccid.focus();
			ChgCurrStep("custQuery");
			OpCodeChange();
		</script>
</BODY>
</HTML>


