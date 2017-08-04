<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-08
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>

<%	
    	//String[][] result = new String[][]{};
    	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
    	//ArrayList retArray = new ArrayList();
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] agentInfo = (String[][])arr.get(2);
	String[][] baseInfo = (String[][])arr.get(0);
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	//String ip_Addr = request.getRemoteAddr();  
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("cardy");
	String card_money=request.getParameter("card_money");
	
	String prepay_fee=request.getParameter("pay_money");
	String print2=request.getParameter("print2");
	String phone_typename=request.getParameter("phone_typename");
	String gift_name=request.getParameter("gift_name");
	
	String paraAray[] = new String[6];
    paraAray[0] =request.getParameter("login_accept");
    paraAray[1] = request.getParameter("opcode");
    paraAray[2] = work_no;
    paraAray[3] = request.getParameter("phone_no");
    paraAray[4] = request.getParameter("opNote");
    paraAray[5] = request.getParameter("ip_Addr");
    
	//String[] ret = impl.callService("s2278Cfm",paraAray,"2","region",org_code.substring(0,2));
%>

<wtc:service name="s2278Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="s2278CfmCode" retmsg="s2278CfmMsg" outnum="2">
	<wtc:param value="<%=paraAray[0]%>"/> 
	<wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/> 
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
</wtc:service>
<wtc:array id="s2278CfmArr" scope="end" />

<%
	String errCode = s2278CfmCode;
	String errMsg = s2278CfmMsg;
    System.out.println("in f2278_2.jsp - s2278Cfm :  "+errCode+" : "+errMsg);
    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+"2278"+"&retCodeForCntt="+errCode+"&opName="+"无线音乐俱乐部包年(季)会员退订"+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%

    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
    
	if (errCode.equals("000000"))
	{

%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功",2);
   window.location="f2296_login.jsp?activePhone=<%=paraAray[3]%>&opCode=2278&opName=无线音乐俱乐部包年(季)会员退订";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("无线音乐俱乐部高级会员退订失败!(<%=errMsg%>",0);
	window.location="f2296_login.jsp?activePhone=<%=paraAray[3]%>&opCode=2278&opName=无线音乐俱乐部包年(季)会员退订";
</script>
<%}%>
