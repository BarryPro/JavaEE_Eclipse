<%
  /*
   * ����:MIS-POSͳһ����-��ѯ
   * �汾: 1.0
   * ����: 20121010
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<!--���ع��пؼ� -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		String orgCode =(String)session.getAttribute("orgCode");
    String regionCode = (String)session.getAttribute("regCode");
    String sWorkNo = (String)session.getAttribute("workNo");
 		String dNopass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("phoneNo");
		//��ˮ��
 		String iLoginAccept = getMaxAccept();
 		//��ʵip
 		String serverIp=realip.trim();
 		//��ѯ�ͻ���Ϣsql
 		String custName="";
		String custSql = "select doc.cust_name from dcustdoc doc,dcustmsg msg where doc.cust_id = msg.cust_id and msg.phone_no='"+phoneNo+"'";
		
    String ip = (String)session.getAttribute("ipAddr");
 		String ssss = "ͨ��phoneNo[" + phoneNo + "]��ѯ";
%>
<wtc:service name="sUserCustInfo" outnum="40" >
      <wtc:param value="<%=iLoginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=sWorkNo%>"/>
      <wtc:param value="<%=dNopass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ip%>"/>
      <wtc:param value="<%=ssss%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>

  <wtc:array id="result11" scope="end" />


<!--����fusk��ѯ����  MIS-POSͳһ���� gaopeng 20121012-->
<wtc:service name="sg175Init" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode1" retmsg="errMsg1"  outnum="16">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="01" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=sWorkNo%>" />
		<wtc:param value="<%=dNopass%>" />
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="" />
	</wtc:service>
<wtc:array id="result1" scope="end" />
		
<!--����xiaoliang��ѯ����  MIS-POSͳһ���� gaopeng 20121012-->
<wtc:service name="getBankPosInf" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode2" retmsg="errMsg2"  outnum="8">		
		<wtc:param value="<%=phoneNo%>" />	
	</wtc:service>
<wtc:array id="result2" scope="end" />

<%
		if(result11.length <= 0)
		{
%>
<script language="JavaScript">
			rdShowMessageDialog("���û����������û���״̬��������");
			removeCurrentTab();
</script>
<%
			return ;
		}
		else
		{
			custName=result11[0][5];
			
		}
%>


<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
			
		});
		function doSubmit()
		{
			if(check(f1))
			{
				var sG175 = $("input[name='sG175']:checked").val();
				if(typeof(sG175)=="undefined")
				{
					rdShowMessageDialog("��ѡ����Ҫ������ҵ��",1);
				}
				else
					{
						var sFlag="";
						var sG175Arr = sG175.split("|");
						//�����CRM����
						if(sG175Arr[2]=="0")
						{
							$("input[name='iOldAccept']").val(sG175Arr[0]);
							$("input[name='iRrn']").val(sG175Arr[1]);
							$("input[name='iOpNote']").val("MIS-POSͳһ����");
							//�������ICBCCommon���г���
							//ԭҵ����ˮ|ԭ����ϵͳ������|��־λ|Ӧ�˽��|ԭ��������(�ύ����)|���ڸ�������|ԭ�����ն˺�|ԭ��������(�ύ����)
							var transType     = "04";																	 /*�������� ����Ϊ����*/         
							var bMoney        = sG175Arr[3];          							 /*���׽�� ������Ӧ�˽��*/
							if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";  
							var response_time = ""+sG175Arr[4];                 					 /*ԭ�������� */			
							var rrn           = sG175Arr[1];                           /*ԭ����ϵͳ������ */ 
							var instNum       = sG175Arr[5];                           /*���ڸ������� */  
							var terminalId    = sG175Arr[6];                           /*ԭ�����ն˺� */
							getSysDate();
							var request_time  = document.all.Request_Time.value;     	 /*�����ύ����  */ 
							var workno        = "<%=sWorkNo%>";                        /*���ײ���Ա */ 
							var orgCode       = "<%=orgCode%>";                        /*ӪҵԱ���� */ 
							var groupId       = "<%=groupID%>";                        /*ӪҵԱ�������� */ 
							var phoneNo       = "<%=phoneNo%>";                        /*���׽ɷѺ� */ 
							var toBeUpdate    = "";						                         /*Ԥ���ֶ� */         
							var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
										
								if(icbcTran=="succ")
								{
									f1.action="/npage/sg175/fg175Cfm.jsp";
									f1.submit();
								}		
							
						}
						//����ǼƷѳ���
						else if(sG175Arr[2]=="1")
							{
								$("input[name='iOldAccept']").val(sG175Arr[0]);
							//�������ICBCCommon���г���
							//ԭҵ����ˮ|ԭ����ϵͳ������|��־λ|Ӧ�˽��|ԭ��������(�ύ����)|���ڸ�������|ԭ�����ն˺�|ԭ��������(�ύ����)
							var transType     = "04";																	 /*�������� ����Ϊ����*/         
							var bMoney        = sG175Arr[3];          							 /*���׽�� ������Ӧ�˽��*/
							if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";  
							var response_time = ""+sG175Arr[4];                 					 /*ԭ�������� */			
							var rrn           = sG175Arr[1];                           /*ԭ����ϵͳ������ */ 
							var instNum       = sG175Arr[5];                           /*���ڸ������� */  
							var terminalId    = sG175Arr[6];                           /*ԭ�����ն˺� */
							getSysDate();
							var request_time  = document.all.Request_Time.value;     	 /*�����ύ����  */ 
							var workno        = "<%=sWorkNo%>";                        /*���ײ���Ա */ 
							var orgCode       = "<%=orgCode%>";                        /*ӪҵԱ���� */ 
							var groupId       = "<%=groupID%>";                        /*ӪҵԱ�������� */ 
							var phoneNo       = "<%=phoneNo%>";                        /*���׽ɷѺ� */ 
							var toBeUpdate    = "";						                         /*Ԥ���ֶ� */         
							var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);		
								if(icbcTran=="succ")
								{
								f1.action="/npage/sg175/fg175Cfm2.jsp";
								f1.submit();
								}
							}
					}
				
			}
			
		}
	
	function getSysDate()
		{
			var myPacket = new AJAXPacket("/npage/s1300/s1300_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
			myPacket.data.add("verifyType","getSysDate");
			core.ajax.sendPacket(myPacket);
			myPacket = null;
		
		}
		function doProcess(packet)
     	{
					var verifyType = packet.data.findValueByName("verifyType");
					var sysDate = packet.data.findValueByName("sysDate");
					if(verifyType=="getSysDate"){
						//��Чʱ��
						document.all.Request_Time.value = sysDate;
						return false;
					}
     	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>
	<table>
		<tr>
			<td class="blue" >�ͻ�����</td>
			<td ><%=custName%></td>
			<td class="blue" >�ֻ�����</td>
			<td ><%=phoneNo%></td>
		</tr>
	</table>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table>
		<th></th>
		<th>�ɷ�����</th>
		<th>��������</th>
		<th>ҵ������</th>
		<th>Ӧ�˽��</th>
		<th>�����к�</th>
		<th>��������</th>
		<th>����ʱ��</th>
		<th>���ڸ�������</th>
		<th>������ˮ</th>
		<%              
		if("0".equals(errCode1) || "000000".equals(errCode1))
		{
            		for(int i=0;i<result1.length;i++){
     %>
		<tr>
			<td width="5%"><input name="sG175" type="radio" value="<%=result1[i][0]%>|<%=result1[i][10]%>|0|<%=result1[i][3]%>|<%=result1[i][11]%>|<%=result1[i][6]%>|<%=result1[i][9]%>|<%=result1[i][11]%>" /></td>
			<td width="10%">
				
				<%
				if(result1[i][2]=="BY" || "BY".equals(result1[i][2])){
				%>
				��������
				<%
				}
			else if(result1[i][2]=="BX" || "BX".equals(result1[i][2])){
				%>
				��������
				<%
				}
			else if(result1[i][2]=="EI" || "EI".equals(result1[i][2])){
				%>
				�������з��ڸ���
				<%
				}
				%>
				</td>
			<td width="10%"><%=result1[i][1]%></td>
			<td width="10%"><%=result1[i][13]%></td>
			<td width="10%"><%=result1[i][3]%></td>
			<td width="15%"><%=result1[i][5]%></td>
			<td width="10%"><%=result1[i][4]%></td>
			<td width="10%"><%=result1[i][7]%></td>
			<td width="10%"><%=result1[i][6]%></td>
			<td width="10%"><%=result1[i][0]%></td>
		</tr>
		<%
		}
		}
	else{
		%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=errCode1%>��������Ϣ��<%=errMsg1%>");
				removeCurrentTab();
		</script>

		<%
		}
		%>
		
		
		<%              
		if("0".equals(errCode2) || "000000".equals(errCode2) || "123403".equals(errCode2))
		{
            		for(int i=0;i<result2.length;i++){
     %>
		<tr>
			<td algin="center"><input name="sG175" type="radio" value="<%=result2[i][6]%>||1" /></td>
			<td>
				<%
				if(result2[i][7]=="BY" || "BY".equals(result2[i][7])){
				%>
				��������
				<%
				}
			else if(result2[i][7]=="BX" || "BX".equals(result2[i][7])){
				%>
				��������
				<%
				}
				%>
				</td>
			<td><%=result2[i][0]%></td>
			<td><%=result2[i][1]%></td>
			<td><%=result2[i][2]%></td>
			<td><%=result2[i][3]%></td>
			<td><%=result2[i][4]%></td>
			<td><%=result2[i][5]%></td>
			<td>0</td>
			<td><%=result2[i][6]%></td>
		</tr>
		<%
		}
		}
	else{
		%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=errCode2%>��������Ϣ��<%=errMsg2%>");
				removeCurrentTab();
			</script>

		<%
		}
		%>
	</table>
	
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<input type="button" class="b_foot" value="ȷ��" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<!--��������-->
	<input type="hidden" name="iOpCode" value="<%=opCode%>"/>
	<!--������-->
	<input type="hidden" name="iOpName" value="<%=opName%>"/>
	<!--����-->
	<input type="hidden" name="iLoginNo" value="<%=sWorkNo%>"/>
	<!--��������-->
	<input type="hidden" name="iLoginPwd" value="<%=dNopass%>"/>
	<!--�ֻ���-->
	<input type="hidden" name="iPhoneNo" value="<%=phoneNo%>"/>
	<!--�û�����-->
	<input type="hidden" name="iUserPwd" value=""/>
	<!--������ע-->
	<input type="hidden" name="iOpNote" value=""/>
	<!--ԭҵ����ˮ-->
	<input type="hidden" name="iOldAccept" value=""/>
	<!--ԭ����ϵͳ������-->
	<input type="hidden" name="iRrn" value=""/>
	<!--ip-->
	<input type="hidden" name="inIpAddr" value="<%=serverIp%>"/>
	<!--orgCode-->
	<input type="hidden" name="iOrgCode" value="<%=orgCode%>"/>
	<input type="hidden" name="Request_Time" value=""/>
	
	
			<input type="hidden" name="MerchantNameChs"  value=""><!-- �Ӵ˿�ʼ����Ϊ���в��� -->
			<input type="hidden" name="MerchantId"  value="">
			<input type="hidden" name="TerminalId"  value="">
			<input type="hidden" name="IssCode"  value="">
			<input type="hidden" name="AcqCode"  value="">
			<input type="hidden" name="CardNo"  value="">
			<input type="hidden" name="BatchNo"  value="">
			<input type="hidden" name="Response_time"  value="">
			<input type="hidden" name="Rrn"  value="">
			<input type="hidden" name="AuthNo"  value="">
			<input type="hidden" name="TraceNo"  value="">
			<input type="hidden" name="Request_time"  value="">
			<input type="hidden" name="CardNoPingBi"  value="">
			<input type="hidden" name="ExpDate"  value="">
			<input type="hidden" name="Remak"  value="">
			<input type="hidden" name="TC"  value="">
			<input type="hidden" id="transTotal" name="transTotal"  value="">
			
	<%@ include file="/npage/include/footer.jsp" %>	
</form>
</body>


</html>