<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2004-01-31
* revised : 2004-01-31
*/%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.15
 模块:神州行余额转帐
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = request.getParameter("activePhone");
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String workno = baseInfo[0][2];
    String workname = baseInfo[0][3];
	String belongName = baseInfo[0][16];
    String[][] favInfo = (String[][])arr.get(3);//读取优惠资费代码
	String op_code = "1588"  ;
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>黑龙江BOSS-神州行转余额转帐</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>

<script language="JavaScript">
<!--
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
function form_load()
{
//document.form.sure.disabled=true;
document.form.phoneno.focus();
}

function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
for (Count=0; Count < InString.length; Count++)  {
	TempChar= InString.substring (Count, Count+1);
	if (RefString.indexOf (TempChar, 0)==-1)  
	return (false);
}
return (true);
}

function getcount()
{
  if(!checkElement(document.all.phoneno)){
	  return false;
  }
  else{
	  var h=480;
	  var w=650;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	  if (document.form.busy_type.value=="1") {
	    var str=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneno.value,"",prop);
	  }
	  else 
	  {
	    var str=window.showModalDialog('getCountdead.jsp?phoneNo='+document.form.phoneno.value,"",prop);
	  }  
	  if( typeof(str) != "undefined" ){
		  if (parseInt(str)==0){
	     	rdShowMessageDialog("没有找到对应的帐号！",0);
	   	  document.form.phoneno.focus();
	   	  return false;
	    }
	    else {
	   	  document.form.contractno.value=str;
	     	return true;
	    }
	    return true;
　  }
  }
}

function pageSubmit(p)
{
  document.all.pw_favor.value=p; //对密码优惠赋值
  document.all.pw_flag.value=1;  //不是验证密码
  form.action="s1588_select.jsp";
  form.submit();
}

function pwValidate(p)
{
  document.all.pw_favor.value=p;
  document.all.pw_flag.value=p;
  var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
  var str=window.open('s1588_pw.jsp?phoneno='+document.form.phoneno.value+'&i2='+document.form.i2.value+'&pw_favor='+document.form.pw_favor.value+'&pw_flag='+document.form.pw_flag.value,"",prop);
}

function change1()
{
	document.form.sure.disabled="ture";
	document.form.index1.disabled="ture";
	return true;
}

//-->
</script>
</HEAD>

<BODY onLoad="form_load();">
<FORM action="s1588_select.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
<input type="hidden" name="busy_type"  value="1">

 	  <table cellspacing="0" >    
        <TR>
          <TD class="blue">服务号码</TD>
        <TD colspan="3">
          <input  name="phoneno" class="InputGrey" value="<%=phoneNo%>" v_must=1 v_type=mobphone onkeydown="if(event.keyCode==13 && check(form)){getcount();}" onKeyPress="isKeyNumberdot(0);" readOnly>
        </TD>
        <tr>
          <td class="blue">帐户号码</td>
          <td> 
            <input type="text" onKeyPress="return isKeyNumberdot(0)" name="contractno">
            <input class="b_text" name=index1 type=button value=查询帐号 onClick="getcount();">
          </td>
        </tr>
      </table>
      <table cellspacing="0">
        <tbody> 
        <tr> 
          <td id="footer"> 
            <input name=sure type="button" class="b_foot" value=确认 onClick="if(check(form)) pageSubmit('1');" >
            &nbsp;
            <input class="b_foot" name=clear type=reset value=清除>
            &nbsp;
            <input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
            &nbsp; 
          </td>
        </tr>
      </tbody> 
      </table>
   

  <input type="hidden" name="pw_favor" value="0">　<!--密码优惠标志 0为无优惠 -->
  <input type="hidden" name="pw_flag" value="1" >　<!--密码验证标志 0为验正-->
	<%@ include file="/npage/include/footer_simple.jsp" %>   
</FORM>
</BODY>

