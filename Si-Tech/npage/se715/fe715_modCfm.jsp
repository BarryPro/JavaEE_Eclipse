<%
   /*���ƣ��¾ɴ��벢�� - ����ύ
�� * �汾: v1.0
�� * ����: 2007/2/7
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%  
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));            //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));         //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));            //��½����
	String regionCode =WtcUtil.repNull((String)session.getAttribute("regCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));

	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());
	String opNote = workNo + "(" + strDate+ ")" + "�¾ɴ�����";
	String opCode = "e715";	
	String opName = "�¾ɴ��벢����ͣ�ָ�";
%>

<%
	String OprCode = request.getParameter("OprCode");//Z��ͣ��H�ָ�,E��ֹ
	String ecid = request.getParameter("ecid");
	String codeprop = request.getParameter("codeprop");
	String oldcode = request.getParameter("oldcode")==null?"":request.getParameter("oldcode");
	String newcode = request.getParameter("newcode")==null?"":request.getParameter("newcode");
	

	
    %>
        <wtc:service name="se715Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=nopass%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=ecid%>"/> 
				<wtc:param value="<%=codeprop%>"/> 
				<wtc:param value="<%=oldcode%>"/> 
				<wtc:param value="<%=newcode%>"/> 
				<wtc:param value="<%=OprCode%>"/> 
				<wtc:param value="<%=regionCode%>"/> 
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%

	System.out.println("# errCode = "+retCode);
	System.out.println("# errMsg = "+retMsg);
%>

	var response = new AJAXPacket();
	response.data.add("retFlag","queryMod");
	response.data.add("errCode","<%=retCode%>");
	response.data.add("errMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);
	