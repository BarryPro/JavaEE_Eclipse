<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-15
********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.format.UnderlineStyle"%>
<%@ page import="jxl.write.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%!

 void writeExcel(OutputStream os,StringTokenizer phoneNo,StringTokenizer returnMsg,String inputPara[])
 {
 	String fixStrings[]=new String[11+1];
 	fixStrings[0]="黑龙江移动通讯公司集团成员管理不成功记录————";
 	fixStrings[1]="集团名称：	";
 	fixStrings[2]="集团编号：	";
 	fixStrings[3]="品牌名称：	";
 	fixStrings[4]="区域：	";
 	fixStrings[5]="客户经理：	";
 	fixStrings[6]="客户经理电话：	";
 	fixStrings[7]="详细信息			";
 	fixStrings[8]="操作日期：		";
 	fixStrings[9]="未成功号码";
 	fixStrings[10]="失败原因		";
 	fixStrings[11]="";
 	
 	
 	System.out.println("writeExcel");
 	try{
 			
  		//创建工作薄
      			WritableWorkbook wwb = Workbook.createWorkbook(os);  
     			
      		//创建工作表
      			WritableSheet ws = wwb.createSheet("错误信息",0);
     			
  			
  		
  		//写入固定内容
		for(int i=0;i<11;i++)
		{
            		int fn=10;	//字号
        		int column =0;	//列
        		int row = 0;	//行
       			WritableFont wf=null;
        		WritableCellFormat wcfF=null;
       			Label labelCF=null;
            		if(i==0){fn=15;column=1;row=1;} //黑龙江移动通讯公司集团成员管理不成功记录————
         		if(i==1){column=1;row=3;}  	//集团名称：	
         		if(i==2){column=4;row=3;}	//集团编号：	
           		if(i==3){column=7;row=3;}  	//智能网编号：	
         		if(i==4){column=1;row=4;}  	//区域：	
         		if(i==5){column=4;row=4;}  	//客户经理：	
         		if(i==6){column=7;row=4;}  	//客户经理电话：
         		if(i==7){column=3;row=6;}  	//详细信息			
         		if(i==8){column=7;row=6;}  	//日期：		
         		if(i==9){column=1;row=7;}  	//未成功号码
         		if(i==10){column=4;row=7;}  	//失败原因		
         		 
            		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);
            		wcfF = new WritableCellFormat(wf);
           		labelCF = new Label(column, row, fixStrings[i], wcfF);
            		ws.addCell(labelCF);	
        	}
        	
        	//写入手机号
        	int phoneRow = 7;
        	while (phoneNo.hasMoreTokens()) 
        	 {
        	 	int fn=10;
            		int column =1;
            		phoneRow++;
         		WritableFont wf=null;
         		WritableCellFormat wcfF=null;
         		Label labelCF=null;
         		
         		
         		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);
            		wf.setColour(jxl.format.Colour.RED);
            		wcfF = new WritableCellFormat(wf);
           		labelCF = new Label(column, phoneRow, phoneNo.nextToken(), wcfF);
            		ws.addCell(labelCF);
            		
        	 }
    		//写入错误信息
    		phoneRow = 7;
    		while (returnMsg.hasMoreTokens()) 
        	 {
        	 	int fn=10;
            		int column =4;
            		phoneRow++;
         		WritableFont wf=null;
         		WritableCellFormat wcfF=null;
         		Label labelCF=null;
         		
         		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);
            		wf.setColour(jxl.format.Colour.RED); 
            		wcfF = new WritableCellFormat(wf);
           		labelCF = new Label(column, phoneRow, returnMsg.nextToken(), wcfF);
            		ws.addCell(labelCF);
            	   }
            	 //写入其它信息
            	 for(int i=0;i<inputPara.length-2;i++)
            	  {
            	  	int fn=10;	//字号
        		int column =0;	//列
        		int Row = 0;	//行
       			WritableFont wf=null;
        		WritableCellFormat wcfF=null;
       			Label labelCF=null;
            	  	
            	  	if(i==0) //集团名称
            	  	 { fn=10; column =2; Row=3; }
          	  
            	 	 if(i==1) //集团编号
            	  	 { fn=10; column =5;Row=3; }
            	  	
            	  	if(i==2) //添加,删除
            	  	 {fn=10;column =8;Row=1;}
            	  	            	  	 
            	  	if(i==3) //区域  
            	  	 {fn=10; column =2; Row=4;}
            	  	 
            	  	if(i==4) //客户经理 
            	  	 {fn=10; column =5; Row=4;}
            	  	 
            	  	if(i==5) //客户经理电话 
            	  	 {fn=10; column =9; Row=4;}  
            	  	 
            	  	if(i==6) //日期
            	  	 {fn=10; column =9; Row=6;}  
            	  	 
            	  	if(i==7)  //智能网编号  
            	  	 {fn=10; column =9; Row=3;}   
            	  	                                                                          	
         		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);  	
            		wcfF = new WritableCellFormat(wf);                                           	
           		labelCF = new Label(column, Row, inputPara[i], wcfF);                        	
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
<meta http-equiv="Content-Type" content="application/vnd.ms-excel">
<title>错误文件</title>
</head>


<body>
<%
	
	String regionCode=(String)session.getAttribute("regCode");
	
	//
	//ArrayList retArray = new ArrayList();
	//String[][] result = new String[][]{};
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String sqlStr ="select  a.boss_vpmn_code,a.service_no,b.phone_no,a.org_code from dgrpcustmsg a,dbvipadm.dgrpmanagermsg b where a.service_no=b.service_no and a.unit_id = '";
	//
	String grpName="" ;		//集团名称
	String unitID=""  ;		//集团编号
	String op_Code="" ;		//根据opcode判断是增加还是删除
	StringTokenizer phoneNo=null;	//不成功手机号码
	StringTokenizer returnMsg=null;	//错误原因
	String orgCode="";		//区域
	String service_no="";		//客户经理
	String service_phone_no="";	//客户经理电话
	String currDate="";		//日期 yyyyMMdd
	String loginAccept=""	;	//流水号
	String fileName="";		//保存文件名称
	String vpmn_code="";		//智能网编号
	String inputPara[]=new String[9+1];
	//
	phoneNo=new StringTokenizer(request.getParameter("phoneNo"),"|");
	returnMsg=new StringTokenizer(request.getParameter("returnMsg"),"|");	
	//
	SimpleDateFormat s=new SimpleDateFormat("yyyyMMddHHmmSS");
   	Date c=new Date();
  	currDate=s.format(c)+"_";
	//
	grpName=request.getParameter("grpName");
	unitID=request.getParameter("unitID");
	op_Code=request.getParameter("op_Code");
	orgCode=request.getParameter("orgCode");
	loginAccept=request.getParameter("loginAccept")+"_";
	vpmn_code = request.getParameter("sm_name");;
	//
	if(unitID.length()>2)
	 {
	 	sqlStr=sqlStr+unitID+"'";
	 	System.out.println("===== Save xls file Msg: sqlstr="+sqlStr);
	 	try {
	 	 	//retArray = callView.sPubSelect("4",sqlStr);
	 	 	
%>

		<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result" scope="end"/>

<%	 	 	
	 		//result = (String[][])retArray.get(0);
	 		int recordNum = result.length;
	 		//System.out.println("---------------result.length;------------hjw------------"+result.length);
	 		System.out.println("===== Save xls file Msg: recordMun="+recordNum);
	 		if(recordNum>=1)
	 		 {
	 		 
	 		 //System.out.println("----------------result[0][0].trim();------------hjw------------"+result[0][0].trim());
	 		 //System.out.println("----------------result[0][1].trim();------------hjw------------"+result[0][1].trim());
	 		 //System.out.println("----------------result[0][2].trim();------------hjw------------"+result[0][2].trim());
	 		 
	 		 //---------------result.length;------------hjw------------1
       //----------------result[0][0].trim();------------hjw------------4510004397
       //----------------result[0][1].trim();------------hjw------------aavg75
       //----------------result[0][2].trim();------------hjw------------13936661658
       
       
       
       
	 		 	service_no=result[0][1].trim();
	 		 	service_phone_no=result[0][2].trim();
	 		 	
	 		 }
	 		 
	 		
	 	    }
	 	catch(Exception e)
	 	    {
			System.out.println(e.toString());
                    } 
	 	
	 }
	
	//
	inputPara[0]=grpName;
	inputPara[1]=unitID;
	if(op_Code.equals("3709"))
		inputPara[2]="添加成员"; 
	if(op_Code.equals("3704"))
	        inputPara[2]="删除成员";
	if(op_Code.equals("3605")) 
	        inputPara[2]="套餐变更"; 
		              
	inputPara[3]=orgCode;
	inputPara[4]=service_no;
	inputPara[5]=service_phone_no;
	inputPara[6]=s.format(c);
	inputPara[7]=vpmn_code;
	//
	
	
	//
	response.reset();//清除Buffer
	response.setContentType("application/vnd.ms-excel;charset=GBK");//文件类型
	response.setHeader("Content-Disposition","attachment;filename=\"" +currDate+unitID+".xls" + "\"");                                                                                                                                                                                             
	writeExcel(response.getOutputStream(),phoneNo,returnMsg, inputPara);

%>
	
</body>
</html>
