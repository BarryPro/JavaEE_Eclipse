<%
/*****************************
 * ģ�����ƣ��������պ�Ⱥ��Ա����
 * ����汾��version 1.0
 * �� �� ��: SI-TECH
 * ��    ��: shengzd
 * ����ʱ��: 2010-05-10
 *****************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<form name="frm" action="" method="post" >
    <input type="hidden" id="errPhoneList" name="errPhoneList" value="" />
    <input type="hidden" id="errMsgList" name="errMsgList" value="" />
</form>
<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	
	String opCode = WtcUtil.repNull((String)request.getParameter("op_code"));
	String opName = WtcUtil.repNull((String)request.getParameter("op_name"));
	
  String workNo    = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String workName  = WtcUtil.repNull((String)session.getAttribute("workName"));
  String regionCode= WtcUtil.repNull((String)session.getAttribute("regCode"));
  String orgCode   = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String ipAddr    = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
  String workPwd   = WtcUtil.repNull((String)session.getAttribute("password"));
	
	String iOpType = WtcUtil.repNull((String)request.getParameter("opType"));           //��������
	String iUnitId = WtcUtil.repNull((String)request.getParameter("unitId"));           //���ű��
	String iUnitName = WtcUtil.repNull((String)request.getParameter("unitName"));       //��������
	String iVpmnGrpNo = WtcUtil.repNull((String)request.getParameter("vpmnGrpNo"));     //���������ű���
	
	String iCloseNo = WtcUtil.repNull((String)request.getParameter("closeNo"));         //�պ�Ⱥ��
	String iCloseName = WtcUtil.repNull((String)request.getParameter("closeName"));     //�պ�Ⱥ����
	String iFeeIndex = WtcUtil.repNull((String)request.getParameter("feeIndex"));       //��������
	String iMaxUserNum = WtcUtil.repNull((String)request.getParameter("maxUserNum"));   //����û���
	
	String iCloseNo2 = WtcUtil.repNull((String)request.getParameter("newClose"));        //�������µıպ�Ⱥ��
	
	String iNoType = WtcUtil.repNull((String)request.getParameter("noType"));
	String iNoList = WtcUtil.repNull((String)request.getParameter("multi_phoneNo"));
	
	String iFeeIndex2 = WtcUtil.repNull((String)request.getParameter("feeIndex2"));       //�·������� wuxy add 20110711
	System.out.println("\n### iNoList = ["+iNoList+"]/n");
	System.out.println("\n### iNoList = ["+iFeeIndex2+"]/n");
	
	try{
%>
    <wtc:service name="s4891Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=workPwd%>"/>
      <wtc:param value="<%=orgCode%>"/>
      <wtc:param value="<%=ipAddr%>"/>
      <wtc:param value="<%=opCode%>"/> 
      <wtc:param value="<%=iOpType%>"/>
      <wtc:param value="<%=iUnitId%>"/>
      <wtc:param value="<%=iVpmnGrpNo%>"/>
      <wtc:param value="<%=iCloseNo%>"/>
      <wtc:param value="<%=iCloseNo2%>"/>
      <wtc:param value="<%=iCloseName%>"/>
      <wtc:param value="<%=iFeeIndex%>"/>
      <wtc:param value="<%=iMaxUserNum%>"/>
      <wtc:param value="<%=iNoType%>"/>
      <wtc:param value="<%=iNoList%>"/>
      <wtc:param value="<%=iFeeIndex2%>"/>
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
<%
    	System.out.println("retCode = "+retCode);
    	System.out.println("retMsg  = "+retMsg);
    	
        if("000000".equals(retCode)){
            String errPhoneList = retArr[0][0];
            String errMsgList   = retArr[0][1];
        /* �ɹ���ת������չʾҳ�� */
            System.out.println("############### SUCCESS ################");
            System.out.println("errPhoneList = " + errPhoneList);
            System.out.println("errMsgList = "+ errMsgList);
        %>
            <script type="text/javascript">
                $("#errPhoneList").val("<%=errPhoneList%>");
                $("#errMsgList").val("<%=errMsgList%>");
                
                frm.action="f4891ResultList.jsp";
            	frm.method="post";
            	frm.submit();
            </script>
        <%
        }else{
            %>
            <script type="text/javascript">
                rdShowMessageDialog("����ʧ�ܣ�<br/>������룺<%=retCode%>��������Ϣ:<%=retMsg%>",0);
                window.location="f4891.jsp";
            </script>
            <%
        }
    }catch(Exception e){
        %>
        <script type="text/javascript">
            rdShowMessageDialog("���÷���s4891Cfmʧ�ܣ�",0);
            window.location="f4891.jsp";
        </script>
        <%
        System.out.println("# return from f4891Cfm.jsp -> Call Service s4891Cfm Failed!");
        e.printStackTrace();
    }
%>
</body>
</html>