<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * 功能:世博会门票配送信息更改
   * 版本: 1.0
   * 日期: 2009/5/14
   * 作者: wangjya
   * 版权: si-tech
   */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6921";
	String opName = "世博会门票配送信息更改";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");

	

	
	String orderCode = request.getParameter("order_code");	
	String mobileNo = request.getParameter("mobileNo");
	String phoneNo = request.getParameter("phoneNo");
	String custName = request.getParameter("custName");
	String idType = request.getParameter("idType");
	String idCard = request.getParameter("idCard");
	String custAddress = request.getParameter("custAddress");
	String postCode = request.getParameter("postCode");
	String ticket_type = null == request.getParameter("ticket_type") ? "" : request.getParameter("ticket_type");
	String ticket_sum = null == request.getParameter("ticket_sum") ? "" : request.getParameter("ticket_sum");
	String ticket_date = null == request.getParameter("ticket_date") ? "" : request.getParameter("ticket_date");

	/*00－变更成功，此时报文头中的RspCode＝0000
	01－变更失败，已配送，变更失败时报文头中的RspCode＝2998
	02－变更失败，已送达
	03－变更失败，该定单中无此票种，
	04－变更失败，变更票数>定单中票数
	05－变更失败，该定单中无此门票时间*/
	Map errType = new HashMap();
	errType.put("01","已配送");
	errType.put("02","已送达");
	errType.put("03","该定单中无此票种");
	errType.put("04","变更票数大于定单中票数");
	errType.put("05","该定单中无此门票时间");
	
	String inputParsm[] = new String[13];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = orderCode;
	inputParsm[3] = mobileNo;
	inputParsm[4] = phoneNo;	
	inputParsm[5] = custName;
	inputParsm[6] = idType;
	inputParsm[7] = idCard;
	inputParsm[8] = custAddress;
	inputParsm[9] = postCode;
	inputParsm[10] = ticket_type;
	inputParsm[11] = ticket_sum;
	inputParsm[12] = ticket_date;
%>

   <wtc:service name="s6921Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="5">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	<wtc:param value="<%=inputParsm[5]%>"/>	
	<wtc:param value="<%=inputParsm[6]%>"/>	
	<wtc:param value="<%=inputParsm[7]%>"/>	
	<wtc:param value="<%=inputParsm[8]%>"/>	
	<wtc:param value="<%=inputParsm[9]%>"/>
	<wtc:param value="<%=inputParsm[10]%>"/>	
	<wtc:param value="<%=inputParsm[11]%>"/>	
	<wtc:param value="<%=inputParsm[12]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="5"  scope="end"/>
<% 		

	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("变更失败！" + "<%=errMsg%>",0);	
	 	window.location="f6923_1.jsp?opCode=6921&opName=世博会门票配送信息更改";
		</script>
<%		
		return;				 			
	}
	else if(tempArr[0][0].equals("0000")){
%>
		<script language="javascript">
		rdShowMessageDialog("更改成功！",2);	
		window.location="f6923_1.jsp?opCode=6921&opName=世博会门票配送信息更改";
	 	
		</script>
<%		
		return;				 			
	}
	else if(tempArr[0][0].equals("2998"))
	{
	%>
		<script language="javascript">
	 	rdShowMessageDialog("变更失败！" + "<%=null == errType.get(tempArr[0][4])?tempArr[0][1]:errType.get(tempArr[0][4])%>",0);	
	 	window.location="f6923_1.jsp?opCode=6921&opName=世博会门票配送信息更改";
		</script>
	<%	
	}
	else 
	{
	%>
		<script language="javascript">
	 	rdShowMessageDialog("变更失败！" + "<%=tempArr[0][1]%>",0);	
	 	window.location="f6923_1.jsp?opCode=6921&opName=世博会门票配送信息更改";
		</script>
	<%	
	}
%>

