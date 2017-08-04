<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 全球通开户冲正1121
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="1121";
	String opName="普通开户冲正";
	String phoneNo = (String)request.getParameter("activePhone");
%>
<%
	/*
	* 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
			部分变量的命名依据对此变量使用的意义，或用途。
	*/
%>
<%
	String workNo =(String)session.getAttribute("workNo");    		//工号
	String workName =(String)session.getAttribute("workName");      //工号名称
	String info =  (String)session.getAttribute("ipAddr");//登陆IP
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");	
	String regionCode = (String)session.getAttribute("regCode");
	/*循环打印优惠资费代码
	for(int p = 0;p< favInfo.length;p++){//打印优惠资费代码
		for(int q = 0;q< favInfo[p].length;q++)
		{
	     out.println("优惠资费代码："+ favInfo[p][q]);
		}
	}*/
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>黑龙江BOSS-入网－全球通普通开户冲正 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body>
<form action="" method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr>
		<td width="20%" class="blue">
			查询类型
		</td>
		<td width="30%">
			<select name="s1" onchange="change()">
				<option value="手机号码">手机号码 </option>
				<option value="服务流水">服务流水 </option>
			</select>
		</td>
		<td width="50%" id="tb1">
			<input class="button" name="i1" size="11" maxlength=11 v_must=0 v_type=mobphone value="" onkeydown="if(event.keyCode==13)if(theform()) if(check(form1)) pageSubmit();">
			<input class="b_text" name=verify  type=button value=查询 onclick="if(theform()) if(check(form1)) pageSubmit(); ">
		</td>
		<td id="tb2" style="display:none">
			<input class="button" name="ii" size="11" v_must=0 v_type=0_9 onkeydown="if(event.keyCode==13)if(theform())if(check(form1)) pageSubmit(); ">
			<input class="b_text" name=query  type=button value=查询 onclick="if(theform()) if(check(form1)) pageSubmit(); ">
		</td>
	</tr>
	<tr>
		<td align=center colspan="3">
			<input class="b_foot" name=sure   type="button" onClick="if(check(form1)) printCommit();" disabled value=确认>
			<input class="b_foot" name="resetName"  onClick="document.all.i1.value='';ii.value=''" type="button" value="清除">
			<input class="b_foot" name=close  type="button" onClick="removeCurrentTab()" value=关闭>
		</td>
	</tr>
</table>
   <%@ include file="/npage/include/footer.jsp" %>
   <input type="hidden" name="my_phone" value="<%=activePhone%>"/>
</form>
</body>
</html>
<%/* --------------------------------javascript区-------------------------------- */%>

<script language="javascript">
function pageSubmit(){
		document.form1.action="<%=request.getContextPath()%>/npage/innet/f1121_2.jsp";
        form1.submit();
    }
/*-----------------------------------对隐藏域的控制函数--------------------------*/
function change(){
	   var i = document.form1.s1.selectedIndex+1;
	   var temp="tb"+i;

	  var j = 1;
	  for(j=1;j<3;j++){
	  	var tem ="tb"+j;
	  	document.all(tem).style.display="none";
	  }

   	    document.all(temp).style.display="";

}//对隐藏域的控制

/*-------------------------文本筐校验函数----------------------------*/
function theform(){
	var temp = document.all.s1.selectedIndex;
	var i1 = document.all.i1.value;
	var ii = document.all.ii.value;
	
	if(temp == 0 && i1=="")
	{
		rdShowMessageDialog("手机号码请务必填写！",0);
		document.all.i1.focus();
		return false;
	}
	if(temp ==1 && ii==""){
		rdShowMessageDialog("服务流水请务必填写！",0);
		document.all.ii.focus();
		return false;
	}
	return true;
}
</script>
