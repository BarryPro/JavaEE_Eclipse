<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.text.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	String prepay_money = request.getParameter("prepay_money");
	String second_fee = request.getParameter("second_fee");
	String thework_no = request.getParameter("thework_no");
	String stream = request.getParameter("stream");
	String e505_sale_name = request.getParameter("e505_sale_name");
	String opName2 = request.getParameter("opName2");
	String name = request.getParameter("name");
	String themob = request.getParameter("themob");
	String chinaFee = request.getParameter("chinaFee");
	String xx_money = request.getParameter("xx_money");
	String brand_code = request.getParameter("brand_code");
	String IMEINo = request.getParameter("IMEINo");
	String prepay_fee = request.getParameter("prepay_fee");
	String work_name = request.getParameter("work_name");
	String payType = request.getParameter("payType");
	String MerchantNameChs = request.getParameter("MerchantNameChs");
	String CardNoPingBi = request.getParameter("CardNoPingBi");
	String MerchantId = request.getParameter("MerchantId");
	String BatchNo = request.getParameter("BatchNo");
	String IssCode = request.getParameter("IssCode");
	String TerminalId = request.getParameter("TerminalId");
	String AuthNo = request.getParameter("AuthNo");
	String Response_time = request.getParameter("Response_time");
	String Rrn = request.getParameter("Rrn");
	String TraceNo = request.getParameter("TraceNo");
	String AcqCode = request.getParameter("AcqCode");
	String transTotal = request.getParameter("transTotal");
	String returnPage = request.getParameter("returnPage");
	String sp_money = request.getParameter("sp_money");
	
	System.out.println("ningtn fe505 1270_4[" + transTotal+"]");
%>
<script language="JavaScript">
function printBillG122() {
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       购TD商务固话赠通信费"+"|";//工号                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 infoStr+="TD商务固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
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
	 /**** ningtn add for pos end ****/ 
	 var dirtPage="";
	 dirtPate = "/npage/bill/fg122_login.jsp?activePhone=<%=themob%>%26opCode=g122%26opName=购TD商务固话赠通信费";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=购TD商务固话赠通信费";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=g122&loginAccept=<%=stream%>&dirtPage=/npage/bill/fg122_login.jsp?activePhone=<%=themob%>%26opCode=g122%26opName=购TD商务固话赠通信费";
}
function printBillG123() { 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       购TD商务固话赠通信费冲正"+"|";//工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 infoStr+="TD商务固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
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
	 /**** ningtn add for pos end ****/
	 var dirtPage=""; 
	dirtPate = "/npage/bill/fg122_login.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/fg122_login.jsp?activePhone=<%=themob%>%26opCode=g122%26opName=购TD商务固话赠通信费";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=g122&loginAccept=<%=stream%>&dirtPage=/npage/bill/fg122_login.jsp?activePhone=<%=themob%>%26opCode=g122%26opName=购TD商务固话赠通信费";
}
function printBillG124(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       购TD商务固话赠通信费(铁通)"+"|";//工号                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 infoStr+="TD商务固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
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
	 /**** ningtn add for pos end ****/ 
	 var dirtPage="";	 
	dirtPate = "/npage/bill/fg124_login.jsp?activePhone=<%=themob%>%26opCode=g124%26opName=购TD商务固话赠通信费(铁通)";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=g124&loginAccept=<%=stream%>&dirtPage=/npage/bill/fg124_login.jsp?activePhone=<%=themob%>%26opCode=g124%26opName=购TD商务固话赠通信费(铁通)";
}
function printBillG125(){ 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       购TD商务固话赠通信费(铁通)冲正"+"|";//工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 infoStr+="TD商务固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
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
	 /**** ningtn add for pos end ****/
	 var dirtPage="";	 
	dirtPate = "/npage/bill/fg124_login.jsp";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=g124&loginAccept=<%=stream%>&dirtPage=/npage/bill/fg124_login.jsp?activePhone=<%=themob%>%26opCode=g124%26opName=购TD商务固话赠通信费(铁通)";
}
</script>