<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
long l1 = new java.util.Date().getTime();
System.out.println("---mylog--searchData.jspҳ����ؿ�ʼʱ��-------------------------------"+new java.util.Date());	
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
	String workNo          = (String) session.getAttribute("workNo"); //��½����
	String password = (String) session.getAttribute("password");
	String idType          = request.getParameter("idType");          //��ѯ����
	String condittionValue = request.getParameter("servno"); //����ֵ
	String modeFlag        = request.getParameter("modeFlag"); //����ֵ
	String selFlag         = request.getParameter("selFlag"); //����ֵ
	String searchDate      = request.getParameter("searchDate") == null?"":(String)request.getParameter("searchDate");  //��ѯ����
	String opCodeLimit     = request.getParameter("opCodeLimit");
	String saleSeq         = request.getParameter("saleSeq");
	String desabLimiStr    = "";
	if(!opCodeLimit.equals("g795")){
		desabLimiStr = "disabled";
	}
	
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
	long l2 = new java.util.Date().getTime();
	System.out.println("---mylog--searchData.jspҳ����ص����÷���sReveresQueryǰ�ĺ�����------"+(l2-l1));	
	
%>
<wtc:utype name="sReveresQuery" id="retVal" scope="end" >
          <wtc:uparam value="<%= idType %>" type="String"/>      
          <wtc:uparam value="<%= condittionValue %>" type="String"/>      
          <wtc:uparam value="<%= workNo %>" type="String"/>      
          <wtc:uparam value="<%= searchDate %>" type="String"/>      
          <wtc:uparam value="<%= opCodeLimit %>" type="String"/>      	
          <wtc:uparam value="<%= saleSeq %>" type="long"/>  
          <wtc:uparam value="<%= password %>" type="String"/> 	
 </wtc:utype>
<%
long l3 = new java.util.Date().getTime();
System.out.println("------------------mylog--------���÷���sReveresQueryǰ��ĺ�����-------"+(l3-l2));	

	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	System.out.println("retCode==mylog=======sReveresQuery================"+retCode);
	System.out.println("retMsg===mylog=======sReveresQuery================"+retMsg);
if("0".equals(retCode.trim())){
	
		//�ͻ���Ϣ
		//custOrderId = retVal.getValue("2.0.0");
		//custName = retVal.getValue("2.0.1");
		//custIccid = retVal.getValue("2.0.2");
		int custArrayOrderSize = retVal.getSize("2");//������Ϣ������
		System.out.println("custArrayOrderSize=========mylog================"+custArrayOrderSize);
		
		StringBuffer logBuffer = new StringBuffer(80);
		WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
		System.out.println("logBuffer.toString()"+logBuffer.toString());

%>

<div id="Operation_Table">
 
 
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�ͻ������б�</div>
</div>
<table id="dataTable" cellspacing=0>
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
		
		
		
		
		<!--th>����</th-->
	</tr>
<%
  String tempFlag = "";
	String custOrrayArrayId_new = "";
             String opCodeV1 ="";
	           String opCodeV2 = "";
	           String loginAccept = "";
	           String opNameV1 = "";
	           String opNameV2 = "";
	           //----------�������� hejwa add 2013��5��24��10:45:06------------
	           
	           int    idnoSize = 0;
	           
	          /*** tianyang add for pos start ***/
	          String payType = "";
	          String Response_time = "";
						String TerminalId = "";
						String Rrn = "";
						String Request_time = "";
						String returnMoney = "";
						String instNumStr  = "";
						/*** tianyang add for pos end ***/					
	           
	for(int i=0;i<custArrayOrderSize;i++){//�ͻ���������
	 
	 // hejwa add ��ҵ��Ȩ����������
	 String saleHitFlag = "";
	 
	 if(retVal.getSize("2."+i+".1")>0){
	 		if(retVal.getSize("2."+i+".1.0")>4){
			 		saleHitFlag = retVal.getValue("2."+i+".1.0.4");
	 		}
	 }
	 
	 custOrrayArrayId_new = retVal.getValue("2."+i+".1.0.0");
	 
	 opCodeV1 = retVal.getValue("2."+i+".1.0.2.0.0.3");
	 opNameV1 = retVal.getValue("2."+i+".1.0.2.0.0.4");
	 opCodeV2 = retVal.getValue("2."+i+".1.0.2.0.0.5");
	 
	 //----------�������� hejwa add 2013��5��24��10:45:06------------
	 String idnoStrs = "";
	 idnoSize = retVal.getSize("2."+i+".1.0.3");
	 for(int j = 0; j<idnoSize ; j++){
		 	idnoStrs += retVal.getValue("2."+i+".1.0.3"+"."+j)+",";
	 }
	 
	 String jttfflag="0";  /*0��������ͨ,1��������ͳ��������*/
	 
	 if(retVal.getSize("2."+i+".1")>0){
	 		if(retVal.getSize("2."+i+".1.0")>5){
			 		jttfflag = retVal.getValue("2."+i+".1.0.5");
	 		}
	 }
	 

	 System.out.println(i+"-----------mylog---------------opCodeV2--------------------"+opCodeV2);
	 System.out.println(i+"-----------mylog---------------modeFlag--------------------"+modeFlag);
	 System.out.println(i+"-----------mylog---------------selFlag---------------------"+selFlag);
	 
	 
	 
	if(selFlag.equals("0")){
	 if(opCodeV2!=null&&opCodeV2.equals(modeFlag)){
	 tempFlag = "1";
	 opNameV2 = retVal.getValue("2."+i+".1.0.2.0.0.6");
	 loginAccept = retVal.getValue("2."+i+".1.0.2.0.0.7");
	
	System.out.println("-----------mylog-----------opCodeV1------------------"+opCodeV1);
	System.out.println("-----------mylog-----------opNameV1------------------"+opNameV1);
	System.out.println("-----------mylog-----------opCodeV2------------------"+opCodeV2);
	System.out.println("-----------mylog-----------opNameV2------------------"+opNameV2);
	System.out.println("-----------mylog-----------loginAccept---------------"+loginAccept);
	
	
	
	/*** tianyang add for pos start ***/
	 payType       = retVal.getValue("2."+i+".1.0.2.0.0.10");
	 Response_time = retVal.getValue("2."+i+".1.0.2.0.0.11");
	 TerminalId    = retVal.getValue("2."+i+".1.0.2.0.0.12");
	 Rrn           = retVal.getValue("2."+i+".1.0.2.0.0.13");
	 Request_time  = retVal.getValue("2."+i+".1.0.2.0.0.14");
	 returnMoney   = retVal.getValue("2."+i+".1.0.2.0.0.15");
	 instNumStr    = retVal.getValue("2."+i+".1.0.2.0.0.16");
	 System.out.println("-----------mylog---------------payType-----------------"+payType);
	 System.out.println("-----------mylog---------------Response_time-----------"+Response_time);
	 System.out.println("-----------mylog---------------TerminalId--------------"+TerminalId);
	 System.out.println("-----------mylog---------------Rrn---------------------"+Rrn);
	 System.out.println("-----------mylog---------------Request_time------------"+Request_time);
	 System.out.println("----------mylog----------------returnMoney-------------"+returnMoney);
	 /*** tianyang add for pos end ***/
	
	
	
	
	
	String hiddenStr = retVal.getValue("2."+i+".1.0.0")+"|"+retVal.getValue("2."+i+".1.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.0")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.2")+"|"+retVal.getValue("2."+i+".0.0")+"|"+retVal.getValue("2."+i+".0.1")+"|"+retVal.getValue("2."+i+".0.2");
%>
				<tr style="cursor:pointer">
					<td><input type="radio" id="custOrderIds" vRowFlag="<%=i%>" value="<%=custOrrayArrayId_new%>"   v_servOrderId="<%=retVal.getValue("2."+i+".1.0.0")%>" onclick="sBindQuery(this,'<%=i%>')" name="custOrderIds"  <%=desabLimiStr%> ></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.0")%></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.1")%></td>
					<td style="display:none"><%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>
						
						<%System.out.println("11111111111====="+retVal.getValue("2."+i+".1.0.2.0.0.0"));%>
						
						<input id="servId_<%=i%>" name="servId_<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>" >
						</td>
					<td style="display:none"><%=retVal.getValue("2."+i+".1.0.2.0.0.1")%></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>
						<input type="hidden" id="phoneNoHv<%=i%>" name="phoneNoHv<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>">
						</td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".0.0")%></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".0.1")%></td>
					<td  style="display:none"><%=retVal.getValue("2."+i+".0.2")%></td>
					
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"> <%=retVal.getValue("2."+i+".1.0.2.0.0.8")%></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"> <%=retVal.getValue("2."+i+".1.0.2.0.0.9")%></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=loginAccept%> </td>
					
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
					<td style="display:none"><input name="instNumStrHv<%=i%>"    id="instNumStrHv<%=i%>"   value="<%=instNumStr%>"></td>
					
					<!-- tianyang add at 20100201 for POS�ɷ�����*****end*****-->
					
					<td style="display:none"><input name="idnoStrs<%=i%>"   id="idnoStrs<%=i%>"   value="<%=idnoStrs%>"></td>
					
<%
	String servIdArrStr = "";
	int servIdNum = retVal.getSize("2."+i+".1.0.2");
	for(int hj=0;hj<servIdNum;hj++){
		servIdArrStr += retVal.getValue("2."+i+".1.0.2."+hj+".0.0")+",";
	}
%>
			<td style="display:none"><input name="servIdArrStrHv<%=i%>"   id="servIdArrStrHv<%=i%>"   value="<%=servIdArrStr%>"></td>
			
			<!-- hejwa add **********-->
			<td style="display:none"><input name="saleHitFlag<%=i%>"   id="saleHitFlag<%=i%>"   value="<%=saleHitFlag%>"></td>
			
			<td style="display:none"><input name="jttfflag<%=i%>"   id="jttfflag<%=i%>"   value="<%=jttfflag%>"></td>
			
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
				<tr style="cursor:pointer" >
					<td><input type="radio" id="custOrderIds" vRowFlag="<%=i%>" value="<%=custOrrayArrayId_new%>"   v_servOrderId="<%=retVal.getValue("2."+i+".1.0.0")%>" onclick="sBindQuery(this,'<%=i%>')" name="custOrderIds"  <%=desabLimiStr%>  ></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.0")%></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.1")%></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>
						
						<%System.out.println("11111111111====="+retVal.getValue("2."+i+".1.0.2.0.0.0"));%>
						
						<input id="servId_<%=i%>" name="servId_<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>" >
						</td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.2.0.0.1")%></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>
						<input type="hidden" id="phoneNoHv<%=i%>" name="phoneNoHv<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>">
						</td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".0.0")%></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".0.1")%></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".0.2")%></td>
					
					<td style="display:none"><input name="custAdd<%=i%>" id="custAdd<%=i%>" value="<%=retVal.getValue("2."+i+".0.3")%>"></td>
					<%
						
						
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
					
					<td style="display:none"><input name="idnoStrs<%=i%>"   id="idnoStrs<%=i%>"   value="<%=idnoStrs%>"></td>
<%
	String servIdArrStr = "";
	int servIdNum = retVal.getSize("2."+i+".1.0.2");
	for(int hj=0;hj<servIdNum;hj++){
		servIdArrStr += retVal.getValue("2."+i+".1.0.2."+hj+".0.0")+",";
	}
%>
			<td style="display:none"><input name="servIdArrStrHv<%=i%>"   id="servIdArrStrHv<%=i%>"   value="<%=servIdArrStr%>"></td>					
						<!-- hejwa add **********-->
			<td style="display:none"><input name="saleHitFlag<%=i%>"   id="saleHitFlag<%=i%>"   value="<%=saleHitFlag%>"></td>
			
			<td style="display:none"><input name="jttfflag<%=i%>"   id="jttfflag<%=i%>"   value="<%=jttfflag%>"></td>
			
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
<%}
long l4 = new java.util.Date().getTime();
System.out.println("------------------mylog--------���÷�����ɵ�ҳ�������ɵĺ�����------"+(l4-l3));	
System.out.println("------------------mylog--------����ҳ�������ɵĺ�����----------------"+(l4-l1));	
%>
