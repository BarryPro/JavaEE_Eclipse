<%
  /*
   * ����: ���в�ѯ
�� * �汾: 2.0
�� * ����: 2007-07-05 16:12
�� * ����: wangxz
�� * ��Ȩ: sitech
��*/
%> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

   
<%
    int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
    int rowNum=0;   //���ص�����
    String errorCode="444444";
    String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";        
	String retType=request.getParameter("retType");
	String sqlStr =request.getParameter("sqlStr");
	String[][] mulit_list = null;  //
	
	String strArray="var arrMsg; ";
	System.out.println("----- "+sqlStr);//��ӡ��ѯ��䵽����̨
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
        	errorMsg = "û���ҵ��û���Ϣ";		    
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