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
		System.out.println("zhangyan~~39~~~~~~~");

		for(int i=0;i<pnt_A.length;i++)
		{
			System.out.println("zhangyan~~pnt_A["+i+"]~~~~~~~"+pnt_A[i]);

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
				System.out.println ( "zhangyan ~~~pnt_C1_1["+j+"]" + pnt_C1_1[j] );
		
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
	String opCode = request.getParameter( "opCode" );
	
	inputPara[0] = request.getParameter( "pnt_A" );
	inputPara[1] = request.getParameter( "pnt_B" );
	inputPara[2] = request.getParameter( "pnt_B1" );
	inputPara[3] = request.getParameter( "pnt_C" );
	inputPara[4] = request.getParameter( "pnt_C1" );

	for ( int i = 0 ; i < inputPara.length ; i ++ )
	{
		System.out.println("zhangyan~~~~inputPara["+i+"]="+inputPara[i]);
	}
	
	java.util.Date sysdate = new java.util.Date();
	java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
	String currDate = sf.format(sysdate);
	
	response.reset();//清除Buffer
	response.setContentType("application/vnd.ms-excel;charset=GBK");//文件类型
	response.setHeader("Content-Disposition","attachment;filename=\"" +opCode+"_"+currDate+".xls" + "\""); 
	writeExcel( response.getOutputStream() , inputPara );
%>
</body>
</html>
