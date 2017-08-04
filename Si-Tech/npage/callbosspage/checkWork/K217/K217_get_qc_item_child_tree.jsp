<%
  /*
   * 功能: 质考评项树
　 * 版本: 1.0.0
　 * 日期: 2008/12/20
　 * 作者: hanjc
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
	String object_id      = request.getParameter("object_id");
	String content_id     = request.getParameter("content_id");
	String parent_item_id = request.getParameter("parent_item_id");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams="";
	String sqlStr="select t.item_id, t.parent_item_id, t.item_name, t.is_leaf " +
	              "from dqccheckitem t " +
	              "where t.parent_item_id='0' and object_id = :object_id and contect_id = :content_id and bak1='Y'" +
	              "order by t.item_id";
	myParams = "object_id="+object_id+",content_id="+content_id;
	        
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="4">
			<wtc:param value="<%=sqlStr%>"/>
			<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="resultList" start="0" length="4" >
		
	var worknos = new Array();
<%
	for(int i = 0; i < resultList.length; i++){
%>
    	var tmpArr = new Array();
<%
			for(int j = 0; j < resultList[i].length; j++){
%>
					tmpArr[<%=j%>] = '<%=resultList[i][j]%>';
<%
			}
%>
			worknos[<%=i%>] = tmpArr;
<%
	}
%>

	var response = new AJAXPacket();
	response.data.add("worknos",worknos);
	response.data.add("nodeId","<%=parent_item_id%>");
	core.ajax.receivePacket(response);

	</wtc:array>
