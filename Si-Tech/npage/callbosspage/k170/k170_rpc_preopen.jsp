<%
  /*
   * 功能: 来电原因填写->原因树的数据
　 * 版本: 1.0.0
　 * 日期: 2009/4/22
　 * 作者: jiangbing
　 * 功能说明: 支持预先打开模式
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/callbosspage/k170/k170_rpc_method.jsp" %>

<%
 response.setHeader("Pragma","No-cache"); 
 response.setHeader("Cache-Control","no-cache"); 
 response.setDateHeader("Expires", 0);
 String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
 if(nodeId==null){
 		nodeId = "";
 }
 int nodelength = nodeId.length();
 String nodeLevel = WtcUtil.repNull(request.getParameter("nodeLevel"));
 nodeLevel = new Integer(Integer.parseInt(nodeLevel)+1).toString();
 String lastChildRoute = WtcUtil.repNull(request.getParameter("lastChildRoute"));
 if(lastChildRoute==null){
 		lastChildRoute = "";
 }
 String gobal_check_str = WtcUtil.repNull(request.getParameter("gobal_check_str"));
 String preopen = WtcUtil.repNull(request.getParameter("preopen"));
 if(preopen==null){
 		preopen = "";
 }
 String param1 = WtcUtil.repNull(request.getParameter("param1"));
 if(param1==null){
 		param1 = "";
 }
 String param2 = WtcUtil.repNull(request.getParameter("param2"));
 if(param2==null){
 		param2 = "";
 }

 boolean flag = false;

 String hasSelectOption = WtcUtil.repNull(request.getParameter("hasSelectOption"));
 String condition = "";
 if(preopen.equals("")||preopen.equals("0")){
 		condition = " and t.super_id='"+nodeId+"' ";
 }else if(preopen.equals("1")){
 		condition = " and t.callcause_id like '"+nodeId+"%' and length(t.callcause_id)>"+nodelength+" ";
 		if(!param1.equals("")){
 		    int maxlength = nodelength + 3*Integer.parseInt(param1);	    /*modify wangyongjl 20090818 将原有2长度修改为3*/
 				condition = condition+ " and  length(t.callcause_id)<="+maxlength+" ";
 		}
 }else if(preopen.equals("2")){  
 	  int begin = nodeId.length(); 
 	  int end = param2.length(); 
 		String orCondition = "";
 		if(begin==1){ 
 			 begin = 0;
 		}
 		boolean befirst = true;
 		for(;begin<end;begin=begin+3){ /*modify wangyongjl 20090818 将原有2长度修改为3*/
 		  if(!befirst){
 		  		orCondition = orCondition+" or ";
 		  }else{
 		  	befirst = false;
 		  }
 		  orCondition = orCondition+"(";
 		  int thisLength = begin+3; /*modify wangyongjl 20090818 将原有2长度修改为3*/
 		  orCondition = orCondition+"length(t.callcause_id)="+thisLength;		
 			if(begin==0){
 					orCondition = orCondition+" and t.super_id = '0'";				
 			}else{
 					orCondition = orCondition+" and t.super_id = '"+param2.substring(0,begin)+"'";	
 			}
 			orCondition = orCondition+")";
 		}
 		condition = " and t.callcause_id like '"+nodeId+"%' and length(t.callcause_id)>"+nodelength+" and ("+orCondition +") ";
 		if(!param1.equals("")){
 		    int maxlength = nodelength + 3*Integer.parseInt(param1);	    /*modify wangyongjl 20090818 将原有2长度修改为3*/
 				condition = condition+ " and  length(t.callcause_id)<="+maxlength+" ";
 		}
 }
 String sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf,t.fullname from DCALLCAUSECFG t where 1=1 "+condition+" and t.is_del='N'and visible='1' order by t.callcause_id";
 StringBuffer res = new StringBuffer();
 //正常的父节点点击

%>
<wtc:service name="s152Select" outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="5" >

<% 
	
	for(int i = 0; i < resultList.length; ){	 
    i=getNodeHtml_cur(res,resultList,i,nodeLevel,lastChildRoute,gobal_check_str,hasSelectOption,flag); 	
	}
%>
</wtc:array>
<% 
%>

var response = new AJAXPacket();
response.data.add("worknos","<%=res.toString()%>");
response.data.add("nodeId","<%=nodeId%>");
response.data.add("param2","<%=param2%>");
response.data.add("preopen","<%=preopen%>");
core.ajax.receivePacket(response);


