<%
  /*
   * 功能: 用户信誉度修改2308
   * 版本: 1.0
   * 日期: 2009/1/15
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	 			 
	String ls = request.getParameter("ls").trim();//流水
	String tax_no = request.getParameter("tax_no"); 
	String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
	String phone_no = request.getParameter("phone_no"); 
	String s_cust_id="";
	String s_flag="";
%>
	<wtc:service name="staxtailUpd" routerKey="phone" routerValue="15004675829"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:param value="<%=ls%>"/>
		<wtc:param value="<%=tax_no%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=phone_no%>"/>
	</wtc:service>
	<wtc:array id="resultName" scope="end" />
<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	//System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa phoneNo is "+phoneNo+" and resultName is "+resultName+" and resultName[0][0] is "+resultName[0][0]);
	if(errCode2=="000000" ||errCode2.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("审批通过!");
				window.location.href="zgbf_1.jsp";
			</script>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("审批失败!错误代码:"+"<%=errCode2%>,错误原因:"+"<%=errMsg2%>");
				window.location.href="zgbf_1.jsp";
			</script>
		<%
	}
 
%>	
     
 
 