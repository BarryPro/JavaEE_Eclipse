<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String themePath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
    String workNo = (String)session.getAttribute("workNo");
    String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);

		String opCode = request.getParameter("opCode")==null?"":request.getParameter("opCode").trim();

		String sql = "select '['||trim(b.op_code)||']'||trim(c.function_name) function_name,a.step_seq||'¡¢'||a.step_name step from dbusiguidetemp a,dbusiguidemsg b,sfunccodenew c where a.template_id=b.template_id and b.op_code=c.function_code and b.op_code=:opCode and b.is_effect='1' order by a.step_seq ";
		String param = "opCode="+opCode;
	
	
		System.out.println(sql);
		System.out.println(param);
%>
<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
	<wtc:param value="<%=sql%>" />
	<wtc:param value="<%=param%>" />
</wtc:service>
<wtc:array id="stepList" scope="end"/>		
<%
		if("000000".equals(retCode)){
			if(stepList.length>0){
				%>
			<div id="busiguide_<%=opCode%>" style="margin-top:12px;font-size:12px;color:#003488;font-weight:bold;width:150px">				
				<div id="title">
					<img src="<%=request.getContextPath()%>/nresources/<%=themePath%>/images/arrow_left.gif" /><%=stepList[0][0]%>
				</div>
				<div id="step_<%=opCode%>" class="step">
				<%
				for(int i=0;i<stepList.length;i++){
					if(i==0){
					%>
						<div id="step_1" class="running" title="<%=stepList[i][1]%>"><img src="<%=request.getContextPath()%>/nresources/<%=themePath%>/images/icon_nav.gif"/><%=stepList[i][1]%></div>
					<%
					}else{
					%>
						<div id="step_<%=(i+1)%>" class="fresh" title="<%=stepList[i][1]%>"><img src="<%=request.getContextPath()%>/nresources/<%=themePath%>/images/arrow_link_blue.gif"/><%=stepList[i][1]%></div>
					<%
					}
				}
				%>
				</div>	
		</div>
	<%
		}
	}
	%>