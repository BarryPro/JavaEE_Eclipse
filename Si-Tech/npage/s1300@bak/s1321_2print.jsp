<%
  /*
   * 功能:兑换发票1321
   * 版本: 1.0
   * 日期: 2009/1/16
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.util.MoneyUtil"%>
<%@ page import="java.text.*" %>
<script language="javascript">
		
	</script>
<%
	String groupId = (String)session.getAttribute("groupId");
   java.util.Random r = new java.util.Random();
	 int ran = r.nextInt(9999);
	 int ran1 = r.nextInt(10)*1000;
	 if((ran+"").length()<4){
	  	ran = ran+ran1;
	 }
	 int key = 99999;
	 int realKey = ran ^ key;
	 System.out.println("realKey："+realKey);
		
	 String bill_type = "2";

	String opCode = "1321";
	String opName = "收据兑换月消费发票 ";
	MoneyUtil mon = new MoneyUtil();
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String phoneNo = (String)request.getParameter("phoneNo");
	
	String i_contract_no = request.getParameter("contract_no");
	String i_year_month = request.getParameter("year_month");
	String i_year_month_end = request.getParameter("year_month_end");
	String i_begin_ym = request.getParameter("begin_ym");
	String i_begin_ym_end =request.getParameter("begin_ym_end");
	String nopass = (String)session.getAttribute("password");
	// xl add for 发票号码 begin
	String check_seq="";//request.getParameter("check_seq");
	String s_flag =  "";//request.getParameter("s_flag"); 
	long ll =0;// Long.parseLong(check_seq)+1; 
	
	String str = "";//ll+"";
	System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS ll is "+ll+" and str is "+str);

	//xl add 
	String d_pay = request.getParameter("d_pay");
	String wpay_yikaiju = request.getParameter("wpay_yikaiju");


	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";//bill_accept
	String i_login_accept = "";
	String loginAccept="";

	String d1 ="";
	%>
	 
 
	
<%	
   
	String return_code = "0";
	boolean canPrint = false;
    boolean canPrint2 = false;
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String year = dateStr.substring(0,4);
	String month = dateStr.substring(4,6);
	String day = dateStr.substring(6,8);
	
 

	String[] inParas = new String[6];
	inParas[0] = i_contract_no;
	inParas[1] = i_year_month;
	inParas[2] = i_year_month_end;
	inParas[3] = i_begin_ym;
	inParas[4] = i_begin_ym_end;
	inParas[5] =workno;
 
   //System.out.println("-------------------------zss--------------------------"+ inParas[5]);
   
    //retList = impl.callFXService("s1322Init", inParas, "16");
%>
	<wtc:service name="s1322Init" routerKey="region" routerValue="<%=regionCode%>" outnum="18" retcode="retCode1" retmsg="retMsg1">
		<wtc:params value="<%=inParas%>"/>
	</wtc:service>
	<wtc:array id="out_result0" start="0" length="1" scope="end"/>
	<wtc:array id="out_result1" start="1" length="1" scope="end"/>
	<wtc:array id="out_result2" start="3" length="1" scope="end"/>
	<wtc:array id="out_result3" start="4" length="1" scope="end"/>
	<wtc:array id="out_result4" start="5" length="1" scope="end"/>
	<wtc:array id="out_result5" start="5" length="1" scope="end"/>
	<wtc:array id="out_result6" start="6" length="1" scope="end"/>
	<wtc:array id="out_result7" start="7" length="1" scope="end"/>
	<wtc:array id="out_result8" start="8" length="1" scope="end"/>
	<wtc:array id="out_result9" start="9" length="1" scope="end"/>
	<wtc:array id="out_result10" start="10" length="1" scope="end"/>
	<wtc:array id="out_result11" start="11" length="1" scope="end"/>
	<wtc:array id="out_result12" start="12" length="1" scope="end"/>
	<wtc:array id="out_result13" start="13" length="1" scope="end"/>
	<wtc:array id="out_result14" start="14" length="1" scope="end"/>
	<wtc:array id="out_result15" start="15" length="1" scope="end"/>
	<wtc:array id="out_result16" start="16" length="2" scope="end"/>
<%
	if (out_result0.length!=0) {
	   //out_result0 = (String[][])retList.get(0);     
	   return_code = out_result0[0][0];
	}
        
  if (retCode1.equals("000000")) {
        canPrint = true;
	 }	 	 
%>

<%if (!canPrint) {%>
   <script language="JavaScript">
     rdShowMessageDialog("<%=retMsg1%>! ");
     window.location="s1321_2.jsp";
   </script>
<% } else {%>
<SCRIPT language="JavaScript">
<!--
function ifprint(){
	//alert("out_result15 is "+"<%=out_result15[0][0]%>"+" and out_result14 is "+"<%=out_result14[0][0]%>");
	//第15个参数是 SUCCESS
	printInDB();
 }

<%
    ///liuxmc add  发票电子化添加入库服务 开始
%>
    function printInDB(){
<%
      String i_paymoney = request.getParameter("paymoney");
      double yingsou = 0.00;  
      double i_money_small =  Double.parseDouble(i_paymoney) - yingsou;
	  String s_money_small	= "";
      
    	String[] inParas0 = new String[15];
			inParas0[0] = realKey+"";
			inParas0[1] = loginAccept;
			inParas0[2] = opCode;
	    inParas0[3] = workno;
	    inParas0[4] = dateStr;
	    inParas0[5] = out_result8[0][0].trim();//服务号码
	    inParas0[6] = out_result9[0][0].trim();
	    String sm_name="";
	    if(sm_name == null || sm_name.trim().length() == 0){
	    	sm_name = "品牌：";
	    }
	    inParas0[7] = sm_name;
	    inParas0[8] = mon.NumToRMBStr(Double.parseDouble(i_paymoney) - yingsou);
	    inParas0[9] = out_result12[0][0].trim();
	    inParas0[10] = out_result15[0][0].trim();
	    inParas0[11] = mon.NumToRMBStr(Double.parseDouble(i_paymoney) - yingsou);
		inParas0[12] = "优惠："+out_result3[0][0]+" 实收："+out_result6[0][0];
		inParas0[13] = "营业员姓名：" + workname;
		inParas0[14] = out_result3[0][0].trim();
%>
		 
		try {
         <%	
         
         
         //String[][] result0 = new String[][]{};
         //String[][] result1 = new String[][]{};
         //String[][] result2 = new String[][]{};
         String cust_name = out_result7[0][0];
         System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCc out_result6.length is "+out_result6.length);
         for (int i=0;i<out_result6.length;i++) {
 
//增加系统流水
	String sql_accept = "SELECT to_char(ltrim(rtrim(sMaxSysAccept.nextval))) FROM Dual";
	%>
	<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
			<wtc:sql><%=sql_accept%></wtc:sql>
			</wtc:pubselect>
	<wtc:array id="count1_new" scope="end" />	
	<%
		 
		if(count1_new.length>0)
		{
			i_login_accept = count1_new[0][0].trim();
			inParas0[1]=i_login_accept;
		}
			loginAccept=i_login_accept;
           yingsou += Double.parseDouble(out_result6[i][0]);
           String i_contract = request.getParameter("contract");
           String i_year = request.getParameter("year");
           String i_accept = request.getParameter("accept");
           String i_work_no = request.getParameter("work_no");
           
		   double d_money_small =  Double.parseDouble(i_paymoney) - yingsou;
		   s_money_small=""+d_money_small;
	       d1 =(new DecimalFormat("0.00")).format(Double.parseDouble(s_money_small) );
          //计算消费年月的明细
           if(i==0){ 
           inParas = new String[6];
           inParas[0] = i_contract;
           inParas[1] = out_result1[i][0];
           inParas[2] = i_work_no;
           inParas[3] = i_accept;
           inParas[4] = i_year;
           inParas[5] = nopass;
		   System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! here?");
         }else{ 
           inParas = new String[6];
           inParas[0] = i_contract;
           inParas[1] = out_result1[i][0];
           inParas[2] = i_work_no;
           inParas[3] = "";
           inParas[4] = i_year;
           inParas[5] = nopass;
		   System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! there~~~");
         }
           System.out.println("inParas[0] is "+i_contract+" inParas[1] is "+out_result1[i][0]+" inParas[2] is "+i_work_no+" inParas[3] is "+i_accept+" inParas[4] is "+i_year +" inParas[5] is "+nopass);
         	 
           //retList = impl.callFXService("s1322Cfm", inParas, "5");
         %>
         	<wtc:service name="s1322Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="5" retcode="retCode2" retmsg="retMsg2">
         		<wtc:param value="<%=inParas[0]%>"/>
				<wtc:param value="<%=inParas[1]%>"/>
				<wtc:param value="<%=inParas[2]%>"/>
				<wtc:param value="<%=inParas[3]%>"/>
				<wtc:param value="<%=inParas[4]%>"/>
				<wtc:param value="<%=inParas[5]%>"/>
         	</wtc:service>
         	<wtc:array id="result0"  start="0" length="1" scope="end"/>
         	<wtc:array id="result1"  start="1" length="1" scope="end"/>
         	<wtc:array id="result2"  start="2" length="1" scope="end"/>
         	<wtc:array id="result3"  start="3" length="1" scope="end"/>
         	
         <%
         System.out.print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"+retCode1);
         	String return_code2 = retCode2;
         	String return_msg2  = retMsg2;
			String i_money=mon.NumToRMBStr(Double.parseDouble(i_paymoney) - yingsou);
			
         	if (return_code2.equals("000000")||return_code2.equals("0")) {
         	    canPrint2 = true;
				%>
				//window.location="s1321_2printNew.jsp?contract_no="+"<%=i_contract_no%>"+"&year_month="+"<%=i_year_month%>"+"&year_month_end="+"<%=i_year_month_end%>"+"&begin_ym="+"<%=i_begin_ym%>"+"&begin_ym_end="+"<%=i_begin_ym_end%>"+"&phoneNo="+"<%=phoneNo%>"+"&i_money="+"<%=i_money%>"+"&cust_name="+"<%=cust_name%>"+"&i_money_small="+"<%=i_money_small%>"+"&check_seq="+"<%=str%>"+"&s_flag="+"<%=s_flag%>"+"&wpay_yikaiju="+"<%=wpay_yikaiju%>"+"&d_pay="+"<%=d_pay%>";
				<%
         	}
         	if (!canPrint2) {%>
         	    
         	     rdShowMessageDialog("打印失败! ,错误原因："+"<%=return_msg2%>");
         	     window.location="s1321_2.jsp";
         	 return false;
         	<%
         		
         	}
			else
			{%>
				   <!--xl add 发票预占-->
					<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=phoneNo%>"  outnum="8" >
							 
							<wtc:param value="<%=loginAccept%>"/>
							<wtc:param value="<%=opCode%>"/>
							<wtc:param value="<%=workno%>"/>
							<wtc:param value=""/><!--op_time-->
							<wtc:param value="<%=phoneNo%>"/>
							<wtc:param value="0"/><!--id_no-->
							<wtc:param value="<%=i_contract_no%>"/>
							<wtc:param value=""/><!--s_check_num-->
							<wtc:param value=""/><!--发票号码 第一次调用时 传空 我在服务里tpcallBASD的接口取得-->
							<wtc:param value=""/><!--发票代码 空-->
							<wtc:param value=""/><!--sm_code-->
							<wtc:param value="<%=out_result6[i][0].trim()%>"/><!--小写金额-->
							<wtc:param value=""/><!--大写金额-->
							<wtc:param value=""/><!--备注-->
						 
							<wtc:param value="6"/><!--预占是6 取消是5即未打印-->
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/><!--账期-->
							<wtc:param value="<%=cust_name%>"/><!--后面的：-->
							<wtc:param value="0"/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value="<%=regionCode%>"/>
							<wtc:param value="<%=groupId%>"/>	
							<wtc:param value="3"/>
					</wtc:service>
					<wtc:array id="bill_opy" scope="end"/> 	
					<%
						if(bill_opy!=null&&bill_opy.length>0)
						{
							return_flag=bill_opy[0][0];
							if(return_flag.equals("000000"))
							{
								 ocpy_begin_no=bill_opy[0][2];
								 ocpy_end_no=bill_opy[0][3];
								 ocpy_num=bill_opy[0][4];
								 res_code=bill_opy[0][5];
								 bill_code=bill_opy[0][6];
								 bill_accept=bill_opy[0][7];
								  
							}
							else
							{
								return_note=bill_opy[0][1];
								%>
									<script language="javascript">
										alert("发票预占失败!错误原因:"+"<%=return_note%>");
										history.go(-1);
									</script>
								<%
							}
						}
					%>
					if(rdShowConfirmDialog("当前发票号码是"+"<%=ocpy_begin_no%>"+",是否打印发票?")==1)
					{
						//alert("1 继续执行");
					}
					else
					{
						alert("调用取消接口 取消预占");
						return false;
					}
				   <%
				   
				   out.println("printctrl.Setup(0)");
				   out.println("printctrl.StartPrint()");
				   out.println("printctrl.PageStart()");
					 
					   //new begin
					%>
					var localPath = "C:/billLogo.jpg";
					printctrl.DrawImage(localPath,8,10,40,18);//左上右下
 
				<%
				   
				   out.println("printctrl.Print(20, 7, 9, 0,'"+year+month+day+"')");
				   out.println("printctrl.Print(85, 7, 9, 0,'邮电通信业')");	
				   out.println("printctrl.Print(110,7, 9, 0,'发票号码:"+ocpy_begin_no+"')");
				   
				   out.println("printctrl.Print(13, 9, 9, 0,'"+"防伪码："+ran+"')");

				   out.println("printctrl.Print(13, 10, 9, 0,'"+"工    号："+i_work_no+"')");
				   out.println("printctrl.Print(72, 10, 9, 0,'"+"操作流水："+loginAccept+"')");
				   out.println("printctrl.Print(115, 10, 9, 0,'业务名称：收据兑换月消费发票')");	
				 
				   out.println("printctrl.Print(13, 11, 9, 0,'客户名称："+out_result7[0][0]+"')");	
				   out.println("printctrl.Print(115, 11, 9, 0,'卡    号：')");	
			 
				   out.println("printctrl.Print(13, 12, 9, 0,'手机号码："+out_result8[0][0]+"')");
				   out.println("printctrl.Print(72, 12, 9, 0,'协议号码："+out_result9[0][0]+"')");
				   out.println("printctrl.Print(115, 12, 9, 0,'支票号码：')");
				  
				   out.println("printctrl.Print(13, 13, 9, 0,'合计金额：(大写)"+mon.NumToRMBStr(Double.parseDouble(out_result6[i][0]))+"')");
				   out.println("printctrl.Print(115, 13, 9, 0,'(小写)￥"+out_result6[i][0].trim()+"')");
				   out.println("printctrl.Print(13, 14, 9, 0,'(项目)')");
				   //add
				   out.println("printctrl.Print(13, 15, 9, 0,'"+result3[0][0]+"')");
				 
				   out.println("printctrl.Print(13, 16, 9, 0,'应收：')");
					// add 1
					int rownumber = 13; //当成列
					int colnumber = 17; //当成行
					ArrayList r1 = new ArrayList();
				   ArrayList r2 = new ArrayList();
				   
				 
				   for (int j = 0; j < result1.length; j++) {
					   if (!(result2[j][0].trim()).equals("0.00")) {
						  r1.add(result1[j][0]);
						  r2.add(result2[j][0]);
					  } 
				   }
				   
				   if (!(out_result4[i][0].trim()).equals("0.00")) {
					   r1.add("滞纳金");
					   r2.add(out_result4[i][0]);
				   }
				 
				   if (!(out_result5[i][0].trim()).equals("0.00")) {
					   r1.add("补收月租");
					   r2.add(out_result5[i][0]);
				   }
				   
				   for (int j = 0; j < r1.size(); j++) {
					  out.println("printctrl.Print("+rownumber+","+colnumber+",9,0,'"+((String)r1.get(j)).trim()+": "+((String)r2.get(j)).trim()+"')");
					 rownumber += 45;
					   
					 if (j%3 == 2) {
						colnumber += 1;
						rownumber = 13;
					 }
				   }
		   
				   out.println("printctrl.Print(13,"+(colnumber+2)+",9,0,'"+"优惠：" + out_result3[i][0] +"')");
				   out.println("printctrl.Print(13,"+(colnumber+4)+",9,0,'"+"实收："+ out_result6[i][0] +"')");
					// end add 1
				 
				   out.println("printctrl.Print(13, 25, 9, 0,'开票："+workname+"')");
				   out.println("printctrl.Print(37, 25, 9, 0,'收款：')");
				   out.println("printctrl.Print(60, 25, 9, 0,'复核：')");	
				   //new end
				   out.println("printctrl.PageEnd()");
				   out.println("printctrl.StopPrint()");
			}
			//xl add
			%>
			//alert("第几次？");
				<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
						<wtc:param value="<%=loginAccept%>"/>
						<wtc:param value="1321"/>
						<wtc:param value="<%=workno%>"/>
						<wtc:param value=" "/>
						<wtc:param value="<%=phoneNo%>"/>
						<wtc:param value="0"/> 
						<wtc:param value="<%=i_contract_no%>"/> 
						<wtc:param value=""/>
						<wtc:param value="<%=ocpy_begin_no%>"/>
						<wtc:param value="<%=bill_code%>"/>
						<wtc:param value="0"/>
						<wtc:param value="<%=out_result6[i][0].trim()%>"/>
						<wtc:param value="<%=mon.NumToRMBStr(Double.parseDouble(out_result6[i][0]))%>"/>
						<wtc:param value="1321发票兑换"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value=""/> 
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="<%=regionCode%>"/>
						<wtc:param value="<%=groupId%>"/>
						<wtc:param value="3"/>
						<wtc:param value="0"/>
					</wtc:service>
					<wtc:array id="RetResult" scope="end"/>	
					<%
					String returnPage="s1321_3.jsp";
					String[][] result2_in_db = new String[][]{};
					System.out.println("====执行 s1300PrintInDB 结束=======");
					if(RetResult.length > 0)
					{
						result2_in_db = RetResult;
						if((result2_in_db[0][0]!="000000")&&!result2_in_db[0][0].equals("000000"))
						{
							%>
							 
									rdShowMessageDialog("电子发票入库失败,营业员没有录入发票号码或者录入的发票号码已经打印完毕.",0);
									document.location.replace("<%=returnPage%>");
							 
					<%			
						}
						
					}
					else if(RetResult == null || RetResult.length == 0){
			%>
								 
									rdShowMessageDialog("电子发票入库失败,s1300PrintInDB服务返回结果为空.",0);
									document.location.replace("<%=returnPage%>");
			 
			<%			
					}
						
					//////////////////////////////////////////////
				else{
			%> 
									rdShowMessageDialog("发票打印失败,s1300Print服务返回结果为空.<br>请使用补打发票交易打印发票!",0);
									document.location.replace("<%=returnPage%>");
							 
			<%
					}
					 
			 
						//xl add 电子化入库 end

				//end of 多次 sinvoiceInDB
			//end of 消费发票循环
         }

		 //增加系统流水
		String sql_accept1 = "SELECT to_char(ltrim(rtrim(sMaxSysAccept.nextval))) FROM Dual";
		%>
		<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
				<wtc:sql><%=sql_accept1%></wtc:sql>
				</wtc:pubselect>
		<wtc:array id="count1_new1" scope="end" />	
		<%
			 
			if(count1_new1.length>0)
			{
				i_login_accept = count1_new1[0][0].trim();
		 
			}
			 //打印剩余的
		%>
		
		 <!--xl add 发票预占-->
					<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=phoneNo%>"  outnum="8" >
							 
							<wtc:param value="<%=loginAccept%>"/>
							<wtc:param value="<%=opCode%>"/>
							<wtc:param value="<%=workno%>"/>
							<wtc:param value=""/><!--op_time-->
							<wtc:param value="<%=phoneNo%>"/>
							<wtc:param value="0"/><!--id_no-->
							<wtc:param value="<%=i_contract_no%>"/>
							<wtc:param value=""/><!--s_check_num-->
							<wtc:param value=""/><!--发票号码 第一次调用时 传空 我在服务里tpcallBASD的接口取得-->
							<wtc:param value=""/><!--发票代码 空-->
							<wtc:param value=""/><!--sm_code-->
							<wtc:param value="<%=d1%>"/><!--小写金额-->
							<wtc:param value=""/><!--大写金额-->
							<wtc:param value=""/><!--备注-->
						 
							<wtc:param value="6"/><!--预占是6 取消是5即未打印-->
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/><!--账期-->
							<wtc:param value="<%=cust_name%>"/><!--后面的：-->
							<wtc:param value="0"/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value=""/>
							<wtc:param value="<%=regionCode%>"/>
							<wtc:param value="<%=groupId%>"/>	
							<wtc:param value="3"/>
						 
					</wtc:service>
					<wtc:array id="bill_opy" scope="end"/> 	
					<%
						if(bill_opy!=null&&bill_opy.length>0)
						{
							return_flag=bill_opy[0][0];
							if(return_flag.equals("000000"))
							{
								 ocpy_begin_no=bill_opy[0][2];
								 ocpy_end_no=bill_opy[0][3];
								 ocpy_num=bill_opy[0][4];
								 res_code=bill_opy[0][5];
								 bill_code=bill_opy[0][6];
								 bill_accept=bill_opy[0][7];
								  
							}
							else
							{
								return_note=bill_opy[0][1];
								%>
									<script language="javascript">
										alert("发票预占失败!错误原因:"+"<%=return_note%>");
										history.go(-1);
									</script>
								<%
							}
						}
					%>
					if(rdShowConfirmDialog("剩余发票的当前发票号码是"+"<%=ocpy_begin_no%>"+",是否打印发票?")==1)
					{
						alert("1 继续执行");
					}
					else
					{
						alert("调用取消接口 取消预占");
						return false;
					}
				    <%
					out.println("printctrl.Setup(0)");
					out.println("printctrl.StartPrint()");
					out.println("printctrl.PageStart()");
			 
				  %>
					var localPath = "C:/billLogo.jpg";
					printctrl.DrawImage(localPath,8,10,40,18);//左上右下
 
				<%

				  out.println("printctrl.Print(20, 10, 9, 0,'"+year+month+day+"')");
				  out.println("printctrl.Print(85, 10, 9, 0,'邮电通信业')");
				  out.println("printctrl.Print(110, 8, 9, 0,'发票号码:"+ocpy_begin_no+"')"); 		
					

				  out.println("printctrl.Print(13, 10, 9, 0,'"+"工    号："+workno+"')");
				  out.println("printctrl.Print(72, 10, 9, 0,'"+"操作流水："+i_login_accept+"')");
				  out.println("printctrl.Print(1115, 10, 9, 0,'业务名称：收据兑换月消费发票')");

				 
				  out.println("printctrl.Print(13, 11, 9, 0,'客户名称："+ cust_name +"')");	
				  out.println("printctrl.Print(115, 11, 9, 0,'卡    号：')");	
			 
				  out.println("printctrl.Print(13, 12, 9, 0,'手机号码："+phoneNo+"')");
				  out.println("printctrl.Print(72, 12, 9, 0,'协议号码："+i_contract_no+"')");
				  out.println("printctrl.Print(115, 12, 9, 0,'支票号码：')");
				  
				  out.println("printctrl.Print(13, 13, 9, 0,'合计金额：(大写)"+mon.NumToRMBStr(Double.parseDouble(d1))+"')");
				  
				  out.println("printctrl.Print(115, 13, 9, 0,'(小写)￥"+d1+"')");
				  out.println("printctrl.Print(13, 14, 9, 0,'(项目)')");
				  out.println("printctrl.Print(13, 15, 9, 0,'换发票时的余额发票')");
				  
				  //xl add 营改增
			 
				  out.println("printctrl.Print(13, 25, 9, 0,'开票："+workname+"')");
				  out.println("printctrl.Print(32, 25, 9, 0,'收款：')");
				  out.println("printctrl.Print(60, 25, 9, 0,'复核：')");
				// end
			
				out.println("printctrl.PageEnd()");
				out.println("printctrl.StopPrint()");
					
					//调用入库的
					%>
					<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
						<wtc:param value="<%=loginAccept%>"/>
						<wtc:param value="1321"/>
						<wtc:param value="<%=workno%>"/>
						<wtc:param value=" "/>
						<wtc:param value="<%=phoneNo%>"/>
						<wtc:param value="0"/> 
						<wtc:param value="<%=i_contract_no%>"/> 
						<wtc:param value=""/>
						<wtc:param value="<%=ocpy_begin_no%>"/>
						<wtc:param value="<%=bill_code%>"/>
						<wtc:param value="0"/>
						<wtc:param value="<%=d1%>"/>
						<wtc:param value=""/>
						<wtc:param value="1321发票兑换"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value=""/> 
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="0"/>
						<wtc:param value="<%=regionCode%>"/>
						<wtc:param value="<%=groupId%>"/>
						<wtc:param value="3"/>
						<wtc:param value="0"/>
					</wtc:service>
					<wtc:array id="RetResult" scope="end"/>	
					<%
					String returnPage="s1321_3.jsp";
					String[][] result2_in_db = new String[][]{};
					System.out.println("====执行 s1300PrintInDB 结束=======");
					if(RetResult.length > 0)
					{
						result2_in_db = RetResult;
						if((result2_in_db[0][0]!="000000")&&!result2_in_db[0][0].equals("000000"))
						{
							%>
							 
									rdShowMessageDialog("电子发票入库失败,营业员没有录入发票号码或者录入的发票号码已经打印完毕.",0);
									document.location.replace("<%=returnPage%>");
							 
					<%			
						}
						
					}
					else if(RetResult == null || RetResult.length == 0){
			%>
								 
									rdShowMessageDialog("电子发票入库失败,s1300PrintInDB服务返回结果为空.",0);
									document.location.replace("<%=returnPage%>");
			 
			<%			
					}
						
					//////////////////////////////////////////////
				else{
			%> 
									rdShowMessageDialog("发票打印失败,s1300Print服务返回结果为空.<br>请使用补打发票交易打印发票!",0);
									document.location.replace("<%=returnPage%>");
							 
			<%
					}
					 
			 
						//xl add 电子化入库 end
				%>
	
					rdShowMessageDialog("打印成功!");
					document.location.replace("s1321_1.jsp");
         } catch(e) {
         } finally {
         }
		
		 
         
         }
 
		 
	<%
 
 

 	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1
		+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept
		+"&pageActivePhone="+i_contract_no+"&opBeginTime="+opBeginTime+"&contactId="+i_contract_no+"&contactType=acc";
	System.out.println(url);
%>
	<jsp:include page="<%=url%>" flush="true" />
-->

</SCRIPT>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
<body onload="ifprint()">
<form action="" name="form" method="post">
</form>
</body>
</html>

<% } 
 
%>