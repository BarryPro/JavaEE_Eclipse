   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-11
********************/
%>

<%@ page contentType="text/html; charset=GB2312" %>
 
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%

  //20100528 liuxmc 添加发票防伪码
		java.util.Random r = new java.util.Random();
		int ran = r.nextInt(9999);
		int ran1 = r.nextInt(10)*1000;
		if((ran+"").length()<4){
			ran = ran+ran1;
		}
		System.out.println("ran：" + ran);
		int key = 99999;
		int realKey = ran ^ key;
		System.out.println("realKey："+realKey);

 	String s_yyt_name="";
  String parm = (String)request.getParameter("parm");//流水
  String contract_no = (String)request.getParameter("contract_no");
  String phoneNo = request.getParameter("phoneNo");
  //读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");          								//工号
	String workName =(String)session.getAttribute("workName"); 
  String regionCode = (String)session.getAttribute("regCode");
  String groupId = (String)session.getAttribute("groupId");
  String ifRed = request.getParameter("ifRed");
  //xl add
  String paySeq = request.getParameter("payAccept");
	String check_seq = request.getParameter("check_seq");
	String s_flag = request.getParameter("s_flag");
  String smop_code = "3172";
  String bill_code = request.getParameter("bill_code");
	String returnPage = "f3172_1.jsp";
	String total_date=new java.text.SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
  String s_id_no="";
  String sm_name  =request.getParameter("s_sm_name");
  String s_sm_code =request.getParameter("s_sm_code");
  String result0  =  "";			//0	返回码                
	String result1 =  "";				//1	返回信息	            
	String result2  =  "";         
	String result3  = "";     
	String result4  =  "";          
	String result5  =  "";           
	String result6  = "";       
	String result7  =  "";             
	String result8  =  "";
	String result9  = "";
	String result10  =  "";
	String result11  =  "";  
	String result12  = "";
	String result13  =  "";
	String result14  =  "";     
	String result15  = "";   
	String result16  =  "";   
	String result17  =  "";
  
  
   
	String[] inParas = new String[4];
	inParas[0] = workNo;
	inParas[1] = contract_no;
	inParas[2] = total_date;
	inParas[3] = parm;
    
  for(int i=0;i<inParas.length;i++){
 		System.out.println("--------------------------inParas["+i+"]:------------------"+inParas[i]);
 	}
	//acceptList = callView.callFXService("s3185Cfm", inParas, "16");
	
	//hq add 根据contract_no查询id_no
		String[] inParam_idno = new String[2];
		inParam_idno[0]="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and "
		 +"a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
		inParam_idno[1]="s_contract_no="+contract_no;
		
	//xl add 根据组织节点查询营业厅名称
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;
	
	
	//xl add for sunby 改造发票打印展示
	String s_name_new="";
	String[] inParam_name = new String[2];
	inParam_name[0]="select b.unit_name from dconmsg a,dgrpcustmsg b where a.con_cust_id=b.cust_id and a.contract_no=:contract_no";
	inParam_name[1]="contract_no="+contract_no;
%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParam_name[0]%>"/>
		<wtc:param value="<%=inParam_name[1]%>"/>
	</wtc:service>
	<wtc:array id="new_name_arr" scope="end" />
<%
	if(new_name_arr!=null&&new_name_arr.length>0)
	{
		s_name_new = new_name_arr[0][0];
	}
%>

	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
		
		
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
	<wtc:param value="<%=inParam_idno[0]%>"/>
	<wtc:param value="<%=inParam_idno[1]%>"/>
	</wtc:service>
	<wtc:array id="id_no_arr" scope="end" />
		
		
    <wtc:service name="s3185Cfm" outnum="16" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[3]%>" />			
		</wtc:service>
		<wtc:array id="result_t" scope="end"/>

<%	
	if(yyt_name_arr!=null&&yyt_name_arr.length>0)
	{
		s_yyt_name = yyt_name_arr[0][0];
	}
	
		
	String return_code = code;
	String error_msg = msg;
	

 	if(id_no_arr!=null&&id_no_arr.length>0){
        	s_id_no = id_no_arr[0][0];
        	phoneNo = id_no_arr[0][1].trim();
  }
	
	
 	System.out.println("--------------------return_code:-----------------"+return_code);
 	System.out.println("--------------------error_msg:------------------"+error_msg);
 	
 	
 	
if ( return_code.equals("000000")||return_code.equals("0") ){
	result0 	= result_t[0][0];	//0	返回码 
	result1 	= result_t[0][1];    //1	返回信息
	result2 	= result_t[0][2];            
	result3  	= result_t[0][3];
	result4  	= result_t[0][4];
	result5  	= result_t[0][5];    
	result6 	= result_t[0][6];
	result7 	= result_t[0][7];
	result8 	= result_t[0][8];             
	result9 	= result_t[0][9];
	result10 	= result_t[0][10];
	result11	= result_t[0][11];
	result12	= result_t[0][12];
	result13	= result_t[0][13];
	result14	= result_t[0][14];
	result15	= result_t[0][15];
	//result16	= result_t[0][16];
	//phoneNo =result5.trim();
	//if(phoneNo.equals("99999999999"))
  //phoneNo="";
    
%>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT language="JavaScript">
 function printInvoice()
    {
        var localPath = "C:/billLogo.jpg";
		//alert(2);
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
		var rowInit = 7;
		var fontSizeInit = 9;//字体大小
		var fontType = "宋体";//字体
		var fontStrongInit = 0;//字体粗细
		var vR = 0;
		var lineSpace = 0;
        //alert(3);
        /*20100528 liuxmc 添加发票防伪码*/
		<%
			/*
			if(s_flag.equals("O"))
			{
				%>
				<%
			}
			if(s_flag.equals("N"))
			{
				%>
					printctrl.DrawImage(localPath,8,10,40,18);//左上右下
 
				<%
			}*/
		%>
		//printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,'20130202');
							printctrl.DrawImage(localPath,8,10,40,18);//左上右下
        printctrl.Print(20, 10, 9, 0, "开票日期:<%=year%>年<%=month%>月<%=day%>日");
		printctrl.Print(115, 10, 9, 0, "本次发票号码:<%=check_seq%>"); 
        /*******************************************/
        //printctrl.Print(13, 12, 9, 0, "防伪码：<%=ran%>");

		//printctrl.Print(13, 13, 9, 0, "工    号：<%=workNo%>");
        //printctrl.Print(72, 13, 9, 0, "操作流水：<%=result15%>");
		printctrl.Print(13, 12, 9, 0, "客户名称:<%=s_name_new.trim()%>");
		printctrl.Print(13, 13, 9, 0, "业务类别:<%=result2%>");
		printctrl.Print(115, 13, 9, 0, "客户品牌:<%=sm_name%>");
		              //列  行
		printctrl.Print(13, 15, 9, 0, "用户号码：<%=phoneNo%>");
		printctrl.Print(13, 16, 9, 0, "协议号码：<%=result6%>");
		printctrl.Print(54, 16, 9, 0, "话费账期:<%=year+month%>");
		printctrl.Print(115, 16, 9, 0, "合同号:");
		/*
		printctrl.Print(46, 15, 9, 0, "协议号码：<%=result6%>");
		printctrl.Print(82, 15, 9, 0, "话费账期:<%=year+month%>");
		printctrl.Print(115, 15, 9, 0, "合同号:");
		*/
		printctrl.Print(115, 17, 9, 0, "支票号:<%=result7%>");
		printctrl.Print(115, 18, 9, 0, "集团统付号码: ");
		printctrl.Print(16, 19, 9, 0, "通信服务费合计:");
		printctrl.Print(16, 19, 9, 0, "本次发票金额:(小写)￥<%=result9.trim()%> 大写金额合计:<%=result8.trim()%> 滞纳金:");
		printctrl.Print(16, 21, 9, 0, "<%=result11%>");//备注 
		printctrl.Print(16, 22, 9, 0, "<%=result12%>");//备注 
		printctrl.Print(16, 23, 9, 0, "<%=result13%>");//备注 
		printctrl.Print(16, 23, 9, 0, "<%=result14%>");//备注
		//printctrl.Print(16, 22, 9, 0, "备注1"<br>"备注2"<br>");//备注 
 
		
		//xl add 开票：                    收款：                     复核：
		printctrl.Print(13, 30, 9, 0, "流水号：<%=result15%>");
		printctrl.Print(54, 30, 9, 0, "开票人：<%=workName%>");
		printctrl.Print(85, 30, 9, 0, "工号：<%=workNo%>");
		printctrl.Print(110, 30, 9, 0, "营业厅：<%=s_yyt_name%>");
		//alert(4);
        printctrl.PageEnd();
        printctrl.StopPrint();
        //alert(5);
    }

    function ifprint()
    {
        printInvoice();
        document.location.replace("<%=returnPage%>");
    }
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
 
</body>     
</html>

<%
	
	//发票电子化添加入库服务
		String[] inParas0 = new String[29];
		inParas0[0] = parm;//流水
		inParas0[1] = smop_code;//
		inParas0[2] = workNo;
		inParas0[3] = total_date;//没有用
		inParas0[4] = phoneNo;
		inParas0[5] = s_id_no;//id_no 只是入表用 实在不行在程序里自己取一下
		inParas0[6] = contract_no;//contract_no
		 
		inParas0[7] = realKey+"";//防伪码
		System.out.println("=============sm_name====================="+sm_name);
		//xl add 发票预占状态变更入参 begin
		//发票号码 发票金额 地市 group_id 备注 发票代码 
		inParas0[8] = check_seq;//发票号码;
		inParas0[9] = bill_code;//发票代码;
		inParas0[10] =s_sm_code;//品牌
		inParas0[11] =result9.trim();//小写金额
		inParas0[12] = result8.trim();//大写金额
		inParas0[13] = "" ;
		
		//本次缴费金额 这个得看样张都有啥
		//xl add 发票预占状态变更入参 end


		//inParas0[14] ="1";//发票打印
		inParas0[14] = "";//增值税的
		inParas0[15] = "0";//增值税的
		inParas0[16] = "0";//增值税的
		inParas0[17] = "0";//打印年月
		inParas0[18] = result4.trim();
		inParas0[19] = "";
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = regionCode;
		inParas0[25] = groupId; 
		inParas0[26] = ifRed;
		inParas0[27] ="0";//通用机打 
		 

		System.out.println("====执行 s1300PrintInDB 开始=======");
		String[][] result22 = new String[][]{};
		//打印的时候 按流水更新状态 预占的更新为已打印
%>		
		<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
			<wtc:param value="<%=inParas0[0]%>"/>
			<wtc:param value="<%=inParas0[1]%>"/>
			<wtc:param value="<%=inParas0[2]%>"/>
			<wtc:param value="<%=inParas0[3]%>"/>
			<wtc:param value="<%=inParas0[4]%>"/>
			<wtc:param value="<%=inParas0[5]%>"/>
			<wtc:param value="<%=inParas0[6]%>"/>
			<wtc:param value="<%=inParas0[7]%>"/>
			<wtc:param value="<%=inParas0[8]%>"/>
			<wtc:param value="<%=inParas0[9]%>"/>
			<wtc:param value="<%=inParas0[10]%>"/>
			<wtc:param value="<%=inParas0[11]%>"/>
			<wtc:param value="<%=inParas0[12]%>"/>
			<wtc:param value="<%=inParas0[13]%>"/>
			<wtc:param value="<%=inParas0[14]%>"/>
			<wtc:param value="<%=inParas0[15]%>"/>
			<wtc:param value="<%=inParas0[16]%>"/>
			<wtc:param value="<%=inParas0[17]%>"/>
			<wtc:param value="<%=inParas0[18]%>"/>
			<wtc:param value="<%=inParas0[19]%>"/>
			<wtc:param value="<%=inParas0[20]%>"/>
			<wtc:param value="<%=inParas0[21]%>"/>
			<wtc:param value="<%=inParas0[22]%>"/>
			<wtc:param value="<%=inParas0[23]%>"/>
			<wtc:param value="<%=inParas0[24]%>"/>
			<wtc:param value="<%=inParas0[25]%>"/>
			<wtc:param value="<%=inParas0[26]%>"/>
			<wtc:param value="<%=inParas0[27]%>"/>
		</wtc:service>
		<wtc:array id="RetResult" scope="end"/>
<%
		System.out.println("====执行 szg12InDB 结束=======");
		if(RetResult.length > 0)
		{
			result22 = RetResult;
			if((result22[0][0]!="000000")&&!result22[0][0].equals("000000"))
			{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,错误代码"+"<%=result22[0][0]%>"+",错误原因:"+"<%=result22[0][1]%>".",0);
					    document.location.replace("<%=returnPage%>");
					</script>
        <%			
			}
			
		}
		else if(RetResult == null || RetResult.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,szg12InDB_pt服务返回结果为空.",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%			
		}
	}else{
%>
	 <script language="JavaScript">
			rdShowMessageDialog("发票打印错误,请联系管理员!<br>错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'。",0);
			window.close();
	 </script>
<%
	}
%>


