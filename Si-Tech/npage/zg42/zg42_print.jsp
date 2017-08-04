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
		
		String op_code = "zg42";
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
	if(loginAccept==null){
	 %>
      <wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept1"/>
	 <%
	  loginAccept=loginAccept1;
	}
	
	String total_date = request.getParameter("total_date");
	String checkno = request.getParameter("checkNo");

	String returnPage = "zg42_1.jsp?activePhone="+pageActivePhone;
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
	
	for(int i=0;i<inParas.length;i++){
		System.out.println("----------------s1352_print.jsp->s1300PrintRe服务入参->inParas["+i+"]-->["+inParas[i]+"]");
	}
	//CallRemoteResultValue  value  = viewBean.callService("1", org_code.substring(0,2) ,  "s1300PrintRe", "17" , inParas);
%>
	<wtc:service name="s1300PrintRe" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode1" retmsg="retMsg1" outnum="35">
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
	printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();
	
	/*20100528 liuxmc 添加发票防伪码*/
	//xl begin
	//var localPath = "C:/billLogo.jpg";
	//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
	printctrl.Print(20,10,9, 0,"<%=year+month+day%>");
	printctrl.Print(85,10,9, 0, "邮电通信业");
	//xl add
	printctrl.Print(110,10,9, 0, "<%=check_seq%>");

    printctrl.Print(13,12,9,0,"防伪码：<%=ran%>");
    printctrl.Print(13,13,9,0, "工    号：<%=workno%>");
    printctrl.Print(72,13,9,0, "操作流水：<%=result[0][15]%>");
	printctrl.Print(115,13,9,0, "业务名称：补打"+"<%=result[0][2]%>");
	printctrl.Print(13,14,9,0, "客户名称：<%=result[0][4]%>");
	printctrl.Print(115,14,9,0, "卡    号：");   
	printctrl.Print(13,15,9,0, "手机号码：<%=phoneNo%>");
	printctrl.Print(72,15,9,0, "协议号码：<%=result[0][6]%>");
	printctrl.Print(115,15,9,0, "支票号码：<%=result[0][7]%>");
                          
	printctrl.Print(13,16,9,0, "合计金额：(大写)<%=result[0][8]%>");
	printctrl.Print(115,16,9,0, "(小写)￥<%=result[0][9].trim()%>");
	                        
	printctrl.Print(13,17,9,0, "(项目)");
	printctrl.Print(13, 18,  9, 0, "<%=result[0][11]%>");
	printctrl.Print(13, 19,  9, 0, "<%=result[0][12]%>");
	printctrl.Print(13, 20,  9, 0, "<%=result[0][13]%>");
	printctrl.Print(13, 21,  9, 0, "<%=result[0][14]%>");
	// end
 
 	
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
	
	<%
		 if(length1>0){
       for(int i=0;i<=record;i++)
        {
        %>//alert("11 "+"<%=temp[i]%>");
        printctrl.Print(13, "<%=(i*1.5+25)%>", 9, 0, "<%=temp[i]%>");
        <%
        if(i==record){
        %>
         //printctrl.Print(13,"<%=(i+29)%>", 9, 0, "<%=workname%>");
        <%
        }
        }
        }
      else{
        %>
        //printctrl.Print(13,29, 9, 0, "<%=workname%>");
        <%}	
		%>
	//xl add 开票：                    收款：                     复核：
	printctrl.Print(13,29,9,0, "开票：<%=workname%>");
	printctrl.Print(63,29,9,0, "收款：");
	printctrl.Print(89,29,9,0, "复核：");
	printctrl.PageEnd() ;
	printctrl.StopPrint() ; 
}

function ifprint()
{
  			if(rdShowConfirmDialog("当前发票号码是"+"<%=check_seq%>"+",是否打印发票?")==1)
			{
				printInvoice();
				document.location.replace("<%=returnPage%>");
			}
			else
			{
				//return false;
				document.location.replace("<%=returnPage%>");
			}
			//document.location.replace("<%=returnPage%>");
 } 
 
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>

</body>
</html>

<%
	//String sqlStr3 = "select id_no from dcustmsg where phone_no = '"+phoneNo+"'";
	//String[][] dcustArray1 = new String[][]{};
%>

<%
		//dcustArray1 = dcustArray;
	
	//liuxmc add  发票电子化添加入库服务

		String[] inParas0 = new String[26];
		inParas0[0] = realKey+"";
		inParas0[1] = result[0][15].trim();
		inParas0[2] = op_code;
    inParas0[3] = workNo;
    inParas0[4] = total_date;
    inParas0[5] = phoneNo;
    inParas0[6] = result[0][6].trim();
    if(sm_name == null || sm_name.trim().length() == 0){
    	sm_name = "品牌：";
    }
    inParas0[7] = sm_name;
    System.out.println("=============sm_name====================="+sm_name);
    inParas0[8] = result[0][8].trim();
    inParas0[9] = result[0][9].trim();
    inParas0[10] = result[0][10].trim();
    inParas0[11] = result[0][11].trim();
    inParas0[12] = result[0][12].trim();
    inParas0[13] = result[0][13].trim();
    inParas0[14] = result[0][14].trim();
    if(result[0][16].trim().length() == 0){
    	result[0][16] = "备注:";
    }
		inParas0[15] = "用户姓名:"+result[0][4].trim()+",业务名称:"+result[0][2].trim()+"."+result[0][16].trim();
		 
		inParas0[16] = result[0][18].trim();
		inParas0[17] = result[0][19].trim();
		inParas0[18] = result[0][20].trim();
		inParas0[19] = result[0][21].trim();
		inParas0[20] = result[0][22].trim();
		inParas0[21] = result[0][25].trim();
		inParas0[22] = result[0][26].trim();
		inParas0[23] = result[0][27].trim();
		inParas0[24] = result[0][28].trim();
		inParas0[25] = result[0][29].trim();

		System.out.println("====执行 s1300PrintInDB 开始=======");
%>		
		<wtc:service name="e005PrintInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
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
		</wtc:service>
		<wtc:array id="RetResult" scope="end"/>
<%
		if(RetResult == null && RetResult.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,sPrintMsgInDB服务返回结果为空.",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%			
		}
			
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
