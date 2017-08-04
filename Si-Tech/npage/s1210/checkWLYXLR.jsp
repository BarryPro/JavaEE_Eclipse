<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	      	String regionCode= (String)session.getAttribute("regCode");
	      	String simtypesz="ptlur";
	      	String sim_type_code = "";
	      	String id_no = request.getParameter("id_no");
	      	String simtypehao = request.getParameter("t_newsimf");
	      	String phoneNo = request.getParameter("phoneNo");
	      	String simOldNo = request.getParameter("simOldNo");
	      	String simNewNo = request.getParameter("simNewNo");
       		//增加网络优先客户sim类型判断20111213 wanghyd-----start
       	  String[] inParamsss = new String[2];
					inParamsss[0] = "select to_char(count(*)) from dBigPriNetMsg where id_no =:id_code";
					inParamsss[1] = "id_code="+id_no;
					
					String[] inParamsdd = new String[2];
					inParamsdd[0] = "select SIM_TYPE from DSIMRES where SIM_NO =:simtype_code";
					inParamsdd[1] = "simtype_code="+simtypehao;
					
					System.out.println("-------hejwa------------simtypehao------------>"+simtypehao);
					
					%>
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
					<wtc:param value="<%=inParamsss[0]%>"/>
					<wtc:param value="<%=inParamsss[1]%>"/>	
					</wtc:service>	
       	   <wtc:array id="simskehu" scope="end" />
       	   	<% 
       	   if(retCode1ss.equals("0") || retCode1ss.equals("000000")) {
       	   	if(!simskehu[0][0].equals("0")) {
       	   	 %>
       	  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1dd" retmsg="retMsg1dd" outnum="1">			
					<wtc:param value="<%=inParamsdd[0]%>"/>
					<wtc:param value="<%=inParamsdd[1]%>"/>	
					</wtc:service>	
       	   <wtc:array id="simstypes" scope="end" />
       	   	 <%
       	   if(retCode1dd.equals("0") || retCode1dd.equals("000000")) {
       	   	if(simstypes.length>0) {
       	   	if(!simstypes[0][0].equals("10056")) {
       	   	simtypesz="wlyxlr";
       	   	}
       	   	}
       	   	
       	    }
       	   	}
       	  else {
       	   simtypesz="ptlur";
       	  	}
       	   }
       	   %>


  			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1dd" retmsg="retMsg1dd" outnum="1">			
					<wtc:param value="<%=inParamsdd[0]%>"/>
					<wtc:param value="<%=inParamsdd[1]%>"/>	
				</wtc:service>	
       	<wtc:array id="simstypes" scope="end" />
       	   	 <%
       	   	if(simstypes.length>0) {
       	   			sim_type_code = simstypes[0][0];
       	    }
       	  
       	   %>
       	   
       	   
	var response = new AJAXPacket();

	response.data.add("simtypesz","<%=simtypesz%>");
	response.data.add("phoneNo","<%=phoneNo%>");
	response.data.add("simOldNo","<%=simOldNo%>");
	response.data.add("simNewNo","<%=simNewNo%>");
	response.data.add("sim_type_code","<%=sim_type_code%>");
	response.data.add("snnn","0");
	core.ajax.receivePacket(response);