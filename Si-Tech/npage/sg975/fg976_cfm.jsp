<%
  /*
   * 功能: 预存购机-合约冲正 g976
   * 版本: 1.0
   * 日期: 2013/9/2
   * 作者: diling
   * 版权: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ include file="/npage/public/posCCB.jsp" %>
<%@ include file="/npage/public/posICBC.jsp" %>
<%	
	String opCode=(String)request.getParameter("opCode");	
	String opName=(String)request.getParameter("opName");	
	String cust_name = request.getParameter("cust_name"); 
	String CashPay = request.getParameter("CashPay");     //缴费合计
	String chinaFee = "";													//大写金额
	String phoneNo = (String)request.getParameter("phone_no");				//手机号码
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");			//地市
	String password = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	
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
	System.out.println("payType : " + payType);
	System.out.println("MerchantNameChs : " + MerchantNameChs);
	System.out.println("MerchantId : " + MerchantId);
	System.out.println("Response_time : " + Response_time);
	System.out.println("TerminalId : " + TerminalId);
	System.out.println("Request_time : " + Request_time);
	System.out.println("Rrn : " + Rrn);


	String paraAray[] = new String[28];
	paraAray[0] = request.getParameter("login_accept");						//流水
	paraAray[1] = "01";
	paraAray[2] = opCode;
	paraAray[3] = work_no;
	paraAray[4] = password;
	paraAray[5] = request.getParameter("phone_no");							//手机号码	
	paraAray[6] = "";
	paraAray[7] = request.getParameter("iAddStr");							//营销案信息串
	paraAray[8] = request.getParameter("opNote");							//注释信息	
	paraAray[9] = ip_Addr;                                    //IP地址
	paraAray[10] = request.getParameter("backaccept");         //冲正流水


	paraAray[11]  = payType				 ;
	paraAray[12]  = MerchantNameChs ;
	paraAray[13]  = MerchantId      ;
	paraAray[14]  = TerminalId      ;
	paraAray[15] = IssCode         ;
	paraAray[16] = AcqCode         ;
	paraAray[17] = CardNo          ;
	paraAray[18] = BatchNo         ;
	paraAray[19] = Response_time   ;
	paraAray[20] = Rrn             ;
	paraAray[21] = AuthNo          ;
	paraAray[22] = TraceNo         ;
	paraAray[23] = Request_time    ;
	paraAray[24] = CardNoPingBi    ;
	paraAray[25] = ExpDate         ;
	paraAray[26] = Remak           ;
	paraAray[27] = TC              ;

%>
	<wtc:service name="sg976Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
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
		<wtc:param value="<%=paraAray[12]%>"/>
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
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
%>
	<script language="javascript">
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
	</script>

	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
		<wtc:param value="<%=WtcUtil.formatNumber(CashPay,2)%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    if(result.length>0 && sToChinaFeeCode.equals("0")){
        chinaFee = result[0][2];
    }
    
	System.out.print(chinaFee);
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
	System.out.println("url===="+url);
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
		   rdShowMessageDialog("确认成功! 下面将打印发票！",2);
		   var infoStr="";
		   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       <%=opName%>"+"|";//工号  
		   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=cust_name%>'+"|";
		   infoStr+=" "+"|";
		   infoStr+='<%=paraAray[5]%>'+"|";//协议号码                                                          
		   infoStr+=" "+"|";
		   infoStr+=" "+"|";
		   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
		   infoStr+="<%=WtcUtil.formatNumber(CashPay,2)%>"+"|";//小写 
		   infoStr+="应退金额：<%=CashPay%>元"+"|";
				
			infoStr+="<%=work_name%>"+"|";//开票人
			infoStr+=" "+"|";//收款人
			 
			 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){      
			 		infoStr+=" "+"|";/*占位第15个参数*/               
			 		infoStr+=" "+"|";/*占位第16个参数*/               
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

			  dirtPate = "/npage/sg975/fg975_login.jsp?activePhone=<%=phoneNo%>&opCode=g976&opName=<%=opName%>";
		    location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=g976&loginAccept=<%=paraAray[0]%>&dirtPage="+codeChg(dirtPate);
		</script>
<%
	}else{
%>   
    <script language="JavaScript">
    	rdShowMessageDialog("预存购机-合约冲正失败!<%=errCode%><br/>(<%=errMsg%>)",0);
    	window.location="/npage/sg975/fg975_login.jsp?activePhone=<%=phoneNo%>&opCode=g976&opName=<%=opName%>";
    </script>
<%}%>
