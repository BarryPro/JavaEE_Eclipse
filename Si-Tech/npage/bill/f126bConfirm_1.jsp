<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>

<%	
	String opCode = "126b";
	String opName = "Ԥ�滰������";
	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	
	String paraAray[] = new String[10];
	
  paraAray[0] = opCode;//��������
	paraAray[1] = request.getParameter("phoneNo");//�������
  paraAray[2] = work_no;//����
	paraAray[3] = request.getParameter("machine_type");//��������
	paraAray[4] = request.getParameter("should_fee");//�ۼ�Ԥ���
	paraAray[5] = request.getParameter("machine_fee");//�۸�
	paraAray[6] = request.getParameter("consume_term");//����ʱ��
  paraAray[7] = ip_Addr;//ip��ַ  
	paraAray[8] = request.getParameter("order_code");//��������
	paraAray[9] = request.getParameter("opNote");//������ע

	/*Ϊ��ӡ��֯����*/
	String op_type=request.getParameter("op_type");//�۷�����
	String printAccept=request.getParameter("printAccept");//��ӡ��ˮ	
	String bp_name=request.getParameter("bp_name");//�û�����
	String phoneNo = request.getParameter("phoneNo");//�������
	String machine_type = request.getParameter("machine_type");//��������
	String machine_fee = request.getParameter("machine_fee");//�۸�
	float fMachineFee = Float.parseFloat(machine_fee); 
	S1100View callView = new S1100View();
	String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(machine_fee,2)).get(0)))[0][2];//��д���
%>
<wtc:service name="s126b_ApplyEx" routerKey="phone" routerValue="<%=paraAray[1]%>" retcode="errCode" retmsg="errMsg" outnum="2" >
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
</wtc:service>

<wtc:array id="ret" scope="end"/>
	
<%
	
	
	System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	if(errCode.equals("0")||errCode.equals("000000")){
		if(ret.length>0){
		  //printAccept=ret[0][0];
		}
	}	
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+printAccept+"&pageActivePhone="+paraAray[1]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
	System.out.println("url="+url);	
	%>
	<jsp:include page="<%=url%>" flush="true" />
	<%
	System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%"); 
	
	
	
	if (errCode.equals("0")||errCode.equals("000000"))
	{
%>
<script language="jscript">
function printBill(){
	 var infoStr="";                                                                         
	 infoStr+="<%=work_no%>  <%=printAccept%>"+"  Ԥ�������ǰ��¿۷�"+"|";//����                                      
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��

     infoStr+="<%=bp_name%>"+"|";//�û����� 
     infoStr+=" "+"|";//����

	 infoStr+="<%=phoneNo%>"+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//Э�����                                                          
	 infoStr+=" "+"|";//֧Ʊ����  
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=WtcUtil.formatNumber(machine_fee,2)%>"+"|";//Сд

	 infoStr+="�����  <%=WtcUtil.formatNumber(machine_fee,2)%>"+
		 "~~~�����ͺţ�<%=machine_type%>"+"|";//��Ŀ

	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���

	 var dirtPage="/npage/obill/fa26b_login.jsp?opCode=a26b%26activePhone="+<%=paraAray[1]%>;
	 location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage;
}

</script>
<script language="JavaScript">
	   <%if(op_type.equals("9")){%>
	       rdShowMessageDialog("Ԥ�滰�������ɹ�,���潫��ӡ��Ʊ!");
           printBill();
	   <%}else{%>
		   rdShowMessageDialog("Ԥ�滰�������ɹ�!");
		   location="fa26b_login.jsp?opCode=a26b&activePhone"+paraAray[1];
	   <%}%>
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("Ԥ�滰������ʧ��!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>");
	history.go(-1);
</script>
<%}%>
