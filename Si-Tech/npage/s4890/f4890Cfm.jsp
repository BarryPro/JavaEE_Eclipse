<%
/*****************************
 * ģ�����ƣ��������պ�Ⱥ����
 * ����汾��version 1.0
 * �� �� ��: SI-TECH
 * ��    ��: shengzd
 * ����ʱ��: 2010-05-10
 *****************************/
%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	
  String workNo    = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String workName  = WtcUtil.repNull((String)session.getAttribute("workName"));
  String regionCode= WtcUtil.repNull((String)session.getAttribute("regCode"));
  String orgCode   = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String ipAddr    = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
  String workPwd   = WtcUtil.repNull((String)session.getAttribute("password"));

  String opCode = WtcUtil.repNull((String)request.getParameter("op_code"));
  String opName = WtcUtil.repNull((String)request.getParameter("op_name"));
  
  String iOpType = WtcUtil.repNull((String)request.getParameter("opType"));           //��������
  String iUnitId = WtcUtil.repNull((String)request.getParameter("unitId"));           //���ű��
  String iUnitName = WtcUtil.repNull((String)request.getParameter("unitName"));       //��������
  String iVpmnGrpNo = WtcUtil.repNull((String)request.getParameter("vpmnGrpNo"));     //���������ű���
  
  String iCloseNo = WtcUtil.repNull((String)request.getParameter("closeNo"));         //�պ�Ⱥ��
  String iCloseName = WtcUtil.repNull((String)request.getParameter("closeName"));     //�պ�Ⱥ����
  String iFeeIndex = WtcUtil.repNull((String)request.getParameter("feeIndex"));       //��������
  String iMaxUserNum = WtcUtil.repNull((String)request.getParameter("maxUserNum"));   //����û���
%>
    <wtc:service name="s4890Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=workPwd%>"/>
      <wtc:param value="<%=orgCode%>"/>
      <wtc:param value="<%=ipAddr%>"/>
      <wtc:param value="<%=opCode%>"/> 
      <wtc:param value="<%=iOpType%>"/>
      <wtc:param value="<%=iUnitId%>"/>
      <wtc:param value="<%=iVpmnGrpNo%>"/>
      <wtc:param value="<%=iCloseNo%>"/>
      <wtc:param value="<%=iCloseName%>"/>
      <wtc:param value="<%=iFeeIndex%>"/>
      <wtc:param value="<%=iMaxUserNum%>"/>
    </wtc:service>
<%
try{
    if("000000".equals(retCode)){
%>
    <script type="text/javascript">
        rdShowMessageDialog("�����ɹ�!",2);
        window.location = "f4890.jsp";
    </script>
<%
    }else{
        System.out.println("From f4890Cfm.jsp ���÷���s4890Cfm����ʧ��!retCode = "+retCode+" retMsg = "+retMsg);
%>
    <script type="text/javascript">
        rdShowMessageDialog("������룺<%=retCode%><br>������Ϣ��<%=retMsg%>",0);
        history.go(-1);
    </script>
<%
    }
}catch(Exception e){
    System.out.println("From f4890Cfm.jsp ���÷���s4890Cfm����ʧ��");
    e.printStackTrace();
%>
    <script type="text/javascript">
        rdShowMessageDialog("���÷���s4890Cfm����ʧ��!",0);
        history.go(-1);
    </script>
<%
}
%>