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
    
 		String opCode = "g444";
 		String opName = "���п�ǩԼ�ͻ���������";
		 
		/**��ҪregionCode���������·��**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
 
		 
		String custPass = request.getParameter("custPass");
		String nopass = (String)session.getAttribute("password"); 
		String phone_no = request.getParameter("phone_no");
		String phone_no2 = request.getParameter("phone_no2");
		String jfje = request.getParameter("jfje");
		String cg_radio= request.getParameter("flag");//�Լ����˱�־ 0���� 1���Լ�
		String phone_new="";
		System.out.println("AAAAAAAAAAAAAAAAAAAAAA ");
		if(cg_radio.equals("1"))
		{
			System.out.println("for�Լ�");
			phone_new=phone_no;
		}
		if(cg_radio.equals("0"))
		{
			System.out.println("for����");
			phone_new=phone_no2;
		}
		String[][] result1  = null ;

%>
 
		<wtc:service name="sg444Cfm"  routerKey="region"  routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="2"> 
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=custPass%>"/>
			<wtc:param value="<%=phone_new%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value="<%=jfje%>"/>
	 
 
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
				rdShowMessageDialog("���п�ǩԼ�ͻ������������óɹ�!");
				window.location="g444_1.jsp";
			</script>
		<%
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("���п�ǩԼ�ͻ�������������ʧ��!"+"������룺"+"<%=retCode5%>"+"������ԭ��"+"<%=retMsg5%>");
				window.location="g444_1.jsp";
			</script>
		<%
	}
	
%>
 
 