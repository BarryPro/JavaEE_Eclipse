<%
  /*
   * ����: ��������
   * �汾: 1.0
   * ����: 2013/9/2
   * ����: wanghyd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>

<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");

	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password"); 

	String cust_name=request.getParameter("oCustName");//��������
	String Prepay_Fee=request.getParameter("sale_price");//Ӧ�ս��
	String Base_Fee=request.getParameter("prepay_limit");//����Ԥ��
	String Free_Fee=WtcUtil.repNull((String)request.getParameter("Free_Fee"));
	String Consume_Term=request.getParameter("contract_time");//��Լ����
	String iAddStr=request.getParameter("iAddStr");//ƴ��
	String do_note=request.getParameter("do_note");//��ע��Ϣ
	String payTypeSelect=request.getParameter("payTypeSelect");//�ɷ�����
	
	String sale_code=WtcUtil.repNull((String)request.getParameter("sale_code_Hidd"));//Ӫ��������	
	String p3=request.getParameter("p3");//�ֻ��ͺ�		
	System.out.println("--diling--p3="+p3);
  String IMEINo=request.getParameter("IMEINo");//IMEINo��
  String Save_Fee=request.getParameter("prepay_limit");//Ԥ�滰�� 
  String PhoneFree_Fee=WtcUtil.repNull((String)request.getParameter("PhoneFree_Fee"));
  String Active_Term=WtcUtil.repNull((String)request.getParameter("Active_Term"));
  
	/*zhangyan ���ѻ���*/
	String used_point = WtcUtil.repNull((String)request.getParameter("markPoint"));
	
	String paraAray[] = new String[32];
	paraAray[0] = request.getParameter("printAccept");
	paraAray[1] = "01";
	paraAray[2] = opCode;
	paraAray[3] = work_no;
	paraAray[4] = password;
	paraAray[5] = request.getParameter("phoneNo");
	paraAray[6] = "";
	paraAray[7] = iAddStr;
	paraAray[8] = do_note;
	paraAray[9] = ip_Addr;
	paraAray[10] = "0";
	paraAray[11] = "39";	


	
%>
	<wtc:service name="sg975Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
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

	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
%>

<script language="JavaScript">
   rdShowMessageDialog("������������ɹ�! ",2);
   window.location="/npage/si101/fi101_login.jsp?activePhone=<%=paraAray[5]%>&opCode=i101&opName=<%=opName%>";
</script>  
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("������������ʧ��!(<%=errMsg%>,<%=errCode%>",0);
	window.location="/npage/si101/fi101_login.jsp?activePhone=<%=paraAray[5]%>&opCode=i101&opName=<%=opName%>";
</script>
<%}%>

