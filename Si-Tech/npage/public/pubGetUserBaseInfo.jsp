<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retCode = "";
	String retMsg = "";
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String regionCode= (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String) session.getAttribute("password");
%>
<wtc:utype name="sPMQryUserInfo" id="retUserInfo" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="0" type="LONG"/>
     <wtc:uparam value="<%=phoneNo%>" type="STRING"/>
     <wtc:uparam value="<%=workNo%>" type="string"/>
     <wtc:uparam value="<%=password%>" type="string"/>
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
String stPMtotalPrepay    = ""; /*��Ԥ�� ����ר��Ԥ���*/
String unbillFee          = ""; /*δ���ʻ���*/
String accountNo          = ""; /*��һ���ʻ�*/
String accountOwe         = ""; /*��һ���ʻ�Ƿ��*/
String openTime           = ""; /*����ʱ��*/
String show_fee 					= ""; /*��ǰԤ��;*/
String prepayFee 					= "";	/*��ǰ�ɻ���Ԥ��*/
String nobillpay 					= ""; /*δ���˻���*/
String now_prepayFee 			= "";	/*��ǰ����Ԥ��*/
String zx_yc_fee					= ""; /*ר��Ԥ�����*/
String pt_yc_fee					= "";	/*��ͨԤ�����*/
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
	show1270V1 = "�û�����/Mֵ";
	show1270V2 = custJFv1;
	if(unbillFee.indexOf(".")!=-1){
		unbillFee = unbillFee+"00";
	}else{
		unbillFee = unbillFee+".00";
	}
	unbillFee = unbillFee.substring(0,unbillFee.indexOf(".")+3);
	
	if(stPMtotalPrepay.indexOf(".")!=-1){
		stPMtotalPrepay = stPMtotalPrepay+"00";
	}else{
		stPMtotalPrepay = stPMtotalPrepay+".00";
	}
	stPMtotalPrepay = stPMtotalPrepay.substring(0,stPMtotalPrepay.indexOf(".")+3);	
%>
	<wtc:service name="s1500_feeVW" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="feeRetCode" retmsg="feeRetMsg" outnum="8">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=stPMid_no%>"/>
	</wtc:service>
	<wtc:array id="s1500FeeArr" scope="end"/>
<%
	if(Integer.parseInt(feeRetCode)==0){
		if(s1500FeeArr.length>0){
			show_fee = s1500FeeArr[0][2]; 	/*��ǰԤ��;*/
			prepayFee = s1500FeeArr[0][3];	/*��ǰ�ɻ���Ԥ��*/
			nobillpay = s1500FeeArr[0][4];	/*δ���˻���*/
			now_prepayFee = s1500FeeArr[0][5];/*��ǰ����Ԥ��*/
			zx_yc_fee=s1500FeeArr[0][6];		/*ר��Ԥ�����*/
			pt_yc_fee=s1500FeeArr[0][7];		/*��ͨԤ�����*/
		}
	}
	System.out.println("ningtn pubGetUserBaseInfo retCode " + retCode);
	/*��ѯ��������Ϣ*/
	String limitOwe = "";
	String sqlTempV10 = "select to_char(limit_owe) from dcustmsg where phone_no= :phone_no";
	String [] paraIn1 = new String[2];
	paraIn1[0]=sqlTempV10;
	paraIn1[1]="phone_no="+phoneNo;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"
	  retmsg="msg0" retcode="code0" outnum="1">
	  <wtc:param value="<%=paraIn1[0]%>"/>
	  <wtc:param value="<%=paraIn1[1]%>"/>
	</wtc:service>
	<wtc:array id="result0" scope="end" />
<%
	if("000000".equals(code0) && result0 != null && result0.length > 0){
		limitOwe = result0[0][0];
	}
%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("stPMvPhoneNo","<%= stPMvPhoneNo %>");
	response.data.add("stPMid_no","<%= stPMid_no %>");
	response.data.add("stPMcust_id","<%= stPMcust_id %>");
	response.data.add("stPMcontract_no","<%= stPMcontract_no %>");
	response.data.add("stPMbelong_code","<%= stPMbelong_code %>");
	response.data.add("stPMsm_code","<%= stPMsm_code %>");
	response.data.add("stPMsm_name","<%= stPMsm_name %>");
	response.data.add("stPMsm_kind","<%= stPMsm_kind %>");
	response.data.add("stPMcust_name","<%= stPMcust_name %>");
	response.data.add("stPMuser_passwd","<%= stPMuser_passwd %>");
	response.data.add("stPMrun_code","<%= stPMrun_code %>");
	response.data.add("stPMrun_name","<%= stPMrun_name %>");
	response.data.add("stPMowner_grade","<%= stPMowner_grade %>");
	response.data.add("stPMgrade_name","<%= stPMgrade_name %>");
	response.data.add("stPMowner_type","<%= stPMowner_type %>");
	response.data.add("stPMtype_name","<%= stPMtype_name %>");
	response.data.add("stPMcust_address","<%= stPMcust_address %>");
	response.data.add("stPMid_type","<%= stPMid_type %>");
	response.data.add("stPMid_name","<%= stPMid_name %>");
	response.data.add("stPMid_iccid","<%= stPMid_iccid %>");
	response.data.add("stPMcard_type","<%= stPMcard_type %>");
	response.data.add("stPMcard_name","<%= stPMcard_name %>");
	response.data.add("stPMvip_no","<%= stPMvip_no %>");
	response.data.add("stPMgrpbig_flag","<%= stPMgrpbig_flag %>");
	response.data.add("stPMgrpbig_name","<%= stPMgrpbig_name %>");
	response.data.add("stPMbak_field","<%= stPMbak_field %>");
	response.data.add("stPMgroup_id","<%= stPMgroup_id %>");
	response.data.add("stPMcontact_person","<%= stPMcontact_person %>");
	response.data.add("stPMcontact_phone","<%= stPMcontact_phone %>");
	response.data.add("stPMowner_code","<%= stPMowner_code %>");
	response.data.add("stPMcredit_code","<%= stPMcredit_code %>");
	response.data.add("stPMmode_code","<%= stPMmode_code %>");
	response.data.add("stPMmode_name","<%= stPMmode_name %>");
	response.data.add("stPMtotalOwe","<%= stPMtotalOwe %>");
	response.data.add("stPMtotalPrepay","<%= stPMtotalPrepay %>");
	response.data.add("unbillFee","<%= unbillFee %>");
	response.data.add("accountNo","<%= accountNo %>");
	response.data.add("accountOwe","<%= accountOwe %>");
	response.data.add("openTime","<%= openTime %>");
	response.data.add("show1270V2","<%= show1270V2 %>");
	response.data.add("show_fee","<%= show_fee %>");
	response.data.add("prepayFee","<%= prepayFee %>");
	response.data.add("nobillpay","<%= nobillpay %>");
	response.data.add("now_prepayFee","<%= now_prepayFee %>");
	response.data.add("zx_yc_fee","<%= zx_yc_fee %>");
	response.data.add("pt_yc_fee","<%= pt_yc_fee %>");
	response.data.add("limitOwe","<%= limitOwe %>");
	
	
	core.ajax.receivePacket(response);