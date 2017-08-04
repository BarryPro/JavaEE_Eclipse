<%
	/********************
	 version v2.0
	开发商: si-tech
	update:zhaoht@2009-03-10 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%

	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	
	String orgcode = (String)session.getAttribute("orgCode");//机构代码
	String regionCode = (String)session.getAttribute("regCode");
	String sOp_code  =  "1330"   ;
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>黑龙江BOSS-有价卡销售及回退</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->
<script language="JavaScript">
<!--
function docheck()
{
if(form.billdate.value=="")
{
	rdShowMessageDialog("请输入合法的帐务日期！");
	form.billdate.select();
	return false;
	}
else if(form.water_number.value=="")
{
	rdShowMessageDialog("请输入合法的流水号！");
	form.water_number.select();
	return false;
	}
else {
document.form.action="s1330_select.jsp";
form.submit();
form.comp.disabled=true;
form.sure.disabled=true;
}
}

function change() { 
 	var i = form.optype.value.substring(1,4);
 	var temp = "tb1";
	if (i == "133") {	   
	   document.all(temp).style.display="none";
	   document.form.action="s1330_1.jsp";
	   form.submit();
	   }
	else if (i == "134") {
	   document.all(temp).style.display="";
	   form.comp.disabled=true;
	   document.form.water_number.focus();
	   }
	else {
		document.all(temp).style.display="none";
		document.form.water_number.value="";
		}
}



function form_load1()
{
form.sure.disabled=true;
form.comp.disabled=true;
}

function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if(s_keycode>=48 && s_keycode<=57)
			return true;
		else 
			return false;
    else
    {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
		    return false;
		}
		else
			  return false;
    }       
}
// -->
</script>
</HEAD>
<BODY onLoad="form_load1()">
<FORM action="s1330_2.jsp" method=post name="form">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">操作类型</div>
		</div>
	<input type="hidden" name="lines" value="0">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">

           <table cellspacing="0">
              <tbody> 
              <tr> 
                <td class="blue">操作类型</td>
                <td>
                  <select name="optype" onChange="change()">
                    <option value="0" selected></option>
                    <% 	
        try
 		{
      		String sqlStr ="select store_type||op_code,op_name from sStoreTypeOp order by store_type";
      		//System.out.println(sqlStr);      		
      		//retArray = callView.s1330Query("2",sqlStr);
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />
<%      
      		for(int i=0;i<result.length;i++){
        		out.print("<option value=" + result[i][0] + ">" + result[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		//System.out.println("Call queryView Failed!");
     	}          
%>
                  </select>
                </td>
                <td>部门<%=orgcode%></td>
              </tr>
              </tbody> 
            </table>
            
              <table id=tb1 cellspacing="0" style="display:none">
                <tr> 
                  <td class="blue">流水号</td>
                  <td> 
                    <input type="text" name="water_number" onkeydown="if(event.keyCode==13)document.form.billdate.focus()" maxlength="22" onKeyPress="return isKeyNumberdot(0)" >
                  </td>
                  <td class="blue">帐务日期</td>
                  <td> 
                    <input type="text" name="billdate" value="<%=dateStr%>" onkeydown="if(event.keyCode==13)docheck()" maxlength="22" onKeyPress="return isKeyNumberdot(0)" >
                    <input class="b_text" name=sure23 type=button value=查询 onClick="docheck();">
                  </td>
                </tr>
              </table>
         </div>
      <div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">业务信息</div>
</div> 
            <table id="dyntb"  cellspacing="0">
              <tbody> 
              <tr> 
                <th> 
                  <div align="center">面值</div>
                </th>
                <th> 
                  <div align="center">实价</div>
                </th>
                <th> 
                  <div align="center">开始卡号</div>
                </th>
                <th> 
                  <div align="center">卡数量</div>
                </th>
                <th> 
                  <div align="center">结束卡号</div>
                </th>
                <th> 
                  <div align="center">应收合计</div>
                </th>
                <th> 
                  <div align="center">实收</div>
                </th>
              </tr>
              </tbody> 
            </table>
    </div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">账务信息</div>
</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td> 
                    <div align="center">充值卡总张数 
                      <input type="text" readonly name="infilling_number" size="14" class="InputGrey">
                    </div>
                  </td>
                  <td> 
                    <div align="center">充值卡总面值 
                      <input type="text" readonly name="infilling_price" size="14" class="InputGrey">
                    </div>
                  </td>
                  <td> 
                    <div align="center">充值卡总实收 
                      <input type="text" readonly name="infilling_income" size="14" class="InputGrey">
                    </div>
                  </td>
                </tr>
                </tbody> 
              </table>
            <table cellspacing="0">
              <tbody> 
              <tr> 
                <td id="footer"> 
                  <input class="b_foot" name="comp" type=button value=计算>
                  <input class="b_foot" name="sure" type="button" value=确认 onclick="docheck()">
                  <input class="b_foot" name=clear type=reset value=清除>
				  <input class="b_foot" name="reset" type=button value=关闭 onClick="removeCurrentTab()">
                </td>
              </tr>
              </tbody> 
            </table>
          <%@ include file="/npage/include/footer_simple.jsp" %>   
</FORM>
</BODY>
</HTML>

