<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.format.UnderlineStyle"%>
<%@ page import="jxl.write.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!

 void writeExcel(OutputStream os,ArrayList acceptlist,String inputPara[])
 {
 	String fixStrings[]=new String[11+1];
 	fixStrings[0]="黑龙江移动通讯公司集团成员付费关系查询结果";
 	fixStrings[1]="区域：	";
 	fixStrings[2]="客户经理：	";
 	fixStrings[3]="详细信息			";
 	fixStrings[4]="操作日期：		";
 	fixStrings[5]="电话号码";
 	fixStrings[6]="用户ID";
 	fixStrings[7]="付费账户";
 	fixStrings[8]="帐单顺序";
 	fixStrings[9]="开始年月日";
 	fixStrings[10]="结束年月日";
 	fixStrings[11]="帐单限额";
 
 	System.out.println("writeExcel");
 	try{ 			
  		//创建工作薄
      			WritableWorkbook wwb = Workbook.createWorkbook(os);  
      		//创建工作表
      			WritableSheet ws = wwb.createSheet("查询结果",0);
  		//写入固定内容
		for(int i=0;i<12;i++)
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
         		if(i==5){column=1;row=7;}  	//电话号码
         		if(i==6){column=3;row=7;}  	//用户ID		
         		if(i==7){column=5;row=7;}  	//付费账户 
         		if(i==8){column=7;row=7;}  //帐单顺序
         		if(i==9){column=9;row=7;}  //开始年月日
         		if(i==10){column=11;row=7;}  //结束年月日
         		if(i==11){column=13;row=7;}  //帐单限额

            		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);
            		wcfF = new WritableCellFormat(wf);
           		labelCF = new Label(column, row, fixStrings[i], wcfF);
            		ws.addCell(labelCF);	
        	}
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
            		int temp=column+2;
            for( int j=0;j<11;j++)
            {
             if(j==0||j==1||j==3||j==4||j==6||j==8){
           		  labelCF = new Label(temp, DataRow, ((String [][])acceptlist.get(j))[i][0], wcfF);
            		ws.addCell(labelCF);
            		temp+=2;
            	}
            	if(j==2){
           		  labelCF = new Label(column, DataRow, ((String [][])acceptlist.get(j))[i][0], wcfF);
            		ws.addCell(labelCF);
            	}
						}
       }
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
		//读取用户session信息
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               //工号姓名
	String org_code = baseInfo[0][16];
	String regionCode=org_code.substring(0,2);
	String ip_Addr  = request.getRemoteAddr();
	
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //登陆密码
	String sqlStr2="";                                             //wuxy add 20090209
	ArrayList retList2 = new ArrayList();                          //wuxy add 20090209                        //wuxy add 20090209

	String QryValues = request.getParameter("turnValue");
	String QryFlag = request.getParameter("QryFlag");             /*wuxy add 20090208*/
	String QryValues1 = request.getParameter("QryValues");        /*wuxy add 20090208*/
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();


	//wuxy alter 20090208 如果按成员号码查询，需要多传入一个成员号码值
	String paraArr[] = new String[6];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "5079";
	if("4".equals(QryFlag))
	{
		paraArr[3] =QryValues1;
    }
    else
    {  	
		paraArr[3] = "";
	}
	paraArr[4] = QryValues;

	acceptList = impl.callFXService("s5079GrpR",paraArr,"11"); /*武星燕　修改多取一个值，以前为１０个20090208*/
	int errCode=impl.getErrCode();   
	String errMsg=impl.getErrMsg(); 
	
	
	
	String currDate="";		//日期 yyyyMMdd
	SimpleDateFormat s=new SimpleDateFormat("yyyyMMddHHmmSS");
  Date c=new Date();
  currDate=s.format(c)+"_";
	String inputPara[]=new String[3];
	inputPara[0]=regionCode;
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
	paraArr[3]=org_code;
	paraArr[4]="操作员"+workNo+"对付费帐号为"+QryValues+"集团按付费关系查询导出";
	paraArr[5]=ip_Addr;

	impl.callFXService("swLoginOpr",paraArr,"2"); 
	int errCode1=impl.getErrCode();   
	String errMsg1=impl.getErrMsg(); 
	if(errCode1!=0){
		System.out.println("OPCODE:5082导出操作日志记录失败");
		System.out.println("失败原因:"+errMsg1);
	}
%>
	
</body>
</html>