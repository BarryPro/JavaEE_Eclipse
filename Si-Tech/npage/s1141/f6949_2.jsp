<%
  /*
   * ����: ����ͳһԤ������6949
   * �汾: 1.0
   * ����: 2008/12/31
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>

<%
	String opCode="6949";
	String opName="����ͳһԤ������";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	String cust_name=request.getParameter("oCustName");
	String Prepay_Fee=request.getParameter("Prepay_Fee");
	String Base_Fee=request.getParameter("Base_Fee");
	String Free_Fee=request.getParameter("Free_Fee");
	String Consume_Term=request.getParameter("Consume_Term");
	
	String paraAray[] = new String[9];
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = request.getParameter("iOpCode");
    paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phoneNo");
    paraAray[4] = request.getParameter("projectType");
    paraAray[5] = request.getParameter("Gift_Code");
	paraAray[6] = request.getParameter("do_note");
    paraAray[7] = request.getParameter("ip_Addr");
    paraAray[8] = request.getParameter("preFlag");

//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
//	String[] ret = impl.callService("s6949Cfm",paraAray,"2","region",org_code.substring(0,2));
	System.out.println("====wanghfa====f6949_2.jsp====s6949Cfm====0==== paraAray[0] = " + paraAray[0]);
	System.out.println("====wanghfa====f6949_2.jsp====s6949Cfm====1==== paraAray[1] = " + paraAray[1]);
	System.out.println("====wanghfa====f6949_2.jsp====s6949Cfm====2==== paraAray[2] = " + paraAray[2]);
	System.out.println("====wanghfa====f6949_2.jsp====s6949Cfm====3==== paraAray[3] = " + paraAray[3]);
	System.out.println("====wanghfa====f6949_2.jsp====s6949Cfm====4==== paraAray[4] = " + paraAray[4]);
	System.out.println("====wanghfa====f6949_2.jsp====s6949Cfm====4==== paraAray[5] = " + paraAray[5]);
	System.out.println("====wanghfa====f6949_2.jsp====s6949Cfm====4==== paraAray[6] = " + paraAray[6]);
	System.out.println("====wanghfa====f6949_2.jsp====s6949Cfm====4==== paraAray[7] = " + paraAray[7]);
	System.out.println("====wanghfa====f6949_2.jsp====s6949Cfm====4==== paraAray[8] = " + paraAray[8]);
%>
	<wtc:service name="s6949Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
//		S1100View callView = new S1100View();
//		String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(Prepay_Fee,2)).get(0)))[0][2];//��д���
%>
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=WtcUtil.formatNumber(Prepay_Fee,2)%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%	
		String chinaFee = result1[0][2];   	//��д���
		System.out.print(chinaFee);
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<script language="JavaScript">
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}	
   rdShowMessageDialog("ȷ�ϳɹ�! ",2);
   //var infoStr="";
   //var gift_code= Number(<%=request.getParameter("Gift_Code")%>);

   //infoStr+="<%=work_no%>  <%=work_name%>"+"       ����ͳһԤ������"+"|";//����
   //infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   //infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   //infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   //infoStr+='<%=cust_name%>'+"|";
   //infoStr+=" "+"|";
   //infoStr+='<%=paraAray[3]%>'+"|";
   //infoStr+=" "+"|";//Э�����
   //if( "<%=org_code.substring(0,2)%>"=="13" &&  "<%=request.getParameter("projectType")%>" == "0004" ){
   //		infoStr+=" "+"|";
   //}
   //else if( "<%=org_code.substring(0,2)%>"=="13" && "<%=request.getParameter("projectType")%>" == "0005" && "<%=request.getParameter("Gift_Code")%>"=="0001" )
   //{
   //    infoStr+=" "+"|";
   //}
   //else if( "<%=org_code.substring(0,2)%>"=="13" && "<%=request.getParameter("projectType")%>" == "0006" && gift_code>=1 && gift_code <=8 )
   //{
   // 	 infoStr+=" "+"|";
   //}
   //else{
   //		infoStr+="������Ԥ����"+"|";
   //}//9֧Ʊ��

   //infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
   //infoStr+="<%=WtcUtil.formatNumber(Prepay_Fee,2)%>"+"|";//Сд
   //infoStr+="Ԥ���<%=WtcUtil.formatNumber(Prepay_Fee,2)%>Ԫ    "+
	//	 "���е���Ԥ�棺"+"<%=Base_Fee%>Ԫ���Ԥ�棺"+"<%=Free_Fee%>Ԫ"+"|";


	 //infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 //infoStr+=" "+"|";//�տ���
	 //infoStr+=" "+"|";//�տ���

	 //if( "<%=org_code.substring(0,2)%>"=="13" && "<%=request.getParameter("projectType")%>" == "0004"  )
	 //{
	 //	 infoStr+="�˻Ԥ������"+"<%=Consume_Term%>"+"���£��ڼ䲻�ܲμ��������Ԥ���˲�ת������תǩ�ʷѡ�"+"|";
	 //}
	 //else if( "<%=org_code.substring(0,2)%>"=="13" && "<%=request.getParameter("projectType")%>" == "0005" && "<%=request.getParameter("Gift_Code")%>"=="0001" )
	 //{
	 //	 infoStr+="Ԥ����100Ԫ������80Ԫ��8���·�����Ԥ���˲�ת��"+"|";
	 //}
	 //else if( "<%=org_code.substring(0,2)%>"=="13" && "<%=request.getParameter("projectType")%>" == "0006" && gift_code>=1 && gift_code <=8 )
	 //{
	 //	 infoStr+="Ԥ����<%=WtcUtil.formatNumber(Prepay_Fee,2)%>Ԫ������120Ԫ��12���·�����Ԥ���˲�ת"+"|";
	 //}
	 //else if( "<%=org_code.substring(0,2)%>"=="08" && "<%=request.getParameter("projectType")%>" == "0012" )
   	 //{
	 //	 infoStr+="���ɷ�<%=WtcUtil.formatNumber(Prepay_Fee,2)%>Ԫ��������Ʒһ�ݣ����ɻ��Ѳ��˲�ת"+"|";
   	 //}
	 //else
	 //{
	 //	infoStr+=" "+"|";//�տ���
	 //}
	 //dirtPate = "/npage/s1141/f6949_login.jsp;
	 window.location="/npage/s1141/f6949_login.jsp?activePhone=<%=paraAray[3]%>&opCode=6949&opName=����ͳһԤ������";
    //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("����ͳһԤ������ʧ��!(<%=errMsg%>",0);
	window.location="/npage/s1141/f6949_login.jsp?activePhone=<%=paraAray[3]%>&opCode=6949&opName=����ͳһԤ������";
</script>
<%}%>
