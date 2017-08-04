<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-------------------------------------------->
<!---日期:  2008-11-14 14:56:27    ---->
<!---作者:  jiangqing                       ---->
<!---代码:  f1848                         ---->
<!---功能：视频会议                       ---->
<!---修改：办理服务开通，注销，预约，取消预约         ---->
<!-------------------------------------------->
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<!-------------------以下是自动调用查询WTC函数------------------------>
<%
String opCode = "1848";
String opName = "视频会议";
String op_name="";
String regionCode = (String)session.getAttribute("regCode");
String phone_no=request.getParameter("phone_no");
String work_no =(String)session.getAttribute("workNo");
String loginName =(String)session.getAttribute("workName");

//String regionCode = (String)session.getAttribute("regCode");
//String phone_no=request.getParameter("phone_no");
//arrSession = (ArrayList)session.getAttribute("allArr");
//baseInfoSession = (String[][])arrSession.get(0);
//work_no = baseInfoSession[0][2];
%>
<wtc:service name="s1848Qry" outnum="7" routerKey="phone" routerValue="<%=phone_no%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result"  start="0" length="7"  scope="end" />
<%
String return_code="";
String return_msg="";
String id_no = "";
String cust_name="";
String run_code="";
String run_name="";
String opr_code="";

return_code = result[0][0].trim();
return_msg = result[0][1].trim();
id_no = result[0][2].trim();
cust_name = result[0][3].trim();
run_code = result[0][4].trim();
run_name = result[0][5].trim();
opr_code = result[0][6].trim();
%>

<html>
<head>
<title><%=opName%></title>
<script type="text/javascript">
onload=function()
{
	var runcode = "<%=run_code%>";
	var opr_code = "<%=opr_code%>"==""?"00":"<%=opr_code%>";
  	if(runcode != 'A' && runcode != 'K')
  	{
  		document.getElementById("kt").disabled=true;
        document.getElementById("yy").disabled=true;
        document.getElementById("qx").disabled=true;
        document.getElementById("zx").disabled=true;
     }
	else
	{
     	if(opr_code=="00")
		{
			document.getElementById("kt").disabled=false;
	        document.getElementById("yy").disabled=true;
	        document.getElementById("qx").disabled=true;
	        document.getElementById("zx").disabled=true;
		}
		else
		{
			document.getElementById("kt").disabled=true;
			if(opr_code=="01")
			{
		        document.getElementById("yy").disabled=false;
		        document.getElementById("qx").disabled=true;
		        document.getElementById("zx").disabled=false;
			}
			if(opr_code=="21")
			{
		        document.getElementById("yy").disabled=true;
		        document.getElementById("qx").disabled=false;
		        document.getElementById("zx").disabled=false;
			}
		}	
	}
}

function show()
{
	document.getElementById("yy").checked ? document.getElementById("booking_vc").style.display="block" : document.getElementById("booking_vc").style.display="none";
}

function doCfm()
{
	
	var count = 0;
	var oprcode;
	var conf_type;
	for(var i = 0 ; i < document.frm.opr_code.length ; i ++)
	{
		if(document.all.opr_code[i].checked)
		{
			count += 1;
			oprcode = document.frm.opr_code[i].value;
		} 
	}
	if(count == 0)
	{
		rdShowMessageDialog("请至少选择一项操作！");
		return;	
	}
	for(var i = 0 ; i < document.frm.conf_type.length ; i ++)
	{
		if(document.all.conf_type[i].checked)
		{
			count += 1;
			conf_type = document.frm.conf_type[i].value;
		} 
	}
	if(document.frm.effeti_time.value != "")
	{
		if(!forDate(document.frm.effeti_time)){
			rdShowMessageDialog("希望生效时间输入格式不正确,请重新输入!");
			return false;
		}
	}
	if(document.getElementById("yy").checked)
	{
		if(document.frm.max_speaker_num.value - document.frm.max_num.value > 0)
		{
			rdShowMessageDialog("会议同时最多发言人数不能大于最大与会人数,请重新输入!");
			return false;
		}
		if(!forDate(document.frm.start_time)){
			rdShowMessageDialog("预约时间输入格式不正确,请重新输入!");
			return false;
		}
		if(!forDate(document.frm.end_time)){
			rdShowMessageDialog("结束时间输入格式不正确,请重新输入!");
			return false;
		}
		var start_time=document.frm.start_time.value;
		var end_time=document.frm.end_time.value;
		if(start_time >= end_time)
		{
			rdShowMessageDialog("开始时间必须小于结束时间！");
			return false;
		}
	}
	
	frm.action="f1848_cfm.jsp";
	frm.submit();
}
</script>
<!--js-->


</head>

<body>
<form name="frm">
	<%@ include file="/npage/include/header.jsp" %>   
	<div class="title">
			<div id="title_zi">视频会议</div>
		</div>
        <table width="98%"  cellspacing="2">
           <tr > 
		      <td  nowrap><input type="hidden" name="phone_no" value="<%=phone_no%>"></td>
			  <td  nowrap><input type="hidden" name="work_no" value="<%=work_no%>"></td>
		   </tr>
		   <tr > 
		      <td width="10%"  nowrap>手机号码</td>
			  <td nowrap><%=phone_no%></td>
		   </tr>
		   <tr> 
		      <td width="10%" nowrap>客户名称</td>
			  <td  nowrap>
			  <%if(cust_name.trim().equals("unknow")){out.print("<font color=#880000>客户姓名未登记</font>");}else{out.print(cust_name);}%>
			  </td>
		   </tr>
		   <tr > 
		      <td width="10%"  nowrap>当前手机状态</td>
			  <td nowrap>
				<font color="#880000"><%=run_name%></font>
			  </td>
		   </tr>
		   
		   <tr > 
		      <td width="10%"  nowrap>办理类型</td>
			  <td  nowrap>
			    <input type="radio" name="opr_code" id="kt" value="01" onclick="show();">开户&nbsp;
			    <input type="radio" name="opr_code" id="yy" value="21" onclick="show();">预约会议&nbsp;
			    <input type="radio" name="opr_code" id="qx" value="22" onclick="show();">取消预约&nbsp;
				<input type="radio" name="opr_code" id="zx" value="02" onclick="show();">注销&nbsp;
			  </td>
		   </tr>
		   
		   <tr > 
		      <td width="10%"  nowrap> 希望生效时间</td>
			  <td  nowrap>
			    <input type="text" name="effeti_time" id="effeti_time" v_type="date" v_format = "yyyyMMdd" v_name="生效时间" size="20" maxlength="8"/>
			  </td>
		   </tr>
		  
		  <tr> 
		      <td width="10%"  nowrap> SP企业代码</td>
			  <td  nowrap>
			    <input type="text" name="sp_id" id="sp_id" size="20" maxlength="18"/>
			  </td>
		   </tr>
		   
		    <tr height="26"> 
		      <td width="10%"  nowrap> SP套餐代码</td>
			  <td  nowrap>
			    <input type="text" name="pack_numb" id="pack_numb" size="20" maxlength="24"/>
			  </td>
		   </tr>
		  
			<tr > 
		      <td width="10%"  nowrap> SP业务代码</td>
			  <td  nowrap>
			    <input type="text" name="biz_code" id="biz_code" size="20" maxlength="10"/>
			  </td>
			</tr>

			<tbody id="booking_vc" style="display:none;">
				<tr > 
				  <td width="10%"  nowrap> 会议类型</td>
				  <td  nowrap>
					<input type="radio" name="conf_type" id="yp" value="01" checked>音频&nbsp;
					<input type="radio" name="conf_type" id="sp" value="02">视频&nbsp;
				  </td>
				</tr>
				
				<tr > 
				  <td width="12%"  nowrap> 最大与会人数</td>
				  <td nowrap>
					<select size="1" name="max_num" id="max_num">
					   <option value="1" selected>1人</option>
					   <option value="2">2人</option>
					   <option value="3">3人</option>
					   <option value="4">4人</option>
					   <option value="5">5人</option>
					   <option value="6">6人</option>
					   <option value="7">7人</option>
					   <option value="8">8人</option>
					 </select>
				  </td>
			   </tr>
			   
			   <tr > 
				  <td width="12%"  nowrap> 同时最多发言人数</td>
				  <td  nowrap>
					<select size="1" name="max_speaker_num" id="max_speaker_num">
					   <option value="1" selected>1人</option>
					   <option value="2">2人</option>
					   <option value="3">3人</option>
					   <option value="4">4人</option>
					   <option value="5">5人</option>
					   <option value="6">6人</option>
					   <option value="7">7人</option>
					   <option value="8">8人</option>
					 </select>
				  </td>
			   </tr>
			   
			   <tr > 
				  <td width="10%" nowrap> 会议开始时间</td>
				  <td  nowrap>
					<input type="text" name="start_time" id="start_time" v_type="date_time" v_format = "yyyyMMdd HH:mm:ss" v_name="开始时间"  size="20"  maxlength="17"/>&nbsp;<font color=red>*</font>
				  </td>
			   </tr>
			   
			   <tr height="26"> 
				  <td width="10%"  nowrap> 会议结束时间</td>
				  <td nowrap>
					<input type="text" name="end_time" id="end_time" v_type="date_time" v_format = "yyyyMMdd HH:mm:ss" v_name="结束时间"  size="20"  maxlength="17"/>&nbsp;<font color=red>*</font>
				  </td>
			   </tr>
			   
			   <tr > 
				  <td width="10%" nowrap> 会议密码</td>
				  <td nowrap>
					<input type="password" name="conf_pwd" id="conf_pwd" size="21" maxlength="8"/>
				  </td>
			   </tr>
			   
			   <tr > 
				  <td width="10%" nowrap> 主持人密码</td>
				  <td  nowrap>
					<input type="password" name="compere_pwd" id="compere_pwd" size="21" maxlength="8"/>
				  </td>
			   </tr>
			   
			   <tr> 
				  <td width="10%" nowrap> 会议内容</td>
				  <td  nowrap>
					<input type="text" name="conf_cont" id="conf_cont" size="20" maxlength="256"/>
				  </td>
			   </tr>
			   
			   <tr > 
				  <td width="10%" nowrap> 会议id</td>
				  <td  nowrap>
					<input type="text" name="conf_id" id="conf_id" size="20" maxlength="32"/>
				  </td>
			   </tr>
		  </tbody>
		   <tr height="26"> 
		      <td width="10%"  nowrap align="center" colspan="2"> 
			    <input type="button" class="b_foot" value="确认" name="confirm" onclick = "doCfm();">&nbsp;&nbsp;&nbsp;
			    <input type="reset" class="b_foot" value="清除" name="reset">&nbsp;&nbsp;&nbsp;
				<input type="button" class="b_foot" value="返回" name="close" onclick="history.go(-1)">
              </td>
		   </tr>
        </table>
        <%@ include file="/npage/include/footer.jsp" %>   
</form>
<br><br>
</body>
</html>
