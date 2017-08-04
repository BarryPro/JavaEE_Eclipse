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
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	 					//操作工号
	String phoneNo = request.getParameter("phoneNo").trim();					//用户号码
 
	String s_cust_id="";
	String s_flag="";
	String[] inParas2 = new String[2];
	int i_count=0;
	String s_tax_no="";
	String s_tax_name="";
	String s_tax_address="";
	String s_tax_phone="";
	//inParas2[0]="select to_char(count(0)),tax_no,tax_name,tax_address,tax_phone,tax_khh,tax_contract from DVIRtaxdetail where phone_no=:s_no and s_flag='Y' group by tax_no,tax_name,tax_address,tax_phone,tax_khh,tax_contract";
	inParas2[0]="select to_char(count(0))  from DVIRtaxdetail where phone_no=:s_no and s_flag='Y' ";
	inParas2[1]="s_no="+phoneNo;
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode1" retmsg="retMsg1" outnum="7">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
 
 
	if(result1!=null &&result1.length>0)
	{
		i_count=Integer.parseInt(result1[0][0]);
		s_flag="0";
	}
	else
	{
		s_flag="1";
	}
 
%>	
     
 

	var response = new AJAXPacket();
			
	response.data.add("i_count","<%=i_count%>");
	
	response.data.add("s_flag","<%=s_flag%>");
 
	core.ajax.receivePacket(response);
	
 