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

 	String fixStrings[]=new String[10+1];

 	fixStrings[0]="黑龙江移动通讯公司集团信息查询结果";

 	fixStrings[1]="区域：	";

 	fixStrings[2]="客户经理：	";

 	fixStrings[3]="详细信息			";

 	fixStrings[4]="操作日期：		";

 	

 	fixStrings[5]="账户号码";

 	fixStrings[6]="账户名称";

 	fixStrings[7]="用户预存";

 	fixStrings[8]="可划拨预存";

 	fixStrings[9]="未出帐话费";


  



  String [][] result1 = new String[][]{};

	result1 = (String[][])acceptlist.get(0);    

	System.out.println("result1 = " + result1.length);	

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

            if(i==0){fn=15;column=1;row=1;} //黑龙江移动通讯公司集团信息查询BBOSS处理结果查询11————

         		if(i==1){column=1;row=3;}  	//区域：		

           	if(i==2){column=7;row=3;}  	//客户经理	

         		if(i==3){column=1;row=5;}  	//详细信息			

         		if(i==4){column=7;row=5;}  	//操作日期：		

         		

         		if(i==5){column=1;row=7;}  	//账户号码

         		if(i==6){column=3;row=7;}  	//账户名称		

         		if(i==7){column=5;row=7;}  	//用户预存 

         		if(i==8){column=7;row=7;}  //可划拨预存

         		if(i==9){column=9;row=7;}  //未出帐话费



         		

		

            wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);

            wcfF = new WritableCellFormat(wf);

           	labelCF = new Label(column, row, fixStrings[i], wcfF);

            ws.addCell(labelCF);	

        	}

        //写入具体信息



       int DataRow = 7;

       	

       for(int i=0;i<result1.length;i++)

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

            for( int j=0;j<result1[0].length;j++)

            {	

        				labelCF = new Label(temp, DataRow, result1[i][j], wcfF);

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

            

            if(i==2) //操作日期

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

	

	String idNo = request.getParameter("idNo");//查询条件

	

	

	//StringBuffer sqlsBUF=new StringBuffer("");

	//sqlsBUF.append("select cust_name, mode_name, member_no, contract_no,run_name,run_time, ROWNUM from ( ");

	//sqlsBUF.append("SELECT  member_id, cust_name, mode_name, member_no, contract_no,run_name,run_time, ROWNUM ID FROM ( ");

	//sqlsBUF.append("select distinct a.member_id, c.cust_name, e.mode_name, a.member_no, b.contract_no,g.run_name,to_char(a.begin_time,'yyyymmdd hh24:mi:ss') run_time ");

	//sqlsBUF.append("from dGrpUserMebMsg a, dCustMsg b, dCustDoc c, dBillCustDetail d, sBillModeCode e,sRunCode g ");

	//sqlsBUF.append("where a.member_id=b.id_no and b.cust_id=c.cust_id and a.member_id=d.id_no and d.mode_code=e.mode_code ");

	//sqlsBUF.append("and d.mode_flag='0' and a.id_no="+idNo+" and e.region_code=substr(b.belong_code, 1, 2) and substr(b.run_code,2,1) = g.run_code and e.region_code = g.region_code and sysdate < d.end_time ");

	//sqlsBUF.append("  union  ");

	//sqlsBUF.append(" select distinct a.member_id, c.cust_name, e.mode_name, a.member_no, b.contract_no,g.run_name,to_char(a.begin_time,'yyyymmdd hh24:mi:ss') run_time ");

	//sqlsBUF.append(" from dgrpnomebmsg a, dCustMsg b, dCustDoc c, dBillCustDetail d, sBillModeCode e,sRunCode g ");

	//sqlsBUF.append(" where a.member_id=b.id_no and b.cust_id=c.cust_id and a.member_id=d.id_no and d.mode_code=e.mode_code ");

	//sqlsBUF.append(" and d.mode_flag='0' and a.id_no="+idNo+" and e.region_code=substr(b.belong_code, 1, 2) and substr(b.run_code,2,1) = g.run_code and e.region_code = g.region_code and sysdate < d.end_time ");

	//sqlsBUF.append(" union  ");

	//sqlsBUF.append(" select distinct b.id_no,c.cust_name,e.mode_name,a.mobnum ,b.contract_no,g.run_name,to_char(a. recordtime,'yyyymmdd hh24:mi:ss') run_time  ");

	//sqlsBUF.append(" from dpadcrblacklist a, dcustmsg b ,dcustdoc c ,dbillcustdetail d ,sbillmodecode e,sruncode g  ");

	//sqlsBUF.append(" where a.mobnum=b.phone_no and b.cust_id=c.cust_id and  b.id_no=d.id_no and d.mode_code=e.mode_code  ");

	//sqlsBUF.append(" and d.mode_flag='0' and a.ecid='"+idNo+"' and e.region_code=substr(b.belong_code,1,2) ");

	//sqlsBUF.append(" and substr(b.run_code,2,1)=g.run_code and e.region_code=g.region_code and sysdate<d.end_time ");

    //sqlsBUF.append("));");

	//String sqls=sqlsBUF.toString();  

	//System.out.println(" sqls = " + sqls);                                



	//ArrayList arlist = new ArrayList();

	//int[] colNum=new int[1];

	//colNum[0]=6;

	//comImpl co=new comImpl();

	//arlist=co.multiSql(colNum,sqls); 

	//String [][] result1 = new String[][]{};

	//result1 = (String[][])arlist.get(0);    

	//System.out.println("result1 = " + result1.length);	

%>

    <wtc:service name="bs_s242ConCfm"  outnum="7" retcode="errCode" retmsg="errMsg" routerKey="region" routerValue="<%=regionCode%>">

    	<wtc:param value="<%=idNo%>" />
  		

    	</wtc:service>

       <wtc:array id="result0" start="0" length="5" scope="end"/>	



<%

   //循环取值,并将结果储存在list中

    ArrayList arlist = new ArrayList();

    arlist.add(result0);

  

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

	                                                                                                                                                                                            

	writeExcel((java.io.OutputStream)response.getOutputStream(),(ArrayList)arlist, inputPara);

	

	

	

	

	

	String []paraArr=new String[6];

	paraArr[0]="5082";

	paraArr[1]=workNo;

	paraArr[2]=nopass;

	paraArr[3]=org_code;

	paraArr[4]="操作员"+workNo+"对集团产品id为:"+idNo+"的客户进行信息查询导出";

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

