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
	String opCode = "zgag";
  	String opName = "充值卡手工充值";
	//xl add
	String o_opcode=request.getParameter("o_opcode");
 	String o_login_accept=request.getParameter("o_login_accept");
	ArrayList arr = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfo = (String[][])arr.get(0);
	String work_no = baseInfo[0][2];
	String work_name = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String[][] password1 = (String[][])arr.get(4);//读取工号密码 
	String pass = password1[0][0];
	
	String paraAray[] = new String[7];

	String phoneNo =request.getParameter("phoneNo");
	String in_money=request.getParameter("yczje");//应充值金额
 
	
	
	String czkkh = request.getParameter("card_no");
	String czkmz = request.getParameter("kmz");
 
	String ppsCardPin = request.getParameter("km");
	//String opNote = request.getParameter("opNote");
	String opNote = "充值卡手动充值";
 
 
	String cmd_str = phoneNo + "~"  + ppsCardPin;
 
	
	String paraArayNew[] = new String[10];
	paraArayNew[0]="e251";
	paraArayNew[1]=work_no;
	paraArayNew[2]=phoneNo;
	paraArayNew[3]=phoneNo;
	paraArayNew[4]=in_money;
	paraArayNew[5]=czkkh;
	paraArayNew[6]=czkmz;
	paraArayNew[7]=cmd_str; 
	paraArayNew[8]="g794"; 
	paraArayNew[9]=o_login_accept; 
/*	 
	String[] retNew = impl.callService("bs_e251Cfm",paraArayNew,"2" );
	int errCodeNew;
	String errMsgNew;
	errCodeNew = impl.getErrCode();
	errMsgNew = impl.getErrMsg();
	 */
	%>
	<wtc:service name="bs_zgagCfm" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="errCodeNew" retmsg="errMsgNew" outnum="2">
		    <wtc:param value="<%=paraArayNew[0]%>"/>
			<wtc:param value="<%=paraArayNew[1]%>"/>
			<wtc:param value="<%=paraArayNew[2]%>"/>
			<wtc:param value="<%=paraArayNew[3]%>"/>
			<wtc:param value="<%=paraArayNew[4]%>"/>
			<wtc:param value="<%=paraArayNew[5]%>"/>
			<wtc:param value="<%=paraArayNew[6]%>"/>
			<wtc:param value="<%=paraArayNew[7]%>"/>
			<wtc:param value="<%=paraArayNew[8]%>"/>
			<wtc:param value="<%=paraArayNew[9]%>"/>
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
		window.location="zgag_1.jsp?activePhone="+"<%=phoneNo%>"+"&opCode="+"zgag"+"&opName="+"充值卡手工充值";
	</script>
	<%
		}else{
	%>   
	<script language="JavaScript">
		rdShowMessageDialog("用户手工充值失败!(<%=return_msg%>");
		window.location="zgag_1.jsp?activePhone="+"<%=phoneNo%>"+"&opCode="+"zgag"+"&opName="+"充值卡手工充值";
	</script>
	<%}
	}
	
 
%>
	 
