<%
  /*
   * 功能: 查询一个帐号
　 * 版本: 2.0
　 * 日期: 2007-07-05 16:12
　 * 作者: wangxz
　 * 版权: sitech
　*/
%> 
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page contentType="text/html;charset=GB2312"%>
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
	String prefix2=request.getParameter("prefix2");
	String suffix2=request.getParameter("suffix2");
	String order_id=request.getParameter("order_id");
	String conn_flag=request.getParameter("conn_flag");
	String branch_no=request.getParameter("branch_no");
	String prod_id=request.getParameter("prod_id");
	String staff_id=request.getParameter("staff_id");
	String svc_inst_id=request.getParameter("svc_inst_id");
	String[][] result = null;  //

	System.out.println("随机获取一个帐号= ");	
	System.out.println("account= "+account);
	System.out.println("prefix= "+prefix1);
	System.out.println("suffix= "+suffix);
	System.out.println("city_id= "+city_id);
	System.out.println("flag= "+flag);
	System.out.println("site_id= "+site_id);
	System.out.println("purpose= "+purpose);
	System.out.println("conn_flag= "+conn_flag);
	System.out.println("order_id= "+order_id);
	String strArray="var arrMsg; ";
	System.out.println("the purpose is  "+purpose);	
%>
<wtc:service name="RBM_kd_xh01" outnum="3">
	<wtc:param value="<%=account%>"/>
	<wtc:param value="<%= prefix1 %>"/>
	<wtc:param value="<%=suffix%>"/>
	<wtc:param value= "<%= branch_no%>" />
	<wtc:param value= "<%= prod_id %>" />
	<wtc:param value= "<%= staff_id%>"/>
	<wtc:param value="<%=city_id%>"/>
	<wtc:param value="<%=flag%>"/>
	<wtc:param value="<%=site_id%>"/>
	<wtc:param value="<%=purpose%>"/>
	<wtc:param value="<%=order_id%>"/>
	<wtc:param value="<%=conn_flag%>"/>
	<wtc:param value="<%=prefix2%>"/>
	<wtc:param value="<%=suffix2%>"/>	
	<wtc:param value="<%=svc_inst_id%>"/>		
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
<%
	for(int i = 0 ; i < result.length; i ++)
	{
		for(int j = 0 ; j < result[i].length ; j ++)
		{
			if(result[i][j] == null||result[i][j].trim().equals(""))
			{
				result[i][j] = "";
			}
			%>
			arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
			<%
		}
	}
}	
else
{%>
	<%=strArray%>
    <%
    errorCode=retCode;
	errorMsg =retMsg;
}%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("rowNum","<%=rowNum%>");
response.data.add("selonerow",arrMsg);
response.data.add("retCode","<%=errorCode%>");
response.data.add("retMessage","<%= errorMsg %>");
core.ajax.receivePacket(response);