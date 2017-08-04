<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglm
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>订单状态信息查询</TITLE>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
    String opCode = "d008";
    String opName = "订单状态信息查询";
%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
%>
</HEAD>

<body>
<script type="text/javascript" src="validate_time.js"></script>
<SCRIPT language="JavaScript">

function yincang(flag){
	if(flag == "1"){
		$("#tr2").hide();
		$("#tr3").hide();
		$("#tr1").show();
		$("#tr4").hide();
	}else if(flag == "2"){
		$("#tr1").hide();
		$("#tr3").hide();
		$("#tr2").show();
		$("#tr4").hide();
	}else if(flag == "0"){
	    $("#tr1").hide();
		$("#tr2").hide();
		$("#tr3").show();
		$("#tr4").hide();	
	}else{
		$("#tr1").hide();
		$("#tr2").hide();
		$("#tr3").hide();
		$("#tr4").show();
	} 
}
function yincanga(fl){
	if(fl == "0"){
		$("#tr5").hide();
	}else {
		$("#tr5").show();
	}
}
function doCheck(){
    	frm.action="fd008_sel.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    	frm.submit();
}
</SCRIPT>

<FORM method=post name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">订单状态信息查询</div>
</div>

	<TABLE cellSpacing=0>
		<tr>
		 <td class=blue>查询订单类型</td>	
		 <td><input type="radio" name="dingdanType" value="0" checked  onclick='yincanga("0")' />在途订单
		     <input type="radio" name="dingdanType" value="1"  onclick='yincanga("1")' />历史订单	
		 </td>
		</tr>
		<tr>
		 <td class=blue>查询订单方式</td>	
		 <td>
		 	<input type="radio" name="dingdanSel" value="0"  onclick='yincang("0")' />按工号查询
		 	<input type="radio" name="dingdanSel" value="1" checked onclick='yincang("1")' />按订单号查询
		    <input type="radio" name="dingdanSel" value="2"  onclick='yincang("2")' />按宽带账号查询
		    <input type="radio" name="dingdanSel" value="3"  onclick='yincang("3")' />按电话号查询	
		    <input type="radio" name="dingdanSel" value="3"  onclick='yincang("3")' />按操作流水	
		    <input type="radio" name="dingdanSel" value="5"  onclick='yincang("3")' />按客户订单号	
		 </td>
		</tr>
		<tr id="tr1"> 
		 <td class=blue>输入订单号</td>	
		 <td><input type="text" name="dingdanNum"  />
		 </td>
		</tr>
		
		<tr style="display:none" id="tr2">
		 <td class=blue>输入宽带账号</td>	
		 <td><input type="text" name="kuandaiNum"  />
		 </td>
		</tr>
		
		<tr style="display:none" id="tr3">
		 <td class=blue>输入工号</td>	
		 <td><input type="text" name="gonghao"  />
		 </td>
		</tr>
		
		<tr style="display:none" id="tr4">
		 <td class=blue>输入电话号</td>	
		 <td><input type="text" name="phoneNum"  />
		 </td>
		</tr>
		
		<tr style="display:none" id="tr5">
		 <td class=blue>输入查询时间</td>	
		 <td><input type="text" name="dtime"  v_type="new_date" maxlength="6" onblur="checkElement1(this)"  />
		 	 <font color="orange">* 时间格式为200011</font>
		 </td>
		</tr>
  <tr id="footer" > 
    <td colspan=2>
    	<input type="submit" class="b_foot" name="sub" value="查询" onclick="doCheck()">
      <input class="b_foot" name=reset  type=reset onClick="" value=清除>
      <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
    </td>
  </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->
