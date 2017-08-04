<% 
/********************
 version v2.0
开发商: si-tech
*
*create: liuxmc@2011-07-26
*
********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	
	//liuxmc @2011-7-26 发票电子化添加入库服务

		String[] inParas0 = new String[26];
		
		for(int i=0;i<inParas0.length;i++){
			inParas0[i] = request.getParameter("inPut"+i);
		}
		int str_count=0;
		for(int j=0;j<inParas0.length;j++){
			if(inParas0[j] != null){
				str_count++;
			}
		}
		
%>		
		<wtc:service name="s1300PrintInDB" outnum="2" >
<%
			for(int k=0;k < str_count;k++){
%>
			<wtc:param value="<%=inParas0[k]%>"/>
<%
			}
%>
		</wtc:service>
		<wtc:array id="RetResult" scope="end"/>
		
<%
		String re_code="1";
		String result2[][];
		if(RetResult == null || RetResult.length == 0 ){
			
		}else if(RetResult.length > 0){
			result2 = RetResult;
			if((result2[0][0]!="000000")&&(!result2[0][0].equals("000000")))
			{
			}
		  else{
			re_code=RetResult[0][0];
			}
		}
	    System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA "+re_code);
%>
		
		var response = new AJAXPacket();
		
		var res = "<%=re_code%>";
		response.data.add("result", res);
		core.ajax.receivePacket(response);
