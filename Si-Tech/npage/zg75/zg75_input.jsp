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
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	
	String opCode = "zg75";
	String opName = "�°��½�";
	
	       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
	String s_op_code_input = "AAAA";//¼�����Ʊ �����¼ΪAAAA
	String login_accept= request.getParameter("login_accept");
    String phoneno= request.getParameter("phoneno");
	String left_invoice= request.getParameter("left_invoice");//��Ʊ���
	String cust_name= request.getParameter("cust_name");
	 
 
	String work_no = (String)session.getAttribute("workNo");
	String groupId = (String)session.getAttribute("groupId"); 
	 
 
  
	//1. �жϸú����Ƿ��Ѿ�¼���
	//2. δ¼��� ����¼�� ��дһ��¼��ӿ�
%>
<wtc:service name="sleftInDB" routerKey="phone" routerValue="<%=phoneno%>" retcode="sCode" retmsg="sMsg"  outnum="2" >
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="<%=s_op_code_input%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value=""/><!--op_time-->
		<wtc:param value="<%=phoneno%>"/>
		<wtc:param value="0"/><!--id_no-->
		<wtc:param value="0"/><contractno>
		<wtc:param value=""/><!--s_check_num-->
		<wtc:param value="0"/><!--��Ʊ���� 0-->
		<wtc:param value="0"/><!--��Ʊ���� 0-->
		<wtc:param value=""/><!--sm_code -->
		<wtc:param value="<%=left_invoice%>"/><!--Сд���-->
		<wtc:param value=""/><!--��д���-->
		<wtc:param value=""/><!--��ע-->
	 
		<wtc:param value="6"/><!--Ԥռ��6 ȡ����5��δ��ӡ-->
		<wtc:param value=""/><!--�ݿ�-->
		<wtc:param value=""/><!--˰��-->
		<wtc:param value=""/><!--˰��-->
		<wtc:param value=""/>

		<!--��basd�� 0��Ԥռ 1��ȡ��Ԥռ ���������Ҫ�� -->
		<wtc:param value="<%=cust_name%>"/><!--userName-->
		<!--xl add ������� ��Ʊ���� �������� ����ͺ� ��λ ���� ���� regionCode groupId �Ƿ���-->
		<wtc:param value="0"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=groupId%>"/> 
		<wtc:param value="1"/>
</wtc:service>
<wtc:array id="sArr" scope="end"/>
<%
	String retCode= sCode;
	String retMsg = sMsg;
   
 
	if ( retCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("��Ʊ¼��ɹ���");
	window.location="zg75_1.jsp";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("��Ʊ¼��ʧ��: <%=retMsg%>,<%=retCode%>",0);
	window.location="zg75_1.jsp";
	</script>
<%}
%>

