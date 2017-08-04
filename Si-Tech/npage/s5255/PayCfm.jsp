<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-21
********************/
%>
<%
  String opCode = "5255";
  String opName = "空中充值帐户缴费";
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
 	String regionCode = (String)session.getAttribute("regCode");
	String busy_type = request.getParameter("busy_type");
	String phoneNo = request.getParameter("phoneNo");
	String contractno = request.getParameter("contractno");
	String payMoney = request.getParameter("payMoney");
	String delayRate = request.getParameter("delayRate");
	String remonthRate = request.getParameter("remonthRate");
	String payType = request.getParameter("moneyType");
	String pay_note = request.getParameter("pay_note");/*wangmei add*/
	System.out.println("#######pay_note="+pay_note);

	String  op_code = request.getParameter("op_code");
	String  batch = request.getParameter("batch");
	String  batchdate = request.getParameter("batchdate");
	String  payNote = request.getParameter("payNote");
	String  bankCode= request.getParameter("BankCode");
	String  checkNo= request.getParameter("checkNo");
	String  userName = request.getParameter("countName");
	String  sum_owefee = request.getParameter("sumowefee");
	String  currentFee = request.getParameter("currentFee");
	String  belongcode = request.getParameter("belongcode");
	String[] phone = new String[]{};
	String paySign=request.getParameter("paySign");

	String  returnPage = "s1300.jsp?ph_no="+phoneNo;

	ArrayList arr = (ArrayList)session.getAttribute("allArr");

  String[][] baseInfo = (String[][])arr.get(0);
  String[][] pass = (String[][])arr.get(4);
  String workno = baseInfo[0][2];
  String workname = baseInfo[0][3];
	String belongName = baseInfo[0][16];
	String orgCode = baseInfo[0][16];
	String nopass = pass[0][0];
	System.out.println("-----------------phoneNo------------------"+phoneNo);
  String return_page="";
	if(busy_type.equals("1")) 	
		return_page = "s1300.jsp?ph_no="+phoneNo;
	if(busy_type.equals("2"))   
		return_page="s1300_2.jsp";	
	System.out.println("-----------------return_page------------------"+return_page);	
	String wm_note="1";
	if(op_code.equals("5255")){
		if(pay_note.equals("0")){    
			wm_note="0";
	  }
	}
	
	if(payNote.equals("")){
		payNote = "空中充值 帐户号码="+contractno+"冲值金额为"+payMoney;
	}

   String [] inParas = new String[15];
   inParas[0]  = workno;
   inParas[1]  = nopass;
   inParas[2]  = orgCode;
   inParas[3]  = op_code;
   inParas[4]  = contractno;
   inParas[5]  =  phoneNo;
   inParas[6]  = payMoney;
   inParas[7]  = payType;
   inParas[8] = delayRate;
   inParas[9] = remonthRate;
   inParas[10] = bankCode;
   inParas[11] = checkNo; 
   inParas[12] =payNote; 
   inParas[13] = paySign;
   inParas[14] = wm_note;

   System.out.println("wwwwwwwww"+contractno);
    
  	 String routerKey_str="";  
  	 String routerValue_str="";
  	     
     if(busy_type.equals("1")) 
     {
     routerKey_str="phoneNo";
     routerValue_str=phoneNo;
     }
     if(busy_type.equals("2")) 
     {
     routerKey_str="regionCode";
     routerValue_str=regionCode;
     }
 	       


%>
    <!-- chenhu add -->
		<wtc:service name="bs_ChnPayLimit" outnum="5" retmsg="msg1" retcode="code1" routerKey="<%=routerKey_str%>" routerValue="<%=routerValue_str%>">
		<wtc:param value="<%=workno%>"/>
 		<wtc:param value="<%=payMoney%>"/>
    </wtc:service>
    <wtc:array id="result4"   scope="end" />
    <wtc:array id="result5"  scope="end" /> 	
    <wtc:array id="result6"  scope="end" />
    <wtc:array id="result7"  scope="end" />
    <wtc:array id="result8"  scope="end" />
<%      
				String t_return_code = result4[0][0].trim();
				String t_return_msg = result5[0][0].trim();
				String flag_status  = result6[0][0].trim(); 
				String pledge_fee  = result7[0][0].trim(); 
				String total_money = result8[0][0].trim(); 
				System.out.println("chenhu test ############################ test t_return_code is "+t_return_code);
				System.out.println("chenhu test ############################ test t_return_msg is "+t_return_msg);
				System.out.println("chenhu test ############################ test flag_status is "+flag_status);
				if(!t_return_code.equals("000000")){
%>
 <script language='jscript'>			
						rdShowMessageDialog("查代理商类型错误！<br>错误代码：'<%=t_return_code%>'。<br>错误信息：'<%=t_return_msg%>'。",0);
						history.go(-1);
	</script>	    
<%		
				}
%>
<%
//System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB test flag is "+flag);
if(t_return_code.equals("000000")){		       
%>

    <wtc:service name="s1300Cfm" outnum="3" retmsg="msg1" retcode="code1" routerKey="<%=routerKey_str%>" routerValue="<%=routerValue_str%>">
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
		  <wtc:param value="<%=inParas[2]%>"/>
			<wtc:param value="<%=inParas[3]%>"/>
			<wtc:param value="<%=inParas[4]%>"/>
			<wtc:param value="<%=inParas[5]%>"/>
			<wtc:param value="<%=inParas[6]%>"/>
			<wtc:param value="<%=inParas[7]%>"/>
		  <wtc:param value="<%=inParas[8]%>"/>
			<wtc:param value="<%=inParas[9]%>"/>
		  <wtc:param value="<%=inParas[10]%>"/>
			<wtc:param value="<%=inParas[11]%>"/>
			<wtc:param value="<%=inParas[12]%>"/>
			<wtc:param value="<%=inParas[13]%>"/>
			<wtc:param value="<%=inParas[14]%>"/>
		</wtc:service>
		<wtc:array id="result1_t" scope="end" />

<%	 

	String result[][] = result1_t;

	String return_code = result[0][0];

 	if(return_code.equals("139444")){%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("查询错误!<br>错误代码：'<%=return_code%>'，错误信息：'标准神州行用户不允许前台交费'。",0);
			window.location = "<%=returnPage%>"

		//-->
		</SCRIPT>
<%}
	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
	String paySeq="";
	String totalDate="";
	String year="";
	String month="";
	String day="";
 	if (return_code.equals("000000"))
	{
		 paySeq      = result[0][1];
		 totalDate   = result[0][2];
		 
		 year = totalDate.substring(0,4);
		 month = totalDate.substring(4,6);
		 day = totalDate.substring(6,8);


%>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<SCRIPT type=text/javascript>

function ifprint()
{
         var prtFlag=0;
 
     			prtFlag = rdShowConfirmDialog("号码缴费成功！是否打印收据？");
     			if (prtFlag==1)
					{
					document.frm_print.action="PrintInvoice.jsp";
					document.frm_print.submit();}
        	else
        	{ 
						rdShowMessageDialog("交易完成！",2);
        		window.location = "<%=returnPage%>"
				 	}
} 
</SCRIPT>

<body onload="ifprint()">
<form action="" name="frm_print" method="post">
<INPUT TYPE="hidden" name="opCode" value="<%=op_code%>">
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="total_date" value="<%=totalDate%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=paySeq%>">
<INPUT TYPE="hidden" name="checkNo" value="<%=checkNo%>">
<INPUT TYPE="hidden" name="phoneNo" value="<%=phoneNo%>">
</form>
</body></html>
<%
}else{%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("查询错误!<br>错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'。",0);
			window.location = "<%=returnPage%>"

		//-->
		</SCRIPT>
		
<%}
}else{%>
	<SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("查询错误!<br>错误代码：'<%=t_return_code%>'，错误信息：'<%=t_return_msg%>'。");
			window.location.href="<%=return_page%>";
		//-->
		</SCRIPT>
<%}%>

		<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
	<%
	String loginNo = (String)session.getAttribute("workNo");
	%>
<%String url ="/npage/contact/upCnttInfo_boss.jsp?opCode="+op_code+
							"&retCodeForCntt="+code1+
							"&opName="+opName+
							"&workNo="+loginNo+
							"&loginAccept="+sysAcceptl+
							"&pageActivePhone="+phoneNo+
							"&retMsgForCntt="+msg1+
							"&opBeginTime="+opBeginTime; %>
							
<jsp:include page="<%=url%>" flush="true" />