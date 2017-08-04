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
	String[][] password1 = (String[][])arr.get(4);//读取工号密码 
	String pass = password1[0][0];
	
	String paraAray[] = new String[7];
	 
 
	String phoneNo ="";
	String in_money="";
	String password =""; //个人的密
	phoneNo = request.getParameter("phone_no");
	
    String czkkh = request.getParameter("czkkh");
	String czkmz = request.getParameter("czkmz");
	
	String ppsCardPin = request.getParameter("ppsCardPin");
 
	String opNote = "赠送充值卡充值";
	String phone_ori = request.getParameter("phone_no");
	//String cmd_str = phoneNo + "~" + password + "~" + ppsCardPin;
	String cmd_str = phoneNo + "~"  + ppsCardPin;
	String cardNo = request.getParameter("cardNo");
	String rownum = request.getParameter("rownum");
	String mz =  request.getParameter("mz");
	System.out.println("WWWWWWWWWWWWWWWWWWWWWWWWWWfinal tcmd_str is "+cmd_str+" work_no is "+work_no+" and pass is "+pass+" and org_code is "+org_code+" and phoneNo is "+phoneNo+" cmd_str is "+cmd_str+" and opNote is  "+opNote+" and cardNo is "+cardNo);
	paraAray[0]="e384"; 
	paraAray[1]=work_no;
	paraAray[2]=phoneNo;
	paraAray[3]=mz;//面值
	paraAray[4]=cardNo;
	paraAray[5]=mz;//面值
	paraAray[6]=cmd_str;
	
	
	// add插入表
	String[] retNew = impl.callService("bs_e384Cfm",paraAray,"2" );
	int errCodeNew;
	String errMsgNew;
	errCodeNew = impl.getErrCode();
	errMsgNew = impl.getErrMsg();
	 
	if (errCodeNew == 0 )
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("用户充值成功！");
	window.location="e384_1.jsp?activePhone="+"<%=phone_ori%>"+"&opCode="+"e384"+"&opName="+"赠送充值卡充值"+"&final_flag=0"+"&rownumNew="+"<%=rownum%>";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("用户充值失败!(<%=errMsgNew%>");
	//window.location="e384_1.jsp?activePhone="+"<%=phone_ori%>"+"&opCode="+"e384"+"&opName="+"赠送充值卡充值"+"&final_flag=1";
	window.location="e384_1.jsp?activePhone="+"<%=phone_ori%>"+"&opCode="+"e384"+"&opName="+"赠送充值卡充值"+"&final_flag=0"+"&rownumNew="+"<%=rownum%>";
</script>
<%}%>
	 
