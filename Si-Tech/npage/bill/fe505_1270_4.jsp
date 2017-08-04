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
	System.out.println("ningtn fe505 1270_4[" + transTotal+"]");
%>
<script language="JavaScript">
function printBillE505() {
	 var infoStr="";        
	 var sum_money = parseFloat("<%=prepay_money%>")+parseFloat("<%=second_fee%>");                                                                
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=e505_sale_name%><%=opName2%>"+"|";//工号                                                 
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)10
	 infoStr+="<%=xx_money%>"+"|";//小写 
	
	 infoStr+="手机型号:"+'<%=brand_code%>'+"~";
	 infoStr+="IMEI号："+'<%=IMEINo%>'+"~";
	
	 infoStr+="缴款合计：  <%=prepay_fee%>"+ "元     含预存话费：" + sum_money + "元" + "|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"||"<%=payType%>"=="EI"){
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
			infoStr+="<%=transTotal     %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f8027.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=e505%26opName=合约计划购机";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e505&loginAccept=<%=stream%>&dirtPage=/npage/se505/se505_login.jsp?activePhone=<%=themob%>%26opCode=e505%26opName=合约计划购机";
}
function printBillE506() {
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=e505_sale_name%><%=opName2%>"+"|";//工号                                                 
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	
	 infoStr+="手机型号:"+'<%=brand_code%>'+"~";
	 //infoStr+="IMEI号："+'<%=IMEINo%>'+"~";
	 infoStr+="退款合计：<%=prepay_fee%>"+ "元" + "|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"||"<%=payType%>"=="EI"){
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
			infoStr+="<%=transTotal     %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 
	 var dirtPage=""; 
	 dirtPate = "/npage/bill/f8027.jsp";
	 //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=e506%26opName=合约计划购机冲正";
	 location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e506&loginAccept=<%=stream%>&dirtPage=<%=returnPage%>";
}
</script>