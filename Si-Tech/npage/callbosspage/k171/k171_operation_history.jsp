<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>

<%
   	String retCode="000000";
   	String operation_id = request.getParameter("operation_id")==null?"":request.getParameter("operation_id");
   	String contactId = request.getParameter("contactId")==null?"":request.getParameter("contactId");
   	String loginNo = request.getParameter("loginNo")==null?"":request.getParameter("loginNo");
   	String flag = request.getParameter("flag")==null?"":request.getParameter("flag");
   	String tablename = request.getParameter("tablename")==null?"":request.getParameter("tablename");
   	int count = 0;
   	Map pMap = new HashMap();
   	pMap.put("flag",flag);
   	pMap.put("contactId",contactId);
   	pMap.put("operation_id",operation_id);
   	pMap.put("tablename",tablename);
   	try{
   			count = ((Integer)KFEjbClient.queryForObject("select_k171_operation_count",pMap)).intValue();
   		}catch(Exception e){
   			new Exception("查询三维一体操作历史记录信息出现错误",e).printStackTrace();
	   		retCode = "999999";
   	}
   	if(count == 0){
	   	  pMap.put("loginNo",loginNo);
	   		
	   		try{
	   			KFEjbClient.insert("insert_k171_operation_history",pMap);
	   		}catch(Exception e){
	   			new Exception("记录三维一体操作历史记录信息出现错误",e).printStackTrace();
	   			retCode = "999999";
	   		}
   	}else{
   		try{
	   			KFEjbClient.update("update_k171_operation_history",pMap);
	   		}catch(Exception e){
	   			new Exception("更新三维一体操作历史记录信息出现错误",e).printStackTrace();
	   			retCode = "999999";
	   	}	
   	}
%>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);