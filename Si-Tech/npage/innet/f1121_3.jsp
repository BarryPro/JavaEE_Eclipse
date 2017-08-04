<%
  /*
   * 功能: 全球通开户冲正1121
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<% request.setCharacterEncoding("GBK");%>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="1121";
	String op_code=opCode;
	String opName="普通开户冲正";
	String phoneNo = (String)request.getParameter("activePhone");
%>

<%
	Logger logger = Logger.getLogger("f1121_3.jsp");
	String thework_no = (String)session.getAttribute("workNo");					//操作工号
	String theip = (String)session.getAttribute("ipAddr");  					//IP地址
	String org_id = (String)session.getAttribute("orgId");          			//工号ID
	String org_code = (String)session.getAttribute("orgCode");      			//机构编码 (归属代码) 
	String regionCode = (String)session.getAttribute("regCode");
	 
%>

<%
	/*------------------------------得到调用s1121Cfm需要的参数----------------------------------------*/
	                                             
	String custid = ReqUtil.get(request,"i2");                                  //客户ID
	String userid = ReqUtil.get(request,"userid");                              //用户ID
	String accountid = ReqUtil.get(request,"accountid");                        //帐户ID
	String openrandom = ReqUtil.get(request,"openrandom");                      //开户流水
	
	String cheque = ReqUtil.get(request,"i14");                                 //支票交款
	String sysnote = ReqUtil.get(request,"sysnote");                            //系统备注
	String donote = ReqUtil.get(request,"i222");                                //操作备注
	String mobile = ReqUtil.get(request,"mob_phone");                           //手机号码
	String cash = ReqUtil.get(request,"i13"); 									//现金交款
	String custName = ReqUtil.get(request,"i5"); 								//用户名
	String innetFee = ReqUtil.get(request,"innetFee"); 							//入网费
	String handFee = ReqUtil.get(request,"i8"); 								//手续费
	String choiceFee = ReqUtil.get(request,"i9"); 								//选号费
	String machineFee = ReqUtil.get(request,"i11"); 							//机器费
	String simFee = ReqUtil.get(request,"i12"); 								//SIM卡费
	String prepayFee = ReqUtil.get(request,"i10"); 								//预存费
	//String stream = getMaxAccept();												//冲正流水
	String stream = ReqUtil.get(request,"stream"); 	
	String ret_code ="";
	String ret_msg="";
%>

<%
/*----------------------------开始调用s1121Cfm-----------------------------------------------*/
		String[] paraStrIn = new String[]{thework_no,custid,userid,accountid,op_code,openrandom,org_code,theip,cheque,sysnote,donote,mobile,org_id,stream};
		String outParaNums= "1";  
%>
	<wtc:service name="s1121Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=thework_no%>"/>
		<wtc:param value="<%=custid%>"/>
		<wtc:param value="<%=userid%>"/>
		<wtc:param value="<%=accountid%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=openrandom%>"/>
		<wtc:param value="<%=org_code%>"/>
		<wtc:param value="<%=theip%>"/>
		<wtc:param value="<%=cheque%>"/>
		<wtc:param value="<%=sysnote%>"/>
		<wtc:param value="<%=donote%>"/>
		<wtc:param value="<%=mobile%>"/>
		<wtc:param value="<%=org_id%>"/>
		<wtc:param value="<%=stream%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>	
<%		
		ret_code = retCode ;
		ret_msg = retMsg ;
	    String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName
		+"&workNo="+thework_no+"&loginAccept="+stream+"&pageActivePhone="+mobile+"&retMsgForCntt="+retMsg
		+"&opBeginTime="+opBeginTime;
		System.out.println("url=========================="+url);
%>
	<jsp:include page="<%=url%>" flush="true" />	
<%
	if(ret_code.equals("000000"))
	{
%>
<%
		String retInfo="";
		String note = custid + mobile + "普通开户" + "现金款:" + WtcUtil.formatNumber(cash,2) + "支票款:" + WtcUtil.formatNumber(cheque,2);
		retInfo="64|5|10|0|"+new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo += "72|5|10|0|"+new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo += "77|5|10|0|"+new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo = retInfo + "16|5|9|0|" + thework_no + "|";            //工号
		retInfo = retInfo + "24|5|9|0|" + openrandom + "|";            //流水
		retInfo = retInfo + "30|5|9|0|" + "全球通普通开户冲正费用明细" + "|";         //全球通开户交费明细
		
		retInfo = retInfo + "16|8|10|0|" + custName + "|";          	   //用户名
		retInfo = retInfo + "16|11|10|0|" + mobile+ "|";               //手机号
		retInfo = retInfo + "50|11|10|0|" + userid + "|"; 		       //协议号码
		String currentPay="";
		if(!cash.equals("")&&!cheque.equals(""))
		{
		 	currentPay = String.valueOf(Double.parseDouble(cash)+Double.parseDouble(cheque));
		}else if(cheque.equals("")&&!cash.equals("")){
			 cheque="0.00";
			 currentPay = String.valueOf(Double.parseDouble(cash));
		}else if(!cheque.equals("")&&cash.equals("")){
			 cash="0.00";
			 currentPay = String.valueOf(Double.parseDouble(cheque));
		}
		retInfo = retInfo + "65|14|10|0|" + currentPay  + "|";     									 //小写		
		String chinaFee= "";

%>
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=currentPay%>"/>
	</wtc:service>
	<wtc:array id="retArray" scope="end"/>
<%			
		chinaFee = retArray[0][2];
		
		retInfo = retInfo + "22|14|10|0|" + chinaFee + "|";                     						//大写
		retInfo = retInfo + "21|19|9|0|入网费：  " +  WtcUtil.formatNumber(innetFee,2) + "|";        	//入网费
		retInfo = retInfo + "50|19|9|0|手续费：    " + WtcUtil.formatNumber(handFee,2) + "|";        	//手续费
		retInfo = retInfo + "21|20|9|0|选号费：  " + WtcUtil.formatNumber(choiceFee,2) + "|";         	//选号费
		retInfo = retInfo + "50|20|9|0|机器费：    " + WtcUtil.formatNumber(machineFee,2) + "|";       	//机器费
		retInfo = retInfo + "21|21|9|0|SIM卡费： " + WtcUtil.formatNumber(simFee,2)+ "|";          		//SIM卡费
		retInfo = retInfo + "50|21|9|0|预存费：    " + WtcUtil.formatNumber(prepayFee,2) + "|";       	//预存费
		retInfo = retInfo + "21|22|9|0|现金款：  " + WtcUtil.formatNumber(cash,2) + "|";         		//现金款
		retInfo = retInfo + "50|22|9|0|支票款：    " + WtcUtil.formatNumber(cheque,2) + "|";       		//支票款
		
		retInfo = retInfo + "21|24|9|0|备注：    " + note + "|";										//备注

%>
<script language="javascript">
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
	var path = "spubPrint_1104.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&printInfo=<%=retInfo%>&submitCfm=submitCfm";
	var ret=window.showModalDialog(path,"",prop);
}
</script>
<script language="javascript">
	rdShowMessageDialog('全球通普通开户冲正成功!',2);
	showPrtDlg("Bill","确实要进行发票打印吗？","Yes");
	document.location.replace("<%=request.getContextPath()%>/npage/innet/f1121_1.jsp?activePhone=<%=phoneNo%>");
</script>
<%}else{%>
<script language="javascript">
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
	history.go(-1);
</script>
<%}%>
