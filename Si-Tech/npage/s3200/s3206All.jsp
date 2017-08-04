

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opCode = "3206";
  String opName = "VPMN集团查询";
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误

    String callData[][] = new String[][]{};
    String[] ParamsIn = null;

	String iQueryType = request.getParameter("busyType");
	String iOpCode = request.getParameter("Op_Code");
	String iWorkNo = request.getParameter("WorkNo");
	String iWorkName = request.getParameter("WorkName");
	String iNoPass = request.getParameter("NoPass");
	String iSystemNote = request.getParameter("TBackNote");
	String iOrgCode = request.getParameter("OrgCode");
	String iGrpId = request.getParameter("TGrpId");
    String iRegion_Code = iOrgCode.substring(0,2);

  %>
	<wtc:service name="s3206CfmEXC" routerKey="region" routerValue="<%=iRegion_Code%>"  retcode="error_code" retmsg="error_msg" outnum="3">
		<wtc:param value="<%=iWorkNo%>" />
		<wtc:param value="<%=iNoPass%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=iOrgCode%>" />
		<wtc:param value="<%=iQueryType%>" />
		<wtc:param value="<%=iGrpId%>" />		
		<wtc:param value="<%=iSystemNote%>" />		
	</wtc:service>
	<wtc:array id="result_t" start="0" length="1" scope="end" />		  
  <%
	System.out.println("# error_code = "+error_code);
	System.out.println("# error_msg  = "+error_msg );
    if( !error_code.equals("000000")){
        valid = 2;
    }else{
        if(result_t.length==0){
            valid = 1;
        }else{
            valid = 0;
            callData = result_t;
        }
    }

 if( valid == 1){%>
<script language="JavaScript">

	rdShowMessageDialog("没有相关的查询数据!!");
	history.go(-1);
</script>

<%}else if ( valid == 2 ) {
%>
<script language="JavaScript">
	rdShowMessageDialog("错误代码：<%=error_code%><br>错误信息：<%=error_msg%>",0);
	history.go(-1);
</script>
<%
}
else{%>
<html>
<head>
<title>集团查询－集团全部信息查询</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

</head>

<BODY>
<FORM action="" method="post" name="form">
<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">查询方式：集团全部信息查询</div>
	</div>		  
        <table cellspacing="0" >
          <tr > 
            <td class="blue">集团号</td>
            <td > 
              <input name="grpId" type="text" class="InputGrey" readonly  id="grpId" value="<%=callData[0][0]%>">
            </td>
            <td class="blue">集团名称</td>
            <td > 
              <input name="grpName" type="text" class="InputGrey"  readonly id="grpName" value="<%=callData[2][0]%>">
            </td>
          </tr>
          <tr > 
            <td class="blue">省区号</td>
            <td  > 
              <input name="province" type="text" class="InputGrey"  readonly id="province" value="<%=callData[3][0]%>">
            </td>
            <td class="blue">业务区号</td>
            <td > 
              <input name="servArea" type="text" class="InputGrey"  readonly id="servArea" value="<%=callData[4][0]%>">
            </td>
          </tr>
          <tr > 
            <td class="blue">SCP号</td>
            <td  > 
              <input name="scpId" type="text" class="InputGrey"  readonly id="scpId" value="<%=callData[5][0]%>">
            </td>
            <td class="blue">集团类型</td>
            <td > 
              <input name="grpType" type="text" class="InputGrey"  readonly id="grpType" 
               value="<% 
            	if(callData[6][0].equals("0")) out.println("本地集团");
            	else if(callData[6][0].equals("1")) out.println("全省集团");
            	else if(callData[6][0].equals("1")) out.println("全国集团");  
            	else out.println("本地化省级集团");         	
             	%>">
            </td>
          </tr>
          <tr > 
            <td class="blue">联系人姓名</td>
            <td  > 
              <input name="contact" type="text" class="InputGrey"  readonly id="contact" value="<%=callData[7][0]%>">
            </td>
            <td class="blue">集团联系电话</td>
            <td > 
              <input name="telePhone" type="text" class="InputGrey"  readonly id="telePhone" value="<%=callData[9][0]%>">
            </td>
          </tr>
          <tr > 
            <td  class="blue">集团联系地址</td>
            <td  colspan="3"> 
              <input name="address" type="text" class="InputGrey"  readonly id="address" value="<%=callData[8][0]%>" size="60">
            </td>
          </tr>
          <tr > 
            <td class="blue">开户时间</td>
            <td  > 
              <input name="creDate" type="text" class="InputGrey"  readonly id="creDate" value="<%=callData[10][0]%>">
            </td>
            <td class="blue">激活/去激活日期</td>
            <td > 
              <input name="actDate" type="text" class="InputGrey"  readonly id="actDate" value="<%=callData[11][0]%>">
            </td>
          </tr>
          <tr > 
            <td class="blue">业务起始日期</td>
            <td  > 
              <input name="srvStart" type="text" class="InputGrey"  readonly id="srvStart" value="<%=callData[12][0]%>">
            </td>
            <td class="blue">业务结束日期</td>
            <td > 
              <input name="srvStop" type="text" class="InputGrey"  readonly id="srvStop" value="<%=callData[13][0]%>">
            </td>
          </tr>
          <tr > 
            <td class="blue">业务激活标志</td>
            <td  > 
              <input name="subState" type="text" class="InputGrey" id="subState"  readonly 
               value="<% 
            	if(callData[14][0].equals("0")) out.println("未激活");
            	else if(callData[14][0].equals("1")) out.println("激活");  
            	else out.println("集团不可用");         	
             	%>">
            </td>
            <td class="blue">&nbsp;</td>
            <td >&nbsp;</td>
          </tr>
          <tr > 
            <td nowrap class="blue">网内费率索引</td>
            <td > 
              <input name="INTERFEE" type="text" class="InputGrey" id="INTERFEE"  readonly value="<%=callData[16][0]%>">
            </td>
            <td class="blue">网外费率索引</td>
            <td > 
              <input name="OUTFEE" type="text" class="InputGrey" id="OUTFEE"  readonly value="<%=callData[17][0]%>">
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">网外号码组费率索引</td>
            <td > 
              <input name="OUTGRPFEE" type="text" class="InputGrey" id="OUTGRPFEE"  readonly value="<%=callData[18][0]%>">
            </td>
            <td class="blue">非优惠费率索引</td>
            <td > 
              <input name="NORMALFEE" type="text" class="InputGrey" id="NORMALFEE"  readonly value="<%=callData[19][0]%>">
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">集团管理流程的接入码</td>
            <td > 
              <input name="admNo" type="text" class="InputGrey" id="admNo" readonly  value="<%=callData[23][0]%>">
            </td>
            <td class="blue">呼叫话务员转接号码</td>
            <td > 
              <input name="transNo" type="text" class="InputGrey" id="transNo2"  readonly value="<%=callData[24][0]%>">
            </td>
          </tr>
          <tr > 
            <td height="19" nowrap class="blue">主叫号码显示方式</td>
            <td > 
              <input name="display" type="text" class="InputGrey" id="display"  readonly 
          value="<% 
            	if(callData[25][0].equals("0")) out.println("使用个人标志");
            	else if(callData[25][0].equals("1")) out.println("显示短号");
            	else if(callData[25][0].equals("2")) out.println("显示真实号码");
            	else if(callData[25][0].equals("3")) out.println("PBX主叫显示真实号码");
            	else out.println("主叫显示短号");
             	%>">
            </td>
            <td class="blue">&nbsp;</td>
            <td >&nbsp;</td>
          </tr>
          <tr > 
            <td nowrap class="blue">最大闭合用户群数</td>
            <td > 
              <input name="MAXCLNUM" type="text" class="InputGrey" id="MAXCLNUM"  readonly value="<%=callData[26][0]%>">
            </td>
            <td class="blue">当前闭合用户群数</td>
            <td > 
              <input name="CURCLNUM" type="text" class="InputGrey" id="CURCLNUM" readonly  value="<%=callData[27][0]%>">
            </td>
          </tr>
          <tr > 
            <td class="blue" >单个闭合用户群能包含的最大用户数</td>
            <td > 
              <input name="MAXNUMCL" type="text" class="InputGrey" id="MAXNUMCL"  readonly value="<%=callData[28][0]%>">
            </td>
            <td class="blue">单个用户最大可加入的闭合群数</td>
            <td > 
              <input name="PMAXCLOSE" type="text" class="InputGrey" id="PMAXCLOSE"  readonly value="<%=callData[29][0]%>" >
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">最大网外号码总数</td>
            <td > 
              <input name="MAXOUTNUM " type="text" class="InputGrey" id="MAXOUTNUM"  readonly value="<%=callData[30][0]%>">
            </td>
            <td class="blue">当前集团网外号码数</td>
            <td > 
              <input name="CUROUTNUM " type="text" class="InputGrey" id="CUROUTNUM"  readonly value="<%=callData[31][0]%>">
            </td>
          </tr>
          <tr > 
            <td  class="blue">当前集团成员网外号码数</td>
            <td > 
              <input name="CURPOUTNUM " type="text" class="InputGrey" id="CURPOUTNUM" readonly  value="<%=callData[32][0]%>">
            </td>
            <td class="blue">最大用户数</td>
            <td > 
              <input name="MAXUSERS" type="text" class="InputGrey" id="MAXUSERS"  readonly value="<%=callData[33][0]%>">
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">当前用户数</td>
            <td > 
              <input name="CURUSERS" type="text" class="InputGrey" id="CURUSERS"  readonly value="<%=callData[34][0]%>">
            </td>
            <td class="blue">&nbsp;</td>
            <td >&nbsp;</td>
          </tr>
          <tr > 
            <td nowrap class="blue">资费套餐类型</td>
            <td > 
              <input name="PKGTYPE" type="text" class="InputGrey" id="PKGTYPE"  readonly 
          value="<% 
            	if(callData[35][0].equals("0")) out.println("没有套餐");
            	else out.println("有套餐");
             	%>">
            </td>
            <td class="blue">资费套餐名称</td>
            <td > 
              <input name="PKGNAME" type="text" class="InputGrey" id="PKGNAME"  readonly value="<%=callData[36][0]%>">
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">总折扣</td>
            <td > 
              <input name="DISCOUNT" type="text" class="InputGrey" id="DISCOUNT"  readonly value="<%=callData[37][0]%>">
            </td>
            <td class="blue">集团月费用限额</td>
            <td > 
              <input name="textfield2411" type="text" class="InputGrey"  readonly value="<%=callData[38][0]%>">
            </td>
          </tr>
          <tr > 
            <td nowrap class="blue">集团综合v网资费</td>
            <td colspan="3"> 
              <input name="offer" type="text" class="InputGrey"  readonly id="offer" value="<%=callData[96][0]%>">
            </td>
          </tr>
          <tr> 
            <td colspan="4" >&nbsp;</td>
          </tr>
        </table>
        <div class="title">
			<div id="title_zi">功能选项集</div>
		</div>		

             <table cellspacing=1 >
                <tr > 
                  <td class="blue">网内去话</td>
                  <td > 
                    <input name="textfield15" type="text" class="InputGrey"  readonly 
            value="<% 
            	if(callData[15][0].substring(0,1).equals("0")) out.println("禁止");
            	else if(callData[15][0].substring(0,1).equals("1")) out.println("市话");
            	else if(callData[15][0].substring(0,1).equals("2")) out.println("市话+省内");
            	else if(callData[15][0].substring(0,1).equals("3")) out.println("市话+省内+省外");
            	else if(callData[15][0].substring(0,1).equals("4")) out.println("市话+省内+省外+国际");
            	%>">
                  </td>
                  <td class="blue">网内来话</td>
                  <td> 
                    <input name="textfield16" type="text" class="InputGrey"  readonly 
            value="<% 
            	if(callData[15][0].substring(1,2).equals("0")) out.println("禁止");
            	else if(callData[15][0].substring(1,2).equals("1")) out.println("市话");
            	else if(callData[15][0].substring(1,2).equals("2")) out.println("市话+省内");
            	else if(callData[15][0].substring(1,2).equals("3")) out.println("市话+省内+省外");
            	else if(callData[15][0].substring(1,2).equals("4")) out.println("市话+省内+省外+国际");
            	%>">
                  </td>
                  <td class="blue">网间去话</td>
                  <td> 
                    <input name="textfield17" type="text" class="InputGrey"  readonly 
            value="<% 
            	if(callData[15][0].substring(2,3).equals("0")) out.println("禁止");
            	else if(callData[15][0].substring(2,3).equals("1")) out.println("市话");
            	else if(callData[15][0].substring(2,3).equals("2")) out.println("市话+省内");
            	else if(callData[15][0].substring(2,3).equals("3")) out.println("市话+省内+省外");
            	else if(callData[15][0].substring(2,3).equals("4")) out.println("市话+省内+省外+国际");
            	%>">
                  </td>
                </tr>
                <tr > 
                  <td class="blue">网间来话</td>
                  <td > 
                    <input name="textfield152" type="text" class="InputGrey"  readonly 
            value="<% 
            	if(callData[15][0].substring(3,4).equals("0")) out.println("禁止");
            	else if(callData[15][0].substring(3,4).equals("1")) out.println("市话");
            	else if(callData[15][0].substring(3,4).equals("2")) out.println("市话+省内");
            	else if(callData[15][0].substring(3,4).equals("3")) out.println("市话+省内+省外");
            	else if(callData[15][0].substring(3,4).equals("4")) out.println("市话+省内+省外+国际");
            	%>">
                  </td>
                  <td class="blue">网外去话</td>
                  <td> 
                    <input name="textfield1514" type="text" class="InputGrey"  readonly 
            value="<% 
            	if(callData[15][0].substring(4,5).equals("0")) out.println("禁止");
            	else if(callData[15][0].substring(4,5).equals("1")) out.println("市话");
            	else if(callData[15][0].substring(4,5).equals("2")) out.println("市话+省内");
            	else if(callData[15][0].substring(4,5).equals("3")) out.println("市话+省内+省外");
            	else if(callData[15][0].substring(4,5).equals("4")) out.println("市话+省内+省外+国际");
            	%>">
                  </td>
                  <td class="blue">网外来话</td>
                  <td> 
                    <input name="textfield1515" type="text" class="InputGrey"  readonly 
            value="<% 
            	if(callData[15][0].substring(5,6).equals("0")) out.println("禁止");
            	else if(callData[15][0].substring(5,6).equals("1")) out.println("市话");
            	else if(callData[15][0].substring(5,6).equals("2")) out.println("市话+省内");
            	else if(callData[15][0].substring(5,6).equals("3")) out.println("市话+省内+省外");
            	else if(callData[15][0].substring(5,6).equals("4")) out.println("市话+省内+省外+国际");
            	%>">
                  </td>
                </tr>
                <tr > 
                  <td class="blue">网外号码组去话</td>
                  <td > 
                    <input name="textfield153" type="text" class="InputGrey"  readonly 
            value="<% 
            	if(callData[15][0].substring(6,7).equals("0")) out.println("禁止");
            	else if(callData[15][0].substring(6,7).equals("1")) out.println("市话");
            	else if(callData[15][0].substring(6,7).equals("2")) out.println("市话+省内");
            	else if(callData[15][0].substring(6,7).equals("3")) out.println("市话+省内+省外");
            	else if(callData[15][0].substring(6,7).equals("4")) out.println("市话+省内+省外+国际");
            	%>">
                  </td>
                  <td class="blue">网外号码组来话</td>
                  <td > 
                    <input name="textfield1513" type="text" class="InputGrey"  readonly 
             value="<% 
            	if(callData[15][0].substring(7,8).equals("0")) out.println("禁止");
            	else if(callData[15][0].substring(7,8).equals("1")) out.println("市话");
            	else if(callData[15][0].substring(7,8).equals("2")) out.println("市话+省内");
            	else if(callData[15][0].substring(7,8).equals("3")) out.println("市话+省内+省外");
            	else if(callData[15][0].substring(7,8).equals("4")) out.println("市话+省内+省外+国际");
            	%>">
                  </td>
                  <td class="blue">主叫漫游权限</td>
                  <td> 
                    <input name="textfield1516" type="text" class="InputGrey"  readonly 
            value="<% 
            	if(callData[15][0].substring(8,9).equals("0")) out.println("禁止");
            	else if(callData[15][0].substring(8,9).equals("1")) out.println("省内");
            	else if(callData[15][0].substring(8,9).equals("2")) out.println("省内+省外");
             	%>">
                  </td>
                </tr>
                <tr > 
                  <td class="blue">被叫漫游权限</td>
                  <td> 
                    <input name="textfield154" type="text" class="InputGrey"  readonly 
             value="<% 
            	if(callData[15][0].substring(9,10).equals("0")) out.println("禁止");
            	else if(callData[15][0].substring(9,10).equals("1")) out.println("省内");
            	else if(callData[15][0].substring(9,10).equals("2")) out.println("省内+省外");
             	%>">
                  </td>
                  <td class="blue">集团话务员</td>
                  <td> 
                    <input name="textfield1512" type="text" class="InputGrey"  readonly 
             value="<% 
            	if(callData[15][0].substring(10,11).equals("0")) out.println("不提供");
            	else if(callData[15][0].substring(10,11).equals("1")) out.println("提供");
            	else if(callData[15][0].substring(10,11).equals("2")) out.println("提供但话务员不能作主叫");
             	%>">
                  </td>
                  <td class="blue">呼叫前转</td>
                  <td > 
                    <input name="textfield1517" type="text" class="InputGrey"  readonly 
             value="<% 
            	if(callData[15][0].substring(11,12).equals("0")) out.println("不提供");
            	else if(callData[15][0].substring(11,12).equals("1")) out.println("提供");
             	%>">
                  </td>
                </tr>
                <tr > 
                  <td class="blue">闭合用户群功能</td>
                  <td > 
                    <input name="textfield155" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(12,13).equals("0")) out.println("不提供");
            	else if(callData[15][0].substring(12,13).equals("1")) out.println("提供优惠群");
            	else if(callData[15][0].substring(12,13).equals("2")) out.println("提供闭合优惠群");
             	%>">
                  </td>
                  <td class="blue">二次折扣</td>
                  <td > 
                    <input name="textfield1511" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(13,14).equals("0")) out.println("不提供");
            	else if(callData[15][0].substring(13,14).equals("1")) out.println("提供");
             	%>">
                  </td>
                  <td class="blue">借机发话</td>
                  <td class="button1"> 
                    <input name="textfield1518" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(14,15).equals("0")) out.println("不提供");
            	else if(callData[15][0].substring(14,15).equals("1")) out.println("提供");
             	%>">
                  </td>
                </tr>
                <tr > 
                  <td nowrap class="blue">群组短消息服务</td>
                  <td > 
                    <input name="textfield156" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(15,16).equals("0")) out.println("不提供");
            	else if(callData[15][0].substring(15,16).equals("1")) out.println("提供");
             	%>">
                  </td>
                  <td colspan="3" class="blue">通过管理流程拨打话务员对主叫是否收费</td>
                  <td > 
                    <input name="textfield1519" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(16,17).equals("0")) out.println("不收费");
            	else if(callData[15][0].substring(16,17).equals("1")) out.println("收费");
             	%>">
                  </td>
                </tr>
                <tr > 
                  <td  nowrap class="blue">成员是否能直接呼叫话务员</td>
                  <td class="button1"> 
                    <input name="textfield157" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(17,18).equals("0")) out.println("不能");
            	else if(callData[15][0].substring(17,18).equals("1")) out.println("能");
             	%>">
                  </td>
                  <td  nowrap class="blue">话务员网内来话是否收费</td>
                  <td> 
                    <input name="textfield1510" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(18,19).equals("0")) out.println("不收费");
            	else if(callData[15][0].substring(18,19).equals("1")) out.println("收费");
             	%>">
                  </td>
                  <td nowrap class="blue">拨打话务员是否转接运营商客服中心</td>
                  <td class="button1"> 
                    <input name="textfield1520" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(19,20).equals("0")) out.println("不转接");
            	else if(callData[15][0].substring(19,20).equals("1")) out.println("转接");
             	%>">
                  </td>
                </tr>
                <tr > 
                  <td nowrap class="blue">资费套餐功能</td>
                  <td class="button1"> 
                    <input name="textfield158" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(20,21).equals("0")) out.println("不提供");
            	else if(callData[15][0].substring(20,21).equals("1")) out.println("提供");
             	%>">
                  </td>
                  <td  class="blue">网外号码组功能</td>
                  <td class="button1"> 
                    <input name="textfield159" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(21,22).equals("0")) out.println("不提供");
            	else if(callData[15][0].substring(21,22).equals("1")) out.println("提供");
             	%>">
                  </td>
                  <td class="blue">个人付费呼叫是否有优惠</td>
                  <td class="button1"> 
                    <input name="textfield1521" type="text" class="InputGrey"  readonly 
              value="<% 
            	if(callData[15][0].substring(22,23).equals("0")) out.println("无优惠");
            	else if(callData[15][0].substring(22,23).equals("1")) out.println("有优惠");
             	%>">
                  </td>
                </tr>
              </table>

         <table  cellspacing=0>
          <tr > 
            <td class="blue" >集团号</td>      
            <td> 
              <input name="grpId" type="text" class="InputGrey" id="grpId"  readonly value="<%=callData[0][0]%>"></td>
            <td class="blue">结算日期</td>      
            <td> 
              <input name="MONTHNOW" type="text" class="InputGrey" id="MONTHNOW"  readonly value="<%=callData[55][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">集团总费用</td>      
            <td> 
              <input name="TOTALFEE" type="text" class="InputGrey" id="TOTALFEE" readonly  value="<%=callData[56][0]%>"></td>
            <td class="blue">集团欠费总额</td>      
            <td> 
              <input name="OVERDUE" type="text" class="InputGrey" id="OVERDUE"  readonly value="<%=callData[57][0]%>"></td>
    </tr>
          <tr > 
            <td height="16"  class="blue">集团网内呼叫总费用</td>      
            <td> 
              <input name="FEE1" type="text" class="InputGrey" id="FEE1"  readonly value="<%=callData[58][0]%>"></td>
            <td class="blue">网内呼叫次数</td>      
            <td> 
              <input name="TIME1" type="text" class="InputGrey" id="TIME1"  readonly value="<%=callData[59][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">集团网外呼叫总费用</td>      
            <td> 
              <input name="FEE2" type="text" class="InputGrey" id="FEE2"  readonly value="<%=callData[60][0]%>"></td>
            <td class="blue">网外呼叫次数</td>      
            <td> 
              <input name="TIME2" type="text" class="InputGrey" id="TIME2"  readonly value="<%=callData[61][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">集团网外号码组呼叫总费用</td>
            <td> 
              <input name="FEE3" type="text" class="InputGrey" id="FEE3"  readonly value="<%=callData[62][0]%>"></td>
            <td class="blue">网外号码组呼叫次数</td>      
            <td> 
              <input name="TIME3" type="text" class="InputGrey" id="TIME3"  readonly value="<%=callData[63][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">集团网间呼叫总费用</td>      
            <td> 
              <input name="FEE4" type="text" class="InputGrey"  readonly value="<%=callData[64][0]%>"></td>
            <td class="blue">网间呼叫次数</td>      
            <td> 
              <input name="TIME4" type="text" class="InputGrey" readonly  value="<%=callData[65][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">集团网外呼叫市话费</td>      
            <td> 
              <input name="FEE5" type="text" class="InputGrey"  readonly value="<%=callData[66][0]%>"></td>
            <td class="blue">网外市话呼叫次数</td>      
            <td> 
              <input name="TIME5" type="text" class="InputGrey"  readonly value="<%=callData[67][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">集团网外呼叫省内长途费</td>
            <td> 
              <input name="FEE6" type="text" class="InputGrey"  readonly value="<%=callData[68][0]%>"></td>
            <td class="blue">网外省内长途呼叫次数</td>
            <td> 
              <input name="TIME6" type="text" class="InputGrey" readonly  value="<%=callData[69][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">集团网外呼叫省外长途费</td>
            <td> 
              <input name="FEE7" type="text" class="InputGrey"  readonly value="<%=callData[70][0]%>"></td>
            <td class="blue">网外省外长途呼叫次数</td>
            <td> 
              <input name="TIME7" type="text" class="InputGrey"  readonly value="<%=callData[71][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">集团网外呼叫国际长途费</td>
            <td> 
              <input name="FEE8" type="text" class="InputGrey"  readonly value="<%=callData[72][0]%>"></td>
            <td class="blue">网外国际长途呼叫次数</td>
            <td> 
              <input name="TIME8" type="text" class="InputGrey" readonly  value="<%=callData[73][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">网内呼叫总时长</td>      
            <td> 
              <input name="DURAT1" type="text" class="InputGrey"  readonly id="DURAT1" value="<%=callData[74][0]%>"></td>
            <td class="blue">网外市话呼叫时长</td>      
            <td> 
              <input name="DURAT2" type="text" class="InputGrey" readonly  id="DURAT2" value="<%=callData[75][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">网外长途呼叫时长</td>      
            <td> 
              <input name="DURAT3" type="text" class="InputGrey" readonly  value="<%=callData[76][0]%>"></td>
            <td class="blue">网外号码组呼叫总时长</td>
            <td> 
              <input name="DURAT4" type="text" class="InputGrey"  readonly value="<%=callData[77][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">网间呼叫总时长</td>      
            <td> 
              <input name="DURAT5" type="text" class="InputGrey"  readonly value="<%=callData[78][0]%>"></td>
            <td class="blue">个人付费总费用</td>      
            <td> 
              <input name="PTOTALFEE" type="text" class="InputGrey"  readonly value="<%=callData[79][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">个人付费欠费总额</td>      
            <td> 
              <input name="POVERDUE" type="text" class="InputGrey"  readonly value="<%=callData[80][0]%>"></td>
            <td class="blue">个人付费网内呼叫总费用</td>      
            <td> 
              <input name="PFEE1" type="text" class="InputGrey"  readonly value="<%=callData[81][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">个人付费网外呼叫总费用</td>      
            <td> 
              <input name="PFEE2" type="text" class="InputGrey"  readonly value="<%=callData[82][0]%>"></td>
            <td class="blue">个人付费网外呼叫总费用</td>      
            <td> 
              <input name="PFEE3" type="text" class="InputGrey"  readonly value="<%=callData[83][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">个人付费网间呼叫总费用</td>      
            <td> 
              <input name="PFEE4" type="text" class="InputGrey"  readonly value="<%=callData[84][0]%>"></td>
            <td class="blue">资费套餐生效日期</td>      
            <td> 
              <input name="PKGDAY" type="text" class="InputGrey"  readonly value="<%=callData[85][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">最后一次交月租日期</td>      
            <td> 
              <input name="PAYDAY" type="text" class="InputGrey"  readonly value="<%=callData[86][0]%>"></td>
            <td class="blue">&nbsp;</td>
            <td width="24%">&nbsp;</td>
    </tr>
          <tr > 
            <td  class="blue">基本月租剩余免费时间1</td>      
            <td> 
              <input name="RENTTIME1" type="text" class="InputGrey" readonly  value="<%=callData[87][0]%>"></td>
            <td class="blue">基本月租剩余免费时间2</td>      
            <td> 
              <input name="RENTTIME2" type="text" class="InputGrey"  readonly value="<%=callData[88][0]%>"></td>
    </tr>
          <tr > 
            <td  class="blue">基本月租剩余免费金额1</td>      
            <td> 
              <input name="RENTFEE1" type="text" class="InputGrey"  readonly value="<%=callData[89][0]%>"></td>
            <td class="blue">基本月租剩余免费金额2</td>      
            <td> 
              <input name="RENTFEE2" type="text" class="InputGrey" readonly  value="<%=callData[90][0]%>"></td>
    </tr>
   </table>
        <TABLE cellSpacing="0">
          <TR > 
            <TD noWrap  colspan="6" id="footer"> 
                <input type="button" name="return" class="b_foot" value="返回" onclick="history.go(-1)">
                <input type="button" name="return" class="b_foot" value="关闭" onClick="removeCurrentTab()">
            </TD>
          </TR>
        </TABLE>
			<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html>
<%}%>
