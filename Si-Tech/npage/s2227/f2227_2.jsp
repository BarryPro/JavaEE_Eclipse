<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page errorPage="/page/common/error.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
  Logger logger = Logger.getLogger("f2227_2.jsp");
  String activePhone = request.getParameter("actphone");
  ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               //工号姓名
	String belongName = baseInfo[0][16];
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //登陆密码
	String ip_Addr = request.getRemoteAddr();
  String contract_no=request.getParameter("contract_no");
	String phoneno=request.getParameter("phoneno");
	String note = workNo+"进行帐单减免恢复操作";
  String opCode = "2227";
  String busyType=request.getParameter("busyType");
  
  String accpetStr = request.getParameter("accpetStr");
  String derateFeeStr = request.getParameter("derateFeeStr");
  String billDayStr = request.getParameter("billDayStr");
  String billTypeStr = request.getParameter("billTypeStr");
  String feeCode2Str = request.getParameter("feeCode2Str");
  String detailCode2Str = request.getParameter("detailCode2Str");
  String monthStr = request.getParameter("monthStr");

  StringTokenizer accpet_token = new StringTokenizer(accpetStr, "|");
  StringTokenizer derateFee_token = new StringTokenizer(derateFeeStr, "|");
  StringTokenizer billDay_token = new StringTokenizer(billDayStr, "|");
  StringTokenizer billType_token = new StringTokenizer(billTypeStr, "|");
  StringTokenizer feeCode2_token = new StringTokenizer(feeCode2Str, "|");
  StringTokenizer detailCode2_token = new StringTokenizer(detailCode2Str, "|");
  StringTokenizer month_token = new StringTokenizer(monthStr, "|");
  
  int len = accpet_token.countTokens();  
  
  String[] accpetArr = new String[len];
  String[] derateFeeArr = new String[len];
  String[] billDayArr = new String[len];
  String[] billTypeArr = new String[len];
  String[] feeCode2Arr = new String[len];
  String[] detailCode2Arr = new String[len];
  String[] monthArr = new String[len];
  
  for(int n=0;accpet_token.hasMoreElements();n++)
	{
		accpetArr[n] 	 = (String)accpet_token.nextElement();
		derateFeeArr[n] 	 = (String)derateFee_token.nextElement();
		billDayArr[n] 	 = (String)billDay_token.nextElement();
		billTypeArr[n] 	 = (String)billType_token.nextElement();
		feeCode2Arr[n] 	 = (String)feeCode2_token.nextElement();
		detailCode2Arr[n] 	 = (String)detailCode2_token.nextElement();
		monthArr[n] 	 = (String)month_token.nextElement();
	}
	
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList al = new ArrayList();
	
	al.add(new String[]{contract_no});
	al.add(new String[]{phoneno});
	al.add(new String[]{note});
	al.add(new String[]{workNo});
	al.add(new String[]{opCode});
	al.add(new String[]{busyType});
	
	al.add(accpetArr);
	al.add(derateFeeArr);
	al.add(ip_Addr);
	al.add(billDayArr);
	al.add(billTypeArr);
	al.add(monthArr);
	al.add(feeCode2Arr);
	al.add(detailCode2Arr);
	
	callView.callService("s2227", al, "1");
	callView.printRetValue();
		
	int errCode = callView.getErrCode();
	String errMsg = callView.getErrMsg();
	
	if(errCode==0){
	%>
	<script language='jscript'>
		rdShowMessageDialog("操作成功！");
		document.location.replace("f2227_1.jsp?activePhone=<%=activePhone%>");
	</script>
	<%
	}
	else{
	%>
	<script language='jscript'>
		rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
		history.go(-1);
	</script>         
	<%
	}
%>