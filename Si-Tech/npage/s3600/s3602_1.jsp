<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.23
 ģ��: BOSS��VPMN���ű��
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../include/remark.htm" %>



<%
	String opCode  =request.getParameter("opCode");
	String opName  =request.getParameter("opName");
	
	String ipAddress = (String)session.getAttribute("ipAddr");
	String loginNo =  (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String loginPwd  = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String powerRight= (String)session.getAttribute("powerRight");
	
	String sqlStr = null;
	String[] inParams = new String[2];
    String[][] result = new String[][]{};
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<TITLE>BOSS��VPMN�����ײͱ��</TITLE>
</HEAD>
<SCRIPT type=text/javascript>

onload=function()
{
	
}

function ChgCurrStep(currStep)
{
	if (currStep == "custQuery")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = true;
		document.frm.doSubmit.disabled = true;
	}
	else if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.doSubmit.disabled = true;
	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
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
		if(retCode == "000000")
		{
			var retResult = packet.data.findValueByName("retResult");
			if (retResult == "false")
			{
				ChgCurrStep("chkGrpPwd");
				frm.grpPwd.value = "";
				frm.grpPwd.focus();
				rdShowMessageDialog(retMessage);
				return false;
			}
			else
			{
				ChgCurrStep("doSubmit");
				rdShowMessageDialog("�ͻ�����У��ɹ���",2);
			}
		}
		else
		{
			rdShowMessageDialog(retMessage+retCode,0);
			return false;
		}
	}

	if(retType == "getOldRate")
	{
		if(retCode == "000000")
		{
			document.frm.oldMainRate.value = packet.data.findValueByName("oldMainRate");
			var ss = packet.data.findValueByName("oldOptionalRate");
			var i= 0, len=ss.length;
			for (i = 0; i < len; i ++)
			{
				if (ss.charAt(i) == "|")
				{
					document.frm.oldOptionalRate.value = document.frm.oldOptionalRate.value + "\n";
				}
				else
				{
					document.frm.oldOptionalRate.value = document.frm.oldOptionalRate.value + ss.charAt(i);
				}
			}
		}
		else
		{
			document.frm.oldMainRate.value = "";
			document.frm.oldOptionalRate.value = "";
			rdShowMessageDialog(retMessage,0);
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
			showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
			if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1)
			{
				page = "s3602_2.jsp";
				frm.action=page;
				frm.method="post";
				frm.submit();
				document.frm.doSubmit.disabled=true;
			}
			else return false;
		}
		else
		{
			rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��");
			return false;
		}
	}
}

//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
	var pageTitle = "���ſͻ�ѡ��";
	var fieldName = "֤������|���ſͻ�ID|�����û�ID|�����û�����|����ID|���Ų�Ʒ����|��Ա�趨����|��Ա�趨��������|";
	var sqlStr = "";
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "8|0|1|2|3|4|5|6|7|";
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|";
	var custId = document.frm.custId.value;

	if(document.frm.idIccid.value == "" &&
	document.frm.custId.value == "" &&
	document.frm.unitId.value == "" &&
	document.frm.grpOutNo.value == "")
	{
		rdShowMessageDialog("���������֤�š��ͻ�ID������ID�����û���Ž��в�ѯ��",0);
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
	var path = "<%=request.getContextPath()%>/npage/s3600/fpubgrpusr_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&idIccid=" + document.all.idIccid.value;
	path = path + "&custId=" + document.all.custId.value;
	path = path + "&unitId=" + document.all.unitId.value;
	path = path + "&grpOutNo=" + document.all.grpOutNo.value;
	path = path + "&regionCode=" + '<%=regionCode%>';

	retInfo = window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|";
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

function QryOldRate()
{
	document.all.oldOptionalRate.value="";
	var QryOldRate_Packet = new AJAXPacket("getOldRate.jsp","���ڵõ�ԭ������������Ϣ�����Ժ�......");
	QryOldRate_Packet.data.add("retType","getOldRate");
	QryOldRate_Packet.data.add("grpIdNo",document.frm.grpIdNo.value);
	QryOldRate_Packet.data.add("regionCode","<%=regionCode%>");
	core.ajax.sendPacket(QryOldRate_Packet);
	QryOldRate_Packet=null;
}

function check_HidPwd()
{
	var grpIdNo = document.frm.grpIdNo.value;
	var inPwd = document.frm.grpPwd.value;
	var checkPwd_Packet = new AJAXPacket("../s3600/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
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
		var temp="";
		for(i=0;i<document.frm.optionalRate.options.length;i++){
			if (document.frm.optionalRate.options[i].selected==true)
			{
				temp+=document.all.optionalRate.options[i].text+"      ";
			}
		}
		/*var oldtemp="";
		for(i=0;i<document.frm.oldOptionalRate.options.length;i++){
			if (document.frm.oldOptionalRate.options[i].selected==true)
			{
				oldtemp+=document.all.oldOptionalRate.options[i].text+"      ";
			}
		}*/
 		retInfo+='<%=workname%>'+"|";
    	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    	retInfo+="���֤��:"+document.frm.idIccid.value+"|";
    	retInfo+="���ſͻ�ID:"+document.frm.custId.value+"|";
    	retInfo+="�����û����:"+document.frm.grpOutNo.value+"|";
    	retInfo+="�¼���������:"+document.frm.newRate.options[document.frm.newRate.selectedIndex].text+"|";
    	retInfo+="�¼��ſ�ѡ����:"+temp+"|";	  
    	retInfo+="ԭ����������:"+document.frm.oldMainRate.value+"|";
    	retInfo+="ԭ���ſ�ѡ����:"+document.frm.oldOptionalRate.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+="ҵ�����ͣ�BOSS��VPMN�����ײͱ��"+"|";
    	retInfo+="��ˮ��"+document.frm.loginAccept.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.all.opNote.value+" "+document.all.simBell.value+"|";
		 return retInfo;
	 }

//��ʾ��ӡ�Ի���
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=150;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var printStr = printInfo(printType);
	if(printStr == "failed")
	{
		return false;
	}

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
	var ret=window.showModalDialog(path,"",prop);
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
	getAfterPrompt();
	if(  document.frm.grpIdNo.value == "" )
	{
		rdShowMessageDialog("�����û�ID����Ϊ��!!");
		document.frm.idIccid.select();
		return false;
	}
	
	if (document.frm.oldMainRate.value == "")
	{
		rdShowMessageDialog("ԭ���������ʲ���Ϊ�գ����Ȳ�ѯ����������!");
		document.frm.bQryOldRate.focus();
		return false;
	}

	if (document.frm.newRate.value=="")
	{
		rdShowMessageDialog("�·��ʲ���Ϊ��!");
		document.frm.newRate.focus();
		return false;
	}
	getSysAccept()
}

</script>
<BODY>
	<FORM action="" method="post" name="frm" >
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<input type="hidden" name="loginAccept"  value="0"> <!-- ������ˮ�� -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		<input type="hidden" name="opCode"  value="3602">
		<input type="hidden" name="opName"  value="<%=opName%>">
		
		<TABLE cellSpacing="0">
			<TR>
				<TD class="blue">
					<div align="left">���֤��</div>
				</TD>
				<TD>
					<input name="idIccid" id="idIccid" size="24" maxlength="18" v_type="string" v_must=1  index="1" value="">
					<input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor��hand" value=��ѯ>
					<font color="orange">*</font>
				</TD>
				<TD class="blue">���ſͻ�ID</TD>
				<TD>
					<input class="button" type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1 index="2" value="">
					<font color="orange">*</font>
				</TD>
			</TR>
			<TR>
				<TD class="blue">
					<div align="left">����ID</div>
				</TD>
				<TD>
					<input name=unitId id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1  index="3" value="">
					<font color="orange">*</font>
				</TD>
				<TD class="blue">�����û����</TD>
				<TD>
					<input class="button" name="grpOutNo" size="20" v_must=1 v_type=string  index="4" value="">
					<font color="orange">*</font>
				</TD>
			</TR>
			<TR>
				<TD class="blue">�����û�ID</TD>
				<TD COLSPAN="1">
					<input class="InputGrey" name="grpIdNo" size="20" readonly v_must=1 v_type=string  index="4" value="">
					<font color="orange">*</font>
				</TD>
				<TD class="blue">���ſͻ�����</TD>
				<TD colspan="1">
					<jsp:include page="/npage/common/pwd_1.jsp">
					<jsp:param name="width1" value="16%"  />
					<jsp:param name="width2" value="34%"  />
					<jsp:param name="pname" value="grpPwd"  />
					<jsp:param name="pwd" value=""  />
					</jsp:include>
					<input name=chkGrpPwd type=button onClick="check_HidPwd();" class="b_text" style="cursor��hand" id="chkGrpPwd" value=У��>
					<font color="orange">*</font>
				</TD>
			</TR>
			<TR>
				<TD class="blue">ԭ����������</TD>
				<TD>
					<input name="oldMainRate" class="InputGrey" type="text" size="35" v_must=1 v_type="string" index="8" value="" readonly>
					<input name=bQryOldRate type=button id="bQryOldRate" class="b_text" onMouseUp="QryOldRate();" onKeyUp="if(event.keyCode==13)QryOldRate();" style="cursor��hand" value=��ѯ>
					<font color="orange">*</font>
				</TD>
				<TD class="blue">ԭ���ſ�ѡ����</TD>
				<TD>
					<textarea name="oldOptionalRate" class="button" v_must=0 rows="5" cols="40" v_type="string"  index="8" value="" readonly></textarea>
					<font color="orange">*</font>
				</TD>
			<TR>
				<TD class="blue">����������</TD>
				<TD>
					<select name="newRate" id="newRate" v_must=1 v_type="string" index="10">
<%
					try
					{
						sqlStr = "select mode_code,mode_code||'->'|| mode_name"
						        +"  from sBillModeCode"
								+" where region_code = substr('" +orgCode+"',1,2)"
								+"   and mode_type = 'VpM0' "
								+" and stop_time>=sysdate and power_Right<="+powerRight+"";
						inParams[0] = "select mode_code,mode_code||'->'|| mode_name"
						        +"  from sBillModeCode"
								+" where region_code =:regionCode"
								+"   and mode_type = 'VpM0' "
								+" and stop_time>=sysdate and power_Right<=:powerRight";
						inParams[1] = "regionCode="+regionCode+",powerRight="+powerRight;
		                //retArray = callView.sPubSelect("2",sqlStr);
%>
						<wtc:service name="TlsPubSelCrm" routerKey="regCode" routerValue="<%=regionCode%>" outnum="2">			
						<wtc:param value="<%=inParams[0]%>"/>	
						<wtc:param value="<%=inParams[1]%>"/>	
						</wtc:service>	
						<wtc:array id="resultTemp1"  scope="end"/>
<%		                
			            result = resultTemp1;
					}
					catch(Exception e){
						System.out.println("ȡ������������Ϣ����!");
					}
					if (result.length>0)
					{
						System.out.println("result.length"+result.length);
						for(int i=0; i < result.length; i ++)
						{
							out.println("<option value='" + result[i][0] + "'>" + result[i][1] + "</option>");
						}
					}
%>
					</select>
					<font color="orange">*</font>
				</TD>
				<TD class="blue">���ſ�ѡ����</TD>
				<TD>
					<select name="optionalRate" id="optionalRate" size="5" MULTIPLE="TRUE" v_must=0 v_type="string" index="10">
<%
					try
					{
						sqlStr = "select mode_code,mode_name"
						        +"  from sBillModeCode"
								+" where region_code = substr('" +orgCode+"',1,2)"
								+"   and mode_type = 'VpA0'"
								+" and stop_time>=sysdate and power_Right<="+powerRight+"";
						inParams[0] = "select mode_code,mode_name"
						        +"  from sBillModeCode"
								+" where region_code =:regionCode"
								+"   and mode_type = 'VpA0'"
								+" and stop_time>=sysdate and power_Right<=:powerRight";
						inParams[1] = "regionCode="+regionCode+",powerRight="+powerRight;
		                //retArray = callView.sPubSelect("2",sqlStr);
%>
						<wtc:service name="TlsPubSelCrm" routerKey="regCode" routerValue="<%=regionCode%>" outnum="2">			
						<wtc:param value="<%=inParams[0]%>"/>	
						<wtc:param value="<%=inParams[1]%>"/>	
						</wtc:service>	
						<wtc:array id="resultTemp2"  scope="end"/>
<%		                
			            result = resultTemp2;
					}
					catch(Exception e){
						System.out.println("ȡ���ſ�ѡ������Ϣ����!");
					}
					if (result.length>0)
					{
						System.out.println("result.length"+result.length);
						for(int i=0; i < result.length; i ++)
						{
							out.println("<option value='" + result[i][0] + "'>" + result[i][0] + "--" + result[i][1] + "</option>");
						}
					}
%>
					</select>
				</TD>
			</tr>
			<TR>
				<TD class="blue">��ע</TD>
				<TD colspan="3">
					<input class="InputGrey" name="sysNote" size="60" value="BOSS��VPMN�����ײͱ��" readonly>
				</TD>
			</TR>
			<TR  style="display:none">
				<TD class="blue">�û���ע</TD>
				<TD colspan="3">
					<input class="InputGrey" name="opNote" size="60" value="BOSS��VPMN�����ײͱ��" readOnly>
				</TD>
			</TR>
		</TABLE>
		<TABLE cellSpacing="0">
			<TR>
				<TD id="footer">
					<input class="b_foot" name="doSubmit"  type=button value="ȷ��" onclick="refMain()">
					<input class="b_foot" name="reset1"  onClick="" type=reset value="���">
					<input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�">
				</TD>
			</TR>
		</TABLE>
		<%@ include file="/npage/include/footer.jsp" %>   			
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
	</FORM>
<script language="JavaScript">
	document.frm.idIccid.focus();
	ChgCurrStep("custQuery");
</script>
</BODY>
</HTML>
