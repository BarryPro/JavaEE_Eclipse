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
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ��TD����̻���ͨ�ŷ�"+"|";//����                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 infoStr+="TD����̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
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
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage="";
	 dirtPate = "/npage/bill/fg122_login.jsp?activePhone=<%=themob%>%26opCode=g122%26opName=��TD����̻���ͨ�ŷ�";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=��TD����̻���ͨ�ŷ�";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=g122&loginAccept=<%=stream%>&dirtPage=/npage/bill/fg122_login.jsp?activePhone=<%=themob%>%26opCode=g122%26opName=��TD����̻���ͨ�ŷ�";
}
function printBillG123() { 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ��TD����̻���ͨ�ŷѳ���"+"|";//����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 infoStr+="TD����̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
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
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage=""; 
	dirtPate = "/npage/bill/fg122_login.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/fg122_login.jsp?activePhone=<%=themob%>%26opCode=g122%26opName=��TD����̻���ͨ�ŷ�";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=g122&loginAccept=<%=stream%>&dirtPage=/npage/bill/fg122_login.jsp?activePhone=<%=themob%>%26opCode=g122%26opName=��TD����̻���ͨ�ŷ�";
}
function printBillG124(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ��TD����̻���ͨ�ŷ�(��ͨ)"+"|";//����                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 infoStr+="TD����̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
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
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage="";	 
	dirtPate = "/npage/bill/fg124_login.jsp?activePhone=<%=themob%>%26opCode=g124%26opName=��TD����̻���ͨ�ŷ�(��ͨ)";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=g124&loginAccept=<%=stream%>&dirtPage=/npage/bill/fg124_login.jsp?activePhone=<%=themob%>%26opCode=g124%26opName=��TD����̻���ͨ�ŷ�(��ͨ)";
}
function printBillG125(){ 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ��TD����̻���ͨ�ŷ�(��ͨ)����"+"|";//����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 infoStr+="TD����̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
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
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage="";	 
	dirtPate = "/npage/bill/fg124_login.jsp";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=g124&loginAccept=<%=stream%>&dirtPage=/npage/bill/fg124_login.jsp?activePhone=<%=themob%>%26opCode=g124%26opName=��TD����̻���ͨ�ŷ�(��ͨ)";
}
</script>