<%@ page contentType="text/html;charset=gb2312"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

 

<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();	
	ArrayList arr = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfo = (String[][])arr.get(0);
	String work_no = baseInfo[0][2];
	String work_name = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String[][] password1 = (String[][])arr.get(4);//��ȡ�������� 
	String pass = password1[0][0];
	
	String paraAray[] = new String[9];
	 
 
	String phoneNo ="";
	String in_money="";
	String password =""; //���˵���
	phoneNo = request.getParameter("phoneNo");//�ֻ�����
	
  
	String czkmz = request.getParameter("kmz");//����ֵ
	
	String ppsCardPin = request.getParameter("kmm");//������
 
	String opNote = "���ſͻ��ֹ���ֵ";
 
	//String cmd_str = phoneNo + "~" + password + "~" + ppsCardPin;
	String cmd_str = phoneNo + "~"  + ppsCardPin;
	String cardNo = request.getParameter("cardNo");//����
	//new ����id
	String grpId = request.getParameter("grpId");
	String grpName = request.getParameter("grpName");
	paraAray[0]="e470"; 
	paraAray[1]=work_no;
	paraAray[2]=phoneNo;
	paraAray[3]=czkmz;//��ֵ
	paraAray[4]=cardNo;
	paraAray[5]=czkmz;//��ֵ
	paraAray[6]=cmd_str;
	paraAray[7]=grpId;
	paraAray[8]=grpName;
	
	// add�����
	String[] retNew = impl.callService("bs_e384Cfm",paraAray,"2" );
	int errCodeNew;
	String errMsgNew;
	errCodeNew = impl.getErrCode();
	errMsgNew = impl.getErrMsg();
	 
	if (errCodeNew == 0 )
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("�û���ֵ�ɹ�!");
	window.location="e470_1.jsp?opCode="+"e470"+"&opName="+"���ſͻ���ֵ���ֹ���ֵ";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("�û���ֵʧ��!(<%=errMsgNew%>)");
	window.location="e470_1.jsp?opCode="+"e470"+"&opName="+"���ſͻ���ֵ���ֹ���ֵ";
 
</script>
<%}%>
	 
