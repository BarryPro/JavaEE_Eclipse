<%
/********************
 version v2.0
开发商: si-tech
update: zhangshuaia@2009-07-06
********************/

%>
 <!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
  String opCode = "8676";     
  String opName = "输入笔记本IMEI码查询所绑定的手机号码";
  String imeiNo = request.getParameter("imeiNo");
  String loginNo = (String)session.getAttribute("workNo");
  
  /*获取系统时间*/
  java.util.Date sysdate = new java.util.Date();
  SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
  String begin_time = sf.format(sysdate);
  
  String retFlag="",retMsg="",passwordFromSer="",machineType="",totalDate="",custPhone="",phoneNo="";
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String[][] tempArr= new String[][]{};
  String[][] result2  = null;

%>
<wtc:service  name="s8676Qry" outnum="25"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=phoneNo%>"/>
	<wtc:param  value="<%=opCode%>"/>
	<wtc:param  value="<%=loginNo%>"/>
	<wtc:param  value="<%=imeiNo%>"/>
</wtc:service>
<wtc:array id="retList"  start="0" length="18" scope="end"/>
<wtc:array id="retList2" start="18" length="7" scope="end"/>
<%
  System.out.println("retList"+retList);
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
	   System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8676Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!errCode.equals("000000")&&!errCode.equals("0")){%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			parent.window.location="f8676_1.jsp?opCode=<%=opCode%>";
		</script>
	<%}
	else
	{
	  bp_name = retList[0][2];
	  bp_add = retList[0][3];
	  cardId_type = retList[0][4];
	  cardId_no = retList[0][5];
	  sm_code = retList[0][6];
	  region_name = retList[0][7];
	  run_name = retList[0][8];
	  vip = retList[0][9];
	  posint = retList[0][10];
	  prepay_fee = retList[0][11];
	  passwordFromSer = retList[0][13];
	  imeiNo = retList[0][14];
	  machineType = retList[0][15];
	  totalDate = retList[0][16];
	  custPhone = retList[0][17];

	  result2 = retList2;
	}
  }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>输入手机号码查询所绑定的笔记本IMEI码</title>

<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>

<body>
<form name="frm" method="post" action="" onKeyUp="chgFocus(frm)">
<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">基本信息</div>
	</div>
  <table  cellspacing="0">
	<tr>
            <td class="blue">用户手机号码</td>
            <td>
            			<input name="imei_no" value="<%=custPhone%>" type="text" Class="InputGrey" v_must=1 readonly id="imei_no" maxlength="20" >
            </td>			
            <td class="blue">机器类型</td>
	    	<td>
						<input name="machine_type" value="<%=machineType%>" type="text" Class="InputGrey" v_must=1 readonly id="machine_type" maxlength="20" >
			</td> 
	</tr>
	<tr >
            <td class="blue">客户姓名</td>
            <td>
						<input name="cust_name" value="<%=bp_name%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名">
            </td>
            <td class="blue">绑定时间</td>
            <td>
						<input name="cust_addr" value="<%=totalDate%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="50" size="50" >
            </td>
	</tr>
	<tr>
            	<td class="blue">证件类型</td>
            <td>
						<input name="cardId_type" value="<%=cardId_type%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" >
            </td>
            <td class="blue">证件号码</td>
            <td>
						<input name="cardId_no" value="<%=cardId_no%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" >
            </td>
	</tr>
	<tr>
            <td class="blue">业务品牌</td>
            <td>
						<input name="sm_code" value="<%=sm_code%>" type="text" Class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" >
            </td>
            <td class="blue">运行状态</td>
            <td>
						<input name="run_type" value="<%=run_name%>" type="text" Class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" >
            </td>
	</tr>
	<tr>
            <td class="blue">VIP级别</td>
            <td>
						<input name="vip" value="<%=vip%>" type="text" Class="InputGrey" v_must=1 readonly id="vip" maxlength="20" >
            </td>
            <td class="blue">可用预存</td>
            <td>
						<input name="prepay_fee" value="<%=prepay_fee%>" type="text" Class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" >
            </td>
	</tr>
    </table>
    </div>

	<input type="hidden" name="Market_Price" id="Market_Price">
	
</form>
</body>


</html>