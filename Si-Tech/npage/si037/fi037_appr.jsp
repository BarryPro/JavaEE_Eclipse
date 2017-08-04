<%
/********************
 version v2.0
 开发商 si-tech
 update dujl@2010-4-27
********************/
%>  
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String logacc = request.getParameter("logacc");
String chnSrc = "01";
String opCode =request.getParameter("opCode");
String workNo = (String)session.getAttribute("workNo");
String passwd = (String)session.getAttribute("password");

String phoNo = request.getParameter("vPhoNo");
System.out.println( "zhangyan  phoNo~~~~"+ phoNo  );
String usrPwd = request.getParameter("usrPwd");
String tm_b = request.getParameter("tm_b");
String tm_e = request.getParameter("tm_e");
String req_chn = (String)request.getParameter("req_chn");
System.out.println("gaopengSeeLog==============req_chn:"+req_chn);

String regCode = (String)session.getAttribute("regCode");
String opName = request.getParameter("opName");
String v_qryChn = request.getParameter( "v_qryChn" );
System.out.println("gaopengSeeLog==============v_qryChn:"+v_qryChn);
String v_qryAcc = request.getParameter( "v_qryAcc" );
String v_iccid = request.getParameter( "v_iccid" );
String vNName = request.getParameter( "vNName" );
String vNHomeAddr = request.getParameter( "vNHomeAddr" );
String vExpTime = request.getParameter( "vExpTime" );

String cur_page = request.getParameter( "cur_page" );
String pageNumber = request.getParameter( "pageNumber" );

Date currentTime = new Date(); 
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
String currentTimeString = formatter.format(currentTime);

String str_src1 = "/npage/public/pubGetImg.jsp?svcName=sI037Qry&outNum=30"
	+"&inNum=15"
	+"&outPos=8"
	+"&param0="+logacc
	+"&param1="+chnSrc
	+"&param2="+opCode
	+"&param3="+workNo
	+"&param4="+passwd
	
	+"&param5="+phoNo
	+"&param6="+usrPwd
	+"&param7="
	+"&param8="
	+"&param9="
	
	+"&param10="
	+"&param11=1"
	+"&param12="+v_qryChn
	+"&param13="+v_iccid
	+"&param14="+v_qryAcc;

String str_src2 = "/npage/public/pubGetImg.jsp?svcName=sI037Qry&outNum=30"
	+"&inNum=15"
	+"&outPos=9"
	+"&param0="+logacc
	+"&param1="+chnSrc
	+"&param2="+opCode
	+"&param3="+workNo
	+"&param4="+passwd
	
	+"&param5="+phoNo
	+"&param6="+usrPwd
	+"&param7="
	+"&param8="
	+"&param9="
	
	+"&param10="
	+"&param11=1"
	+"&param12="+v_qryChn
	+"&param13="+v_iccid
	+"&param14="+v_qryAcc;	

%>

<wtc:service name = "sI037Qry" outnum = "40"
	routerKey = "region" routerValue = "<%=regCode%>" 
	retcode = "rc_cfm" retmsg = "rm_cfm" >
	<wtc:param value = "<%=logacc%>"/>
	<wtc:param value = "<%=chnSrc%>"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = "<%=phoNo%>"/>
	<wtc:param value = "<%=usrPwd%>"/>
	<wtc:param value = ""/>
	<wtc:param value = ""/>
	<wtc:param value = ""/>
		
	<wtc:param value = ""/>
	<wtc:param value = "1"/>
	<wtc:param value = "<%=v_qryChn%>"/>
	<wtc:param value = "<%=v_iccid%>"/>
	<wtc:param value = "<%=v_qryAcc%>"/>
</wtc:service>
<wtc:array id="rst" scope="end" />

<%
if ( !rc_cfm.equals("000000") )
{
%>
	<script>
		rdShowMessageDialog( "<%=rc_cfm%>" + ":" + "<%=rm_cfm %>");
		window.history.go(-1);
	</script>
<%
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>查看客户身份证照片</title>
<script language="javascript" type="text/javascript" 
	src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</head>

<body>
<FORM  NAME = "frm" ACTION = "" METHOD = "POST" >
<%@ include file="/npage/include/header.jsp" %>
<DIV ID = "Operation_Table">
	<div class="title">
		<div id="title_zi">查看客户身份证照片</div>
	</div>
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
	<table>
		<tr>
			<th align='center' width = '50%' colspan = '2'>身份证正面</th>
			<th align='center' width = '50%' colspan = '2'>身份证背面</th>
		</tr>
		<tr>
			<td align='center' colspan = '2' >
				<img src = '<%=str_src1%>' width = '300px' height = '200px'>
			</td>	
			
			<td align='center' colspan = '2'>
				<img src = '<%=str_src2%>'  width = '300px' height = '200px'>	
			</td>			
		</tr>
		<tr>
			<td WIDTH = '15%' ALIGN = 'CENTER' class = 'blue' >证件号码</TD> 
			<td >
				<input id = 'v_iccid' name = 'v_iccid' maxlength = '18' 
					value = '<%=v_iccid%>' >
			</TD> 		
			<td WIDTH = '15%' ALIGN = 'CENTER' class = 'blue' >证件名称</TD> 
			<td >
				<input id = 'vNName' name = 'vNName' maxlength = '60' 
					value = '<%=vNName%>' >
			</TD> 
		</tr>
		<tr>
			<td ALIGN = 'CENTER' class = 'blue' >证件地址</TD> 
			<td >
				<input id = 'vNHomeAddr' name = 'vNHomeAddr' maxlength = '60' 
					value = '<%=vNHomeAddr%>' size = 40>				
			</TD> 					
			<td ALIGN = 'CENTER' class = 'blue' >证件有效期</TD>  
			<td >
				<input type='text' id = 'vExpTime' name = 'vExpTime1' 
					value = '' />					
			</TD> 					
		</tr>		
		<tr id = 'tr_rst'>
			<td ALIGN = 'CENTER' class = 'blue' >审批结果</td>
			<td colspan = '3'>
				<select  name = 'appr_rst' id = 'appr_rst' >
					<option value = '0'>0-->不通过</option>
					<option value = '1' selected >1-->通过</option>
				</select>
			</td>			
		</tr>
		<tr id = 'tr_rsn' style = 'display:none'>
			<td ALIGN = 'CENTER' class = 'blue' >不通过原因</td>
			<td colspan = '3'>
				<select id = 'rsn' name = 'rsn' >
					<%
					if ( "02".equals(v_qryChn) )
					{
					%>
						<option value = '8' >证件照片与身份信息不符</option>	
					<%
					}
					%>
					<option value = '9' >证件照片无效</option>
					<option value = '0' >其他</option>
				</select>
			</td>			
		</tr>	
		<tr id = 'tr_o_rsn' style = 'display:none'>
			<td ALIGN = 'CENTER' class = 'blue' >其它原因</td>
			<td colspan = '3'>
				<textarea id = 'other_rsn' name = 'other_rsn' 
					rows = '2' cols = '100'></textarea>
			</td>			
		</tr>
	</table>
	<TABLE>
		<TR> 
			<TD align=center id="footer"> 
				<input class="b_foot" name='doCfm' id = 'doCfm' 
					style="cursor:hand" type=button value=确认>&nbsp;    
					
				<input class="b_foot" name='doRst' id = 'doRst' 
					style="cursor:hand" type=button value=重置>&nbsp;
				<input class="b_foot" name='doBak' id = 'doBak' 
					style="cursor:hand" type=button value=返回>&nbsp;					
				<input class="b_Foot" name=back onClick="removeCurrentTab();" 
					style="cursor:hand" type=button value=关闭>&nbsp;        
			</TD>
		</TR>
	</TABLE>
	<INPUT TYPE = 'HIDDEN' ID = 'logacc' NAME = 'logacc' VALUE = '<%=logacc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'chnSrc' NAME = 'chnSrc' VALUE = '<%=chnSrc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'workNo' NAME = 'workNo' VALUE = '<%=workNo%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'passwd' NAME = 'passwd' VALUE = '<%=passwd%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'phoNo' NAME = 'phoNo' VALUE = '<%=phoNo%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'usrPwd' NAME = 'usrPwd' VALUE = '<%=usrPwd%>'/>
	
	<input type = 'hidden' id = 'v_qryChn' name = 'v_qryChn' value = '<%=v_qryChn%>'/>
	<input type = 'hidden' id = 'v_qryAcc' name = 'v_qryAcc' value = '<%=v_qryAcc%>'/>
	<input type = 'hidden' id = 'v_iccid' name = 'v_iccid' value = '<%=v_iccid%>'/>
	<input type = 'hidden' id = 'vIdNo' name = 'vIdNo' value = '<%=rst[0][10]%>'/>
	<input type = 'hidden' id = 'vNPwd' name = 'vNPwd' value = '<%=rst[0][11]%>'/>
	<input type = 'hidden' id = 'vNStatus' name = 'vNStatus' value = '<%=rst[0][12]%>'/>
	<input type = 'hidden' id = 'vNGrade' name = 'vNGrade' value = '<%=rst[0][13]%>'/>
	<input type = 'hidden' id = 'vNConName' name = 'vNConName' value = '<%=rst[0][14]%>'/>
	<input type = 'hidden' id = 'vNConTel' name = 'vNConTel' value = '<%=rst[0][15]%>'/>
	<input type = 'hidden' id = 'vNConAddr' name = 'vNConAddr' value = '<%=rst[0][16]%>'/>
	<input type = 'hidden' id = 'vNConPostNum' name = 'vNConPostNum' value = '<%=rst[0][17]%>'/>
	<input type = 'hidden' id = 'vNConPostAddr' name = 'vNConPostAddr' value = '<%=rst[0][18]%>'/>
	<input type = 'hidden' id = 'vNConFax' name = 'vNConFax' value = '<%=rst[0][19]%>'/>
	<input type = 'hidden' id = 'vNConEMail' name = 'vNConEMail' value = '<%=rst[0][20]%>'/>
	<input type = 'hidden' id = 'vNSex' name = 'vNSex' value = '<%=rst[0][21]%>'/>
	<input type = 'hidden' id = 'vNBirth' name = 'vNBirth' value = '<%=rst[0][22]%>'/>
	<input type = 'hidden' id = 'vNWork' name = 'vNWork' value = '<%=rst[0][23]%>'/>
	<input type = 'hidden' id = 'vNEduLevel' name = 'vNEduLevel' value = '<%=rst[0][24]%>'/>
	<input type = 'hidden' id = 'vNLove' name = 'vNLove' value = '<%=rst[0][25]%>'/>
	<input type = 'hidden' id = 'vNHabit' name = 'vNHabit' value = '<%=rst[0][26]%>'/>
	<input type = 'hidden' id = 'vChkStatu' name = 'vChkStatu' value = ''/>
	<input type = 'hidden' id = 'vChkMsg' name = 'vChkMsg' value = ''/>
	<input type = 'hidden' id = 'vNewCustId' name = 'vNewCustId' value = ''/>
	<input type = 'hidden' id = 'vNName' name = 'vNName' value = '<%=vNName%>'/>
	<input type = 'hidden' id = 'vNHomeAddr' name = 'vNHomeAddr' value = '<%=vNHomeAddr%>'/>
	<input type = 'hidden' id = 'vExpTime' name = 'vExpTime' value = '<%=vExpTime%>'/>
	<input type = 'hidden' id = 'vIdType' name = 'vIdType' value = '<%=rst[0][27]%>'/>
	<input type = 'hidden' id = 'vNBelongCode' name = 'vNBelongCode' value = '<%=rst[0][28]%>'/>
	<input type = 'hidden' id = 'vPhoNo' name = 'vPhoNo' value = '<%=phoNo%>'/>
	<input type = 'hidden' id = 'opCode' name = 'opCode' value = '<%=opCode%>'/>
	<input type = 'hidden' id = 'opName' name = 'opName' value = '<%=opName%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'regCode' NAME = 'regCode' VALUE = '<%=regCode%>'/>	
	<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>	
	<INPUT TYPE = 'HIDDEN' ID = 'cur_page' NAME = 'cur_page' VALUE = '<%=cur_page%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'pageNumber' NAME = 'pageNumber' VALUE = '<%=pageNumber%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'tm_b' NAME = 'tm_b' VALUE = '<%=tm_b%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'tm_e' NAME = 'tm_e' VALUE = '<%=tm_e%>'/>
</div>
</DIV>
<%@ include file="/npage/include/footer_new.jsp" %>	
<script>

$( document ).ready
(
	function ()
	{
		$("#d0").show ( 800 )	
		
		if ( ( "02" == $("#v_qryChn").val()) )
		{
			$("#v_iccid").addClass( "InputGrey" );
			$("#vNName").addClass( "InputGrey" );
			$("#vNHomeAddr").addClass( "InputGrey" );
			//$("#vExpTime").addClass( "InputGrey" );
			
			$("#v_iccid").attr( "readOnly" , true );
			$("#vNName").attr( "readOnly" , true );
			$("#vNHomeAddr").attr( "readOnly" , true );
			//$("#vExpTime").attr( "readOnly" , true );
		}
		
		if ( ( "14" == $("#v_qryChn").val()) )
		{
			$("#v_iccid").addClass( "InputGrey" );
			$("#vNName").addClass( "InputGrey" );
			$("#vNHomeAddr").addClass( "InputGrey" );
			//$("#vExpTime").addClass( "InputGrey" );
			
			$("#v_iccid").attr( "readOnly" , true );
			$("#vNName").attr( "readOnly" , true );
			$("#vNHomeAddr").attr( "readOnly" , true );
			//$("#vExpTime").attr( "readOnly" , true );
		}
		
	}
)

/*
$("#vExpTime").click
(
	function ()
	{
		WdatePicker({startDate:'%y%M%d'
			,dateFmt:'yyyyMMdd'
			,readOnly:true
			,alwaysUseStartDate:true})			
	}
);
*/
$("#vExpTime").blur(
	function(){
		if(!chekExpTime()) return false;
	}
);

function chekExpTime(){
	var flag = true;
	var currentTimeString = "<%=currentTimeString%>";
	hiddenTip(document.all.vExpTime1);
	var vExpTime = $("#vExpTime").val().trim();
	$("#vExpTime").val(vExpTime);
	if(vExpTime != "" && vExpTime != null){
		if(vExpTime != "长期"){
			$("#vExpTime").attr("v_format","yyyyMMdd");
			if(!forDate(document.all.vExpTime1)){ 
				flag = false;
			}else if( vExpTime < currentTimeString ){
				rdShowMessageDialog("证件有效期不可以小于当前时间！" ,1);
				$("#vExpTime").focus();
				flag = false;
			}
		}else{
			$("#vExpTime").removeAttr("v_format");
		}
	}
	return flag;
}

$("#doCfm").click
(
	function ()
	{
		var apprFlag = $("#appr_rst").find("option:selected").val();
		if(apprFlag == "1"){
			if ( "" == $("#v_iccid").val().trim() )
			{
				rdShowMessageDialog("证件号码必须填写！" ,0);
				return false;
			}
			else
			{
				if ( 18 != $("#v_iccid").val().trim().length )
				{
					rdShowMessageDialog("证件号码必须18位！" ,0);
					return false;
				}
			}
			
			if ( "" == $("#vNName").val().trim() )
			{
				rdShowMessageDialog("证件姓名必须填写！" ,0);
				return false;
			}		
			else
			{
				if ( 2 > $("#vNName").val().trim().length )
				{
					rdShowMessageDialog("证件姓名必须大于两个汉字！" ,0);
					return false;
				}
				
				if(($("#vNName").val().trim().indexOf("临时") > -1)
					||($("#vNName").val().trim().indexOf("代办") > -1))
				{
					rdShowMessageDialog("不可以包含“临时”、“代办”字样！请重新输入！");
					return false;
				}	
			}
			
			if ( "" == $("#vNHomeAddr").val().trim() )
			{
				rdShowMessageDialog("证件地址必须填写！" ,0);
				return false;
			}	
			else
			{
				/*gaopeng 2013/12/24 13:24:00 修改证件地址至少含有8个汉字的校验逻辑*/
				var objValue = $.trim($("#vNHomeAddr").val());
				var m = /^[\u0391-\uFFE5]*$/;
				var chinaLength = 0;
				for (var i = 0; i < objValue.length; i ++){
		          var code = objValue.charAt(i);//分别获取输入内容
		          var flag = m.test(code);
		          if(flag){
		          	chinaLength ++;
		          }
		    }
				if ( chinaLength < 8)
				{
					rdShowMessageDialog("证件地址必须含有至少8个汉字！" ,0);
					return false;
				}			
			}
			
			if ( "" == $("#vExpTime").val().trim() )
			{
				rdShowMessageDialog("证件有效期必须填写！" ,0);
				return false;
			}			
			
			if(!chekExpTime()) return false;
			
			if ( $("#rsn").val() == "0" )
			{
				$("#vChkMsg").val( $("#other_rsn").val() );
			}
			else
			{
				$("#vChkMsg").val( $("#rsn").find ( "option:selected" ).text() );
			}
		}
		var rsnval = $("#rsn").find("option:selected").val();
		if(rsnval == "0"){
			var other_rsntext = $("#other_rsn").text();
			if($.trim(other_rsntext).length == 0){
				rdShowMessageDialog("其他原因必须填写！" ,0);
				return false;
			}
		
		}
		if ( $("#rsn").val() == "0" )
			{
				$("#vChkMsg").val( $("#other_rsn").val() );
			}
			else
			{
				$("#vChkMsg").val( $("#rsn").find ( "option:selected" ).text() );
			}
			/*gaopeng 2013/12/24 13:23:02 实名制审需求，将联系人地址 联系人通讯地址 等地址全部赋值为证件地址*/
			/*如果来自手机客户端*/
			if("<%=v_qryChn%>" == "69"){
				$("#vNConAddr").val($.trim($("#vNHomeAddr").val()));
				$("#vNConPostAddr").val($.trim($("#vNHomeAddr").val()));
				$("#vNHomeAddr").val($.trim($("#vNHomeAddr").val()));
			}
			
			if($("#vExpTime").val().trim()=="长期"){
				$("#vExpTime").val("20500101");
			}
		document.frm.action = "fi037_cfm.jsp";
		document.frm.submit();
	
	}
)

/*重置*/
$("#doRst").click
(
	function ()
	{		
		document.frm.action = "#";
		document.frm.submit();
	}
)	

$("#doBak").click
(
	function ()
	{
		window.history.go( -1 );	
	}
)

/*审批*/
$("#appr_rst").change
(
	function ()
	{
		if ( "0" == $("#appr_rst").val()  )
		{
			$("#tr_rsn").show( 800 );
		}
		else
		{
			$("#tr_rsn").hide();
			$("#tr_o_rsn").hide();
		}
	}
)

/*原因*/
$("#rsn").change
(
	function ()
	{
		if ( "0" == $("#rsn").val()  )
		{
			$("#tr_o_rsn").show( 800 );
		}
		else
		{
			$("#tr_o_rsn").hide();
			$("#other_rsn").val("");
		}
	}
)
</script>
</FORM>
</body>
</html>
