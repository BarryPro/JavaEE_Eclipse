 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-16 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ include file="../../include/remark.htm" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	//baixf modify 20080901 ���Ų�Ʒ��� �޸�Ϊ ���Ų�Ʒ����	
	String opCode = request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");	
	
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);	
	String loginNo = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");	
	String loginPwd  = (String)session.getAttribute("password");
	String Department = baseInfo[0][16];	
	String regionCode = (String)session.getAttribute("regCode");	
	String ipAddress = (String)session.getAttribute("ipAddr");
%>
<HTML>
	<HEAD>
		<TITLE>���ų�Ա����</TITLE>
	</HEAD>
	
	<SCRIPT type=text/javascript>
		//core.loadUnit("debug");
		//core.loadUnit("rpccore");
		onload=function()
		{
			//core.rpc.onreceive = doProcess;
		}

		function OpCodeChange()
		{
			if (document.frm.opCode.value == "3709")			{
				document.frm.sysNote.value="���Ų�Ʒ��Ա����";
				document.frm.opNote.value="���Ų�Ʒ��Ա����";
				if(document.all.grpIdNo.value!="")
					if(getbizcode(document.all.grpIdNo.value,document.all.regionCode.value));
				if(document.all.smCode.value=="hy")
				{
					document.all.payflag_div_3.style.display="";
					document.all.addmodeflag.value="3";
				}
				
			}
			else if (document.frm.opCode.value == "3704")
			{
				document.frm.sysNote.value="���Ų�Ʒ��Աɾ��";
				document.frm.opNote.value="���Ų�Ʒ��Աɾ��";
				document.all.addProduct_div.style.display="none"; 
				document.all.addProduct_div1.style.display="none";
				document.all.addmodeflag.value="0";
				document.all.payflag_div_3.style.display="none";
			}
			else if (document.frm.opCode.value == "3605")
			{
				document.frm.sysNote.value="BOSS��VPMN��Ա�û��ײͱ��";
				document.frm.opNote.value="BOSS��VPMN��Ա�û��ײͱ��";
			}
			else
			{
				rdShowMessageDialog("�����������!");
				return false;
			}	
				
				
			if(document.all.smCode.value=="j1")
			{
				if(document.all.opCode.value=="3709")
				{
					tbs1.style.display="";
				}
				else
				{
					tbs1.style.display="none";
				}	
			}
			else
			{
				tbs1.style.display="none";
			}
			ChgCurrStep("custQuery");
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
			else if (currStep == "qryPhone")
			{
				document.frm.custQuery.disabled = false;
				document.frm.chkGrpPwd.disabled = false;				
				document.frm.doSubmit.disabled = false;
			}
			else if (currStep == "chkUserPwd")
			{
				document.frm.custQuery.disabled = false;
				document.frm.chkGrpPwd.disabled = false;				
				document.frm.doSubmit.disabled = false;
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
						ChgCurrStep("qryPhone");
						rdShowMessageDialog("�ͻ�����У��ɹ���",2);
					}
				}
				else
				{
					rdShowMessageDialog(retMessage+retCode,0);
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
						page = "s3709_2.jsp";
						frm.action=page;
						frm.method="post";
						frm.submit();
					}
					else return false;
				}
				else
				{
					rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��");
					return false;
				}
			}
			if(retType=="getbizcode")//luxc add 20080128
		    {
		    	if(retCode="000000")
		    	{ 
		    		if(document.frm.opCode.value == "3709")
		    		{
		    			var flag_1001 = packet.data.findValueByName("flag_1001");
		    			var flag_1002 = packet.data.findValueByName("flag_1002");
		    			var biz_code = packet.data.findValueByName("biz_code");
		    			document.all.flag_1001.value = flag_1001;
		    			document.all.flag_1002.value = flag_1002;
		    			document.all.biz_code.value = biz_code;
		    	    	
		    			
		    			if(flag_1001=="1")
		    			{
		    				document.all.addProduct_div.style.display="";
		    				//if(document.all.addmodeflag.value=="0"||document.all.addmodeflag.value=="1")
		    				document.all.addmodeflag.value="9"; //1001Ϊ1
		    			}
		    			if(flag_1002=="1")
		    			{
		    				if(document.frm.opCode.value == "3709")
		    				{       
		    					if(flag_1001=="1")
		    					{
		    						document.all.addmodeflag.value="11"; //��Ϊ1     					
		    					}
		    					else
		    					{  
		    					    document.all.addmodeflag.value="10"; //1002Ϊ1 
								}
		    					document.all.addProduct_div1.style.display="";     				
		    				}
		    			}
		    			if(flag_1001=="0"&&flag_1002=="0")
		    			{
		    				document.all.addmodeflag.value="0"; //ȫΪ0   
		    			}
		    			/*luxc 20080526 δ֪���󲹳�*/
		    			if(document.all.smCode.value=="hy")
						{
							document.all.payflag_div_3.style.display="";
							document.all.addmodeflag.value="3";
		    			}
		    			
		    		}
		    		else if (document.frm.opCode.value == "3704")
			        {
				        document.all.addProduct_div.style.display="none"; 
				        document.all.addProduct_div1.style.display="none";	
					}
		    	}
		    	else
		    	{		    	
		    		rdShowMessageDialog(retMessage);
		    	}
		    }			
		}


		//���ù������棬���м��ſͻ�ѡ��
		
		function getInfo_Cust()
		{
			var pageTitle = "���ſͻ�ѡ��";
			var fieldName = "֤������|���ſͻ�ID|�����û�ID|�����û�����|����ID|���Ų�Ʒ����|��������|��Ʒ����|aa|bb|";
			var sqlStr = "";
			var selType = "S";    //'S'��ѡ��'M'��ѡ
			var retQuence = "10|0|1|2|3|4|5|6|7|8|9|";
			var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|user_no|smCode|";
			var custId = document.frm.custId.value;
		
			if(document.frm.idIccid.value == "" &&
			document.frm.custId.value == "" &&
			document.frm.unitId.value == "" &&
			document.frm.grpOutNo.value == "")
			{
				rdShowMessageDialog("���������֤�š��ͻ�ID������ID���Ų�Ʒ��Ž��в�ѯ��",0);
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
				rdShowMessageDialog("���Ų�Ʒ���Ʋ���Ϊ0��",0);
				return false;
			}
		
			PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
		}

		function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
		{
			var path = "<%=request.getContextPath()%>/npage/s3500/fpubgrpusr_sel3709.jsp";
			path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
			path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
			path = path + "&selType=" + selType+"&idIccid=" + document.all.idIccid.value;
			path = path + "&custId=" + document.all.custId.value;
			path = path + "&unitId=" + document.all.unitId.value;
			path = path + "&grpOutNo=" + document.all.grpOutNo.value;
		
			retInfo = window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
			
			return true;
			
		}

		function getvaluecust(retInfo)
		{
			var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|user_no|account_id|smCode|";
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
			//alert("----1--"+document.all.smCode.value);
			if(document.all.smCode.value=="YM")
			{
				rdShowMessageDialog("����ҵ���������ɾ����Ա!");
		        return false;
			}
			if(document.all.smCode.value=="j1")
			{
				if(document.all.opCode.value=="3709")
				{
					
					tbs1.style.display="";
				}
				else
				{
					tbs1.style.display="none";
				}	
			}
			else
			{
				tbs1.style.display="none";
			}		
			
			
			if(getbizcode(document.all.grpIdNo.value,document.all.regionCode.value));			
		
			if(document.all.smCode.value=="hy" && document.all.opCode.value=="3709")
			{
				document.all.payflag_div_3.style.display="";
				document.all.addmodeflag.value="3";				
			}
			else if(document.all.smCode.value=="hy" && document.all.opCode.value!="3709")
			{
				document.all.payflag_div_3.style.display="none";
				document.all.addmodeflag.value="0";
			}
		
			ChgCurrStep("chkGrpPwd");
		}

		function getbizcode(id_no,region_code)
		{
			if(id_no.trim() == "")
		    {
		       	rdShowMessageDialog("ȡҵ�����ʧ��!");
		        return false;
		    }
		    var getbizcode_Packet = new AJAXPacket("fgetbizcode.jsp","���ڻ�ȡҵ����룬���Ժ�......");
			getbizcode_Packet.data.add("retType","getbizcode");
		    getbizcode_Packet.data.add("id_no",id_no);
		    getbizcode_Packet.data.add("region_code",region_code);
			core.ajax.sendPacket(getbizcode_Packet);
			getbizcode_Packet=null;
			//delete(getbizcode_Packet);
		}

		function check_HidPwd()
		{
			
			var grpIdNo = document.frm.grpIdNo.value;
			var inPwd = document.frm.grpPwd.value;
			var checkPwd_Packet = new AJAXPacket("/npage/s3600/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("retType","checkPwd");
			checkPwd_Packet.data.add("GRP_ID",grpIdNo);
			checkPwd_Packet.data.add("inPwd",inPwd);
			core.ajax.sendPacket(checkPwd_Packet);
			checkPwd_Packet=null;
			//delete(checkPwd_Packet);
		}

		//��ӡ��Ϣ
		function printInfo(printType)
		{ 
			var retInfo = "";
			var tmpOpCode=document.all.opCode.value;
			if((tmpOpCode=="3709" || tmpOpCode=="3704")&&(document.all.smCode.value=="hy"))
			{
				retInfo+='<%=workname%>'+"|";
		    	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		    	retInfo+="���֤��:"+document.frm.idIccid.value+"|";
		    	retInfo+="�û�����:"+document.frm.grpName.value+"|";
		    	retInfo+="���Ų�Ʒ����:"+document.frm.grpOutNo.value+"|";
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
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";  
		    	retInfo+="ҵ�����ͣ���ҵӦ�ò�Ʒ,"+document.frm.opCode.options[document.frm.opCode.selectedIndex].text+"|";
		    	retInfo+="��ˮ��"+document.frm.loginAccept.value+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=document.frm.sysNote.value+"|";
		    	retInfo+=document.all.simBell.value+"|";
				return retInfo;
			}
			else if (tmpOpCode=="3709" || tmpOpCode=="3704")
			{
				retInfo+='<%=workname%>'+"|";
		    	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		    	retInfo+="���֤��:"+document.frm.idIccid.value+"|";
		    	retInfo+="�û�����:"+document.frm.grpName.value+"|";
		    	retInfo+="���Ų�Ʒ����:"+document.frm.grpOutNo.value+"|";
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
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";  
		    	retInfo+="ҵ�����ͣ�"+document.frm.opCode.options[document.frm.opCode.selectedIndex].text+"|";
		    	retInfo+="��ˮ��"+document.frm.loginAccept.value+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=""+"|";
		    	retInfo+=document.frm.sysNote.value+"|";
		    	retInfo+=document.all.simBell.value+"|";
				return retInfo;
			}
		}

		//��ʾ��ӡ�Ի���
		function showPrtDlg(printType,DlgMessage,submitCfm)
		{
			var h=180;
			var w=352;
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
			//delete(getSysAccept_Packet);
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
			
			if (document.frm.opCode.value == "3605")
			{
				if (document.frm.newRate.value == document.frm.mainRate.value ||document.frm.newRate.value=="")
				{
					rdShowMessageDialog("�·��ʲ���Ϊ�գ��¾ɷ���Ҳ������ͬ!");
					document.frm.newRate.focus();
					return false;
				}
			}
			if( (document.all.addmodeflag.value=="9"||document.all.addmodeflag.value=="11") 
				&& document.all.addProduct.value.trim()=="" )
			{
				rdShowMessageDialog("��ѡ���Ա�����ײ�!");
				document.frm.addProduct.focus();
				return false;
			}
			getSysAccept();
		}


		function getAdditiveBill()
		{
		    //var modeCode = document.frm.modeCode.value;
			var addMode = document.frm.addProduct.value;
			//alert(document.all.biz_code.value);
		    var path = "/npage/s3500/pubAdditiveBill_3509.jsp";
		    path = path + "?pageTitle=" + "��ѡ�ʷ�ѡ��";
		    path = path + "&orgCode=" + "<%=Department%>";
		    //path = path + "&smCode="+document.all.sm_code.value;
		    //path = path + "&modeCode=" + modeCode;
			path = path + "&existModeCode=" + addMode;
			path = path + "&biz_code=" + document.all.biz_code.value;
			path = path + "&product_code=" + document.all.grpName.value;
			//path = path + "&userType=" + document.frm.userType.value;
			path = path + "&userType=ADCA";
		    var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:30;");
			if(typeof(retInfo) == "undefined")     
		    {   
		    	return false;   
		    }
			var addiMode=retInfo.substring(0,retInfo.indexOf("|"));
			var addProduct_name=retInfo.substring(retInfo.indexOf("|")+2,retInfo.length-2);
		    document.frm.addProduct.value      =  addiMode;
		    document.frm.addProduct_name.value =  addiMode+"->"+addProduct_name;
		    
		}
</script>
	<BODY>
	 <FORM action="" method="post" name="frm" >	
		<input type="hidden" name="loginAccept"  value="0"> <!-- ������ˮ�� -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="smCode"  value="">
		<input type="hidden" name="user_no"  value="">
		<input type="hidden" name="account_id"  value="">
		
		<input type="hidden" name="smName"  value="">
		<input type="hidden" name="grpName"  value="">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		<input type="hidden" name="biz_code"  value="">
		<input type="hidden" name="addmodeflag"  value="0">   
		<input type="hidden" name="flag_1001"  value="0"> 
		<input type="hidden" name="flag_1002"  value="0">
		<input type="hidden" name="regionCode"  value="<%=regionCode%>">
		<input type="hidden" name="opName"  value="<%=opName%>">
		
		<input  type="hidden" class="InputGrey" name="opNote" size="50" value="���ų�Ա����" readonly >
		
		<%@ include file="/npage/include/header.jsp" %>  
		<div class="title">
			<div id="title_zi">ͨ�ü��ų�Ա����</div>
		</div>	
		
		 <TABLE cellspacing="0">
                	<TBODY> 
			<TR>
				<TD class="blue">
					��������
				</TD>
				<TD colspan="3">
					<SELECT name="opCode" id="opCode" onChange="OpCodeChange()">
						<option value="3709">�������ų�Ա����</option>
						<option value="3704">�������ų�Աɾ��</option>
					</SELECT>
					<font class="orange">*</font>
				</TD>
			</TR>
			
			<TR>
				<TD class="blue">
					֤������
				</TD>
				<TD>
					<input name="idIccid" id="idIccid" size="24" maxlength="18" v_type="string" v_must=1  index="1" value="">
					<input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=��ѯ>
					<font class="orange">*</font>
				</TD>
				<TD class="blue">���ſͻ�ID</TD>
				<TD>
					<input type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1  index="2" value="">
					<font class="orange">*</font>
				</TD>
			</TR>
			
			<TR>
				<TD class="blue">
					���ű��
				</TD>
				<TD>
					<input name=unitId id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1  index="3" value="">
					<font class="orange">*</font>
				</TD>
				<TD class="blue">���Ų�Ʒ����</TD>
				<TD>
					<input name="grpOutNo" size="20" v_must=1 v_type=string  index="4" value="">
					<font class="orange">*</font>
				</TD>
			</TR>
			<TR>
				<TD class="blue">���Ų�ƷID</TD>
				<TD>
					<input class="InputGrey" name="grpIdNo" size="20" readonly v_must=1 v_type=string  index="4" value="">
					<font class="orange">*</font>
				</TD>
				<TD class="blue">���ſͻ�����</TD>
					<TD>
						<jsp:include page="/npage/common/pwd_1.jsp">
						<jsp:param name="width1" value="16%"  />
						<jsp:param name="width2" value="34%"  />
						<jsp:param name="pname" value="grpPwd"  />
						<jsp:param name="pwd" value=""  />
						</jsp:include>
						<input name=chkGrpPwd type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkGrpPwd" value=У��>
						<font class="orange">*</font>
					</TD>
				</TR>
				<TR>
					<TD class="blue">�ֻ�����</TD>
					<TD>
						<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string"  index="8"></textarea>
							<br>ע���������ֻ�����ʱ,����"|"��Ϊ�ָ�<br>
							��,�������һ������Ҳ����"|"��Ϊ����.<br>
							����:13900000000|<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br>								
					</TD>
					
					<TD colspan="2">
						<div id="tbs1" style="display:none">
							<Font color="red">��Ա���ʷѱ���Ϊ000030AA <br>
							 (0���⣬����ͨ�ŷ�0.40Ԫ/����)<br> 
							���ܼ��뱾����<br></font>
						</div>				
					</TD>
							
				</TR>
				<tr id="addProduct_div"  style="display:none">
					<td class="blue">��Ա�����ײ�</td>
					<td>
						<input name="addProduct" type="hidden" v_must=1 v_maxlength=8 v_type="string"  index="10" value="<%//=addProduct%>" >
		   				<input name="addProduct_name" class="InputGrey" type="text" v_must=1 v_maxlength=20 v_type="string"  index="20" value="<%//=addProduct_name%>" readonly >
		   				<input id="selectAdditive" onkeyup="if(event.keyCode==13)getAdditiveBill()" onmouseup="getAdditiveBill()" style="cursor:hand" type=button value=ѡ��  index="20" >
		   				<Font class="orange">*</font>
		   			</td>
		   			<td>&nbsp;</td>  
		   			<td>&nbsp;</td>  
		   		</tr>
		   		<tr id="addProduct_div1"  style="display:none">   
					<td class="blue">���ѷ�ʽ</td>
					<td colspan="3">
						<select name="pay_flag" id="pay_flag">
							<option value="0">0--����ͳ�� </option>
							<option value="1">1--���˸��� </option>
						</select>
					</td>					
				</tr>
				<tr id="payflag_div"  style="display:none">
					<td class="blue">���ѷ�ʽ</td>
					<td colspan="3">
						<select name="pay_flag_4" id="pay_flag_4">
							<option value="0">0--����ͳ�� </option>
							<option value="1">1--���˸��� </option>
						</select>
					</td>					
				</tr>
				<!--��һ��ѡ��,��ʾ����-->
				<tr id="payflag_div_3"  style="display:none">
					<td class="blue">���ѷ�ʽ</td>
					<td colspan="3">
						<select name="pay_flag_3" id="pay_flag_3">
							<option value="0">0--����ͳ�� </option>
						</select>
					</td>			
				</tr>	
				<TR>
					<TD class="blue">ϵͳ��ע</TD>
					<TD>
						<input   class="InputGrey"  name="sysNote" size="50" value="���ų�Ա����" readonly >
					</TD>
				</TR>	
			
			  </TBODY> 
			</TABLE>		
					
			<table cellspacing="0">
				<TBODY> 
				    <tr> 
				    	<td id="footer">  
				    		<input class="b_foot" name="doSubmit"  type=button value="ȷ��" onclick="refMain()">
				    		&nbsp;
				                <input class="b_foot" name="reset1"  onClick="" type=reset value="���">
				                &nbsp;
						<input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�">
				   	</td>
				    </tr>
			  	 </TBODY> 
  			</table> 
		<%@ include file="/npage/include/footer.jsp" %>		
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
	</FORM>	
		<script language="JavaScript">
			document.frm.idIccid.focus();
			ChgCurrStep("custQuery");
			OpCodeChange();
		</script>
	</BODY>
	
</HTML>
