<%
  /*
   * 功能: 来电原因填写->原因树的数据提取
　 * 版本: 1.0.0
　 * 日期: 2009/4/7
　 * 作者: jiangbing
　 * 功能说明: 分为四种情况的html生成：
　 * 1、正常的父节点点击，生成html，这种情况需要输入参数nodeId，此方法查询数据库，返回父节点为nodeId的子节点
　 * 2、初始化虚拟父节点，生成html，这种情况需要输入参数nodeId、isRoot=1、isVisual=1，此方法不查询数据库，返回虚拟父节点，虚拟节点的id=nodeId
　 * 3、初始化实体父节点，生成html，这种情况需要输入参数nodeId、isRoot=1、isVisual=0，此方法查询数据库，返回nodeId的节点
　 * 4、根据查询caption相似，来初始化列表，生成html，这种情况需要输入参数nodeId、isRoot=1、isVisual=0、caption，此方法查询数据库，返回符合条件的叶子节点html
　 * 版权: sitech
   * update:
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
 String isRoot = WtcUtil.repNull(request.getParameter("isRoot"));
 if(isRoot==null){
 	isRoot = "";
 }
 String nodeLevel = WtcUtil.repNull(request.getParameter("nodeLevel"));
 nodeLevel = new Integer(Integer.parseInt(nodeLevel)+1).toString();
 String lastChildRoute = WtcUtil.repNull(request.getParameter("lastChildRoute"));
 String gobal_check_str = WtcUtil.repNull(request.getParameter("gobal_check_str"));
 String isFirstSelect = WtcUtil.repNull(request.getParameter("isFirstSelect"));
 boolean flag = false;
 if("4".equals(isFirstSelect)){
 		flag = true;	
 }
 String hasSelectOption = WtcUtil.repNull(request.getParameter("hasSelectOption"));
 String sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf,t.fullname from DCALLCAUSECFG t where 1=1 and t.super_id='"+nodeId+"' and t.is_del='N'and visible='1' order by t.callcause_id";
 StringBuffer res = new StringBuffer();
 //正常的父节点点击
 if(isRoot.equals("")||isRoot.equals("0")){
 System.out.println("begin k170_rpc s152Select ");
%>
<wtc:service name="s152Select" outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="5" >

<% 
	System.out.println("end k170_rpc s152Select ");
	for(int i = 0; i < resultList.length; i++){
    String isLast = "0";
	  if(i==resultList.length-1){
	  	 isLast="1";	  	
	   }  
	  String lastChildRoute_ = (lastChildRoute.equals("")?lastChildRoute:(lastChildRoute+","))+isLast;
    getNodeHtml(res,resultList[i],nodeLevel,isLast,lastChildRoute_,gobal_check_str,hasSelectOption,flag); 	

	}
%>
</wtc:array>
<% 
}else{
			String isVisual = request.getParameter("isVisual");
 			if(isVisual==null){
 				isVisual = "";
 			}
 			//初始化实体父节点
	    if(isVisual.equals("")||isVisual.equals("0")){
					sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf,t.fullname from DCALLCAUSECFG t where 1=1 and t.callcause_id='"+nodeId+"' and t.is_del='N'and visible='1' order by t.callcause_id";
				 System.out.println("start k170_rpc s152Select ");
%>
<wtc:service name="s152Select" outnum="5">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="5" >
<%	  
System.out.println("end k170_rpc s152Select ");
for(int i = 0; i < resultList.length; i++){
				String isLast = "0";
	  		if(i==resultList.length-1){
	  	 		isLast="1";	  	
	   		}  
        getNodeHtml(res,resultList[i],"1",isLast,isLast,gobal_check_str,hasSelectOption,flag);
      }
%>
</wtc:array>
<% 
			}			
		  else{
	    	String[] param = {"0","-1","来电原因","0","来电原因"};
				getNodeHtml(res,param,"1","1","1",gobal_check_str,hasSelectOption,flag);
			}
	}
%>
var response = new AJAXPacket();
response.data.add("worknos","<%=res.toString()%>");
response.data.add("nodeId","<%=nodeId%>");
core.ajax.receivePacket(response);


