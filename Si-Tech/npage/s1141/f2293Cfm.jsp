<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 统一预存赠礼冲正2293
   * 版本: 1.0
   * 日期: 2008/12/30
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
  <%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<!-- **** ningtn add for pos @ 20100430 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100430 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%	
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();   
	String opCode="2293";
	String opName="统一预存赠礼冲正";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String cust_name = request.getParameter("cust_name"); 
	String sum_money = request.getParameter("sum_money");
	String regionCode = (String)session.getAttribute("regCode");			//地市
	String chinaFee = "";													//大写金额
	String phoneNo = (String)request.getParameter("phone_no");				//手机号码
	String password = (String)session.getAttribute("password");
		///////<!-- ningtn add for pos start @ 20100430 -->
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
		
		String old_op_date   = request.getParameter("old_op_date");
		String backaccept    = request.getParameter("backaccept");
				System.out.println("-------hejwa----------------old_op_date--------->"+old_op_date);
				System.out.println("-------hejwa----------------backaccept---------->"+backaccept);		
		System.out.println("payType : " + payType);
		System.out.println("MerchantNameChs : " + MerchantNameChs);
		System.out.println("MerchantId : " + MerchantId);
		System.out.println("Response_time : " + Response_time);
		System.out.println("TerminalId : " + TerminalId);
		System.out.println("Request_time : " + Request_time);
		System.out.println("Rrn : " + Rrn);
		///////<!-- ningtn add for pos end @ 20100430 -->
		String flag            = request.getParameter("flag");/*huangroong add 标记是否是预约冲正 0：普通 1：预约*/
	String paraAray[] = new String[24];
	paraAray[0] = request.getParameter("login_accept");						//流水
	paraAray[1] = request.getParameter("phone_no");							//手机号码
	paraAray[2] = request.getParameter("opcode");
	paraAray[3] = work_no;
	paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
///////<!-- ningtn add for pos start @ 20100430 -->
		paraAray[6]  = payType				 ;
		paraAray[7]  = MerchantNameChs ;
		paraAray[8]  = MerchantId      ;
		paraAray[9]  = TerminalId      ;
		paraAray[10] = IssCode         ;
		paraAray[11] = AcqCode         ;
		paraAray[12] = CardNo          ;
		paraAray[13] = BatchNo         ;
		paraAray[14] = Response_time   ;
		paraAray[15] = Rrn             ;
		paraAray[16] = AuthNo          ;
		paraAray[17] = TraceNo         ;
		paraAray[18] = Request_time    ;
		paraAray[19] = CardNoPingBi    ;
		paraAray[20] = ExpDate         ;
		paraAray[21] = Remak           ;
		paraAray[22] = TC              ;
///////<!-- ningtn add for pos end @ 20100430 -->
		paraAray[23] = flag;
		System.out.println("paraAray[23]========================= : " + paraAray[23]);

//	String[] ret = impl.callService("s2293Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
	<wtc:service name="s2293Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
			
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>	
		<wtc:param value="<%=password%>"/>		
		<wtc:param value="<%=paraAray[1]%>"/>	
		<wtc:param value=" "/>	
				
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
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
//		S1100View callView = new S1100View();
//		String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(sum_money,2)).get(0)))[0][2];//大写金额

%>
	<script language="javascript">
		/*** ningtn add for pos start @ 20100430 *****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/*** ningtn add for pos end  @ 20100430 *****/
	</script>

	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
		<wtc:param value="<%=WtcUtil.formatNumber(sum_money,2)%>"/>
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
		   rdShowMessageDialog("确认成功! 下面将打印发票！",2);
		   var infoStr="";
		   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       统一预存赠礼冲正"+"|";//工号  
		   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=cust_name%>'+"|";
		   infoStr+=" "+"|";
		   infoStr+='<%=paraAray[1]%>'+"|";
		   infoStr+=" "+"|";//协议号码                                                          
		   infoStr+=" "+"|";
		   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
		   infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//小写 
		   infoStr+="退预存款：  <%=sum_money%>元"+"|";
				
			infoStr+="<%=work_name%>"+"|";//开票人
			infoStr+=" "+"|";//收款人
			
			 /**** ningtn add for pos start @ 20100409 ****/      
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
			 /**** ningtn add for pos end  @ 20100409****/        
			/*
			dirtPate = "/npage/s1141/f2289_login.jsp?activePhone=<%=phoneNo%>&opCode=2293&opName=统一预存赠礼冲正";
		  // location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
		   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate)+"&op_code=2293&loginAccept=<%=paraAray[0]%>";
		  */
		  var billArgsObj = new Object();
			$(billArgsObj).attr("10001","<%=work_no%>");
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
		 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
		 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=cust_name%>");
			$(billArgsObj).attr("10006","统一预存赠礼冲正");
			$(billArgsObj).attr("10008","<%=phoneNo%>");
			$(billArgsObj).attr("10015","-<%=WtcUtil.formatNumber(sum_money,2)%>");//小写
			$(billArgsObj).attr("10016","-<%=WtcUtil.formatNumber(sum_money,2)%>");//合计金额(大写) 传小写，公共页转换
			if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
				$(billArgsObj).attr("10019","*");//本次缴费：刷卡
			}else{
				$(billArgsObj).attr("10017","*");//现金
			}
			$(billArgsObj).attr("10020","");//入网费
			$(billArgsObj).attr("10021","");//手续费
			$(billArgsObj).attr("10022","");//选号费
			$(billArgsObj).attr("10023","");//押金
			$(billArgsObj).attr("10024","");//SIM卡费
			$(billArgsObj).attr("10025","-<%=WtcUtil.formatNumber(sum_money,2)%>");//预存金额
			$(billArgsObj).attr("10026","");//机器费
			$(billArgsObj).attr("10027","");//其他费
			$(billArgsObj).attr("10028","");//参与的营销活动名称
			$(billArgsObj).attr("10047","");//活动代码
			$(billArgsObj).attr("10030","<%=paraAray[0]%>");//业务流水
			$(billArgsObj).attr("10036","2293");
			$(billArgsObj).attr("10031","<%=work_name%>");//开票人
			if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
				$(billArgsObj).attr("10049","<%=payType%>");
				$(billArgsObj).attr("10050","<%=MerchantNameChs%>");
				$(billArgsObj).attr("10051","<%=CardNoPingBi%>");
				$(billArgsObj).attr("10052","<%=MerchantId%>");
				$(billArgsObj).attr("10053","<%=BatchNo%>");
				$(billArgsObj).attr("10054","<%=IssCode%>");
				$(billArgsObj).attr("10055","<%=TerminalId%>");
				$(billArgsObj).attr("10056","<%=AuthNo%>");
				$(billArgsObj).attr("10057","<%=Response_time%>");
				$(billArgsObj).attr("10058","<%=Rrn%>");
				$(billArgsObj).attr("10059","<%=TraceNo%>");
				$(billArgsObj).attr("10060","<%=AcqCode%>");
			}
			$(billArgsObj).attr("10072","2"); //冲正2
				
			var printInfo = "";
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			  //var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=确实要进行发票打印吗？";

			$(billArgsObj).attr("11215","<%=backaccept%>");   //流水号：--业务流水
			$(billArgsObj).attr("11216","<%=old_op_date%>".trim().substring(0,6)); //原业务日期			
						//发票项目修改为新路径
	    var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=确实要进行发票打印吗？";

			var path = path + "&infoStr="+printInfo+"&loginAccept=<%=paraAray[0]%>&opCode=2293&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop); 
			location = "/npage/s1141/f2289_login.jsp?activePhone=<%=phoneNo%>&opCode=2293&opName=统一预存赠礼冲正";
		</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("统一预存赠礼冲正失败!<%=errCode%><br />(<%=errMsg%>)",0);
	window.location="f2289_login.jsp?activePhone=<%=phoneNo%>&opCode=2293&opName=统一预存赠礼冲正";
</script>
<%}%>
