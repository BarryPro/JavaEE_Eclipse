<%@ page contentType="text/html; charset=GB2312" %>
 
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>


<%
	String contractno = request.getParameter("contractno");
	String workNo = request.getParameter("workno");
	String payAccept = request.getParameter("payAccept");
	String total_date = request.getParameter("total_date");
	String checkno = request.getParameter("checkNo");
	String op_code="1302";
	String pageActivePhone = WtcUtil.repNull(request.getParameter("phoneno"));
	String returnPage = "s1300.jsp?activePhone="+pageActivePhone+"&opCode=5255&opName=���г�ֵ�ʻ��ɷ�";
    if (request.getParameter("returnPage") != null) {
	   returnPage = request.getParameter("returnPage");
	   System.out.println("returnPage======"+returnPage);
	}

	String workno =  (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");

    java.util.Random r = new java.util.Random();
		int ran = r.nextInt(9999);
		int ran1 = r.nextInt(10)*1000;
		if((ran+"").length()<4){
			ran = ran+ran1;
		}
		int key = 99999;
		int realKey = ran ^ key;
		System.out.println("realKey��"+realKey);
		 
		String bill_type = "2";
	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
    
	String[] inParas = new String[4];
	inParas[0] = workNo;
	inParas[1] = contractno;
	inParas[2] = total_date;
	inParas[3] = payAccept;
%>
	<wtc:service name="s1300PrtChk" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode1" retmsg="retMsg1" outnum="16">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%     
	String return_code = result[0][0];
 	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
 	
if ( return_code.equals("000000") )
{

    String phoneNo =result[0][5].trim();
	if(phoneNo.equals("99999999999"))
         phoneNo="";


%>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">

<SCRIPT language="JavaScript">

function printInvoice()
{ 
    printctrl.Setup(0) ;
		printctrl.StartPrint();
		printctrl.PageStart();


        //new begin
		printctrl.Print(20, 10, 9, 0, "<%=result[0][3].substring(0,4)%><%=result[0][3].substring(4,6)%><%=result[0][3].substring(6,8)%>");
		printctrl.Print(50, 10, 9, 0, "�ʵ�ͨ��ҵ");
		printctrl.Print(13, 12, 9, 0, "��α�룺<%=ran%>");

		printctrl.Print(13, 13, 9, 0, "��    �ţ�<%=workNo%>");
        printctrl.Print(42, 13, 9, 0, "������ˮ��<%=payAccept%>");
	    printctrl.Print(65, 13, 9, 0, "ҵ�����ƣ�����<%=result[0][2]%>");

     

        printctrl.Print(13, 14, 9, 0, "�ͻ����ƣ�<%=result[0][4]%>");
		printctrl.Print(65, 14, 9, 0, "��    �ţ�");   
 
        printctrl.Print(13, 15, 9, 0, "�ֻ����룺<%=phoneNo%>");
 
   
        printctrl.Print(42, 15, 9, 0, "Э����룺<%=result[0][6]%>");
        printctrl.Print(65, 15, 9, 0, "֧Ʊ���룺<%=result[0][7]%>");

        printctrl.Print(13, 16, 9, 0, "�ϼƽ�(��д)<%=result[0][8]%>");
        printctrl.Print(65, 16, 9, 0, "(Сд)��<%=result[0][9].trim()%>");
		

		printctrl.Print(13, 17, 9, 0, "(��Ŀ)");
		printctrl.Print(13, 19, 9, 0, "<%=result[0][10]%>");
        printctrl.Print(13, 20, 9, 0, "<%=result[0][11]%>");
        printctrl.Print(13, 21, 9, 0, "<%=result[0][12]%>"); 
		printctrl.Print(13,22,9,0,"���վ�Ϊ���г�ֵҵ�������Ԥ���ר�ã����г�ֵ�ʻ���Ǯ��ð����˿") ;
		printctrl.Print(13,23,9,0,"���������Ԥ�������κ�Ӫ������");
		printctrl.Print(13, 30, 10, 0, "��Ʊ��<%=workname%>");
		printctrl.Print(37, 30, 10, 0, "�տ");
		printctrl.Print(65, 30, 10, 0, "���ˣ�");

 

 		printctrl.PageEnd() ;
		printctrl.StopPrint() ; 
}

function ifprint()
{
  			printInvoice();
 			document.location.replace("<%=returnPage%>");
 } 
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

</body>
</html>
<%}
else
{
%>
	 <script language="JavaScript">
			rdShowMessageDialog("�վݴ�ӡ����,��ʹ�ò����վݽ��״�ӡ�վ�!<br>������룺'<%=return_code%>'��������Ϣ��'<%=error_msg%>'��",0);
			document.location.replace("<%=returnPage%>");
	 </script>
<%
	}
%>