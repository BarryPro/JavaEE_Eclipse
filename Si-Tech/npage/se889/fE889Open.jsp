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
String passwd = (String)session.getAttribute("password");
String cldPhoneNo=request.getParameter("cldPhoneNo");
String cldPwd="";
String regCode = (String)session.getAttribute("regCode");
String orgCode=(String)session.getAttribute("orgCode");
String ipAddr=(String)session.getAttribute("ipAddr");

java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf2
	= new java.text.SimpleDateFormat("yyyy-MM-dd");
String createTime2 = sf2.format(sysdate);

/*����У���ֻ�������*/
boolean pwrf=false;
String pubOpCode = opCode;
String pubWorkNo = (String)session.getAttribute("workNo");
String chnSrc="01";
%>
<!--������ˮ-->
<wtc:sequence name="sPubSelect" key="sMaxSysAccept"
	routerKey="workNo" routerValue="<%=workNo%>" id="loginAccept"/>



<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=opCode%></title>
	</head>
	<body >
		<form  name="frm" action="" method="POST" >
			<input type="hidden" id="opCode" name	="opCode"	value= "<%=opCode%>">
			<input type="hidden" id="opName" name	="opName"	value= "<%=opName%>">
			<!--�����ʷѴ���-->
			<input type="hidden" id="odOfid" name	="odOfid"	value= "">		
			<!--�����ʷ�����-->
			<input type="hidden" id="odOfCmt" name	="odOfCmt"	value= "">		
			<!--�˶��ط���-->
			<input type="hidden" id="iProductStr" name	="iProductStr"	value= "">
			<!--�����Ƿ�����wlanȡ��-->
			<input type="hidden" id="wFlag" name	="wFlag"	value= "">
			
			<input type="hidden" id="prtProd" name	="prtProd"	value= "">
			<!--ԭSPҵ��-->
			<input type="hidden" id="iSpOldOC" name	="iSpOldOC"	value= "">
			<!--��SPҵ��-->
			<input type="hidden" id="iSpNewOC" name	="iSpNewOC"	value= "">
			<!--SPҵ�����-->
			<input type="hidden" id="iSpOCCode" name	="iSpOCCode"	value= "">			
			<!--��ͯ�û�����-->
			<input type="hidden" id="cldPhoneNo" name	="cldPhoneNo"	value= "<%=cldPhoneNo%>">
			<!--��ͯ�û�����-->
			<input type="hidden" id="cldName" name	="cldName"	value= "">
			<!--��ͯ�û�Ʒ��-->
			<input type="hidden" id="cldSmName" name	="cldSmName"	value= "">
			<!--�ҳ�����-->
			<input type="hidden" id="pName" name	="pName"	value= "">
			
			
			<!--������ˮ-->
			<input type="hidden" id="loginAccept" name	="loginAccept"	value= "<%=loginAccept%>">
	
			<%@ include file="/npage/include/header.jsp" %>

			<DIV id="Operation_Table">

				<div class="title">
					<div id="title_zi"><%=opName%></div>
				</div>
				<table>
				<tr>
					<th align="center">ѡ��</th>
					<th align="center">�ʷ�ID</th>
					<th align="center">�ʷ�����</th>
					<th align="center">�ʷ�����</th>
				<wtc:service name="sChildOfferInit" outnum="4"
					routerKey="region" routerValue="<%=regCode%>" 
					retcode="retCode" retmsg="retMsg">
					<wtc:param value="<%=loginAccept%>"/>
					<wtc:param value="<%=chnSrc%>"/>
					<wtc:param value="<%=opCode%>"/>
					<wtc:param value="<%=workNo%>"/>
					<wtc:param value="<%=passwd%>"/>
					<wtc:param value="<%=cldPhoneNo%>"/>
					<wtc:param value="<%=cldPwd%>"/>
					<wtc:param value="0"/>
				</wtc:service>
				<wtc:array id="rstCld" scope="end" />			
				<%
				if ( !retCode.equals("000000") )
				{
				%>
					<script>
						rdShowMessageDialog("<%=retCode%>:<%=retMsg%>");
						removeCurrentTab();
					</script>
				<%
				}
				else
				{
					if (rstCld.length!=0)
					{
					%>
	
						<tr>
							<td>
								<input type="radio" id="offerRdo" name="offerRdo" 
									onclick="showPifo(this)" value='<%=rstCld[0][0]%>' ofCmt="<%=rstCld[0][2]%>" >	
							</td>							
							<td>
								<input type="text" id="offerId" name="offerId" 
									value='<%=rstCld[0][0]%>' readOnly class='InputGrey' size='10'/>	
							</td>			
							<td >
								<input type="text" id="offerNm" name="offerNm" 
									value='<%=rstCld[0][1]%>' readOnly class='InputGrey' size='20'/>	
							</td>
							<td >
								<textarea id="offerCmt" name="offerCmt" cols='100' rows='3'
								value='<%=rstCld[0][2]%>' readOnly  ><%=rstCld[0][2]%></textarea>	
							</td>
						</tr>				
					<%
					}
					else
					{
					%>
						<script>
							rdShowMessageDialog("û�п��԰���Ķ�ͯ�ײ�",0);
							removeCurrentTab();
						</script>
					<%
					}

				}	
				%>	
		
				</table>
				<table id='pIfo' style='display:none'>
					<tr>
						<th>�ҳ�����</th>	
						<td><input type='text' id='pPhone' name='pPhoneNo' value=''></td>
						<th>�ҳ�����</th>	
						<td><input type='password' id='pPwd' name='pPwd' value=''></td>	
					</tr>
					<tr>
						<th>�˶��ط�</th>	
						<td>
						<wtc:service name="sChildOfferInit" outnum="4"
							routerKey="region" routerValue="<%=regCode%>" 
							retcode="prodRc" retmsg="prodRm">
							<wtc:param value="<%=loginAccept%>"/>
							<wtc:param value="<%=chnSrc%>"/>
							<wtc:param value="<%=opCode%>"/>
							<wtc:param value="<%=workNo%>"/>
							<wtc:param value="<%=passwd%>"/>
							<wtc:param value="<%=cldPhoneNo%>"/>
							<wtc:param value="<%=cldPwd%>"/>
							<wtc:param value="1"/>
						</wtc:service>
						<wtc:array id="rstProd" scope="end" />			
						<%
						if( !prodRc.equals("000000") )
						{
						%>
							<script>
								rdShowMessageDialog("<%=prodRc%>:<%=prodRm%>");
								removeCurrentTab();	
							</script>
						<%
						}
						else
						{

							if (rstProd.length==0)
							{
							%>
								�޿��˶����ط�!
							<%
							}
							else
							{
								for ( int i=0;i<rstProd.length;i++ )
								{
								%>
									<input type='checkbox' id='prodIfo' name='prodIfo' checked
										value='<%=rstProd[i][0]%>' prodName='<%=rstProd[i][1]%>'  ><%=rstProd[i][1]%> &nbsp&nbsp
								<%
								}
							}

						}
						%>					
						</td>
						<th>SPҵ�񿪹�</th>	
						<td>
						<table>
						
						<wtc:service name="s1984PhoneOut" outnum="43" 
							routerKey="region" routerValue="<%=regCode%>"  
							retcode="spRc" retmsg="spRm">
							<wtc:param value="<%=workNo%>"/>
							<wtc:param value="<%=orgCode%>"/>
							<wtc:param value="<%=passwd%>"/>
							<wtc:param value="<%=ipAddr%>"/>
							<wtc:param value="1984"/>
							<wtc:param value="<%=cldPhoneNo%>"/>

						</wtc:service>
						<wtc:array id="s9130PhoneOutArr" scope="end"/>
						<wtc:array id="arrSp8" start="8" length="1" scope="end"/>
						<wtc:array id="arrSp9" start="9" length="1" scope="end"/>
						<wtc:array id="arrSp10" start="10" length="1" scope="end"/>
						<wtc:array id="arrSp11" start="11" length="1" scope="end"/>
						<wtc:array id="arrSp12" start="12" length="1" scope="end"/>
						<wtc:array id="arrSp13" start="13" length="1" scope="end"/>
						<%
						if( !spRc.equals("000000") )
						{
						%>
							<script>
								rdShowMessageDialog("<%=spRc%>:<%=spRm%>");
								removeCurrentTab();	
							</script>
						<%
						}			
						else
						{
							for ( int i=0;i<arrSp8.length;i++ )
							{
								if (arrSp8[i][0].equals("199")
									||arrSp8[i][0].equals("105")
									||arrSp8[i][0].equals("104")
									||arrSp8[i][0].equals("103")  )
								{
									String rdoChk="checked";
									if (arrSp8[i][0].equals("199")  )
									{
										rdoChk=" ";
									}
								
								%>
								<tr>
									<td><%=arrSp9[i][0]%> </td>	
									<td>			
										<input type='radio'  name="f<%=arrSp8 [i][0]%>" value='0'
											spOCCode='<%=arrSp8[i][0]%>'disabled >�� &nbsp
										<input type='radio'   name="f<%=arrSp8 [i][0]%>" value='1'
											spOCCode='<%=arrSp8[i][0]%>' <%=rdoChk%>  disabled >��
									</td>
								</tr>
								<%
								}
								else
								{
								%>
								<tr style='display:none'>
									<td><%=arrSp9[i][0]%> </td>	
									<td>
										<input type='radio'  name="f<%=arrSp8 [i][0]%>" value='0'
											spOCCode='<%=arrSp8[i][0]%>' >�� &nbsp
										<input type='radio'   name="f<%=arrSp8 [i][0]%>" value='1'
											spOCCode='<%=arrSp8[i][0]%>' >��
									</td>
								</tr>								
								<%
								}

							}							
						}			
						%>	
						</td>
						</table>
					</tr>
					<tr>		
						<th>�������</th>
						<td colspan='3'><input type='text' id='iPayAmount' name='iPayAmount'></td>
						</td>	
					</tr>				
				</table>
				<table>
					<tr>
						<td  id="footer">
							<input class="b_foot" type="button" name=cfmBtn value="ȷ��"
								onClick="doCfm();">
							<input class="b_foot" type="button" name=rstBtn value="����"
								onClick="doRst();">
							<input class="b_foot" type="button" name=clsBtn value="�ر�"
								onClick="removeCurrentTab();">								
						</td>
					</tr>
				</table>
					
				<wtc:service name="sWlanQry" outnum="43" 
					routerKey="region" routerValue="<%=regCode%>"  
					retcode="wqRc" retmsg="wqRm">
					<wtc:param value="<%=workNo%>"/>
					<wtc:param value="<%=orgCode%>"/>
					<wtc:param value="<%=passwd%>"/>
					<wtc:param value="<%=ipAddr%>"/>
					<wtc:param value="1984"/>
					<wtc:param value="<%=cldPhoneNo%>"/>
				</wtc:service>		
				<wtc:array id="rstWlanQry" scope="end"/>	
				<%
				if (wqRc.equals("000000"))
				{
					if (rstWlanQry.length==0)
					{
						%>
							<script>
								rdShowMessageDialog("���񷵻س���:rstWlanQry.length=0");	
								removeCurrentTab();
							</script>
						<%					
					}
					else
					{
						if (rstWlanQry[0][0].equals("Y"))
						{
							%>
							<%@ include file="/npage/include/footer.jsp" %>
							<%						
						}
					}
				}
				else
				{
				%>
					<script>
						rdShowMessageDialog("<%=wqRc%>:<%=wqRm%>");	
						removeCurrentTab();
					</script>
				<%
				}
				%>						
			</div>
		</form>
	</body>
	<script type="text/javascript">
		function printInfo(printType)
		{    
			/*�ͻ���Ϣ*/
			var cust_info="�ֻ����룺"+document.all.cldPhoneNo.value
				+"|�ͻ�������"+document.all.cldName.value+"|";
			/*ҵ����Ϣ*/
			var opr_info="����ҵ�� ��ͯ�ײ�����";
			opr_info+="�û�Ʒ�ƣ�"+document.all.cldSmName.value+"|";
			opr_info+="������ˮ��"+document.all.loginAccept.value
				+"     ҵ�����ʱ�䣺"+"<%=createTime2%>"+"|";
			opr_info+="�ҳ����룺"+document.all.pPhoneNo.value
				+"     �ҳ�������"+document.all.pName.value+"|";				
		
			var strWlan="";
			if ( document.all.wFlag.value!="0" )
			{
				strWlan=",WLAN";
			}
			opr_info+="�ر�ҵ�� ��"+document.all.prtProd.value+"SP������,����,WAP��"+strWlan+"|";
			opr_info+="�ҳ�֧�����ö�ȣ�"+document.all.iPayAmount.value+"|";
			opr_info+="�ʷ�������"+document.all.odOfCmt.value+"|";
			/*��ע��Ϣ*/
			var note_info1="";
			var note_info2="ע������ҳ�ÿ�����ͯ�˻��������ã��ҳ��ֽ����Ԥ���С�ڻ������ã���������|";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		    return retInfo;
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
				+"&phoneNo=<%=cldPhoneNo%>&submitCfm=" + submitCfm
				+"&pType="+pType+"&billType="+billType
				+ "&printInfo=" + printStr;

			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}			
		
		/*��ʾ�ҳ���Ϣ*/
		function showPifo(obj)
		{
			
			if("true" == "<%=pwrf%>")
			{
				document.frm.pPwd.disabled=true;
			}				
			
			document.all.pIfo.style.display='block';
			document.all.odOfid.value=obj.value;
			document.all.odOfCmt.value=obj.ofCmt;
			document.all.offerRdo.disabled=true;
			/*ƴԭ��*/
			var iSpOldOC="";
			<%
			for(int i=0; i<arrSp12.length; i++)
			{
			%>
				if ("<%=arrSp12[i][0]%>" == "1")
				{
					iSpOldOC=iSpOldOC+"0|";
				} 
				if ("<%=arrSp13[i][0]%>" == "1")
				{
					iSpOldOC=iSpOldOC+"1|";
				}
			<%
			}
			%>
			document.all.iSpOldOC.value=iSpOldOC;
			
			<%
			for(int i=0; i<arrSp12.length; i++){%>
				if ("<%=arrSp12[i][0]%>" == "1"){
					if ("<%=arrSp8[i][0]%>" != "105" 
						&&"<%=arrSp8[i][0]%>" != "104" 
						&&"<%=arrSp8[i][0]%>" != "103"  )
					{
						for(var i=0; i< document.frm.f<%=arrSp8 [i][0]%>.length; i++){
						if (document.frm.f<%=arrSp8 [i][0]%>[i].value == "0")
							document.frm.f<%=arrSp8 [i][0]%>[i].checked = true;
						}
					}

				}
				if ("<%=arrSp13[i][0]%>" == "1"){
					if ("<%=arrSp8[i][0]%>" != "105" 
						&&"<%=arrSp8[i][0]%>" != "104" 
						&&"<%=arrSp8[i][0]%>" != "103"  )
					{
						for(var i=0; i< document.frm.f<%=arrSp8 [i][0]%>.length; i++){
							if (document.frm.f<%=arrSp8 [i][0]%>[i].value == "1")
								document.frm.f<%=arrSp8 [i][0]%>[i].checked = true;
						}
					}
				}
		    <%}%>			
		}
		
		function getWInfo(packet)		
		{
			var wFlag=packet.data.findValueByName("wlanRst");
			document.all.wFlag.value=wFlag;
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
			if( !forPhone(document.all.pPhone)  )
			{
				return false;	
			}
			
			
			if ( document.all.odOfid.value.trim()=="" )
			{
				rdShowMessageDialog("��ͯ�ײ��ʷѱ���ѡ��!",0);
				return false;
			}
			
			/*�������*/
			if (   document.all.iPayAmount.value.trim()=="")
			{
				rdShowMessageDialog("������������д!",0);
				return false;					
			}
			
			if ( parseFloat( document.all.iPayAmount.value.trim(),2)>100 )
			{
				rdShowMessageDialog("����������С�ڵ���100Ԫ!",0);
				return false;				
			}			
			
			if(!forMoney(document.all.iPayAmount)){
			 			 return false;
			}	
						
			if("false" == "<%=pwrf%>")
			{
				/*������*/
				if(document.frm.pPwd.value.trim() == "")
				{
					rdShowMessageDialog("�ҳ��û������������",0);
					return false;
				}
				checkUserPwd(document.frm.pPhoneNo.value,document.frm.pPwd.value );
			}	
			
			if(pwdIsRight != "1" &&  "true" == "<%=pwrf%>"  ){
				return false;
			}
			
			/*�ط���Ϣ*/
			var objPrdIfo=document.all.prodIfo;
			var iProductStr="";
			var prtProd="";
			if ( typeof ( objPrdIfo.length )!="undefined" )
			{
				for ( var i=0;i<objPrdIfo.length;i++ )
				{
					if ( objPrdIfo[i].checked==true )
					{
						iProductStr+=objPrdIfo[i].value+"|";
						prtProd+=objPrdIfo[i].prodName+",";
					}	
				}
			}	
			else
			{
				if ( objPrdIfo.checked==true )
				{				
					iProductStr+=objPrdIfo.value+"|";
				}
			}
			
			if ( iProductStr=="" )
			{
				iProductStr="|";
			}

			document.all.iProductStr.value=iProductStr;			
			document.all.prtProd.value=prtProd;			
			
			/*sp��Ϣ*/
			var iSpNewOC="";
			var iSpOCCode="";
			<%
			for(int i=0; i<arrSp8.length; i++)
			{
			%>
				for ( var j=0;j<document.frm.f<%=arrSp8[i][0]%>.length;j++ )
				{
					if (document.frm.f<%=arrSp8[i][0]%>[j].checked==true)
					{
						iSpNewOC+=document.frm.f<%=arrSp8[i][0]%>[j].value+"|";
						iSpOCCode+=document.frm.f<%=arrSp8[i][0]%>[j].spOCCode+"|";
					}
				}
			<%
			}
			%>

			document.all.iSpNewOC.value=iSpNewOC;
			document.all.iSpOCCode.value=iSpOCCode;
			
			/**/
			document.all.cfmBtn.disabled=true;
	
			/*���ͯ�û���Ϣ*/
			var pPacket = new AJAXPacket("../public/pubGetUserBaseInfo.jsp"
				,"���Ժ�...");
			/*��ajaxҳ�洫�ݲ���*/
			pPacket.data.add("phoneNo",document.all.pPhoneNo.value );
			pPacket.data.add("opCode","<%=opCode%>" );
			
			/*����ҳ��,��ָ���ص�����*/
			core.ajax.sendPacket(pPacket,getPInfo,false);
			pPacket=null;		
			
			/*���ͯ�û���Ϣ*/
			var cPacket = new AJAXPacket("../public/pubGetUserBaseInfo.jsp"
				,"���Ժ�...");
			/*��ajaxҳ�洫�ݲ���*/
			cPacket.data.add("phoneNo",document.all.cldPhoneNo.value );
			cPacket.data.add("opCode","<%=opCode%>" );
			
			/*����ҳ��,��ָ���ص�����*/
			core.ajax.sendPacket(cPacket,getCInfo,false);
			cPacket=null;					
			
			/*��wlan��Ϣ*/
			var wPacket = new AJAXPacket("fE889OpenAjax.jsp"
				,"���Ժ�...");
			/*��ajaxҳ�洫�ݲ���*/
			wPacket.data.add("ajaxType","getWlanInfo" );
			wPacket.data.add("cldPhone",document.all.cldPhoneNo.value );
			wPacket.data.add("opCode","<%=opCode%>" );
			
			/*����ҳ��,��ָ���ص�����*/
			core.ajax.sendPacket(wPacket,getWInfo,false);
			wPacket=null;	
						
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
		
		function conf()
		{
			document.frm.action='fE889Cfm.jsp';
			document.frm.submit();
		}
		
		/*У���û�����*/
		function checkUserPwd(phoneNo,custPwd)
		{
			var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("custType", "01");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo", phoneNo);		//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd", custPwd);//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType", "");							//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum", "");							//����
			checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//����
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
		}
		
		function doCheckPwd(packet) 
		{
			var retResult = packet.data.findValueByName("retResult");
			var msg = packet.data.findValueByName("msg");
			if (retResult != "000000") 
			{
				pwdIsRight = "0";
				rdShowMessageDialog(msg);
				return false;
			}
			
			else
			{
				pwdIsRight = "1";
			}
		}		
		
		/*����*/	
		function doRst()
		{
			hiddenTip(document.frm);
			window.location = 'fE889Open.jsp?opCode=<%=opCode%>&opName=<%=opName%>&cldPhoneNo=<%=cldPhoneNo%>';
		}
		

		var pwdIsRight = "0";
		/*����������*/
		function nextStep()
		{
			if ( !(checkElement( document.frm.cldPhoneNo )) )
			{
				return false;
			}		
			
			if("false" == "<%=pwrf%>")
			{
				/*������*/
				if(document.frm.cldPwd.value.trim() == "")
				{
					rdShowMessageDialog("��ͯ�û����������������",0);
					return false;
				}
				checkUserPwd(document.frm.cldPhoneNo.value,document.frm.cldPwd.value );
			}	
			else
			{
				var opCode=document.all.opCode.value;
				var opName=document.all.opName.value;
				
				document.frm.action="fE889Open.jsp?opCode="+opCode+"&opName="+opName;
				document.frm.submit();			
			}
			

		}

	</script>
</html>
