<%
/***************************
* url�����й�ҳ��
* �ṩ�����������ƣ�url���ȣ������ʾ��
* ʯ�س�
* 20080407
***************************/
%>
<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
    Map _paramap = (Map)request.getAttribute("_paraMap");
    String _url = (String)_paramap.get("_url");
    System.out.println("url==========="+_url);
    
        String _wono = (String)_paramap.get("_wono");
    System.out.println("_wono==========="+_wono);
    
    
            String _dataId = (String)request.getAttribute("_dataId");
    System.out.println("_dataId==========="+_dataId);
    
    
%>
		 <jsp:forward page="<%=_url%>" />