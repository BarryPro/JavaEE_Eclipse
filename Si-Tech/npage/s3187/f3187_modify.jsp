<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-2-13
********************/
%>
<%
  String opCode = "3187";
  String opName = "帐户关系维护";
%>              


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
	
<%@ include file="/npage/include/public_title_name.jsp" %>  
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.util.*"%>

<%
	Logger logger = Logger.getLogger("f3187_modify.jsp");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

	
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String workNo = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");
	String loginPass  = (String)session.getAttribute("password");

	String contractPay = request.getParameter("contractPay");	//支付帐户
	String contractNo = request.getParameter("contractNo");		//被支付帐户
	
	String op_name = "帐户关系维护-修改";
%>


<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
</head> 
<%
String all_flag="";
String cycle_money="";
String begin_date="";
String end_date="";
String pay_order="";


String sqlStr1="";
sqlStr1 ="select all_flag,cycle_money,begin_date,end_date,,pay_order from dconconmsg where contract_pay='"+contractPay+"' and contract_no='"+contractNo+"'";
System.out.println(sqlStr1);
//acceptList = impl.sPubSelect("4",sqlStr1,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%
String errCode=code;
String errMsg=msg;

if(!errCode.equals("000000"))
{
	%>        
    <script language='jscript'>
       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
       history.go(-1);
    </script> 
	<%  
}			
if(errCode.equals("000000"))
{
	String[][] retListString1 = result_t1;
	System.out.println("retListString1.length;"+retListString1.length);
	if(retListString1.length!=0){
		all_flag=retListString1[0][0];
		cycle_money=retListString1[0][1];
		begin_date=retListString1[0][2];
		end_date=retListString1[0][3];
		pay_order=retListString1[0][4];
	}
}
%>
<script language=javascript>
	
	function fsubmit1() //提交
	{	
		getAfterPrompt();	
		if(!check(document.all.form1)) return false;

		
		if(!forDate(document.all.beginDate)) return false;		
		
		if(!forDate(document.all.endDate)) return false;		
		
		if(parseInt(document.form1.beginDate.value) > parseInt(document.form1.endDate.value))
		{
			rdShowMessageDialog("结束日期应大于开始日期",0);
			return false;
		}
		document.form1.action="f3187_modifySub.jsp"; 
		document.form1.submit();
	}
	
	//检测:只能输入数字
	function isKeyNumberdot(ifdot) 
	{
	    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
		if(ifdot==0)
			if(s_keycode>=48 && s_keycode<=57)
				return true;
			else 
				return false;
	    else
	    {
			if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
			{
			      return true;
			}
			else if(s_keycode==45)
			{
			    rdShowMessageDialog('不允许输入负值,请重新输入!');
			    return false;
			}
			else
				  return false;
	    }
	}	

	


	function changeFlag(){
		if(document.all.allFlag.value=="1"){
			document.all.line_111.style.display="none";
			document.all.cycleMoney.value="0";
		}
		else{
			document.all.line_111.style.display="";
			document.all.cycleMoney.value="";
		}
	}


</script>


<body>


	

     	<form name="form1" method="post" action="">
     		<%@ include file="/npage/include/header_pop.jsp" %>                         
	<div class="title">
		<div id="title_zi">帐户关系维护</div>
	</div>
     <TABLE  id="mainOne"  cellspacing="0">

	<input type="hidden" name="workNo" value="<%=workNo%>">
	<input type="hidden" name="loginPass" value="<%=loginPass%>">
		<input type="hidden" name="yearmonth"  value="<%=dateStr%>">		
          <TBODY>
        		<TR  id="line_1"> 
							<TD width=124 height = 20 class="blue">支付帐号</TD>
            	<TD  height = 20>
              	<input type="text" readOnly name="contractPay" value="<%=contractPay%>">
            	</TD>
							<TD width=10% height = 20  class="blue">被支付帐号</TD>
	            <TD  height = 20>
	              <input type="text" readOnly name="contractPay2" value="<%=contractNo%>">
	            </TD>
            </TR>
             <TR  id="line_1"> 		  
             <TD width=10% height = 20 class="blue">支付顺序</TD>
	            <TD width=20% height = 20 colspan=3 >
	              	<input type="text"  v_type="int"  v_must="1" v_minlength="1" v_maxlength="10" v_name="支付顺序"  name="payOrder" maxlength="10" value="<%=pay_order%>">&nbsp;<font color="#FF0000">*</font>
	            </TD> 
	          </TR>   
         	<TR  id="line_1"> 
				<TD colspan="4"% height = 20 >&nbsp;</TD>
            </TR>
            <TR  id="line_1"> 		
			    <TD width=10% height = 20  class="blue">全额标志</TD>
	            <TD width=20% height = 20 colspan=3>	              	
	            	<select name="allFlag" onchange="changeFlag()">	            		
	              		<option value="0">定额交费</option>
	              		<option value="1">全额交费</option>
	              	</select>&nbsp;<font class="orange">*</font>
	            </TD>
	          </TR> 
	         <TR  id="line_111">    	              
	            <TD width=10% height = 20  class="blue">定额金额</TD>
	            <TD height = 20 colspan=3>
	              	<input type="text"  v_type="money"  v_must="1" v_minlength="1" v_maxlength="14" v_name="定额金额"  name="cycleMoney" maxlength="14" value="<%=cycle_money%>">&nbsp;<font class="orange">*</font>
	            </TD>
	         </TR>
	         
	         <TR  id="line_1"> 
				<TD width=10% height = 20  class="blue">开始日期</TD>
	            <TD width=20% height = 20>
	              	<input type="text"  v_type="date"  name="beginDate" maxlength="8" value="<%=dateStr%>" readOnly v_format="yyyymmdd">&nbsp;(格式:yyyymmdd)&nbsp;<font class="orange">*</font>            	
	            </TD> 			
			    <TD width=10% height = 20  class="blue">结束日期</TD>
	            <TD width=20% height = 20>
	              	<input type="text"  v_type="date"  name="endDate" maxlength="8" value="<%=end_date%>"  v_format="yyyymmdd">&nbsp;(格式:yyyymmdd)&nbsp;<font class="orange">*</font>  
	            </TD> 		            	              
	         </TR>
          </TBODY>
        </TABLE> 
		<TABLE cellSpacing= "0">
				 <TR >
		         	<TD height="30" align="center" id="footer"> 
		         	    <input name="bSubmit1" style="cursor:hand" type="button"  value="确认" onClick="fsubmit1()" class="b_foot">
		         	    &nbsp;
		         	    <input name="cancel" style="cursor:hand" type="button"  value="重置"  class="b_foot" onClick="javascript:window.location.reload();">
		         	    &nbsp; 
		         	    <input name="" style="cursor:hand" type="button"  value="关闭" onClick="window.close();" class="b_foot">
		         	    &nbsp; 		         	     	         	   
				 	</TD>
		       </TR>
	    </TABLE>	
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<script language='javascript'>
	if("<%=all_flag%>"==1){
		document.all.allFlag.value="1";
		changeFlag();
	}
</script>