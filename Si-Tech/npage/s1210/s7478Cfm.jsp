<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-28 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
	String work_no = (String)session.getAttribute("workNo");
	String op_code = "7478";
	String paraStr[] = new String[24];
	String stream ="0";
	String loginPwd = (String)session.getAttribute("password"); //工号密码
%>
<%--@ include file="../../npage/public/fPubSavePrint.jsp" --%>

<%
    paraStr[0] = "0";
    paraStr[1] = "01";
    paraStr[2] = op_code;
    paraStr[3] = work_no;   
    paraStr[4] = loginPwd;
    paraStr[5] = activePhone;
    paraStr[6] = ""; 


    //String[] fg = co.callService("s7478Cfm", paraStr, "1", "phone", srv_no);
%>
		<wtc:service name="s7478Cfm" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=activePhone%>" outnum="1">
			<wtc:param value="<%=paraStr[0]%>"/>
			<wtc:param value="<%=paraStr[1]%>"/>
			<wtc:param value="<%=paraStr[2]%>"/>
			<wtc:param value="<%=paraStr[3]%>"/>
			<wtc:param value="<%=paraStr[4]%>"/>
			<wtc:param value="<%=paraStr[5]%>"/>
			<wtc:param value="<%=paraStr[6]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	  System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");		
    int s7478CfmRetCode = 999999;
    if(initRetCode!=null&&initRetCode!=""){
    	s7478CfmRetCode = Integer.parseInt(initRetCode);
    }
    String s7478CfmRetMsg = initRetMsg;
    System.out.println("result[0][0] = " + result[0][0]);
    System.out.println("errCode = " + s7478CfmRetCode);
	String cnttActivePhone = activePhone;    
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraStr[2]+"&retCodeForCntt="+initRetCode+"&opName=取消网管黑名单功能&workNo="+paraStr[3]+"&loginAccept="+result[0]+"&pageActivePhone="+cnttActivePhone+"&retMsgForCntt="+s7478CfmRetMsg+"&opBeginTime="+opBeginTime;
 %>
 	<jsp:include page="<%=url%>" flush="true" />
 <%
 		System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");	
    if (s7478CfmRetCode == 0) {     
%>
	<script>
	    rdShowMessageDialog("操作成功！", 2);
	    location = "s7478Login.jsp?activePhone=<%=activePhone%>";
	</script>
<%
	} else {
	%>
		<script>
		    rdShowMessageDialog('错误<%=s7478CfmRetCode%>：' + '<%=s7478CfmRetMsg%>，请重新操作！');
		    location = "s7478Login.jsp?activePhone=<%=activePhone%>";
		</script>
<%
    }
%>
