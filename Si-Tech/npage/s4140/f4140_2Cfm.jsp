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
	String loginAccept = request.getParameter("sysAccept");;       		//������ˮ
	String FirstClass = request.getParameter("FirstClass2");          //�˷�һ��ԭ��
	String SecondClass = request.getParameter("SecondClass2");        //�˷Ѷ���ԭ��
	String ThirdClass = request.getParameter("ThirdClass2");					//�˷�����ԭ��
	String opFlag = request.getParameter("opFlag2");       						//��������
	String org_Code = (String)session.getAttribute("orgCode");
	String regionCode = org_Code.substring(0,2);
	String op_code = request.getParameter("op_code");              		//��������
	

	
	System.out.println("�˷�ԭ��ά��[ɾ��]\n");
	System.out.println("loginName============"+loginName);
	
	System.out.println("work_no============"+work_no);
	System.out.println("pass============"+pass);
	System.out.println("loginAccept============"+loginAccept);
	System.out.println("FirstClass============"+FirstClass);
	System.out.println("SecondClass============"+SecondClass);
	System.out.println("ThirdClass============"+ThirdClass);
	System.out.println("opFlag============"+opFlag);
	System.out.println("org_Code============"+org_Code);
	System.out.println("regionCode============"+regionCode);
	System.out.println("op_code============"+op_code);

	String paraAray[] = new String[13];
	paraAray[0] = loginAccept;				//��������
	paraAray[1] = "01";						//��������
	paraAray[2] = op_code; 		//������ˮ
	paraAray[3] = work_no;     //�˷�һ��ԭ��
	paraAray[4] = pass;    //�˷Ѷ���ԭ��
	paraAray[5] = "";     //�˷�����ԭ��
	paraAray[6] = "";        	//��������
	paraAray[7] = FirstClass;//���д���
	paraAray[8] = SecondClass;//��������
	paraAray[9] = ThirdClass;//��������
	paraAray[10] = opFlag;//���д���
	paraAray[11] = regionCode;//��������
	paraAray[12] = org_Code;//��������
%>
<wtc:service name="s4140_2Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s4140_2CfmCode" retmsg="s4140_2CfmMsg" outnum="2" >
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
</wtc:service>
<wtc:array id="s4140_2CfmArr" scope="end"/>
<%
	System.out.println("s4140_2CfmCode === "+ s4140_2CfmCode);
	System.out.println("s4140_2CfmMsg === "+ s4140_2CfmMsg);

	if (s4140_2CfmArr.length > 0 && s4140_2CfmCode.equals("000000"))
	{
		System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("ɾ���˷�ԭ����ɹ���",2);
	window.location="../s4140/f4140.jsp?opCode=4140&opName=Ͷ���˷�ԭ��ά��";
	</script>
<%}else{%>
<script language="JavaScript">
	rdShowMessageDialog("ɾ���˷�ԭ����ʧ��: <%=s4140_2CfmCode%><%=s4140_2CfmMsg%>",0);
	window.location="../s4140/f4140.jsp?opCode=4140&opName=Ͷ���˷�ԭ��ά��";
	</script>
<%}%>
