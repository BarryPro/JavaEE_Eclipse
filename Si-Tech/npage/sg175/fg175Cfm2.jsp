<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:MIS-POS统一冲正-计费冲正
   * 版本: 1.0
   * 日期: 
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**	
   工号 org_code 手机号码 in_Rrn(银行流水)
  *@		 iLoginNo      工号
	*@     org_code  		 组织机构编码
	*@		 iPhoneNo,     手机号码
  *@     iOldAccept    原业务流水

*/

	/*===========获取参数============*/
  String 	regionCode = (String)session.getAttribute("regCode");  
  String  iOpCode = (String)request.getParameter("iOpCode");
  String  iLoginNo = (String)request.getParameter("iLoginNo");
  String  iPhoneNo = (String)request.getParameter("iPhoneNo");
  String  iOldAccept = (String)request.getParameter("iOldAccept");
  String 	iopName = 	(String)request.getParameter("iOpName"); 
  String 	iOrgCode = 	(String)request.getParameter("iOrgCode");             
      
%>
<wtc:service name="updPosInf" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iOrgCode%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iOldAccept%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务updPosInf in fg175Cfm2.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("MIS-POS统一冲正成功！");
		window.location = 'fg175Main.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}else{
		System.out.println("调用服务updPosInf in fg175Cfm2.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location = 'fg175Main.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}		
%>	

