<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-09-16 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>

<%
		String opCode = "1350";
		String opName = "账单打印";
		String orgCode = (String)session.getAttribute("orgCode");
		String op_code = "1350";
		String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		Calendar cal = Calendar.getInstance(Locale.getDefault());
    cal.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(4,6))-1),Integer.parseInt(dateStr.substring(6,8)));
    cal.add(Calendar.MONTH,-1);
    String mon = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
    
    String[][] favInfo = (String[][])session.getAttribute("favInfo");   
    String tempStr = "";
    String passflag = "0"; 
    for(int i=0;i<favInfo.length;i++) {
        tempStr = (favInfo[i][0]).trim();
				if(tempStr.compareTo("a272") == 0) {     
					passflag = "1";         
				}
    }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>黑龙江BOSS-帐单打印</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>

<script language="JavaScript">
<!--
function change() 
{ 
 	   var i = document.form.printway.value;
	   var temp0="tb1";
	   
		if (i=="0") 
		{
			document.all.zhhmTd.style.display = "none";
			document.all.zhmmTd.style.display = "none";
			document.all.fwhmTd.style.display = "block";
			document.all.fwmmTd.style.display = "block";
			document.all.pass_msg.innerHTML = "用户密码";
			document.form.mobileno.focus();
	  	}	
	  	else if (i=="1")
		{
			document.all.zhhmTd.style.display = "block";
			document.all.zhmmTd.style.display = "block";
			document.all.fwhmTd.style.display = "none";
			document.all.fwmmTd.style.display = "none";
			document.all.pass_msg.innerHTML = "帐户密码";
			document.form.contractno.focus();
	  }
	  
	   hiddenTip(document.all.mobileno);
	   hiddenTip(document.all.contractno);
	   hiddenTip(document.all.cus_pass);
	      
	   document.form.mobileno.value = "";
	   document.form.contractno.value = "";
}

function form_load()
{
	form.sure.disabled=true;
	document.form.mobileno.focus();
}

 
function docheck2()
{
		if(document.form.printway.value=="0"){
			document.all.mobileno.value = document.all.mobileno.value.trim();
			if(!forMobil(document.all.mobileno)){
				return false;	
			}	
		}
		
		if(form.mobileno.value==""&&document.form.printway.value=="0")
		{
			rdShowMessageDialog("请输入合法的服务号码！");
			document.form.mobileno.focus();
		 	 return false;
		}

		if(document.form.printway.value=="1"){
			document.all.contractno.value=document.all.contractno.value.trim();
			
			if(!forNonNegInt(document.all.contractno)){
				return false;	
			}
		}
 
		if(form.contractno.value==""&&document.form.printway.value=="1")
		{
			rdShowMessageDialog("请输入合法的帐户号码！");
			document.form.contractno.focus();
			return false;
		}
 		
 		if(!forDate(document.all.billmonth)){
 			return false;	
 		}
 		
		if(form.billmonth.value.length<6)
		{
			rdShowMessageDialog("请输入合法的出帐年月！格式为YYYYMM。");
			document.form.billmonth.focus();
			return false;
		}
      
	      var billy ,billm,billmonthtemp;
		 if (form.billmonth.value.length == 6)
		{
			  billy = form.billmonth.value.substring(0,4);
			  billm = form.billmonth.value.substring(4,6);
			  billmonthtemp=form.billmonth.value;
		}

        if (billy < "1990" || billy > "2050" || billm < "01" || billm > "12") 
		{
            rdShowMessageDialog("请输入合法的出帐年月！");
		        document.form.billmonth.focus();
		        return false;
    }
 
 		//wuxy添加判断新帐单打印模块！
		if(billmonthtemp>"200805")
		{
			rdShowMessageDialog("日期为200805以后的账单请选择“新帐单打印”模块!");
			return false;
		}
 
 		if(<%=passflag%>!="1"){
 			if(document.form.printway.value=="0"&&document.all.cus_pass.value.trim().len()==0){
 				showTip(document.all.cus_pass,"用户密码不能为空!");
 				return false;
 			}	
 			
 			if(document.form.printway.value=="1"&&document.all.cus_pass.value.trim().len()==0){
 				showTip(document.all.cus_pass,"帐户密码不能为空!");
 				return false;
 			}
 		}
		document.form.action="s1350_select.jsp";
		document.all.password.value=document.all.cus_pass.value;
		form.submit();
}

//-->
</script>
</HEAD>
 <BODY onLoad="form_load();">
<FORM action="" method="post" name="form">
<input type="hidden" name="password"/>
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">请选择打印方式</div>
		</div>
            <table cellspacing="0"> 
              <tr height="30"> 
                <td class="blue" width="13%">业务类型</td>
                <td>帐单打印</td>
                <td class="blue" width="13%">部门</td>
                <td><%=orgCode%></td>
              </tr>
              <tr> 
                <td class="blue" width="13%">打印方式</td>
                <td width="35%">
                  <select name="printway" onChange="change();">
                    <option value="0" selected>按服务号码</option>
                    <option value="1">按帐户号码</option>
                  </select>
                </td>
                <td width="13%" class="blue">出帐年月</td>
                <td>
                	<input type="text" name="billmonth" v_format="yyyyMM" value="<%=mon%>" maxlength="6" onKeyDown="if(event.keyCode==13)docheck2()"  onKeyPress="return isKeyNumberdot(0)">
                </td>
              </tr>
              <tr> 
                <td class="blue" id="fwhmTd" style="display:block">服务号码</td>
                <td id="fwmmTd" style="display:block"> 
                  <input type="text" value="" name="mobileno" maxlength="14" onKeyDown="if(event.keyCode==13)form.billmonth.focus()" onKeyPress="return isKeyNumberdot(0)">
                </td>
                <td id="tb2" style="display:none">
                <td class="blue" id="zhhmTd" style="display:none">帐户号码</td>
                <td id="zhmmTd" style="display:none"> 
                  <input type="text" name="contractno" maxlength="22" onKeyDown="if(event.keyCode==13)form.billmonth.focus()"  onKeyPress="return isKeyNumberdot(0)">
                </td>
                <td class="blue"><div id="pass_msg">用户密码</div></td>
                <td>
			           <jsp:include page="/npage/common/pwd_one.jsp">
							      <jsp:param name="width1" value="16%"  />
							      <jsp:param name="width2" value="34%"  />
							      <jsp:param name="pname" value="cus_pass"  />
							      <jsp:param name="pwd" value="12345"  />
						 	   </jsp:include>
                <input name=querybill type=button class="b_text" value=查询 onClick="docheck2();">
                </td>
              </tr>
            </table>
            <table cellspacing="0">
              <tbody> 
              <tr> 
                <td id="footer"> 
                  	<input class="b_foot" name=sure type=button value="打印">
                  	&nbsp;
				  					<input class="b_foot" name=reset type=reset value="关闭" onClick="parent.removeTab('<%=opCode%>')">
                </td>
              </tr>
              </tbody> 
            </table>
			  <%@ include file="/npage/include/footer.jsp" %>             
			</FORM>
		</BODY>
</HTML>
