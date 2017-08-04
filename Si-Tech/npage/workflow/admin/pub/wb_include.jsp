<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.workflow.*"%>
<%@ page import="com.sitech.boss.workflow.cache.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.xml.ParseData2XML" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String loginNo = (String)session.getAttribute("workNo");
	String opName = "端到端任务接收";

	String _wb_groupid=(String)session.getAttribute("_wb_groupid");
		if(_wb_groupid==null||_wb_groupid.equals(""))
		{
%>

				<wtc:pubselect name="sPubSelect" outnum="2">
					<wtc:sql>select group_id,group_name from dchngroupmsg where boss_org_code='?'</wtc:sql>
					<wtc:param value="<%=orgCode.substring(0,orgCode.length()-2)%>"/> 
				</wtc:pubselect>
				<%
				if(retCode.equals("000000"))
				{
				%>
				<wtc:array id="ret"  start="0" length="2" scope='end' /> 
				
				<%
					if(ret.length!=0)
					{
						session.setAttribute("_wb_groupid",ret[0][0]);
						session.setAttribute("_wb_groupname",ret[0][1]);
					}
				}
				else
				{
					throw new Exception("获取group_id错误");
				}
				%>
	<%			
		}
	%>