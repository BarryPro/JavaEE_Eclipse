<%
/*********************************
	zhangyan@2013/8/13 9:46:37
	
	�贫��6������	
	pnt_A ����  pnt_B ��Ϣ�� pnt_B1 ��Ϣ������ pnt_C ��Ϣ�б��� pnt_C1 ��Ϣ�б����� opCode ��������
	�����и�����Ϣ��|�ָ�,����Ϣ��~�ָ�
	����:
	pnt_A=�������ƶ�ͨѶ��˾���ų�Ա�����ɹ���¼|
	pnt_B=��������|���ű��|���Ų�Ʒ�ʻ�|��������|��������|��������|
	pnt_B1=haoyyTEST|4510982865|13053991314|aaaaxp|���ų�Ա�ʷѱ��|2013-08-13 16:25:57|
	pnt_C=δ�ɹ�����|ʧ��ԭ��|
	pnt_C1=13945018888~|ȡ GROUP_INSTANCE_MEMBER_ATTR �� optMode ����[1403]!~|
	opCode=7897
*********************************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.format.UnderlineStyle"%>
<%@ page import="jxl.write.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!
void writeExcel( OutputStream os , String inputPara[] )
{
	try
	{
		//����������
		WritableWorkbook wwb = Workbook.createWorkbook(os);  
		//����������
		WritableSheet ws = wwb.createSheet("������Ϣ",0);
		
		String [] pnt_A = inputPara[0].split("\\|");
		String [] pnt_B = inputPara[1].split("\\|");
		String [] pnt_B1 = inputPara[2].split("\\|");
		String [] pnt_C = inputPara[3].split("\\|");
		String [] pnt_C1 = inputPara[4].split("\\|");

		int fn=10;	//�ֺ�
		int column =1;	//��
		int row = 1;	//��
		WritableFont wf =null;
		WritableCellFormat wcfF=null;
		Label labelCF = null;
		Label labelCF1 = null;
  		//��һ����
		for(int i=0;i<pnt_A.length;i++)
		{
			fn=15;
			column=1;
			row=row+i;
			
			wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);
			wcfF = new WritableCellFormat(wf);
			labelCF = new Label(column, row, pnt_A[i], wcfF);
			ws.addCell(labelCF);	
		}
		row = row+1;
		for ( int i=0;i<pnt_B.length;i++ )
		{
			fn=10;
			column=i%3*3+1;
			if ( i%3==0 )
			{
				row = row+1;
			}

			wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);
			wcfF = new WritableCellFormat(wf);
			labelCF = new Label(column, row, pnt_B[i], wcfF);
			ws.addCell(labelCF);	
						
			wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);
			wcfF = new WritableCellFormat(wf);	
			labelCF1 = new Label(column+1, row, pnt_B1[i], wcfF);
			ws.addCell(labelCF1);				
		}
		row = row+2;
		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);
		wcfF = new WritableCellFormat(wf);
		labelCF = new Label(3, row, "��ϸ��Ϣ", wcfF);
		ws.addCell(labelCF);
			
		row = row+1;
		column=1;
		System.out.println("89~~~~~~~~~~~~~~~~~~~~~~~~~");
		for ( int i=0;i<pnt_C.length;i++ )
		{
			fn=10;
			column=i*4+1;
			
			wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);
			wcfF = new WritableCellFormat(wf);
			labelCF = new Label(column, row, pnt_C[i], wcfF);
			ws.addCell(labelCF);
			
			String [] pnt_C1_1 = pnt_C1[i].split("~");
			row = row+1;
			for ( int j=0;j<pnt_C1_1.length;j++ )
			{		
				wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);
				wf.setColour(jxl.format.Colour.RED); 
				wcfF = new WritableCellFormat(wf);
				labelCF = new Label(column, row, pnt_C1_1[j] , wcfF);
				ws.addCell(labelCF);	
				row = row+1;			
			}
			
			row = row-pnt_C1_1.length-1;
		}
		wwb.write();
		wwb.close();
	}
	catch(Exception e)
	{   
		System.out.println(e.toString());
	}
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel">
<title>�����ļ�</title>
</head>

<body>
<%
String inputPara[]=new String[5];

String accept = request.getParameter( "logacc" );
String chnSrc = request.getParameter( "chnSrc" );
String opCode = request.getParameter( "opCode" );
String workNo = request.getParameter( "workNo" );
String passwd = request.getParameter( "passwd" );

String phoNo = request.getParameter( "phoNo" );   
String usrPwd = request.getParameter( "usrPwd" );
String start_pos = request.getParameter( "start_pos" );
String end_pos = request.getParameter( "end_pos" );
String svc_name = "sSpBatchFileQry"; //sSpBatchFileQry sJQKTest

String regCode = (String)session.getAttribute( "regCode" );

java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyyMMdd");
String currDate = sf.format(sysdate);
%>
<wtc:service name = "<%=svc_name%>" outnum = "30" 
	routerKey = "region" routerValue = "<%=regCode%>" 
	retcode = "retcode" retmsg = "retmsg" >
	<wtc:param value = "<%=accept%>"/>
	<wtc:param value = "<%=chnSrc%>"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
		               
	<wtc:param value = "<%=phoNo%>"/>
	<wtc:param value = "<%=usrPwd%>"/>
	<wtc:param value = "<%=start_pos%>"/>
	<wtc:param value = "<%=end_pos%>"/>
</wtc:service>
<wtc:array id="rst0" start = "0" length = "2" scope="end" />
<wtc:array id="rst" start = "2" length = "3" scope="end" />	

<%	
inputPara[0] = "�������ƶ�ͨѶ��˾����ҵ�����������ɹ���¼|";
inputPara[1] = "��������|��������|����ʱ��|";
inputPara[2] = workNo+"|����ҵ��|"+currDate+"|";
inputPara[3] = "�ֻ�����|ʧ�ܴ���|ʧ��ԭ��|";
String strPho="";
String strErrCode="";
String strErrMsg="";

System.out.println("rst.length~~~~~"+rst.length);
for ( int i=0;i<rst.length;i++ )
{
	for ( int j=0;j<rst[i].length;j++ )
	{
		System.out.println("zhangyan~~~~~~rst["+i+"]["+j+"]~~~~~~" +rst[i][j] );
	}
	strPho = strPho +rst[i][0]+"~";
	strErrCode = strErrCode+rst[i][1]+"~";
	strErrMsg = strErrMsg+rst[i][2]+"~";
}
inputPara[4] =  strPho +"|"+  strErrCode+"|"+strErrMsg+"|";
response.reset();//���Buffer
response.setContentType("application/vnd.ms-excel;charset=GBK");//�ļ�����
response.setHeader("Content-Disposition","attachment;filename=\"" +opCode+"_"+currDate+".xls" + "\""); 
writeExcel( response.getOutputStream() , inputPara );
%>
</body>
</html>
