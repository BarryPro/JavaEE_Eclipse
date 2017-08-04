<%
  /*
   * 功能: 充值有礼7162
   * 版本: 1.8.2
   * 日期: 2003-12-08 
   * 作者: yuanby
   * 版权: si-tech
   * update:leimd@2008-12-1
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String opCode = "7162";
	String opName = "充值有礼";
	String[][] result = new String[][]{};
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
	//ArrayList retArray = new ArrayList();
	
//	ArrayList arr = (ArrayList)session.getAttribute("allArr");
//	String[][] baseInfo = (String[][])arr.get(0);
//	String work_no = baseInfo[0][2];
//	String work_name = baseInfo[0][3];
//	String org_code = baseInfo[0][16];
	String work_no = (String)session.getAttribute("workNo");
  String work_name = (String)session.getAttribute("workName");
  String org_code = (String)session.getAttribute("orgCode");
	
	String sendlist = request.getParameter("sendlist");
	String moneylist = request.getParameter("moneylist");
	String numberlist = request.getParameter("numberlist");
	String login_accept = request.getParameter("login_accept");
	System.out.println("sendlist="+sendlist);
	System.out.println("moneylist="+moneylist);
	System.out.println("numberlist="+numberlist);
	System.out.println("login_accept="+login_accept);
	StringTokenizer token=new StringTokenizer(sendlist,"|");
	int length=token.countTokens();
	String strArr[] = new String [length];
	
	String [] res_code = new String [length];
	String [] child_code = new String [length];
	
	int i=0;
	while (token.hasMoreElements()){
		strArr[i]=(String)token.nextElement();
		String temArr[] = strArr[i].split(",");
		res_code[i]=temArr[2];
		child_code[i]=temArr[1];
	i++;
	}
	
	StringTokenizer token_money=new StringTokenizer(moneylist,"|");
	String [] d_money = new String [token_money.countTokens()];
	int j=0;
	while (token_money.hasMoreElements()){
		d_money[j]=(String)token_money.nextElement();
		j++;
		}
		
	StringTokenizer token_number=new StringTokenizer(numberlist,"|");
	String [] number = new String [token_number.countTokens()];
	int k=0;
	while (token_number.hasMoreElements()){
		number[k]=(String)token_number.nextElement();
		k++;
		}		
	
	ArrayList paraAray = new ArrayList();
	paraAray.add("");//操作流水(可空)
	paraAray.add("7162");//操作代码
	paraAray.add(work_no);//工号
	paraAray.add(request.getParameter("opNote"));//备注
	paraAray.add(request.getRemoteHost());//ip
	paraAray.add(request.getParameter("phoneNo"));//手机号码
	paraAray.add(res_code);//促销品代码
	paraAray.add(d_money);//抵值金额
	paraAray.add(child_code);//
	paraAray.add(number);//
	String phoneNo = request.getParameter("phoneNo");
	String opNote = request.getParameter("opNote");
	String host = request.getRemoteHost();
	
	//String[] ret = impl.callService("s7162Cfm",paraAray,"2");
%>
    <wtc:service name="s7162Cfm"  routerKey="phone" routerValue="<%=phoneNo%>" retcode="error_code" retmsg="error_msg" outnum="2" >
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="7162"/>
		<wtc:param value="<%=work_no%>"/> 
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=host%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:params value="<%=res_code%>"/>
		<wtc:params value="<%=d_money%>"/> 
		<wtc:params value="<%=child_code%>"/>
		<wtc:params value="<%=number%>"/> 
	  </wtc:service>
<%
String errorcode="";
if(error_code.equals("0")){
	errorcode="000000";
}else{
	errorcode=error_code;	
}
String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errorcode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+login_accept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+error_msg+"&opBeginTime="+opBeginTime+"&contactId="+phoneNo+"&contactType=user"; 
 System.out.println("error============================"+error_code);
	String errCode = error_code;
 System.out.println("error============================"+errCode);
	String errMsg = error_msg;
	if (errCode.equals("0")||errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("领奖成功！",2);
   location="f7162_1.jsp?activePhone=<%=phoneNo%>&opCode=7162&opName=充值有礼";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true" />
