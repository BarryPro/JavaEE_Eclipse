<%
  /*
   * ����: �˹�ת�Զ�-תҵ����ѯά���������
�� * �汾: 1.0.0
�� * ����: 2009/08/07
�� * ����: yinzx
�� * ��Ȩ: sitech
   * 
�� */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
  String strSql="";
  String addvalxin = "";
	String retType = WtcUtil.repNull(request.getParameter("retType"));
  addvalxin = (String)request.getParameter("checkval");
  String[] addvalxnew=addvalxin.split(",");
  List sqlList=new ArrayList();
  String[] sqlArr = new String[]{};
 
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2); 
    
    if (retType.equals("delsceTrans"))
    {
       for(int i=0;i<addvalxnew.length;i++)
      {
        
         strSql="delete from difoperational where serialno=:v1";
         strSql +="&&"+addvalxnew[i];
         sqlList.add(strSql);
     	} 
     	 sqlArr = (String[])sqlList.toArray(new String[0]);
     	 	 
	  		
	  }
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value=""/>
    <wtc:param value="dbchange"/>
    <wtc:params value="<%=sqlArr%>"/>
</wtc:service>

<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);
