<%
  /*
   * 功能:兑换发票1321
   * 版本: 1.0
   * 日期: 2009/2/16
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.util.MoneyUtil"%>
<%@ page import="java.text.*" %>

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
	String opName = "等额发票兑换月消费发票";
	MoneyUtil mon = new MoneyUtil();
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");;
	String regionCode = (String)session.getAttribute("regCode");
	
	String i_contract_no = request.getParameter("contract_no");
	String i_begin_ym = request.getParameter("begin_ym");
	String i_end_ym = request.getParameter("end_ym");
	String i_cust_name = request.getParameter("cust_name");
	String i_phone_no = request.getParameter("phone_no");
	String i_bill_no = request.getParameter("bill_no");
	String i_bill_money = request.getParameter("bill_money");
	String i_money_total = request.getParameter("money_total");
	String nopass = (String)session.getAttribute("password");
	String return_code = "0";
	boolean canPrint = false;
	boolean canPrint2 = false;
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String year = dateStr.substring(0,4);
	String month = dateStr.substring(4,6);
	String day = dateStr.substring(6,8);
 	
	// xl add for 发票号码 begin
	String check_seq=request.getParameter("check_seq");
	String s_flag = request.getParameter("s_flag");
	String str="";	
 	
	String[] inParas = new String[4];
	inParas[0] = i_contract_no;
	inParas[1] = i_begin_ym;
    inParas[2] = i_end_ym;
    inParas[3] =workno;


	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";//bill_accept
	String last_bill_accept = request.getParameter("bill_accept");
   
    String i_login_accept = "";
%>
	<wtc:service name="s1323Init" routerKey="region" routerValue="<%=regionCode%>" outnum="7" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/> 
	</wtc:service>
	<wtc:array id="out_result0" start="0" length="1" scope="end"/>
	<wtc:array id="out_result1" start="1" length="1" scope="end"/>
	<wtc:array id="out_result2" start="2" length="1" scope="end"/>
	<wtc:array id="out_result3" start="3" length="1" scope="end"/>
	<wtc:array id="out_result4" start="4" length="1" scope="end"/>
	<wtc:array id="out_result5" start="5" length="1" scope="end"/>
	<wtc:array id="out_result6" start="6" length="1" scope="end"/>
<%
        
	if (retCode.equals("000000")||retCode.equals("0")) {
	    return_code = out_result0[0][0];
	}
    if (return_code.equals("000000")||retCode.equals("0")) {
       canPrint = true;
/*	   out_result1 = (String[][])retList.get(1);
	   out_result2 = (String[][])retList.get(2);
       out_result3 = (String[][])retList.get(3);
	   out_result4 = (String[][])retList.get(4);
	   out_result5 = (String[][])retList.get(5);
	   out_result6 = (String[][])retList.get(6);
*/
	}	
%>

<%if (!canPrint) {%>
   <script language="JavaScript">
     rdShowMessageDialog("此用户无权限打印! ");
     window.location="s1321_3.jsp";
  </script>
<% } else {%>
<SCRIPT language="JavaScript">
 
function ifprint(){
	
//	alert("11");
	printInDB(); 
	//alert("2");
}

   function printInDB(){
		//alert("3");	 
		
				try {
         <%	
			 
		   
		
		double yingsou = 0.00;
		double d1 = Double.parseDouble(i_money_total.trim());
		double d2 = Double.parseDouble(i_bill_money.trim());
		String[] inParas0 = new String[13];
		inParas0[0] = realKey+"";
		inParas0[1] = i_login_accept;
		inParas0[2] = opCode;
	    inParas0[3] = workno;
	    inParas0[4] = dateStr;
	    inParas0[5] = i_phone_no;//服务号码
	    inParas0[6] = i_contract_no;
	    String sm_name="";
	    if(sm_name == null || sm_name.trim().length() == 0){
	    	sm_name = "品牌：";
	    }
	    inParas0[7] = sm_name;
	    inParas0[8] = year+month+day;
	    inParas0[9] = i_cust_name;
	    inParas0[10] = i_bill_no;
	    inParas0[11] = mon.NumToRMBStr(d1+d2-yingsou);


         for (int i=0;i<out_result1.length;i++) {

		 
			 
			 //xl add 多次预占 调用basd接口 begin
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
					/*if(s_flag=="first" ||s_flag.equals("first"))
					{
						i_login_accept=last_bill_accept;
					}
					else
					{
						i_login_accept = count1_new[0][0].trim();
					}
					*/
					i_login_accept = count1_new[0][0].trim();
					
				}
				
			%>
			<!--xl add 发票预占-->
			<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=i_phone_no%>"  outnum="8" >
					<wtc:param value="<%=i_login_accept%>"/>
					<wtc:param value="<%=opCode%>"/>
					<wtc:param value="<%=workno%>"/>
					<wtc:param value=""/><!--op_time-->
					<wtc:param value="<%=i_phone_no%>"/>
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
					<wtc:param value="<%=i_cust_name%>"/><!--后面的：-->
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
			 //end 多次预占 调用basd接口 begin
             yingsou += Double.parseDouble(out_result6[i][0]);

               inParas = new String[6];
               inParas[0] = i_contract_no;
               inParas[1] = out_result1[i][0];
               inParas[2] = workno;
               inParas[3] = "0";
               inParas[4] = "0";  
               inParas[5] = nopass;
    

              %>
              	<wtc:service name="s1323Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode1" retmsg="retMsg1">
              		<wtc:param value="<%=inParas[0]%>"/>
              		<wtc:param value="<%=inParas[1]%>"/>
              		<wtc:param value="<%=inParas[2]%>"/>
              		<wtc:param value="<%=inParas[3]%>"/>
              		<wtc:param value="<%=inParas[4]%>"/> 
              		<wtc:param value="<%=inParas[5]%>"/>
              	</wtc:service>
              	<wtc:array id="result0" start="0" length="1" scope="end"/>
              	<wtc:array id="result1" start="1" length="1" scope="end"/>
              	<wtc:array id="result2" start="2" length="1" scope="end"/>
              	<wtc:array id="result3" start="3" length="1" scope="end"/>
              <%
                String return_code3 = retCode1;
                String return_msg3  = retMsg1;
                if (return_code3.equals("000000")||return_code3.equals("0")) {
              	    canPrint2 = true;
              	}
              	if (!canPrint2) {%>
              	    
              	     rdShowMessageDialog("打印失败! ,错误原因："+"<%=return_msg3%>");
	                 window.location="s1321_3.jsp";
					 return false;
                <%
                	
                }

				//xl add 多次调用basd确认or取消接口 实现每次的开具
				//xl add 电子化入库 begin
				%>
				
						<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
							<wtc:param value="<%=i_login_accept%>"/>
							<wtc:param value="1321"/>
							<wtc:param value="<%=workno%>"/>
							<wtc:param value=" "/>
							<wtc:param value="<%=i_phone_no%>"/>
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
				


                out.println("printctrl.Setup(0)");
                out.println("printctrl.StartPrint()");
                out.println("printctrl.PageStart()");
                 
				%>
					var localPath = "C:/billLogo.jpg";
					printctrl.DrawImage(localPath,8,10,40,18);//左上右下
 
				<%

				out.println("printctrl.Print(20, 10, 9, 0,'"+year+month+day+"')");
				out.println("printctrl.Print(85, 10, 9, 0,'邮电通信业')");
				
				out.println("printctrl.Print(110, 10, 9, 0,'"+"本次发票号码"+ocpy_begin_no+"')");
		 

				out.println("printctrl.Print(13, 12, 9, 0,'"+"防伪码："+ran+"')");
	 

				out.println("printctrl.Print(13, 13, 9, 0,'"+"工    号："+workno+"')");
				out.println("printctrl.Print(72, 13, 9, 0,'"+"操作流水："+i_login_accept+"')");
				out.println("printctrl.Print(115, 13, 9, 0,'业务名称：等额发票兑换月消费发票')");	
				out.println("printctrl.Print(13, 14, 9, 0,'客户名称："+i_cust_name+"')");	
				out.println("printctrl.Print(115, 14, 9, 0,'卡    号：')");
				
				out.println("printctrl.Print(13, 15, 9, 0,'手机号码："+i_phone_no+"')");
				out.println("printctrl.Print(72, 15, 9, 0,'协议号码："+i_contract_no+"')");
				out.println("printctrl.Print(115, 15, 9, 0,'支票号码："+i_bill_no+"')");
				
				out.println("printctrl.Print(13, 16, 9, 0,'合计金额：(大写)"+mon.NumToRMBStr(Double.parseDouble(out_result6[i][0]))+"')");
				out.println("printctrl.Print(115, 16, 9, 0,'(小写)￥"+out_result6[i][0].trim()+"')");
				  // add
				  out.println("printctrl.Print(13, 17, 9, 0,'(项目)')");
				  out.println("printctrl.Print(13, 18, 9, 0,'"+result3[0][0]+"')");
				  out.println("printctrl.Print(13, 19, 9, 0,'应收：')");
				  // end
				int rownumber = 13; //当成列
				int colnumber = 20; //当成行
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
				out.println("printctrl.Print(13, 30, 9, 0,'开票："+workname+"')");
				out.println("printctrl.Print(47, 30, 9, 0,'收款：')");
				out.println("printctrl.Print(70, 30, 9, 0,'复核：')");
				// new end
   
               
              
               
               out.println("printctrl.PageEnd()");
               out.println("printctrl.StopPrint()");
               	}
               	%>
               	} catch(e) {
                 } finally {
                 }
             
               try {
              <% 
                
			  
				//余额发票
				//增加系统流水
			String sql_accept = "SELECT to_char(ltrim(rtrim(sMaxSysAccept.nextval))) FROM Dual";
			%>
			<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
					<wtc:sql><%=sql_accept%></wtc:sql>
					</wtc:pubselect>
			<wtc:array id="count1_new1" scope="end" />	
			<%
				
				if(count1_new1.length>0)
				{
					/*if(s_flag=="first" ||s_flag.equals("first"))
					{
						i_login_accept=last_bill_accept;
					}
					else
					{
						i_login_accept = count1_new[0][0].trim();
					}
					*/
					i_login_accept = count1_new1[0][0].trim();
					
				}

                String d3 = (new DecimalFormat("0.00")).format(d1 + d2 - yingsou);
				//打印剩余机打发票的
				%>
                
				<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=i_phone_no%>"  outnum="8" >
					<wtc:param value="<%=i_login_accept%>"/>
					<wtc:param value="<%=opCode%>"/>
					<wtc:param value="<%=workno%>"/>
					<wtc:param value=""/><!--op_time-->
					<wtc:param value="<%=i_phone_no%>"/>
					<wtc:param value="0"/><!--id_no-->
					<wtc:param value="<%=i_contract_no%>"/>
					<wtc:param value=""/><!--s_check_num-->
					<wtc:param value=""/><!--发票号码 第一次调用时 传空 我在服务里tpcallBASD的接口取得-->
					<wtc:param value=""/><!--发票代码 空-->
					<wtc:param value=""/><!--sm_code-->
					<wtc:param value="<%=d3%>"/><!--小写金额-->
					<wtc:param value=""/><!--大写金额-->
					<wtc:param value=""/><!--备注-->
					<wtc:param value="6"/><!--预占是6 取消是5即未打印-->
					<wtc:param value=""/>
					<wtc:param value=""/>
					<wtc:param value=""/>
					<wtc:param value=""/><!--账期-->
					<wtc:param value="<%=i_cust_name%>"/><!--后面的：-->
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
                
				%>
					var localPath = "C:/billLogo.jpg";
					printctrl.DrawImage(localPath,8,10,40,18);//左上右下
 
				<%
	 
				out.println("printctrl.Print(20, 10, 9, 0,'"+year+month+day+"')");
				out.println("printctrl.Print(85, 10, 9, 0,'邮电通信业')");
				  
				out.println("printctrl.Print(110, 10, 9, 0,'"+"本次发票号码"+ocpy_begin_no+"')");
				   
				  out.println("printctrl.Print(13, 12, 9, 0,'"+"防伪码："+ran+"')");
				  out.println("printctrl.Print(13, 13, 9, 0,'"+"工    号："+workno+"')");
				  out.println("printctrl.Print(72, 13, 9, 0,'"+"操作流水："+i_login_accept+"')");
				  out.println("printctrl.Print(115, 13, 9, 0,'业务名称：等额发票兑换月消费发票')");	
				 
				  out.println("printctrl.Print(13, 14, 9, 0,'客户名称："+i_cust_name+"')");	
				  out.println("printctrl.Print(115, 14, 9, 0,'卡    号：')");	
			 
				  out.println("printctrl.Print(13, 15, 9, 0,'手机号码："+i_phone_no+"')");
				  out.println("printctrl.Print(72, 15, 9, 0,'协议号码："+i_contract_no+"')");
				  out.println("printctrl.Print(115, 15, 9, 0,'支票号码："+i_bill_no+"')");
				  
				  out.println("printctrl.Print(13, 16, 9, 0,'合计金额：(大写)"+mon.NumToRMBStr(d1+d2-yingsou)+"')");
				  out.println("printctrl.Print(115, 16, 9, 0,'(小写)￥"+d3+"')");
				  out.println("printctrl.Print(13, 17, 9, 0,'(项目)')");
				  out.println("printctrl.Print(13,18,9,0,'"+"交话费："+"')");
					if (d1 == 0) 
					{
						out.println("printctrl.Print(13,19,9,0,'"+"现金：" + " 0.00" +"')");
						out.println("printctrl.Print(13,20,9,0,'"+"支票：" + d3 +"')");  
					}
					else
					{
						out.println("printctrl.Print(13,19,9,0,'"+"现金：" + d3 +"')");
						out.println("printctrl.Print(13,20,9,0,'"+"支票：" + " 0.00" +"')");
					}
				  out.println("printctrl.Print(13, 21, 9, 0,'换发票时的余额发票')");
				 
				  out.println("printctrl.Print(13, 30, 10, 0,'开票："+workname+"')");
				  out.println("printctrl.Print(42, 30, 10, 0,'收款：')");
				  out.println("printctrl.Print(80, 30, 10, 0,'复核：')");
			// end

    
                
                out.println("printctrl.PageEnd()");
                out.println("printctrl.StopPrint()");

//xl add 多次调用basd确认or取消接口 实现每次的开具
				//xl add 电子化入库 begin
				%>
				
					<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
						<wtc:param value="<%=i_login_accept%>"/>
						<wtc:param value="1321"/>
						<wtc:param value="<%=workno%>"/>
						<wtc:param value=" "/>
						<wtc:param value="<%=i_phone_no%>"/>
						<wtc:param value="0"/> 
						<wtc:param value="<%=i_contract_no%>"/> 
						<wtc:param value=""/>
						<wtc:param value="<%=ocpy_begin_no%>"/>
						<wtc:param value="<%=bill_code%>"/>
						<wtc:param value="0"/>
						<wtc:param value="<%=d3%>"/>
						<wtc:param value="<%=mon.NumToRMBStr(d1+d2-yingsou)%>"/>
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
			

           	rdShowMessageDialog("打印成功!",2);
             document.location.replace("s1321_3.jsp");
           } catch(e) {
           } finally {
	              }
		
			 
 
			
<%
		
  		}
  
    %>
    
}  
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
 