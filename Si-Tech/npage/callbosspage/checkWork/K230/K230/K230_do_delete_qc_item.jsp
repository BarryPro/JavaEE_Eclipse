<%
  /*
   * 功能: 删除评测项
　 * 版本: 1.0.0
　 * 日期: 2008/11/09
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "删除评测项";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	System.out.println("############################################");

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String item_id = WtcUtil.repNull(request.getParameter("item_id"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String content_id = WtcUtil.repNull(request.getParameter("content_id"));
	String parentItem_id = WtcUtil.repNull(request.getParameter("parentItem_id"));
	System.out.println("parentItem_id:"+parentItem_id);
	//String sqlStr = "delete from dqccheckitem where trim(item_id) = '" + item_id + "'";
	String sqlStr = "update dqccheckitem set bak1='N' "+
					"where trim(item_id) = '" + item_id.trim() + "' and trim(object_id)='"+object_id.trim()+"' and trim(contect_id)='"+content_id.trim()+"'";
	String sqlStr2 = "select count(item_id) from dqccheckitem where trim(parent_item_id) ='" + parentItem_id.trim()+"' and trim(object_id)='"+object_id.trim()+"' and trim(contect_id)='"+content_id.trim() +"' and bak1='Y'";
  	String sqlStr1 = "update dqccheckitem set is_leaf='Y' where trim(item_id) = '" + parentItem_id.trim()+"' and trim(object_id)='"+object_id.trim()+"' and trim(contect_id)='"+content_id.trim() +"' and bak1='Y'" ; 
  	//System.out.println(sqlStr);
  String[] sqlStrs = null;
    System.out.println("############################################");
   
%>

<wtc:service name="s151Select" outnum="8">
<wtc:param value="<%=sqlStr2%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
		int leafCount = 0;
		if(queryList.length>0){
				
	  		leafCount = Integer.parseInt(queryList[0][0]);
	  		System.out.println("leafCount:"+leafCount);
		}
%>	
<%
	if(leafCount<=1&&!("0".equals(parentItem_id.trim()))){
		sqlStrs = new String[]{sqlStr,sqlStr1};
	} else{
		sqlStrs = new String[]{sqlStr};
	}
	%>

<wtc:service name="sPubModify" outnum="3">
	<wtc:params value="<%=sqlStrs%>"/>
	<wtc:param value="dbcall"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","000000");
response.data.add("retMsg","success");
response.data.add("leafCount","<%=leafCount%>");
response.data.add("parentItem_id","<%=parentItem_id%>");
core.ajax.receivePacket(response);

