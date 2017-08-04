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
	//操作工号
	//zgbe_add.jsp?cphm="+cphm+"&s_tax_no="+s_tax_no+"&s_tax_name="+s_tax_name+"&s_tax_address="+s_tax_address+"&s_tax_phone="+s_tax_phone+"&zh="+zh+"&bz="+bz;

	String cphm = request.getParameter("cphm").trim();					//用户号码
	String s_tax_no = request.getParameter("s_tax_no");
	String s_tax_name = request.getParameter("s_tax_name");
	String s_tax_address = request.getParameter("s_tax_address");
	String s_tax_phone = request.getParameter("s_tax_phone");
	String zh = request.getParameter("zh");
    String bz = request.getParameter("bz");
	String khh= request.getParameter("khh");
	String s_flag="";
	String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
	String s_msg = "";
	String s_code = "";
	
%>
 
 
	<wtc:service name="staxtailadd" routerKey="phone" routerValue="15004675829"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:param value="<%=cphm%>"/>
		<wtc:param value="<%=s_tax_no%>"/>
		<wtc:param value="<%=s_tax_name%>"/>
		<wtc:param value="<%=s_tax_address%>"/>
		<wtc:param value="<%=s_tax_phone%>"/>
		<wtc:param value="<%=khh%>"/>
		<wtc:param value="<%=zh%>"/>
		<wtc:param value="<%=bz%>"/>
		<wtc:param value="<%=work_no%>"/>
	</wtc:service>
	<wtc:array id="resultName" scope="end" />
<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	s_msg=errMsg2;
	s_code=errCode2;
	//System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa phoneNo is "+phoneNo+" and resultName is "+resultName+" and resultName[0][0] is "+resultName[0][0]);
	if(errCode2=="000000" ||errCode2.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("专票虚拟关系添加成功!");
				window.location.href="zgbe_1.jsp";
			</script>
		<%
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("专票虚拟关系添加失败!错误原因:"+"<%=errCode2%>");
				window.location.href="zgbe_1.jsp";
			</script>
		<%
	}
 
%>	
     
 

	 
	
 