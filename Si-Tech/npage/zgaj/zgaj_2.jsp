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
	String op_code = "zgaj";              //��������
	
	String work_no = (String)session.getAttribute("workNo"); 
	String phone_no = request.getParameter("phone_no");
	String beginTime = request.getParameter("beginTime");
	String endTime = request.getParameter("endTime");
	String searchType = request.getParameter("searchType");
	String tsdzls =  request.getParameter("tsdzls");
	/*
	����	�ַ���	6		
	�绰����	�ַ���	15		Yyyymm
	��ѯ����	�ַ���	2		11-35  ����0 
	ʱ������	�ַ���	1		Ĭ�ϴ� 0 
	ʱ���ַ���	�ַ���	60		Yyyymmdd^ Yyyymmdd^

	*/
	//String sjzfc = beginTime+"^"+endTime+"^";//ֻҪ�·�
	String sjzfc = beginTime;
%>
<wtc:service name="s4141_spec" routerKey="phone" routerValue="<%=phone_no%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
    <wtc:param value="<%=work_no%>"/>
    <wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=searchType%>"/> 
	<wtc:param value="1"/> 
	<wtc:param value="<%=sjzfc%>"/> 
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("fffffffffffffffffffffffffdddddddddddddddddddddaaaaaaaaaaaaaaaaaaaaaa retCode === "+ retCode+" and s4141CfmCode is "+s4141CfmCode);
	System.out.println("retMsg === "+ retMsg);
	
    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");

	String errMsg = s4141CfmMsg;
	if (s4141CfmCode=="000000"||s4141CfmCode.equals("000000"))
	{
	  
	System.out.println("success");
%>
<script language="JavaScript">
	//rdShowMessageDialog("�ļ�����ɹ���",2);
	window.location="zgaj_3.jsp?phone_no=<%=phone_no%>&beginTime=<%=beginTime%>&endTime=<%=endTime%>&searchType=<%=searchType%>&tsdzls=<%=tsdzls%>";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("�ļ�����ʧ��,�������:<%=s4141CfmCode%>,����ԭ��:<%=s4141CfmMsg%>",0);//���ҳ����Ϊ�˵����굥�����ѯ�� ��ʱ��ߵ��� �ɹ���ʧ�ܵķ���ҳ�� 
	history.go(-1);
	//alert(window.location);
	</script>
<%}
%>

