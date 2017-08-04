<%
/********************
 *开发商: si-tech
 *create by wanghfa @ 20110725
 ********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	request.setCharacterEncoding("GBK");
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String numCountStr = request.getParameter("numCount");
	System.out.println("--------liujian------numCountStr=" + numCountStr);
	int numCount = 0;
	if(numCountStr != null && !numCountStr.equals("")) {
		numCount = Integer.parseInt(numCountStr);
	}
	String bxy = request.getParameter("bxy");
	String[] inParams = new String[40];
	String retCode = "";
	 String broad_no = request.getParameter("inParams15"); 
	 String serviceName = "e005PrintInDB";
	 if(broad_no.indexOf("yd")==0){ //判断前两位是否为yd 如果为yd 走移动发票入库 
	 	serviceName = "s1300PrintInDB";
	}else{
		serviceName = "e005PrintInDB";
	}
	
%>
	<wtc:service name="<%=serviceName%>" routerKey="region" routerValue="<%=regionCode%>" 
			retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<%
		for (int i = 0; i < 19; i ++) {
			inParams[i] = request.getParameter("inParams" + i);
			%>
				<wtc:param value="<%=inParams[i]%>"/>
			<%
		}
		for(int i=0;i<numCount;i++) {
			%>
				<wtc:param value="<%=inParams[19+i]%>"/>
			<%
		}
		if(bxy != null && bxy.equals("bxy")) {
			for(int i=0;i<12;i++) {
			%>
				<wtc:param value="<%=inParams[26+i]%>"/>
			<%	
			}
		}
	%>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
	
	var response = new AJAXPacket();
	response.data.add("retCode", "<%=retCode1%>");
	response.data.add("retMsg", "<%=retMsg1%>");
	core.ajax.receivePacket(response);
