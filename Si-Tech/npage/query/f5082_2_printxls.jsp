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

 void writeExcel(OutputStream os,ArrayList acceptlist,String inputPara[])
 {
 	String fixStrings[]=new String[27];
 	fixStrings[0]="黑龙江移动通讯公司集团信息查询结果";
 	fixStrings[1]="区域：	";
 	fixStrings[2]="客户经理：	";
 	fixStrings[3]="详细信息			";
 	fixStrings[4]="操作日期：		";
 	
 	fixStrings[5]="集团产品ID";
 	fixStrings[6]="产品类型";
 	fixStrings[7]="产品帐号";
 	fixStrings[8]="产品状态";
 	fixStrings[9]="产品号码";
 	fixStrings[10]="开户时间";
 	fixStrings[11]="产品名称";
 	fixStrings[12]="APN号码";
 	fixStrings[13]="当前剩余金额";
 	fixStrings[14]="欠费金额";
 	
    fixStrings[15]="项目合同";  
  fixStrings[16]="产品协议";  
  
  fixStrings[17]="集团编号";   
  fixStrings[18]="集团名称";  
  fixStrings[19]="VPMN代码";  
  fixStrings[20]="客户ID"; 
  fixStrings[21]="客户经理工号";  
  fixStrings[22]="经理姓名";  
  fixStrings[23]="联系电话";  
  fixStrings[24]="证件号码";  
  fixStrings[25]="一点支付账户";  
  fixStrings[26]="账户名称";  



  String [][] result1 = new String[][]{};
	String [][] result2 = new String[][]{};	
	String [][] result3 = new String[][]{};	
	result1 = (String[][])acceptlist.get(0);    
	result2 = (String[][])acceptlist.get(1);	
	result3 = (String[][])acceptlist.get(2);
	System.out.println("result1 = " + result1.length);	
	System.out.println("result2 = " + result2.length);
	System.out.println("result3 = " + result3.length);


 	System.out.println("writeExcel");
 	try{ 			
  		//创建工作薄
      			WritableWorkbook wwb = Workbook.createWorkbook(os);  
      		//创建工作表
      			WritableSheet ws = wwb.createSheet("查询结果",0);
  		//写入固定内容
		for(int i=0;i<27;i++)
		{
            int fn=10;	//字号
        		int column =0;	//列
        		int row = 0;	//行
       			WritableFont wf=null;
        		WritableCellFormat wcfF=null;
       			Label labelCF=null;
            	if(i==0){fn=15;column=1;row=1;} //黑龙江移动通讯公司集团信息查询BBOSS处理结果查询————
         		if(i==1){column=1;row=3;}  	//区域：		
           		if(i==2){column=7;row=3;}  	//客户经理	
         		if(i==3){column=1;row=5;}  	//详细信息			
         		if(i==4){column=7;row=5;}  	//日期：		
         		
         		if(i==5){column=1;row=14;}  	//集团产品ID
         		if(i==6){column=3;row=14;}  	//产品类型		
         		if(i==7){column=5;row=14;}  	//产品帐号 
         		if(i==8){column=7;row=14;}  //产品状态
         		if(i==9){column=9;row=14;}  //产品号码
         		if(i==10){column=11;row=14;}  //开户时间
         		if(i==11){column=13;row=14;}  //产品名称
         		if(i==12){column=15;row=14;}  //APN号码
         		if(i==13){column=17;row=14;}  //当前剩余金额
         		if(i==14){column=19;row=14;}  //欠费金额
         		if(i==15){column=21;row=14;}  //欠费金额
         		if(i==16){column=23;row=14;}  //欠费金额
						
						if(i==17){column=1;row=7;}
						if(i==18){column=7;row=7;}
						if(i==19){column=1;row=8;}
						if(i==20){column=7;row=8;}
						if(i==21){column=1;row=9;}
						if(i==22){column=7;row=9;}
						if(i==23){column=1;row=10;}
						if(i==24){column=7;row=10;}
						if(i==25){column=1;row=11;}
						if(i==26){column=7;row=11;}
		
            wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);
            wcfF = new WritableCellFormat(wf);
           	labelCF = new Label(column, row, fixStrings[i], wcfF);
            ws.addCell(labelCF);	
        	}
        //写入具体信息

       int DataRow = 14;
       	
       for(int i=0;i<result3.length;i++)
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
            for( int j=0;j<result3[0].length;j++)
            {	
        				labelCF = new Label(temp, DataRow, result3[i][j], wcfF);
          		  ws.addCell(labelCF);
            		temp+=2;
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
        
     
     	WritableFont wf=null;
     	WritableCellFormat wcfF=null;
     	Label labelCF=null;
   		
   		int fn=10;
   		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);
  		wf.setColour(jxl.format.Colour.BLUE);
  		wcfF = new WritableCellFormat(wf);
  		DataRow = 7;
  		int temp=2;
      for( int j=0;j<result1[0].length;j++)
      {	
          if(j%2==0)  temp=2;
          else  temp=8;
  				labelCF = new Label(temp, DataRow, result1[0][j], wcfF);
    		  ws.addCell(labelCF);
    		  if(j%2==1)	DataRow++;
			}
			
			labelCF = new Label(2, DataRow, result2[0][0], wcfF);
    	ws.addCell(labelCF);
			labelCF = new Label(8, DataRow, result2[0][1], wcfF);
    	ws.addCell(labelCF);
         	 
      wwb.write();
      wwb.close();

  }catch(Exception e)
  {   
      e.printStackTrace();
  }
 }
%>

<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr  = request.getRemoteAddr();

		
	String nopass  = (String)session.getAttribute("password");//登陆密码
	
	String unitId = request.getParameter("unitId");//查询条件
	
	//StringBuffer sqlsBUF=new StringBuffer("");
	//sqlsBUF.append("select unit_id, unit_name, BOSS_VPMN_CODE, a.cust_id, service_no, b.login_name, a.contact_phone , c.id_iccid ");
	//sqlsBUF.append("from dCustDocOrgAdd a, dloginmsg b ,dcustdoc c ");
	//sqlsBUF.append("where a.cust_id = c.cust_id and a.service_no=b.login_no(+)  and a.unit_id="+unitId+";");
    //
	//sqlsBUF.append("select a.contract_no, a.bank_cust from dconmsg a, dconconmsg b where a.contract_no=b.contract_pay ");
	//sqlsBUF.append("and a.con_cust_id=(select cust_id from dCustDocOrgAdd where unit_id="+unitId+");");
    //
	//sqlsBUF.append("SELECT distinct a.id_no, e.sm_name, a.account_id, c.run_name, a.user_no,substr(to_char(a.run_time,'yyyymmdd hh24:mi:ss'),0,17),d.product_name,f.apn_no,g.prepay_fee,g.owe_fee ");
	//sqlsBUF.append("FROM dgrpusermsg a, sproductcode b, sRunCode c,sProductCode d,sSmCode e,dGrpApnMsg f,dconmsg g ");
	//sqlsBUF.append("WHERE a.product_code = b.product_code and a.run_code=c.run_code and a.region_code=c.region_code ");
	//sqlsBUF.append("and a.product_code = d.product_code and a.sm_code = e.sm_code and a.cust_id=(select cust_id from dCustDocOrgAdd where unit_id="+unitId+") and a.id_no = f.id_no(+) and a.account_id = g.contract_no;");
    //
	//String sqls=sqlsBUF.toString(); 
	//System.out.println("sqls = " + sqls);                                

	//ArrayList arlist = new ArrayList();
	//int[] colNum=new int[3];
	//colNum[0]=8;
	//colNum[1]=2;
	//colNum[2]=10;
	//comImpl co=new comImpl();
	//arlist=co.multiSql(colNum,sqls); 
	%>
    <wtc:service name="s5082BPEXC"  outnum="22" retcode="errCode" retmsg="errMsg" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="5082" />
    	<wtc:param value="<%=workNo%>" />
    	<wtc:param value="<%=unitId%>" />    		
    	</wtc:service>
    <wtc:array id="result0" start="0" length="8" scope="end"/>	
    <wtc:array id="result1" start="8" length="2" scope="end"/>
    <wtc:array id="result2" start="10" length="12" scope="end"/>
    <%
   //循环取值,并将结果储存在list中
    ArrayList arlist = new ArrayList();
    arlist.add(result0);
    arlist.add(result1);
    arlist.add(result2);
	String currDate="";		//日期 yyyyMMdd
	SimpleDateFormat s=new SimpleDateFormat("yyyyMMddHHmmSS");
  	Date c=new Date();
  	currDate=s.format(c)+"_";
	String inputPara[]=new String[3];
	inputPara[0]=regionCode;
	inputPara[1]=workName;
	inputPara[2]=s.format(c).substring(0,6);

	System.out.println("Print XSL IN CODE 5082");
	response.reset();//清除Buffer
	response.setContentType("application/vnd.ms-excel;charset=GBK");//文件类型

	response.setHeader("Content-Disposition","attachment;filename=" +currDate+".xls" + ""); 
	                                                                                                                                                                                            
	writeExcel(response.getOutputStream(),arlist, inputPara);
	
	
	
	
	
	String []paraArr=new String[6];
	paraArr[0]="5082";
	paraArr[1]=workNo;
	paraArr[2]=nopass;
	paraArr[3]=org_code;
	paraArr[4]="操作员"+workNo+"对集团id为:"+unitId+"的客户进行集团信息查询导出操作";
	paraArr[5]=ip_Addr;

	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//impl.callFXService("swLoginOpr",paraArr,"2"); 
    %>
    	<wtc:service name="swLoginOpr"  outnum="2" retcode="errCode" retmsg="errMsg" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=paraArr[0]%>" />
    	<wtc:param value="<%=paraArr[1]%>" />
    	<wtc:param value="<%=paraArr[2]%>" />
    	<wtc:param value="<%=paraArr[3]%>" />
    	<wtc:param value="<%=paraArr[4]%>" />
    	<wtc:param value="<%=paraArr[5]%>" />    		
    	</wtc:service>
    	<wtc:array id="retArr1" scope="end"/>
    <%	
	if(!errCode.equals("000000")){
		System.out.println("OPCODE:5082导出操作日志记录失败");
		System.out.println("返回代码："+errCode+"失败原因:"+errMsg);
	}
	/*
	
	*/

%>
