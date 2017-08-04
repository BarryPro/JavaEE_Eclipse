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
	String opCode = "e251";
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
	String zzFlag = request.getParameter("show");
	System.out.println("QQQQQQQQQQQQQQQQQQQ是否转增的判断标记 0非转 1转 "+zzFlag);
	String phoneNo ="";
	String in_money="";
	String password =""; //个人的密
	if(zzFlag=="1" ||"1".equals(zzFlag))
	{
		phoneNo = request.getParameter("zzphone");
		in_money = request.getParameter("zzje");
		//password = request.getParameter("password2zz"); //个人的密
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA转赠 "+phoneNo );
	}
	else if(zzFlag=="2" ||"2".equals(zzFlag))
	{
		phoneNo =  request.getParameter("srv_no");
		in_money = request.getParameter("fzzje");
		//password = request.getParameter("grmm");
		System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB not转赠 "+phoneNo);
	}
	else
	{
		phoneNo =  request.getParameter("srv_no");
		in_money = request.getParameter("fzzje");
		//password = request.getParameter("password2fzz"); //个人的密
		System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB not转赠 "+phoneNo);
	}
	
String czkkh = request.getParameter("czkkh");
	String czkmz = request.getParameter("czkmz");
	System.out.println("WWWWWWWWWWWWWWWWWWWWWWWWWWfinal test  password is "+password);
	String ppsCardPin = request.getParameter("ppsCardPin");
	//String opNote = request.getParameter("opNote");
	String opNote = "充值卡手动充值";
	String phone_ori = request.getParameter("srv_no");
	//String cmd_str = phoneNo + "~" + password + "~" + ppsCardPin;
	String cmd_str = phoneNo + "~"  + ppsCardPin;
 
	
	String paraArayNew[] = new String[10];
	paraArayNew[0]="e251";
	paraArayNew[1]=work_no;
	paraArayNew[2]=phone_ori;
	paraArayNew[3]=phoneNo;
	paraArayNew[4]=in_money;
	paraArayNew[5]=czkkh;
	paraArayNew[6]=czkmz;
	paraArayNew[7]=cmd_str; 
	paraArayNew[8]=o_opcode; 
	paraArayNew[9]=o_login_accept; 
/*	 
	String[] retNew = impl.callService("bs_e251Cfm",paraArayNew,"2" );
	int errCodeNew;
	String errMsgNew;
	errCodeNew = impl.getErrCode();
	errMsgNew = impl.getErrMsg();
	 */
	%>
	<wtc:service name="bs_e251Cfm" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="errCodeNew" retmsg="errMsgNew" outnum="2">
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
		window.location="e251_1.jsp?activePhone="+"<%=phone_ori%>"+"&opCode="+"e251"+"&opName="+"充值卡手工充值";
	</script>
	<%
		}else{
	%>   
	<script language="JavaScript">
		rdShowMessageDialog("用户手工充值失败!(<%=return_msg%>");
		window.location="e251_1.jsp?activePhone="+"<%=phone_ori%>"+"&opCode="+"e251"+"&opName="+"充值卡手工充值";
	</script>
	<%}
	}
	
 
%>
	 
