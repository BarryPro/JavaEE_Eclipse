<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-21
********************/
%>
<%
  String opCode = "5255";
  String opName = "���г�ֵ�ʻ��ɷ�";
%>
<%@ page contentType="text/html; charset=GB2312" %>
 

 <%@ page import="com.sitech.boss.pub.config.*" %>
 <%@ page import="com.sitech.boss.pub.util.*"%>
 <%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
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


	String groupId = (String)session.getAttribute("groupId");
	String regionCode = (String)session.getAttribute("regCode");
	String contractno = request.getParameter("contractno");
	String workNo = request.getParameter("workno");
	String payAccept = request.getParameter("payAccept");
	String total_date = request.getParameter("total_date");
	String checkno = request.getParameter("checkNo");
	String op_code="5255";
	String smphoneNo = request.getParameter("phoneNo");
	String smop_code=request.getParameter("opCode");
	System.out.println("smop_code="+smop_code);
	String sm_name=" ";
	String[] inParam = new String[2];
	inParam[0] ="select decode(sm_code,'zn','������','gn','ȫ��ͨ','dn','���еش�') from dcustmsg where phone_no=: smphoneNo  and substr(run_code,2,1)<'a'";
	inParam[1] = "smphoneNo="+smphoneNo;

//xl add ��Ʊ����
//	String check_seq = request.getParameter("check_seq");
//	String s_flag = request.getParameter("s_flag");

	   //xl add ������֯�ڵ��ѯӪҵ������
		String[] inParam_yyt = new String[2];
		inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
		inParam_yyt[1]="s_group_id="+groupId;		 
		String s_yyt_name="";
		
	if(smop_code.equals("5255")){
	 
%>
	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
		
   <wtc:service name="TlsPubSelBoss" outnum="3" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  			<wtc:param value="<%=inParam[0]%>"/>
			<wtc:param value="<%=inParam[1]%>"/>
   </wtc:service>
	 <wtc:array id="sm_name_arr" scope="end"/>

<%	
		if(yyt_name_arr!=null&&yyt_name_arr.length>0)
		{
				s_yyt_name = yyt_name_arr[0][0];
		}
			
	 	if(sm_name_arr!=null&&sm_name_arr.length>0){
        	sm_name = sm_name_arr[0][0];
        }
	}
	String returnPage = "s1300.jsp?ph_no="+smphoneNo;
    if (request.getParameter("returnPage") != null) {
	   returnPage = request.getParameter("returnPage");
	}

	String printtype = "0";
    if (request.getParameter("printtype") != null) {
	    printtype = request.getParameter("printtype");
	}

	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workno = baseInfo[0][2];
	String workname = baseInfo[0][3];
	String org_code = baseInfo[0][16];


	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
    
	String[] inParas = new String[4];
	inParas[0] = workNo;
	inParas[1] = contractno;
	inParas[2] = total_date;
	inParas[3] = payAccept;
    
	//CallRemoteResultValue  value  = viewBean.callService("1", org_code.substring(0,2) ,  "s1300PrtChk", "16" , inParas);
%>

    <wtc:service name="s1300PrtChk" outnum="16" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:params value="<%=inParas%>" />
		</wtc:service>
		<wtc:array id="result_t2" scope="end"/>

<%   
 	String[][] result  = null;

	result = result_t2;
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
		var localPath = "C:/billLogo.jpg";
		printctrl.DrawImage(localPath,8,10,40,18);//��������
 	//printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,'20130202');
 	   	printctrl.Print(50, 6, 9, 0, "�������ƶ����޹�˾ͨ�û���Ʊ");
   	printctrl.Print(20, 10, 9, 0, "��Ʊ����:<%=year%>��<%=month%>��<%=day%>��");
		printctrl.Print(13, 13, 9, 0, "�ͻ�����:<%=result[0][4]%>");
		printctrl.Print(48, 13, 9, 0, "ҵ�����:<%=result[0][2]%>");
		printctrl.Print(115, 13, 9, 0, "�ͻ�Ʒ��:<%=sm_name%>");

		printctrl.Print(13, 14, 9, 0, "�û����룺<%=phoneNo%>");	
		printctrl.Print(48, 14, 9, 0, " Э����룺<%=result[0][6]%>");
		printctrl.Print(90, 14, 9, 0, " ��������:<%=year+month%>");
		printctrl.Print(125, 14, 9, 0, " ��ͬ��:");
		printctrl.Print(115, 15, 9, 0, "֧Ʊ��:");
		printctrl.Print(115, 16, 9, 0, "����ͳ������:");//ֻ��opcode=d340��
		
		printctrl.Print(18, 17, 9, 0, "ͨ�÷���Ѻϼƣ�<%=result[0][8]%>");
		printctrl.Print(13, 18, 9, 0, "���νɷѽ�(Сд)��<%=result[0][9].trim()%>");
		printctrl.Print(83, 18, 9, 0, "��д���ϼƣ�<%=result[0][8]%>");
		
		printctrl.Print(13, 20, 9, 0, "<%=result[0][11]%>");
				
		printctrl.Print(13, 23, 9, 0, "<%=result[0][10]%> ");			
		printctrl.Print(72, 23, 9, 0, "<%=result[0][12]%> ");		
				
		printctrl.Print(13, 24, 9, 0, "ע�����վ�Ϊ���г�ֵ������Ԥ���ר�ã����г�ֵ�˻����ܰ����˿���ܲ�������Ӫ����� ");

		//xl add ��Ʊ��                    �տ                     ���ˣ�
		printctrl.Print(13, 27, 9, 0, "��ˮ�ţ�<%=payAccept%>");
		printctrl.Print(54, 27, 9, 0, "��Ʊ�ˣ�<%=workname%>");
		printctrl.Print(85, 27, 9, 0, "���ţ�<%=workNo%>");
		printctrl.Print(125, 27, 9, 0, "Ӫҵ����<%=s_yyt_name%>");

 		printctrl.PageEnd() ;
		printctrl.StopPrint() ; 
}

   function ifprint()
{
  			printInvoice();
  			//printInDB();
 			removeCurrentTab();
 } 
   
		
		
<%
///liuxmc add  ��Ʊ���ӻ������� ����
%>
 
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
<%}
else
{
%>
	 <script language="JavaScript">
			rdShowMessageDialog("�վݴ�ӡ����,��ʹ�ò����վݽ��״�ӡ�վ�!<br>������룺'<%=return_code%>'��������Ϣ��'<%=error_msg%>'��",0);
			window.location = "<%=returnPage%>"
		 </script>
<%
	}
%>


