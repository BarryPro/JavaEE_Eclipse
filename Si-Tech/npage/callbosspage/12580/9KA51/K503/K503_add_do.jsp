<%
  /*
   * 功能: 预定义短信界面树形数据生成页面
　 * 版本: 1.0.0
　 * 日期: 2009/01/15
　 * 作者: fengliang
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
String str = "select seq_12580.nextVal from dual";
%>


<wtc:service name="s151Select" outnum="1">
<wtc:param value="<%=str%>"/>
</wtc:service>
<wtc:array id="list" scope="end"/>
	
	<%
     String item_id = list[0][0];	
	%>

<%
							
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String contect_id = WtcUtil.repNull(request.getParameter("contect_id"));
	String is_leaf = WtcUtil.repNull(request.getParameter("is_leaf"));
	String item_name = WtcUtil.repNull(request.getParameter("item_name"));
	String isDefault = WtcUtil.repNull(request.getParameter("isDefault"));
	String isScore = WtcUtil.repNull(request.getParameter("isScore"));
	String parent_item_id = WtcUtil.repNull(request.getParameter("parent_item_id"));
	String crete_login_no = WtcUtil.repNull(request.getParameter("crete_login_no"));
	
	String sqla = "insert into DMESSAGEMODEL(msg_mod_id,Msg_Mod_Par_Id,Msg_Mod_Name,msg_leaf_flag,Create_Login_No,create_time,is_del)" 
               + " values('"+item_id+"','"+parent_item_id+"','"+item_name+"','Y','"+crete_login_no+"',sysdate,'N')";
  String sqlb = "update DMESSAGEMODEL set msg_leaf_flag = 'N' where msg_mod_id = '"+parent_item_id+"' and is_del= 'N' ";
  
  String sqlc = "select count(msg_mod_id) from DMESSAGEMODEL where trim(msg_mod_par_id) ='" + parent_item_id.trim()+"'  and is_del='N'";             
   
  String[] sqlStrs = null;
  
%>

<wtc:service name="sKFModify" outnum="3">
<wtc:param value="<%=str%>"/>
</wtc:service>
<wtc:array id="list" scope="end"/>
	
	<%
     item_id = list[0][0];	
	%>


<wtc:service name="sKFModify" outnum="3">
<wtc:param value="<%=sqlc%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
	<%
		int leafCount = 0;
		if(queryList.length>0){
				
	  		leafCount = Integer.parseInt(queryList[0][0]);
		}
%>	

<%
	if(leafCount == 0){
		sqlStrs = new String[]{sqla,sqlb};
	} else{
		sqlStrs = new String[]{sqla};
	}
	%>
	
	

<wtc:service name="sKFModify" outnum="3">
	<wtc:params value="<%=sqlStrs%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
response.data.add("item_id","<%=item_id%>");
core.ajax.receivePacket(response);

