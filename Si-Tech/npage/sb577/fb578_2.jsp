<%
/********************
 version v2.0
������: si-tech
update: huangrong@2010-09-21
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>

<%
	String opCode = "b578";
	String opName = "Ԥ�滰������ݮ�ն˳���";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>
<%

	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");

	String opNote = request.getParameter("opNote");       //��ע����
	String backaccept1 = request.getParameter("backaccept1");//������ˮ
	String login_accept = request.getParameter("login_accept");//��ˮ
	String userpass = request.getParameter("userpass");//�û�����
	String phone_typeno = request.getParameter("phone_typeno");//�ֻ�Ʒ���ͺ�
	String chuan=request.getParameter("chuan");//ƴ��
	String phone_no = request.getParameter("phone_no");
	String cust_name=request.getParameter("cust_name");
	String IMEINo=request.getParameter("IMEINo");
	
	String baseFee=request.getParameter("baseFee");	
	String op_code=request.getParameter("op_code");
	String paraAray[] = new String[23];
	paraAray[0]= login_accept;
	paraAray[1]= op_code;
	paraAray[2]= work_no;
	paraAray[3]= phone_no;
	paraAray[4]= "01";
	paraAray[5]= pass;
	paraAray[6]= userpass;
	paraAray[7]= chuan;
	paraAray[8]= opNote;
	paraAray[9]= ip_Addr;
	paraAray[10]= backaccept1;
	paraAray[11]= "0";
	
	System.out.println("login_accept==================="+paraAray[0]);
	System.out.println("op_code==================="+paraAray[1]);
	System.out.println("work_no==================="+paraAray[2]);
	System.out.println("phone_no==================="+paraAray[3]);
	System.out.println("pass==================="+paraAray[5]);
	System.out.println("userpass==================="+paraAray[6]);
	System.out.println("chuan==================="+paraAray[7]);	
	System.out.println("opNote==================="+paraAray[8]);
	System.out.println("ip_Addr==================="+paraAray[9]);
	System.out.println("backaccept==================="+paraAray[10]);	
	
%>
<wtc:service  name="sB578Cfm" routerKey="region" routerValue="<%=org_code%>" outnum="2"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>
	<wtc:param value="<%=paraAray[10]%>"/>
	<wtc:param value="<%=paraAray[11]%>"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	if (errCode.equals("0")||errCode.equals("000000"))
	{
		String ipf = WtcUtil.formatNumber(baseFee,2);
	  String outParaNums= "4";
%>
  	<wtc:service  name="sToChinaFee" routerKey="region" routerValue="<%=org_code%>" outnum="<%=outParaNums%>"  retcode="retCode2" retmsg="retMessage2">
			<wtc:param  value="<%=ipf%>"/>
	  </wtc:service>
	  <wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
	String chinaFee =chinaFee1[0][0];
%>
<script language="JavaScript">
   rdShowMessageDialog("�ύ�ɹ�! ��ӡ��Ʊ!",2);
 	 var infoStr="";

   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       Ԥ�滰������ݮ�ն�"+"|";//����	
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[3]%>'+"|";
   infoStr+=" "+"|";//Э�����
   infoStr+="�ֻ��ͺ�: "+'<%=phone_typeno%>'+"|";
   infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
   infoStr+="<%=WtcUtil.formatNumber(baseFee,2)%>"+"|";//Сд

    
   var jkinfo="";
	 jkinfo+="�˿�ϼƣ�<%=baseFee%>"+"Ԫ    ����Ԥ�滰��: <%=baseFee%>Ԫ"+"|";
	 
	 infoStr+=jkinfo+"|";
	 infoStr+=" "+"|";
	 infoStr+="IMEI�룺"+'<%=IMEINo%>'+"|";
	 infoStr+=" "+"|";                                                 
   location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/sb577/fb577_login.jsp?activePhone=<%=phone_no%>%26opCode=<%=op_code%>";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("Ԥ�滰������ݮ�ն˳���ʧ��!(<%=errMsg%>",0);
	window.location="fb577_login.jsp?activePhone=<%=phone_no%>&opCode=<%=op_code%>";
</script>
<%}%>