<%
  /* *********************
   * 功能:新入网赠话费预案
   * 版本: 1.0
   * 日期: 2009/09/02
   * 作者: fengry
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String workNo =(String)session.getAttribute("workNo");
	String opCode = "6952";
 	String opName = "新入网赠话费预案";
	String phoneNo = request.getParameter("phoneNo");
	String printAccept = request.getParameter("printAccept");
	String orgCode =(String)session.getAttribute("orgCode");
	String ProCode = request.getParameter("ProCode");
	String regionCode = orgCode.substring(0,2);

	String paraAray[] = new String[6];

	paraAray[0] = workNo;
	paraAray[1] = opCode;
	paraAray[2] = phoneNo;
	paraAray[3] = printAccept;
	paraAray[4] = orgCode;
	paraAray[5] = ProCode;

	System.out.println("paraAray[0]=========================="+paraAray[0]);
	System.out.println("paraAray[1]=========================="+paraAray[1]);
	System.out.println("paraAray[2]=========================="+paraAray[2]);
	System.out.println("paraAray[3]=========================="+paraAray[3]);
	System.out.println("paraAray[4]=========================="+paraAray[4]);
	System.out.println("paraAray[5]=========================="+paraAray[5]);
%>
<wtc:service name="s6952Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
	if(errCode.equals("0") || errCode.equals("000000"))
	{
		System.out.println("f6952Cfm.jsp调用服务s6952Cfm成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
<script language="JavaScript">
	rdShowMessageDialog("操作成功!");
	window.location="f6952_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
</script>
<%
	}else{
		System.out.println("f6952Cfm.jsp调用服务s6952Cfm失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("errCode==="+errCode+"errMsg==="+errMsg);
%>   
<script language="JavaScript">
		rdShowMessageDialog("操作失败!<%=errMsg%>");

<%
if(result[0][1].equals("只有动感地带用户可以办理此业务"))
{
	System.out.println("测试result[0][1]==="+result[0][1]);
}
if(result[0][1].substring(0,6).equals("只有动感地带"))
{
	System.out.println("测试result[0][1].substring(0,6)==="+result[0][1].substring(0,6));
}
System.out.println("测试result[0][0]==="+result[0][0]);
System.out.println("测试result[0][0].substring(0,2)==="+result[0][0].substring(0,2));
System.out.println("测试result[0][0].substring(1,6)==="+result[0][0].substring(1,6));
System.out.println("测试result[0][1]==="+result[0][1]);
System.out.println("测试result[0][1].substring(0,2)==="+result[0][1].substring(0,2));
System.out.println("测试result[0][1].substring(1,6)==="+result[0][1].substring(1,6));
%>

		window.location="f6952_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";	
</script>
<%	
	}
%>
