<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: Ͷ���˷Ѳ�ѯ-���ݽ����ѯ��Ϣ
�� * �汾: v3.0
�� * ����: 2009-08-10
�� * ����: zhangshuaia
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=GBK"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>

<%
		/**��Ҫ�������.�������ҳ��,��ɾ��**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "g430";
 		String opName = "ǩԼ�û��۷ѽ������";
		 
		/**��ҪregionCode���������·��**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
 
		String kg = request.getParameter("kg");
		String flag = request.getParameter("flag");
		String values = request.getParameter("values");
		String custPass = request.getParameter("custPass");
		String nopass = (String)session.getAttribute("password"); 
		String phoneNo = request.getParameter("phoneNo");
		String value_fz = request.getParameter("value_fz");
		String[][] result1  = null ;

%>
 
		<wtc:service name="sg430"  routerKey="region"  routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="2"> 
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value="<%=custPass%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value="<%=values%>"/>
			<wtc:param value="<%=value_fz%>"/>
			<wtc:param value="<%=kg%>"/>
			<wtc:param value="<%=flag%>"/>
		</wtc:service> 
		<wtc:array id="sVerifyTypeArr1" start="0" length="2" scope="end"/> 
 
<%	
result1 = sVerifyTypeArr1;
System.out.println("retCode===="+retCode5);
System.out.println("retMsg===="+retMsg5);
System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSS result1.length=" + result1.length);
	if(retCode5=="000000" ||retCode5.equals("000000") )
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("ǩԼ�û��۷ѽ�����óɹ�!");
				window.location="g430_1.jsp";
			</script>
		<%
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("ǩԼ�û��۷ѽ������ʧ��!"+"������룺"+"<%=retCode5%>"+"������ԭ��"+"<%=retMsg5%>");
				window.location="g430_1.jsp";
			</script>
		<%
	}
	
%>
 
 