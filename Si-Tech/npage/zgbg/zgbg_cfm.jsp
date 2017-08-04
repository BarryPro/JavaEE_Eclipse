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
	String workno = (String)session.getAttribute("workNo");
	String s_phone_no = request.getParameter("s_phone_no").trim();					//用户号码
	String s_tax_no = request.getParameter("s_tax_no").trim();
	String s_tax_name = request.getParameter("s_tax_name").trim();
	String s_tax_address = request.getParameter("s_tax_address").trim();
	String s_tax_phone = request.getParameter("s_tax_phone").trim();					//用户号码
	String s_tax_khh = request.getParameter("s_tax_khh").trim();
	String s_tax_zh = request.getParameter("s_tax_zh").trim();
	String s_begin_ym = request.getParameter("s_begin_ym").trim();
	String s_end_ym = request.getParameter("s_end_ym").trim();					//用户号码
	String s_spr = request.getParameter("s_spr").trim();
	String s_spr_phone = request.getParameter("s_spr_phone").trim();
	String s_hwmc = request.getParameter("s_hwmc").trim();
	String s_dj = request.getParameter("s_dj").trim();
	String s_sl = request.getParameter("s_sl").trim();
	String s_je = request.getParameter("s_je").trim();
	String s_sl_je = request.getParameter("s_sl_je").trim();
	String bzxx = request.getParameter("bzxx").trim();
	String kj_flag = request.getParameter("kj_flag").trim();
	String[] inParas2 = new String[19];
	inParas2[0]=s_tax_no;
	inParas2[1]=s_tax_name;
	inParas2[2]=s_phone_no;
	inParas2[3]=s_tax_address;
	inParas2[4]=s_tax_phone;
	inParas2[5]=s_tax_khh;
	inParas2[6]=s_tax_zh;
	inParas2[7]=s_begin_ym;
	inParas2[8]=s_end_ym;
	inParas2[9]=workno;
	inParas2[10]=s_spr;
	inParas2[11]=s_spr_phone;
	inParas2[12]=s_hwmc;
	inParas2[13]=s_dj;
	inParas2[14]=s_sl;
	inParas2[15]=s_je;
	inParas2[16]=s_sl_je;
	inParas2[17]=bzxx;
	inParas2[18]=kj_flag;
 
 
%>
	<wtc:service name="staxInsert" routerKey="phone" routerValue="<%=s_phone_no%>"  retcode="retCode1" retmsg="retMsg1" outnum="7">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
		<wtc:param value="<%=inParas2[2]%>"/>
		<wtc:param value="<%=inParas2[3]%>"/>
		<wtc:param value="<%=inParas2[4]%>"/>
		<wtc:param value="<%=inParas2[5]%>"/>
		<wtc:param value="<%=inParas2[6]%>"/>
		<wtc:param value="<%=inParas2[7]%>"/>
		<wtc:param value="<%=inParas2[8]%>"/>
		<wtc:param value="<%=inParas2[9]%>"/>
		<wtc:param value="<%=inParas2[10]%>"/>
		<wtc:param value="<%=inParas2[11]%>"/>
		<wtc:param value="<%=inParas2[12]%>"/>
		<wtc:param value="<%=inParas2[13]%>"/>
		<wtc:param value="<%=inParas2[14]%>"/>
		<wtc:param value="<%=inParas2[15]%>"/>
		<wtc:param value="<%=inParas2[16]%>"/>
		<wtc:param value="<%=inParas2[17]%>"/>
		<wtc:param value="<%=inParas2[18]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	String ret_code=retCode1;
	String ret_msg = retMsg1;
	String s_flag="";
	if(ret_code=="000000"||ret_code.equals("000000"))
	{
		s_flag="0";
	}
	else
	{
		s_flag="1";
	}
 
%>	
     
 

	var response = new AJAXPacket();
	response.data.add("s_flag","<%=s_flag%>");
	response.data.add("s_msg","<%=ret_msg%>");
	core.ajax.receivePacket(response);
	
 