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
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=e505_sale_name%><%=opName2%>"+"|";//����                                                 
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)10
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+"~";
	 infoStr+="IMEI�ţ�"+'<%=IMEINo%>'+"~";
	
	 infoStr+="�ɿ�ϼƣ�  <%=prepay_fee%>"+ "Ԫ     ��Ԥ�滰�ѣ�" + sum_money + "Ԫ" + "|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"||"<%=payType%>"=="EI"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
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
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=e505%26opName=��Լ�ƻ�����";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e505&loginAccept=<%=stream%>&dirtPage=/npage/se505/se505_login.jsp?activePhone=<%=themob%>%26opCode=e505%26opName=��Լ�ƻ�����";
}
function printBillE506() {
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=e505_sale_name%><%=opName2%>"+"|";//����                                                 
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+"~";
	 //infoStr+="IMEI�ţ�"+'<%=IMEINo%>'+"~";
	 infoStr+="�˿�ϼƣ�<%=prepay_fee%>"+ "Ԫ" + "|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"||"<%=payType%>"=="EI"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
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
	 //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=e506%26opName=��Լ�ƻ���������";
	 location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e506&loginAccept=<%=stream%>&dirtPage=<%=returnPage%>";
}
</script>