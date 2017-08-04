<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-15 页面改造,修改样式
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.util.*"%>


<%
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    
    //ArrayList arr = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo = (String[][])arr.get(0);
    //String workno = baseInfo[0][2];
    //String workname = baseInfo[0][3];
    //String belongName = baseInfo[0][16];
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String belongName = (String)session.getAttribute("orgCode");
    String op_code = "b302"  ;
    
    String dateStr=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD><TITLE>缴费冲正</TITLE>
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
	if(document.form.phoneNo.value.length<11 &&document.form.contractno.value.length<5)
	{   
		rdShowMessageDialog("请输入正确的服务号码！");
		document.form.phoneNo.focus();
		return false;
	}
   if(form.billdate.value.length<6)
   {   
	    rdShowMessageDialog("缴费月份不可为空！<br>请输入YYYYMM格式的月份！");
	    document.form.billdate.focus();
	    return false;
	}

	if(form.billdate.value.substring(0,4)<"1990" || form.billdate.value.substring(0,4)>"2050")
   {
	    rdShowMessageDialog("缴费月份输入错误！<br>请输入YYYYMM格式的月份！");
	    document.form.billdate.focus();
	    return false;
    }
      
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
   	var  returnValue ;  
    if (form.contractno.value.length<5)    
    {
    
        returnValue=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneNo.value,"",prop);
        if(returnValue==null)
        {
        	rdShowMessageDialog("没有找到对应的帐号！",0);
        	document.form.phoneNo.focus();
        	return false;
        }
        
        if(returnValue == "" )
        {
        	rdShowMessageDialog("您没有选择对应的帐号！",0);
        	document.form.phoneNo.focus();
        	return false;
        }
        
        document.form.contractno.value = returnValue;
    }
	
	returnValue=window.showModalDialog('getwater_td.jsp?billmonth='+document.form.billdate.value+'&contractno='+document.form.contractno.value,"",prop);
    	 
    
    if( returnValue == null )
    {
    	rdShowMessageDialog("没有找到对应的流水！",0);
    	document.form.phoneNo.focus();
    	return false;
    }
    
    if(returnValue == "" )
    {
    	rdShowMessageDialog("您没有选择对应的流水！",0);
    	document.form.phoneNo.focus();
    	return false;
    }
    
    document.form.water_number.value = returnValue;
    document.form.action="s1310_2td.jsp";
	
    document.form.submit();
    return true;
 
 
}
//-->
</script>
</HEAD>
<BODY>
<FORM action="s1310_2td.jsp" method=post name=form>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">缴费信息</div>
</div>
    <table cellspacing="0">
        <tr> 
            <td class="blue">业务类型</td>
            <td colspan=2>缴费冲正</td>
            <td class="blue">部门</td>
            <td colspan=2><%=belongName%> </td>
        </tr>
        
        
        <tr> 
            <td class="blue">服务号码</td>
            <td colspan=2>
 
                <input type="text" name="phoneNo" maxlength="11" onKeyDown="if(event.keyCode==13)form.billdate.focus()" onKeyPress="return isKeyNumberdot(0)"  >
            </td>
            <td class=blue>缴费月份</td>
            <td colspan=2> 
                <input type="text" name="billdate" maxlength="6" onKeyDown="if(event.keyCode==13)docheck()" onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>">
                <input class="b_text" name=sure22 type=button value=查询 onClick="docheck();">
            </td>
        </tr>
        <tr> 
            <td class=blue>帐户号码</td>
            <td colspan=2> 
                <input type="text" name="contractno" readonly  >
            </td>
            <td class=blue>缴费流水</td>
            <td colspan=2>
                <input type="text" readonly name="water_number">
            </td>
        </tr>
        <tr> 
            <td class=blue>用户/帐户名称</td>
            <td colspan=2> 
                <input type="text" readonly name="textfield7">
            </td>
            <td class=blue>缴费金额</td>
            <td colspan=2> 
                <input type="text" readonly name="textfield8">
            </td>
        </tr>
        <tr> 
            <td class=blue>用户数量</td>
            <td colspan=2> 
                <input type="text" readonly name="textfield6" maxlength="5">
            </td>
            <td class=blue>缴费时间</td>
            <td colspan=2> 
                <input type="text" readonly name="paytime" maxlength="20">
            </td>
        </tr>
        <tr> 
            <td class=blue>缴费工号</td>
            <td colspan=5>
                <input type="text" readonly name="textfield5" maxlength="6">
            </td>
        </tr>
        
        <tr> 
            <td colspan=6 class=blue>缴费信息</td>
        </tr>
        
        <tr> 
            <th>服务/帐户号码</th>
            <th>缴费金额</th>
            <th>预存款</th>
            <th>话费</th>
            <th colspan=2>滞纳金</th>
        </tr>
        
        
        <tr> 
            <td class=blue>退费金额</td>
            <td colspan=5>
                <input readonly name=remark2>
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
