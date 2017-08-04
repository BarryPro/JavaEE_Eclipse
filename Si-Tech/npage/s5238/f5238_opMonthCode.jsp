<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-19
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                    	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String detail_code = request.getParameter("detail_code");
	String note = request.getParameter("note");	
	String region_code = request.getParameter("region_code");
 	String typeButtonNum = request.getParameter("typeButtonNum");
 	
 	int errCode=0;
    String errMsg="";
 	
 	//获取所有的优惠信息
 	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList retArray = new ArrayList();
	String[] paramsIn=new String[6];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]=detail_code;
	
	retArray=callView.callFXService("s5238_MonthQry",paramsIn,"6");	
	callView.printRetValue();
	errCode = callView.getErrCode();
	errMsg = callView.getErrMsg();
	
	String[][]sOut_month_flag=(String[][])retArray.get(0);
	String[][]sOut_month_fee =(String[][])retArray.get(1);
	String[][]sOut_day_flag  =(String[][])retArray.get(2);
	String[][]sOut_day_fee   =(String[][])retArray.get(3);
	String[][]sOut_acc_detail=(String[][])retArray.get(4);
	String[][]sOut_acc_detail_name=(String[][])retArray.get(5);
	if(errCode != 0)
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        history.go(-1);
        </script>
<%	} 
%>

<html>
<head>
<base target="_self">
<title>月租优惠配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 

//-----提交配置月租优惠配置-----
function doSubmit()
{	
	document.form1.action="f5238_opMonthCode_submit.jsp"; 
	document.form1.submit();
}

//-----计算日费用-----
function minusDayFee0()
{	
		if(!checkElement("month_fee")) 
    {
      document.all.month_fee.focus();
	    return;
    }
    
    document.all.day_fee.value = "0";
    
}

function minusDayFee1()
{	
		if(!checkElement("month_fee")) 
    {
      document.all.month_fee.focus();
	    return;
    }
    
    /* 日费用=月费用*12/365 */
    var monthFee = parseInt(document.all.month_fee.value);
    var dayFee = monthFee * 120000 / 365;
    var dayFee = Math.round(dayFee);
    document.all.day_fee.value = dayFee/10000;
}

//选择一级账目项
function queryFeeCode()
{
	var retToField = "fee_code|fee_name|";
	var url = "f5238_queryFeeCode.jsp?retToField="+retToField;
    window.open(url,'','height=600,width=500,scrollbars=yes');	
}
//选择二级账目代码
function queryAccDetail()
{
	if(document.all.fee_code.value=="") 
    {
        rdShowMessageDialog("请选择一级账目项!");
	    return;
    }
	var retToField = "acc_detail|acc_detail_name|";
	var url = "f5238_queryFeeDetailCode.jsp?fee_code="+document.all.fee_code.value+"&retToField="+retToField;
    window.open(url,'','height=600,width=500,scrollbars=yes');	
}
</script>
</head>

<body   onMouseDown="hideEvent()" onKeyDown="hideEvent()">

	  <form name="form1"  method="post">
	  		<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">产品（<%=mode_code%>）月租优惠配置</div>
	</div>

 
	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="detail_code" value="<%=detail_code%>">
	  <input type="hidden" name="note" value="<%=note%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  <input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">
	  		  	<TABLE   id="mainOne" cellspacing="0" >
	            <TBODY>
	  				<tr >
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;优惠代码</TD>
	  					<TD width="80%">
	  						<%=detail_code%>
	  					</TD>
	  				</tr>
	  				<tr  >
	  					<TD height="22" class="blue">&nbsp;&nbsp;优惠描述</TD>
	  					<TD>
	  						<%=note%>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;帐务月周期</TD>
	  					<TD>
	  					<input type=text  v_type="int" v_must=1 v_minlength=1 v_maxlength=4 v_name="帐务月周期" name=month_flag maxlength=4 value="<%=sOut_month_flag[0][0]%>"></input> <font color="red">(单位月)</font>
	 	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;按月收费用</TD>
	  					<TD>
	  						<input type=text  v_type="float" v_must=1 v_minlength=1 v_maxlength=15 v_name="按月收费用" name=month_fee maxlength=15 value="<%=sOut_month_fee[0][0]%>"></input> <font color="red">(单位元)</font>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;按日收取标识</TD>
	  					<TD>
	  						<input type="radio" onclick="minusDayFee0()" name="day_flag" value="0" <%=sOut_day_flag[0][0].equals("0")==true?"checked":""%><%=sOut_day_flag[0][0].equals("")==true?"checked":""%>>按月收
	  						<input type="radio" onclick="minusDayFee1()" name="day_flag" value="1" <%=sOut_day_flag[0][0].equals("1")==true?"checked":""%>>按日收
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;按日收费用</TD>
	  					<TD>
	  						<input type=text  v_type="float" v_must=1 v_minlength=1 v_maxlength=15 v_name="按日收取费用" name=day_fee maxlength=15 value="<%=sOut_day_fee[0][0]%>"></input> <font color="red">(单位元)</font>
	  					</TD>
	  				</tr>
					<tr >
	  					<TD class="blue">&nbsp;&nbsp;一级账目项</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=0 v_maxlength=5 v_name="一级账目项" name=fee_code maxlength=5 size="5" value="" ></input>
	  						<input type=text  v_name="一级账目项" name=fee_name maxlength=40 value="" readonly></input>
	  						<input  type="button" name="query_feeCode" class="b_text" onclick="queryFeeCode()" value="选择">
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;二级账目项</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=5 v_name="二级账目项" name=acc_detail maxlength=5 size="5" value="<%=sOut_acc_detail[0][0]%>"></input>
	  						<input type=text  v_name="二级账目项" name=acc_detail_name maxlength=40 value="<%=sOut_acc_detail_name[0][0]%>"></input>
	  						<input  type="button" class="b_text" name="query_accdetail" onclick="queryAccDetail()" value="选择">
	  					</TD>
	  				</tr>
	            </TBODY>
	          	</TABLE>
	          	<TABLE   cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="nextButton" type="button" class="b_foot" value="确定" onClick="if (check(form1)) doSubmit()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button"  class="b_foot_long"  value="取消返回" onClick="window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;window.close()" >
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
</body>
</html>

