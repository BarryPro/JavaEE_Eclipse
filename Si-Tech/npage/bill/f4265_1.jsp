<%
/********************
 * version v2.0
 * 开发商: si-tech
 * 作者: dujl
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
    String opCode = "4265";
    String opName = "公务测试号转入冲正";

    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    System.out.println("       =======ip_Addr=======       "+ip_Addr);
    String regionCode = orgCode.substring(0,2);
    String loginNoPass = (String)session.getAttribute("password");
    String paraStr[]=new String[1];
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    paraStr[0] = seq;
    System.out.println("loginAccept === "+paraStr[0]);

    String  retFlag="",retMsg="";
    String  bp_name="",sm_code="",rate_code="",sm_name="",use_level="";
    String  rate_name="",next_rate_code="",next_rate_name="";
    String  bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
    String  imain_stream="",next_main_stream="",hand_fee="";
    String  favorcode="",phone_ty="",phone_type="",warning_money="",type_code="";
    String  limit_money="",end_time="",use_unit="";
    String  use_department="",use_center="",use_application="";
    String  oModeCodeSm="",oBlackCode="",iLoginNoAccept="";

    String iPhoneNo = request.getParameter("phoneNo");
    String iOpCode = request.getParameter("opcode");
	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);

%>
    <wtc:service name="s4265Init" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="s4265InitCode" retmsg="s4265InitMsg" outnum="42" >
    	<wtc:param value="<%=inputParsm[0]%>"/>
    	<wtc:param value="<%=inputParsm[1]%>"/>
        <wtc:param value="<%=inputParsm[2]%>"/>
        <wtc:param value="<%=inputParsm[3]%>"/>
    </wtc:service>
    <wtc:array id="s4265InitArr" scope="end" />
<%
	String errCode = s4265InitCode;
	String errMsg = s4265InitMsg;

	if(s4265InitArr == null)
	{
		System.out.println("ccccccccccccc");
	   	retFlag = "1";
	   	retMsg = "s4265Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
	}
  	else
  	{
  		System.out.println("errCodeerrCodeerrCodeerrCode="+errCode);
  		System.out.println("s4265InitArrs4265InitArrs4265InitArr="+s4265InitArr.length);

	  	if (errCode.equals("000000") && s4265InitArr.length>0 )
	  	{
	  		System.out.println("s4265InitArr[0][3]+"+s4265InitArr[0][1]);

		 	if(!(s4265InitArr[0][3].equals(""))){
		    	bp_name = s4265InitArr[0][3];           		//机主姓名
		  	}

			if(!(s4265InitArr[0][6].equals(""))){
				rate_name = s4265InitArr[0][6];        			//资费名称
			}

			if(!(s4265InitArr[0][22].equals("")))
			{
				phone_ty = s4265InitArr[0][22];            		//号码类型
				if(phone_ty.equals("0"))
				{
					phone_type="测试号";
				}else if(phone_ty.equals("1"))
				{
					phone_type="公务号";
				}
			}

			if(!(s4265InitArr[0][23].equals(""))){
				warning_money = s4265InitArr[0][23];            //告警金额
			}

			if(!(s4265InitArr[0][26].equals(""))){
				limit_money = s4265InitArr[0][26];            	//预存限额
			}

			if(!(s4265InitArr[0][25].equals(""))){
				end_time = s4265InitArr[0][25];            		//结束时间
			}

			if(!(s4265InitArr[0][27].equals(""))){
				type_code = s4265InitArr[0][27];            	//省市标志
			}

			if(!(s4265InitArr[0][28].equals(""))){
				use_unit = s4265InitArr[0][28];            		//使用单位
			}

			if(!(s4265InitArr[0][29].equals(""))){
				use_department = s4265InitArr[0][29];           //使用部门
			}

			if(!(s4265InitArr[0][30].equals(""))){
				use_center = s4265InitArr[0][30];            	//使用中心
			}

			if(!(s4265InitArr[0][31].equals(""))){
				use_application = s4265InitArr[0][31];          //使用用途
			}

			if(!(s4265InitArr[0][32].equals(""))){
				use_level = s4265InitArr[0][32];            	//级别
			}

			if(!(s4265InitArr[0][21].equals(""))){
				cust_id = s4265InitArr[0][21];					//客户id
			}

			if(!(s4265InitArr[0][5].equals(""))){
				rate_code = s4265InitArr[0][5];     			//当前资费代码
			}

			if(!(s4265InitArr[0][7].equals(""))){
				next_rate_code = s4265InitArr[0][7];			//下月资费代码
			}

			if(!(s4265InitArr[0][18].equals(""))){
				cust_belong_code = s4265InitArr[0][18];			//客户归属id
			}

			if(!(s4265InitArr[0][4].equals(""))){
				bp_add = s4265InitArr[0][4];            		//客户地址
			}

			if(!(s4265InitArr[0][15].equals(""))){
				cardId_type = s4265InitArr[0][15]; 				//证件类型
			}

			if(!(s4265InitArr[0][16].equals(""))){
				cardId_no = s4265InitArr[0][16];				//证件号码
			}

			if(!(s4265InitArr[0][9].equals(""))){
				sm_code = s4265InitArr[0][9];         			//业务类别
			}

			if(!(s4265InitArr[0][10].equals(""))){
				sm_name = s4265InitArr[0][10];					//业务类型名称
			}

			if(!(s4265InitArr[0][12].equals(""))){
				favorcode = s4265InitArr[0][12];     			//优惠代码
			}

			if(!(s4265InitArr[0][19].equals(""))){
				imain_stream = s4265InitArr[0][19];				//当前资费开通流水
			}

			if(!(s4265InitArr[0][20].equals(""))){
				next_main_stream = s4265InitArr[0][20];			//预约资费开通流水
			}

			if(!(s4265InitArr[0][8].equals(""))){
				next_rate_name = s4265InitArr[0][8];			//下月资费名称
			}

			if(!(s4265InitArr[0][11].equals(""))){
				hand_fee = s4265InitArr[0][11];      			//手续费
			}

			if(!(s4265InitArr[0][39].equals(""))){
				oBlackCode = s4265InitArr[0][39];				//冲正套餐代码
			}

			if(!(s4265InitArr[0][40].equals(""))){
				oModeCodeSm = s4265InitArr[0][40];				//冲正套餐名称
			}
			if(!(s4265InitArr[0][41].equals(""))){
				iLoginNoAccept = s4265InitArr[0][41];			//冲正流水
			}
	 	}
	  	else{
%>
	 	<script language="JavaScript">
<!--
	  		rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
	  	 	history.go(-1);
  	//-->
  		</script>
<%	 	}
	}
%>

<head>
<title>公务测试号转入冲正</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
onload=function()
{
	document.all.phoneNo.focus();
	self.status="";
}

function frmCfm()
{
	if(!checkElement(document.frm.phoneNo)) return;
	document.frm.iAddStr.value="";
	frm.submit();
}
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">业务信息</div>
</div>
<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
<input type="hidden" name="back_flag_code" value="">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="loginAccept" value="<%=paraStr[0]%>">
<table cellspacing="0">
    <tr>
        <td class="blue">手机号码</td>
        <td>
            <input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11  value="<%=iPhoneNo%>" readonly >
        </td>
        <td class="blue">机主姓名</td>
        <td>
            <input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
        </td>
    </tr>
    <tr>
    	<td class="blue">业务品牌</td>
        <td>
            <input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
        </td>
        <td class="blue">资费名称</td>
        <td>
            <input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">号码类型</td>
        <td>
            <input name="phoneType" type="text" class="InputGrey" id="phoneType" value="<%=phone_type%>" readonly>
        </td>
        <td class="blue">告警金额</td>
        <td>
            <input name="warningMoney" type="text" class="InputGrey" id="warningMoney" readonly value="<%=warning_money%>">
        </td>
    </tr>
    <tr>
        <td class="blue">话费限额</td>
        <td>
            <input name="limitMoney" type="text" class="InputGrey" id="limitMoney"  value="<%=limit_money%>" readonly>
        </td>
        <td class="blue">结束时间</td>
        <td>
            <input name="endTime" type="text" class="InputGrey" id="endTime"  value="<%=end_time%>" readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">省市标志</td>
        <td>
            <input name="typeCode" type="text" class="InputGrey" id="typeCode" value="<%=type_code%>" readonly>
        </td>
        <td class="blue">使用单位</td>
        <td colspan="3">
            <input name="useUnit" type="text" class="InputGrey" id="useUnit" value="<%=use_unit%>"  readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">使用部门</td>
        <td>
            <input name="useDepartment" type="text" class="InputGrey" id="useDepartment" value="<%=use_department%>" readonly>
        </td>
        <td class="blue">使用中心</td>
        <td colspan="3">
            <input name="useCenter" type="text" class="InputGrey" id="useCenter" value="<%=use_center%>"  readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">使用用途</td>
        <td>
            <input name="useApplication" type="text" class="InputGrey" id="useApplication" value="<%=use_application%>" readonly>
        </td>
        <td class="blue">级别</td>
        <td colspan="3">
            <input name="useLevel" type="text" class="InputGrey" id="useLevel" value="<%=use_level%>"  readonly>
        </td>
    </tr>
    <tr id="footer">
        <td colspan="4">
            <input name="commit" id="commit" type="button" class="b_foot"   value="确认" onClick="frmCfm();">
            <input class="b_foot" name="goback"  onClick="history.go(-1)" type=button value="返回">
            <input name="close" onClick="removeCurrentTab()" type="button" class="b_foot" value="关闭">
        </td>
    </tr>
</table>
<input type="hidden" name="iOpCode" value="4265">
<input type="hidden" name="loginNo" value="<%=loginNo%>">
<input type="hidden" name="orgCode" value="<%=orgCode%>">
<input type="hidden" name="oblack_code" value="<%=oBlackCode%>">
<input type="hidden" name="omodecode_sm" value="<%=oModeCodeSm%>">
<!--以下部分是为调f1270_3.jsp所定义的参数
        i2:客户ID
        i16:当前主套餐代码
        ip:申请主套餐代码
        belong_code:belong_code

        i1:手机号码
        i5:客户地址
        i6:证件类型
        i7:证件号码
        i8:业务品牌

        ipassword:密码
        do_note:用户备注
        favorcode:手续费优惠权限
        maincash_no:现主套餐代码（老）
        imain_stream:当前主资费开通流水
        next_main_stream:预约主资费开通流水

        i18:下月主套餐
        i19:手续费
        i20:最高手续费

        beforeOpCode:原业务办理的op_code
-->
<input type="hidden" name="i2" value="<%=cust_id%>">
<input type="hidden" name="i16"  value="<%=rate_code%>">
<input type="hidden" name="ip" 	value="<%=next_rate_code%>">

<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
<input type="hidden" name="iAddStr" value="">

<input type="hidden" name="i1" value="<%=iPhoneNo%>">
<input type="hidden" name="i4" value="<%=bp_name%>">
<input type="hidden" name="i5" value="<%=bp_add%>">
<input type="hidden" name="i6" value="<%=cardId_type%>">
<input type="hidden" name="i7" value="<%=cardId_no%>">
<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">

<input type="hidden" name="ipassword" value="">
<input type="hidden" name="do_note" value="<%=iPhoneNo%>公务测试号转入冲正">
<input type="hidden" name="favorcode" value="<%=favorcode%>">
<input type="hidden" name="maincash_no" value="<%=rate_code%>">
<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
<input type="hidden" name="i19" value="<%=hand_fee%>">
<input type="hidden" name="i20" value="<%=hand_fee%>">

<input type="hidden" name="beforeOpCode" value="4264">	
<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">	
<input type="hidden" name="return_page" value="/npage/bill/f4264_login.jsp">		
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
