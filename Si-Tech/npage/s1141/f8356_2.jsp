<%
/********************
 version v2.0
开发商: si-tech
update:sunaj@2009-06-22
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String opCode = "8356";
	String opName = "购G3上网卡";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>

<%
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
  	String regionCode = orgCode.substring(0,2);
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("cardy");
	String card_money=request.getParameter("card_money");  /*上网流量费*/
	String pay_money=request.getParameter("pay_money");   /*赠预存*/
	String phone_type = request.getParameter("phone_type");
	String award_flag=request.getParameter("award_flag");
	//String prepay_fee=""+Float.parseFloat(pay_money);
	String phone_no = request.getParameter("phone_no");
    String op_code=request.getParameter("op_code");
   
	String new_opCode = request.getParameter("opcode");
	
	//liyan add end

    String paraAray[] = new String[22]; /*liyan modify at 20081222 19-->21 */
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = new_opCode ;
  	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
	paraAray[4] = request.getParameter("sale_type");
	paraAray[5] = request.getParameter("sale_code");
	paraAray[6] = request.getParameter("used_point");
	paraAray[7] = request.getParameter("sum_money");      /*应付金额*/
	/*paraAray[8] = prepay_fee;                              赠预存*/
	paraAray[8] = request.getParameter("pay_money");       /*赠预存*/
	paraAray[9] = request.getParameter("price");          /*卡费*/
	paraAray[10] = request.getParameter("net_money");     /*上网费*/
	paraAray[11] = request.getParameter("opNote");
	paraAray[12] = request.getParameter("ip_Addr");
	paraAray[13] = request.getParameter("phone_typename");
	paraAray[14] = request.getParameter("IMEINo");
	paraAray[15] = request.getParameter("payTime");
	paraAray[16] = request.getParameter("repairLimit");
	paraAray[17] = phone_type;
	paraAray[18] = award_flag;
	paraAray[19] = request.getParameter("secondphone2");
	paraAray[20] = request.getParameter("Consume_Term"); /*话费期限*/
	paraAray[21] = request.getParameter("Active_Term");  /*网费期限*/
	

%>
<wtc:service  name="s8356Cfm" routerKey="region" routerValue="<%=orgCode%>" outnum="2"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
	<wtc:param  value="<%=paraAray[6]%>"/>
	<wtc:param  value="<%=paraAray[7]%>"/>
	<wtc:param  value="<%=paraAray[8]%>"/>
	<wtc:param  value="<%=paraAray[9]%>"/>
	<wtc:param  value="<%=paraAray[10]%>"/>
	<wtc:param  value="<%=paraAray[11]%>"/>
	<wtc:param  value="<%=paraAray[12]%>"/>
	<wtc:param  value="<%=paraAray[13]%>"/>
	<wtc:param  value="<%=paraAray[14]%>"/>
	<wtc:param  value="<%=paraAray[15]%>"/>
	<wtc:param  value="<%=paraAray[16]%>"/>
	<wtc:param  value="<%=paraAray[17]%>"/>
	<wtc:param  value="<%=paraAray[18]%>"/>
	<wtc:param  value="<%=paraAray[19]%>"/>
	<wtc:param  value="<%=paraAray[20]%>"/>
	<wtc:param  value="<%=paraAray[21]%>"/>
	
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+phone_no+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
	System.out.println("==========================================="+url);
	if (errCode.equals("0")||errCode.equals("000000"))
	{
		String ipf = WtcUtil.formatNumber(paraAray[7],2);
	  String outParaNums= "4";
%>
  	<wtc:service  name="sToChinaFee" routerKey="region" routerValue="<%=orgCode%>" outnum="<%=outParaNums%>"  retcode="retCode2" retmsg="retMessage2">
	<wtc:param  value="<%=ipf%>"/>
	</wtc:service>
	<wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
	String chinaFee =chinaFee1[0][0];
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功! 打印发票！");
   var infoStr="";

   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       购G3上网卡"+"|";//工号	
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[3]%>'+"|";
   infoStr+=" "+"|";//协议号码
   infoStr+="上网卡品牌型号: "+'<%=paraAray[13]%>'+"|";//支票号码	
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(paraAray[7],2)%>"+"|";//小写

    
	var jkinfo="";
	jkinfo+="捆绑语音卡号码:<%=paraAray[19]%>"+",交款合计<%=paraAray[7]%>"+"元,赠送数据卡上网费<%=paraAray[10]%>"+"元,语音卡话费<%=paraAray[8]%>"+"元";　 
	
   //alert(jkinfo);
	 infoStr+=jkinfo+"|";
	// infoStr+="<%=work_name%>"+"|";//开票人
	infoStr+="<%=work_name%>"+"|";
	 infoStr+=" "+"|";//收款人
	 infoStr+="IMEI码：<%=paraAray[14]%>"+"|";
	 if( "<%=award_flag%>" == "1" )
	 {
	 		infoStr+="已参与赠送礼品活动"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }
	 location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1141/f8356_login.jsp?activePhone=<%=phone_no%>%26opCode=8356%26opName=购G3上网卡";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("购G3上网卡申请失败!(<%=errMsg%>",0);
	window.location="/npage/s1141/f8356_login.jsp?activePhone=<%=phone_no%>&opCode=8356&opName=购G3上网卡";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true"/>