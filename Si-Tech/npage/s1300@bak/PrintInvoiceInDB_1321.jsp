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
	
	// xl add 发票号码 新的出参
	String fphm_new="";

	//liuxmc @2011-7-26 发票电子化添加入库服务

		String[] inParas0 = new String[26];
		
		for(int i=0;i<inParas0.length;i++){
			inParas0[i] = request.getParameter("inPut"+i);
			System.out.println("FFFFFFFFFFFFFFFFFFF inParas0[i] is "+inParas0);
		}
		String inPutNew = request.getParameter("inPutNew");
		String out_result3 = request.getParameter("out_result3");
		String out_result6 = request.getParameter("out_result6");
		
		 
		int str_count=0;
		for(int j=0;j<inParas0.length;j++){
			if(inParas0[j] != null){
				str_count++;
			}
		}
		
		
%>		
		<wtc:service name="s1300PrintInDB" outnum="3" >
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
			fphm_new=RetResult[0][2];
			}
		}
	    System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA "+re_code+" and fphm_new is "+fphm_new);
%>
		
		var response = new AJAXPacket();
		
		var res = "<%=re_code%>";
		var inPutNew = "<%=inPutNew%>";
		var out_result3 = "<%=out_result3%>";
		var out_result6 = "<%=out_result6%>";
		var fphm_new = "<%=fphm_new%>";
		response.data.add("result", res);
		response.data.add("inPutNew", inPutNew);
		response.data.add("out_result3", out_result3);
		response.data.add("out_result6", out_result6);
		response.data.add("fphm_new", fphm_new);
		core.ajax.receivePacket(response);
