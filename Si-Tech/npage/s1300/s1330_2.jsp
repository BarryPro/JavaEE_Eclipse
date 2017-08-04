<%
	/********************
	 version v2.0
	开发商: si-tech
	update:zhaoht@2009-03-10 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>

<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
    
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String orgcode = (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode");
	
	
	String opCode = request.getParameter("opcode");
	String opName=request.getParameter("opName");
	
	System.out.println("1330opName======"+opName);
	//定义变量
	//输入参数：工号、流水号、信息串、操作类型，帐务日期。
	String billdate  = request.getParameter("billdate");//帐务日期
	String opcode    = request.getParameter("opcode");//操作码
	String optype	 = request.getParameter("optype");//操作类型
	String lines = request.getParameter("lines");
	//System.out.println("lines ---:"+lines);
	if (optype.equals("2")){
		lines = "1";
	}
	
	String[] cardtype2=new String[]{};
	String[] card_begin_no2=new String[]{};
	String[] card_end_no2=new String[]{};
	String[] card_number2=new String[]{};
	String[] should_sum2=new String[]{};
	String[] real_income2=new String[]{};
	
	String cardtype1="";
	String card_begin_no1="";
	String card_end_no1="";
	String card_number1="";
	String should_sum1="";
	String real_income1="";
	
	if (lines.equals("1")==false) {
		cardtype2 = request.getParameterValues("card_price");
		card_begin_no2 = request.getParameterValues("card_begin_no");
		card_end_no2 = request.getParameterValues("card_end_no");
		card_number2 = request.getParameterValues("card_number");
		should_sum2 = request.getParameterValues("should_sum");
		real_income2 = request.getParameterValues("real_income");
	}
	else {
		cardtype1 = request.getParameter("card_price");
		card_begin_no1 = request.getParameter("card_begin_no");
		card_end_no1 = request.getParameter("card_end_no");
		card_number1 = request.getParameter("card_number");
		should_sum1 = request.getParameter("should_sum");
		real_income1 = request.getParameter("real_income");
	}
	String infomsg = "";
	String succinfo = "";
	String failinfo = "";
	String cardkind = "";
	
	
	if (optype.equals("1")==true) {
		succinfo = "有价卡销售成功，";
		failinfo = "有价卡销售失败！";
	}
	else if (optype.equals("2")==true) {
		succinfo = "有价卡回退成功，";
		failinfo = "有价卡回退失败！";
	}
	
	String waternumber = request.getParameter("water_number");//流水号
	if (waternumber==null){
		waternumber = "";
	}
	if (lines.equals("1")==false) {
		for (int i=0;i< cardtype2.length;i++) {
			cardkind = cardtype2[i].substring(0,2);
			infomsg  = infomsg+cardkind+"|"+
						card_begin_no2[i]+"|"+
						card_end_no2[i]+"|"+
						card_number2[i]+"|"+
						should_sum2[i]+"|"+
						real_income2[i]+"|"+"#";
		}
	}
	else {
	cardkind = cardtype1.substring(0,2);
	infomsg  = infomsg+cardkind+"|"+
					   card_begin_no1+"|"+
					   card_end_no1+"|"+
					   card_number1+"|"+
					   should_sum1+"|"+
					   real_income1+"|"+"#";
	}
	//System.out.println("totaldate :"+billdate);
	//System.out.println("opcode :"+opcode);
	//System.out.println("optype :"+optype);
	//System.out.println("workno :"+workno);
	//System.out.println("loginaccept :"+waternumber);
	//System.out.println("infomsg :"+infomsg);
	ArrayList arlist = new ArrayList();
	
	String [][] result = new String[][]{};
	String    iErrorNo ="";
	String    sErrorMessage = " ";
	String    sReturnCode = "";
	int   	  flag = 0;
	String newloginaccept = "";
	String newtotaldate = "";
	String error_msg = "";
	
	try
	{
		//arlist = viewBean.s1330Save(optype,billdate,waternumber,workno,orgcode,opcode,infomsg);
%>
		<wtc:service name="s1330_save" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
		<wtc:param value="<%=optype%>"/>	
		<wtc:param value="<%=billdate%>"/>	
		<wtc:param value="<%=waternumber%>"/>	
		<wtc:param value="<%=workno%>"/>	
		<wtc:param value="<%=orgcode%>"/>	
		<wtc:param value="<%=opcode%>"/>	
		<wtc:param value="<%=infomsg%>"/>	
		</wtc:service>	
		<wtc:array id="resultTemp"  scope="end"/>
<%
		result = resultTemp;
		iErrorNo = result[0][0];
		sErrorMessage = result[0][1];
		error_msg = retMsg1;
		System.out.println("-------------------------"+resultTemp.length);
	}
	catch(Exception e)
	{
		System.out.println("调用发生失败！");
	}
		//result = (String [][])arlist.get(0);

		System.out.println("1330iErrorNo="+iErrorNo);
		System.out.println("1330error_msg="+error_msg);
		
		if (iErrorNo.equals("000000")==false)
		{
            flag = -1;
		}

	// 判断处理是否成功
	if (flag == 0)
	{
		//System.out.println(succinfo+" !");
		newloginaccept = result[0][2];
	}
	else
	{
		//System.out.println(failinfo+" 请检查 !");
	}
	
%>
<SCRIPT type="text/javascript">
function ifprint(){
     <% 

     if (flag == 0){%>
    if(rdShowConfirmDialog("<%=succinfo%>是否打印发票?")==1)
	{
		frm_print_invoice.submit();
	}
	else {document.location.replace("s1330.jsp?opCode=<%=opCode%>&opName=<%=opName%>");}
    <%}
    else{%>
    rdShowConfirmDialog("<%=failinfo%><br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=error_msg%>'。",0);
    history.go(-1);
    <%}
     %>
} 						
</SCRIPT>
<html xmlns="http://www.w3.org/1999/xhtml">
<body onload="ifprint()">
<form action="s1330_print.jsp" name="frm_print_invoice" method="post">
<INPUT TYPE="hidden" name="print_work_no" value="<%=workno%>">
<INPUT TYPE="hidden" name="print_billdate" value="<%=billdate%>">
<INPUT TYPE="hidden" name="print_login_accept" value="<%=newloginaccept%>">
<INPUT TYPE="hidden" name="opCode" value="<%=opCode%>">
<INPUT TYPE="hidden" name="opName" value="<%=opName%>">
</form>
</body>
</html>


