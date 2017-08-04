<%
/********************
 version v2.0
������: si-tech
*
*create:ningtn@2011-11-30 ��ͨ��������
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode = (String)session.getAttribute("regCode");
	String iSmCode = WtcUtil.repNull(request.getParameter("iSmCode")); //Ʒ��
	String busiFlag = WtcUtil.repNull(request.getParameter("busiFlag"));//ҵ���ʶ
	String rateCode = WtcUtil.repNull(request.getParameter("rateCode"));//�ʷ�
	String isOpenCountFlag = "0";
	
	String  inParams [] = new String[2];
	inParams[0] = "SELECT COUNT(*) "
								+" FROM CGRPSMLIMIT "
								+" WHERE SM_CODE =:iSmCode "
								+" AND EXTERNAL_CODE =:busiFlag " 
								+" AND LIMIT_TYPE = '24' "
								+" AND LIMIT_VALUE =:rateCode "
								+" AND LIMIT_FLAG = 'Y'";
	inParams[1] = "iSmCode="+iSmCode+",busiFlag="+busiFlag+",rateCode="+rateCode;
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service>  
	<wtc:array id="result"  scope="end"/>
<%
	if("000000".equals(retCode1)){
		if(result.length > 0){
			isOpenCountFlag = result[0][0];
		}
	}
%>
	var response = new AJAXPacket();

	response.data.add("retCode","<%=retCode1 %>");
	response.data.add("retMsg","<%=retMsg1%>");
	response.data.add("isOpenCountFlag","<%=isOpenCountFlag%>");
	core.ajax.receivePacket(response);