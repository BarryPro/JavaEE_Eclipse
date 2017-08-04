<% 
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
 

<%	
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String work_no = baseInfo[0][2];
	String work_name = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String[][] password1 = (String[][])arr.get(4);//读取工号密码 
	String pass = password1[0][0];
	
	String paraAray[] = new String[7];
	 
 
	String phoneNo ="";
	String in_money="";
	String password =""; //个人的密
	phoneNo = request.getParameter("phoneNo");//手机号码
	
  
	String czkmz = request.getParameter("kmz");//卡面值
	
	String ppsCardPin = request.getParameter("kmm");//卡密码
 
	String opNote = "充值卡手工充值";
 
	//String cmd_str = phoneNo + "~" + password + "~" + ppsCardPin;
	String cmd_str = phoneNo + "~"  + ppsCardPin;
	String cardNo = request.getParameter("cardNo");//卡号
	//new 集团id
	 
	paraAray[0]="g248"; 
	paraAray[1]=work_no;
	paraAray[2]=phoneNo;
	paraAray[3]=czkmz;//面值
	paraAray[4]=cardNo;
	paraAray[5]=czkmz;//面值
	paraAray[6]=cmd_str;

	
 
	
 
 
/*	 
	String[] retNew = impl.callService("bs_e251Cfm",paraArayNew,"2" );
	int errCodeNew;
	String errMsgNew;
	errCodeNew = impl.getErrCode();
	errMsgNew = impl.getErrMsg();
	 */
	%>
	<wtc:service name="bs_e384Cfm" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="errCodeNew" retmsg="errMsgNew" outnum="2">
		    <wtc:param value="<%=paraAray[0]%>"/>
			<wtc:param value="<%=paraAray[1]%>"/>
			<wtc:param value="<%=paraAray[2]%>"/>
			<wtc:param value="<%=paraAray[3]%>"/>
			<wtc:param value="<%=paraAray[4]%>"/>
			<wtc:param value="<%=paraAray[5]%>"/>
			<wtc:param value="<%=paraAray[6]%>"/> 
		</wtc:service>
	<wtc:array id="results" scope="end" />
	<%
	String return_code="";
	String return_msg="";
	String[][] result1  = null ;
	result1=results;
	if(result1!=null)
	{
		return_code=result1[0][0];
		return_msg=result1[0][1];
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAaaareturn_code is  "+return_code);
		if (return_code == "000000" ||return_code.equals("000000") )
		{
	%>
	<script language="JavaScript">
		rdShowMessageDialog("用户手工充值成功！");
		window.location="g248_1.jsp";
	</script>
	<%
		}else{
	%>   
	<script language="JavaScript">
		rdShowMessageDialog("用户手工充值失败!(<%=return_msg%>");
		window.location="g248_1.jsp";
	</script>
	<%}
	}
	
 
%>
	 
