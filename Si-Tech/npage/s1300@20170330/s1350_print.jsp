<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-09-16 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
 
 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String printway=request.getParameter("printway");//打印方式
	String mobileno	 = request.getParameter("mobileno");//用户ID
	String contractno	 = request.getParameter("contractno");//帐户ID
	String billmonth = request.getParameter("billmonth");//帐单年月

  String workno = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String ny = dateStr.substring(0,4);
	String nm = dateStr.substring(4,6);
	String nd = dateStr.substring(6,8);

	String op_code  =  "1350";
	String billy = billmonth.substring(0,4);
	String billm = billmonth.substring(4,6);
	String billd = "";
	//判断闰年闰月，取帐单"日",开始:
	if(billm.equals("01")||billm.equals("03")||billm.equals("05")||billm.equals("07")||billm.equals("08")||billm.equals("10")||billm.equals("12")) {
	      billd = "31";
	} else if (billm.equals("04")||billm.equals("06")||billm.equals("09")||billm.equals("11")) {
	       billd = "30";
	} else if (billm.equals("02")) {
		if ((Integer.parseInt(billy)%4==0)&&(Integer.parseInt(billy)%100!=0) || (Integer.parseInt(billy)%400==0)) {
	      	billd = "29";
		} else {
	        billd = "28";
		}
	}
 	String id = "";
	String printname ="";
	//0:mobileno,1:contractno
	if (printway.equals("0")) {
		id = mobileno;
		printname = "服务号码";
	} else if(printway.equals("1")) {
		id = contractno;
		printname = "帐户号码";
	}	

	String[] inParas = new String[4];
	inParas[0] = printway;
	inParas[1] = id;
	inParas[2] = billmonth;
	inParas[3] = workno;
	for(int i=0;i<inParas.length;i++){
  	System.out.println("##############inParas["+i+"]->"+inParas[i]);
  }
	//CallRemoteResultValue value = viewBean.callService("1",org_code.substring(0,2),"s1350Init","11"  ,lens,inParas);
%>
	<wtc:service name="s1350Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="7" scope="end"/> 
	<wtc:array id="result2" start="7" length="2" scope="end"/>
	<wtc:array id="result3" start="9" length="1" scope="end"/>
	<wtc:array id="result4" start="10" length="1" scope="end"/>
<% 
   if(result==null||result.length==0){
%>
		<script language="javascript">
			rdShowMessageDialog("查询的账单信息为空!");
			window.location.href = "s1350.jsp";
		</script>
<%
			return;
  }
    
	String return_code = retCode1;
	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
   
  String username = null;
  String user_jifen = null;
  String user_total_fee = null;
	String pre_total_fee = null;
	String shoud_pay_fee = null;
	String user_total_mark = null;

	if (return_code.equals("000000")) {
			username = result[0][1];
	    user_jifen =result[0][2];
	    user_total_fee =result[0][3];
			pre_total_fee =result[0][4];
	    shoud_pay_fee =result[0][5];
	    user_total_mark =result[0][6];
	}
%>
<%if (!return_code.equals("000000")) {%>
 		<script language="javascript">
			rdShowMessageDialog("查询的账单信息失败!原因:<%=return_code%><%=error_msg%>");
			window.location.href = "s1350.jsp";
		</script> 
<% } else {%>
<SCRIPT language="JavaScript">
<!--
function ifprint(){
try {
<%
for (int i=0;i<result.length;i++) {
  out.println("printctrl.Setup(0)");
  out.println("printctrl.StartPrint()");
  out.println("printctrl.PageStart()");

  int colNumber = 10;
  for (int j = 0;j < result3.length; j++) {
      out.println("printctrl.Print(11,"+ colNumber +",9,0,'"+result3[j][0]+"')");      
      ++colNumber;
  }
  
  //第一行
  out.println("printctrl.Print(11,29,9,0,'"+username+"')");
  out.println("printctrl.Print(78,29,9,0,'"+id+"')");
  
  //第二行
  out.println("printctrl.Print(9,31,9,0,'"+billy+"')");
  out.println("printctrl.Print(18,31,9,0,'"+billm+"')");
  out.println("printctrl.Print(26,31,9,0,'"+"01"+"')");

  out.println("printctrl.Print(35,31,9,0,'"+billy+"')");
  out.println("printctrl.Print(45,31,9,0,'"+billm+"')");
  out.println("printctrl.Print(52,31,9,0,'"+billd+"')");
  
  out.println("printctrl.Print(77,31,9,0,'"+ny+"')");
  out.println("printctrl.Print(85,31,9,0,'"+nm+"')");
  out.println("printctrl.Print(92,31,9,0,'"+nd+"')");

  int resultlength = result2.length;
  int len = 0;
  if (resultlength <= 15) {
     len = 5;
  } else if (resultlength <= 30 && resultlength > 15) {
     len = 10;
  } else if (resultlength <= 60 && resultlength > 30) {
     len = 20;
  } else {
     len = 30;
  }

  int len1=0;
  int len2=0;
  int len3=0;
                    
  if (resultlength > 2*len) {
     len1 = len;
     len2 = len;
     len3 = resultlength -2*len;
  }else if (resultlength <= 2*len && resultlength > len) {
     len1 = len;
     len2 = resultlength-len;
     len3 = 0;
  } else if (resultlength <= len) {
     len1 = resultlength;
     len2 = 0;
     len3 = 0;
  }
  
  colNumber = 40;
  for(int m=0;m<len1;m++) {
     if (result2[m][1].equals("")){
	    out.println("printctrl.Print(0,"+ colNumber +",9,0,'"+result2[m][0]+"')");
	 } else {
	    out.println("printctrl.Print(2,"+ colNumber +",9,0,'"+result2[m][0]+"')");
	 }
	 ++colNumber;
  }

  colNumber = 40;
  for (int m=0;m<len1;m++) {
      out.println("printctrl.Print(15,"+ colNumber +",9,0,'"+result2[m][1]+"')"); 
	  ++colNumber;	  
  }
  
  ///////////////////////////////
  colNumber = 40;
  for(int m=len1;m<len2+len1;m++) {
     if (result2[m][1].equals("")){
	    out.println("printctrl.Print(35,"+ colNumber +",9,0,'"+result2[m][0].trim()+"')");
	 } else {
	    out.println("printctrl.Print(37,"+ colNumber +",9,0,'"+result2[m][0].trim()+"')");
	 }
	 ++colNumber;
  }
  
  colNumber = 40;
  for(int m=len1;m<len2+len1;m++) {
	 out.println("printctrl.Print(53,"+ colNumber +",9,0,'"+result2[m][1].trim()+"')"); 
	 ++colNumber;
  }

  /////////////
  colNumber = 40;
  for (int m=len2+len1;m< len2+len1+len3 ;m++) {
     if (result2[m][1].equals("")){
	    out.println("printctrl.Print(68,"+ colNumber +",9,0,'"+result2[m][0].trim()+"')");
	 } else {
	    out.println("printctrl.Print(70,"+ colNumber +",9,0,'"+result2[m][0].trim()+"')");
	 }
	 ++colNumber;
  }
  
  colNumber = 40;
  for (int m=len2+len1;m< len2+len1+len3 ;m++) {
	 out.println("printctrl.Print(88,"+ colNumber +",9,0,'"+result2[m][1].trim()+"')"); 
	 ++colNumber;
  }

  out.println("printctrl.Print(13,63,9,0,'￥"+user_total_fee.trim()+"')");
  out.println("printctrl.Print(45,63,9,0,'￥"+pre_total_fee.trim()+"')");
  out.println("printctrl.Print(75,63,9,0,'￥"+shoud_pay_fee.trim()+"')");

  out.println("printctrl.Print(15,66,9,0,'"+user_total_mark+"')");
  out.println("printctrl.Print(70,66,9,0,'"+user_jifen+"')");
  
  colNumber = 69;
  for (int j = 0;j < result4.length; j++) {
      out.println("printctrl.Print(11,"+ colNumber +",9,0,'"+result4[j][0]+"')");      
      ++colNumber;
  }
	
  out.println("printctrl.PageEnd()");
  out.println("printctrl.StopPrint()");
}
%>
} catch(e) {
} finally {
}
<%
	 System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
	 String cnttOpCode = "1350";
	 String cttOpNamge = "账单打印";
	 String cnttWorkNo = workno;
	 String retCodeForCntt = "000000";
	 String cnttLoginAccept = "";
	 System.out.println("--------------流水----:"+cnttLoginAccept);
	 String cnttContactId = id;
	 String cnttUserType = "user";
	  if(printway.equals("0")) {
			cnttUserType = "user";
		}else if(printway.equals("1")) {
			cnttUserType = "acc";
		}	
	 String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+cnttOpCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+cttOpNamge+"&workNo="+cnttWorkNo+"&loginAccept="+cnttLoginAccept+"&contactId="+cnttContactId+"&contactType="+cnttUserType;
	 System.out.println("--------------url----:"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	 System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
%>
  rdShowMessageDialog("打印成功!",2);
  document.location.replace("s1350.jsp");
}
-->
</SCRIPT>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
<body onload="ifprint()">
<form action="" name="form" method="post">
</form>
</body>
</html>
<% } %>
