<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
 /**
 *���ݲ�ѯ������ѯ�������ͻ�������������Ϣ��
 * #inputparam
 * #utype
 * -paramType       string       ����Ĳ������ͣ�������� 0 ,�ͻ�����ID 1 ,�ͻ���������ID  2  ,���񶨵�ID  3  ,���߳�����ˮ(���񶨵���ˮ)  4.
 * -paramValue      string       ����Ĳ���  
 * -loginNO         string       �������� 
 * -queryDate       string       ��ѯ������  ֻ�е��÷������ͳ�����ˮʱʹ��
 * #outputparam
 * #utype
 * -utype     # 2 �ͻ���Ϣ
 * --custOrderId    string       �ͻ�����ID
 * --custName       string       �ͻ�����
 * --custIccid      string       �ͻ�֤������
 
 * -utype    # 3 ������Ϣ��
 * --utype   #������Ϣ1*
 * ---custArrayId    string       �ͻ���������ID
 * ---custArrayName  string       �ͻ�������������
 * ---utype   #���񶨵���Ϣ��
 * ----utype   #���񶨵���Ϣ1
 * -----servOrderId    string       ���񶩵�����ID
 * -----actionName  string          ��������
 * -----service_no  string          �������
 */

	String idType = request.getParameter("idType");          //��ѯ����
	String condittionValue = request.getParameter("servno"); //����ֵ
	String modeFlag = request.getParameter("modeFlag"); //����ֵ
	String selFlag = request.getParameter("selFlag"); //����ֵ
	String searchDate = request.getParameter("searchDate") == null?"":(String)request.getParameter("searchDate");  //��ѯ����
	String workNo = (String) session.getAttribute("workNo"); //��½����
	
	//�ͻ���Ϣ
	String custOrderId = "";
	String custName = "";
	String custIccid = "";
	
	/*
	UType sendInfo  = new UType();  
	sendInfo.setUe("STRING", idType);
	sendInfo.setUe("STRING", condittionValue);
	sendInfo.setUe("STRING", workNo);
	sendInfo.setUe("STRING", searchDate);
	*/
%>
<wtc:utype name="sReveresQuery" id="retVal" scope="end" >
          <wtc:uparam value="<%= idType %>" type="String"/>      
          <wtc:uparam value="<%= condittionValue %>" type="String"/>      
          <wtc:uparam value="<%= workNo %>" type="String"/>      
          <wtc:uparam value="<%= searchDate %>" type="String"/>      
 </wtc:utype>
<%
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	System.out.println("retCode========================="+retCode);
	System.out.println("retMsg========================="+retMsg);
	if(retCode.equals("0"))
	{
	
		//�ͻ���Ϣ
		//custOrderId = retVal.getValue("2.0.0");
		//custName = retVal.getValue("2.0.1");
		//custIccid = retVal.getValue("2.0.2");
		int custArrayOrderSize = retVal.getSize("2");//������Ϣ������
		System.out.println("e890~~custArrayOrderSize========================="+custArrayOrderSize);
		
		StringBuffer logBuffer = new StringBuffer(80);
		WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
		
		System.out.println("mylog"+logBuffer.toString());



%>

<div id="Operation_Table">
 
 
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�ͻ������б�</div>
</div>

<table id="dataTable" cellspacing=0 >
	<tr>
		<th>ѡ��</th>
		<th>�ͻ���������ID</th>
		<th>��������</th>
		<th style="display:none">���񶨵�</th>
		<th style="display:none">��������</th>
		<th>�������</th>
		<th>�ͻ�����ID</th>
		<th>�ͻ�����</th>
		<th  style="display:none">�ͻ�֤������</th>
		
		<th>����ʱ��</th>
		<th>��������</th>
		<th>������ˮ</th>
		
		
	</tr>
<%
  String tempFlag = "";
	String custOrrayArrayId_new = "";
             String opCodeV1 ="";
	           String opCodeV2 = "";
	           String loginAccept = "";
	           String opNameV1 = "";
	           String opNameV2 = "";
	          /*** tianyang add for pos start ***/
	          String payType = "";
	          String Response_time = "";
						String TerminalId = "";
						String Rrn = "";
						String Request_time = "";
						String returnMoney = "";
						/*** tianyang add for pos end ***/
	           
	for(int i=0;i<custArrayOrderSize;i++){//�ͻ���������
	 
	 custOrrayArrayId_new = retVal.getValue("2."+i+".1.0.0");
	 
	 opCodeV1 = retVal.getValue("2."+i+".1.0.2.0.0.3");
	 opNameV1 = retVal.getValue("2."+i+".1.0.2.0.0.4");
	 opCodeV2 = retVal.getValue("2."+i+".1.0.2.0.0.5");
	 System.out.println(i+"-----e890---------------------opCodeV2--------------------"+opCodeV2);
	 System.out.println(i+"-----e890---------------------modeFlag--------------------"+modeFlag);
	 System.out.println(i+"-----e890---------------------selFlag---------------------"+selFlag);
	 
	 
	 
	if(selFlag.equals("0")){
	 if(opCodeV2!=null&&opCodeV2.equals(modeFlag)){
	 tempFlag = "1";
	 opNameV2 = retVal.getValue("2."+i+".1.0.2.0.0.6");
	 loginAccept = retVal.getValue("2."+i+".1.0.2.0.0.7");
	
	System.out.println("----------------------opCodeV1------------------"+opCodeV1);
	System.out.println("----------------------opNameV1------------------"+opNameV1);
	System.out.println("----------------------opCodeV2------------------"+opCodeV2);
	System.out.println("----------------------opNameV2------------------"+opNameV2);
	System.out.println("----------------------loginAccept---------------"+loginAccept);
	
	
	
	/*** tianyang add for pos start ***/
	 payType       = retVal.getValue("2."+i+".1.0.2.0.0.10");
	 Response_time = retVal.getValue("2."+i+".1.0.2.0.0.11");
	 TerminalId    = retVal.getValue("2."+i+".1.0.2.0.0.12");
	 Rrn           = retVal.getValue("2."+i+".1.0.2.0.0.13");
	 Request_time  = retVal.getValue("2."+i+".1.0.2.0.0.14");
	 returnMoney   = retVal.getValue("2."+i+".1.0.2.0.0.15");
	 System.out.println("--------------------------payType-----------------"+payType);
	 System.out.println("--------------------------Response_time-----------"+Response_time);
	 System.out.println("--------------------------TerminalId--------------"+TerminalId);
	 System.out.println("--------------------------Rrn---------------------"+Rrn);
	 System.out.println("--------------------------Request_time------------"+Request_time);
	 System.out.println("--------------------------returnMoney-------------"+returnMoney);
	 /*** tianyang add for pos end ***/
	
	
	
	
	
	String hiddenStr = retVal.getValue("2."+i+".1.0.0")+"|"+retVal.getValue("2."+i+".1.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.0")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.2")+"|"+retVal.getValue("2."+i+".0.0")+"|"+retVal.getValue("2."+i+".0.1")+"|"+retVal.getValue("2."+i+".0.2");
%>
				<tr style="cursor:pointer" onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')">
					<td><input type="radio" id="custOrderIds" vRowFlag="<%=i%>" value="<%=custOrrayArrayId_new%>"   v_servOrderId="<%=retVal.getValue("2."+i+".1.0.0")%>" onclick="sBindQuery(this,'<%=i%>')" name="custOrderIds"  disabled></td>
					<td><%=retVal.getValue("2."+i+".1.0.0")%></td>
					<td><%=retVal.getValue("2."+i+".1.0.1")%></td>
					<td style="display:none"><%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>
						
						<%System.out.println("11111111111====="+retVal.getValue("2."+i+".1.0.2.0.0.0"));%>
						
						<input id="servId_<%=i%>" name="servId_<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>" >
						</td>
					<td style="display:none"><%=retVal.getValue("2."+i+".1.0.2.0.0.1")%></td>
					<td><%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>
						<input type="hidden" id="phoneNoHv<%=i%>" name="phoneNoHv<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>">
						</td>
					<td><%=retVal.getValue("2."+i+".0.0")%></td>
					<td><%=retVal.getValue("2."+i+".0.1")%></td>
					<td  style="display:none"><%=retVal.getValue("2."+i+".0.2")%></td>
					
					<td> <%=retVal.getValue("2."+i+".1.0.2.0.0.8")%></td>
					<td> <%=retVal.getValue("2."+i+".1.0.2.0.0.9")%></td>
					<td><%=loginAccept%> </td>
					
					<td style="display:none"><input name="custAdd<%=i%>" id="custAdd<%=i%>" value="<%=retVal.getValue("2."+i+".0.3")%>"></td>
				 
					<td style="display:none"><input name="hiddenStrv<%=i%>" id="hiddenStrv<%=i%>" value="<%=hiddenStr%>"></td>
					<td style="display:none"><input name="opCode1Hv<%=i%>" id="opCode1Hv<%=i%>" value="<%=opCodeV1%>"></td>
					<td style="display:none"><input name="opName1Hv<%=i%>" id="opName1Hv<%=i%>" value="<%=opNameV1%>"></td>
					<td style="display:none"><input name="opCode2Hv<%=i%>" id="opCode2Hv<%=i%>" value="<%=opCodeV2%>"></td>
					<td style="display:none"><input name="opName2Hv<%=i%>" id="opName2Hv<%=i%>" value="<%=opNameV2%>"></td>
					<td style="display:none"><input name="loginAcceptHv<%=i%>" id="loginAcceptHv<%=i%>" value="<%=loginAccept%>"></td>					
					<!-- tianyang add at 20100201 for POS�ɷ�����*****start*****-->
					<td style="display:none"><input name="payTypeHv<%=i%>"       id="payTypeHv<%=i%>"       value="<%=payType%>"></td>
					<td style="display:none"><input name="Response_timeHv<%=i%>" id="Response_timeHv<%=i%>" value="<%=Response_time%>"></td>
					<td style="display:none"><input name="TerminalIdHv<%=i%>"    id="TerminalIdHv<%=i%>"    value="<%=TerminalId%>"></td>
					<td style="display:none"><input name="RrnHv<%=i%>"           id="RrnHv<%=i%>"           value="<%=Rrn%>"></td>
					<td style="display:none"><input name="Request_timeHv<%=i%>"  id="Request_timeHv<%=i%>"  value="<%=Request_time%>"></td>
					<td style="display:none"><input name="returnMoneyHv<%=i%>"   id="returnMoneyHv<%=i%>"   value="<%=returnMoney%>"></td>
					<!-- tianyang add at 20100201 for POS�ɷ�����*****end*****-->
				</tr>
<%
}
}else{
		 tempFlag = "1";
	 opNameV2 = retVal.getValue("2."+i+".1.0.2.0.0.6");
	 loginAccept = retVal.getValue("2."+i+".1.0.2.0.0.7");
	
	System.out.println("----------------------opCodeV1------------------"+opCodeV1);
	System.out.println("----------------------opNameV1------------------"+opNameV1);
	System.out.println("----------------------opCodeV2------------------"+opCodeV2);
	System.out.println("----------------------opNameV2------------------"+opNameV2);
	System.out.println("----------------------loginAccept---------------"+loginAccept);
	String hiddenStr = retVal.getValue("2."+i+".1.0.0")+"|"+retVal.getValue("2."+i+".1.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.0")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.2")+"|"+retVal.getValue("2."+i+".0.0")+"|"+retVal.getValue("2."+i+".0.1")+"|"+retVal.getValue("2."+i+".0.2");
%>
				<tr style="cursor:pointer" onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')">
					<td><input type="radio" id="custOrderIds" vRowFlag="<%=i%>" value="<%=custOrrayArrayId_new%>"   v_servOrderId="<%=retVal.getValue("2."+i+".1.0.0")%>" onclick="sBindQuery(this,'<%=i%>')" name="custOrderIds" disabled></td>
					<td><%=retVal.getValue("2."+i+".1.0.0")%></td>
					<td><%=retVal.getValue("2."+i+".1.0.1")%></td>
					<td><%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>
						
						<%System.out.println("11111111111====="+retVal.getValue("2."+i+".1.0.2.0.0.0"));%>
						
						<input id="servId_<%=i%>" name="servId_<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>" >
						</td>
					<td><%=retVal.getValue("2."+i+".1.0.2.0.0.1")%></td>
					<td><%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>
						<input type="hidden" id="phoneNoHv<%=i%>" name="phoneNoHv<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>">
						</td>
					<td><%=retVal.getValue("2."+i+".0.0")%></td>
					<td><%=retVal.getValue("2."+i+".0.1")%></td>
					<td><%=retVal.getValue("2."+i+".0.2")%></td>
					
					<td style="display:none"><input name="custAdd<%=i%>" id="custAdd<%=i%>" value="<%=retVal.getValue("2."+i+".0.3")%>"></td>
					<%
						
						
						System.out.println("----------------hiddenStr-------------"+hiddenStr);
					%>
					<td style="display:none"><input name="hiddenStrv<%=i%>" id="hiddenStrv<%=i%>" value="<%=hiddenStr%>"></td>
					<td style="display:none"><input name="opCode1Hv<%=i%>" id="opCode1Hv<%=i%>" value="<%=opCodeV1%>"></td>
					<td style="display:none"><input name="opName1Hv<%=i%>" id="opName1Hv<%=i%>" value="<%=opNameV1%>"></td>
					<td style="display:none"><input name="opCode2Hv<%=i%>" id="opCode2Hv<%=i%>" value="<%=opCodeV2%>"></td>
					<td style="display:none"><input name="opName2Hv<%=i%>" id="opName2Hv<%=i%>" value="<%=opNameV2%>"></td>
					<td style="display:none"><input name="loginAcceptHv<%=i%>" id="loginAcceptHv<%=i%>" value="<%=loginAccept%>"></td>
					<!-- tianyang add at 20100201 for POS�ɷ�����*****start*****-->
					<td style="display:none"><input name="payTypeHv<%=i%>"       id="payTypeHv<%=i%>"       value="<%=payType%>"></td>
					<td style="display:none"><input name="Response_timeHv<%=i%>" id="Response_timeHv<%=i%>" value="<%=Response_time%>"></td>
					<td style="display:none"><input name="TerminalIdHv<%=i%>"    id="TerminalIdHv<%=i%>"    value="<%=TerminalId%>"></td>
					<td style="display:none"><input name="RrnHv<%=i%>"           id="RrnHv<%=i%>"           value="<%=Rrn%>"></td>
					<td style="display:none"><input name="Request_timeHv<%=i%>"  id="Request_timeHv<%=i%>"  value="<%=Request_time%>"></td>
					<td style="display:none"><input name="returnMoneyHv<%=i%>"   id="returnMoneyHv<%=i%>"   value="<%=returnMoney%>"></td>
					<!-- tianyang add at 20100201 for POS�ɷ�����*****end*****-->
				</tr>
				
				
<%
	}
}
%>

</table>

</div>
<script>
	<%if(custArrayOrderSize>0&&tempFlag.equals("1")){%>
			var selObj = document.getElementsByName("custOrderIds");
			selObj[0].checked = true;
			sBindQuery(selObj[0],selObj[0].vRowFlag);
		<%}%>
</script>
<%
}else{
%>
<script>
	rdShowMessageDialog("[<%=retCode%>]:<%=retMsg%>",0);
</script>
<%}%>
