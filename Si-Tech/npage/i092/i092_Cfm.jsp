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
	String op_code = "g088";//��Ҫ������             //��������
	String loginAccept = "0";//request.getParameter("sysAccept");;       //������ˮ 
	String op_note = "���Ž���֪ͨ��������";//request.getParameter("op_note");              //��ע
 
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	//��Ϊ ������ϵ�˺� ��Ҫ��Ա����   

	String id_arrays[]=request.getParameterValues("id_arrays");  //������ϵ��
	

	String id_new="";
	 
    System.out.println("TTTTTTTTTTTTTTTTTTTTTTTTTT id_arrays is "+id_arrays);
	for(int i =0;i<id_arrays.length;i++)
	{
		id_new+=id_arrays[i];
		 
		System.out.println("VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV id_new is "+id_new);
	}
	 
 
 
	String paraAray[] = new String[14]; 
 
	String s_flag = request.getParameter("s_flag"); 
	String s_returnPage="";
	if(s_flag=="1" || s_flag.equals("1"))
	{
		s_returnPage="i092_1.jsp";
	}
	else
	{
		s_returnPage="i092_2.jsp";
	}
%>
<wtc:service name="bi092Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
    <wtc:param value="<%=work_no%>"/>
    <wtc:param value="<%=id_new%>"/> 
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/> 
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
%>
 
<%
   

	String errMsg = s4141CfmMsg;
	if ( s4141CfmCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("����ɹ���");
	window.location="<%=s_returnPage%>";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("����ʧ��: <%=retMsg%>,<%=s4141CfmCode%>",0);
	window.location="<%=s_returnPage%>";
	</script>
<%}
%>
 