/*
  ��ȡ������Ϣ��
      ������
      ����ϵͳ��ֵ���߽��
      ����ϵͳ��ֵ����
      ϵͳ��ֵ�ר�������
      ϵͳ��ֵ����ר�������
*/
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");

	String saleCode = (String)request.getParameter("saleCode");//Ӫ��������
	String opCode = (String)request.getParameter("opCode");
	
	String monBaseFee = ""; //����ϵͳ��ֵ���߽�� 
	String freeFee	 = "";  //����ϵͳ��ֵ����
	String baseFee = "";    //������  
	String activeTerme = "";//����ϵͳ��ֵ�·�
%>
  <wtc:service name="sFamYXSel" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="4">
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value=""/>
    <wtc:param value=""/>
    <wtc:param value="<%=saleCode%>"/>
    <wtc:param value="<%=regionCode%>"/>
  </wtc:service>
  <wtc:array id="result" scope="end" />
<%
  if("000000".equals(retCode)){
    if(result.length>0){
      monBaseFee = result[0][0];
      freeFee = result[0][1];
      baseFee = result[0][2];
      activeTerme = result[0][3];
    }
  } 
%>		
	var response = new AJAXPacket();
	response.data.add("monBaseFee","<%=monBaseFee%>");
	response.data.add("freeFee","<%=freeFee%>");
	response.data.add("baseFee","<%=baseFee%>");
	response.data.add("activeTerme","<%=activeTerme%>");
	core.ajax.receivePacket(response);