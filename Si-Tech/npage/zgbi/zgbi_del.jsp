<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "zgbi";
		String opName = "冲正工号添加";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*默认，12个月之前*/
    String startTime = sdf.format(today.getTime());
	activePhone = request.getParameter("activePhone");	
%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function ghadd()
{
	//alert("1");
	var prtFlag=0;
	var s_login_no = document.all.s_login_no.value;
 
	if(s_login_no=="")
	{
		rdShowMessageDialog("请输入删除的工号!");
		return false;
	}
	else
	{
		prtFlag=rdShowConfirmDialog("是否确定进行冲正工号删除操作?");
		if (prtFlag==1){
			document.frm.action="zgbi_del_2.jsp?s_login_no="+s_login_no;
			//alert(document.frm.action);
			document.frm.submit();
		}
		else
		{ 
			return false;	
		}

	}

	
	
}
 


 function doclear() {
 		frm.reset();
 }
   
 function sel1() {
 		window.location.href='zgbi_1.jsp';
 }

 function sel2(){
    window.location.href='zgbi_del.jsp';
 }
 function sel3(){
    window.location.href='zgbi_upload.jsp';
 }
 

 
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请选择配置方式</div>
	</div>
	
	<table cellspacing="0">
      <tbody> 
	 
      <tr> 
        <td class="blue" width="15%">配置方式</td>
        <td colspan="4"> 
        	<q vType="setNg35Attr">
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >工号添加 
        </q>
 
          <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel2()" value="2" checked>工号删除
          </q>
          <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel3()" value="3">工号批量添加
          </q>
		  
	
     </tr>
	   
    </tbody>
  </table>
	
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">删除的工号</td>
      <td> 
        <input class="button"type="text" name="s_login_no" size="14" maxlength="14" >
      </td>
      
    </tr>
	 
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="冲正权限工号删除" onclick="ghadd()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>