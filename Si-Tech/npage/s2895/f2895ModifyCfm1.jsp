<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.16
 ģ��:���Ŷ�����Ϣ����(�޸�)
********************/
%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="com.sitech.util.UnicodeUtil"%>

<%
	String opCode = "2885";
	String opName = "���Ŷ�����Ϣ����(�޸�)";
	String loginAccept = "";

	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");                //����
	String workName = (String)session.getAttribute("workName");              	//��������
	String regCode = (String)session.getAttribute("regCode");
			
	/* ����������� */
	String custId       = request.getParameter("custId");           //���ſͻ�id
	String idNo         = request.getParameter("idNo");
	String attrCode     = request.getParameter("attrCode");
	String prodCode     = request.getParameter("prodCode");
	String unitId = request.getParameter("unitId");
	String newAttrValue = UnicodeUtil.unescape(request.getParameter("newAttrValue"));    
	//UnicodeUtil.escape(����) ==> unicode
	String iMonthFee    = request.getParameter("iMonthFee");      
    System.out.println("/n " + newAttrValue);
	System.out.println("======newAttrValue: " + newAttrValue);
	System.out.println("/n " + newAttrValue);
	String errCode="";
    String errMsg="";
  	System.out.println("cfmcfmcfmcfmcfmcfmcfmcfmcfmcfm1=="+unitId);
	
	String paramsIn[] = new String[6];
	paramsIn[0] = workNo;	
	paramsIn[1] = "2885";
	paramsIn[2] = idNo;
	paramsIn[3] = prodCode;
	paramsIn[4] = attrCode;
	paramsIn[5] = newAttrValue;
   
    //acceptList = impl.callService("s2885Cfm",paramsIn,"0");
%>
	<wtc:service name="s2885Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=paramsIn[0]%>"/>	
	<wtc:param value="<%=paramsIn[1]%>"/>	
	<wtc:param value="<%=paramsIn[2]%>"/>	
	<wtc:param value="<%=paramsIn[3]%>"/>	
	<wtc:param value="<%=paramsIn[4]%>"/>	
	<wtc:param value="<%=paramsIn[5]%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
	if(result1.length==1)
		loginAccept = result1[0][0];
	
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unitId+"&contactType=grp";
	System.out.println("onceCnttInfo Cfm1");
	System.out.println("onceCnttInfo Cfm1===="+loginAccept);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	errCode=retCode1;
	errMsg=retMsg1;
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>");
response.data.add("flag","10");
core.ajax.receivePacket(response);
