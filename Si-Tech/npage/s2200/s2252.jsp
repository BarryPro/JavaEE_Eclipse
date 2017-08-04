<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.sitech.boss.s5010.viewBean.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "2252";
	String opName = "提醒、催缴阀值配置";
    String workno =(String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String orgcode =((String)session.getAttribute("orgCode")).substring(0, 2);//机构代码
    
    String outNum = "2";
	ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
    
    CallRemoteResultValue callRemoteResultValue = null;
    String[][] result = new String[][]{};
    String[] inParas = new String[]{""};
%>

<head>
<title>黑龙江BOSS-提醒、催缴阀值配置</title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
var awakeCallingCode = new Array();

<%
    inParas[0] = "select * from sAwakeCallingCode where region_code = '" + orgcode + "'";
    callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", "10", inParas);
   
    result = callRemoteResultValue.getData();
    
	for(int i=0; i<result.length; i++){
%>
       awakeCallingCode[<%=i%>] = new Array();
<%
	   for(int j=0; j<result[i].length; j++){
%>
     
       awakeCallingCode[<%=i%>][<%=j%>] = '<%=result[i][j]%>';
<%
	    }
    }
%>


var po_ca_show = new Array();
var po_ca_value = new Array();
var po_detail_show = new Array();
var po_detail_value = new Array();
 
<%
   inParas[0] = "select * from sstopoprtypecode where operate_type != 'SPAC'";
   callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", outNum, inParas);
   result = callRemoteResultValue.getData();
    	 
   for(int i=0; i<result.length; i++){
%>

	  po_ca_show[<%=i%>]='<%=result[i][1]%>';
      po_ca_value[<%=i%>]='<%=result[i][0]%>';	  
      po_detail_show[<%=i%>]= new Array();
      po_detail_value[<%=i%>]= new Array();
      
	  <%
	     String operate_type = result[i][0].trim().toLowerCase();
	     
	     if (operate_type.equals("owne")) {
	         inParas[0] = "select owner_code,type_name from sOwnerCode where region_code = '"+ orgcode + "'";
		 } else if (operate_type.equals("card")) {
             inParas[0] = "select card_type,card_name from sBigCardCode";
		 } else if (operate_type.equals("sm")) {
             inParas[0] = "select sm_code, sm_name from sSmCode where region_code = '"+ orgcode + "'";
		 } else if (operate_type.equals("cred")) {
             inParas[0] = "select credit_code,credit_name from sCreditCode where region_code = '"+ orgcode + "'";
		 } else if (operate_type.equals("bill")) {
             inParas[0] = "select offer_id,offer_name from product_offer ";
		 }
         
         callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", outNum, inParas); 
         String[][] result1 = callRemoteResultValue.getData();
         
         for(int j=0; j<result1.length; j++){ 
	  %>      
	       po_detail_show[<%=i%>][<%=j%>]='<%=result1[j][1]%>';
           po_detail_value[<%=i%>][<%=j%>]='<%=result1[j][0]%>';
	  <%}%>
	  
<%
   }
%>

onload=function(){
   //Do_po_Change();
   operate_change();
}

function Do_po_Change(){
    var num,n, i, m;
	num= GetObjID('i_operate_type');
    m = document.mainForm.elements[num].selectedIndex;
    n = document.mainForm.elements[num + 1].length;

	if (n > 1) {
	   for(i = n - 1; i >= 0; i--) {
         document.mainForm.elements[num + 1].options[i] = null;
       }
	}

	if (m>=0) {
        for(i = 0; i < po_detail_show[m].length; i++){
           NewOptionName = new Option(po_detail_show[m][i], po_detail_value[m][i]);
           document.mainForm.elements[num + 1].options[i] = NewOptionName;
        }

		if (po_detail_show[m].length > 0) {
		   document.mainForm.elements[num + 1].options[0].selected = true;
		}
    }
    
	operate_change();
}

function GetObjID(ObjName) { 
  for (var ObjID=0; ObjID < window.mainForm.elements.length; ObjID++) {
    if ( window.mainForm.elements[ObjID].name == ObjName ) {  
	   return(ObjID);
       break;
    }
  }
  return(-1);
}

function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0) {
		if(s_keycode>=48 && s_keycode<=57) {
			return true;
		} else {
			return false;
		}
    } else if (ifdot==1) {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46) {
		      return true;
		} else if(s_keycode==45) {
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
		    return false;
		} else {
		    return false;
		}
    } else if (ifdot==2) {
        if((s_keycode>=48 && s_keycode<=57) || s_keycode==46 || s_keycode==45) {
		      return true;
		} else {
		    return false;
		}
    }
}


function dosubmit() {
   if (document.mainForm.i_awake_fee.value.length == 0) {
      rdShowMessageDialog("提醒阀值不能为空，请重新输入 !!")
      document.mainForm.i_awake_fee.focus();
      return false;
   } else if (document.mainForm.i_awake_times.value.length == 0) {
      rdShowMessageDialog("提醒次数不能为空，请重新输入 !!")
      document.mainForm.i_awake_times.focus();
      return false;
   }if (document.mainForm.i_calling_fee.value.length == 0) {
      rdShowMessageDialog("催缴（停机）阀值不能为空，请重新输入 !!")
      document.mainForm.i_calling_fee.focus();
      return false;
   }if (document.mainForm.i_calling_times.value.length == 0) {
      rdShowMessageDialog("催缴次数不能为空，请重新输入 !!")
      document.mainForm.i_calling_times.focus();
      return false;
   } else {
      var ii_awake_fee = parseInt(document.mainForm.i_awake_fee.value);
	  var ii_calling_fee = parseInt(document.mainForm.i_calling_fee.value);
      
      if (ii_awake_fee < ii_calling_fee) {
          rdShowMessageDialog("提醒阀值不能小于催缴（停机）阀值，请重新输入 !")
          document.mainForm.i_awake_fee.focus();
      } else {
         //document.mainForm.list.disabled=true;
         document.mainForm.sure.disabled=true;
         document.mainForm.reset.disabled=true;
         document.mainForm.close.disabled=true;
      
         document.mainForm.submit();
      }      
   }
}

function sel1() {
   document.all.busy_type.value = "I";
}

function sel2() {
   document.all.busy_type.value = "U";
}

function sel3() {
   document.all.busy_type.value = "D";
}

function operate_change() {
    with(document.mainForm) {
		i_awake_fee.value =  "";
		i_awake_times.value =  "";
		i_calling_fee.value =  "";
		i_calling_times.value =  "";
		i_op_note.value =  "";
		
		  for( var i=0; i<awakeCallingCode.length; i++ ) {		
				i_awake_fee.value =  awakeCallingCode[i][4];
				i_awake_times.value =  awakeCallingCode[i][5];
				i_calling_fee.value =  awakeCallingCode[i][6];
				i_calling_times.value =  awakeCallingCode[i][7];
				i_op_note.value =  "";				
				break;
		  }	
		 
	 }
    
}
</script>
</head>

<body >
<form action="s2252_2.jsp" method="post" name="mainForm">
	<%@ include file="/npage/include/header.jsp" %>
   <input type="hidden" name="i_func_code" value="2310"> 
   <input type="hidden"	name="i_calling_cyc" value="1"> 
   <input type="hidden"	name="i_limit_flag" value="1"> 
   <input type="hidden" name="busy_type" value="I">
   <input type="hidden" name="i_operate_type" value="SPAC">
   <input type="hidden" name="i_operate_code" value="SPAC"> 
		<div class="title">
			<div id="title_zi">提醒、催缴阀值配置</div>
		</div>   
	<!-- 操作类型开始-->
	<table cellspacing="1">
		<tbody>
			<tr>
				<td class="blue">操作类型</td>
				<td nowrap>
					<input type="radio" name="busyType" value="I" onClick="sel1()" checked> 增加
					<input type="radio" name="busyType" value="U" onClick="sel2()"> 修改
					<input type="radio" name="busyType" value="D" onClick="sel3()"> 删除
				</td>
		</tbody>
	</table>
				<!-- 操作类型结束 -->

				<table cellspacing="0">
					<tr>
						<td nowrap class="blue">提醒阀值</td>
						<td >
							<input class="button" type="text" name="i_awake_fee" maxlength="5" onKeyPress="return isKeyNumberdot(1)">
							<font class="orange"> *</font>
						</td>
						<td class="blue" nowrap>提醒次数</td>
						<td width="35%">
							<input class="button" type="text" name="i_awake_times" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
							<font class="orange"> *</font>
						</td>
					</tr>

					<tr>
						<td class="blue" nowrap>催缴（停机）阀值</td>
						<td width="35%">
							<input class="button" type="text" name="i_calling_fee" maxlength="5" onKeyPress="return isKeyNumberdot(2)">
							<font class="orange"> *</font>
						</td>
						<td class="blue" nowrap>催缴次数</td>
						<td  ><input class="button" type="text" name="i_calling_times" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
							<font class="orange"> *</font>
						</td>
					</tr>

					<tr>
						<td class="blue" nowrap>用户备注：</td>
						<td width="75%" colspan="3">
							<input class="button" name="i_op_note" size=60 maxlength="60">
						</td>
					</tr>
				</table>

				<!-- 功能按钮开始 -->
				<table cellspacing="1">
					<tr>
						<td noWrap id="footer" colspan="6">
						<input type="button" name="sure" class="b_foot" value="确认"	onClick="dosubmit()"> &nbsp; 
						<input type="reset" name="reset" class="b_foot" value="清除"> &nbsp; 
						<input type="button" name="close" class="b_foot" value="关闭" onClick="window.close()">
						</td>
					</tr>
				</table>
				  	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
