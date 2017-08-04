<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String parentPhone = request.getParameter("parentPhone");
	
	String famCode = request.getParameter("famCode");
	String prodCode = request.getParameter("prodCode");
	String famRole = request.getParameter("famRole");
	String busiType = request.getParameter("busiType");
	String memRoleId = request.getParameter("memRoleId");
	System.out.println("gaopengSeeLoge2801111====getBusi.jsp-----[" + famCode + "|" + prodCode + "|" + famRole + "|" + memRoleId + "]");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String kdstyle="";
	
	String offerTitle = "";
	if("MO".equals(busiType)){
	System.out.println("gaopengSeeLoge2801111===aaaaaa");
		offerTitle = "主资费";
	}else if("AO".equals(busiType)){
		offerTitle = "可选资费";
	}
%>
		<wtc:service name="sFamSelCheck" routerKey="region" 
			 routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="9">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=parentPhone%>"/>
				<wtc:param value=""/>
				<wtc:param value="1"/>
				<wtc:param value="<%=famCode%>"/>
				<wtc:param value="<%=prodCode%>"/>
				<wtc:param value="<%=famRole%>"/>
				<wtc:param value="<%=memRoleId%>"/>
				<wtc:param value="<%=busiType%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
		System.out.println("----gaopengSeeLoge280-----getOfferContent.jsp--------" + retCode1);
		if("000000".equals(retCode1)){
			System.out.println("diling-----gaopengSeeLoge280----getOfferContent.jsp--------length=" + result.length);
			 if(busiType.equals("KD") || busiType.equals("WL") || busiType.equals("ZK")) {
				kdstyle="style='display:none'";
			}
			/*39元终端专属流量共享套餐 成员70054角色不展示可选资费*/
			if("ZSLL".equals(famCode) && "AO".equals(busiType) && "70054".equals(memRoleId)){
				kdstyle="style='display:none'";
			}
			
%>
<tr <%=kdstyle%>>
	<td class="blue"><%=offerTitle%></td>
	<td colspan="4">
		<%
			String styleStr = "";
			System.out.println("gaopengSeeLoge280=====================busiType:"+busiType);
			for(int i = 0; i < result.length; i++){
				for ( int j = 0 ; j < result[i].length ; j ++ )
				{
					System.out.println("----gaopengSeeLoge280---- offerComment --result["+i+"]["+j+"]---" + result[i][j] );
				}
			

				if("0".equals(result[i][2]) || "8".equals(result[i][2]) || "9".equals(result[i][2]) ){
					styleStr = "disabled";
				}
				if("CX".equals(busiType) || "ZK".equals(busiType)){
					styleStr = "style='display:none'";
				}
				/*39元终端专属流量共享套餐 不展示这两种资费信息*/
				if("403703".equals(result[i][0]) || "403704".equals(result[i][0])){
					styleStr = "style='display:none'";
				}

		%>
		<span>
			<input type="checkbox" id="complex_<%=busiType%>_<%=i%>" 
			 value="<%=result[i][1]%>" checked <%=styleStr%> />
			 <%
			 if("CX".equals(busiType)){
			 %>
			 	促销品赠送促销品&nbsp;&nbsp;
			 	<%
			 	}else if("ZK".equals(busiType)){
			 	%>
			 	
			 	<%
			}else if("403703".equals(result[i][0]) || "403704".equals(result[i][0])){
				%>
				
				<%
			 }else{
			 	%>
			 	<%=result[i][1]%>-<%=result[i][6]%>&nbsp;&nbsp;
			 	<%
			 }%>

			<input type="hidden" id="complex_busiid_<%=busiType%>_<%=i%>" value="<%=result[i][0]%>" />
			<input type="hidden" id="offerName_<%=busiType%>_<%=i%>" value="<%=result[i][6]%>" />
			<input type="hidden" id="offerComment_<%=busiType%>_<%=i%>" value="<%=result[i][7]%>" />
			<input type="hidden" id="action_<%=busiType%>_<%=i%>" value="<%=result[i][8]%>" />
			<input type="hidden" id="memssRoleId_<%=busiType%>_<%=i%>" value="<%=memRoleId%>" />
			
		</span>
		<%
			}
		%>
		
	</td>
</tr>
<%if("MO".equals(busiType)){%>
    <tr id="OfferAttribute2" ></tr><!--小区代码-->
    <input type="hidden" name="nowStatusUse" id="nowStatusUse" value="MO"/>
<%}%>
<%
	}
%>
<%if("MO".equals(busiType)){%>
	<input type="hidden" id="retCode_getOfferCon" name="retCode_getOfferCon" value="<%=retCode1%>" />
	<input type="hidden" id="retMsg_getOfferCon" name="retMsg_getOfferCon" value="<%=retMsg1%>" />
<%}%>

