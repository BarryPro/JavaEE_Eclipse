<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>修改IMEI绑定关系</title>

<%
		String regionCode = (String)session.getAttribute("regCode");
		String opCode = "8090";
		String opName = "修改IMEI绑定关系";
		String iLoginNo = request.getParameter("iLoginNo");
		String phoneno = request.getParameter("phoneno");
   	String plan_code = request.getParameter("plan_code");
   	String saletime = request.getParameter("saletime");
%>

<wtc:service name="s8090Qry" routerKey="region" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="10" >
		<wtc:param value="<%=phoneno%>"/>
		<wtc:param value="<%=plan_code%>"/>		
		<wtc:param value="<%=saletime%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
		
	<%
		if (!sReturnCode.equals("000000") )
    {
  %>
  	
  	<script language="JavaScript">
        rdShowMessageDialog("<%=sErrorMessage%>",0);
        window.location="f8090.jsp";
    </script>
  <%
  }
  %>
  
 <script language="javascript">
		$(document).ready(function(){
			
		});
//为原IMEI码赋值
function opchange(imeno) {
	document.all.imei_no.value="";
	document.all.imei_no.value=imeno.replace(/[ ]/g,""); 

}
//提交方法
function doSubmit()
{
	if(check(frm))
		{
			var q=document.getElementsByName("unchange");
			var flag=false;
			//流水号
			var v_op_accept;
			for(var i=0;i<q.length;i++)
			{
				 if(q[i].checked==true){
				 	flag=true;
				 	v_op_accept = q[i].value;
				 	break;
				 	
				}
				
			}
			//流水号赋值
			$("#inAcceptCode").val(v_op_accept);
			if(!flag)
			{
				rdShowMessageDialog("请选择要修改的销售信息！",1);
        return false;
			}
			
			var new_imei_no = $("#new_imei_no").val();
			var imei_no = $("#imei_no").val();
			//去空格
			new_imei_no=new_imei_no.replace(/\s+/g,"");
			if (new_imei_no.length != 15)
  		{
      rdShowMessageDialog("输入的新IMEI码长度必须是15位，请重新输入！",1);
      document.all.new_imei_no.select();
      return false;
  		}
			if(imei_no==new_imei_no)
			{
				rdShowMessageDialog("新IMEI与系统中IMEI相同，不需要再次更改！",1);
        return false;
			}
			frm.action="f8090Cfm.jsp";
			frm.submit();
			
		}
	
}
	</script>
</head>
<body>
<form name="frm" method="post" action="">	
	<%@ include file="/npage/include/header.jsp" %>
<div id="items">
     
	<div class="title">
		<div id="title_zi">修改IMEI绑定关系</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th width="10%" >
				
			</th>
			<th width="15%">
				品牌型号
			</th>
			<th width="20%">
				营销案
			</th>
			<th width="15%">
				IMEI码
			</th>
			<th width="20%">
				营销案生效时间
			</th>

		</tr>
		<% for(int i=0;i<result.length;i++)
	  {
		%>
		<tr>
			<td width="10%" algin="center"><input type="radio" onclick="opchange('<%=result[i][3]%>')" name="unchange" value="<%=result[i][2]%>"></input>
				</td>
				<td width="15%"><%=result[i][5]%></td>
				<td width="20%"><%=result[i][8]%></td>
				<td width="15%"><%=result[i][3]%></td>
				<td width="20%"><%=result[i][6]%></td>
				
		</tr>
		
		<%
		}
		%>
		<tr>
			<td colspan="6" >&nbsp;</td>
		</tr>
		<tr>
			<td class="blue">原IMEI码</td>
			<td colspan="2">
				<input type="text" name="imei_no" id="imei_no" value="" v_must="1" onblur="checkElement(this)" readOnly/>
        <font color="#FF0000">*</font>
			</td>
			
			<td class="blue">新IMEI码</td>
			<td colspan="2">
				<input type="text" name="new_imei_no" id="new_imei_no" value="" v_must="1" onblur="checkElement(this)" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)"/>
			  <font color="#FF0000">*</font>
			</td>
		</tr>
	</table>
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<input type="button" class="b_foot" value="提交" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" class="b_foot"  value="清除"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot"  value="返回" onclick="JavaScript:document.location.href='/npage/s1141/f8090.jsp';"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
</div>
	<input type="hidden" name="inAcceptCode" id="inAcceptCode" value=""/>
	<input type="hidden" name="iLoginNo2" value="<%=iLoginNo%>"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>  