
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-13
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
  String opCode = "3074";
  String opName = "换卡";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%
    String card_no  = request.getParameter("card_str");
    String card_other = request.getParameter("card_str1");
    String org_code = request.getParameter("org_code");
    String work_no  = (String)session.getAttribute("workNo");
    String op_code   = request.getParameter("op_code");
    String hand_fee   = request.getParameter("sum_hand_fee");
	String total_date = "";
	String newloginaccept = "";
	String regionCode = (String)session.getAttribute("regCode");
	String work_name = (String)session.getAttribute("workName");
	String sysAccept = request.getParameter("sysAccept");/*20090325 liyan add 操作流水*/
	String orgCode = (String)session.getAttribute("orgCode");
	String inputParsm [] = new String[7];
	String outMsg = "";
	int    outCode = 0;

	  inputParsm[0] = card_no;
	  inputParsm[1] = card_other;
	  inputParsm[2] = org_code;
	  inputParsm[3] = work_no;
	  inputParsm[4] = op_code;
	  inputParsm[5] = hand_fee;
	  inputParsm[6] = sysAccept; /*20090325 liyan add 操作流水*/

    //String [] initBack = impl.callService("s3074Cfm",inputParsm,outputNumber);
%>

    <wtc:service name="s3074Cfm" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inputParsm[0]%>" />
			<wtc:param value="<%=inputParsm[1]%>" />
			<wtc:param value="<%=inputParsm[2]%>" />
			<wtc:param value="<%=inputParsm[3]%>" />
			<wtc:param value="<%=inputParsm[4]%>" />
			<wtc:param value="<%=inputParsm[5]%>" />
			<wtc:param value="<%=inputParsm[6]%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%
    //int retCode = impl.getErrCode();
	String retCode = code;
	String retMsg = msg;
	System.out.println();
	 total_date = result_t[0][2];
	 newloginaccept = result_t[0][3];
	 String outParaNums= "4";
%>
	<wtc:service  name="sToChinaFee" routerKey="region" routerValue="<%=orgCode%>" outnum="<%=outParaNums%>"  retcode="retCode2" retmsg="retMessage2">
			<wtc:param  value="<%=hand_fee%>"/>
	  </wtc:service>
	  <wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
	String chinaFee =chinaFee1[0][0];
	System.out.print(chinaFee);

%>
<SCRIPT type=text/javascript>
function ifprint(){
     <%
     if (retCode.equals("000000"))
     {%>
     	var handFee= <%=hand_fee%>;
		if ( Number(handFee) >0 )
		{
		 	rdShowMessageDialog("提交成功! 下面将打印发票！");
		 	var infoStr="";
			infoStr+="<%=work_no%>  <%=sysAccept%>"+"       过期卡换卡"+"|";//工号
	 		infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+=" "+" |";
			infoStr+=" "+" |";
			infoStr+=" "+" |";
			infoStr+=" "+" |";//协议号码
			infoStr+=" "+" |";
			infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
			infoStr+="<%=WtcUtil.formatNumber(hand_fee,2)%>"+"|";//小写

			infoStr+="  过期卡号："+'<%=card_no%>'+"   新卡卡号："+'<%=card_other%>'+"|";
			infoStr+="<%=work_name%>" +"|";//开票人
			 infoStr+=" "+"|";//收款人
		 	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s3070/s3074.jsp?opCode=<%=op_code%>";
		 	//window.location.href="s3074.jsp";

    	 }
		else
		{
			rdShowMessageDialog("提交成功!");
			window.location.href="s3074.jsp";
		}
	<%
    }
    else
    {%>
	    rdShowMessageDialog("过期卡换卡失败。<br>错误代码：'<%=retCode%>'。<br>错误信息：'<%=retMsg%>'。",0);
	    history.go(-1);
    <%}%>
}
</SCRIPT>
<html>
<body onload="ifprint()">
<form action="s3071Print.jsp" name="frm_print_invoice" method="post">
<INPUT TYPE="hidden" name="workno" value="<%=work_no%>">
<INPUT TYPE="hidden" name="print_prepay_fee" value="<%=hand_fee%>">
<INPUT TYPE="hidden" name="opCode" value="<%=op_code%>">
<INPUT TYPE="hidden" name="total_date" value="<%=total_date%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=newloginaccept%>">
<INPUT TYPE="hidden" name="checkNo" value="">


</form>
</body></html>
