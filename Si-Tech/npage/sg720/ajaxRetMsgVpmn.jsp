<%
    /********************
     version v2.0
     ������: si-tech
     *
     *wangzc:@2010-06-10 
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
System.out.println("--------------------ajaxRetMsg1.jsp-------------------");
		String return_code = "000000";
		String org_code = (String) session.getAttribute("orgCode");
		String errMsg="";
		String strPhoneNo =request.getParameter("phone_no");
		String loginNo = (String)session.getAttribute("workNo");
		String loginPwd = (String)session.getAttribute("password");
		String opCode =request.getParameter("opCode");
		String servId =request.getParameter("servId");
		String iChnSource = "01";
		
		
		String regionCode = (String)session.getAttribute("regCode");
		 

		System.out.println("--------------------strPhoneNo-------------------"+strPhoneNo);
		System.out.println("strPhoneNo="+strPhoneNo);
%>
 /**************wangzc ���� ��ʾ�û��Ƿ���������VPMN�û����Ƿ���Ҫ�������������******************/

		 	<wtc:service name="sVpmnQry" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="1" >
			<wtc:param value="" />
			<wtc:param value="<%=iChnSource%>" />	
			<wtc:param value="<%=opCode%>" />		
			<wtc:param value="<%=loginNo%>" />			
			<wtc:param value="<%=loginPwd%>" />				
			<wtc:param value="<%=strPhoneNo%>" />					
			<wtc:param value="" />
			
			</wtc:service>
			<wtc:array id="offnodataArray1" scope="end"/>
<%				
	String vpmnstr1="";
 System.out.println("----------------retCode-----------------"+retCode);
       if(!retCode.equals("000000")){
    	
    		vpmnstr1="NO";
    	}
    	else
    	{
    		 if(offnodataArray1[0][0].equals("000000")){
		    	vpmnstr1="YES";
		    }  
    	}
	  System.out.println("-----------------vpmnstr1--------------"+vpmnstr1);
%>
 
 /**************wangzc ���� ��ʾ�û��Ƿ���������VPMN�û����Ƿ���Ҫ������������� end******************/
			var response = new AJAXPacket();
			var vpmnstr1="<%=vpmnstr1%>";
			response.data.add("vpmnstr1",vpmnstr1);
			core.ajax.receivePacket(response);


 

