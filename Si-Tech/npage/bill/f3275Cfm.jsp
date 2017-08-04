<%
/********************
* 功能: 可选套餐包年取消 3275
* version v3.0
* 开发商: si-tech
* update by qidp @ 2008-11-29
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%	
	String[][] result = new String[][]{};
    String opCode = "3275";
    String opName = "可选套餐包年取消";	
	ArrayList retArray = new ArrayList();
	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr"); 
	String cust_name=request.getParameter("cust_name"); 
	String sum_money=request.getParameter("sum_money");
	String prepay_fee=request.getParameter("limit_pay"); 
	String sale_name=request.getParameter("sale_name");
	String card_info=request.getParameter("");
	String card_money=request.getParameter("");   
	String machine_type=request.getParameter("machine_type");
	String paraAray[] = new String[6];
	

	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phoneNo");
	paraAray[2] = request.getParameter("iOpCode");
    paraAray[3] = work_no;
    paraAray[4] = request.getParameter("addModeCode");
	paraAray[5] = request.getParameter("do_note");
	%>
   <wtc:service name="s3275Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="2" retcode="s3275CfmCode" retmsg="s3275CfmMsg">
        <wtc:param value="<%=paraAray[0]%>"/>
        <wtc:param value="<%=paraAray[1]%>"/>
        <wtc:param value="<%=paraAray[2]%>"/>
        <wtc:param value="<%=paraAray[3]%>"/>
        <wtc:param value="<%=paraAray[4]%>"/>
        <wtc:param value="<%=paraAray[5]%>"/>
	</wtc:service>               
<%
	//String[] ret = impl.callService("s3275Cfm",paraAray,"2","region",org_code.substring(0,2));
	String errCode = s3275CfmCode;
	String errMsg  = s3275CfmMsg;
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+s3275CfmCode+"&retMsgForCntt="+s3275CfmMsg+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[1]+"&opBeginTime="+opBeginTime+"&contactId="+paraAray[1]+"&contactType=user";
	if (errCode.equals("000000") )
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("可选资费包年取消成功！",2);
	window.location="f3250_login.jsp?activePhone=<%=paraAray[1]%>&opCode=3275&opName=可选套餐包年取消";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("可选包年套餐取消失败!(<%=errMsg%>",0);
	window.location="f3250_login.jsp?activePhone=<%=paraAray[1]%>&opCode=3275&opName=可选套餐包年取消";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true" />