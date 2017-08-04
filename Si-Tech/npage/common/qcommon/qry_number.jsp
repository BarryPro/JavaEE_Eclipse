<%
  /*
   * 功能:查询帐号
　 * 版本: 2.0
　 * 日期: 2007-07-05 16:12
　 * 作者: zhanghb
　 * 版权: sitech
　*/
%> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    int valid = 1;	//0:正确，1：系统错误，2：业务错误
    int rowNum=0;   //返回的行数
    String errorCode="444444";
    String errorMsg="系统错误，请与系统管理员联系，谢谢!!";        
	String retType=request.getParameter("retType");
	String account=request.getParameter("account");
	String prefix1=request.getParameter("prefix");
	String suffix=request.getParameter("suffix");
	String city_id=request.getParameter("city_id");
	String flag=request.getParameter("flag");
	String purpose=request.getParameter("purpose");
	String site_id=request.getParameter("site_id");
	String NUM =request.getParameter("NUM");
	String conn_flag =request.getParameter("conn_flag");
	String staff_id =request.getParameter("staff_id");
	String prod_id =request.getParameter("prod_id");
	String branch_no =request.getParameter("branch_no");
	String work_form_id =request.getParameter("work_form_id");
	String oldprefix =request.getParameter("oldprefix");
	String oldsuffix =request.getParameter("oldsuffix");
	String[][] result = null;
		System.out.println("NUM= "+NUM);
	System.out.println("oldprefix= "+oldprefix);
	System.out.println("oldsuffix= "+oldsuffix);
	System.out.println("prod_id= "+prod_id);
	System.out.println("staff_id= "+staff_id);
	System.out.println("city_id= "+city_id);
	System.out.println("flag= "+flag);
	System.out.println("site_id= "+site_id);
	System.out.println("purpose= "+purpose);
	System.out.println("work_form_id= "+work_form_id);
	System.out.println("conn_flag= "+conn_flag);
	System.out.println("prefix1= "+prefix1);
	System.out.println("suffix= "+suffix);
	String strArray="var arrMsg; ";	
%>
<wtc:service name="RBM_kd_xh01" outnum="3">
	<wtc:param value="<%=NUM%>"/>
	<wtc:param value="<%= oldprefix %>"/>
	<wtc:param value="<%=oldsuffix%>"/>
	<wtc:param value= "<%= branch_no%>" />
	<wtc:param value= "<%= prod_id %>" />
	<wtc:param value= "<%=staff_id%>"/>
	<wtc:param value="<%=city_id%>"/>
	<wtc:param value="<%=flag%>"/>
	<wtc:param value="<%=site_id%>"/>
	<wtc:param value="<%=purpose%>"/>
	<wtc:param value="<%=work_form_id%>"/>
	<wtc:param value="<%=conn_flag%>"/>
	<wtc:param value="<%=prefix1%>"/>
	<wtc:param value="<%=suffix%>"/>	
</wtc:service>
<%
System.out.println("\n call service RBM_kd_xh01 ,retCode =  " + retCode +", retMsg = "+ retMsg +"\n");	
if(retCode.equals("000000"))
{
%>
    <wtc:array id="rows">
 	  	<%result = rows;%>	
 	</wtc:array>
<%
	if(result==null)
	{
		valid = 1;
	}
	else
	{
		rowNum=result.length;
		if(rowNum==0)
		{
		valid = 2;
		errorMsg = "没有找到用户信息";		    
	}
	else
	{
		valid = 0;
		errorCode="000000";		  
		strArray = CreatePlanerArray.createArray("arrMsg",result.length);		    
	}
}%>
<%=strArray%>
<%  for(int i = 0 ; i < result.length; i ++)
	{
		for(int j = 0 ; j < result[i].length ; j ++)
		{
			if(result[i][j] == null || result[i][j].trim().equals(""))
			{
				result[i][j] = "";
			}%>
		arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
		<%}
	}
}	
else
{%>
  <%=strArray%>
  <%errorCode=retCode;
	errorMsg=retMsg;
}%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("rowNum","<%=rowNum%>");
response.data.add("mulit_list",arrMsg);
response.data.add("retCode","<%=errorCode%>");
response.data.add("retMessage","<%= errorMsg %>");
core.ajax.receivePacket(response);