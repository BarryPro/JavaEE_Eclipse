<%@ page contentType="text/html; charset=GB2312" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="java.util.*"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.format.UnderlineStyle"%>
<%@ page import="jxl.write.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%!

 void writeExcel(OutputStream os,String reSult[][],String inputPara[])
 {
 	String fixStrings[]=new String[15+1];
 	fixStrings[0]="黑龙江移动通讯公司集团成员管理BBOSS处理结果查询";
 	fixStrings[1]="区域：	";
 	fixStrings[2]="客户经理：	";
 	fixStrings[3]="详细信息			";
 	fixStrings[4]="操作日期：		";
 	fixStrings[5]="集团编码";
 	fixStrings[6]="企业代码	";
 	fixStrings[7]="业务代码";
 	fixStrings[8]="业务名称　";
 	fixStrings[9]="短信服务号码　";
 	fixStrings[10]="手机号码";
 	fixStrings[11]="操作类型";
 	fixStrings[12]="当前处理状态";
 	fixStrings[13]="处理结果　";
 	fixStrings[14]="办理时间　";
 	fixStrings[15]="处理时间　";
 	System.out.println("writeExcel");
 	try{
 			
  		//创建工作薄
      			WritableWorkbook wwb = Workbook.createWorkbook(os);  
     			
      		//创建工作表
      			WritableSheet ws = wwb.createSheet("错误信息",0);
     			
  			
  		
  		//写入固定内容
		for(int i=0;i<16;i++)
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
         		if(i==5){column=1;row=7;}  	//集团编码
         		if(i==6){column=3;row=7;}  	//企业代码		
         		if(i==7){column=5;row=7;}  	//业务代码 
         		if(i==8){column=7;row=7;}  //业务名称
         		if(i==9){column=9;row=7;}  //短信服务号码
         		if(i==10){column=11;row=7;}  //手机号码
         		if(i==11){column=13;row=7;}  //操作类型
         		if(i==12){column=15;row=7;}  //当前处理状态
         		if(i==13){column=17;row=7;}  //处理结果
         		if(i==14){column=19;row=7;}  //办理时间
         		if(i==15){column=21;row=7;}  //处理时间
            		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);
            		wcfF = new WritableCellFormat(wf);
           		labelCF = new Label(column, row, fixStrings[i], wcfF);
            		ws.addCell(labelCF);	
        	}
        //写入具体信息
        int DataRow = 7;	
       for(int i=0;i<reSult.length;i++)
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
            for( int j=0;j<11;j++)
            {
           		labelCF = new Label(column+2*j, DataRow, reSult[i][j], wcfF);
            		ws.addCell(labelCF);
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
            {fn=10; column =8; Row=5;}    	                                                                          	
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

<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>

<body>
<%
	//
	ArrayList retArray = new ArrayList();
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	String whereSql="";
	String sqlStmt = "";
	
	//
    String favCond="";
    String favValue="";
    String totalNum = "";
    String opCode = "";

	
	String orgCode="";		//区域
	String loginNo="";		//客户经理
	String currDate="";		//日期 yyyyMMdd
 	
 	String[][] result1 = new String[][]{};
 	
 	
	String fileName="";		//保存文件名称
	String inputPara[]=new String[3];
	
	SimpleDateFormat s=new SimpleDateFormat("yyyyMMddHHmmSS");
   	Date c=new Date();
  	currDate=s.format(c)+"_";
	//

	orgCode=request.getParameter("orgCode");
	loginNo=request.getParameter("loginNo");
	favCond=request.getParameter("favCond");
	favValue=request.getParameter("favValue");
	totalNum=request.getParameter("totalNum");
	opCode = request.getParameter("opcode");
	
	String regionCode=orgCode.substring(0,2);
	/*
	 if(!(favCond.equals(""))&&(favCond.equals("0")))
	  {
	  	whereSql=" and a.unit_id = " + favValue ;
	  }
	  else if(!(favCond.equals(""))&&(favCond.equals("1")))
	  {
	  	whereSql= " and g.id_iccid= '" + favValue + "'";
	  }
	 else if(!(favCond.equals(""))&&(favCond.equals("2")))
	 {
	 	whereSql= " and c.phone_no= '" + favValue + "'";
	 }
	 else if(!(favCond.equals(""))&&(favCond.equals("3")))
	 {
	 	whereSql= " and f.enterprice_code= '" + favValue + "'";
	 }
	 else if(!(favCond.equals(""))&&(favCond.equals("4"))) 
	 {
	 	whereSql= " and f.bizcodeadd= '" + favValue + "'";
	 }
	 else if(!(favCond.equals(""))&&(favCond.equals("5")))  
	 {
	 	whereSql= " and d.field_value= '" + favValue + "'";
	 }
     
	 sqlStmt="select a.unit_id,f.enterprice_code,f.bizcodeadd,f.product_note,d.field_value,"
	  	         +"c.phone_no, decode(c.op_code,'3709','添加','3704','删除','2900','加入白名单','2901',"
	  	         +"'退出白名单','2898','加入黑名单','2899','退出黑名单','未知') ,"
	  	         +"decode(c.deal_flag,'0','未处理','1','已处理','未知') ,c.ret_msg ,to_char(c.create_time,'YYYY-MM-DD HH24:MI:SS') ,to_char(c.op_time,'YYYY-MM-DD HH24:MI:SS')  "
	  	         +" from dgrpcustmsg a,dcustdoc g, dgrpusermsg b ,dautomebdeal c , "
	  	         +" dgrpusermsgadd d ,dgrpusermsgadd e ,sbillspcode f  "
	  	         +" where a.cust_id=b.cust_id and c.id_no=b.id_no and c.id_no=d.id_no "
	  	         +" and d.field_code='00006'   and c.id_no=e.id_no "
	  	         +" and e.field_code='YWDM0' and f.bizcodeadd=e.field_value "
	  	         +" and a.cust_id=g.cust_id    " ;
	  	         
	  sqlStmt= sqlStmt + whereSql + " order by c.create_time ";       
	  	System.out.println("sqlStmt= " + sqlStmt);
	 
	try
	{
		retArray = callView.sPubSelect("11",sqlStmt, "region", regionCode);
	}catch(Exception e)	
	{
	  	System.out.println("\n==================\n error1");
	}
	*/
	try
	{
	    %>
	  	    <wtc:service name="s3488EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="15" >
                <wtc:param value="<%=opCode%>"/>
                <wtc:param value="<%=loginNo%>"/>
                <wtc:param value="<%=favCond%>"/> 
                <wtc:param value="<%=favValue%>"/> 
                <wtc:param value="0" />
    	        <wtc:param value="<%=totalNum%>" />
            </wtc:service>
            <wtc:array id="retArr1" scope="end"/>
        <%
            if (retCode1.equals("000000") && retArr1.length>0){
  		        result1 = retArr1;
  		    }
	    //result1   = (String[][])retArray.get(0);
	   
	}catch(Exception e)
	{
		System.out.println("\n==================\nerror3");
	}	
	

	//
	
	
	//
	inputPara[0]=orgCode;
	inputPara[1]=loginNo;
	inputPara[2]=s.format(c);
	//
	
	
	//
	response.reset();//清除Buffer
	response.setContentType("application/vnd.ms-excel;charset=GBK");//文件类型
	response.setHeader("Content-Disposition","attachment;filename=\"" +currDate+".xls" + "\""); 
	                                                                                                                                                                                            
	writeExcel(response.getOutputStream(),result1, inputPara);

%>
	
</body>
</html>