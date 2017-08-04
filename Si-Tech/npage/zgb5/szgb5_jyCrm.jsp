<%
  /*
   * 功能: 校验服务号码是否为宽带号码
   * 版本: 1.0
   * 日期: 2014/8/20
   * 作者: huangqi
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	 
 
	String sim_vlaue = WtcUtil.repNull(request.getParameter("sim_vlaue").trim());
	 
	String id_no = WtcUtil.repNull(request.getParameter("id_no").trim());
 
	int i_count=0;
	String s_sql_flag="";
 
	String[] inParam = new String[2];
	inParam[0]="select to_char(count(0))  from dcustsimdead where id_no=:s_id_no and to_char(sim_no) = :s_sim";
	inParam[1]="s_id_no="+id_no+",s_sim="+sim_vlaue;
	%>
	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
	<%
	 
		 
	String s_flag="";
%>
	
<%
	
	String checkResult="0";
	String[][] result1  = null ;
	result1=result;
	if(result1!=null&&result1.length>0)
	{
		if(Integer.parseInt(result1[0][0])>=1)
		{
			s_flag="0";//通过
		}
		else
		{
			s_flag="1";
		}
		System.out.println("ccccccccccccccccccccccccccc result1 is "+result1[0][0]);
	}
	else
	{
		s_flag="1";//不通过
	}
	System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB s_flag is "+s_flag);
%>
		
 
	var response = new AJAXPacket();
	response.data.add("s_flag","<%=s_flag%>");
	core.ajax.receivePacket(response);
 