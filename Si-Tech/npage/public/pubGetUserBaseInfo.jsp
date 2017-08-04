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

String stPMvPhoneNo       = ""; /*手机号码*/
String stPMid_no          = "";  /*用户id*/
String stPMcust_id        = "";  /*客户id*/
String stPMcontract_no    = "";  /*默认帐号*/
String stPMbelong_code    = "";  /*用户归属*/
String stPMsm_code        = "";  /*业务类型代码*/
String stPMsm_name        = "";  /*业务类型名称*/
String stPMsm_kind        = "";  /*c,g,d,e*/
String stPMcust_name      = "";  /*客户名称*/
String stPMuser_passwd    = "";  /*用户密码*/
String stPMrun_code       = "";  /*状态代码*/
String stPMrun_name       = "";  /*状态名称*/
String stPMowner_grade    = "";  /*等级代码*/
String stPMgrade_name     = "";  /*等级名称*/
String stPMowner_type     = "";  /*用户类型代码*/
String stPMtype_name      = "";  /*用户类型名称*/
String stPMcust_address   = "";  /*客户住址*/
String stPMid_type        = "";  /*证件类型*/
String stPMid_name        = "";  /*证件名称*/
String stPMid_iccid       = "";  /*证件号码*/
String stPMcard_type      = "";  /*客户卡类型*/
String stPMcard_name      = "";  /*客户卡类型名称*/
String stPMvip_no         = "";  /*VIP卡号*/
String stPMgrpbig_flag    = "";  /*集团客户标志*/
String stPMgrpbig_name    = "";  /*集团客户名称*/
String stPMbak_field      = "";  /*备用字段*/
String stPMgroup_id       = "";  /*归属标识*/
String stPMcontact_person = "";  /* 联系人  */
String stPMcontact_phone  = "";  /* 联系电话 */    
String stPMowner_code     = "";  /* 用户属性 */
String stPMcredit_code    = "";  /* 信用类型 */
String stPMmode_code      = "";  /* 当月基本产品ID*/
String stPMmode_name      = "";  /* 当月基本产品名称*/
String stPMtotalOwe       = "";  /*总欠费*/
String stPMtotalPrepay    = ""; /*总预存 包含专款预存的*/
String unbillFee          = ""; /*未出帐话费*/
String accountNo          = ""; /*第一个帐户*/
String accountOwe         = ""; /*第一个帐户欠费*/
String openTime           = ""; /*开户时间*/
String show_fee 					= ""; /*当前预存;*/
String prepayFee 					= "";	/*当前可划拨预存*/
String nobillpay 					= ""; /*未出账话费*/
String now_prepayFee 			= "";	/*当前可用预存*/
String zx_yc_fee					= ""; /*专款预存余额*/
String pt_yc_fee					= "";	/*普通预存余额*/
if(retCode.equals("0"))
{
stPMvPhoneNo       = retUserInfo.getValue("2.0.2.0");   /*手机号码*/
stPMid_no          = retUserInfo.getValue("2.0.2.1");   /*用户id*/
stPMcust_id        = retUserInfo.getValue("2.0.2.2");   /*客户id*/
stPMcontract_no    = retUserInfo.getValue("2.0.2.3");   /*默认帐号*/
stPMbelong_code    = retUserInfo.getValue("2.0.2.4");   /*用户归属*/
stPMsm_code        = retUserInfo.getValue("2.0.2.5");   /*业务类型代码*/
stPMsm_name        = retUserInfo.getValue("2.0.2.6");   /*业务类型名称*/
stPMsm_kind        = retUserInfo.getValue("2.0.2.7");   /*c,g,d,e*/
stPMcust_name      = retUserInfo.getValue("2.0.2.8");   /*客户名称*/
stPMuser_passwd    = retUserInfo.getValue("2.0.2.9");   /*用户密码*/
stPMrun_code       = retUserInfo.getValue("2.0.2.10");  /*状态代码*/
stPMrun_name       = retUserInfo.getValue("2.0.2.11");  /*状态名称*/
stPMowner_grade    = retUserInfo.getValue("2.0.2.12");  /*等级代码*/
stPMgrade_name     = retUserInfo.getValue("2.0.2.13");  /*等级名称*/
stPMowner_type     = retUserInfo.getValue("2.0.2.14");  /*用户类型代码*/
stPMtype_name      = retUserInfo.getValue("2.0.2.15");  /*用户类型名称*/
stPMcust_address   = retUserInfo.getValue("2.0.2.16");  /*客户住址*/
stPMid_type        = retUserInfo.getValue("2.0.2.17");  /*证件类型*/
stPMid_name        = retUserInfo.getValue("2.0.2.18");  /*证件名称*/
stPMid_iccid       = retUserInfo.getValue("2.0.2.19");  /*证件号码*/
stPMcard_type      = retUserInfo.getValue("2.0.2.20");  /*客户卡类型*/
stPMcard_name      = retUserInfo.getValue("2.0.2.21");  /*客户卡类型名称*/
stPMvip_no         = retUserInfo.getValue("2.0.2.22");  /*VIP卡号*/
stPMgrpbig_flag    = retUserInfo.getValue("2.0.2.23");  /*集团客户标志*/
stPMgrpbig_name    = retUserInfo.getValue("2.0.2.24");  /*集团客户名称*/
stPMbak_field      = retUserInfo.getValue("2.0.2.25");  /*备用字段*/
stPMgroup_id       = retUserInfo.getValue("2.0.2.26");  /*归属标识*/
stPMcontact_person = retUserInfo.getValue("2.0.2.27");  /* 联系人  */
stPMcontact_phone  = retUserInfo.getValue("2.0.2.28");  /* 联系电话 */    
stPMowner_code     = retUserInfo.getValue("2.0.2.29");  /* 用户属性 */
stPMcredit_code    = retUserInfo.getValue("2.0.2.30");  /* 信用类型 */
stPMmode_code      = retUserInfo.getValue("2.0.2.31");  /* 当月基本产品ID*/
stPMmode_name      = retUserInfo.getValue("2.0.2.32");  /* 当月基本产品名称*/
stPMtotalOwe       = retUserInfo.getValue("2.0.2.33");  /*总欠费*/
stPMtotalPrepay    = retUserInfo.getValue("2.0.2.34");  /*总预存*/
unbillFee          = retUserInfo.getValue("2.0.2.35");  /*未出帐话费*/
accountNo          = retUserInfo.getValue("2.0.2.36");  /*第一个帐户*/
accountOwe         = retUserInfo.getValue("2.0.2.37");  /*第一个帐户欠费*/
openTime           = retUserInfo.getValue("2.0.2.38");  /*开户时间*/
}
	String custJFv1 = "";

	//wanghfa修改积分查询方式 2011/6/13 start
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
		custJFv1 = "没有符合条件的数据!";
		return;
	} else {
		custJFv1 = mainQryArr[0][0];
	}
//wanghfa修改积分查询方式 2011/6/13 start
	
	String show1270V1 = "";
	String show1270V2 = "";
	show1270V1 = "用户积分/M值";
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
			show_fee = s1500FeeArr[0][2]; 	/*当前预存;*/
			prepayFee = s1500FeeArr[0][3];	/*当前可划拨预存*/
			nobillpay = s1500FeeArr[0][4];	/*未出账话费*/
			now_prepayFee = s1500FeeArr[0][5];/*当前可用预存*/
			zx_yc_fee=s1500FeeArr[0][6];		/*专款预存余额*/
			pt_yc_fee=s1500FeeArr[0][7];		/*普通预存余额*/
		}
	}
	System.out.println("ningtn pubGetUserBaseInfo retCode " + retCode);
	/*查询信誉度信息*/
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