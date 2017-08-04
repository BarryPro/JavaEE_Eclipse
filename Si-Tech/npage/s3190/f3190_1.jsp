<%
/********************
 *version v2.0
 *开发商: si-tech
 *xiaoliang 3190一点支付冲正
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.util.*"%>


<%
    String opCode = "3190";
    String opName = "一点支付冲正";
    
    //ArrayList arr = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo = (String[][])arr.get(0);
    //String workno = baseInfo[0][2];
    //String workname = baseInfo[0][3];
    //String belongName = baseInfo[0][16];
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String belongName = (String)session.getAttribute("orgCode");
    String op_code = "3190"  ;
    
    String dateStr=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD><TITLE>一点支付冲正</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>


<script language="JavaScript">
<!--
 function form_load()
{
	form.sure.disabled=true;
	form.phoneNo.focus();
}

function docheck()
{
	if(document.form.contractNo.value=="")
	{   
		rdShowMessageDialog("请输入支付账号！");
		document.form.contractNo.focus();
		return false;
	}
	if(document.form.loginaccept.value=="")
	{   
		rdShowMessageDialog("请输入缴费流水！");
		document.form.loginaccept.focus();
		return false;
	}
	if(document.form.billdate.value=="")
	{   
		rdShowMessageDialog("请输入缴费月份！");
		document.form.billdate.focus();
		return false;
	}
	/*
	returnValue=window.showModalDialog('getWater.jsp?billmonth='+document.form.billdate.value+'&contractno='+document.form.contractNo.value,"",prop);
    	 
    
    if( returnValue == null )
    {
    	rdShowMessageDialog("没有找到对应的流水！",0);
    	document.form.contractNo.focus();
    	return false;
    }
    
    if(returnValue == "" )
    {
    	rdShowMessageDialog("您没有选择对应的流水！",0);
    	document.form.contractNo.focus();
    	return false;
    }
    
    document.form.water_number.value = returnValue;*/
    document.form.action="f3190_2.jsp";
    document.form.submit();
    return true;
 
 
}
//-->
</script>
</HEAD>
<BODY>
<FORM action="f3190_2.jsp" method=post name=form>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">一点支付冲正</div>
</div>
    <table cellspacing="0">
        <tr> 
            <td class="blue">支付账号</td>
            <td colspan=2>
			<input type="text" name="contractNo" maxlength="14" onKeyPress="return isKeyNumberdot(0)"  >
			</td>
            <td class="blue">缴费流水</td>
            <td colspan=2>
			<input type="text" name="loginaccept"  onKeyPress="return isKeyNumberdot(0)"  >
			</td>
        </tr>
        
        
        <tr> 
            
            <td class=blue>缴费月份</td>
            <td colspan=5> 
                <input type="text" name="billdate" maxlength="6" onKeyDown="if(event.keyCode==13)docheck()" onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>">
               
            </td>
        </tr>
        
        
        </table>
    <table cellspacing="0">
        <tbody>
            <tr>
                <td id="footer">
                    <input class="b_foot" name=sure type="button" value=确认 onclick="docheck()">
                    <input class="b_foot" name=clear type=reset value=清除>
                    <input class="b_foot" name=reset type=button value=关闭 onClick="removeCurrentTab()">
                </td>
            </tr>
        </tbody>
    </table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
