<%@ page contentType="text/html;charset=GBK"%><%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String parNode = (request.getParameter("parNode") != null ? request.getParameter("parNode") : "");
%>
<wtc:service name="sKF280Select" outnum="3">
			<wtc:param value="<%=parNode%>" />
		</wtc:service>
<wtc:array id="rows" scope="end" />
<%
//增加新被检组成功ajax返回参数.
%>
{data:[
<%//这个是数据内容.
out.print("'"+rows[0][0]+"',");
out.print("'"+rows[0][1]+"',");
out.print("'"+rows[0][2]+"'");
%>
]}