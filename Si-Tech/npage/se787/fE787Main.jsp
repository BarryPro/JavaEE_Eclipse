<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%
String regCode	=(String)session.getAttribute("regCode");
String opCode="e787";
String opName="�籣ͨҵ��ͨ";

String phoneNo=request.getParameter("activePhone");

/*��ȡϵͳʱ��*/
java.util.Date sysdate = new java.util.Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
SimpleDateFormat sf1 = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat sf2 = new SimpleDateFormat("yyyyMMddHHmmss");
String opTimeD = sf1.format(sysdate);
String opTimeS = sf.format(sysdate);
String opTimeS1= sf2.format(sysdate);

/*������ˮ*/
String printAccept=getMaxAccept();
%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>e787.�籣ͨҵ��ͨ</title>
		<script src="/npage/public/json2.js" type="text/javascript"></script>
		<script src="socialInsurance.js" type="text/javascript"></script>
		<script>
			/*�������ֻ����벻��Ϊ��*/
			function doCfm()
			{
			
				/*У�����֤����Ϊ��*/
				if ($("#orderIdIccId").val()=="")
				{
					rdShowMessageDialog("������д���������֤����!",0);	
					return false;
				}
				
				/*У�����֤�Ƿ�Ϸ�*/
				if(!forIdCard(document.getElementById("orderIdIccId")))
				{
   					return false;
				}		
				
				/*У��IMEI		*/	
				if ($("#orderImei").val()=="")
				{
					rdShowMessageDialog("������дIMEI��!",0);	
					return false;
				}	
					
				if( document.getElementById("orderImei").value.len()!=15)
				{
					rdShowMessageDialog("IMEI�����15λ!",0);	
					return false;					
				}				

				if (!forInt(document.getElementById("orderImei")))
				{
					return false;					
				}	

				if ($("#cfmCode").val()=="2")
				{
					rdShowMessageDialog("IMEI�����У��ͨ��!",0);	
					return false;					
				}
				else if ($("#cfmCode").val()=="3")
				{
					rdShowMessageDialog("������Ϣ����У��ͨ��!",0);	
					return false;	
				}
				
				var tabBd=document.getElementById("tabBindInfo");
				if (tabBd.rows.length==1)
				{
					rdShowMessageDialog("������Ϣ������д" , 0);
					return false;
				}
				/*�ύƴJSON��*/	
				
				 //var =document.getElementById("tabBindInfo").rows[1].cells[1].children[0].value;
				var siList1= new siList();
				
				/*������Ϣ*/

				
				/*ѭ����Ӱ�����Ϣ*/			
				var strIdIcd="";
				var strNId="";
				var strName="";
				for ( var i=1; i<tabBd.rows.length; i++ )
				{
					if (tabBd.rows[i].cells[0].children[0].value.trim()=="")
					{
						rdShowMessageDialog("�������֤�Ų���Ϊ��!");
						return false;
					}
					
					if (tabBd.rows[i].cells[1].children[0].value.trim()=="")
					{
						rdShowMessageDialog("���˰����籣��Ų���Ϊ��!");
						return false;
					}
									
					var bdInfo=new bind();
					
					bdInfo.setGid(tabBd.rows[i].cells[0].children[0].value);
					bdInfo.setNid(tabBd.rows[i].cells[1].children[0].value);
					bdInfo.setName(tabBd.rows[i].cells[2].children[0].value);
					
					strIdIcd+=tabBd.rows[i].cells[0].children[0].value+"|";
					strNId+=tabBd.rows[i].cells[1].children[0].value+"|";
					strName+=tabBd.rows[i].cells[2].children[0].value+"|";
					
					siList1.setBind(bdInfo);	
				}
				
				var bsInfo=new base();
				bsInfo.setMobile($("#orderPhoneNo").val());
				bsInfo.setBgid($("#orderIdIccId").val());
				bsInfo.setBname($("#orderCustName").val());
				bsInfo.setDeviceId($("#orderImei").val());
				bsInfo.setMobile($("#orderPhoneNo").val());
				bsInfo.setAddr($("#orderAddr").val());	
				
				/*�ѻ�����Ϣ��ӵ��籣��Ϣ��*/
				siList1.setBase(bsInfo);				
				document.all.hdGId.value=strIdIcd;
				document.all.hdNId.value=strNId;
				document.all.hdGName.value=strName;

				/*�籣����ת��ΪJSON��*/
				var jsonSclIsc = JSON.stringify(siList1,function(key,value){
					return value;
				});		
				$("#jsonSI").val(jsonSclIsc);
				/*ת���ύҳ��*/

			 	//��ӡ�������ύ��
				var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
				if(typeof(ret)!="undefined")
				{ 
					if((ret=="confirm"))
					{
						if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
						{
							document.frmE787.action="fE787Cfm.jsp";
							document.frmE787.submit();
						}
					}
					if(ret=="continueSub")
					{
						if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
						{
							document.frmE787.action="fE787Cfm.jsp";
							document.frmE787.submit();
						}
					}
				}
				else
				{
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
					{
						document.frmE787.action="fE787Cfm.jsp";
						document.frmE787.submit();
					}
				}
			  	return true;				
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
				var sysAccept = document.all.printAccept.value;
				var printStr = printInfo(printType);
			
				var mode_code=null;
				var fav_code=null;
				var area_code=null
			
				var prop="dialogHeight:"+h+"px; "
					+"dialogWidth:"+w+"px; "
					+"dialogLeft:"+l+"px; "
					+"dialogTop:"+t+"px;"
					+"toolbar:no; menubar:no; scrollbars:yes; "
					+"resizable:no;location:no;status:no;help:no";
				var path = "<%=request.getContextPath()%>"
					+"/npage/innet/hljBillPrint_jc.jsp?DlgMsg="+DlgMessage;
				var path = path  + "&mode_code="+mode_code
					+"&fav_code="+fav_code+"&area_code="+area_code
					+"&opCode=<%=opCode%>&sysAccept="+sysAccept
					+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm
					+"&pType="+pType+"&billType="+billType
					+ "&printInfo=" + printStr;
				var ret=window.showModalDialog(path,printStr,prop);
				return ret;
			}
			
			/*ƴ�������*/
			function printInfo(printType)
			{    
				/*�ͻ���Ϣ*/
				var cust_info="";
				cust_info+= "�ֻ����룺     "
					+document.all.orderPhoneNo.value+"|";
				cust_info+= "�ͻ�������     "
					+document.all.orderCustName.value
					+"    ֤�����룺     "
					+document.all.orderIdIccId.value+"|";
				cust_info+= "|";
				
				/*ҵ����Ϣ*/
				var opr_info="";
				opr_info+="����ҵ���籣ͨҵ�񿪻�"+"|";
				opr_info+="ҵ���ʷѣ�"
					+document.getElementById("orderOfferName").value+"|";
				opr_info+="������ţ�"+"<%=printAccept%>"+"|";
				opr_info+="ҵ����Чʱ�䣺"+"<%=opTimeD%>"+"|";
				
				var note_info1="";
				var note_info2="	��ӭʹ���й��ƶ��籣ͨҵ��"
					+"�����κ������������Ŀͻ�������ϵ��";
				var note_info3="";
				var note_info4="";
				
				/*ƴװ�����Ϣ*/
				var retInfo = "";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";    
				retInfo+=" "+"|";	
				retInfo+=" "+"|";
					
				note_info1 =retInfo;
				
				retInfo = cust_info+"#"
					+opr_info+"#"
					+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			    return retInfo;
			}		
			
			/*������Ϣ*/
			function addBindInfo()
			{
				/*����У���Ѱ�������*/
				var tab_len=$("#tabBindInfo").find("tr").length;

				$("#cfmCode").val("3");
				if (tab_len>2)
				{
					rdShowMessageDialog("�����������ܴ�������!",0);
					return false;
				}
				
				var bindCode=parseInt( $("#bindCode").val() , 10)+1;
				$("#bindCode").val(bindCode);
				$("#tabBindInfo").append("<tr>"
				+"<td align='center'>"
					+"<input type='text' id='bandIdIccId"+bindCode+"' "
						+"name='bandIdIccId' value='' "
						+"size='18' maxlength='20' "
						+"  onblur='getBindInfo("+bindCode+" , this)'  >"
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' id='bandNId"+bindCode+"' "
						+"name='bandNId' value='' "
						+"size='20'  maxlength='15'"
						+" onblur='getBindInfo("+bindCode+" , this)' >"
				+"</td align='center'>"
				+"<td align='center'>"
					+"<input type='text' id='bandName"+bindCode+"' "
						+"name='bandName' value='' "
						+" maxlength='18' size='20'>"
				+"</td>"	
				+"<td align='center'>"
					+"<input type='button' onclick='delBindInfo( this )'   "
						+"name='bandName' value='ɾ��' class='b_text'>"
				+"</td>"														
				+"</tr>"
				);
			}
	
			function delBindInfo(k)
			{
				$(k).parent().parent().remove(); 
			}
			
			/*��ȡ������Ϣ*/
			function getBindInfo(i , obj)
			{
				document.all.hdChkId.value=obj.id;
				if ($("#bandIdIccId"+i).val()==""
					 && $("#bandNId"+i).val()=="" )
				{
					rdShowMessageDialog("���֤�ź��籣���������дһ��!",0);
					return false;
				}	
				/*У�����֤�Ƿ�Ϸ�*/
				if ( document.getElementById("bandIdIccId"+i).value.trim().len()!=0 )
				{
					if(!forIdCard(document.getElementById("bandIdIccId"+i)))
					{
	   					return false;
					}					
				}
				
				/*У�����֤�Ƿ�Ϸ�*/
				if ( document.getElementById("bandNId"+i).value.trim().len()!=0 )
				{
					if ( document.getElementById("bandNId"+i).value.trim().len()!=10 )
					{
						rdShowMessageDialog("�籣�������10λ!",0);
						return false;
					}
					else
					{
						if(!forInt(document.getElementById("bandNId"+i)))
						{
		   					return false;
						}
					}					
				}
						
					
				var addBind = new bind();
				
				addBind.setGid($("#bandIdIccId"+i).val());
				addBind.setNid($("#bandNId"+i).val());
				addBind.setName($("#bandName"+i).val());
				
				/*ƴjson��*/
				var jsonBind = JSON.stringify(addBind,function(key,value){
					return value;
				});
				
				$("#bandIdIccId"+i).attr("disabled" , "disabled");
				$("#bandNId"+i).attr("disabled" , "disabled");
				$("#bandName"+i).attr("disabled" , "disabled");							
				
				var strBind="{bid:'"+obj.value+"'}";
				var packet = new AJAXPacket("fE787MainAjax.jsp"
					,"���Ժ�...");
				packet.data.add("jsonBind" ,strBind);
				packet.data.add("bindCode" ,i);
				packet.data.add("getType" ,"getBid");
				core.ajax.sendPacket(packet,setBindInfo,true);//�첽
				packet =null;
			}
			
			function setBindInfo(packet)
			{

				var	retCode=packet.data.findValueByName("retCode"); 
				var	retMsg=packet.data.findValueByName("retMsg"); 
				var	bindCode=packet.data.findValueByName("bindCode"); 

				if (retCode!="000000")
				{
					$("#bandIdIccId"+bindCode).attr("disabled" , "");
					$("#bandNId"+bindCode).attr("disabled" , "");
					$("#bandName"+bindCode).attr("disabled" , "");					
					
					rdShowMessageDialog(retCode+":"+retMsg , 0);
					return false;
				}
				else
				{
					/*��Ԫ�ظ�ֵ*/
					var	bindJson=packet.data.findValueByName("oBindJson"); 

					/*json����ת��*/
					var bindInfo=eval('('+bindJson+')'); 
					/*���ñ�ֵ*/
					$("#bandIdIccId"+bindCode).val(bindInfo.gid);
					$("#bandNId"+bindCode).val(bindInfo.nid);
					$("#bandName"+bindCode).val(bindInfo.name);
					
					/*��Ԫ���û�*/
					$("#bandIdIccId"+bindCode).attr("disabled" , "disabled");
					$("#bandNId"+bindCode).attr("disabled" , "disabled");
					$("#bandName"+bindCode).attr("disabled" , "disabled");
					$("#cfmCode").val("0");
				}
			}
		</script>
	</head>
	<body>
	<form name='frmE787' action='' method='POST'>
		
		<!--ȷ�ϱ�ʶ:
			0:ȫ��У��ͨ��,
			1:Ĭ������У�鶼��ͨ��.
			2:У��IMEI��ͨ��
			3:����У�鲻ͨ��-->
		<input type='hidden' id='cfmCode' value='1'>	
		
		<!--ȷ�ϱ�ʶ:0:ȫ��У��ͨ��,1:У�鲻ͨ��-->
		<input type='hidden' id='cfmMsg' value=''>	
		
		<!--��������-->
		<input type='hidden' name = 'opCode' id='opCode' value='<%=opCode%>'>				
		
		<!--��������-->
		<input type='hidden' id='opName' value='<%=opName%>'>		
		
		<!--��������-->
		<input type='hidden' name = 'bindCode' id='bindCode' value='0'>
		
		<!--�籣��ϢJSON��-->
		<input type="hidden" id = "jsonSI" name="jsonSI" value= "">
		
		<!--������Ϣjson��-->
		<input type="hidden" id = "jsonBind" name="jsonBind" value= "">		
		
		<!--�������֤-->
		<input type="hidden" id = "hdGId" name="hdGId" value= "">			
		<!--�����籣��-->
		<input type="hidden" id = "hdNId" name="hdNId" value= "">		
		<!--��������-->
		<input type="hidden" id = "hdGName" name="hdGName" value= "">		
		<input type="hidden" id = "hdChkId" name="hdChkId" value= "">		
					
		<!--������ˮ-->
		<input type="hidden" id = "printAccept" 
			name="printAccept" value= "<%=printAccept%>">	
						
		<!--����ʱ��-->
		<input type="hidden" id = "opTimeD" name="opTimeD" value= "<%=opTimeD%>">		
		<input type="hidden" id = "opTimeS" name="opTimeS" value= "<%=opTimeS%>">		
		<input type="hidden" id = "opTimeS1" name="opTimeS1" value= "<%=opTimeS1%>">		
		
		<!---->

		<div id="Operation_Title">
			<div class="icon"></div>
				<B><%=opCode%>.<%=opName%></B>
		</div>
		<!--��ѯ����-->
		<DIV id="Operation_Table">
			<div class="title">
				<div id="title_zi">��������Ϣ</div>
			</div>
			<table id="orderInfo">
				<tr>
					<th>�������ֻ�����</th>
					<td>
						<input	TYPE="TEXT" id='orderPhoneNo' name='orderPhoneNo'
							maxlength='15' size='20' value='<%=phoneNo%>' 
							class='InputGrey' readOnly >
						<font color='red'>*</font>
					</td>
					<%
					String sqlOrdCstNm="  SELECT T1.CUST_NAME	"
						+"    FROM DCUSTMSG T,	"
						+"         DCUSTDOC T1	"
						+"   WHERE T.CUST_ID = T1.CUST_ID	"
						+"     AND T.PHONE_NO = :phoneNo";
					
					String[] inParamsCN = new String[2];
					inParamsCN[0] = sqlOrdCstNm;
					inParamsCN[1] = "phoneNo=" + phoneNo;
					
					String work_no = WtcUtil.repNull((String)session.getAttribute("workNo"));
					String password = WtcUtil.repNull((String)session.getAttribute("password"));
					String userNote = "ͨ���ֻ�����[" + phoneNo + "]��ѯ";
					%>
					
					<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
  
          <wtc:service name="sUserCustInfo" outnum="40" >
              <wtc:param value="<%=loginAccept%>"/>
              <wtc:param value="01"/>
              <wtc:param value="<%=opCode%>"/>
              <wtc:param value="<%=work_no%>"/>
              <wtc:param value="<%=password%>"/>
              <wtc:param value="<%=phoneNo%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=userNote%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value=""/>
          </wtc:service>
					
					<wtc:array id="rstCN" scope="end" />
					  <%
					  //System.out.println(" zhouby fE787Main.jsp " + rstCN[0][5]);
					  %>
					<th>����������</th>
					<td>
						<input	TYPE="TEXT" id='orderCustName' name='orderCustName'
							maxlength='15' size='20' value='<%=rstCN[0][5]%>' 
							class='InputGrey' readOnly >
						<font color='red'>*</font>
					</td>	
				</tr>							
				<tr>
					<th>IMEI��</th>
					<td>
						<input	TYPE="TEXT" id='orderImei' name='orderImei'
							size='20' maxlength='15' >
						<font color='red'>*</font>
					</td>
					<th>�ʷ�</th>
					<td>
						<input type='hidden' id='orderOfferName' name='orderOfferName' 
							value='�籣ͨ10Ԫ����2M'>
						<select id='orderOfferId' name='orderOfferId'>
							<option value='37682'>37682-->�籣ͨ10Ԫ����2M</option>
						</select>
					</td>
				</tr>	
				<tr>
					<th>���������֤��</th>
					<td colspan='3'>
						<input	TYPE="TEXT" id='orderIdIccId' name='orderIdIccId' 
							maxlength='18' size='20'>
						<font color='red'>*</font>
					</td>
				</tr>					
				<tr>
					<th>�����˵�ַ</th>
					<td colspan='3'>
						<input	TYPE="TEXT" id='orderAddr' name='orderAddr'
							size='130' maxlength='120'>
					</td>
				</tr>							
			</table>
			<div class="title">
				<div id="title_zi">������Ϣ</div>
				<input	TYPE="button" id='bindImeiChk'
					class="b_text" value='����' onclick='addBindInfo()'>
			</div>			
			<table id="tabBindInfo">	
				<th align='center'>�������֤��</th>					
				<th align='center'>�����籣���</th>					
				<th align='center'>��������</th>								
				<th align='center'>����</th>								
			</table>			
			
			<!--������ť-->
			<table>
				<tr>
					<td  id="footer">
						<input type="button" id=cfmPage value="ȷ��"
							onClick="doCfm()" class="b_foot" >
						<input type="button" id=clsPage value="�ر�"
							onClick="window.close();" class="b_foot">						
					</td>
				</tr>
			</table>		
		</div>
	</form>
	</body>
</html>