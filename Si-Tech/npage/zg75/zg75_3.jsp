<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.util.MoneyUtil"%>
<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	MoneyUtil mon = new MoneyUtil();
	String opName = "�½ᷢƱ��ӡ";
	String phoneno= request.getParameter("phoneno");
	String returnPage="zg75_1.jsp?activePhone="+phoneno;
	String return_code="";       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	String workno = (String)session.getAttribute("workNo");
	String check_seq= request.getParameter("check_seq");
	String bill_code= request.getParameter("bill_code");
	String login_accept= request.getParameter("login_accept");
	
	String print_begin= request.getParameter("print_begin");//��������
	String nopass = (String)session.getAttribute("password");
	String invoice_money= request.getParameter("invoice_money");//��Ʊ��ӡ���
	String s_time= request.getParameter("s_time");
	String cust_name = request.getParameter("cust_name"); 
	String sm_name = request.getParameter("sm_name"); 
	String txfwf = request.getParameter("txfwf"); 
	String xszk = request.getParameter("xszk"); 
	String hj = request.getParameter("hj"); 
	String ykjje = request.getParameter("ykjje"); 
	String yckykjje = request.getParameter("yckykjje"); 
	String czkykjje = request.getParameter("czkykjje"); 
	String xtcz = request.getParameter("xtcz"); 
	String qt = request.getParameter("qt"); 
	String groupId = (String)session.getAttribute("groupId");
	String s_yyt_name="";
	//xl add ������֯�ڵ��ѯӪҵ������
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;

	//xl add hytcf
	String hytcf = request.getParameter("hytcf"); 
	String s_flag = request.getParameter("s_flag");
	//s_flag="N";
	//hytcf="10";
%>
	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
<%
	if(yyt_name_arr!=null&&yyt_name_arr.length>0)
	{
		s_yyt_name = yyt_name_arr[0][0];
	}

	String paraAray[] = new String[16]; 
	paraAray[0] = login_accept;
	paraAray[1] = "01";
	paraAray[2] = "zg75";
	paraAray[3] = workno;
	paraAray[4] = nopass;
	paraAray[5] = phoneno;
	paraAray[6] = "";
	paraAray[7] = "�½��˵���ӡ";
	paraAray[8] = s_time;  
	paraAray[9] = print_begin;  
	paraAray[10] = invoice_money;  
	paraAray[11] = check_seq; 
	paraAray[12] = bill_code; 
    paraAray[13] = ""; 
	paraAray[14] = ""; 
	paraAray[15] = hytcf; 
	String year = s_time.substring(0, 4);
    String month = s_time.substring(4, 6);
    String day = s_time.substring(6, 8);
 
%>
<wtc:service name="bs_zg17Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode2" retmsg="sMsg2" outnum="2" >
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
</wtc:service>
<wtc:array id="sArr" scope="end"/>
<%
	String retCode2= sCode2;
	String retMsg2 = sMsg2;
	return_code=sCode2;
    if (return_code.equals("000000")) {
     
	 
			String result[][] = new String[][]{};
			 
			if(result==null||result.length==0){
		     
		        
	
		   
			  
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT language="JavaScript">
    function printInvoice()
    {
        var localPath = "C:/billLogo.jpg";
		//alert(2);
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
		var rowInit = 7;
		var fontSizeInit = 9;//�����С
		var fontType = "����";//����
		var fontStrongInit = 0;//�����ϸ
		var vR = 0;
		var lineSpace = 0;
        //alert(3);
        /*20100528 liuxmc ��ӷ�Ʊ��α��*/
		printctrl.DrawImage(localPath,8,10,40,18); 
        printctrl.Print(20, 10, 9, 0, "��Ʊ����:<%=year%>��<%=month%>��<%=day%>��");
		printctrl.Print(115, 10, 9, 0, "���η�Ʊ����:<%=check_seq%>"); 
		/*******************************************/
 
		printctrl.Print(13, 13, 8, 0, "�ͻ�����:<%=cust_name%>");
		printctrl.Print(13, 14, 8, 0, "ҵ�����:<%=opName%>");
		printctrl.Print(115, 14, 8, 0, "�ͻ�Ʒ��:<%=sm_name%>");

		printctrl.Print(13, 15, 8, 0, "�û����룺<%=phoneno%>");	
		printctrl.Print(62, 15, 8, 0, "��������:<%=print_begin%>");
		printctrl.Print(115, 15, 8, 0, "��ͬ��:");

		printctrl.Print(13, 16, 8, 0, "ͨ�ŷ����:<%=txfwf%>");
		printctrl.Print(13, 17, 8, 0, "��Լ�ײͷ�:<%=hytcf%>");
		printctrl.Print(13, 18, 8, 0, "�����ۿ�:<%=xszk%>");
		printctrl.Print(13, 19, 8, 0, "�ϼ�:<%=hj%>");
		
		printctrl.Print(13, 20, 8, 0, "�ѳ��߷�Ʊ���:<%=ykjje%>"); 
		printctrl.Print(15, 21, 8, 0, "����:Ԥ����ѳ��߷�Ʊ���:<%=yckykjje%>"); 
		printctrl.Print(75, 21, 8, 0, "��ֵ���ѳ��߷�Ʊ���:<%=czkykjje%>");
		printctrl.Print(15, 22, 8, 0, "�ۼ�:ϵͳ��ֵ�ѳ���:<%=xtcz%>");
		printctrl.Print(75, 22, 8, 0, "����:<%=qt%>");
		
		printctrl.Print(13, 23, 8, 0, "���η�Ʊ���:<%=invoice_money%>");
		printctrl.Print(13, 24, 8, 0, "��д���ϼ�:<%=mon.NumToRMBStr(Double.parseDouble(invoice_money))%>");

 
 
		printctrl.Print(13, 29, 8, 0, "��ˮ�ţ�<%=login_accept%>");
		printctrl.Print(54, 29, 8, 0, "��Ʊ�ˣ�<%=loginName%>");
		printctrl.Print(85, 29, 8, 0, "���ţ�<%=workno%>");
		printctrl.Print(110, 29, 8, 0, "Ӫҵ����<%=s_yyt_name%>");
	 
        printctrl.PageEnd();
        printctrl.StopPrint();
  
    }
	
	function print_jf()
	{
		var localPath = "C:/billLogo.jpg";
		//alert(2);
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
		var rowInit = 7;
		var fontSizeInit = 9;//�����С
		var fontType = "����";//����
		var fontStrongInit = 0;//�����ϸ
		var vR = 0;
		var lineSpace = 0;
        //alert(3);
        /*20100528 liuxmc ��ӷ�Ʊ��α��*/
		printctrl.DrawImage(localPath,8,10,40,18);
        printctrl.Print(20, 10, 9, 0, "��Ʊ����:<%=year%>��<%=month%>��<%=day%>��");
		printctrl.Print(115, 10, 9, 0, "���η�Ʊ����:<%=check_seq%>"); 
		printctrl.Print(13, 12, 9, 0, "�ͻ�����:<%=cust_name%>");
		printctrl.Print(13, 13, 9, 0, "ҵ�����:<%=opName%>");
		printctrl.Print(125, 13, 9, 0, "�ͻ�Ʒ��:<%=sm_name%>");

		printctrl.Print(13, 15, 9, 0, "�û����룺<%=phoneno%>");	
 
		printctrl.Print(82, 15, 9, 0, "��������:<%=print_begin%>");
		printctrl.Print(115, 15, 9, 0, "��ͬ��:");

		printctrl.Print(115, 16, 9, 0, "֧Ʊ��: ");
		printctrl.Print(115, 17, 9, 0, "����ͳ������:");//ֻ��opcode=d340��
		printctrl.Print(16, 18, 9, 0, "ͨ�ŷ���Ѻϼ�:");
		printctrl.Print(16, 19, 9, 0, "���η�Ʊ���:(Сд)��<%=invoice_money%> ��д���ϼ�:<%=mon.NumToRMBStr(Double.parseDouble(invoice_money))%>");
		printctrl.Print(13, 29, 8, 0, "��ˮ�ţ�<%=login_accept%>");
		printctrl.Print(54, 29, 8, 0, "��Ʊ�ˣ�<%=loginName%>");
		printctrl.Print(85, 29, 8, 0, "���ţ�<%=workno%>");
		printctrl.Print(110, 29, 8, 0, "Ӫҵ����<%=s_yyt_name%>");
		//alert(4);
        printctrl.PageEnd();
        printctrl.StopPrint();
 
	}
    function ifprint()
    {
		//alert("test hytcf is "+"<%=hytcf%>");
		if("<%=s_flag%>"=="Y")
		{
			//alert("��ӡ�½��");
			printInvoice();
		}
        else
		{
			//alert("��ӡ�ɷѵ�");
			print_jf();
		}
        document.location.replace("<%=returnPage%>");
    }
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
 
</body>     
</html>

<%
	String[] inParas0 = new String[29];
		//inParas0[0] = realKey+"";
		inParas0[0] = login_accept;//��ˮ
		inParas0[1] = "zg75";//
		inParas0[2] = workno;
		inParas0[3] = "";//û����
		inParas0[4] = phoneno;
		inParas0[5] = "0";//id_no ֻ������� ʵ�ڲ����ڳ������Լ�ȡһ��
		inParas0[6] = "0";//contract_no
		 
		inParas0[7] = "";//֧Ʊ����
 
		//xl add ��ƱԤռ״̬������ begin
		//��Ʊ���� ��Ʊ��� ���� group_id ��ע ��Ʊ���� 
		inParas0[8] = check_seq;//��Ʊ����;
		inParas0[9] = bill_code;//��Ʊ����;
		inParas0[10] ="";//Ʒ��
		inParas0[11] =invoice_money;//Сд���
		inParas0[12] = mon.NumToRMBStr(Double.parseDouble(invoice_money));//��д���
		inParas0[13] = "ͨ�ŷ����:"+txfwf+"<p>"+"�����ۿ�"+xszk+"<p>" ;//��ע
		
		//���νɷѽ�� ����ÿ����Ŷ���ɶ
		//xl add ��ƱԤռ״̬������ end


		inParas0[14] ="";//��Ʊ��ӡ
		inParas0[15] = "";//��ֵ˰��
		inParas0[16] = "";//��ֵ˰��
		inParas0[17] = print_begin;//����
		inParas0[18] = "";//cust_name
		inParas0[19] = "";//
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = regionCode;
		inParas0[25] = groupId;
		inParas0[26] = "1";
		inParas0[27] ="0";//ͨ�û��� 
		 

		System.out.println("====ִ�� s1300PrintInDB ��ʼ=======");
		String[][] result2 = new String[][]{};
		//��ӡ��ʱ�� ����ˮ����״̬ Ԥռ�ĸ���Ϊ�Ѵ�ӡ
%>		
		<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
			<wtc:param value="<%=inParas0[0]%>"/>
			<wtc:param value="<%=inParas0[1]%>"/>
			<wtc:param value="<%=inParas0[2]%>"/>
			<wtc:param value="<%=inParas0[3]%>"/>
			<wtc:param value="<%=inParas0[4]%>"/>
			<wtc:param value="<%=inParas0[5]%>"/>
			<wtc:param value="<%=inParas0[6]%>"/>
			<wtc:param value="<%=inParas0[7]%>"/>
			<wtc:param value="<%=inParas0[8]%>"/>
			<wtc:param value="<%=inParas0[9]%>"/>
			<wtc:param value="<%=inParas0[10]%>"/>
			<wtc:param value="<%=inParas0[11]%>"/>
			<wtc:param value="<%=inParas0[12]%>"/>
			<wtc:param value="<%=inParas0[13]%>"/>
			<wtc:param value="<%=inParas0[14]%>"/>
			<wtc:param value="<%=inParas0[15]%>"/>
			<wtc:param value="<%=inParas0[16]%>"/>
			<wtc:param value="<%=inParas0[17]%>"/>
			<wtc:param value="<%=inParas0[18]%>"/>
			<wtc:param value="<%=inParas0[19]%>"/>
			<wtc:param value="<%=inParas0[20]%>"/>
			<wtc:param value="<%=inParas0[21]%>"/>
			<wtc:param value="<%=inParas0[22]%>"/>
			<wtc:param value="<%=inParas0[23]%>"/>
			<wtc:param value="<%=inParas0[24]%>"/>
			<wtc:param value="<%=inParas0[25]%>"/>
			<wtc:param value="<%=inParas0[26]%>"/>
			<wtc:param value="<%=inParas0[27]%>"/>
		</wtc:service>
		<wtc:array id="RetResult" scope="end"/>
 
<%
		System.out.println("====ִ�� szg12InDB ����=======");
		if(RetResult.length > 0)
		{
			result2 = RetResult;
			result2[0][0]="000000";
			if((result2[0][0]!="000000")&&!result2[0][0].equals("000000"))
			{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("111���ӷ�Ʊ���ʧ��,�������"+"<%=result2[0][0]%>"+",����ԭ��:"+"<%=result2[0][1]%>".",0);
					    document.location.replace("<%=returnPage%>");
					</script>
        <%			
			}
			
		}
		else if(RetResult == null || RetResult.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("222���ӷ�Ʊ���ʧ��,szg12InDB_pt���񷵻ؽ��Ϊ��.",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%			
		}
			
		//////////////////////////////////////////////
				}else{
%>
					<script language="JavaScript">
					    rdShowMessageDialog("333��Ʊ��ӡʧ��,s1300Print���񷵻ؽ��Ϊ��.�������:"+"<%=return_code%>"+"<br>��ʹ�ò���Ʊ���״�ӡ��Ʊ!",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%
				}
		} else {//s1300Print�������ʧ��
%>
		<script language="JavaScript">
		    rdShowMessageDialog("s1300Print��Ʊ��ӡ����,��ʹ�ò���Ʊ���״�ӡ��Ʊ!<br>������룺'<%=return_code%>'��������Ϣ��'111'",0);
		    document.location.replace("<%=returnPage%>");
		</script>
<%
    }
%>