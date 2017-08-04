<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-12 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<HTML>
	<HEAD>
		<TITLE>综合信息查询</TITLE>
<%
  String opCode = "1500";
  String opName = "综合信息查询";
  String workNo = (String)session.getAttribute("workNo");
  String workName=(String)session.getAttribute("workName");
  String Department=(String)session.getAttribute("orgCode");
  String regionCode = Department.substring(0,2);
  String ip_Addr = "172.16.23.13";
  
  String accountType =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//accountType == "2"时为客服工号进入
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">
/*
 * 【项目】关于旧版客服系统割接下线需要将客服域的营业代码与CRM合并成一套版本的解决方案和后续需求开发讨论规则@2014/7/21
 */
$(document).ready(function(){
	if("<%=accountType%>" == "2"){
		window.location.href="<%=request.getContextPath()%>/npage/public/showMsg_KF.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
});

function doCheck()
{
	
	//if(jtrim(document.frm1500.cus_pass.value).length ==0)
	//	document.frm1500.cus_pass.value="123456";
	if(document.frm1500.cus_pass.value.trim().length>0 && document.frm1500.cus_pass.value.trim().length !=6)
	{
	   rdShowMessageDialog("密码位数不正确！");
	   document.frm1500.cus_pass.focus();
	   return false;
	}
	 document.frm1500.custPass.value=document.frm1500.cus_pass.value;

	if(document.frm1500.condText.value=="")
	{	rdShowMessageDialog("请输入查询条件！");
		document.frm1500.condText.select();
		return false;
	} else {
	
	var queryType = $("select[name='QueryType']").find("option:selected").text();
	/*2015/03/09 15:09:02 gaopeng 关于物联网专网专号业务功能优化的函
		新增物联网查询条件，这里用的是select的text校验的，为什么呢？
		原因是服务中对queryType的value有校验，不在0-7中的均视为无效查询代码。
	*/
	if(queryType == "物联网号码"){
		var condText = $.trim($("input[name='condText']").val());
		var condPhoneHead1 = condText.substring(0,3);
		var condPhoneHead2 = condText.substring(0,5);
		
			/*
			if(condPhoneHead1 == "147"){
				condText = "206"+condText.substring(3,condText.length);
			}else if(condPhoneHead2 == "10648"){
				condText = "205"+condText.substring(5,condText.length);
			}
			*/
			
			var myPacket = new AJAXPacket("/npage/public/pubGetWLWPhoneNo.jsp","正在查询信息，请稍候......");
				
			  myPacket.data.add("opCode","1500");
			  myPacket.data.add("phoneNo",condText);
			  
			  
			  core.ajax.sendPacket(myPacket,function(packet){
			  	var retCode=packet.data.findValueByName("retCode");
				  var retMsg=packet.data.findValueByName("retMsg");
				  var phoneNoRet=packet.data.findValueByName("phoneNoRet");
				  if(retCode == "000000"){
				  	condText = phoneNoRet;
				 	}else{
						
				 	}
			  });
			  myPacket = null;
			
		
		$("input[name='condText']").val(condText)
	}
	document.frm1500.action="f1500_2.jsp";
	frm1500.submit();
	}
	return true;
}

</SCRIPT>

<FORM method=post name="frm1500">
<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="opCode"  value="1500">
	<input type="hidden" name="custPass"  value="">
			<div class="title">
				<div id="title_zi">请输入查询条件</div>
			</div>
			<table cellspacing="0">
        <tr>
          <td class="blue" align="center" nowrap>查询条件</td>
          <td>
           <select align="left" name=QueryType width=50>
              <option value="0">服务号码</option>
              <option value="1">帐户号</option>
              <option value="2">证件号码</option>
              <option value="3">客户名称</option>
              <option value="4">SIM卡号</option>
              <option value="5">IMSI号</option>
              <option value="7">宽带账号</option>
              <option value="0">物联网号码</option>
            </select>
		  		</td>
          <td class="blue" align="center" nowrap> 条件信息</td>
          <td>
          	<input type="text" name="condText" size="20" maxlength="60" onKeyDown="if(event.keyCode==13){ doCheck();return false}">
          	<input type="button" name="Button1" class="b_text" value="查询" onclick="doCheck()">
          </td>
          <td class="blue" align="center" nowrap> 用户密码</td>
          <td>
           	<jsp:include page="/npage/query/pwd_one.jsp">
		      	<jsp:param name="width1" value="16%"  />
		      	<jsp:param name="width2" value="34%"  />
		      	<jsp:param name="pname" value="cus_pass"  />
		      	<jsp:param name="pwd" value="12345"  />
	    	   	</jsp:include>
          </td>
        </tr>
    	</table>

<script>
	x = screen.availWidth;
	y = screen.availHeight;
	window.innerWidth = x;
	window.innerHeight = y;
</script>
<!------------------------>

	</div>


	<div id="Operation_Table">
		<div class="title">
				<div id="title_zi">查询结果</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
        <th>服务号码</th>
        <th>用户ID号</th>
        <th>服务类型</th>
        <th>当前状态</th>
        <th>状态变更时间</th>
        <th>入网时间</th>
      </tr>
    </table>



<table cellspacing="0">
  <tr align="center">
    <td id="footer">
      &nbsp; <input name=reset class="b_foot" type=reset onClick="" value=清除>
      &nbsp; <input name=back class="b_foot" onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
      &nbsp;
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
</form>
</body>
</html>
<!--***********************************************************************-->
