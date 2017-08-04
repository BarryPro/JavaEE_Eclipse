<%
/********************
 version v2.0
开发商: si-tech
update:wanglm  2010/12/1
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>

<%
  request.setCharacterEncoding("GBK");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>营业厅管理配置及查询</title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "b901";
    String opName = "管理参数配置";
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>


//----------------验证及提交函数-----------------
var subButt2;
function controlButt(subButton){
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
 //if(!check(frm)) return false;
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	  {
	    var opFlag = radio1[i].value;
	    if(opFlag=="one")
	    {
	      	frm.action="fb901_add.jsp";
	    }
	    else if(opFlag=="two")
	    {
			frm.action="fb901_sel.jsp";
	    }
	  }
  }

  frm.submit();
  return true;
}

</script>
</head>
<body>
<form name="frm" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">管理参数配置</div>
	</div>
      <table cellspacing="0">
		<tr>
		  <td class="blue" width="10%">操作类型</td>
		  <td width="34%" class="blue">
				<input type="radio" name="opFlag" value="one"  checked  />新增&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="two"   />查询
		  </td>
         <tr>
            <td colspan="4" align="center">
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
           </td>
        </tr>
      </table>
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>