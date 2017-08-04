<%
/*
 * 功能: 省内携号
 * 版本: 1.0
 * 日期: 2012/3/9 14:19:13
 * 作者: zhangyan
 * 版权: si-tech
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
String stPMtotalPrepay    = ""; /*总预存*/
String unbillFee          = ""; /*未出帐话费*/
String accountNo          = ""; /*第一个帐户*/
String accountOwe         = ""; /*第一个帐户欠费*/
String openTime           = ""; /*开户时间*/
System.out.println("zhangyan!!!retCodeM!!!!!!!!!!!!!!!!!!!!"+retCodeM+"!!!!!!!!!");
if(retCodeM.equals("0"))
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
	custJFv1 = "没有符合条件的数据!";
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
	showE687V1 = "用户积分/M值";
	showE687V2 = custJFv1;
}
%>			 	
<div class="input">
<table cellspacing="0">
<TR> 
	<TD class="blue">移动号码	</TD> 
	<TD><%=stPMvPhoneNo%>			</TD>
	<TD class="blue">客户ID 	</TD>
	<TD><%=stPMcust_id%>			</TD>
	<TD class="blue">客户名称 </TD>
	<TD><%=stPMcust_name%>		</TD>
</TR>
<tr>
	<td  class="blue">业务品牌 </td>
	<td >
		<%=stPMsm_name%>
		<input type="hidden" name="stPMsm_nameHi" id="stPMsm_nameHi" 
			value="<%=stPMsm_name%>">
		<input type="hidden" name="stPMcust_addressHi" id="stPMcust_addressHi" 
			value="<%=stPMcust_address%>">
		<input type="hidden" name="stPMid_no" id="stPMid_no" 
			value="<%=stPMid_no%>">
		</td>
	<td class="blue">开户时间 </td>
	<td>
		<%=openTime%>
	</td>      
	<TD class="blue">业务类型 </TD>
	<TD>
		<%=stPMsm_name%>
	</TD>
</tr>
<TR> 
	<TD class="blue">运行状态 </TD>
	<TD>
		<%=stPMrun_name%>
	</TD>
	<TD class="blue">未出帐话费 </TD>
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
	<TD class="blue">可用预存 </TD>
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
	<TD class="blue">集团客户类别 </TD>
	<TD>
	<%=stPMgrpbig_name%>
	</TD>
	<TD class="blue">大客户类别 </TD>
	<TD>
	<%=stPMcard_name%>
	</TD>  
	<TD class=blue><%=showE687V1%>&nbsp; </TD>
	<TD><%=showE687V2%>&nbsp;  </TD>
</TR>
	 	<tr>
	 		<td class="blue">证件类型</td>
	 		<td class=""><%=stPMid_name%></td>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 	</tr>
</table>
</div>
