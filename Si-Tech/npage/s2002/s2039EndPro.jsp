
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page errorPage="../common/errorpage.jsp" %>


<%	
	//读取用户session信息	
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");	
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               //工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();	
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //登陆密码	
	String regionCode = baseInfo[0][16].substring(0,2);
			
	String PospecNum=request.getParameter("PospecNum");//商品规格编码
	String ProductCode=request.getParameter("ProductCode");//产品代码
	String productNum=request.getParameter("productNum");//产品规格编码
	String planCode=request.getParameter("planCode");//资费计划标识
	String v_id=request.getParameter("v_id");        //修改id标示
	String tempflag=request.getParameter("tempflag"); //终止成员资费标示
	String vregioncode=request.getParameter("vregioncode");
	String modecode=request.getParameter("modecode");
	String vcharacternum=request.getParameter("vcharacternum");
	String smparasetValue=request.getParameter("smparasetValue");
	String fieldValue=request.getParameter("fieldValue");
	String fieldtxt=request.getParameter("fieldtxt");
	String vreturnCode="";
	String vreturnMsg="";
	String code_th = request.getParameter("code_th");//更改dProductCharacterInfo 表 charater_attr_code字段 第code_th位
	String attr_code = request.getParameter("attr_code");//更改dProductCharaterInfo表charater_attr_code字段  的前面字符串
	System.out.println("wuxy");
	System.out.println("PospecNum="+PospecNum);
	System.out.println("ProductCode="+ProductCode);
	System.out.println("productNum="+productNum);
	System.out.println("planCode="+planCode);
	System.out.println("v_id="+v_id);
	System.out.println("vregioncode"+vregioncode);
	System.out.println("modecode="+modecode);
	System.out.println("vcharacternum="+vcharacternum);
	System.out.println("tempflag="+tempflag);
	System.out.println("smparasetValue="+smparasetValue);
	System.out.println("fieldValue="+fieldValue);
	System.out.println("fieldtxt="+fieldtxt);
	
	 String retFlag = "0";
	
	
	if("1".equals(tempflag))
	{
	
%>	
var response = new AJAXPacket();

<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="Code1" retmsg="Msg1">
		<wtc:param value="203902"/>
		<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=PospecNum%>"/>
       <wtc:param value="<%=productNum%>"/>
       	<wtc:param value="<%=planCode%>"/>
       <wtc:param value="<%=modecode%>"/>
       	<wtc:param value="<%=vregioncode%>"/>
</wtc:service>
<wtc:array id="result1"  scope="end" />
<%
	vreturnMsg=Msg1;
  if(Code1.equals("000000"))
  {  
		vreturnCode="0";
		
  }

 } else if("2".equals(tempflag))
 {
%>
	var response = new AJAXPacket();

<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="Code2" retmsg="Msg2">
		<wtc:param value="203903"/>
			<wtc:param value="<%=PospecNum%>"/>
       <wtc:param value="<%=productNum%>"/>
       	<wtc:param value="<%=vcharacternum%>"/>
</wtc:service>
<wtc:array id="result2"  scope="end" />

<%
	  vreturnMsg=Msg2;
    if(Code2.equals("000000"))
    {  
		  vreturnCode="0";
		
    }
  }
  else if("3".equals(tempflag))
  {
%>
 		var response = new AJAXPacket();

<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="Code3" retmsg="Msg3">
		<wtc:param value="203904"/>
			<wtc:param value="<%=workNo%>"/>
       	<wtc:param value="<%=vcharacternum%>"/>
       		<wtc:param value="<%=vcharacternum%>"/>
</wtc:service>
<wtc:array id="result3"  scope="end" />
<% 
   vreturnMsg="3";
    if(Code3.equals("000000"))
    {  
		  vreturnCode="0";
		
    }

} else if("4".equals(tempflag))
{
%>
	var response = new AJAXPacket();
	<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="Code4" retmsg="Msg4">
		<wtc:param value="203906"/>
			<wtc:param value="<%=workNo%>"/>
       	<wtc:param value="<%=vcharacternum%>"/>
       		<wtc:param value="<%=vcharacternum%>"/>
       			<wtc:param value="<%=vcharacternum%>"/>
       				<wtc:param value="<%=fieldtxt%>"/>
       					<wtc:param value="<%=fieldValue%>"/>
       						<wtc:param value="<%=smparasetValue%>"/>
       							<wtc:param value="<%=productNum%>"/>
</wtc:service>
<wtc:array id="result4"  scope="end" />
<%
    vreturnMsg="4";
    if(Code4.equals("000000"))
    {  
		  vreturnCode="0";
		
    }

}else if("5".equals(tempflag))
 {
%>
	var response = new AJAXPacket();

<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="Code2" retmsg="Msg2">
		<wtc:param value="203908"/>
			<wtc:param value="<%=PospecNum%>"/>
       <wtc:param value="<%=productNum%>"/>
       	<wtc:param value="<%=vcharacternum%>"/>
</wtc:service>
<wtc:array id="result5"  scope="end" />

<%
	  vreturnMsg=Msg2;
    if(Code2.equals("000000"))
    {  
		  vreturnCode="0";
		
    }
}else if("6".equals(tempflag)){
%>
	var response = new AJAXPacket();

<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="Code2" retmsg="Msg2">
		<wtc:param value="203909"/>
			<wtc:param value="<%=code_th%>"/>
				<wtc:param value="<%=code_th%>"/>
					<wtc:param value="<%=code_th%>"/>
						<wtc:param value="<%=code_th%>"/>
			<wtc:param value="<%=PospecNum%>"/>
       <wtc:param value="<%=productNum%>"/>
       	<wtc:param value="<%=vcharacternum%>"/>
</wtc:service>
<wtc:array id="result6"  scope="end" />

<%
	  vreturnMsg=Msg2;
    if(Code2.equals("000000"))
    {  
		  vreturnCode="0";
		
    }
}else if("7".equals(tempflag)){
%>
	var response = new AJAXPacket();

<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="Code2" retmsg="Msg2">
		<wtc:param value="203910"/>
			<wtc:param value="<%=attr_code%>"/>
				<wtc:param value="<%=attr_code%>"/>
					<wtc:param value="<%=attr_code%>"/>
			<wtc:param value="<%=PospecNum%>"/>
       <wtc:param value="<%=productNum%>"/>
       	<wtc:param value="<%=vcharacternum%>"/>
</wtc:service>
<wtc:array id="result6"  scope="end" />

<%
	  vreturnMsg=Msg2;
    if(Code2.equals("000000"))
    {  
		  vreturnCode="0";
		
    }
}else
	{
%>

var response = new AJAXPacket();

<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="Code" retmsg="Msg">
		<wtc:param value="203901"/>
		<wtc:param value="<%=workNo%>"/>
       <wtc:param value="<%=PospecNum%>"/>
       <wtc:param value="<%=productNum%>"/>
       	<wtc:param value="<%=planCode%>"/>
       <wtc:param value="<%=ProductCode%>"/>
</wtc:service>
<wtc:array id="result"  scope="end" />
<%
	vreturnMsg=Msg;
  if(Code.equals("000000"))
  {  
		vreturnCode="0";
  }
}
%>

response.data.add("retFlag","<%=vreturnCode%>");
response.data.add("retType","<%=vreturnMsg%>"); 
response.data.add("v_id","<%=v_id%>"); 
response.data.add("fieldValue","<%=fieldValue%>"); 
response.data.add("fieldtxt","<%=fieldtxt%>"); 
response.data.add("code_th","<%=code_th%>");
core.ajax.receivePacket(response);


	
	
	
	
