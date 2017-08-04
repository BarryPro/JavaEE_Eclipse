<%
/********************
 version v1.0
开发商: si-tech
update: sunaj@2010-03-23
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>

<%
	String opCode=request.getParameter("opcode");
	String opName="赠送预存款方案详细信息";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String RegionName="",PayFee="",BaseFee="",BaseTerm="",FreeFee="",FreeTerm="";
	String ReturnFee="",ReturnTerm="",MonthBaseFee="",MonthConsume="",ConsumeMark="";
	String BeginTime="",EndTime="",AwardCode="",GiftCode="",retFlag="",ReturnDate="";
	String FileName="",FileNo="",AuditName="",AuditPhone ="",ReturnPayType="";
	String ReturnActionCode="";  //huangrong 增加 经分活动编码的定义
	String ActionNote="";  //huangrong 增加 备注信息的定义 2010-10-21 13:54
	String channelName=""; //huangrong 增加 渠道名称的定义 2011-8-30
	String examineSituation = request.getParameter("examineSituation"); //diling add 审批情况@2011/10/26 
	String projectcode = request.getParameter("projectcode"); //diling add 活动代码@2011/10/26 
	String projecttype = request.getParameter("projecttype"); //diling add 活动类型@2011/10/26 
	String innetTime = "";
	String typeOfBaseFeeValue = "";//diling add 底线预存类型@2012/2/3 
	String typeOfFreeFeeValue = "";//diling add 活动预存类型@2012/2/3 
	
	String paraAray[] = new String[11];
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = "01";
    paraAray[2] = request.getParameter("opcode");
	paraAray[3] = work_no;
    paraAray[4] = password;
    paraAray[5] = "";
	paraAray[6] = "";
    paraAray[7] = request.getParameter("projectcode");
    paraAray[8] = request.getParameter("projecttype");
    paraAray[9] = regionCode;
    paraAray[10] = request.getParameter("RegionCode");
    
    System.out.println("-----------8377---------regionCode="+regionCode);
    System.out.println("-----------8377---------RegionCode="+request.getParameter("RegionCode"));
%>
	<wtc:service name="s8377Detail" routerKey="region" routerValue="<%=regionCode%>" outnum="35" retcode="retCode" retmsg="retMsg">  <!--huangrong 将出参个数由26改为27个 update 出参由28改为29--><!--diling 将出参由33改为35-->
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
	<wtc:array id="tempArr1" start="23" length="3" scope="end"/>
	<wtc:array id="tempArr2" start="28" length="1" scope="end"/>	
	<wtc:array id="tempArr3" start="29" length="1" scope="end"/>	
	<wtc:array id="tempArr4" start="30" length="3" scope="end"/>	
	
<%
	String errCode = retCode;
	String errMsg  = retMsg;
 if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s8377Detail查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else 
  {
	  if (errCode.equals( "000000") && tempArr.length>0)
	  {
	  	if(!(tempArr==null))
	  	{
		    RegionName = tempArr[0][2];         //区域名称
		    PayFee = tempArr[0][3];             //现金
		    BaseFee = tempArr[0][4];            //底线
		    BaseTerm = tempArr[0][5];           //底线期限
		    FreeFee = tempArr[0][6];            //活动
		    FreeTerm = tempArr[0][7];     	    //活动期限
		    ReturnFee = tempArr[0][8];     	    //赠送预存
		    ReturnTerm = tempArr[0][9];    		//赠送预存期限
		    MonthBaseFee = tempArr[0][10];       //每月最低消费
		    MonthConsume = tempArr[0][11];		//每月最少贡献值
		    ConsumeMark = tempArr[0][12];		//消费积分
		    BeginTime = tempArr[0][13];		    //开始时间
		    EndTime = tempArr[0][14];		    //结束时间
		    AwardCode=tempArr[0][15];	
			GiftCode=tempArr[0][16];
		    FileName = tempArr[0][17];		    //文件名
		    FileNo = tempArr[0][18];		    //文件号
		    AuditName = tempArr[0][19];		    //申请人姓名
		    AuditPhone = tempArr[0][20];		//申请人电话
		    ReturnPayType=tempArr[0][21];       //赠送预存款专款类型
		    ReturnDate=tempArr[0][22];			//赠送预存款返回日期
		    ReturnActionCode=tempArr[0][26];			//经分活动编码  huangrong 增加 对经分活动编码值的获取
		    ActionNote=tempArr[0][27];			//经分活动编码  huangrong 增加 备注信息值的获取 2010-10-21 13:55
		    innetTime=tempArr3[0][0];
		    typeOfBaseFeeValue=tempArr[0][33];  //diling add 底线预存类型@2012/2/3 16:29:41
		    typeOfFreeFeeValue=tempArr[0][34];  //diling add 活动预存类型@2012/2/3 16:29:41
		    System.out.println("=====8377=========tempArr[0][33]="+tempArr[0][33]);
		    System.out.println("=====8377=========tempArr[0][34]="+tempArr[0][34]);
	 	}
	 	if (tempArr2.length > 0) {
		 	for(int i=0;i<tempArr2.length;i++)
			{
				if(channelName=="")
				{
					channelName=tempArr2[i][0];
				}else{
					channelName=channelName+"，"+tempArr2[i][0];			
				}
			}
	 	} else {
	 		channelName = "无";
	 	}
	}else{%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
				history.go(-1);
			</script>
      <%}
    }
%>

<html>
<head>
	<title>赠送预存款方案详细信息</title>
<script language="JavaScript">

function printCommit()
{
	if("<%=opCode%>"=="8377")
	{
		frm.action="f8375_login.jsp";
		frm.submit();
	}else if("<%=opCode%>"=="8378")
	{
		frm.action="f8378_1.jsp";
		frm.submit();
	}
}

function go()
{
	if("<%=opCode%>"=="8377")
	{
		frm.action="f8377_Qry.jsp";
		frm.submit();
	}else if("<%=opCode%>"=="8378")
	{
		frm.action="f8378_1.jsp";
		frm.submit();
	}
	
}
onload=function()
{
	if("<%=opCode%>"=="8377")
	{
		table_2.style.display="";
		
	}else if("<%=opCode%>"=="8378")
	{
		table_2.style.display="none";
	}
}

//diling add@2011/10/26 增加修改提交按钮
function updateSubmit(){
    if(check(frm)!=true) return false;
    var stop_time = $("#stop_time").val();
    if(stop_time==""||stop_time==null){
        rdShowMessageDialog("营销结束时间为空！请重新输入！",0);
	    return false;
    }
    $("#projectcode").val("<%=projectcode%>");
    $("#projecttype").val("<%=projecttype%>");
    $("#regionCode").val("<%=regionCode%>");
    frm.action="f8377_updateSubInfo.jsp";
	frm.submit();
}

</script>
<%/*begin huangrong 添加对多行文本框的背景样式 2010-10-21 13:57*/%>
<style>
.TextAreaGrey{
	background-color: #EEF2F7;
	border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 0px;
	border-left-width: 0px;
	text-indent: 2px;
}		
</style>
<%/*end huangrong 添加对多行文本框的背景样式 2010-10-21 13:57*/%>
</head>
<body>
<form name="frm" method="post" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">基本信息</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="10%">区域名称</td>
            <td width="20%">
					<input name="region_name" type="text"  id="region_name" value="<%=RegionName%>" class="InputGrey" readonly maxlength="30" >
            </td>
            <td class="blue" width="10%">省公司审批文件名</td>
            <td width="20%">
					<input name="file_name" type="text"  id="file_name" value="<%=FileName%>" class="InputGrey" readonly maxlength="30" >
            </td>
            <td class="blue" width="10%">省公司审批文件号</td>
            <td width="30%">
					<input name="file_no" type="text" id="file_no" value="<%=FileNo%>" class="InputGrey" readonly maxlength="30" >
            </td>
		</tr>
		<tr>
            <td class="blue">申请人姓名</td>
            <td>
						  <input name="audit_name"  type="text" id="audit_name" value="<%=AuditName%>" class="InputGrey" readonly>
            </td>
            <td class="blue">申请人电话</td>
            <td colspan='3'>
						  <input name="audit_phone" type="text" id="audit_phone" value="<%=AuditPhone%>" class="InputGrey" readonly>
            </td>
            
        </tr>
		<tr>
			<!--begin add 增加展示底线预存类型内容 by diling@2012/2/3 13:57:57 --> 
						<td class="blue">底线预存类型</td>
            <td>
						  <input name="BaseFeeType" type="text" id="BaseFeeType" value="<%=typeOfBaseFeeValue%>" class="InputGrey" readonly>
            </td>
      <!--end add by diling -->
						<td class="blue">底线预存款</td>
            <td>
						  <input name="base_fee" type="text" id="base_fee" value="<%=BaseFee%>" class="InputGrey" readonly>
            </td>
            <td class="blue">底线预存消费期限</td>
            <td>
						  <input name="base_term" type="text" id="base_term"  value="<%=BaseTerm%>" class="InputGrey" readonly>
            </td>
           
     	</tr>
     	<tr>
     		<!--begin add 增加展示活动预存类型内容 by diling@2012/2/3 13:57:57 --> 
     			<td class="blue">活动预存类型</td>
          <td>
					  <input name="FreeFeeType" type="text" id="FreeFeeType" value="<%=typeOfFreeFeeValue%>" class="InputGrey" readonly>
          </td>
        <!--end add by diling -->
     		 <td class="blue">活动预存款</td>
            <td>
						  <input name="free_fee" type="text" id="free_fee" value="<%=FreeFee%>" class="InputGrey" readonly>
            </td>
            <td class="blue">活动预存消费期限</td>
            <td>
						  <input name="free_term" type="text" id="free_term" value="<%=FreeTerm%>" class="InputGrey" readonly>
            </td>
     	</tr>
		<tr>
			 <td class="blue">每月赠送预存款</td>
            <td>
						  <input name="return_fee" type="text" id="return_fee" value="<%=ReturnFee%>" class="InputGrey" readonly>
            </td>
             <td class="blue">赠送预存款月数</td>
            <td>
						  <input name="return_term" type="text" id="return_term" value="<%=ReturnTerm%>" class="InputGrey" readonly>
            </td>
				<td class="blue">赠送预存款专款类型</td>
            <td>
						  <input name="return_paytype" type="text" id="return_paytype" value="<%=ReturnPayType%>" class="InputGrey" readonly>
            </td>
        </tr>
		<tr>
			<td class="blue">赠送预存款返款日期</td>
            <td>
						  <input name="return_date" type="text" id="return_date"  value="<%=ReturnDate%>" class="InputGrey" readonly>
            </td>
            <td class="blue">现金</td>
            <td>
						  <input name="pay_fee" type="text" id="pay_fee"  value="<%=PayFee%>" class="InputGrey" readonly>
            </td>
            <td class="blue">消费积分</td>
            <td>
						  <input name="consume_mark"  type="text" type="text" id="consume_mark" value="<%=ConsumeMark%>" class="InputGrey" readonly>
            </td>
        </tr>
		<tr>
            <td class="blue">每月最低消费</td>
            <td>
						  <input name="month_basefee" type="text" id="month_basefee" value="<%=MonthBaseFee%>" class="InputGrey" readonly>
            </td>
            <td class="blue">每月最少贡献值</td>
            <td>
						  <input name="month_consume" type="text" id="month_consume" value="<%=MonthConsume%>" class="InputGrey" readonly>
            </td>
      	
			<td class="blue">营销开始时间</td> 
            <td>
						  <input name="begin_time" type="text" id="begin_time" value="<%=BeginTime%>" class="InputGrey" readonly>
            </td>
         </tr>
		<tr>
		    <td class="blue">营销结束时间</td>
            <td>
		    <%
		        /*** begin diling update@2011/10/26 审批情况为审批通过时，才能进行营销结束时间的修改。 ***/
		         
		        if("审批通过".equals(examineSituation)){
		    %>
		            <input name="stop_time" type="text" id="stop_time" value="<%=EndTime%>" v_type="date"  />
		    <%
		        }else{
		    %>
		            <input name="stop_time" type="text" id="stop_time" value="<%=EndTime%>" class="InputGrey" readonly>
		    <%
		        }
		         /*** end diling update@2011/10/26  ***/
		    %>
            </td>
           <td class="blue">礼品代码</td> 
            <td>
						  <input name="Award_Code" type="text" id="Award_Code" value="<%=AwardCode%>" class="InputGrey" readonly>
            </td>   
            <td class="blue">礼品等级</td>
            <td>
						  <input name="Gift_Code" type="text" id="Gift_Code" value="<%=GiftCode%>" class="InputGrey" readonly>
            </td>
     	</tr>
     	<!--begin  huangrong 增加对经分活动编码文本框的显示  -->
     	<tr>
     				<td class="blue">经分活动编码</td>
            <td>
						  <input name="action_code" type="text" id="action_code" value="<%=ReturnActionCode%>" class="InputGrey" readonly>
            </td>	
            
            <td class="blue">渠道配置</td>
						<td colspan='3' title="<%=ActionNote%>">
							<%=channelName%>
						</td>
     	</tr>
     	<!--end -->
     	<tr>
				<td class="blue">入网时间</td>
				<td colspan='5'>
					<input type="text" value="<%=innetTime%>" class="InputGrey" readonly>天
				</td>     		
      </tr>	
     	<tr>
            <td class="blue">备注</td>
						<td colspan='5'>
							<TEXTAREA NAME="do_note" id="do_note" COLS="60" ROWS="3" class="TextAreaGrey" readonly><%=ActionNote%></TEXTAREA>
						</td>     		
      </tr>	
	<table id="table_2" style="display:;" cellspacing="0">       
       	<tr>
       		<th>审批工号</th>
       		<th>审批时间</th>
       		<th>审批意见</th>			
       	</tr>
	<%
	for(int i=0;i<tempArr1.length;i++)
	{
	%>
	<tr>
	        <td nowrap name="Login_no"><%=tempArr1[i][0]%></td>
	        <td nowrap name="Audit_Date"><%=tempArr1[i][1]%></td>
	        <td nowrap name="Audti_Suggestion"><%=tempArr1[i][2]%></td>
	</tr>
	<%}%>
</table>
<div class="title">
	<div id="title_zi">指定资费办理的配置</div>
</div>
<table id="table_3">       
	<tr>
		<th>资费代码</th>
		<th>资费名称</th>
		<th>资费描述</th>
	</tr>
	<%
	for(int i = 0; i < tempArr4.length; i ++) {
		%>
		<tr>
			<td><%=tempArr4[i][0]%></td>
			<td><%=tempArr4[i][1]%></td>
			<td><%=tempArr4[i][2]%></td>
		</tr>
		<%
	}
	%>
</table>
<table>
		<tr>
		    
            <td colspan="6" align="center" id="footer">
             <%
		        /*** begin diling update@2011/10/26 审批情况为审批通过时，才有提交按钮。 ***/
             %>
                 <input type="hidden" id="projectcode" name="projectcode" value="" />
		        <input type="hidden" id="projecttype" name="projecttype" value="" />
		        <input type="hidden" id="regionCode" name="regionCode" value="" />
             <%		         
		        if("审批通过".equals(examineSituation)){
		    %>
		            <input name="confirm" type="button" class="b_foot" index="2" value="提交" onClick="updateSubmit()" >
		    <%
		        }
		        /*** end diling update@2011/10/26  ***/
		    %>
                 
                <input name="confirm" type="button" class="b_foot" index="2" value="关闭" onClick="printCommit()" >
                <input name="back" type="button" class="b_foot" value="返回" onClick="go()">
            </td>
		</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

