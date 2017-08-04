<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: gaopeng 2015/02/11 9:50:29 关于11月份集团客户部CRM、BOSS和经分系统需求的函-7-行业应用流量卡BOSS系统需求
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
		System.out.println("#############ReqPageName->"+ReqPageName);
		String accept = WtcUtil.repNull(request.getParameter("accept"));

	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}
		
		HashMap hm=new HashMap();
	  hm.put("1","没有客户ID！");
	  hm.put("3","密码错误！");
	  hm.put("4","手续费不确定，您不能进行任何操作！");
	  ///////
	  //  孙振兴添加 START
	  hm.put("5","对不起，此号码为特殊特殊号码，您的工号权限不足！");
	  hm.put("6","对不起，此号码办理过“邮寄帐单”业务，请先取消！");
	  hm.put("7","对不起，此号码办理过“电子帐单”业务，请先取消！");
	  hm.put("8","对不起，此号码办理过“邮寄帐单”和“电子帐单”业务，请先取消！");
	  hm.put("9","未能取得用户完整的基本信息!");
	  ///////
	  //  孙振兴添加 END
	  hm.put("2", "用户资料不存在1，请核查数据或咨询系统管理员！");
	  hm.put("10","用户资料不存在2，请核查数据或咨询系统管理员！");
	  hm.put("11","用户资料不存在3，请核查数据或咨询系统管理员！");
	  hm.put("12","用户资料不存在4，请核查数据或咨询系统管理员！");
	  hm.put("13","用户资料不存在5，请核查数据或咨询系统管理员！");
	  hm.put("14","用户资料不存在6，请核查数据或咨询系统管理员！");
	  hm.put("15","对不起，此号码办理过“亲情通业务”业务，请先取消！");
	  hm.put("30","此用户为异地用户，不能进行实名登记！");
	  hm.put("31","省内携号用户，只能在原归属地进行实名登记！");
	  
	   boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = loginNo;
	int favFlag = 0 ;/*0没有免密权限1有免密权限*/
	%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	 
%>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
			<%
			if(ReqPageName.equals("s1238Main"))
			{
			  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));			 
		 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
			  {
		%>
			    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");
		<%
			  }
			  else if(retMsg.equals("100"))
			  {
		%>
				rdShowMessageDialog('帐户<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>已欠费，不能办理业务！');

		<%
			  }
		      else if(retMsg.equals("101"))
			  {
		%>
		rdShowMessageDialog('错误<%=WtcUtil.repNull(request.getParameter("errCode"))%>：<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
		       		<%
			  }
			}
		%>
			
		});
		
		function doCommit(){
			f1.action="/npage/sm058/s1238Main.jsp";
    	f1.submit();
			
		}
	
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
	    <tr>
	  		<td width="20%" class="blue">手机号码</td>
	  		<td width="80%" colspan="3">
	  			<input type="text" id="srv_no" name="srv_no" v_type="0_9" maxlength="11" value="<%=phoneNo%>" class="InputGrey" readonly onblur="checkElement(this)"/>&nbsp;&nbsp;
	  		</td>
	    </tr>
	    <tr>
	  		<td colspan="4" ><font color="red">*操作此界面的工号需要有“实名登记(m058)”权限</font></td>
	    </tr>
	  </table>
	 <div>
	
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="确认"   onclick="doCommit();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
			</td>
		</tr>
		
		</table>
	
	</div>
	<input type="hidden" name="iLoginAcceptnew" id="iLoginAcceptnew" />
	<input type="hidden" name="oCustName" id="oCustName" value=""/>
	<input type="hidden" name="oIccidNo" id="oIccidNo" value=""/>
	<input type="hidden" name="realOpCode" id="realOpCode" value="<%=opCode%>"/>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
