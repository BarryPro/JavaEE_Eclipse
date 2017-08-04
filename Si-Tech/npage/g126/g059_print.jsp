<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*1352 补打发票专用页面
*1300,1302等(补打发票也用到)
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	String cust_name=request.getParameter("cust_name");
	String phoneNo   = request.getParameter("ttPhone_no");
	String id_no = request.getParameter("id_no");
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
		
		 
		String bill_type = "2";
		String sm_name = "";
	/////////////////////////////////
	
	/***add by zhanghonga@2008-09-25,配合增加统一接触,增加了此三个参数.从"1352 补打收据".s1352_select.jsp传递来***/
	String pageOpCode = WtcUtil.repNull(request.getParameter("pageOpCode"));
	String pageOpName = WtcUtil.repNull(request.getParameter("pageOpName"));
	String pageActivePhone = WtcUtil.repNull(request.getParameter("phoneno"));
	/************************************************************************************************************/
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String contractno = request.getParameter("contractno");
	String workNo = request.getParameter("workno");
	String nopass = (String)session.getAttribute("password");
	 
	String loginAccept = request.getParameter("loginAccept");
	String cfmname = request.getParameter("cfmname");
	if(loginAccept==null){
	 %>
      <wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept1"/>
	 <%
	  loginAccept=loginAccept1;
	}
	
  

	String returnPage = "g126_1.jsp";
	if (request.getParameter("returnPage") != null) {
	   returnPage = request.getParameter("returnPage");
	}
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");

	
    
   
	//xl add for hxf
	 
	String payAccept = request.getParameter("payAccept");
	String total_date = request.getParameter("total_date");
	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
	String print_time = total_date.substring(0,6);
	String opname = request.getParameter("opname");
	System.out.println("");
	String[][] result = new String[][]{};
	String function_name="";
	String op_code = request.getParameter("op_code");
	String[] inParas1 = new String[2];
	inParas1[0] = "select to_char(print_content) from Dservorderprtcntt"+print_time+" where serv_order_id in (select serv_order_id from Dservorderprt"+print_time+" where serv_order_id = :login_accept  ) and bill_type = '2' order by col_num asc";
	inParas1[1] = "login_accept="+payAccept ;
	
	//取 发票号码 发票代码 入库
	String[][] tt_result = new String[][]{};
	String t_invoice_code="";
	String t_invoice_num="";
	String[] inParas_new = new String[2];
	inParas_new[0]="select s_Invoice_number,Invoice_code  from tt_wLoginInvoice where login_no=:in_login_no";
	inParas_new[1]="in_login_no="+workno;
%>
<!--new upadte begin-->
<%
	String[] inParas1_new = new String[2];
	inParas1_new[0]="Dservorderprt"+print_time;
	inParas1_new[1]=payAccept;
	String[][] tt_result_new = new String[][]{};
%>
	<wtc:service name="stt_update"   retcode="retCode13" retmsg="retMsg13" outnum="1">
			<wtc:param value="<%=inParas1_new[0]%>"/>
			<wtc:param value="<%=inParas1_new[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_value_update" scope="end" />
<%
	tt_result_new=ret_value_update;
	if(tt_result_new==null || tt_result_new.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("更新失败");
				return false;
			</script>
		<% 
	}
	else
	{
	
%>
<!--end of update-->
	<wtc:service name="TlsPubSelCrm"   retcode="retCode122" retmsg="retMsg122" outnum="2">
			<wtc:param value="<%=inParas1[0]%>"/>
			<wtc:param value="<%=inParas1[1]%>"/>	
	</wtc:service>
	<wtc:array id="ttcode_value" scope="end" />
	<%
		tt_result=ttcode_value;
		if(tt_result!=null && tt_result.length>0)
		{
			t_invoice_num=tt_result[0][0];
			t_invoice_code=tt_result[0][1];
		}
	%>
    <wtc:service name="TlsPubSelCrm"   retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:param value="<%=inParas1[0]%>"/>
			<wtc:param value="<%=inParas1[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_value" scope="end" />
	<%
	result=ret_value; 
	if(ret_value!=null && ret_value.length>0)
		{
		int ret_length= ret_value.length;
		%>
			<script language="javascript">
				//alert("loginAccept is "+"<%=loginAccept%>"+" and payAccept is "+"<%=payAccept%>");
			</script>
		<%
				
		%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">

<SCRIPT language="JavaScript">

function printInvoice()
{ 
	
	printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();
	  
		printctrl.Print(20, 9, 9, 0, "<%=year%>年<%=month%>月<%=day%>日");
		printctrl.Print(50, 9, 9, 0, "邮电通信业");
        printctrl.Print(13, 12, 9, 0, "防伪码：<%=ran%>");
		printctrl.Print(13, 13, 9, 0, "工    号：<%=workno%>");
        printctrl.Print(42, 13, 9, 0, "操作流水：<%=payAccept%>");
		//xl 根据opcode判断 begin
		printctrl.Print(65, 13, 9, 0, "业务名称：<%=opname%>");
		<% 
		if(op_code.equals("e006")||op_code.equals("e007")||op_code.equals("e033"))
		{
			%>
				printctrl.Print(13, 14, 9, 0, "客户名称：<%=cust_name%>");
				printctrl.Print(65, 14, 9, 0, "卡    号：");  
				printctrl.Print(13, 15, 9, 0, "宽带账号：<%=result[2][0]%>");

				//printctrl.Print(33, 15, 9, 0, "<%=result[4][0]%>");
				printctrl.Print(42, 15, 9, 0, "协议号码：<%=result[3][0]%>");
				printctrl.Print(65, 15, 9, 0, "支票号码：<%=result[7][0]%>");

				printctrl.Print(13, 17, 9, 0, "合计金额：(大写)<%=result[5][0]%>");
				printctrl.Print(65, 17, 9, 0, "(小写)￥<%=result[6][0].trim()%>");
				
				printctrl.Print(13, 18, 9, 0, "(项目)");
				printctrl.Print(13, 20, 9, 0, "<%=result[8][0]%>");
				printctrl.Print(13, 21, 9, 0, "<%=result[11][0]%>");
				printctrl.Print(13, 22, 9, 0, "<%=result[12][0]%>");
				 

			<%
		}
		else
		{
			%>
				printctrl.Print(13, 14, 9, 0, "客户名称：<%=cust_name%>");
				printctrl.Print(65, 14, 9, 0, "卡    号：");  
				printctrl.Print(13, 15, 9, 0, "宽带账号：<%=result[12][0]%>");

				//printctrl.Print(33, 15, 9, 0, "<%=result[4][0]%>");
				printctrl.Print(42, 15, 9, 0, "协议号码：<%=result[3][0]%>");
				printctrl.Print(65, 15, 9, 0, "支票号码： ");

				printctrl.Print(13, 17, 9, 0, "合计金额：(大写)<%=result[14][0]%>");
				printctrl.Print(65, 17, 9, 0, "(小写)￥<%=result[15][0].trim()%>");
				
				printctrl.Print(13, 18, 9, 0, "(项目)");
				//printctrl.Print(13, 20, 9, 0, "<%=result[8][0]%>");
				<%
					for(int h =16;h<ret_value.length-2;h++)
					{
					%>
						printctrl.Print(13, "<%=(h*1+5)%>", 9, 0, "<%=result[h][0]%>");	
					<%
					}
				%>
				
			 
			<%
		}

		%>
		 

		//xl 根据opcode判断 end
		//xl add 开票：                    收款：                     复核：
		printctrl.Print(13,29,9,0, "开票：<%=workname%>");
		printctrl.Print(43,29,9,0, "收款：");
		printctrl.Print(69,29,9,0, "复核：");
		printctrl.PageEnd() ;
		printctrl.StopPrint() ; 
}

function ifprint()
{
  			printInvoice();
 			document.location.replace("<%=returnPage%>");
 } 
</SCRIPT>

<body onload="ifprint()">
<OBJECT
	classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
	codebase="/ocx/printatl.dll#version=1,0,0,1"
	id="printctrl"
	style="DISPLAY: none"
	VIEWASTEXT
>
</OBJECT>

</body>
</html>
<!--xl add begin-->
<%
	
	//liuxmc add  发票电子化添加入库服务

		String[] inParas0 = new String[ret_value.length];
		inParas0[0] = realKey+"";
		inParas0[1] = loginAccept.trim();
		inParas0[2] = op_code;
		inParas0[3] = workNo;
		inParas0[4] = total_date;
		inParas0[5] = phoneNo;
		inParas0[6] = id_no;
		if(sm_name == null || sm_name.trim().length() == 0){
			sm_name = "品牌：";
		}
		inParas0[7] = sm_name;//品牌为空	
    System.out.println("=============sm_name====================="+sm_name);
		for(int i=8;i<ret_value.length-2;i++)
		{
			inParas0[i] = result[i][0];
		}
		inParas0[ret_value.length-2]=t_invoice_num;
		inParas0[ret_value.length-1]=t_invoice_code;
	%>
		
	<%


		System.out.println("====执行 s1300PrintInDB 开始=======");
		String[][] result2 = new String[][]{};
%>		
		<wtc:service name="e005PrintInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
			<%
				for(int i=0;i<ret_value.length-2;i++)
			    {
					%><wtc:param value="<%=inParas0[i]%>"/>;
				<%}%>
				<wtc:param value="<%=inParas0[ret_value.length-2]%>"/>
				<wtc:param value="<%=inParas0[ret_value.length-1]%>"/>
		</wtc:service>
		<wtc:array id="RetResult" scope="end"/>
<%
		if(RetResult.length > 0)
		{
			result2 = RetResult;
			if((result2[0][0]!="000000")&&!result2[0][0].equals("000000"))
			{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,营业员没有录入发票号码或者录入的发票号码已经打印完毕.错误代码:"+"<%=result2[0][0]%>",0);
					    document.location.replace("<%=returnPage%>");
					</script>
        <%			
			}
			
		}
		else if(RetResult == null || RetResult.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,s1300PrintInDB服务返回结果为空.",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%			
		}
%>
<!--xl add end-->
<%
		
	}
	else
	{
		%><script language="javascript">
				rdShowMessageDialog("发票信息查询失败，请重新输入!");	
				window.location.href='g126_1.jsp?opCode=e901&opName=铁通发票补打&crmActiveOpCode=e901';
		  </script><%
	}
		  }
	%>
 
 
 
