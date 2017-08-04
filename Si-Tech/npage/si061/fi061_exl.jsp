<%
/*********************************
	zhangyan@2013/8/13 9:46:37
	
	需传入6个参数	
	pnt_A 标题  pnt_B 信息项 pnt_B1 信息项内容 pnt_C 信息列表项 pnt_C1 信息列表内容 opCode 操作代码
	参数中各个信息用|分隔,子信息用~分隔
	例如:
	pnt_A=黑龙江移动通讯公司集团成员管理不成功记录|
	pnt_B=集团名称|集团编号|集团产品帐户|操作工号|操作功能|操作日期|
	pnt_B1=haoyyTEST|4510982865|13053991314|aaaaxp|集团成员资费变更|2013-08-13 16:25:57|
	pnt_C=未成功号码|失败原因|
	pnt_C1=13945018888~|取 GROUP_INSTANCE_MEMBER_ATTR 表 optMode 出错[1403]!~|
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
		//创建工作薄
		WritableWorkbook wwb = Workbook.createWorkbook(os);  
		//创建工作表
		WritableSheet ws = wwb.createSheet("错误信息",0);
		
		String [] pnt_A = inputPara[0].split("\\|");
		String [] pnt_B = inputPara[1].split("\\|");
		String [] pnt_B1 = inputPara[2].split("\\|");
		String [] pnt_C = inputPara[3].split("\\|");
		String [] pnt_C1 = inputPara[4].split("\\|");

		int fn=10;	//字号
		int column =1;	//列
		int row = 1;	//行
		WritableFont wf =null;
		WritableCellFormat wcfF=null;
		Label labelCF = null;
		Label labelCF1 = null;
  		//第一部分
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
		labelCF = new Label(3, row, "详细信息", wcfF);
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
<title>导出文件</title>
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
inputPara[0] = "黑龙江移动通讯公司数据业务批量受理不成功记录|";
inputPara[1] = "操作工号|功能名称|操作时间|";
inputPara[2] = workNo+"|数据业务|"+currDate+"|";
inputPara[3] = "手机号码|失败代码|失败原因|";
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
response.reset();//清除Buffer
response.setContentType("application/vnd.ms-excel;charset=GBK");//文件类型
response.setHeader("Content-Disposition","attachment;filename=\"" +opCode+"_"+currDate+".xls" + "\""); 
writeExcel( response.getOutputStream() , inputPara );
%>
</body>
</html>
