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
					smzname="实名";
			}
			if(smzvresultarry[0][0].equals("2")) {
					smzname="准实名";
			}
			if(smzvresultarry[0][0].equals("3")) {
					smzname="非实名";
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
//String sqlTempV1 = "select a.year_fee,b.prepay_fee  from dCustYearMsg a,dConMsgPre b,product_offer_attr c where a.CONTRACT_NO = b.CONTRACT_NO and b.PAY_TYPE = c.OFFER_ATTR_VALUE and c.OFFER_ATTR_SEQ = '5060' and a. id_no = to_number('"+stPMcust_id+"') and sysdate between a.begin_time and a.end_time";
//String sqlTempV1 = "select a.year_fee,b.prepay_fee  from dCustYearMsg a,dConMsgPre b,product_offer_attr c where a.CONTRACT_NO = b.CONTRACT_NO and b.PAY_TYPE = c.OFFER_ATTR_VALUE and a.mode_code=c.offer_id and c.OFFER_ATTR_SEQ = '5060' and a.id_no = to_number('"+stPMid_no+"') and sysdate between a.begin_time and a.end_time ";

String sqlTempV10 = "select a.offer_attr_value from product_offer_attr a,dcustyearmsg b where  a.offer_attr_seq = '5060' and a.offer_id = b.mode_code and b.id_no = :serv_id";
String [] paraIn1 = new String[2];
paraIn1[0]=sqlTempV10;
paraIn1[1]="serv_id="+stPMid_no;
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
	if(opCode.equals("1270")){
		show1270V1 = "用户积分/M值";
		show1270V2 = custJFv1;
	}
%>			 	
<div class="input">
 <table cellspacing="0">
 	
      <TR> 
		  <TD class="blue">移动号码</TD> 
		  <TD>
		   <%=stPMvPhoneNo%>
		  </TD>
		  <TD class="blue">客户ID </TD>
		  <TD>
		    <%=stPMcust_id%>
		  </TD>
		  <TD class="blue">客户名称 </TD>
		  <TD>
		   <%=stPMcust_name%>
		  </TD>
		 </TR>
         <tr>
      <td  class="blue">业务品牌 </td>
      <td >
        <%=stPMsm_name%>
        <input type="hidden" name="stPMsm_nameHi" id="stPMsm_nameHi" value="<%=stPMsm_name%>">
        <input type="hidden" name="stPMcust_addressHi" id="stPMcust_addressHi" value="<%=stPMcust_address%>">
        <input type="hidden" name="stPMid_no" id="stPMid_no" value="<%=stPMid_no%>">

        
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
		  	if(unbillFee.indexOf(".")!=-1){
		  		unbillFee = unbillFee+"00";
		  	}else{
		  		unbillFee = unbillFee+".00";
		  		}
		  		
		  	unbillFee = unbillFee.substring(0,unbillFee.indexOf(".")+3);	
		  	
		  	%>
		   <%=unbillFee%>
		  </TD>
		  <TD class="blue">可用预存 </TD>
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
	    <TD class="blue">集团客户类别 </TD>
		  <TD>
		    <%=stPMgrpbig_name%>
		  </TD>
		  
		  <TD class="blue">大客户类别 </TD>
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
	 //3275、127a、 127b 这三个业务的模块的要显示地址信息，其他的业务模块不显示地址信息
	 if(opCode.equals("127b")){
	 %>
			<TD class="blue">客户地址 </TD>
		  <TD colspan=3><%=stPMcust_address%>
		  	
		  	</TD>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 		<td class="blue">&nbsp;</td>
	 <%}else if(opCode.equals("1258")){%>
		<tr>
	 		<td class="blue">证件类型</td>
	 		<td class=""><%=stPMid_name%></td>
	 		<td class="blue">证件号码</td>
	 		<td class=""><%=stPMid_iccid%></td>
	 		<td class="blue">包年金额</td>
	 		
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
	 		<td class="blue">包年期初预存</td>
	 		<td class=""> <%=prepay_feeStr%></td>
	 		<td class="blue">包年未出帐话费</td>
	 		<td class=""> <%=stPMtotalOwe%></td>
	 		<td class="blue">包年当前可用余额</td>
	 		<td  ><%=dValueTemp%></td>
	 	</tr>
	 <%}else if(opCode.equals("3275")||opCode.equals("127a")){%>
	 	<tr>
	 		<td class="blue">证件类型</td>
	 		<td class=""><%=stPMid_name%></td>
	 		<td class="blue">证件号码</td>
	 		<td class=""><%=stPMid_iccid%></td>
	 		<TD class="blue">客户地址 </TD>
		  <TD colspan=3><%=stPMcust_address%></TD>
	 	</tr>
	 <%}else if( opCode.equals("3250") || opCode.equals("g720")){%>
	 	<tr>
			<td class="blue">证件类型</td>
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
	 	
	 		<td class="blue">证件类型</td>
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
						rdShowMessageDialog("无此用户信息!" , 0);		
						removeCurrentTab();								
					</script>
					<%
					}
					else
					{
					%>
			 		<td class="blue">白名单用户:</td>
			 		<td class="red" >
			 			
			 			<%
			 			if ( rstUm[0][0].equals("W"))
			 			{
			 			%>
			 				是
			 			<%
			 			}
			 			else if ( rstUm[0][0].equals("B"))
			 			{
			 			%>
			 				否 (在黑名单中)
			 			<%
			 			}
			 			else
			 			{
			 			%>
			 				否
			 			<%
			 			}
			 			%>
			 			
			 		</td>
			 		<td class="blue">智能网VPMN用户</td>
			 		<td class="red" >
			 			<%=( rstUm[0][1].equals("Y")?"是":"否" )%>		 			
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
			<td class="blue">商务公话用户</td>
			<td class="red" >
				<%=( rstUm[0][2].equals("Y")?"是":"否" )%>		 			
			</td>
			<td class="blue">一卡双号用户</td>
			<td class="red" >
				<%=( rstUm[0][3].equals("Y")?"是":"否" )%>		 			
			</td>	
			<td class="blue">中高端用户</td>		
			<td class="red" >
				<%=( rstUm[0][4].equals("Y")?"是":"否" )%>		 			
			</td>
		</tr>		
				<tr>
			<td class="blue">实名状态</td>
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
