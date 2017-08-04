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
	
		String groupId = (String)session.getAttribute("groupId");
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
		
		String op_code = "1352";
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
	String payAccept = request.getParameter("payAccept");
	String loginAccept = request.getParameter("loginAccept");
	String check_seq = request.getParameter("check_seq");
	String s_flag = request.getParameter("s_flag");
	String pay_money = request.getParameter("pay_money");
	
	String s_sm_code="";
	String s_id_no="";
	String s_sm_name="";
	String[] inParam_dcustmsg = new String[2];
	inParam_dcustmsg[0]="select to_char(id_no),a.sm_code,b.sm_name from dcustmsg a,ssmcode b where phone_no=:s_no and substr(a.belong_code,0,2) = b.region_code and a.sm_code = b.sm_code";
	inParam_dcustmsg[1]="s_no="+pageActivePhone;

	//xl add 根据组织节点查询营业厅名称
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;
	String s_yyt_name="";
%>
	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
<%
	if(yyt_name_arr!=null&&yyt_name_arr.length>0)
	{
		s_yyt_name = yyt_name_arr[0][0];
	}
%>
	<wtc:service name="TlsPubSelBoss"  outnum="3" >
		<wtc:param value="<%=inParam_dcustmsg[0]%>"/>
		<wtc:param value="<%=inParam_dcustmsg[1]%>"/>
	</wtc:service>
	<wtc:array id="retList_dcustmsg" scope="end" />
<%
	if(retList_dcustmsg.length>0)
	{
		s_id_no=retList_dcustmsg[0][0];
		s_sm_code=retList_dcustmsg[0][1];
		s_sm_name=retList_dcustmsg[0][2];
	}
	if(loginAccept==null){
	 %>
      <wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept1"/>
	 <%
	  loginAccept=loginAccept1;
	}
	
	String total_date = request.getParameter("total_date");
	String checkno = request.getParameter("checkNo");

	String returnPage = "s1300.jsp";
  if (request.getParameter("returnPage") != null) {
	   returnPage = request.getParameter("returnPage");
	}
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");

	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
    
	String[] inParas = new String[6];
	inParas[0] = workNo;
	inParas[1] = contractno;
	inParas[2] = total_date;
	inParas[3] = payAccept.trim();
	inParas[4] = loginAccept;
	inParas[5] = nopass;/*xl 工号临时授权 20110328*/
%>

<%
	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no=request.getParameter("ocpy_begin_no");
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code= request.getParameter("bill_code");;
	String bill_accept="";
	String s_invoice_flag="";
	String cust_name = request.getParameter("textfield7");
%>
 

	<wtc:service name="szg58PrintRe" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode1" retmsg="retMsg1" outnum="35">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%   
	String return_code = "999999";
	if(result!=null&&result.length>0){
		return_code = result[0][0];
	}
 	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
%>

<%
	 String s_pay_note="";
	 s_pay_note ="本次发票金额:(小写)￥"+result[0][9].trim()+",大写金额合计:"+result[0][8]+"滞纳金:"+"<p>"+result[0][11]+"<p>"+result[0][12]+"<p>"+result[0][13];
	 System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
	 System.out.println("loginAccept=="+loginAccept);
	 
	 String cnttOpCode = "".equals(pageOpCode)?"1352":pageOpCode;
	 String cttOpName = "".equals(pageOpName)?"补打收据":pageOpName;
	 String cnttWorkNo = workNo;
	 String retCodeForCntt = return_code;
	 String cnttLoginAccept = loginAccept.length()>0?loginAccept:"";
	 String cnttActivePhone = pageActivePhone;
	 String url = "";
	 /**pageActivePhone的优先级别高于账号**/
	 if(cnttActivePhone.length()>0){
			url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+cnttOpCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+cttOpName+"&workNo="+cnttWorkNo+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+pageActivePhone+"&opBeginTime="+opBeginTime+"&retMsgForCntt="+retMsg1+"&contactId="+pageActivePhone+"&contactType=user";	 
	 }else{
	 		String cnttContactId = contractno;
	 		String cnttUserType = "acc";
	 		url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+cnttOpCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+cttOpName+"&workNo="+cnttWorkNo+"&loginAccept="+cnttLoginAccept+"&contactId="+cnttContactId+"&contactType="+cnttUserType+"&opBeginTime="+opBeginTime+"&retMsgForCntt="+retMsg1;	
	 }
	 System.out.println("--------------统一接触url----:"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	 System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
%>


<% 	
	  String temp[]=new String[10];
		String info=new String();
		int record=0;
	if ( return_code.equals("000000") ){

	  String phoneNo =result[0][5].trim();
		if(phoneNo.equals("99999999999"))
	         phoneNo="";
	         
	    System.out.println("-----------1352-------result[0][16]="+result[0][16]);
  int length1=result[0][16].length();
			 if(length1>0)
			 {
			 int size=60;
			 System.out.println("-------------------------"+result[0][16].length());
			 info=result[0][16].trim();
			 System.out.println("-------------------------"+result[0][16]);
			 record=length1/size;
			 System.out.println("-------------------------"+record);
			 for(int j=0;j<=record;j++)
			 {
			 if(info.length()>=size)
			 {
			 temp[j]=info.substring(0,size);
		   info=info.substring(size);
		   }
		   else
		   temp[j]=info;
		   System.out.println("-------------------------"+j+"  "+temp[j]);
		   
		   
		  
		   }
		   }

%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">

<SCRIPT language="JavaScript">

function printInvoice()
{ 
	//alert("打印了？");
	printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();
	
	/*20100528 liuxmc 添加发票防伪码*/
	//xl begin
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
					 
					var localPath = "C:/billLogo.jpg";
					printctrl.DrawImage(localPath,8,10,40,18);//左上右下
 
				<%
			}*/
		%>
	printctrl.Print(20, 10, 9, 0, "开票日期:<%=year%>年<%=month%>月<%=day%>日");
	printctrl.Print(115, 10, 9, 0, "本次发票号码:<%=ocpy_begin_no%>"); 
	
	printctrl.Print(13, 13, 9, 0, "客户名称:<%=result[0][4]%>");
	printctrl.Print(72, 13, 9, 0, "客户品牌:<%=s_sm_name%>");
	printctrl.Print(115, 13, 9, 0, "业务类别:集团公司预存话费送和包电子券活动");
	

	printctrl.Print(13, 15, 9, 0, "用户号码：<%=pageActivePhone%>");	
	printctrl.Print(48, 15, 9, 0, "协议号码：<%=result[0][6]%>");
	printctrl.Print(82, 15, 9, 0, "话费账期:<%=year+month%>");
	printctrl.Print(115, 15, 9, 0, "合同号:");

	printctrl.Print(115, 16, 9, 0, "支票号:<%=result[0][7]%>");
	printctrl.Print(115, 17, 9, 0, "集团统付号码:");//只有opcode=d340的
	printctrl.Print(16, 18, 9, 0, "通信服务费合计:");
	printctrl.Print(16, 18, 9, 0, "本次发票金额:(小写)￥<%=result[0][9].trim()%> 大写金额合计:<%=result[0][8]%>");
	printctrl.Print(16, 20, 9, 0, "<%=result[0][11]%>");//备注 
	printctrl.Print(16, 21, 9, 0, "<%=result[0][12]%>");//备注 
	printctrl.Print(16, 22, 9, 0, "<%=result[0][13]%>");//备注 
	printctrl.Print(16, 22, 9, 0, "<%=result[0][14]%>");//备注 
 
 	
/********tianyang add at 20090928 for POS缴费需求****start*****/
/* result[0][17] 为 "1"  是pos缴费(冲正) */
	//alert("test "+"<%=result[0][17]%>");
<%if (result[0][17] != null && result[0][17].equals("1")) {%>
 	printctrl.Print(13, 22, 9, 0, "<%=result[0][18].trim()%>");/*商户名称（中英文)*/
	printctrl.Print(13, 23, 9, 0, "<%=result[0][29].trim()%>");/*交易卡号（屏蔽）*/
	printctrl.Print(72, 23, 9, 0, "<%=result[0][19].trim()%>");/*商户编码*/
	printctrl.Print(115, 23, 9, 0, "<%=result[0][24].trim()%>");/*批次号*/
	printctrl.Print(13, 24, 9, 0, "<%=result[0][21].trim()%>");/*发卡行号*/
	printctrl.Print(72, 24, 9, 0, "<%=result[0][20].trim()%>");/*终端编码*/
	printctrl.Print(115, 24, 9, 0, "<%=result[0][27].trim()%>");/*授权号*/
	printctrl.Print(13, 25, 9, 0, "<%=result[0][25].trim()%>");/*回应日期时间*/
	printctrl.Print(72, 25, 9, 0, "<%=result[0][26].trim()%>");/*参考号*/
	printctrl.Print(115, 25, 9, 0, "<%=result[0][28].trim()%>");/*流水号*/
	printctrl.Print(13, 26, 9, 0, "<%=result[0][22].trim()%>");/*收单行号*/
	printctrl.Print(115, 26, 9, 0, "签字：");
<%}%>
 
/*xl add 2是BQ的
商户编号 、终端编号 、发卡行号 、收单行号 ,如果acquire_bank_no==0105则打印建设银行 否则打印acquire_bank_no、卡号 、交易类别：消费、批次号 、凭证号TraceNo、参考号RRN、有效期 、持卡人签名(本人确认以上交易，同意将其记入本卡账户)
*/
<%if (result[0][17] != null && result[0][17].equals("2")) {%>
 	printctrl.Print(13, 22, 9, 0, "<%=result[0][33].trim()%>");/*交易类别1*/
	printctrl.Print(13, 23, 9, 0, "<%=result[0][29].trim()%>");/*交易卡号（屏蔽）*/
	printctrl.Print(72, 23, 9, 0, "<%=result[0][19].trim()%>");/*商户编码*/
	printctrl.Print(120, 23, 9, 0, "<%=result[0][24].trim()%>");/*批次号*/
	printctrl.Print(13, 24, 9, 0, "<%=result[0][21].trim()%>");/*发卡行号*/
	printctrl.Print(72, 24, 9, 0, "<%=result[0][20].trim()%>");/*终端编码*/
	printctrl.Print(120, 24, 9, 0, "<%=result[0][30].trim()%>");/*有效期*/
	printctrl.Print(72, 25, 9, 0, "<%=result[0][26].trim()%>");/*参考号*/
	printctrl.Print(120, 25, 9, 0, "<%=result[0][28].trim()%>");/*流水号*/
	printctrl.Print(13, 25, 9, 0, "<%=result[0][22].trim()%>");/*收单行号*/
	printctrl.Print(13, 26, 9, 0, "<%=result[0][34].trim()%>");/*note*/
	printctrl.Print(115, 26, 9, 0, "签字：");
<%}%>

/********tianyang add at 20090928 for POS缴费需求****end*******/
	
	 
	//xl add 开票：                    收款：                     复核：
	printctrl.Print(13, 30, 9, 0, "流水号：<%=result[0][15]%>");
	printctrl.Print(54, 30, 9, 0, "开票人：<%=workname%>");
	printctrl.Print(85, 30, 9, 0, "工号：<%=workNo%>");
	printctrl.Print(110, 30, 9, 0, "营业厅：<%=s_yyt_name%>");
	printctrl.PageEnd() ;
	printctrl.StopPrint() ; 

	
}

function ifprint()
{
  			printInvoice();
					<%
						//xl add 电子化入库
 
		String[] inParas0 = new String[29];
		//inParas0[0] = realKey+"";
		inParas0[0] = payAccept;//流水
		inParas0[1] = op_code;//
		inParas0[2] = workNo;
		inParas0[3] = total_date;//没有用
		inParas0[4] = pageActivePhone;
		inParas0[5] = s_id_no;//s_id_no 只是入表用 实在不行在程序里自己取一下
		inParas0[6] = contractno;//contract_no
		 
		inParas0[7] = checkno;//支票号码
		//xl add 发票预占状态变更入参 begin
		//发票号码 发票金额 地市 group_id 备注 发票代码 
		inParas0[8] = ocpy_begin_no;//发票号码;
		inParas0[9] = bill_code;//发票代码;
		inParas0[10] =s_sm_code;//品牌
		inParas0[11] = result[0][9].trim();//小写金额
		inParas0[12] = result[0][8].trim();//大写金额
		inParas0[13] = s_pay_note ;
		
		//本次缴费金额 这个得看样张都有啥
		//xl add 发票预占状态变更入参 end



		inParas0[14] = "";//增值税的
		inParas0[15] = "0";//增值税的
		inParas0[16] = "0";//增值税的
		inParas0[17] = "0";//打印年月
		inParas0[18] = result[0][4].trim();//cust_name
		inParas0[19] = "";
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = regionCode;
		inParas0[25] = groupId; 
		inParas0[26] = "1";
		inParas0[27] ="0";//通用机打
		String[][] result2 = new String[][]{};
		System.out.println("====执行 s1300PrintInDB 开始=======");
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
		if(RetResult == null && RetResult.length == 0){
%>
					 
					    rdShowMessageDialog("电子发票入库失败,sPrintMsgInDB服务返回结果为空.",0);
					    document.location.replace("<%=returnPage%>");
					 
<%			
		}	
		else
		{
				result2 = RetResult;
				if((result2[0][0]!="000000")&&!result2[0][0].equals("000000"))
				{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,错误代码"+"<%=result2[0][0]%>"+",错误原因:"+"<%=result2[0][1]%>".",0);
					    document.location.replace("<%=returnPage%>");
					</script>
        <%			
				}else
				{
			%>
				rdShowMessageDialog("打印成功!");
			
 				document.location.replace("<%=returnPage%>");
			<%
				}
			
		}
  		
	%>
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
	//String sqlStr3 = "select id_no from dcustmsg where phone_no = '"+phoneNo+"'";
	//String[][] dcustArray1 = new String[][]{};
%>

<%
		
			
		//////////////////////////////////////////////

	}else{
%>
	 <script language="JavaScript">
			rdShowMessageDialog("发票打印错误,请使用补打发票交易打印发票!<br>错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'。",0);
			document.location.replace("<%=returnPage%>");
	 </script>
<%
	}
%>
