<%
/********************
 -------------------------����-----------�ξ�ΰ(hejwa) 2015/5/12 9:54:44-------------------
 ���ڽ�һ����ǿʡ��֧��ϵͳʵ�����Ǽǹ��ܵ�֪ͨ
 
 ����ҵ���߼���ƣ�
1�������ֻ������(����ͼ����������ֻ����뵯������)������û��Ƿ�ʵ������׼ʵ���û����򵯳���ʾ��
		��ʾ��ϢΪ�������ʵ���Ǽǣ�����ͻ����ϡ���˵����ֻ����ʾ���������ơ�
 -------------------------��̨��Ա����--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	System.out.println("--hejwa-------------sTrueCodeQry.jsp------------->");
	
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
	String retCode    = "000000";
	String retMsg     = "";
	String result     = "1";//�˴�д����ʵ���Ʒŵ����ﳵ�н����ж�
	 
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("result","<%=result%>");
core.ajax.receivePacket(response);
