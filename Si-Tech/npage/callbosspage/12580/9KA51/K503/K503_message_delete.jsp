<%
  /*
   * ����: Ԥ������Ž���������������ҳ��
�� * �汾: 1.0.0
�� * ����: 2009/01/15
�� * ����: fengliang
�� * ��Ȩ: sitech
   * update:
�� */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String item_id = WtcUtil.repNull(request.getParameter("item_id"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String content_id = WtcUtil.repNull(request.getParameter("content_id"));
	String parentItem_id = WtcUtil.repNull(request.getParameter("parentItem_id"));

	String sqlStr = "update DMESSAGEMODEL set is_del='Y' "+
					"where trim(msg_mod_id) = '" + item_id.trim() + "'";
					
	String sqlStr2 = "select count(msg_mod_id) from DMESSAGEMODEL where trim(msg_mod_par_id) ='" + parentItem_id.trim()+"'  and is_del='N'";
	
  	String sqlStr1 = "update DMESSAGEMODEL set msg_leaf_flag='Y' where trim(msg_mod_id) = '" + parentItem_id.trim()+"' and is_del='N'" ; 
  	
  String[] sqlStrs = null;
   
%>

<wtc:service name="s151Select" outnum="8">
<wtc:param value="<%=sqlStr2%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
		int leafCount = 0;
		if(queryList.length>0){
				
	  		leafCount = Integer.parseInt(queryList[0][0]);
		}
%>	
<%
	if(leafCount<=1&&!("0".equals(parentItem_id.trim()))){
		sqlStrs = new String[]{sqlStr,sqlStr1};
	} else{
		sqlStrs = new String[]{sqlStr};
	}
	%>

<wtc:service name="sKFModify" outnum="3">
	<wtc:params value="<%=sqlStrs%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","000000");
response.data.add("retMsg","success");
response.data.add("leafCount","<%=leafCount%>");
response.data.add("parentItem_id","<%=parentItem_id%>");
core.ajax.receivePacket(response);

