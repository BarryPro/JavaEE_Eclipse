<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.s1310.viewBean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%/*
* name    :
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String workno = baseInfo[0][2];
    String workname = baseInfo[0][3];
	String belongName = baseInfo[0][16];

	String op_code = "zgai"  ;
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	Calendar cal = Calendar.getInstance(Locale.getDefault());
    cal.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(4,6))-1),Integer.parseInt(dateStr.substring(6,8)));
    String mon = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
%>

<HTML><HEAD><TITLE>黑龙江BOSS-物联网费用正补收</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
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
		else
			  return false;
    }
}
function form_load()
{
form.sure.disabled=true;
form.phoneno.focus();
}

function docheck()
{
	/* 号段改造20090304 liyan
	if (checkPhone())
if( form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1 || parseInt(form.phoneno.value.substring(0,3),10)<134 || (parseInt(form.phoneno.value.substring(0,3),10)>159)) {*/
/*
if(form.phoneno.value.substring(0,3)  == "209"){
	rdShowMessageDialog("请到e031宽带补收界面办理 !!")
	document.form.phoneno.focus();
	return false;	
}
*/

//xl add 451 045开头的可以办理
//xl add for hanfeng 10648开头的也可以办理
/*
if(form.phoneno.value.substring(0,3)  == "451" ||form.phoneno.value.substring(0,3)  == "045"||form.phoneno.value.substring(0,5)  == "10648")
{
	 
}
else 
if( form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1 || !checkPhone(form.phoneno.value)) {
		//alert("form.phoneno.value.substring(0,2) is "+form.phoneno.value.substring(0,2));
		
		if(form.phoneno.value.substring(0,2)  != "20"){
				rdShowMessageDialog("\请输入正确的服务号码,长度为11位数字 !!")
				document.form.phoneno.focus();
				return false;	
		}		
}*/
if( form.billmonth.value.length<6) {
rdShowMessageDialog("\请输入正确的归属年月,格式为YYYYMM !!")
document.form.billmonth.focus();
return false;
}
if( form.billmonth.value.substring(0,4)<"1990"||form.billmonth.value.substring(0,4)>"2020") {
rdShowMessageDialog("\输入的年份错误，请重新输入 !!")
document.form.billmonth.focus();
return false;
}
if( form.billmonth.value.substring(4)<"01"||form.billmonth.value.substring(4)>"12") {
rdShowMessageDialog("\输入的月份错误，请重新输入 !!")
document.form.billmonth.focus();
return false;
}

	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var str=window.showModalDialog('getCount_new.jsp?phoneNo='+document.form.phoneno.value,"",prop);

	if( typeof(str) != "undefined" ){
		if (parseInt(str)==0) {
	   		rdShowMessageDialog("没有找到对应的帐号！");
	   		return false; }
	   	else 
		{
			//alert("str is "+str);
			//document.all.zzname.value = returnValue.split(",")[0];
			document.form.contractno.value = str.split(",")[0];
			document.form.sm_code.value = str.split(",")[1];
			document.form.phoneno.value = str.split(",")[2];
			document.form.action="zgai_select.jsp";
			//xl add for hanfeng 非PB品牌不可以办理
			
			if(document.form.sm_code.value!="PB")
			{
				rdShowMessageDialog("非物联网号码不允许办理!");
	   			return false;
			}
			else
			{
				form.submit();
				return true; 
			}
			/*
			form.submit();
			return true; 
			*/
		}
	}

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

//-->
</script>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" onLoad="form_load()">
<FORM action="s2201_2.jsp" method=post name=form>
  <table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td background="<%=request.getContextPath()%>/images/jl_background_1.gif">
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr>
            <td align="right" width="45%">
              <p><img src="<%=request.getContextPath()%>/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
            <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=workno%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=workname%></td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr>
            <td align="right" background="<%=request.getContextPath()%>/images/jl_background_3.gif" height="69">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><img src="<%=request.getContextPath()%>/images/jl_logo.gif"></td>
                  <td align="right"><img src="<%=request.getContextPath()%>/images/jl_head_1.gif"></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr>
            <td align="right" width="73%">
              <table width="535" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                  <td valign="bottom" width="493">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>单个号码费用正补收</b></font></td>
                        <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="389" height="30"></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
            <td width="27%">
              <table border="0" cellspacing="0" cellpadding="4" align="right">
                <tr>
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_4.gif" width="60" height="50"></td>
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_5.gif" width="60" height="50"></td>
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr>
            <td width="45%"> <br>
              <table width=100% height=25 border=0 align="center" cellspacing=2 cellpadding="4">
                <tbody>
                <tr bgcolor="649ECC">
                  <td width="13%">操作类型：</td>
                  <td width="35%">
                    <select name = "optype" size = "1">
                      <option value = "1" selected>单个号码费用正补收</option>
                    </select>
                  </td>
                  <td width="13%"></td>
                  <td width="39%">部门：<%=belongName%></td>
                </tr>
                </tbody>
              </table>
              <table width=100% height=25 border=0 align="center" cellspacing=2>
                <tr bgcolor="#E8E8E8">
                  <td width="13%">服务号码：</td>
                  <td width="35%">
                    <input type="text"  class="button" name="phoneno" onkeydown="if(event.keyCode==13)form.billmonth.focus()" onKeyPress="return isKeyNumberdot(0)">
                  </td>
                  <td width="13%" align="left">归属年月：</td>
                  <td width="39%">
                    <input type="text" class="button" value="<%=mon%>" name="billmonth" readonly>
                    <input class="button" name=sure22 type=button value=查询 onClick="docheck()">
                  </td>
                </tr>
                <tr bgcolor="F5F5F5">
                  <td width="13%">帐户号码：</td>
                  <td width="35%">
                    <input type="text" readonly class="button" name="contractno" value="">
                  </td>
                  <td width="13%">客户名称：</td>
                  <td width="39%">
                    <input type="text" readonly name="textfield7" class="button">
                  </td>
                </tr>
                <tr bgcolor="#E8E8E8">
                  <td width="13%">运行状态： </td>
                  <td width="35%">
                    <input type="text" readonly class="button" name="textfield5">
                  </td>
                  <td width="13%">客户信息：</td>
                  <td width="39%">
                    <input type="text" readonly name="textfield72" class="button">
                  </td>
                </tr>
				<!--xl add 新增品牌-->
				<tr bgcolor="#E8E8E8">
                  <td width="13%">品牌</td>
                  <td width="35%">
                    <input type="text" readonly class="button" name="sm_code">
                  </td>
                </tr>
              </table>
              <table width="100%" height=25 border=0 align="center" cellspacing=2>
                <tr bgcolor="#F5F5F5">
                  <td colspan="4">以下为可调整的费用信息：</td>
               	</tr>


                <tr bgcolor="#E8E8E8">
                  <td>
                    <div align="center">费用名称</div>
                  </td>
                  <td>
                    <div align="center">金额</div>
                  </td>
                </tr>
              </table>
              <table width=100% height=25 border=0 align="center" cellspacing=1 cellpadding="4">
                <tbody>
                <tr bgcolor="#F5F5F5">
                  <td width=13%>金额总计：</td>
                  <td width="87%">
                    <input type="text"  class="button" name="total_pay" readonly value="">
                  </td>
                </tr>
                <tr bgcolor="#E8E8E8">
                  <td width="13%">备注信息：</td>
                  <td width="87%">
                    <input type="text"  class="button" name="TOpNote" maxlength="60" size="60">
                  </td>
                </tr>
                </tbody>
              </table>
              <table width="100%" border=0 align=center cellpadding="4" cellspacing=1>
                <tbody>
                <tr bgcolor="#EEEEEE">
                  <td align=center bgcolor="F5F5F5" width="100%">
                    <input class="button" name=sure type=button value=确认>
                    <input class="button" name=reset type=reset value=关闭 onClick="window.close()">
                    &nbsp; </td>
                </tr>
                </tbody>
              </table>
              <p>&nbsp;</p>
            </td>
          </tr>
        </table>
        <br>
      </td>
    </tr>
  </table>
 </FORM>
</BODY></HTML>
