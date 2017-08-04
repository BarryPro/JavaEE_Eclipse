<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page errorPage="/page/common/error.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
  Logger logger = Logger.getLogger("f2226_2.jsp");
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
	String note = workNo+"进行帐单减免操作";
  String opCode = "2226";
  String busyType=request.getParameter("busyType");
  
  String feeCodeStr = request.getParameter("feeCodeStr");
  String detailCodeStr = request.getParameter("detailCodeStr");
  String derateFeeStr = request.getParameter("derateFeeStr");
  String yearMonthStr = request.getParameter("yearMonthStr");
  String billDateStr = request.getParameter("billDateStr");
  String billTypeStr = request.getParameter("billTypeStr");
  
  StringTokenizer feeCode_token = new StringTokenizer(feeCodeStr, "|");
  StringTokenizer detailCode_token = new StringTokenizer(detailCodeStr, "|");
  StringTokenizer derateFee_token = new StringTokenizer(derateFeeStr, "|");
  StringTokenizer yearMonth_token = new StringTokenizer(yearMonthStr, "|");
  StringTokenizer billDate_token = new StringTokenizer(billDateStr, "|");
  StringTokenizer billType_token = new StringTokenizer(billTypeStr, "|");
  
  int len = feeCode_token.countTokens();
  
  String[] feeCodeArr = new String[len];
  String[] detailCodeArr = new String[len];
  String[] derateFeeArr = new String[len];
  String[] yearMonthArr = new String[len];
  String[] billDateArr = new String[len];
  String[] billTypeArr = new String[len];
  
  for(int n=0;feeCode_token.hasMoreElements();n++)
	{
		feeCodeArr[n] 	 = (String)feeCode_token.nextElement();
		detailCodeArr[n] = (String)detailCode_token.nextElement();
		derateFeeArr[n]=(String)derateFee_token.nextElement();
		yearMonthArr[n]=(String)yearMonth_token.nextElement();
		billDateArr[n]=(String)billDate_token.nextElement();
		billTypeArr[n]=(String)billType_token.nextElement();
	}
	
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList al = new ArrayList();
	
	al.add(new String[]{contract_no});
	al.add(new String[]{phoneno});
	al.add(new String[]{note});
	al.add(new String[]{workNo});
	al.add(new String[]{opCode});
	al.add(new String[]{busyType});
	
	al.add(feeCodeArr);
	al.add(detailCodeArr);
	al.add(derateFeeArr);
	al.add(yearMonthArr);
	al.add(ip_Addr);
	al.add(billDateArr);
	al.add(billTypeArr);
	callView.callService("s2226", al, "1");
	callView.printRetValue();
		
	int errCode = callView.getErrCode();
	String errMsg = callView.getErrMsg();
	
	if(errCode==0){
	%>
	<script language='jscript'>
		rdShowMessageDialog("操作成功！");
		document.location.replace("f2226_1.jsp?activePhone=<%=activePhone%>");
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