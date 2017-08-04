<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.format.UnderlineStyle"%>
<%@ page import="jxl.write.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  System.out.println("-------打印5------");
%>
<%!

 void writeExcel(OutputStream os,ArrayList acceptlist,String inputPara[])
 {
 System.out.println("---------writeExcel=============");
 	String fixStrings[]=new String[11];
 	fixStrings[0]="黑龙江移动通讯公司集团按账目项付费查询结果";    
 	fixStrings[1]="区域：	";
 	fixStrings[2]="客户经理：	";
 	fixStrings[3]="详细信息：		";
 	fixStrings[4]="操作日期：		";
 	fixStrings[5]="地市	";
 	fixStrings[6]="集团编码	";
 	fixStrings[7]="集团名称		";
 	fixStrings[8]="集团帐号		";
 	fixStrings[9]="付费帐目项";
 	fixStrings[10]="付费成员数量";
 
 	System.out.println("writeExcel");
 	try{ 			
  		//创建工作薄
      			WritableWorkbook wwb = Workbook.createWorkbook(os);  
      		//创建工作表
      			WritableSheet ws = wwb.createSheet("查询结果",0);
  		    //写入固定内容
      		for(int i=0;i<11;i++)
      		{
            int fn=10;	//字号
        		int column =0;	//列
        		int row = 0;	//行
       			WritableFont wf=null;
        		WritableCellFormat wcfF=null;
       			Label labelCF=null;
            if(i==0){fn=15;column=1;row=1;} //黑龙江移动通讯公司集团成员管理BBOSS处理结果查询————
         		if(i==1){column=1;row=3;}  	//区域：		
           	if(i==2){column=7;row=3;}  	//客户经理	
         		if(i==3){column=1;row=5;}  	//详细信息			
         		if(i==4){column=7;row=5;}  	//日期：		
         		if(i==5){column=1;row=7;}  	//地市
         		if(i==6){column=3;row=7;}  	//集团编码		
         		if(i==7){column=5;row=7;}  	//集团名称 
         		if(i==8){column=7;row=7;}  //集团帐号
         		if(i==9){column=9;row=7;}  //付费帐目项
         		if(i==10){column=11;row=7;}  //付费成员数量

            wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);
            wcfF = new WritableCellFormat(wf);
            labelCF = new Label(column, row, fixStrings[i], wcfF);
            ws.addCell(labelCF);	
        	}
        	System.out.println("---------写入具体信息=============");
        //写入具体信息

       int DataRow = 7;	
       for(int i=0;i<((String [][])acceptlist.get(0)).length;i++)
       {
          int fn=10;
          int column =1;
          DataRow++;
          WritableFont wf=null;
          WritableCellFormat wcfF=null;
          Label labelCF=null;
       		
       		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);
            		wf.setColour(jxl.format.Colour.RED);
            		wcfF = new WritableCellFormat(wf);
            		int temp=column;
            for( int j=0;j<6;j++)
            {
           		  labelCF = new Label(temp, DataRow, ((String [][])acceptlist.get(j))[i][0], wcfF);
            		ws.addCell(labelCF);
            		temp+=2;
						}
       }
       System.out.println("---------写入其它信息=============");
        //写入其它信息
        for(int i=0;i<inputPara.length;i++)
        {
        	int fn=10;	//字号
        	int column =0;	//列
        	int Row = 0;	//行
       		WritableFont wf=null;
        	WritableCellFormat wcfF=null;
       		Label labelCF=null;
       	            	  	 
           	if(i==0) //区域  
            {fn=10; column =2; Row=3;}
            	  	 
            if(i==1) //客户经理 
            {fn=10; column =9; Row=3;}
            
            if(i==2) //日期
            {fn=10; column =9; Row=5;}    	                                                                          	
         		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);  	
            		wcfF = new WritableCellFormat(wf);                                           	
           		labelCF = new Label(column, Row, inputPara[i], wcfF);                        	
            		ws.addCell(labelCF);     
        
        }     	 
      wwb.write();
      wwb.close();

  }catch(Exception e)
  {   
      e.printStackTrace();
  }
 }
%>

<html>
<head>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel">
<title>错误文件</title>
</head>

<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>

<body>
<%
	String regCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo")); 
	String workName   = WtcUtil.repNull((String)session.getAttribute("workName")); 
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String orgCode   = WtcUtil.repNull((String)session.getAttribute("orgCode")); 
	String ip_Addr  = request.getRemoteAddr();
	
	String QryValues = (String)request.getParameter("turnValue")==null?"":(String)request.getParameter("turnValue");
	String QryFlag = (String)request.getParameter("QryFlag")==null?"":(String)request.getParameter("QryFlag");             
	String QryValues1 = (String)request.getParameter("QryValues")==null?"":(String)request.getParameter("QryValues");
	String idNo = (String)request.getParameter("idNo")==null?"":(String)request.getParameter("idNo");
	System.out.println("--------------5079-------QryValues5="+QryValues1);   
	System.out.println("--------------5079-------QryFlag="+QryFlag);  
	System.out.println("--------------5079-------turnValue="+QryValues);
	System.out.println("--------------5079-------idNo="+idNo);    
	     
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
<%
	String paraArr[] = new String[9];
	paraArr[0] = printAccept;
	paraArr[1] = "01";
	paraArr[2] = "5079";
	paraArr[3] = workNo;
	paraArr[4] = nopass;
	paraArr[5] = "";
	paraArr[6] = "";
	paraArr[7] = QryValues1;
	paraArr[8] = idNo;
	
	acceptList = impl.callFXService("s5079GrpConUser",paraArr,"6");
	int errCode=impl.getErrCode();   
	String errMsg=impl.getErrMsg(); 

	
	String currDate="";		//日期 yyyyMMdd
	SimpleDateFormat s=new SimpleDateFormat("yyyyMMddHHmmSS");
  Date c=new Date();
  currDate=s.format(c)+"_";
	String inputPara[]=new String[3];
	inputPara[0]=regCode;
	inputPara[1]=workName;
	inputPara[2]=s.format(c).substring(0,6);

	System.out.println("Print XSL IN CODE 5079");
	response.reset();//清除Buffer
	response.setContentType("application/vnd.ms-excel;charset=GBK");//文件类型
	response.setHeader("Content-Disposition","attachment;filename=" +currDate+".xls" + ""); 
	writeExcel(response.getOutputStream(),acceptList, inputPara);
	
	paraArr=new String[6];
	paraArr[0]="5079";
	paraArr[1]=workNo;
	paraArr[2]=nopass;
	paraArr[3]=orgCode;
	paraArr[4]="操作员"+workNo+"对成员ID为"+QryValues+"的集团按账目项付费导出";
	paraArr[5]=ip_Addr;

	impl.callFXService("swLoginOpr",paraArr,"2"); 
	int errCode1=impl.getErrCode(); 
	String errMsg1=impl.getErrMsg(); 
	if(errCode1!=0){
		System.out.println("OPCODE:5079 集团按账目项付费 导出操作日志记录失败");
		System.out.println("失败原因:"+errMsg1);
	}
	
%>
	
</body>
</html>