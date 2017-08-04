<%
  String opName = "订单冲正查询";
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>




<%

String opCode = "1170";

System.out.println("-------------------showBaseInfoj.jsp--------------"+opCode);

String phoneNo = request.getParameter("phoneNo");

String serOId = request.getParameter("serVId");

String opCode1 = request.getParameter("opCode1Hv");

String opCode2 = request.getParameter("opCode2Hv");

String loginAccept = request.getParameter("loginAcceptHv");

/* liujian add workNo and password 2012-4-5 15:59:15 begin */

String workNo = (String)session.getAttribute("workNo");

String password = (String) session.getAttribute("password");

String op_code = request.getParameter("opCode");

/* liujian add workNo and password 2012-4-5 15:59:15 end */







String regionCode = (String)session.getAttribute("regCode");



%>



<%String regionCode_sReverInfo = (String)session.getAttribute("regCode");%>
<wtc:utype name="sReverInfo" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sReverInfo%>">

          <wtc:uparam value="<%=phoneNo%>" type="String"/>

          <wtc:uparam value="<%=serOId%>" type="String"/>

          <wtc:uparam value="<%=opCode1%>" type="String"/>

          <wtc:uparam value="<%=opCode2%>" type="String"/>

          <wtc:uparam value="<%=loginAccept%>" type="LONG"/>

</wtc:utype>



<wtc:utype name="sPMQryUserInfo" id="retUserInfo" scope="end"  routerKey="region" routerValue="<%=regionCode%>">

     <wtc:uparam value="0" type="LONG"/>

     <wtc:uparam value="<%=phoneNo%>" type="STRING"/>

		 <wtc:uparam value="<%=workNo%>" type="string"/>

     <wtc:uparam value="<%=password%>" type="string"/>	

     <wtc:uparam value="<%=op_code%>" type="string"/>

</wtc:utype>



<%

	StringBuffer logBuffer = new StringBuffer(80);

	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);

	System.out.println(logBuffer.toString());

	String taocLeib = "";

	String taocanMingc = "";


	String czczOffert   = "";

	String czczOffertId = "";

	String czhzOffert = "";

	String czhzOffertId = "";

	String comeFlag = "";



	if(retVal.getSize("2.0")>0){

			czczOffertId  = retVal.getValue("2.0.2");

			czczOffert = retVal.getValue("2.0.2")+"--"+retVal.getValue("2.0.3");

			comeFlag = retVal.getValue("2.0.7");

	}
	String offerIdF3264= "";
  if(retVal.getSize("2.2")>0){
     if(retVal.getSize("2.2.0")>0){

     			offerIdF3264 =retVal.getValue("2.2.0.2");

	         taocanMingc = retVal.getValue("2.2.0.2") +"-->"+ retVal.getValue("2.2.0.3");

           taocLeib  = retVal.getValue("2.2.0.5");

	           }
	         }

	if(retVal.getSize("2.1")>0){

			czhzOffertId = retVal.getValue("2.1.2");

			czhzOffert =retVal.getValue("2.1.2")+"--"+retVal.getValue("2.1.3");

	}



%>

    <wtc:service name="sDynSqlCfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="220" />
			<wtc:param value="<%=czczOffertId%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end" />
<%

String baoNfee = "";

if(result_t.length>0&&result_t[0][0]!=null){

	baoNfee =result_t[0][0];

}





String retCode =retUserInfo.getValue(0);

String retMsg  =retUserInfo.getValue(1);



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



System.out.println("---------------stPMid_no--------------"+stPMid_no);

%>
<%!
String StrToPrice(String v_value)
{
	if(v_value.indexOf(".")!=-1){
  		v_value = v_value+"00";
  	}
  	else{
  		v_value = v_value+".00";
  	}
  	v_value = v_value.substring(0,v_value.indexOf(".")+3);
  	return v_value;
}
%>

<%String regionCode_sQUserOfferInst = (String)session.getAttribute("regCode");%>
<wtc:utype name="sQUserOfferInst" id="retVal1" scope="end"  routerKey="region" routerValue="<%=regionCode_sQUserOfferInst%>">

          <wtc:uparam value="<%=stPMid_no%>" type="LONG"/>

          <wtc:uparam value="99" type="LONG"/>

          <wtc:uparam value="0" type="LONG"/>

          <wtc:uparam value="0" type="LONG"/>

</wtc:utype>



<%

	String beginTime = "";

  String endTime = "";






	int countTempF = 0;

	countTempF = retVal1.getSize("2");



	for(int ij= 0;ij<countTempF;ij++){

		if(retVal1.getValue("2."+ij+".3").equals("10")&&retVal1.getValue("2."+ij+".8").equals("有效")){



			beginTime = retVal1.getValue("2."+ij+".5");

			endTime = retVal1.getValue("2."+ij+".6");



		}

	}



String beginTime1 = "";

String endTime1 = "";

try{

 Date tempDateV1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").parse(beginTime);

 beginTime1 =new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tempDateV1).toString();

 Date tempDateV2 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").parse(endTime);

 endTime1 =new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tempDateV2).toString();

 System.out.println("--------------beginTime1----------------"+beginTime1);

System.out.println("--------------endTime1----------------"+endTime1);



}catch(Exception e){



}





%>

<FORM method=post name="frm">

	<%@ include file="/npage/include/header_pop.jsp" %>

<div class="title">

	<div id="title_zi">查询详细信息</div>

</div>



<div class="input">

 <table cellspacing="0">

<%

if(opCode2.equals("3264")){
%>
<tr>
	<TD class="blue">客户名称 </TD>

		  <TD>

		   <%=stPMcust_name%>

		  </TD>
		  <TD class="blue">客户住址</TD>

		  <TD>

		  <%=stPMcust_address%>

		  </TD>
		</tr>
		 <tr>
		  <TD class="blue">证件类型</TD>

		  <TD>

		   <%=stPMid_name%>

		  </TD>

		  <TD class="blue">证件号码 </TD>

		  <TD>

		    <%=stPMid_iccid%>

		  </TD>


     </tr>
<tr>

		  <td  class="blue">业务品牌 </td>

      <td >

        <%=stPMsm_name%>

      </td>

		   <TD class="blue">运行状态 </TD>

		  <TD>

		    <%=stPMrun_name%>

		  </TD>
		</tr>
		<tr>
		  	<td class=blue >套餐类别 </td>


	<td> <%=taocLeib%>  </td>

	<td class="blue" >  套餐名称</td>

	<td id="tdHit3"> <%=taocanMingc%> </td>
		</tr>


<%} else{%>
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
		 <TR>

		  <TD class="blue">证件类型</TD>

		  <TD>

		   <%=stPMid_name%>

		  </TD>

		  <TD class="blue">证件号码 </TD>

		  <TD>

		    <%=stPMid_iccid%>

		  </TD>

		  <TD class="blue">客户住址</TD>

		  <TD>

		  <%=stPMcust_address%>

		  </TD>

		 </TR>

         <tr>

      <td  class="blue">业务品牌 </td>

      <td >

        <%=stPMsm_name%>

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

	 <%

		  	if(stPMtotalPrepay.indexOf(".")!=-1){

		  		stPMtotalPrepay = stPMtotalPrepay+"00";

		  	}else{

		  		stPMtotalPrepay = stPMtotalPrepay+".00";

		  		}
		  	stPMtotalPrepay = stPMtotalPrepay.substring(0,stPMtotalPrepay.indexOf(".")+3);
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
		  <TD class="blue">当前主套餐 </TD>
		  <TD id="tdHit2"><%=czczOffert%>  </TD>
	 </TR>
 <TR >
	    <TD class="blue">申请主套餐 </TD>
		  <TD id="tdHit1">
		  	<%=czhzOffert%>
		  </TD>
		  <TD class="blue"> 生效方式 </TD>
		  <TD>
		  	<%=comeFlag%>
	    </TD>
		  <TD class="blue"> </TD>
		  <TD>
		  	</TD>
	 </TR>
	 <%
if(opCode2.equals("1257")){
%>
<tr>
	<td class=blue>包年金额</td>
	 <%
		  	if(baoNfee.indexOf(".")!=-1){
		  		baoNfee = baoNfee+"00";
		  	}else{
		  		baoNfee = baoNfee+".00";
		  		}
		  	baoNfee = baoNfee.substring(0,baoNfee.indexOf(".")+3);
		  	%>
	<td><%=baoNfee%></td>
	<td class=blue>剩余金额</td>
	<td><%=baoNfee%></td>
	<td class=blue>包年开始时间</td>
	<td><%=beginTime1%></td>
</tr>
<tr>
	<td class=blue>包年结束时间 </td>
	<td> <%=endTime1%> </td>
	<td > &nbsp;</td>
	<td> &nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
</tr>
<%}

}%>

</table>

</div>
<%
if(!opCode2.equals("3264")){
%>
<div class="title">
	<div id="title_zi">套餐信息</div>
</div>
 <table cellspacing="0">
 	<tr>
 		<th>可选套餐名称</th>
 		<th>状态</th>
 		<th>开始时间</th>
 		<th>结束时间</th>
 		<th>套餐类别</th>
 		<th>生效方式</th>
 		<th>可选方式</th>
</tr>
<%
		 for(int ih=0;ih<retVal.getSize("2.3");ih++){
		 		%>
		 		<tr>
					<td>		<%=retVal.getValue("2.3."+ih+".3")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".6")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".8")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".9")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".5")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".7")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".10")%> 			</td>
		 		</tr>
		 		<%
		 }
%>
</table>


<%}%>

<%
if(opCode1.equals("1104") || opCode1.equals("q001")){
%>
<div class="title">
	<div id="title_zi">相关费用</div>
</div>
<table cellspacing="0">
	<tr>
		<TD class="blue">手续费 </TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.0"))%> </TD>
		<TD class="blue">选号费</TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.1"))%> </TD>
	</tr>
	<tr>
		<TD class="blue">预存款 </TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.2"))%> </TD>
		<TD class="blue">机器费</TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.3"))%> </TD>
	</tr>
	<tr>
		<TD class="blue">SIM卡费 </TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.4"))%> </TD>
		<TD class="blue">现金交款</TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.5"))%> </TD>
	</tr>
	<tr>
		<TD class="blue">支票交款 </TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.6"))%> </TD>
		<TD class="blue">退款总额</TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.7"))%> </TD>
	</tr>
</table>
<%}%>

<div class="title">

	<div id="title_zi">备注信息</div>

</div>



 <table cellspacing="0">

 	<tr>

 	 <td class="blue" width="15%">系统备注</td>

 	 <td></td>

</tr>

</table>





<table>

	<tr>

		<td id="footer">

			<input class="b_foot" name="quit"  onclick="window.close()"  type=button value="关闭"/>

		</td>

		</tr>

</table>

<%@ include file="/npage/include/footer_new.jsp" %>

 <SCRIPT type=text/javascript>

	var offerIdV1 = "<%=czhzOffertId%>";
	var offerIdV2 = "<%=czczOffertId%>";
	var offerIdV3 = "<%=offerIdF3264%>";


	<%if(opCode2.equals("3264")){%>
			getMidPrompt("10442",offerIdV3,"tdHit3");
	<%}else{%>

	getMidPrompt("10442",offerIdV1,"tdHit1");
	getMidPrompt("10442",offerIdV2,"tdHit2");

<%}%>

	getBeforePrompt();
	getAfterPrompt();

	function getBeforePrompt()
	{
		var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","请稍后...");
		packet.data.add("opCode" ,"<%=opCode2%>");
	    core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//异步
		packet =null;
	}
	function doGetBeforePrompt(data)
	{
		$('#wait').hide();
		$('#beforePrompt').html(data);
	}
</script>
