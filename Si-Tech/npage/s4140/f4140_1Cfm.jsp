<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String loginName = (String)session.getAttribute("workName");

	String work_no = (String)session.getAttribute("workNo");
	String pass = (String)session.getAttribute("password");
	String loginAccept = request.getParameter("sysAccept");;       	//������ˮ
	String FirstClass = request.getParameter("FirstClass");					//�˷�һ��ԭ��
	String SecondClass = request.getParameter("SecondClass");				//�˷Ѷ���ԭ��
	String ThirdClass = request.getParameter("ThirdClass");					//�˷�����ԭ��
	String Inclassfirst = request.getParameter("inclassfirst");			//�����˷�һ��ԭ��
	String Inclasssecond = request.getParameter("inclasssecond");		//�����˷Ѷ���ԭ��
	String Inclassthird = request.getParameter("inclassthird");			//�����˷�����ԭ��
	String opFlag1 = request.getParameter("opFlag1");								//��������
	String org_Code = (String)session.getAttribute("orgCode");
	String regionCode = org_Code.substring(0,2);
	String op_code = request.getParameter("op_code");              	//��������
	

	
	System.out.println("�˷�ԭ��ά��[����]\n");
	System.out.println("loginName============"+loginName);
	
	System.out.println("work_no============"+work_no);
	System.out.println("pass============"+pass);
	System.out.println("loginAccept============"+loginAccept);
	System.out.println("FirstClass============"+FirstClass);
	System.out.println("SecondClass============"+SecondClass);
	System.out.println("ThirdClass============"+ThirdClass);
	System.out.println("Inclassfirst============"+Inclassfirst);
	System.out.println("Inclasssecond============"+Inclasssecond);
	System.out.println("Inclassthird============"+Inclassthird);
	System.out.println("opFlag1============"+opFlag1);
	System.out.println("regionCode============"+regionCode);
	System.out.println("org_Code============"+org_Code);
	System.out.println("op_code============"+op_code);

	String paraAray[] = new String[16];
	paraAray[0] = loginAccept;					//������ˮ
	paraAray[1] = "01";  						//������ʶ
	paraAray[2] = op_code; 			//��������
	paraAray[3] = work_no;					//��������
	paraAray[4] = pass;  						//��������
	paraAray[5] = ""; 			//�绰����	
	paraAray[6] = ""; 			//��������
	paraAray[7] = FirstClass;				//�˷�һ��ԭ��
	paraAray[8] = SecondClass;			//�˷Ѷ���ԭ��
	paraAray[9] = ThirdClass;				//�˷�����ԭ��
	paraAray[10] = Inclassfirst;			//�����˷�һ��ԭ��
	paraAray[11] = Inclasssecond;		//�����˷Ѷ���ԭ��
	paraAray[12] = Inclassthird;			//�����˷�����ԭ��
	paraAray[13] = opFlag1;					//��������
	paraAray[14] = regionCode;
	paraAray[15] = org_Code;
%>
<wtc:service name="s4140_1Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s4140_1CfmCode" retmsg="s4140_1CfmMsg" outnum="2" >
  <wtc:param value="<%=paraAray[0]%>"/>
  <wtc:param value="<%=paraAray[1]%>"/>
  <wtc:param value="<%=paraAray[2]%>"/>
  <wtc:param value="<%=paraAray[3]%>"/>
  <wtc:param value="<%=paraAray[4]%>"/>
  <wtc:param value="<%=paraAray[5]%>"/>
  <wtc:param value="<%=paraAray[6]%>"/>
  <wtc:param value="<%=paraAray[7]%>"/>
  <wtc:param value="<%=paraAray[8]%>"/>
  <wtc:param value="<%=paraAray[9]%>"/>
  <wtc:param value="<%=paraAray[10]%>"/>
  <wtc:param value="<%=paraAray[11]%>"/>
  <wtc:param value="<%=paraAray[12]%>"/>
  <wtc:param value="<%=paraAray[13]%>"/>
  <wtc:param value="<%=paraAray[14]%>"/>
  <wtc:param value="<%=paraAray[15]%>"/>
</wtc:service>
<wtc:array id="s4140_1CfmArr" scope="end"/>
<%
	System.out.println("s4140_1CfmCode === "+ s4140_1CfmCode);
	System.out.println("s4140_1CfmMsg === "+ s4140_1CfmMsg);

	if (s4140_1CfmArr.length > 0 && s4140_1CfmCode.equals("000000"))
	{
		System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("�����˷�ԭ����ɹ���",2);
	window.location="../s4140/f4140.jsp?opCode=4140&opName=Ͷ���˷�ԭ��ά��";
</script>
<%}else{%>
<script language="JavaScript">
	rdShowMessageDialog("�����˷�ԭ����ʧ��: <%=s4140_1CfmCode%><%=s4140_1CfmMsg%>",0);
	window.location="../s4140/f4140.jsp?opCode=4140&opName=Ͷ���˷�ԭ��ά��";
	</script>
<%}%>
