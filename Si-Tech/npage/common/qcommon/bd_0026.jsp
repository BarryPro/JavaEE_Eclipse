<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
	String servPhoneNo_0026 = request.getParameter("servPhoneNo"); 
	String servPhoneNo_0026_2 = servPhoneNo_0026;
	String idNo_0026 = "";
	System.out.println(" ................. servPhoneNo_0026  = " + servPhoneNo_0026);
%>
<wtc:pubselect name="sPubSelect"  outnum="1">
	<wtc:sql>select msisdn  from daccountidinfo  where trim (service_no) = trim ('?')</wtc:sql> 
	<wtc:param value="<%=servPhoneNo_0026%>"/>
</wtc:pubselect>
<wtc:iter id="rows2" indexId="i" >
	<%
		 servPhoneNo_0026_2 = rows2[0];
		 System.out.println(" ................. servPhoneNo_0026  = " + servPhoneNo_0026);
	%>
</wtc:iter>		
<wtc:pubselect name="sPubSelect" retcode = "retCode1" retmsg = "retMsg1" retval="ret_val1" outnum="1">
	<wtc:sql>select id_no from dcustmsg where phone_no='?'</wtc:sql> 
	<wtc:param value="<%=servPhoneNo_0026_2%>"/>
</wtc:pubselect>
<wtc:array id="rows1" property="ret_val1" scope="end"/>
<%
	if(rows1.length>0){	
		idNo_0026 = rows1[0][0];
%>
<wtc:utype name="sgetUserMsg" id="retCurConInfo" scope="end">
    <wtc:uparam value="<%=idNo_0026%>" type="LONG"/>
</wtc:utype>
<%
	 StringBuffer logBuffer_0026 = new StringBuffer(80);
	 WtcUtil.recursivePrint(retCurConInfo,1,"2",logBuffer_0026);		
	 System.out.println(logBuffer_0026.toString());
	 String  retCode_0026 =retCurConInfo.getValue(0);
     String  retMsg_0026  =retCurConInfo.getValue(1);
     System.out.println(retCode_0026+" = retCode_0026 ................. retMsg_0026  = " + retMsg_0026);
     String curPreFee_0026 = "0"; 	//��Ԥ��
     String curPayFee_0026 = "0";	 //��Ƿ��
     String retPreFee_0026 = "0"; 	//����Ԥ��
     String noRetPreFee_0026 = "0"; 	//������Ԥ��
     String hasFee_0026 = "0"; 		 //δ���˷���
     String retMark_0026 = "0";  	//�û��ܻ���
     String deposit_fee_0026 = "0"; 	//Ѻ��
     if(retCode_0026.equals("0")){
     	curPreFee_0026 =	retCurConInfo.getValue("2.1.0");       //��Ԥ��        
     	curPayFee_0026 =  	retCurConInfo.getValue("2.1.1");        //��Ƿ��       
     	retPreFee_0026 = 	retCurConInfo.getValue("2.1.6");       //����Ԥ��      
     	noRetPreFee_0026 = 	retCurConInfo.getValue("2.1.7");     	//������Ԥ��
     	hasFee_0026 =		retCurConInfo.getValue("2.1.2");           //δ���˷���   
     	deposit_fee_0026 = 	retCurConInfo.getValue("2.1.5");       //Ѻ��     
     	retMark_0026 = 	    retCurConInfo.getValue("2.2.0");     	   //�û��ܻ���    
%>
<table id="tbl<%=servPhoneNo_0026.trim()%>">
	<tr>
		<th><span class="red">*������룺</span></th>
		<td>
			<input type="text" readOnly="true"  name="service_no" value="<%=servPhoneNo_0026%>"/>
		</td>
		<th>Ѻ��</th>
		<td>
				 <input type="text" readOnly="true" class="forMoney" vflag=1 name="deposit_fee<%=servPhoneNo_0026.trim()%>" value="<%=deposit_fee_0026%>"/>
		</td>
	
	</tr>
	<tr>
		<th>��ǰԤ�棺</th>
		<td>
			 	  <input type="text" readOnly="true" class="forMoney" vflag=1  name="cur_pre_fee<%=servPhoneNo_0026.trim()%>" value="<%=curPreFee_0026%>"/>	
		</td>
		<th>��ǰǷ�ѣ�</th>
		<td>
		          <input type="text" readOnly="true"  class="forMoney" vflag=1  name="cur_pay_fee<%=servPhoneNo_0026.trim()%>" value="<%=curPayFee_0026%>"/>
		</td>
	</tr>
	<tr>
		<th>����Ԥ�棺</th>
		<td>
			 	 <input type="text" readOnly="true" class="forMoney" vflag=1  name="ret_pre_fee<%=servPhoneNo_0026.trim()%>" value="<%=retPreFee_0026%>"/>
		</td>
		<th>������Ԥ�棺</th>
		<td>
		          <input type="text" readOnly="true" class="forMoney" vflag=1  name="noret_pre_fee<%=servPhoneNo_0026.trim()%>" value="<%=noRetPreFee_0026%>"/>
		</td>
	</tr>
	<tr>
		<th>δ���ʷ��ã�</th>
		<td>
				 <input type="text" readOnly="true" class="forMoney" vflag=1  name="con_rate<%=servPhoneNo_0026.trim()%>" value="<%=hasFee_0026%>"/>
		</td>
		<th>ʣ��ɶһ����֣�</th>
		<td>
		          <input type="text" readOnly="true" class="forMoney" vflag=1  name="ret_mark<%=servPhoneNo_0026.trim()%>" value="<%=retMark_0026%>"/>
		</td>
	</tr>
</table>
<%}}else{%>
	<script>
		rdShowMessageDialog("��ѯ�û�������Ϣ����!",0);
	</script>
<%}%>