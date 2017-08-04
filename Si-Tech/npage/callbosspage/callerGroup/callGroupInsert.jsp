<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String Region_Code = WtcUtil.repNull(request.getParameter("Region_Code"));
    String phone = WtcUtil.repNull(request.getParameter("phone"));
    String Classid = WtcUtil.repNull(request.getParameter("Classid"));
    String outflag = WtcUtil.repNull(request.getParameter("outflag"));
    String note = WtcUtil.repNull(request.getParameter("note"));
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
	
		String sql= " INSERT INTO Dcallercalloutphone(caller_call_out_id,Region_Code,caller_call_out_phone,note,Classid,outflag) " 
		+ " VALUES(seq_call_phone.nextval,:v1,:v2,:v3,:v4,:v5) ";
%>
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="dbchange"/>
			<wtc:param value="<%=Region_Code%>"/>
			<wtc:param value="<%=phone%>"/>
			<wtc:param value="<%=note%>"/>
			<wtc:param value="<%=Classid%>"/>
			<wtc:param value="<%=outflag%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "±£´æ¹ØÏµÊ§°Ü";
	  }
	%>


	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);




