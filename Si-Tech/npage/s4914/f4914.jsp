<%
   /*
   * 功能: B-C/P类成员查询 - 主界面
　 * 版本: v1.0
　 * 日期: 2008/04/28
　 * 作者: hupp
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-15    qidp        新版集团产品改造
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>

<%	
	//读取用户session信息	
    String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));           //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                     //登陆密码	
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	Logger logger = Logger.getLogger("f4914.jsp");
	String op_name="B-C/P类成员查询";
	
	String opCode = "4914";
	String opName = "B-CP类成员查询";
%>	
	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>
	
	
function qryProdInfo()
{  
	
	if (document.all.custID.value==""){
		
		rdShowMessageDialog("请输入查询条件！");
		return false;

		}
   if(check(form1)){
   var custID = document.all.custID.value;
   var queType = document.all.queType.value;
   var queCondition = document.all.queCondition.value;
   
   if (queCondition=="0")
   {
   document.middle.location="f4914Info.jsp?custID="+custID+"&queType="+queType+"&queCondition="+queCondition;
   }
   else
   {
    document.middle.location="f4914Info2.jsp?custID="+custID+"&queType="+queType+"&queCondition="+queCondition;   	
   }
   }
}	


	
</script>

</head>

<body>
	<form action="" name="form1"  method="post">
		<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">B-CP类成员查询</div>
</div>
		<TABLE cellspacing="0" >
 			 <TR id="con2">
				<td class='blue' nowrap>查询类型</td>

	     		<td nowrap colspan='3'>  

		             <select name="queType">

	              		<option value="0">MAS/ADC类</option> 

	              		<option value="1">非MAS/ADC类</option> 	

	              	</select>

		          <font class='orange'>*</font>
			      </td>
		  </TR>
			  <TR>
			  	<td class='blue' nowrap>查询条件类型</TD>
	     		<td nowrap> 
		             <select name="queCondition">

	              		<option value="0">手机号码</option> 

	              		<option value="1">集团证件号码</option> 	

	              		<option value="2">集团编号</option> 			

		             </select>

		      <font class='orange'>*</font>

					 	</td>
		<td class='blue' nowrap>查询条件</TD>
          <TD>
          	<input name ="custID" type="text" v_maxlength=60 v_type="string" maxlength="60" size=30 >
          </TD>
			  </TR>	
		</TABLE>
		
		<TABLE cellspacing="0">	    
			    <TR id="footer"> 
		         	<TD> 
		         	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="查  询" onClick="qryProdInfo()">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="重  置" onclick="javascript:location.reload();">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="关  闭" onClick="javascript:removeCurrentTab();" >
				 	  </TD>
		       </TR>
	     </TABLE> 

						<IFRAME frameBorder=0 id=middle name=middle scrolling="auto"   
						style="HEIGHT: 300px; VISIBILITY: inherit; WIDTH: 98%; Z-INDEX: 1">
						</IFRAME>
					
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

