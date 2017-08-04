<%
  /*
   * 功能: 查询后缀
　 * 版本: 2.0
　 * 日期: 2007-07-05 16:12
　 * 作者: zhanghb
　 * 版权: sitech
　*/
%> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
   
<%
    int valid = 1;	//0:正确，1：系统错误，2：业务错误
    int rowNum=0;   //返回的行数
	String errorCode1="444444";
    String errorMsg1="系统错误，请与系统管理员联系，谢谢!!";  
    String errorCode2="444444";
    String errorMsg2="系统错误，请与系统管理员联系，谢谢!!";        
	String retType=request.getParameter("retType");
	String sqlStr =request.getParameter("sqlStr");
	String account =request.getParameter("account");
	String city_id =request.getParameter("city_id");
	String work_form_id =request.getParameter("work_form_id");
	String conn_flag =request.getParameter("conn_flag");
	String svc_inst_id =request.getParameter("svc_inst_id");
	String[][] mulit_list = null;  //
	
	String strArray="var arrMsg; ";
	System.out.println("----- "+sqlStr);//打印查询语句到控制台
	System.out.println("account----- "+account);
	System.out.println("city_id----- "+city_id);
	System.out.println("work_form_id----- "+work_form_id);
	System.out.println("svc_inst_id----- "+svc_inst_id);
	System.out.println("conn_flag----- "+conn_flag);
%>
<wtc:service name="kd0102" outnum="0">
	<wtc:param value="<%=account%>"/>
	<wtc:param value="<%= city_id %>"/>
	<wtc:param value="<%=work_form_id%>"/>
	<wtc:param value="<%=svc_inst_id%>"/>
	<wtc:param value="<%=conn_flag%>"/>
</wtc:service>
<%
	errorCode1=retCode;
	errorMsg1=retMsg;	
%>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<%if(retCode.equals("000000"))
{
%>
	<wtc:array id="rows">
		<%mulit_list =rows;%>
	</wtc:array>
<%
	if(mulit_list==null)
	{
		valid = 1;
	}
	else
	{
		rowNum=mulit_list.length;
		if(rowNum==0)
		{
		valid = 2;
		errorMsg2 = "没有找到用户信息";		    
	}
		else
		{
			valid = 0;
			errorCode2="000000";		  
			strArray = CreatePlanerArray.createArray("arrMsg",mulit_list.length);		    
		}
	}%>
	<%=strArray%>
<%  for(int i = 0 ; i < mulit_list.length; i ++)
	{
		for(int j = 0 ; j < mulit_list[i].length ; j ++)
	    {
	    	if( mulit_list[i][j] == null||mulit_list[i][j].trim().equals(""))
			{
				mulit_list[i][j] = "";
	        }%>
			arrMsg[<%=i%>][<%=j%>] = "<%=mulit_list[i][j].trim()%>";
		<%}
	}
}	
else
{
	errorCode2=retCode;
	errorMsg2=retMsg;
}%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("rowNum","<%=rowNum%>");
response.data.add("mulit_list",arrMsg);
response.data.add("retCode1",'<%=errorCode1%>');
response.data.add("retMessage1","<%= errorMsg1 %>");
response.data.add("retCode2",'<%=errorCode2%>');
response.data.add("retMessage2","<%= errorMsg2 %>");
core.ajax.receivePacket(response);