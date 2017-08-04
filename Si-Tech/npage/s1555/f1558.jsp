 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-10 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GbK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
	<head>
		<title>短信类领奖</title>
<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");	
 
%>

	<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
	<script language=javascript>
		  onload=function()
		  {
		    self.status="";
		    document.all.srv_no.focus();
		  }
		
		//----------------验证及提交函数-----------------
		function doCfm(subButton)
		{
		  controlButt(subButton);//延时控制按钮的可用性
		  if(!check(frm)) return false;
		  	frm.action="f1558_query.jsp";
		  	frm.submit();	  
		}
	</script>
</head>
<body>	
	<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>  
			<div class="title">
				<div id="title_zi">短信类领奖</div>
			</div>	
		<table cellspacing="0">       
	          <tr>
	            	<td  class="blue" nowrap>兑奖类型</td>	
	            	<td>	            	
			              <select name="shorttype"  index="15">
			                <option value="0" selected >1 --> 幸运十二周周奖</option>
			                <option value="1">2 --> 幸运十二周幸运奖</option>
			                <option value="2">3 --> 彩信人气奖</option>
			                <option value="3">4 --> 彩信能手奖</option>
			                <option value="4">5 --> 送福回家之积分抽奖</option>
			                <option value="5">6 --> 幸运52周奖</option>
			                <option value="6">7 --> 一转即发月奖</option>
			                <option value="7">8 --> 幸运三重奖</option>
			                <option value="8">9 --> 中秋送祝福</option>
			                <option value="9">10 --> 幸运52周新版</option>
			                <option value="10">11 --> 幸运52周新版月奖</option>
			              </select>		              
	            	</td>
	          </tr>
          	<tr>
            		<td width="16%" nowrap class="blue">手机号码</td>
            		<td nowrap >             
                		<input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"   value =<%=activePhone%>  readonly class="InputGrey" maxlength="11" index="0" >
                		<font class="orange">*</font>
                	</td>
            
          	</tr>
          </table>
         <table cellspacing="0">       
	          <tr>
	            	<td id="footer">	             
	                	<input  type=button class="b_foot"  name="confirm" value="确认" onClick="doCfm(this)" index="2">
	                	<input  type=button class="b_foot" name=back value="清除" onClick="frm.reset()">
	                	<input  type=button class="b_foot" name=qryP value="关闭" onClick="removeCurrentTab()">
	            	</td>
	          </tr>
        </table>  
        <input type="hidden" name="opName" value="<%=opName%>">
        <input type="hidden" name="opCode" value="<%=opCode%>">
        <%@ include file="/npage/include/footer_simple.jsp" %>	
   </form>
</body>
</html>