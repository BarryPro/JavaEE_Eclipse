<%
    /********************
     version v2.0
     ������: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String op_code = "zg57";
	String op_name = "������ϢͶ�߹ػ�";
	
	String work_no = (String)session.getAttribute("workNo");
	String loginPwd = (String)session.getAttribute("password");
	String regCode = (String)session.getAttribute("regCode");

	String phoneNo = request.getParameter("phoneNo");
	String shandlingtype = request.getParameter("shandlingtype"); //����ԭ��
	String sSourceData = request.getParameter("sSourceData");  //�Ӻ�����
	String sSourceType = request.getParameter("sSourceType"); //������Դ
	String blackReason = request.getParameter("blackReason"); //ԭ��˵��
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
<%
	String paraStr[] = new String[11];
	paraStr[0] = "";
	paraStr[1] = "01";
  paraStr[2] = op_code;
  paraStr[3] = work_no;
  paraStr[4] = loginPwd;
  paraStr[5] = phoneNo;
  paraStr[6] = "";
  paraStr[7] = sSourceType;
  paraStr[8] = sSourceData;
  paraStr[9] = "05";
  paraStr[10] = blackReason;
%>
	<wtc:service name="szg57Cfm" routerKey="region" routerValue="<%=regCode%>" retCode="initRetCode" retMsg="initRetMsg"  outnum="3">
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/>
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>
		<wtc:param value="<%=paraStr[4]%>"/>
		<wtc:param value="<%=paraStr[5]%>"/>
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value="<%=paraStr[7]%>"/>
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value="<%=paraStr[9]%>"/>
		<wtc:param value="<%=paraStr[10]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
		
	<%if("000000".equals(initRetCode)){%> 
			<script language="JavaScript">
				rdShowMessageDialog("�����ɹ�!",2);
				window.location="zg57.jsp?opCode=<%=op_code%>&opName=<%=op_name%>";
			</script>
	<%}else{%>   
			<script language="JavaScript">
				rdShowMessageDialog("����ʧ��!������룺<%=initRetCode%><br>������Ϣ��<%=initRetMsg%>",0);
				//history.go(-1);
				window.location="zg57.jsp?opCode=<%=op_code%>&opName=<%=op_name%>";
			</script>
	<%}%>
