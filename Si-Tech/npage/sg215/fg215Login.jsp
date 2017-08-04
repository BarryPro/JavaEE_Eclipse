<%
  /*
   * 功能:宽带订单状态信息查询--查询条件页面
   * 版本: 1.0
   * 日期: 20121015
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String sWorkNo = (String)session.getAttribute("workNo");
 		String dNopass = (String)session.getAttribute("password");
 		//String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		//流水号
 		String PrintAccept = getMaxAccept();
 		//查询当前工号是否是营业厅(组织机构的最低级)
 		String gruopSQL="SELECT t.group_id,t.group_name,t.root_distance FROM dchngroupmsg t,dloginmsg t2"+
 		" WHERE t.group_id=t2.group_id AND t2.login_no='"+sWorkNo+"'";
 		//预备营业厅组织机构id
 		String lvlGrpId="";
 		//预备营业厅名称
 		String lvlGrpName="";
 		//是否属于营业厅
 		boolean lvlFlag=false;

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:sql><%=gruopSQL%></wtc:sql>
		</wtc:pubselect>
<wtc:array id="result11" scope="end" />
<%
		if(result11.length<=0)
		{
				lvlFlag=false;
%>

<script language="JavaScript">
			rdShowMessageDialog("查询工号组织机构信息失败！",0);
			removeCurrentTab();
</script>

<%
		}
else if("4".equals(result11[0][2])){
		lvlGrpId   =  result11[0][0];
		lvlGrpName =	result11[0][1];
		lvlFlag    =  true;
}
else
	{
		lvlFlag    =  false;
	}
%>

<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			//如果是营业厅级别
			if(<%=lvlFlag%>)
			{
				$("input[name='getGroupTree']").attr("disabled",true);
				$("#addObjectId").val("<%=lvlGrpId%>--<%=lvlGrpName%>");
				$("input[name='iGroupId']").val("<%=lvlGrpId%>");
			}
			//否则
			else if(!<%=lvlFlag%>)
			{
				$("input[name='getGroupTree']").attr("disabled",false);
				$("#addObjectId").val("");
				$("input[name='iGroupId']").val("");
			}
			
		});
		//展开组织机构树形结构
		function queryObjectId()
		{
			var path = "tree/groupTree.jsp";
			window.open(path + "?grouptype=form_g215&grpId=addObjectId","","height=600,width=300,scrollbars=yes");
		}
		//提交方法
		function doSubmit()
		{
			if(check(form_g215))
			{
				var opFlag = $("input[name='opFlag']:checked").val();
				var startTime = $("#startCust").val().trim();
				var endTime = $("#endCust").val().trim();
				//如果按宽带账号查询
				if(opFlag=="0")
				{
					//重新赋值为可见
					var skdUser = $("input[name='sKdUser']").val();
					$("input[name='iSKdUser']").val(skdUser);
					if(skdUser.length==0)
					{
						rdShowMessageDialog("请输入宽带账号！",1);
						return false;
					}
					//重置订单状态
					$("input[name='sErrFlag']").val("0");
					form_g215.action="/npage/sg215/fg215QryZh.jsp";
				}
				//如果按起止时间查询
				if(opFlag=="1")
				{
					//如果没有选择组织节点
					if($("#addObjectId").val().trim().length==0)
					{
						rdShowMessageDialog("请选择组织节点！",1);
						return false;
					}
					if(startTime.length==0)
					{
						rdShowMessageDialog("请选择开始时间！",1);
						return false;
					}
					if(endTime.length==0)
					{
						rdShowMessageDialog("请选择结束时间！",1);
						return false;
					}
					if(startTime.length!=0)
					{
						startTime = startTime.replace("年-","");
						startTime = startTime.replace("月-","");
						startTime = startTime.replace("日","");
						$("input[name='iStartTime']").val(startTime);
					}
					if(endTime.length!=0)
					{
						endTime = endTime.replace("年-","");
						endTime = endTime.replace("月-","");
						endTime = endTime.replace("日","");
						$("input[name='iEndTime']").val(endTime);
					}
					//将宽带账号隐藏域赋值为空，以便于不影响按时间查询的条数
					$("input[name='iSKdUser']").val("");
					form_g215.action="/npage/sg215/fg215Qry.jsp";
				}
				
				form_g215.submit();
			}
		}
	</script>
	</head>
<body>
	<form action="" method="post" name="form_g215">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table id="koManage">
		<tr>
			<td class="blue" width="20%">操作类型</td>
			<td colspan="3">
				<input type="radio" name="opFlag" value="0" data-bind="checked:offerId"/>按宽带账号查询
				<input type="radio" name="opFlag" value="1" data-bind="checked:offerId"/>按起止时间查询
			</td>
		</tr>
		<tr data-bind="visible:offerId()==0">
			<td class="blue" width="20%">宽带账号</td>
			<td colspan="3"><input type="text" name="sKdUser" style="width:220px" value="" maxlength="25"/>
				&nbsp;<font color="red">(最大长度25字符)</font></td>
		</tr>
		<tr data-bind="visible:offerId()==1">
			<td class="blue">开始时间</td>
				<td>
				<input type="text" id="startCust"  name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyy年-MM月-dd日',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})"/>
							<img id = "imgCustStart" 
								onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyy年-MM月-dd日',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				</td>
			<td class="blue">结束时间</td>
			<td>
				<input type="text" id="endCust"  name="endCust" readOnly onclick="WdatePicker({el:'endCust',startDate:'%y-%M-%d',dateFmt:'yyyy年-MM月-dd日',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}',maxDate:'%y-%M-%d'})"/>
							<img id = "imgCustEnd" 
								onclick="WdatePicker({el:'endCust',startDate:'%y-%M-%d',dateFmt:'yyyy年-MM月-dd日',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}',maxDate:'%y-%M-%d'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			</td>
		</tr>
		<tr data-bind="visible:offerId()==1">
			<td class="blue" width="20%">组织节点</td>
			<td width="30%"><input type="text" name="addObjectId" id="addObjectId"  value="" readonly/>&nbsp;&nbsp;
				<input type="button" class="b_text" name="getGroupTree" value="选择" onclick="queryObjectId()"/> 
			&nbsp;<font color="red">*</font>
			</td>
			<td class="blue" width="15%" >订单类型</td>
			<td  width="35%" >
				<select name="sErrFlag">
					<option value="0" selected>全部订单</option>
					<option value="1">异常订单</option>
					</select>
			</td>
			</td>
		</tr>
		
	</table>
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<input type="button" class="b_foot" value="查询" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot"  value="重置" onclick="javascript:window.location.reload();"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<!--组织机构编码 -->
	<input type="hidden" name="iGroupId" value=""/>
	<!--流水号 -->
	<input type="hidden" name="iLoginAccept" value=""/>
	<!--渠道标识 -->
	<input type="hidden" name="iChnSource" value="01"/>
	<!--操作代码 -->
	<input type="hidden" name="iOpCode" value="<%=opCode%>"/>
	<!--操作代码 -->
	<input type="hidden" name="iOpName" value="<%=opName%>"/>
	<!--工号 -->
	<input type="hidden" name="iLoginNo" value="<%=sWorkNo%>"/>
	<!--工号密码 -->
	<input type="hidden" name="iLoginPwd" value="<%=dNopass%>"/>
	<!--手机号码 -->
	<input type="hidden" name="iPhoneNo" value=""/>
	<!--号码密码 -->
	<input type="hidden" name="iUserPwd" value=""/>
	<!--开始时间 -->
	<input type="hidden" name="iStartTime" value=""/>
	<!--结束时间 -->
	<input type="hidden" name="iEndTime" value=""/>
	<!--宽带账号 -->
	<input type="hidden" name="iSKdUser" value=""/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!--ko对象 script区域-->
<script language="javascript">

	var myViewModel = {
					offerId:ko.observable(0)
		};
		ko.applyBindings(myViewModel,$("#koManage")[0]);
		
</script>

</html>
