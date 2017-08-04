<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>修改IMEI绑定关系</title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<%
		String opCode = "8090";
		String opName = "修改IMEI绑定关系";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String[] inParams = new String[2];
		String Sql_Str = "";
		Sql_Str = "select sale_op_code,plan_name,is_com from dbchnterm.schnressaleplantype where is_ModifyImei='Y'" ;
		inParams[0] = Sql_Str;
    inParams[1] = "";
    
		
	%>
	
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg0" retcode="code0" outnum="10">
			<wtc:param value="<%=inParams[0]%>"/>
			<wtc:param value="<%=inParams[1]%>"/>
		</wtc:service>
		<wtc:array id="resulttest" scope="end" />
			
	<script language="javascript">
		$(document).ready(function(){
			
		});
		//查询方法
		function doSubmit()
		{
			if(check(frm))
		{
			var plan_code = $("select[name='plan_code']").find("option:selected").val();
			var startCust = $("#startCust").val();
			if(plan_code.length==0)
			{
				rdShowMessageDialog("请选择营销案！",1);
				return false;
			}
			if(startCust.length==0)
			{
				rdShowMessageDialog("请选择销售时间！",1);
				return false;
			}
			if(startCust.length!=0){
			startCust = startCust.replace("年-","");
			startCust = startCust.replace("月-","");
			startCust = startCust.replace("日","");
			//将销售时间去掉年月日以及横杠赋值到隐藏域中
			$("#saletime").val(startCust);
			}
			frm.action="f8090Qry.jsp";
			frm.submit();
			
		}
			
		}
</script>
</head>
<body>
<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">修改IMEI绑定关系</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">手机号码</td>
			<td>
				<input type="text" id="phoneno" name="phoneno"  v_must="1" 
						v_type="mobphone" onblur="checkElement(this)" />
			</td>
			<td class="blue">营销案</td>
			<td>
				<select name="plan_code" style="width:200px">  			      
					<option value=""></option>
						<%                  
            		for(int i=0;i<resulttest.length;i++){
            %>
  			        <option value="<%=resulttest[i][0]%>"><%=resulttest[i][1]%></option>
  			    <%
  			    }
  			    %> 
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">销售时间</td>
			<td>
				<input type="text" id="startCust"   name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyy年-MM月-dd日',alwaysUseStartDate:true,maxDate:'%y-%M-%d',minDate:'#{%y-6}-01-01'})"/>
							<img id = "imgCustStart" 
								onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyy年-MM月-dd日',alwaysUseStartDate:true,maxDate:'%y-%M-%d',minDate:'#{%y-6}-01-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			</td>
			<td class="blue" colspan="2">时间限制：2006年---今天</td>
			
		</tr>
		<tr>
			<td class="red" colspan="4">注意：用户在营销管理平台“营销执行(g794)”办理的终端营销案请在“重新捆绑IMEI绑定关系(g821)”进行修改</td>
		</tr>
	</table>
	
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<input type="button" class="b_foot" value="查询" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" class="b_foot"  value="清除"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<input type="hidden" id="saletime" name="saletime" value=""/>
	<input type="hidden" name="iLoginNo" value="<%=workNo%>"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>  