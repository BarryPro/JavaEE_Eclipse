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

	String jtnameArrays[]=request.getParameterValues("jtnameArrays");  //������ϵ��
	String jttelArrays[]=request.getParameterValues("jttelArrays");    //��ϵ�˵绰

	String impnameArrays[]=request.getParameterValues("impnameArrays");    //��Ҫ��Ա��name
	//String flagArrays[]=request.getParameterValues("flagArrays"); //1���ŵ� 2��Ҫ��
	String dutyArrays[]=request.getParameterValues("dutyArrays");
	String depArrays[]=request.getParameterValues("depArrays");
	String i_flag_grp[]=request.getParameterValues("i_flag_grp");
	String i_flag_imp[]=request.getParameterValues("i_flag_imp");
	 
	String grp_cust_id[]=request.getParameterValues("grp_cust_id");
	String grp_imp_id[]=request.getParameterValues("grp_imp_id");
	String imp_cust_id[]=request.getParameterValues("imp_cust_id");
	String imp_imp_id[]=request.getParameterValues("imp_imp_id");

	String jtname_new="";
	String jttel_new="";
	String jt_flag="";
	String jt_cust_id="";	
	String jt_imp_id="";

	String impname_new="";
	String impduty_new="";
	String impdep_new="";
	String imp_flag="";
	String imp_cust_id_new="";
	String imp_imp_id_new="";
    
	for(int i =0;i<jtnameArrays.length;i++)
	{
		jtname_new+=jtnameArrays[i];
		jttel_new+=jttelArrays[i];
		jt_flag+=i_flag_grp[i];
		jt_cust_id+=grp_cust_id[i];
		jt_imp_id+=grp_imp_id[i];
		//System.out.println("VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV bizcode_new is "+bizcode_new);
	}
	
	for(int i =0;i<impnameArrays.length;i++)
	{
		impname_new+=impnameArrays[i];
		impduty_new+=dutyArrays[i];
		impdep_new+=depArrays[i];
		imp_flag+=i_flag_imp[i];
		imp_cust_id_new+=imp_cust_id[i];
		imp_imp_id_new+=imp_imp_id[i];
		//System.out.println("VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV bizcode_new is "+bizcode_new);
	}
 
 
	String paraAray[] = new String[14]; 
	String unitId = request.getParameter("unitId");
	 
	//String sysAccept = request.getParameter("sysAccept");
	 

	paraAray[0] = op_code;
	paraAray[1] = work_no;
	paraAray[2] = jtname_new;
	paraAray[3] = jttel_new;
	paraAray[4] = impname_new;
	paraAray[5] = impduty_new;
	paraAray[6] = impdep_new;
	paraAray[7] = jt_flag; //����
	paraAray[8] = imp_flag; //��Ҫ
	paraAray[9] = unitId; //unit_id
	paraAray[10] = imp_imp_id_new; //imp_imp_Id
	paraAray[11] = imp_cust_id_new; //imp_cust_id
	paraAray[12] = jt_imp_id; //grp_imp_Id
	paraAray[13] = jt_cust_id; //grp_cust_Id 
 
%>
<wtc:service name="sInsGrpInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
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
    
</wtc:service>
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
	window.location="asdf_1.jsp?opCode=asdf&opName=���ſͻ��ɷ�֪ͨ";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("����ʧ��: <%=retMsg%>,<%=s4141CfmCode%>",0);
	window.location="asdf_1.jsp?opCode=asdf&opName=���ſͻ��ɷ�֪ͨ";
	</script>
<%}
%>

