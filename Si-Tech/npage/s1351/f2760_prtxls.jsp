<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.*"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.format.UnderlineStyle"%>
<%@ page import="jxl.write.*"%>

<%!
 void writeExcel(OutputStream os,String[][] show_name,String[][] line,String[][] list,String[][] font_num,String[][] blank_flag)
 {
 
 	System.out.println("writeExcel");
 	try{
 			
  		//����������
      WritableWorkbook wwb = Workbook.createWorkbook(os);  
      System.out.println("1");
      //����������
      WritableSheet ws = wwb.createSheet("�����ʵ�",0);
      System.out.println("2");
   /*    
      //            ��Ӵ�������Formatting�Ķ���
            WritableFont wf = new WritableFont(WritableFont.ARIAL, 28, WritableFont.NO_BOLD, false);
            WritableCellFormat wcfF = new WritableCellFormat(wf);
            Label labelCF = new Label(1, 0, "����1", wcfF);
            ws.addCell(labelCF);
    */  
            for(int i=0;i<line.length;i++)
            {
            System.out.println("i="+i);
            int fn=new Integer(font_num[i][0]).intValue();
            int column = new Integer(list[i][0]).intValue();
            int row =  new Integer(line[i][0]).intValue();
            String content;
            if(blank_flag[i][0].equals("1"))
            {
            content = "       "+show_name[i][0];
          }else
          	{
          	content = show_name[i][0];
          	}
            
            WritableFont wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);
            WritableCellFormat wcfF = new WritableCellFormat(wf);
            Label labelCF = new Label(column/12, row/2, content, wcfF);
            ws.addCell(labelCF);
            }
           
      wwb.write();
      wwb.close();

  }catch(Exception e)
  {   
      System.out.println(e.toString());
  }
 }
%>

<html>
<head>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel;charset=GBK">
<title>�����ʵ�</title>
</head>

<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>

<body>
<%


	String show_mode = request.getParameter("show_mode");	
	
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	String paramsIn1[] = new String[1];
	paramsIn1[0]=show_mode;
	ArrayList acceptList = new ArrayList();
	
	acceptList = callView.callFXService("sShowMode", paramsIn1, "7");	
	
	int errCode = callView.getErrCode();
	String errMsg = callView.getErrMsg();
	if(errCode!=0)
	{
	%>
	<script>
		rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	  window.close();
	</script>
		<%
	}else{
	
	String[][] return_code  = (String[][])acceptList.get(0);     //0	code  		
	String[][] return_msg   = (String[][])acceptList.get(1);		 //1	msg
	String[][] show_name    = (String[][])acceptList.get(2);     //2 ��ʾ����       
	String[][] line         = (String[][])acceptList.get(3);     //3	��ʾ����       
	String[][] list         = (String[][])acceptList.get(4);     //4	��ʾ����   	
	String[][] font_num     = (String[][])acceptList.get(5);     //5	�����С  	
	String[][] blank_flag     = (String[][])acceptList.get(6);     //6	�ո��־λ  	
		
	System.out.println("aaaa="+line.length);

	response.reset();//���Buffer
	response.setContentType("application/vnd.ms-excel");

	//String filePath = "applications/iccweb/page/s2760/xlstmp/new.xls";
	
	//File fileWrite = new File(filePath);
	//fileWrite.createNewFile();
	
	writeExcel(response.getOutputStream(),show_name,line,list,font_num,blank_flag);
}
	
	%>
		
</body>
</html>