<%
/* liujian add workNo and password 2012-4-5 15:59:15 begin */
String workNo_new = (String)session.getAttribute("workNo");
String password_new = (String) session.getAttribute("password");
String smzname="";
/* liujian add workNo and password 2012-4-5 15:59:15 end */
System.out.println("-------------------PMUserBaseInfo.jsp--------------"+opCode);

	  String[] inParamsss2 = new String[2];
		inParamsss2[0] = "select to_char(a.TRUE_CODE) from dTrueNamemsg a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phonesNO ";
		inParamsss2[1] = "phonesNO="+phoneNo;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss2[0]%>"/>
	<wtc:param value="<%=inParamsss2[1]%>"/>	
	</wtc:service>	
  <wtc:array id="smzvresultarry" scope="end" />
  	
 <%
 	if(smzvresultarry.length>0) {
 			
			if(smzvresultarry[0][0].equals("1")) {
					smzname="ʵ��";
			}
			if(smzvresultarry[0][0].equals("2")) {
					smzname="׼ʵ��";
			}
			if(smzvresultarry[0][0].equals("3")) {
					smzname="��ʵ��";
			}
	}
 %> 	
<wtc:utype name="sPMQryUserInfo" id="retUserInfo" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="0" type="LONG"/>
     <wtc:uparam value="<%=phoneNo%>" type="STRING"/>
     <wtc:uparam value="<%=workNo_new%>" type="string"/>
     <wtc:uparam value="<%=password_new%>" type="string"/>
     <wtc:uparam value="<%=opCode%>" type="string"/>	
</wtc:utype>


<%
retCode =retUserInfo.getValue(0);
retMsg  =retUserInfo.getValue(1);

String stPMvPhoneNo       = ""; /*�ֻ�����*/
String stPMid_no          = "";  /*�û�id*/
String stPMcust_id        = "";  /*�ͻ�id*/
String stPMcontract_no    = "";  /*Ĭ���ʺ�*/
String stPMbelong_code    = "";  /*�û�����*/
String stPMsm_code        = "";  /*ҵ�����ʹ���*/
String stPMsm_name        = "";  /*ҵ����������*/
String stPMsm_kind        = "";  /*c,g,d,e*/
String stPMcust_name      = "";  /*�ͻ�����*/
String stPMuser_passwd    = "";  /*�û�����*/
String stPMrun_code       = "";  /*״̬����*/
String stPMrun_name       = "";  /*״̬����*/
String stPMowner_grade    = "";  /*�ȼ�����*/
String stPMgrade_name     = "";  /*�ȼ�����*/
String stPMowner_type     = "";  /*�û����ʹ���*/
String stPMtype_name      = "";  /*�û���������*/
String stPMcust_address   = "";  /*�ͻ�סַ*/
String stPMid_type        = "";  /*֤������*/
String stPMid_name        = "";  /*֤������*/
String stPMid_iccid       = "";  /*֤������*/
String stPMcard_type      = "";  /*�ͻ�������*/
String stPMcard_name      = "";  /*�ͻ�����������*/
String stPMvip_no         = "";  /*VIP����*/
String stPMgrpbig_flag    = "";  /*���ſͻ���־*/
String stPMgrpbig_name    = "";  /*���ſͻ�����*/
String stPMbak_field      = "";  /*�����ֶ�*/
String stPMgroup_id       = "";  /*������ʶ*/
String stPMcontact_person = "";  /* ��ϵ��  */
String stPMcontact_phone  = "";  /* ��ϵ�绰 */    
String stPMowner_code     = "";  /* �û����� */
String stPMcredit_code    = "";  /* �������� */
String stPMmode_code      = "";  /* ���»�����ƷID*/
String stPMmode_name      = "";  /* ���»�����Ʒ����*/
String stPMtotalOwe       = "";  /*��Ƿ��*/
String stPMtotalPrepay    = ""; /*��Ԥ��*/
String unbillFee          = ""; /*δ���ʻ���*/
String accountNo          = ""; /*��һ���ʻ�*/
String accountOwe         = ""; /*��һ���ʻ�Ƿ��*/
String openTime           = ""; /*����ʱ��*/
		
if(retCode.equals("0"))
{
stPMvPhoneNo       = retUserInfo.getValue("2.0.2.0");   /*�ֻ�����*/
stPMid_no          = retUserInfo.getValue("2.0.2.1");   /*�û�id*/
stPMcust_id        = retUserInfo.getValue("2.0.2.2");   /*�ͻ�id*/
stPMcontract_no    = retUserInfo.getValue("2.0.2.3");   /*Ĭ���ʺ�*/
stPMbelong_code    = retUserInfo.getValue("2.0.2.4");   /*�û�����*/
stPMsm_code        = retUserInfo.getValue("2.0.2.5");   /*ҵ�����ʹ���*/
stPMsm_name        = retUserInfo.getValue("2.0.2.6");   /*ҵ����������*/
stPMsm_kind        = retUserInfo.getValue("2.0.2.7");   /*c,g,d,e*/
stPMcust_name      = retUserInfo.getValue("2.0.2.8");   /*�ͻ�����*/
stPMuser_passwd    = retUserInfo.getValue("2.0.2.9");   /*�û�����*/
stPMrun_code       = retUserInfo.getValue("2.0.2.10");  /*״̬����*/
stPMrun_name       = retUserInfo.getValue("2.0.2.11");  /*״̬����*/
stPMowner_grade    = retUserInfo.getValue("2.0.2.12");  /*�ȼ�����*/
stPMgrade_name     = retUserInfo.getValue("2.0.2.13");  /*�ȼ�����*/
stPMowner_type     = retUserInfo.getValue("2.0.2.14");  /*�û����ʹ���*/
stPMtype_name      = retUserInfo.getValue("2.0.2.15");  /*�û���������*/
stPMcust_address   = retUserInfo.getValue("2.0.2.16");  /*�ͻ�סַ*/
stPMid_type        = retUserInfo.getValue("2.0.2.17");  /*֤������*/
stPMid_name        = retUserInfo.getValue("2.0.2.18");  /*֤������*/
stPMid_iccid       = retUserInfo.getValue("2.0.2.19");  /*֤������*/
stPMcard_type      = retUserInfo.getValue("2.0.2.20");  /*�ͻ�������*/
stPMcard_name      = retUserInfo.getValue("2.0.2.21");  /*�ͻ�����������*/
stPMvip_no         = retUserInfo.getValue("2.0.2.22");  /*VIP����*/
stPMgrpbig_flag    = retUserInfo.getValue("2.0.2.23");  /*���ſͻ���־*/
stPMgrpbig_name    = retUserInfo.getValue("2.0.2.24");  /*���ſͻ�����*/
stPMbak_field      = retUserInfo.getValue("2.0.2.25");  /*�����ֶ�*/
stPMgroup_id       = retUserInfo.getValue("2.0.2.26");  /*������ʶ*/
stPMcontact_person = retUserInfo.getValue("2.0.2.27");  /* ��ϵ��  */
stPMcontact_phone  = retUserInfo.getValue("2.0.2.28");  /* ��ϵ�绰 */    
stPMowner_code     = retUserInfo.getValue("2.0.2.29");  /* �û����� */
stPMcredit_code    = retUserInfo.getValue("2.0.2.30");  /* �������� */
stPMmode_code      = retUserInfo.getValue("2.0.2.31");  /* ���»�����ƷID*/
stPMmode_name      = retUserInfo.getValue("2.0.2.32");  /* ���»�����Ʒ����*/
stPMtotalOwe       = retUserInfo.getValue("2.0.2.33");  /*��Ƿ��*/
stPMtotalPrepay    = retUserInfo.getValue("2.0.2.34");  /*��Ԥ��*/
unbillFee          = retUserInfo.getValue("2.0.2.35");  /*δ���ʻ���*/
accountNo          = retUserInfo.getValue("2.0.2.36");  /*��һ���ʻ�*/
accountOwe         = retUserInfo.getValue("2.0.2.37");  /*��һ���ʻ�Ƿ��*/
openTime           = retUserInfo.getValue("2.0.2.38");  /*����ʱ��*/
}

String custJFv1 = "";
//String sqlTempV1 = "select a.year_fee,b.prepay_fee  from dCustYearMsg a,dConMsgPre b,product_offer_attr c where a.CONTRACT_NO = b.CONTRACT_NO and b.PAY_TYPE = c.OFFER_ATTR_VALUE and c.OFFER_ATTR_SEQ = '5060' and a. id_no = to_number('"+stPMcust_id+"') and sysdate between a.begin_time and a.end_time";
//String sqlTempV1 = "select a.year_fee,b.prepay_fee  from dCustYearMsg a,dConMsgPre b,product_offer_attr c where a.CONTRACT_NO = b.CONTRACT_NO and b.PAY_TYPE = c.OFFER_ATTR_VALUE and a.mode_code=c.offer_id and c.OFFER_ATTR_SEQ = '5060' and a.id_no = to_number('"+stPMid_no+"') and sysdate between a.begin_time and a.end_time ";

String sqlTempV10 = "select a.offer_attr_value from product_offer_attr a,dcustyearmsg b where  a.offer_attr_seq = '5060' and a.offer_id = b.mode_code and b.id_no = :serv_id";
String [] paraIn1 = new String[2];
paraIn1[0]=sqlTempV10;
paraIn1[1]="serv_id="+stPMid_no;
//wanghfa�޸Ļ��ֲ�ѯ��ʽ 2011/6/13 start
%>
	<wtc:service name="sMarkMsgQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="16">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="mainQryArr" scope="end"/>
<%
	if (mainQryArr.length<1) {
		custJFv1 = "û�з�������������!";
		return;
	} else {
		custJFv1 = mainQryArr[0][0];
	}
//wanghfa�޸Ļ��ֲ�ѯ��ʽ 2011/6/13 start
	
	String show1270V1 = "";
	String show1270V2 = "";
	if(opCode.equals("1270")){
		show1270V1 = "�û�����/Mֵ";
		show1270V2 = custJFv1;
	}
%>			 	
<div class="input">
 <table cellspacing="0">
 	
      <TR> 
		  <TD class="blue">�ƶ�����</TD> 
		  <TD>
		   <%=stPMvPhoneNo%>
		  </TD>
		  <TD class="blue">�ͻ�ID </TD>
		  <TD>
		    <%=stPMcust_id%>
		  </TD>
		  <TD class="blue">�ͻ����� </TD>
		  <TD>
		   <%=stPMcust_name%>
		  </TD>
		 </TR>
         <tr>
      <td  class="blue">ҵ��Ʒ�� </td>
      <td >
        <%=stPMsm_name%>
        <input type="hidden" name="stPMsm_nameHi" id="stPMsm_nameHi" value="<%=stPMsm_name%>">
        <input type="hidden" name="stPMcust_addressHi" id="stPMcust_addressHi" value="<%=stPMcust_address%>">
        <input type="hidden" name="stPMid_no" id="stPMid_no" value="<%=stPMid_no%>">

        
      </td>
		  <td class="blue">����ʱ�� </td>
		  <td>
		     <%=openTime%>
		  </td>      

		  <TD class="blue">ҵ������ </TD>
		  <TD>
		    <%=stPMsm_name%>
		  </TD>
		</tr>
      
	 <TR> 
		  <TD class="blue">����״̬ </TD>
		  <TD>
		    <%=stPMrun_name%>
		  </TD>
		  <TD class="blue">δ���ʻ��� </TD>
		  <TD>
		  	
		  	<%
		  	if(unbillFee.indexOf(".")!=-1){
		  		unbillFee = unbillFee+"00";
		  	}else{
		  		unbillFee = unbillFee+".00";
		  		}
		  		
		  	unbillFee = unbillFee.substring(0,unbillFee.indexOf(".")+3);	
		  	
		  	%>
		   <%=unbillFee%>
		  </TD>
		  <TD class="blue">����Ԥ�� </TD>
		  <TD>
		  	<span spanType="prepaySpan">
		  	<%
		  	
		  	if(stPMtotalPrepay.indexOf(".")!=-1){
		  		stPMtotalPrepay = stPMtotalPrepay+"00";
		  	}else{
		  		stPMtotalPrepay = stPMtotalPrepay+".00";
		  		}
		  		
		  	stPMtotalPrepay = stPMtotalPrepay.substring(0,stPMtotalPrepay.indexOf(".")+3);	
						  	
		  	%>
		    <%=stPMtotalPrepay %>
		  </span>
		  </TD>
   </TR>
   
	 <TR>  
	    <TD class="blue">���ſͻ���� </TD>
		  <TD>
		    <%=stPMgrpbig_name%>
		  </TD>
		  
		  <TD class="blue">��ͻ���� </TD>
		  <TD>
		    <%=stPMcard_name%>
	    </TD>  
		  <TD class=blue><%=show1270V1%>&nbsp; </TD>
		  <TD><%=show1270V2%>&nbsp;  </TD>


	 </TR>
    <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">	
	<wtc:param value="<%=paraIn1[0]%>"/>
 	<wtc:param value="<%=paraIn1[1]%>"/>
 	</wtc:service>
	<wtc:array id="result_t1" scope="end" />	
<%
	String sqlTempV11 = "";
	sqlTempV11 += "SELECT a.year_fee, b.prepay_fee ";
	sqlTempV11 += "FROM dcustyearmsg a, dconmsgpre b ";
	sqlTempV11 += "WHERE a.contract_no = b.contract_no ";
	sqlTempV11 += "AND b.pay_type = :attr_value ";
	sqlTempV11 += "AND a.id_no = TO_NUMBER (:serv_id) ";
	sqlTempV11 += "AND SYSDATE BETWEEN a.begin_time AND a.end_time";
	System.out.println("sqlTempV11|"+sqlTempV11);
	String [] paraIn = new String[2];
	String year_feeStr = "0"; 
	String prepay_feeStr = "0";
	if(result_t1.length<0){
		paraIn[0]=sqlTempV11;
		paraIn[1]="attr_value="+result_t1[0][0]+",serv_id="+stPMid_no;
%>
	    <wtc:service name="TlsPubSelBoss" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">	
		<wtc:param value="<%=paraIn[0]%>"/>
	 	<wtc:param value="<%=paraIn[1]%>"/>
	 	</wtc:service>
		<wtc:array id="result_tV1" scope="end" />								 
		 <%
	
	
		 for(int it=0;it<result_tV1.length;it++){
		 	year_feeStr =result_tV1[it][0];
		 	prepay_feeStr =result_tV1[it][1];
		 }
		
	}
	stPMtotalOwe="0";
	double dValueTemp1 = Double.parseDouble(prepay_feeStr) -Double.parseDouble(stPMtotalOwe);
	 //3275��127a�� 127b ������ҵ���ģ���Ҫ��ʾ��ַ��Ϣ��������ҵ��ģ�鲻��ʾ��ַ��Ϣ
	 if(opCode.equals("127b")){
	 %>
			<TD class="blue">�ͻ���ַ </TD>
		  <TD colspan=3><%=stPMcust_address%>
		  	
		  	</TD>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 <%}else if(opCode.equals("1258")){%>
		<tr>
	 		<td class="blue">֤������</td>
	 		<td class=""><%=stPMid_name%></td>
	 		<td class="blue">֤������</td>
	 		<td class=""><%=stPMid_iccid%></td>
	 		<td class="blue">������</td>
	 		
	 		<%
	 		
	 		
	 		if(year_feeStr.indexOf(".")!=-1){
		  		year_feeStr = year_feeStr+"00";
		  	}else{
		  		year_feeStr = year_feeStr+".00";
		  		}
		  		
		  	year_feeStr = year_feeStr.substring(0,year_feeStr.indexOf(".")+3);	
		  	
		  	
		  	if(prepay_feeStr.indexOf(".")!=-1){
		  		prepay_feeStr = prepay_feeStr+"00";
		  	}else{
		  		prepay_feeStr = prepay_feeStr+".00";
		  		}
		  		
		  	prepay_feeStr = prepay_feeStr.substring(0,prepay_feeStr.indexOf(".")+3);	
	 		
	 		
	 		if(stPMtotalOwe.indexOf(".")!=-1){
		  		stPMtotalOwe = stPMtotalOwe+"00";
		  	}else{
		  		stPMtotalOwe = stPMtotalOwe+".00";
		  		}
		  		
		  	stPMtotalOwe = stPMtotalOwe.substring(0,stPMtotalOwe.indexOf(".")+3);	
		  	
		  	
		  	String dValueTemp = String.valueOf(dValueTemp1);
		  	if(dValueTemp.indexOf(".")!=-1){
		  		dValueTemp = dValueTemp+"00";
		  	}else{
		  		dValueTemp = dValueTemp+".00";
		  		}
		  		
		  	dValueTemp = dValueTemp.substring(0,dValueTemp.indexOf(".")+3);	
		  	
		  	
	 		
	 		%>
	 		<td > <%=year_feeStr%></td>
	 	</tr>
	 	<tr>
	 		<td class="blue">�����ڳ�Ԥ��</td>
	 		<td class=""> <%=prepay_feeStr%></td>
	 		<td class="blue">����δ���ʻ���</td>
	 		<td class=""> <%=stPMtotalOwe%></td>
	 		<td class="blue">���굱ǰ�������</td>
	 		<td  ><%=dValueTemp%></td>
	 	</tr>
	 <%}else if(opCode.equals("3275")||opCode.equals("127a")){%>
	 	<tr>
	 		<td class="blue">֤������</td>
	 		<td class=""><%=stPMid_name%></td>
	 		<td class="blue">֤������</td>
	 		<td class=""><%=stPMid_iccid%></td>
	 		<TD class="blue">�ͻ���ַ </TD>
		  <TD colspan=3><%=stPMcust_address%></TD>
	 	</tr>
	 <%}else if( opCode.equals("3250") || opCode.equals("g720")){%>
	 	<tr>
			<td class="blue">֤������</td>
			<td class=""><%=stPMid_name%></td>
			<td class="blue">&nbsp;</td>
			<td class="blue">&nbsp;</td>
			<td class="blue">&nbsp;</td>
			<td class="blue">&nbsp;</td>
		</tr>
	 <%}%>
		<%
		if ( opCode.equals("1270") )
		{
		%> 	
	 	<tr>
	 	
	 		<td class="blue">֤������</td>
	 		<td class=""><%=stPMid_name%></td>

				<!--zhangyan add-->
				<wtc:service name="sGetUserMsgNew" routerKey="region" 
					routerValue="<%=regionCode%>"  
					retcode="rcUm" retmsg="rmUm"  outnum="5" >
				    <wtc:param value="<%=loginAccept%>"/>
				    <wtc:param value="01"/>
				    <wtc:param value="<%=opCode%>"/>
				    <wtc:param value="<%=workNo%>"/>
				    <wtc:param value="<%=password_new%>"/>
				    <wtc:param value="<%=phoneNo%>"/>
				    <wtc:param value=""/>
				</wtc:service>
				<wtc:array id="rstUm" scope="end" />		
				<%
				if (rcUm.equals("000000"))
				{
					System.out.println("zhangyan ~~~~rstUm.length="+rstUm.length);
					if (   rstUm.length==0 )
					{
					%>
					<script>
						rdShowMessageDialog("�޴��û���Ϣ!" , 0);		
						removeCurrentTab();								
					</script>
					<%
					}
					else
					{
					%>
			 		<td class="blue">�������û�:</td>
			 		<td class="red" >
			 			
			 			<%
			 			if ( rstUm[0][0].equals("W"))
			 			{
			 			%>
			 				��
			 			<%
			 			}
			 			else if ( rstUm[0][0].equals("B"))
			 			{
			 			%>
			 				�� (�ں�������)
			 			<%
			 			}
			 			else
			 			{
			 			%>
			 				��
			 			<%
			 			}
			 			%>
			 			
			 		</td>
			 		<td class="blue">������VPMN�û�</td>
			 		<td class="red" >
			 			<%=( rstUm[0][1].equals("Y")?"��":"��" )%>		 			
			 		</td>
					<%						
					}
				}
				else
				{
				%>
					<script>
						rdShowMessageDialog("<%=rcUm%>"+":"+"<%=rmUm%>!" , 0);		
						removeCurrentTab();					
					</script>	
				<%			
				}
			%>

	 	</tr>
		<tr>
			<td class="blue">���񹫻��û�</td>
			<td class="red" >
				<%=( rstUm[0][2].equals("Y")?"��":"��" )%>		 			
			</td>
			<td class="blue">һ��˫���û�</td>
			<td class="red" >
				<%=( rstUm[0][3].equals("Y")?"��":"��" )%>		 			
			</td>	
			<td class="blue">�и߶��û�</td>		
			<td class="red" >
				<%=( rstUm[0][4].equals("Y")?"��":"��" )%>		 			
			</td>
		</tr>		
				<tr>
			<td class="blue">ʵ��״̬</td>
			<%
				if(smzvresultarry.length>0) {
			if(smzvresultarry[0][0].equals("3")){%>
			<td style="color:red;font-weight:bold">
				<%=smzname%>		 			
			</td>
		<%}else {%>
						<td >
				<%=smzname%>		 			
			</td>
			<%}%>
	
	<%
}else {%>
	
							<td >
				<%=smzname%>		 			
			</td>
			<%
	}
	}
	%>
		</tr>	
</table>
</div>
