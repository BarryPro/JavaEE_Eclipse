<%
  /*
   * ����: ʵ�����޸�
   * �汾: 1.0
   * ����: 20111206
   * ����: wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
response.setHeader("Pragma","No-Cache"); 
response.setHeader("Cache-Control","No-Cache");
response.setDateHeader("Expires", 0); 
String opCode = "e455";
String opName = "ʵ�����޸�";
String password = (String)session.getAttribute("password");
String regionCode=(String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String phoneNo = request.getParameter("phoneNo");
String opNote = workNo + "��" + phoneNo + "����ʵ�����޸�";
String trueCode = request.getParameter("trueCode");
String opType22 = request.getParameter("opType22");


System.out.println("====wanghfa====fe455_cfm.jsp====sE455Cfm====0==== iLoginAccept = 0");
System.out.println("====wanghfa====fe455_cfm.jsp====sE455Cfm====1==== iChnSource = 01");
System.out.println("====wanghfa====fe455_cfm.jsp====sE455Cfm====2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe455_cfm.jsp====sE455Cfm====3==== iloginNo = " + workNo);
System.out.println("====wanghfa====fe455_cfm.jsp====sE455Cfm====4==== iloginPwd = " + password);
System.out.println("====wanghfa====fe455_cfm.jsp====sE455Cfm====5==== iPhoneNo = " + phoneNo);
System.out.println("====wanghfa====fe455_cfm.jsp====sE455Cfm====6==== iUserPwd = ");
System.out.println("====wanghfa====fe455_cfm.jsp====sE455Cfm====7==== opNote = " + opNote);
System.out.println("====wanghfa====fe455_cfm.jsp====sE455Cfm====8==== trueCode = " + trueCode);
	
%>

<%
/*2016/2/26 15:35:03 gaopeng ����Э���������ʵ���Ʊ�ʶ���������ֱ�������ĺ���BOSS�ࣩ
	����˺�ת�ֻ�������� ���ǿ���˺��򷵻ش������ 
	���Կ��������ж���ĺ����Ƿ��ǿ���˺�
*/
%>
<wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="1"  retcode="errCodeGetPhone" retmsg="errMsgGetPhone">
			<wtc:param  value="0"/>
			<wtc:param  value="01"/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=workNo%>"/>
			<wtc:param  value=""/>
			<wtc:param  value=""/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=phoneNo%>"/>
	  </wtc:service>
  	<wtc:array id="list" scope="end"/>
	<%
			if("000000".equals(errCodeGetPhone)){
			
				if(list != null && list.length > 0){
				System.out.println("==gaopengSeeLogE455= list[0][0] ===" + list[0][0]);
					/*���ֻ����滻��ǰ����˺����ڷ���ֵ*/
					phoneNo = list[0][0];
				}
			}
	
	%>
	
<wtc:service name="sE455Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=opNote%>"/>
	<wtc:param value="<%=trueCode%>"/>
	<wtc:param value="<%=opType22%>"/>
	
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
System.out.println("====wanghfa====fe455_cfm.jsp====sE455Cfm==== " + retCode1 + ", " + retMsg1);

if (!"000000".equals(retCode1)) {
	%>
	<script language="javascript">
		rdShowMessageDialog("sE455Cfm����<%=retCode1%>��<%=retMsg1%>", 0);
		window.location = "fe455.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
} else {
	%>
	<script language=javascript>
		rdShowMessageDialog("ҵ�����ɹ���", 2);
		window.location = "fe455.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
}
%>
