<%
/*
 * ����: ��ͯ�ײ�
 * �汾: 1.0
 * ����: 2012/6/28 11:19:29
 * ����: zhangyan
 * ��Ȩ: si-tech
 * update:
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String passwd=(String)session.getAttribute("password");
String regCode=(String)session.getAttribute("regCode");
String cldPhone=request.getParameter("activePhone");

java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf2
	= new java.text.SimpleDateFormat("yyyy��MM��dd��");
String createTime2 = sf2.format(sysdate);

/*����У���ֻ�������*/
boolean pwrf=false;
String pubOpCode = opCode;
String pubWorkNo = (String)session.getAttribute("workNo");
%>


<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=opCode%></title>
	</head>
	<body onload="cldInit()">
		<form  name="frm" action="" method="POST" >
					
		<!--������ˮ-->
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept"
			routerKey="workNo" routerValue="<%=workNo%>" id="loginAccept"/>

			
			<input type="hidden" id="opCode" name	="opCode"	value= "<%=opCode%>">
			<input type="hidden" id="opName" name	="opName"	value= "<%=opName%>">
			<!--�ҳ�����-->
			<input type="hidden" id="pName" name	="pName"	value= "">
			<!--��ͯ����-->
			<input type="hidden" id="cldName" name	="cldName"	value= "">
			<!--��ͯ�û�Ʒ��-->
			<input type="hidden" id="cldSmName" name	="cldSmName"	value= "">
			<!--������ˮ-->
			<input type="hidden" id="loginAccept" name	="loginAccept"	value= "<%=loginAccept%>">
			<%@ include file="/npage/include/header.jsp" %>

			<DIV id="Operation_Table">

				<div class="title">
					<div id="title_zi"><%=opName%></div>
				</div>
				
				<wtc:service name="sChildOfferInit" outnum="4"
					routerKey="region" routerValue="<%=regCode%>" 
					retcode="retCode" retmsg="retMsg">
					<wtc:param value="<%=loginAccept%>"/>
					<wtc:param value="01"/>
					<wtc:param value="<%=opCode%>"/>
					<wtc:param value="<%=workNo%>"/>
					<wtc:param value="<%=passwd%>"/>
					<wtc:param value="<%=cldPhone%>"/>
					<wtc:param value=""/>
					<wtc:param value="2"/>
				</wtc:service>
				<wtc:array id="rstProd" scope="end" />
				
				<%
				if ( retCode.equals("000000") )
				{
					System.out.println(opCode+"~~~~rstProd.length="+rstProd.length);
					if ( rstProd.length==0 )
					{
					%>
						<script>
							rdShowMessageDialog("�鲻���û�����Ķ�ͯ�ײ��ʷ�!",0);
							removeCurrentTab();
						</script>
					<%
					}
					else
					{
					%>	
						<table>
							<tr>
								<th align="center">��ͯ�û�����:</th>
								<td>
									<input type="text" id="cldPhone" name="cldPhone" 
										value='<%=cldPhone%>' readOnly class='InputGrey'/>	
								</td>			
								<th align="center">�ҳ��û�����:</th>
								<td>
									<input type="text" id="pPhoneNo" name="pPhoneNo" 
										value='<%=rstProd[0][0]%>'  readOnly class='InputGrey'/>	
								</td>
							</tr>	
							<tr>
								<th align="center">ȡ�����ʷ�ID:</th>
								<td>
									<input type="text" id="offerId" name="offerId" 
										value='<%=rstProd[0][1]%>' readOnly class='InputGrey'/>	
								</td>			
								<th align="center">ȡ�����ʷ�����:</th>
								<td >
									<input type="text" id="offerNm" name="offerNm" 
										value='<%=rstProd[0][2]%>' readOnly class='InputGrey'/>	
								</td>
							</tr>
							<tr>
								<th align="center" >ȡ�����ʷ�����:</th>
								<td colspan='3'>
									<textarea id="offerCmt" name="offerCmt" cols='120' rows='7'
									value='<%=rstProd[0][3]%>' readOnly  ><%=rstProd[0][2]%></textarea>	
								</td>
							</tr>		
						</table>
					<%
					}
				}
				else
				{
					System.out.println(opCode+"~~~~retCode"+retCode);
				%>
					<script>
						rdShowMessageDialog("<%=retCode%>:<%=retMsg%>",0);
						removeCurrentTab();
					</script>
				<%
				}
				%>				

				<table>
					<tr>
						<td  id="footer">
							<input class="b_foot" type="button" name=cfmBtn value="ȷ��"
								onClick="doCfm();">
							<input class="b_foot" type="button" name=clsBtn value="�ر�"
								onClick="removeCurrentTab();">								
						</td>
					</tr>
				</table>	
				<%@ include file="/npage/include/footer.jsp" %>
			</div>
		</form>
	</body>
	<script type="text/javascript">
		
		/*��װ��ӡ��Ϣ*/	
		function printInfo(printType)
		{    

			/*�ͻ���Ϣ*/
			var cust_info="";
			/*ҵ����Ϣ*/
			var opr_info="";
			
			/*��ע��Ϣ*/
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";

			cust_info+= "�ֻ����룺     "+"<%=cldPhone%>"+"|";
			cust_info+= "�ͻ�������     "+document.all.cldName.value+"|";
			
			
			opr_info+="����ҵ�񣺶�ͯ�ײ�ȡ��"+"|";
			opr_info+="�û�Ʒ�ƣ�"+document.all.cldSmName.value+"|";                       
			opr_info+="������ˮ��"+<%=loginAccept%>+"     ҵ�����ʱ�䣺"+"<%=createTime2%>"+"|";
			opr_info+="�ҳ����룺"+document.all.pPhoneNo.value
				+"   �ҳ�������"+document.all.pName.value+"|";

			retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		    return retInfo;
		}		
		
		function conf()
		{
			document.frm.action="fE891Cfm.jsp";
			document.frm.submit();
		}
		
		function getPInfo(packet)
		{
			var pName=packet.data.findValueByName("stPMcust_name");
			document.all.pName.value=pName;
		}		
		
		function getCInfo(packet)
		{
			var cldName=packet.data.findValueByName("stPMcust_name");
			var cldSmName=packet.data.findValueByName("stPMsm_name");
			document.all.cldName.value=cldName;
			document.all.cldSmName.value=cldSmName;
		}		
		
		function doCfm()
		{
			document.all.cfmBtn.disabled=true;
			/*���û���Ϣ�����*/
			var pPacket = new AJAXPacket("../public/pubGetUserBaseInfo.jsp"
				,"���Ժ�...");
			/*��ajaxҳ�洫�ݲ���*/
			pPacket.data.add("phoneNo",document.all.pPhoneNo.value );
			pPacket.data.add("opCode","<%=opCode%>" );
			
			/*����ҳ��,��ָ���ص�����*/
			core.ajax.sendPacket(pPacket,getPInfo,false);
			pPacket=null;		
			
			/*���û���Ϣ�����*/
			var cPacket = new AJAXPacket("../public/pubGetUserBaseInfo.jsp"
				,"���Ժ�...");
			/*��ajaxҳ�洫�ݲ���*/
			cPacket.data.add("phoneNo",document.all.cldPhone.value );
			cPacket.data.add("opCode","<%=opCode%>" );
			
			/*����ҳ��,��ָ���ص�����*/
			core.ajax.sendPacket(cPacket,getCInfo,false);
			pPacket=null;				
			
			
			var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined")
			{ 
				if((ret=="confirm"))
				{
					if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
					{
						conf();
					}
					else
					{
						document.all.cfmBtn.disabled=false;	
					}
				}
				if(ret=="continueSub")
				{
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
					{
						conf();
					}
					else
					{
						document.all.cfmBtn.disabled=false;	
					}
				}
			}
			else
			{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
				{
					conf();
				}
				else
				{
					document.all.cfmBtn.disabled=false;	
				}
			}			
			
		}
		
		
		/*��ʾ��ӡ�Ի���*/
		function showPrtDlg(printType,DlgMessage,submitCfm)
		{ 
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var pType="subprint";
			var billType="1";
			var sysAccept = "<%=loginAccept%>";
			var printStr = printInfo(printType);
		
			var mode_code=null;
			var fav_code=null;
			var area_code=null
		
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp"
				+"?DlgMsg="+DlgMessage;
			var path = path  + "&mode_code="+mode_code
				+"&fav_code="+fav_code
				+"&area_code="+area_code
				+"&opCode=<%=opCode%>&sysAccept="+sysAccept
				+"&phoneNo=<%=cldPhone%>&submitCfm=" + submitCfm
				+"&pType="+pType+"&billType="+billType
				+ "&printInfo=" + printStr;

			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}		
	</script>
</html>
