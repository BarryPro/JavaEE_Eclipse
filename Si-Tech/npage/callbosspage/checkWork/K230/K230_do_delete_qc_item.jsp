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
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams="";
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String item_id = WtcUtil.repNull(request.getParameter("item_id"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String content_id = WtcUtil.repNull(request.getParameter("content_id"));
	String parentItem_id = WtcUtil.repNull(request.getParameter("parentItem_id"));
	System.out.println("parentItem_id:"+parentItem_id);
	//String sqlStr = "delete from dqccheckitem where trim(item_id) = '" + item_id + "'";
	
	String sqlStr = "update dqccheckitem set bak1='N' "+
					"where trim(item_id) = :v1 and trim(object_id)= :v2 and trim(contect_id)= :v3 &&"+item_id.trim()+"^"+object_id.trim()+"^"+content_id.trim();
					
	String sqlStr1 = "update dqccheckitem set is_leaf='Y' where trim(item_id) = :v1 and trim(object_id)= :v2 and trim(contect_id)= :v3 and bak1='Y'&&"+parentItem_id.trim()+"^"+object_id.trim()+"^"+content_id.trim() ;
				
	String sqlStr2 = "select to_char(count(item_id)) from dqccheckitem where trim(parent_item_id) = :parentItem_id and trim(object_id)=:object_id and trim(contect_id)=:content_id and bak1='Y'";
 
  myParams = "parentItem_id="+parentItem_id.trim()+",object_id="+object_id.trim()+",content_id="+content_id.trim();
  
  String[] sqlStrs = null;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
	<wtc:param value="<%=sqlStr2%>"/>
	<wtc:param value="<%=myParams%>"/>
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
	//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
	%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlStrs%>"/>
</wtc:service>


var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","000000");
response.data.add("retMsg","success");
response.data.add("leafCount","<%=leafCount%>");
response.data.add("parentItem_id","<%=parentItem_id%>");
core.ajax.receivePacket(response);

