<%
  /*
   * 功能: 预存购机-合约
   * 版本: 1.0
   * 日期: 2013/9/2
   * 作者: diling
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ include file="/npage/public/posCCB.jsp" %>
<%@ include file="/npage/public/posICBC.jsp" %>
<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");

	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password"); 

	String cust_name=request.getParameter("oCustName");//机主姓名
	String Prepay_Fee=request.getParameter("sale_price");//应收金额
	String Base_Fee=request.getParameter("prepay_limit");//底线预存
	String Free_Fee=WtcUtil.repNull((String)request.getParameter("Free_Fee"));
	String Consume_Term=request.getParameter("contract_time");//合约期限
	String iAddStr=request.getParameter("iAddStr");//拼串
	String do_note=request.getParameter("do_note");//备注信息
	String payTypeSelect=request.getParameter("payTypeSelect");//缴费类型
	String sale_code=WtcUtil.repNull((String)request.getParameter("sale_code_Hidd"));//营销案类型	
	String p3=request.getParameter("p3");//手机型号		
  String IMEINo=request.getParameter("IMEINo");//IMEINo码
  String Save_Fee=request.getParameter("prepay_limit");//预存话费 
  String PhoneFree_Fee=WtcUtil.repNull((String)request.getParameter("PhoneFree_Fee"));
  String Active_Term=WtcUtil.repNull((String)request.getParameter("Active_Term"));
  
  
	System.out.println("======================= fg975_cfm.jsp ===============================");
	String payType				 = request.getParameter("payType");/**缴费类型 payType=BX 是建行 payType=BY 是工行**/
	String MerchantNameChs = request.getParameter("MerchantNameChs");/**从此开始以下为银行参数**/
	String MerchantId      = request.getParameter("MerchantId");
	String TerminalId      = request.getParameter("TerminalId");
	String IssCode         = request.getParameter("IssCode");
	String AcqCode         = request.getParameter("AcqCode");
	String CardNo          = request.getParameter("CardNo");
	String BatchNo         = request.getParameter("BatchNo");
	String Response_time   = request.getParameter("Response_time");
	String Rrn             = request.getParameter("Rrn");
	String AuthNo          = request.getParameter("AuthNo");
	String TraceNo         = request.getParameter("TraceNo");
	String Request_time    = request.getParameter("Request_time");
	String CardNoPingBi    = request.getParameter("CardNoPingBi");
	String ExpDate         = request.getParameter("ExpDate");
	String Remak           = request.getParameter("Remak");
	String TC              = request.getParameter("TC");
	/*gaopeng 2013/4/19 星期五 15:50:55 加入一个参数，用来判断是否中奖 ： 0 中奖 1 没中奖*/
	/*zhangyan 消费积分*/
	String used_point = WtcUtil.repNull((String)request.getParameter("markPoint"));
	
	String paraAray[] = new String[32];
	paraAray[0] = request.getParameter("printAccept");
	paraAray[1] = "01";
	paraAray[2] = opCode;
	paraAray[3] = work_no;
	paraAray[4] = password;
	paraAray[5] = request.getParameter("phoneNo");
	paraAray[6] = "";
	paraAray[7] = iAddStr;
	paraAray[8] = do_note;
	paraAray[9] = ip_Addr;
	paraAray[10] = payTypeSelect;
	paraAray[11] = "54";	

	paraAray[12] = payType				 ;
	paraAray[13] = MerchantNameChs ;
	paraAray[14] = MerchantId      ;
	paraAray[15] = TerminalId      ;
	paraAray[16] = IssCode         ;
	paraAray[17] = AcqCode         ;
	paraAray[18] = CardNo          ;
	paraAray[19] = BatchNo         ;
	paraAray[20] = Response_time   ;
	paraAray[21] = Rrn             ;
	paraAray[22] = AuthNo          ;
	paraAray[23] = TraceNo         ;
	paraAray[24] = Request_time    ;
	paraAray[25] = CardNoPingBi    ;
	paraAray[26] = ExpDate         ;
	paraAray[27] = Remak           ;
	paraAray[28] = TC              ;
	paraAray[29] = used_point      ;
	
%>
	<wtc:service name="sg975Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[13]%>"/>
		<wtc:param value="<%=paraAray[14]%>"/>
		<wtc:param value="<%=paraAray[15]%>"/>
		<wtc:param value="<%=paraAray[16]%>"/>
		<wtc:param value="<%=paraAray[17]%>"/>
		<wtc:param value="<%=paraAray[18]%>"/>
		<wtc:param value="<%=paraAray[19]%>"/>
		<wtc:param value="<%=paraAray[20]%>"/>
		<wtc:param value="<%=paraAray[21]%>"/>
		<wtc:param value="<%=paraAray[22]%>"/>
		<wtc:param value="<%=paraAray[23]%>"/>
		<wtc:param value="<%=paraAray[24]%>"/>
	  <wtc:param value="<%=paraAray[25]%>"/>		
	  <wtc:param value="<%=paraAray[26]%>"/>	
	  <wtc:param value="<%=paraAray[27]%>"/>		
	  <wtc:param value="<%=paraAray[28]%>"/>		
	  <wtc:param value="<%=paraAray[29]%>"/>		
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
			//PreFlag=result[0][0];
			//System.out.println("gaopengv587:-------------"+PreFlag);
			
%>
	<script language="JavaScript">
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
	</script>

<%
System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode1" retmsg="retMsg1">
			<wtc:param value="<%=WtcUtil.formatNumber(Prepay_Fee,2)%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
<%	
		String chinaFee = result1[0][2];   	//大写金额
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[5]+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<script language="JavaScript">
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}	
   rdShowMessageDialog("提交成功! 下面将打印发票！",2);
   
   var infoStr="";

   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       <%=opName%>"+"|";//工号
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//年
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";//月
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日
   infoStr+='<%=cust_name%>'+"|";//用户名称
   infoStr+=" "+"|";//卡号
   infoStr+='<%=paraAray[5]%>'+"|";//移动台号
   infoStr+=" "+"|";//协议号码
   infoStr+=" "+"|";//支票号码 
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(Prepay_Fee,2)%>"+"|";//小写
   //业务项目
	 infoStr+="手机型号：<%=p3%>   "+
		 "IMEI码："+"<%=IMEINo%>"+"~"+"缴费合计："+"<%=WtcUtil.formatNumber(Prepay_Fee,2)%>元"+"    含预存话费：<%=Save_Fee%>元"+"|";

	 
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 infoStr+=" "+"|";//收款人
	 infoStr+=" "+"|";//收款人
	
	/* ningtn add for pos start @ 20100430 */
		 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
		 		infoStr+="<%=payType%>"+"|";
			 	infoStr+="<%=MerchantNameChs%>"+"|";
				infoStr+="<%=CardNoPingBi   %>"+"|";
				infoStr+="<%=MerchantId     %>"+"|";
				infoStr+="<%=BatchNo        %>"+"|";
				infoStr+="<%=IssCode        %>"+"|";
				infoStr+="<%=TerminalId     %>"+"|";
				infoStr+="<%=AuthNo         %>"+"|";
				infoStr+="<%=Response_time  %>"+"|";
				infoStr+="<%=Rrn            %>"+"|";
				infoStr+="<%=TraceNo        %>"+"|";
				infoStr+="<%=AcqCode        %>"+"|";
		 }
	/* ningtn add for pos end @ 20100430 */
	dirtPate = "/npage/sg975/fg975_login.jsp?activePhone=<%=paraAray[5]%>&opCode=g975&opName=<%=opName%>";
   location="/npage/public/hljBillPrintNew.jsp?retInfo="+codeChg(infoStr)+"&op_code=g975&loginAccept=<%=paraAray[0]%>&dirtPage="+codeChg(dirtPate);
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("预存购机-合约失败!(<%=errMsg%>,<%=errCode%>",0);
	window.location="/npage/sg975/fg975_login.jsp?activePhone=<%=paraAray[5]%>&opCode=g975&opName=<%=opName%>";
</script>
<%}%>

