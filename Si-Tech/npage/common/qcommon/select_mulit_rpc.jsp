<%
  /*
   * 功能: 多列查询
　 * 版本: 2.0
　 * 日期: 2007-07-05 16:12
　 * 作者: wangxz
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
	String sqlStr =request.getParameter("sqlStr");
	String[][] mulit_list = null;  //
	
	String strArray="var arrMsg; ";
	System.out.println("----- "+sqlStr);//打印查询语句到控制台
%>


	<wtc:pubselect name="sPubSelect" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
<%
System.out.println("==================--------------============="+retCode);
	if(retCode.equals("000000"))
	{
%>
	<wtc:array id="rows">
	<%	  
		mulit_list =rows;		    
	%>
	</wtc:array>
<%
		if(mulit_list==null)
		{
			valid = 1;
			errorCode="444444";	
		}
	   else
		{
		  rowNum=mulit_list.length;
		  if(rowNum==0)
		  {
        	valid = 2;
			errorCode="222222";	
        	errorMsg = "没有找到用户信息";		    
		  }
		 else
		  {
        	valid = 0;
            errorCode="000000";		  
            strArray = CreatePlanerArray.createArray("arrMsg",mulit_list.length);		    
		  }
		
		}

   
%>

<%=strArray%>

<%
	for(int i = 0 ; i < mulit_list.length; i ++)
	{
	     for(int j = 0 ; j < mulit_list[i].length ; j ++)
	     {
				if(mulit_list[i][j].trim().equals("") || mulit_list[i][j] == null)
				{
					mulit_list[i][j] = "";
	            }
				%>
				arrMsg[<%=i%>][<%=j%>] = "<%=mulit_list[i][j].trim()%>";
				<%
		  }
	}
  }	
  else
  {
    errorCode=retCode;
   }	
%>


var response = new AJAXPacket();

response.data.add("retType","<%=retType%>");
response.data.add("rowNum","<%=rowNum%>");
response.data.add("mulit_list",arrMsg);
response.data.add("retCode",'<%=errorCode%>');
response.data.add("retMessage","<%= errorMsg %>");
core.ajax.receivePacket(response);