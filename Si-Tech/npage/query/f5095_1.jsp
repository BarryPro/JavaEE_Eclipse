<%
   /*
   * 功能: BBOSS签约关系处理结果查询 - 主界面
　 * 版本: v1.0
　 * 日期: 2008/09/17
　 * 作者: sunzg
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-10    qidp        集团新版产品改造
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>

<%	
	//读取用户session信息	
  String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	Logger logger = Logger.getLogger("f5095_1.jsp");
	String op_name="BBOSS签约关系处理结果查询";
	String opCode = "3488";
	String opName = "BBOSS签约关系处理结果查询";
%>	
	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>
	
	
function queryBWInfo()
{
   if(document.form1.condText.value=="")
   { 
   	 rdShowMessageDialog("请输入条件信息！");
	 document.form1.condText.select();
   }
   else
   {
   	 var favCond = document.form1.queryType.value; 
   	 var favValue = document.all.condText.value;
   	 document.middle.location="f5095info.jsp?favCond="+favCond+"&favValue=" + favValue;
   }
}	

	
	
</script>

</head>

<body>
	<form action="" name="form1"  method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">BBOSS签约关系处理结果查询</div>
</div>			
		
		<TABLE id="mainOne" cellspacing="0" >
 			 <TR id="con2">
				  <td class='blue' nowrap>查询条件</TD>
			      <TD>
			      	<select align="left" name=queryType id='queryType'>
                  		<option value="0">集团编号</option>
                  		<option value="1">证件号码</option>
                  		<option value="2">手机号码</option>
                  		<option value="3">企业代码</option>
                  		<option value="4">业务代码</option>
                  		<option value="5">短信服务号码</option>
            		</select> 
			      </TD>
          <td class='blue' nowrap>条件信息</TD>
          <TD>
          	<input type="text" id="condText" name="condText" size="20" maxlength="60" >
          </TD>	
			  </TR>
		</TABLE>
		
		<TABLE id="tabBtn" style="display:''" id="mainOne" cellspacing="0">	    
			    <TR id="footer"> 
		         	<TD> 
		         	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="查  询" onClick="queryBWInfo()">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="重  置" onclick="javascript:location.reload();">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="关  闭" onClick="javascript:removeCurrentTab();" >
				 	  </TD>
		       </TR>
	     </TABLE> 
	      
					<IFRAME frameBorder=0 id=middle name=middle scrolling="auto"  
					style="HEIGHT: 330px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 2">
					</IFRAME>
</form>
</body>
</html>

