<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>   
<%@ page import="java.util.*"%>                                                 
<%@ page import="java.text.*"%>                                                 
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>        

<%
	String loginNo=(String)session.getAttribute("workNo");    //���� 
	String workPwd = (String)session.getAttribute("password");
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retFlag = "0";
    
    String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());
	
	String opCode = "e539";	
	String error_code = "";
	String error_msg="ϵͳ��������ϵͳ����Ա��ϵ";
    
    SPubCallSvrImpl impl = new SPubCallSvrImpl();

	String OprCode = request.getParameter("OprCode");//e542��ֹ
	String queryValue = request.getParameter("queryValue");//��ѯֵ 
	String alterCodeProp = request.getParameter("alterCodeProp");//���޸Ļ������������
	String alterCode = request.getParameter("alterCode");//���޸Ļ��������
	String v_id = request.getParameter("v_id");//���޸Ļ��������
	String ecsiname = request.getParameter("queryName");
  String phone_no = request.getParameter("phone_no");//��ϵ�绰
	
	System.out.println("OprCode="+OprCode);
	System.out.println("queryValue="+queryValue);
	System.out.println("alterCodeProp="+alterCodeProp);
	System.out.println("alterCode="+alterCode);
	System.out.println("v_id="+v_id);
	 
%>
<wtc:service name="se539Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=OprCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=workPwd%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=queryValue%>"/>
	<wtc:param value="<%=ecsiname%>"/>
	<wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=alterCode%>"/>
	<wtc:param value="<%=alterCodeProp%>"/>
	<wtc:param value="<%=regionCode%>"/>
</wtc:service>
<wtc:array id="callData" scope="end" />	

<%
	error_code=retCode1;
	error_msg= retMsg1;
	
	System.out.println("================="+error_code);
	System.out.println("================="+error_msg);
	System.out.println("================="+callData[0][0]);
	System.out.println("================="+callData[0][1]);
	
	if(!"000000".equals(error_code))
	{
		retFlag="0";
	}
    else
    {
   		retFlag="1";
    }


%>

var response = new AJAXPacket();
response.data.add("retFlag","<%=retFlag.trim()%>");
response.data.add("retCode","<%=callData[0][0]%> ");
response.data.add("retMsg","<%=callData[0][1]%> ");
response.data.add("v_id","<%=v_id%> ");
core.ajax.receivePacket(response);
