<%
/*
 * ����: ʡ��Я��
 * �汾: 1.0
 * ����: 2012/3/9 14:19:13
 * ����: zhangyan
 * ��Ȩ: si-tech
 * update:
*/
System.out.println("e687~~~sCQryUserInfo wtc begin~~~~~");
%>
<wtc:utype name="sCQryUserInfo" id="retUserInfo" scope="end"  
	routerKey="region" routerValue="<%=regCode%>">
     <wtc:uparam value="0" type="LONG"/>
     <wtc:uparam value="<%=phoneNo%>" type="STRING"/>
     <wtc:uparam value="<%=workNo%>" type="string"/>
     <wtc:uparam value="<%=password%>" type="string"/>
     <wtc:uparam value="<%=opCode%>" type="string"/>	  	
</wtc:utype>
<%
System.out.println("e687~~~sCQryUserInfo wtc end~~~~~");
String retCodeUserInfo = retUserInfo.getValue(0);
String retMsgUserInfo  = retUserInfo.getValue(1);
if(!retCodeUserInfo.equals("0")){
%>
  <script language='JavaScript'>
        rdShowMessageDialog("<%=retCodeUserInfo%>:<%=retMsgUserInfo%>");
        removeCurrentTab();
   </script> 
<%
}
retCodeM =retUserInfo.getValue(0);
retMsgM  =retUserInfo.getValue(1);
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
System.out.println("zhangyan!!!retCodeM!!!!!!!!!!!!!!!!!!!!"+retCodeM+"!!!!!!!!!");
if(retCodeM.equals("0"))
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

String sqlTempV10 = "select a.offer_attr_value "
	+"from product_offer_attr a,dcustyearmsg b "
	+"where  a.offer_attr_seq = '5060' and a.offer_id = b.mode_code "
	+"and b.id_no = :serv_id";
String [] paraIn1 = new String[2];
paraIn1[0]=sqlTempV10;
paraIn1[1]="serv_id="+stPMid_no;
%>
<wtc:service name="sMarkMsgQry" routerKey="region"  outnum="16"
	routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1">
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
if (mainQryArr.length<1) 
{
	custJFv1 = "û�з�������������!";
	return;
} 
else 
{
	custJFv1 = mainQryArr[0][0];
}
String showE687V1 = "";
String showE687V2 = "";
if(opCode.equals("e687"))
{
	showE687V1 = "�û�����/Mֵ";
	showE687V2 = custJFv1;
}
%>			 	
<div class="input">
<table cellspacing="0">
<TR> 
	<TD class="blue">�ƶ�����	</TD> 
	<TD><%=stPMvPhoneNo%>			</TD>
	<TD class="blue">�ͻ�ID 	</TD>
	<TD><%=stPMcust_id%>			</TD>
	<TD class="blue">�ͻ����� </TD>
	<TD><%=stPMcust_name%>		</TD>
</TR>
<tr>
	<td  class="blue">ҵ��Ʒ�� </td>
	<td >
		<%=stPMsm_name%>
		<input type="hidden" name="stPMsm_nameHi" id="stPMsm_nameHi" 
			value="<%=stPMsm_name%>">
		<input type="hidden" name="stPMcust_addressHi" id="stPMcust_addressHi" 
			value="<%=stPMcust_address%>">
		<input type="hidden" name="stPMid_no" id="stPMid_no" 
			value="<%=stPMid_no%>">
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
	if(unbillFee.indexOf(".")!=-1)
	{
		unbillFee = unbillFee+"00";
	}
	else
	{
		unbillFee = unbillFee+".00";
	}
	unbillFee = unbillFee.substring(0,unbillFee.indexOf(".")+3);	
	%>
	<%=unbillFee%>
	</TD>
	<TD class="blue">����Ԥ�� </TD>
	<TD>
		<%
		if(stPMtotalPrepay.indexOf(".")!=-1)
		{
			stPMtotalPrepay = stPMtotalPrepay+"00";
		}
		else
		{
			stPMtotalPrepay = stPMtotalPrepay+".00";
		}
		stPMtotalPrepay = stPMtotalPrepay.substring(0
			,stPMtotalPrepay.indexOf(".")+3);	
		%>
		<%=stPMtotalPrepay %>
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
	<TD class=blue><%=showE687V1%>&nbsp; </TD>
	<TD><%=showE687V2%>&nbsp;  </TD>
</TR>
	 	<tr>
	 		<td class="blue">֤������</td>
	 		<td class=""><%=stPMid_name%></td>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 	</tr>
</table>
</div>
