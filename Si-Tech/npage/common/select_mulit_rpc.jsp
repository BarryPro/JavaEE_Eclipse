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
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
   
<%
    int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
    int rowNum=0;   //���ص�����
    String errorCode="444444";
    String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";        
		String retType=request.getParameter("retType");
		String sqlStr =request.getParameter("sqlStr");
		String outNum1 = request.getParameter("outNum");
		String[][] mulit_list = null;  
	
	String strArray="var arrMsg; ";
	System.out.println("$$$$$$$$$$$$--->" + (String)request.getRequestURI() + ":" +sqlStr);//��ӡ��ѯ��䵽����̨
%>


	<wtc:pubselect name="sPubSelect" outnum="<%=outNum1%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
<%
	if(retCode.equals("000000"))
	{
%>
	<wtc:array id="rows" scope="end" />
<%	  
		mulit_list =rows;		    
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
	        	errorCode="1403";
	        	errorMsg = "û���ҵ���Ϣ";		    
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
		if(valid==0)
		{
				int msize = mulit_list.length;
				for(int i = 0 ; i < msize; i ++)
				{
						int misize = mulit_list[i].length;
				     for(int j = 0 ; j < misize ; j ++)
				     {
								if(mulit_list[i][j] == null || mulit_list[i][j].trim().equals(""))
								{
									mulit_list[i][j] = "";
					      }
%>
								 arrMsg[<%=i%>][<%=j%>] = '<%=mulit_list[i][j].replaceAll("\\\"","��").trim()%>';
<%
					   }
				 }
		 }
		  
 }	
else
  {
    errorCode=retCode;
    errorMsg=retMsg;
  }	
%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("rowNum","<%=rowNum%>");
response.data.add("mulit_list",arrMsg);
response.data.add("retCode",'<%=errorCode%>');
response.data.add("retMessage","<%= errorMsg %>");
response.data.add("retMsg","<%= errorMsg %>");
core.ajax.receivePacket(response);