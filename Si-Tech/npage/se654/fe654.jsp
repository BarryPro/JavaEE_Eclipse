<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
		String opCode = WtcUtil.repNull(request.getParameter("opCode"));	
		String opName = WtcUtil.repNull(request.getParameter("opName"));	
		
		String ipAddress = (String)session.getAttribute("ipAddr");
		String loginNo = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String loginPwd  = (String)session.getAttribute("password");
		String Department = (String)session.getAttribute("orgCode");
		String regionCode = Department.substring(0,2);
		String districtCode = Department.substring(2,4);
		String strDate=new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		//System.out.println(")))))))))))))))))))))))))))))0="+strDate);
%>
<%  
  //��ȡ����ҳ�õ�����Ϣ
	String loginAccept = request.getParameter("login_accept");
	if(loginAccept == null)
	{			
	//��ȡϵͳ��ˮ
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>"  id="req" />
<%		
		loginAccept=req;	
	}
%>
	<head>
		<title>
			<%=opName%>
		</title>
		<script type=text/javascript>
		function doProcess(packet)
		{
			//RPC������findValueByName
			var retType = packet.data.findValueByName("retType");
			var retCode = packet.data.findValueByName("retCode"); 
			var retMessage = packet.data.findValueByName("retMessage"); 
			if(retType == "QryPhoneInfo"){
				var cust_id = packet.data.findValueByName("cust_id");
				var cust_name = packet.data.findValueByName("cust_name");
				var run_code = packet.data.findValueByName("run_code");
				var run_name = packet.data.findValueByName("run_name");
				var id_no = packet.data.findValueByName("id_no");
				if(retCode=="000000")
				{
					document.all.cust_id.value = cust_id;
					document.all.cust_name.value = cust_name;
					document.all.run_name.value = run_name;
					document.all.id_no.value = id_no;
					
				}else
				{
					retMessage = "����" + retCode + "��"+retMessage;
					rdShowMessageDialog(retMessage);
					return false;
				}  		
			}
			if(retType == "QryEcSiInfo"){
					var ECSIID = packet.data.findValueByName("ECSIID");
					var cust_name = packet.data.findValueByName("cust_name");

				
				if(retCode=="000000"){
					 if(ECSIID!=""){
					 document.all.ECSIID.value = ECSIID;
					 document.all.cust_name.value = cust_name;
					 document.all.confirm.disabled=false;
					 document.all.cust_id.readOnly=true;
					 //document.all.cust_status.value = cust_status;					
					//retMessage = "��EC/SI�����ȷ" + retCode  ;
					//rdShowMessageDialog(retMessage);
				  }else{
				  		retMessage = "��ѯʧ�ܣ�û�д�����¼��";
					    rdShowMessageDialog(retMessage);
					    return false;
				  }
				}else
				{
					retMessage = "����" + retCode + "��"+retMessage;
					rdShowMessageDialog(retMessage);
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

			//�õ�������Ϣ
	/*function QryPhoneInfo()
		{
			if (document.frm.phoneNo.value == "")
			{
				rdShowMessageDialog("�ֻ����벻��Ϊ�գ�");
				document.frm.phoneNo.focus();
				return false;		
			}

			var checkPwd_Packet = new AJAXPacket("../se654/getPhoneInfo.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("retType","QryPhoneInfo");
			checkPwd_Packet.data.add("loginNo",<%=loginNo%>);
			checkPwd_Packet.data.add("phoneNo",document.frm.phoneNo.value);
			core.ajax.sendPacket(checkPwd_Packet);
			checkPwd_Packet = null;
		}*/



		function QryEcSiInfo()
		{
			if (document.frm.cust_id.value == "")
			{
				rdShowMessageDialog("EC/SI���벻��Ϊ�գ�");
				document.frm.ECSIID.focus();
				return false;		
			}	
			var checkPwd_Packet = new AJAXPacket("QryEcSiInfo.jsp","���ڽ��в�ѯ�����Ժ�......");
			checkPwd_Packet.data.add("retType","QryEcSiInfo");
			checkPwd_Packet.data.add("loginNo","<%=loginNo%>");
			checkPwd_Packet.data.add("black_type",document.frm.black_type.value);
			checkPwd_Packet.data.add("cust_id",document.frm.cust_id.value);
			checkPwd_Packet.data.add("ECSIType",document.frm.ECSIType.value);
			core.ajax.sendPacket(checkPwd_Packet);
			checkPwd_Packet = null;		
		}	


//ȡ��ˮ
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("../s2897/pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet=null;
}			

			
		function conCfm()
		{		
			var EfftT=document.frm.EfftT.value;
			
			if(document.frm.EfftT.value=="")
			{
				rdShowMessageDialog("�������ڲ���Ϊ�գ�");
				return;
			}
			
			var nowDate=  "<%=strDate%>";
			if(parseInt(EfftT)<parseInt(nowDate))
			{
				rdShowMessageDialog("�������ڲ���С�ڵ�ǰ���ڣ�");
				return;
			}
			
			  var phoneNo=document.frm.phoneNo.value;
				var chPos_field ;
				var MobPhone;	
				var count=0;		
				while(phoneNo!=""){
				    chPos_field = phoneNo.indexOf("|");
				    MobPhone   =phoneNo.substring(0,chPos_field);
				    phoneNo = phoneNo.substring(chPos_field + 1);
					  //phoneNo=phoneNo.replace("\r\n","");
				    MobPhone = MobPhone.replace("\r\n","");       
				    count ++;
						if(count>50){
				      rdShowMessageDialog("��ӵĺ�����Ϣ��ʽ������Ա��������30����",0);
			        document.frm.phoneNo.focus();
			        return false;
					 }
			 }
			 
			 if(document.frm.black_type.value=="03"||document.frm.black_type.value=="04")
			 {
			 	if(document.frm.cust_id.value=="")
			 	{
			 		rdShowMessageDialog("EC/SI���벻��Ϊ�գ�");
					return;
			 	}
			 	
			 }
			 
			 document.frm.EcSiType1.value=document.frm.ECSIType.value;
			
			document.frm.opType.value="no";   //����ֻ�ṩ����¼�뷽ʽ			
			//getSysAccept();
			if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1)
			{
				page = "fe654Cfm.jsp?opType="+document.frm.opType.value;
				frm.action=page;
				frm.method="post";
				frm.submit();
			}
			else{ 
				return false;
			}
		}
			
		function inputECSI()
		{
			if(document.frm.black_type.value == "03"||document.frm.black_type.value == "04"){

				document.all.tableNo.style.display="";
				document.all.tableNo1.style.display="";
				//document.all.tableNo2.style.display="";
				document.all.ECSIType.disabled =false;
				document.all.confirm.disabled=true;
			}else
			{
				document.all.tableNo.style.display="none";
				document.all.tableNo1.style.display="none";
				//document.all.tableNo2.style.display="none";
				document.all.ECSIType.disabled =true;
				document.all.confirm.disabled=false;
			}
			
		}
		
		function doclear()
		{
	 		window.location.href="fe654.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	 	}
		
		</script>
	</head>

	<body>
		<form name="frm">
			<%@ include file="/npage/include/header.jsp" %>
			<input type="hidden" name="pageOpCode" value="<%=opCode%>">
			<input type="hidden" name="pageOpName" value="<%=opName%>">
			<input type="hidden" name="id_no">
			<input type="hidden" name="loginAccept"  value="<%=loginAccept%>"> <!-- ������ˮ�� -->
			<input type="hidden" name="loginNo"  value="<%=loginNo%>">
			<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
			<input type="hidden" name="smName"  value="">
			<input type="hidden" name="grpName"  value="">
			<input type="hidden" name="opType"  value="124">
			<input type="hidden" name="orgCode"  value="<%=orgCode%>">
			<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
			<input type="hidden" name="EcSiType1"  value="">
			<div class="title">
					<div id="title_zi">��ѡ���������</div>
			</div>
					<TABLE cellSpacing="0">
						<TR>
							<TD class="blue">
								�������룺
							</TD>
							<TD  >
								<SELECT name="black_type" onchange="inputECSI()">
									<OPTION value="01">
										01������ȫ�ֺ�����
									</option>
									<OPTION value="02">
										02���˳�ȫ�ֺ�����
									</option>
									<OPTION value="03">
										03������EC/SI��������
									</option>
									<OPTION value="04">
										04���˳�EC/SI��������
									</option>
								</SELECT>

							</TD>
							
							<TD class="blue">
								EC/SI���ͣ�
							</TD>
							<TD>
								<SELECT name="ECSIType" disabled =true>
									<OPTION value="01">
										01��EC
									</option>
									<OPTION value="02">
										02��SI
									</option>
								</SELECT>
							</TD>
						</TR>
						<TR id="tableNo"  style=display:none>
							<TD class="blue">
								EC/SI���룺
							</TD>
							<TD width='32%'>
								<INPUT type="text" name="cust_id" value="">
								&nbsp;
								<FONT color="orange">
									<INPUT type="Button" name="button1" value="У��"  class="b_text" onclick="QryEcSiInfo()"/>
									*
								</FONT>
							</TD>

							<TD>
								&nbsp;
							</TD>
							<TD>
								&nbsp;
							</TD>
							

						</TR>
						<TR  id="tableNo1"  style=display:none>
							<TD class="blue">
								EC/SI���룺
							</TD>
							<TD>
								<INPUT type="text" name="ECSIID"  Class="InputGrey"  readonly>
							</TD>
							<TD class="blue">
								EC/SI���ƣ�
							</TD>
							<TD>
								<INPUT type="text" name="cust_name" Class="InputGrey" size=40  readonly>
							</TD>
						</TR>
						
						<TR>
							<TD class="blue">
								����
							</TD>
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

			
						<TR>
							<TD class="blue">
								��Чʱ��:
							</TD>
							<TD>
								<INPUT type="text" name="EfftT"  v_format="yyyyMMdd" maxlength="8" v_type="date" value="<%=strDate%>" v_must="1" size="9"/>
								<FONT color="orange">
									*
								</FONT>&nbsp;
								(��ʽ:YYYYMMDD)&nbsp;
							</TD>
							<TD>
								&nbsp;
							</TD>
							<TD>
								&nbsp;
							</TD>
						</TR>
					</TABLE>

					<TABLE cellSpacing="0">
						<TR>
							<TD align="center">
								<INPUT  class="b_foot" type="Button" name="confirm" value="ȷ��" onclick="conCfm()"   >
								<!--<INPUT  class="b_foot" type="reset" name="reset" value="���"  >-->
								<INPUT  class="b_foot" type="reset" name="reset" value="���" onclick="doclear()" >
								<INPUT  class="b_foot" type="Button" name="closeBtn" value="�ر�" onClick="removeCurrentTab()">
							</TD>
						</TR>
					</TABLE>
<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>


