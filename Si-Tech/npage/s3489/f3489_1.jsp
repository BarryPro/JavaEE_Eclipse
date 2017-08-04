<%
   /*
   * 功能: 统付和付费关系操作查询
　 * 版本: v1.0
　 * 日期: 2009/02/05
　 * 作者: wuxy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-15    qidp        新版集团产品改造
   * 2009-11-05    niuhr		根据查询类型不同跳转到不同界面
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%	
	//读取用户session信息	
    String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String nopass   = WtcUtil.repNull((String)session.getAttribute("password"));                    //登陆密码	
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	Logger logger = Logger.getLogger("f3489_1.jsp");
	String op_name="统付和付费关系操作查询";
	
	String opCode = "3489";
	String opName = "统付和付费关系操作查询";
%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>
function queryBWInfo()
{
   if(!forInt(document.form1.condText)) return false;
   if(document.form1.condText.value=="")
   { 
   	 rdShowMessageDialog("请输入查询条件！");
	 document.form1.condText.select();
	 return;
   }
   if(!check(form1)) return false;
   if(document.all.begin_time.value!="")
	{
		if(!forDate(document.all.begin_time))
		{
			return false;
		}
	}
	if(document.all.end_time.value!="")
	{
		if(!forDate(document.all.end_time))
		{
			return false;
		}
	}


	var begin_time=document.all.begin_time.value;
	var end_time=document.all.end_time.value;

    var queryType = document.form1.queryType1.value; //查询类型
    var favCond = document.form1.queryType.value;  //查询条件
    var favValue = document.all.condText.value;    //条件信息
   if(queryType=="0")//统付关系：0
   {
   	 
   	document.middle.location="f3489info.jsp?queryType="+queryType+"&favCond="+favCond+"&favValue=" + favValue+"&begin_time="+begin_time+"&end_time="+end_time;
   }
   else //付费关系：1
   {  		
   	 	document.middle.location="f3489info1.jsp?queryType="+queryType+"&favCond="+favCond+"&favValue=" + favValue+"&begin_time="+begin_time+"&end_time="+end_time;
   }	
	
}	

	
	
</script>

</head>

<body>
	<form action="" name="form1"  method="post">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">统付和付费关系操作查询</div>
    </div>
	<table cellspacing="0">
			<TR id="con3">
				<td class='blue' nowrap>查询类型</TD>
				<TD colspan = "3"　>
			      	<select name=queryType1>
              		<option value="0">统付关系</option>
              		<option value="1">付费关系</option>
            		</select> 
			      </TD>
		    </TR>
 			 <TR id="con2">
				  <td class='blue' nowrap>查询条件</TD>
			      <TD>
			      	<select name=queryType>
              		<option value="0">付费账户</option>
              		<option value="1">集团编号</option>
              		<option value="2">成员号码</option>
            		</select> 
			      </TD>
          <td class='blue' nowrap>条件信息</TD>
          <TD>
          	<input type="text" v_must="1" v_type="0_9" name="condText" size="20" maxlength="60" >
          </TD>	
			  </TR>
			  <TR id="con4">
				<td class='blue' nowrap>查询开始日期</td>
				<td>
					<input type=text  v_type="0_9"  name="begin_time" maxlength="8" size="20" v_format="yyyyMMdd">
					(YYYYMMDD)
				</td>
				<td class='blue' nowrap>查询结束日期</td>
				<td>
					<input type=text  v_type="0_9" name="end_time" maxlength="8" size="20" v_format="yyyyMMdd">
					(YYYYMMDD)
				</td>
			  </TR>
			  
		</TABLE>
		
		<TABLE cellspacing="0">	    
			    <TR id="footer"> 
		         	<TD> 
		         	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="查  询" onClick="queryBWInfo()">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="重  置" onclick="javascript:location.reload();">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="关  闭" onClick="javascript:removeCurrentTab();" >
				 	  </TD>
		       </TR>
	     </TABLE> 
	      
					<IFRAME frameBorder=0 id=middle name=middle scrolling="auto"  
					style="HEIGHT: 280px; WIDTH: 100%; Z-INDEX: 1">
					</IFRAME>
<%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>

