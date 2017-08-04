<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../page/common/pwd_comm.jsp" %>
<%@ page import="com.sitech.boss.s1310.viewBean.*" %>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
String workno = baseInfo[0][2];
String workname = baseInfo[0][3];
String orgcode = baseInfo[0][16];//机构代码

//定义变量
//输入参数：workno,nopass,orgcode,opcode,contractno,phoneno,billmonth,total_pay,pay_detail,note      
//之前是
//xl 修改
 String phoneno  = request.getParameter("phone_kd");
String contractno  = request.getParameter("contractno");
String opcode    = "zg66";//操作码
String opCode = "zg66"  ;
String opName = "铁通宽带补收"  ;
String billmonth = request.getParameter("billmonth");
String total_pay = request.getParameter("total_pay");
String remark = request.getParameter("remark");
String lines = request.getParameter("lines");
String dealType = request.getParameter("dealType");
String balanceType = request.getParameter("balanceType");
if (remark == null || remark.equals("")) {
remark = phoneno+"费用补收:"+total_pay;}
String nopass="111111";
String[] feename2=new String[] {};
String[] feedetail2 = new String[]{};
String feename = ""; 
String feedetail = "";
String feestr = "";

if (lines.equals("1")==false) {
feedetail2 = request.getParameterValues("fee_detail");
feename2 = request.getParameterValues("fee_name");
}
else {
feename = request.getParameter("fee_name");
feedetail = request.getParameter("fee_detail");
}

if (lines.equals("1")==false) {
for (int i=0;i< feedetail2.length;i++) {
feestr=feestr+feename2[i]+"|"+feedetail2[i]+"|"+"#";
}
}

else {
feestr=feestr+feename+"|"+feedetail+"|"+"#";
}

//System.out.println("contractno :"+contractno);
//System.out.println("opcode :"+opcode);
//System.out.println("workno :"+workno);
//System.out.println("phoneno :"+phoneno);
//System.out.println("remark :'"+remark+"'");
//System.out.println("total_pay :'"+total_pay+"'");
//System.out.println("feestr :'"+feestr+"'");
//System.out.println("remark :'"+remark+"'");

ArrayList arlist = new ArrayList();
 
String [][] result = new String[][]{};

String paraAray[] = new String[12];
String[] ret=new String[2];
String    iErrorNo ="";
String    sErrorMessage = " ";
String    sReturnCode = "";
int   	  flag = 0;
String newloginaccept = "";
String total_date = "";

	paraAray[0]=workno;
	paraAray[1]=nopass;
	paraAray[2]=orgcode;
	paraAray[3]=opcode;
	paraAray[4]=contractno;
	paraAray[5]=phoneno;
	paraAray[6]=billmonth;
	paraAray[7]=total_pay;
	paraAray[8]=feestr;
	paraAray[9]=remark;
	paraAray[10]=dealType;
	paraAray[11]=balanceType;
	%>
	<wtc:service name="s2201Cfm" retcode="retCode4" retmsg="retMsg4" outnum="2">
				<wtc:params value="<%=paraAray%>"/> 
		</wtc:service>
		<wtc:array id="results" scope="end" />
	
	<%
		//result = (String [][])ret.get(0);
		result=results;
		iErrorNo =results[0][0];
		System.out.println("eeeeeeeeeeeeeeeeeeeeeeeeee*********:'"+iErrorNo+"'");
		//sErrorMessage = result[0][1];
		//String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(iErrorNo));
		//int errCode = impl.getErrCode();
		//String errMsg = impl.getErrMsg();
		if (!iErrorNo.equals("000000") && (iErrorNo!="000000"))
		{	
			sErrorMessage =ret[1];
			//System.out.println(" 错误代码 : " + iErrorNo);
			//System.out.println(" 错误信息 : " + sErrorMessage);
            flag = -1;
		}

	// 判断处理是否成功
	if (flag == 0)
	{
		//System.out.println("success!");
	}
	else
	{
		//System.out.println("failed, 请检查 !");
	}
	
%>

<SCRIPT type=text/javascript>
function ifprint(){
     <% 

     if (flag == 0){%>
    alert("铁通宽带费用补收成功。");
	window.location.href="zg66_1.jsp";
    <%}
    else{%>
    alert("铁通宽带费用补收失败。<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
    history.go(-1);
    <%}
     %>
} 						
</SCRIPT>
<html>
<body onload="ifprint()">
 
<INPUT TYPE="hidden" name="print_work_no" value="<%=workno%>">
<INPUT TYPE="hidden" name="print_nopass" value="<%=orgcode%>">
</form>
</body></html>


