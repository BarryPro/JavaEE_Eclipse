<%
  /*
   * ����: ����ԭ����д->ԭ������������ȡ
�� * �汾: 1.0.0
�� * ����: 2009/4/7
�� * ����: jiangbing
�� * ����˵��: ��Ϊ���������html���ɣ�
�� * 1�������ĸ��ڵ���������html�����������Ҫ�������nodeId���˷�����ѯ���ݿ⣬���ظ��ڵ�ΪnodeId���ӽڵ�
�� * 2����ʼ�����⸸�ڵ㣬����html�����������Ҫ�������nodeId��isRoot=1��isVisual=1���˷�������ѯ���ݿ⣬�������⸸�ڵ㣬����ڵ��id=nodeId
�� * 3����ʼ��ʵ�常�ڵ㣬����html�����������Ҫ�������nodeId��isRoot=1��isVisual=0���˷�����ѯ���ݿ⣬����nodeId�Ľڵ�
�� * 4�����ݲ�ѯcaption���ƣ�����ʼ���б�����html�����������Ҫ�������nodeId��isRoot=1��isVisual=0��caption���˷�����ѯ���ݿ⣬���ط���������Ҷ�ӽڵ�html
�� * ��Ȩ: sitech
   * update:
�� */
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
 //�����ĸ��ڵ���
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
 			//��ʼ��ʵ�常�ڵ�
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
	    	String[] param = {"0","-1","����ԭ��","0","����ԭ��"};
				getNodeHtml(res,param,"1","1","1",gobal_check_str,hasSelectOption,flag);
			}
	}
%>
var response = new AJAXPacket();
response.data.add("worknos","<%=res.toString()%>");
response.data.add("nodeId","<%=nodeId%>");
core.ajax.receivePacket(response);


