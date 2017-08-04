<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9607";
 		String opName = "注意事项库修改";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		/**这个参数是用来控制"重置"的时候,页面显示哪部分内容**/
		String confirmFlag = WtcUtil.repNull(request.getParameter("confirmFlag"));
		
		
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd hh:mm:ss").format(new java.util.Date());
		
		/**查看工号的级别,如果是营业厅的级别或更小,则进不了修改页面**/
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("#######checkSql->"+checkSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**根据loginRootDistance来判断工号权限问题**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				loginRootDistance = sVerifyTypeArr[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
			}
		}
		
		/*zhangyan add 工号类型,用于区别人工客服*/
		String accountType=(String)session.getAttribute("accountType");
		System.out.println("zhangyan~~~~loginRootDistance="+loginRootDistance);
		System.out.println("zhangyan~~~~accoutType~~~~"+accountType);
	
		String sqlChn="select Channels_Code,Channels_Name "
			+"	from sChannelsCode "
			+"	where root_distance >="+loginRootDistance;
			
		if (accountType.equals("2"))
		{
			sqlChn+=" and Channels_Code='08' ";
		}	
		else
		{
			sqlChn+=" and Channels_Code<>'08' ";
		}
		sqlChn+="	order by Channels_Code  ";		
		
		System.out.println("9607~~~~sqlChn="+sqlChn);
		/**如果工号的级别比区县更小,则不能进行修改操作;1.判断工号的级别,如果root_distance==1,省级,==2,地市,==3,区县,>3,营业厅或更小的级别**/
		/*zhangyan add 非客服工号才校验root_distance*/
		if (  ! accountType.equals("2") )
		{
			if(loginRootDistance>3){
			%>
					<table cellspacing="0">
						<tr bgcolor='649ECC' height=25 align="center">
							<td>
								<font style="color:red">(此工号无修改权限)</font>
							</td>
						</tr>
					</table>
					<script language="javascript">
						<!--
						rdShowMessageDialog("此工号无修改权限");
						window.close();
						//-->
					</script>		
				<%
				return;
			}
		}
%>
<html>
	<head>
	<title>黑龙江BOSS-注意事项库修改</title>
	<!--调用js库-->
	<script language="javascript">
		<!--
			/**
				*因为后来用户需求的大量调整,,所以后来写的代码没用rdShowMessageDialog(),用了alert(),,以加快页面响应速度
				*本模块中使用的jtrim(),不是老方法jtrim(),是在模块中重写的方法,所以无须更改
				*页面逻辑复杂,使用嵌套iframe,也是应用户的要求
				*请再次修改的时候,,一定要看清楚逻辑,,
				*/
				
			onload = function(){
				
				/**以下这段代码能用来控制"重置"后,页面显示那部分内容.可以删除这段代码,而且不影响页面**/
				var confirmFlag = "<%=confirmFlag%>";
				if(confirmFlag=="fieldPromptConfirm"){
					showMessage(2);
				}else{
					showMessage(1);
				}	
				/***到这里为止***/
			}
			
			/**显示"根据界面增加"**/
			function showOprInfo(){
				oprDiv.style.display="block";
				fieldDiv.style.display="none";
				document.all.confirmFlag.value="oprPromptConfirm";
			}

			/**显示"根据业务增加"**/
			function showFieldInfo(){
				oprDiv.style.display="none";
				fieldDiv.style.display="block";
				document.all.confirmFlag.value="fieldPromptConfirm";
			}	
			
			
			/**点击切换标签调用事件**/
			function showMessage(flag){
				var guidanceUl=document.getElementById("guidanceUl");
				for(var i=0;i<guidanceUl.childNodes.length;i++){
					guidanceUl.childNodes[i].className="";
				}
				eval("document.getElementById('li"+flag+"')").className="current";	
				if(flag==1){
					//根据界面修改
					showOprInfo();
				}else if(flag==2){
					//根据业务修改
					showFieldInfo();
				}
			}	
			
			/**模糊查询操作模块信息**/
			function getFucntionInfo(){
				var sFunctionCode = document.all.sFunctionCode.value;
				var sFunctionName = document.all.sFunctionName.value;
				if(jtrim(sFunctionCode)==""&&jtrim(sFunctionName)==""){
					rdShowMessageDialog("模块代码与模块名称必须输入一项!<br>(支持模糊查询,只需输入部分信息)");
					document.all.sFunctionCode.focus();
					return false;
				}
        var h = 500;
        var w = 350;
        var t = screen.availHeight / 2 - h / 2;
        var l = screen.availWidth / 2 - w / 2;
        var impFrm = document.frm;
        var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
        var path = "f9607_getFucntionInfo.jsp?sFunctionCode="+sFunctionCode+"&sFunctionName="+sFunctionName;
        var ret = window.showModalDialog(path, impFrm, prop);				
			}
			
			/**清除输入的操作模块信息,便于查询**/
			function doClearFunctionInput(){
				document.all.sFunctionCode.value = "";
				document.all.sFunctionName.value = "";
			}
			
			/**模糊查询操作模块信息**/
			function getFucntionInfo2(){
				var sFunctionCode = document.all.sFunctionCode2.value;
				var sFunctionName = document.all.sFunctionName2.value;
				if(jtrim(sFunctionCode)==""&&jtrim(sFunctionName)==""){
					rdShowMessageDialog("模块代码与模块名称必须输入一项!<br>(支持模糊查询,只需输入部分信息)");
					document.all.sFunctionCode2.focus();
					return false;
				}
        var h = 500;
        var w = 350;
        var t = screen.availHeight / 2 - h / 2;
        var l = screen.availWidth / 2 - w / 2;
        var impFrm = document.frm;
        var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
        var path = "f9607_getFucntionInfo.jsp?sFunctionCode="+sFunctionCode+"&sFunctionName="+sFunctionName;
        var ret = window.showModalDialog(path, impFrm, prop);				
			}	
	
			/**清除输入的操作模块信息,便于yyy查询**/
			function doClearFunctionInput2(){
				document.all.sFunctionCode2.value = "";
				document.all.sFunctionName2.value = "";
			}
			
			/**选择代码**/
			function getFieldClassCode(){
				document.getElementById("iClassCodeFrame").style.display = "block";
				document.iClassCodeFrame.location = "f9607_getFieldClassCode.jsp?iClassCode="+jtrim(document.all.iClassCode.value)+"&iClassName="+jtrim(document.all.iClassName.value);
			}
			
			/**点击"查询"按钮产生的事件**/
			function doQuery(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					var sFunctionCode = jtrim(document.all.sFunctionCode.value);
					var iBillType = document.all.iBillType.value;
					var iPromptType = document.all.iPromptType.value;
					var iPromptSeq = (document.all.iPromptSeq.value).trim();	
					var Channels_Code = document.all.Channels_Code.value;
						
					/**
					if(sFunctionCode==""||sFunctionCode.length==0){
						rdShowMessageDialog("提示操作代码不能为空!");
						document.all.sFunctionCode.focus();
						return false;
					}	
					**/
							
					document.getElementById("qryOprInfoFrame").style.display="block";
					document.qryOprInfoFrame.location.href = "f9607_getOprInfoByFunctionCode.jsp?sFunctionCode="+sFunctionCode+"&iBillType="+iBillType+"&iPromptType="+iPromptType+"&iPromptSeq="+iPromptSeq+"&Channels_Code="+Channels_Code+"&rootDistance=<%=loginRootDistance%>";
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var iClassCode = jtrim(document.all.iClassCode.value);
					var sClassValue = jtrim(document.all.sClassValue.value);
					var iBillType = document.all.iBillType2.value;
					var iPromptType = document.all.iPromptType2.value;
					var iPromptSeq = jtrim(document.all.iPromptSeq2.value);
					var sFunctionCode = jtrim(document.all.sFunctionCode2.value);
					var Channels_Code2 = document.all.Channels_Code2.value;
					document.getElementById("qryFieldInfoFrame").style.display = "block";
					document.qryFieldInfoFrame.location.href = "f9607_getFieldInfoByClassCode.jsp?iClassCode="+iClassCode+"&sClassValue="+sClassValue+"&iPromptSeq2="+iPromptSeq+"&iPromptType2="+iPromptType+"&iBillType2="+iBillType+"&sFunctionCode2="+sFunctionCode+"&Channels_Code="+Channels_Code2+"&rootDistance=<%=loginRootDistance%>";						
				}
			}
			
			/**提交页面**/
			function doConfirm(){
					/**如果是按"操作代码"修改**/
					if(document.all.confirmFlag.value=="oprPromptConfirm"){
						/**
						if(typeof(document.all.)){
							
						}
						**/
						
						var sFunctionCode = jtrim(document.all.sFunctionCode.value);
						var iBillType = document.all.iBillType.value;
						var iPromptType = document.all.iPromptType.value;
						var Channels_Code = document.all.Channels_Code.value;
						var iPromptSeq = jtrim(document.all.iPromptSeq.value);
						
						if(sFunctionCode==""||sFunctionCode.length==0){
							rdShowMessageDialog("操作代码不能为空!");
							return false;
						}	
						if(iPromptType==""||iPromptType=="none"){
							rdShowMessageDialog("请选择提示类型!");
							return false;
						}					
						if(iBillType==""||iBillType=="none"){
							rdShowMessageDialog("请选择票据类型!");
							return false;
						}
						if(iPromptSeq==""||iPromptSeq.length==0){
							rdShowMessageDialog("提示序号不能为空!");
							return false;
						}	
						if(Channels_Code==""||Channels_Code=="none"){
							rdShowMessageDialog("请选择渠道类型!");
							return false;
						}
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var sFunctionCode = jtrim(document.all.sFunctionCode2.value);
					var iClassCode = jtrim(document.all.iClassCode.value);
					var sClassValue = jtrim(document.all.sClassValue.value);
					var iBillType = document.all.iBillType2.value;
					var iPromptType = document.all.iPromptType2.value;
					var iPromptSeq = jtrim(document.all.iPromptSeq2.value);	
					var Channels_Code = document.all.Channels_Code2.value;
					
					if(sFunctionCode==""||sFunctionCode.length==0){
						rdShowMessageDialog("操作代码不能为空!");
						document.all.iClassCode2.focus();
						return false;
					}
						
					if(iClassCode==""||iClassCode.length==0){
						rdShowMessageDialog("代码不能为空!");
						document.all.iClassCode.focus();
						return false;
					}	
					
					if(sClassValue==""||sClassValue.length==0){
						rdShowMessageDialog("字段域值不能为空!");
						document.all.sClassValue.focus();
						return false;
					}						
					
					if(iPromptSeq==""||iPromptSeq.length==0){
						rdShowMessageDialog("提示序号不能为空!");
						document.all.iPromptSeq2.focus();
						return false;
					}	
					if(iPromptType==""||iPromptType=="none"){
						rdShowMessageDialog("请选择提示类型!");
						document.all.iPromptType2.focus();
						return false;
					}					
					if(iBillType==""||iBillType=="none"){
						rdShowMessageDialog("请选择票据类型!");
						document.all.iBillType2.focus();
						return false;
					}
					if(Channels_Code==""||Channels_Code=="none"){
							rdShowMessageDialog("请选择渠道类型!");
							return false;
					}	
				}
				

				
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					var sPromptContent = document.showOprInfoFrame.document.all.sPromptContent.value;
					var sIsPrint = document.showOprInfoFrame.document.all.sIsPrint.value;
					var sValidFlag = document.showOprInfoFrame.document.all.sValidFlag.value;
					var sModifyGroupId = document.showOprInfoFrame.document.all.sModifyGroupId.value;
					var sIsCreaterStart = document.showOprInfoFrame.document.all.sIsCreaterStart.value;
					var sAuditLogins = document.showOprInfoFrame.document.all.sAuditLogins.value;
					var opNote = document.showOprInfoFrame.document.all.opNote.value;
					
					if(jtrim(sPromptContent)==""){
						rdShowMessageDialog("提示内容不能为空!");
						return false;	
					}
					
					if(jtrim(sPromptContent).length>512){
						rdShowMessageDialog("提示内容长度有误,不能大于512字！");
						return false;						
					}
					
					if(jtrim(sAuditLogins)==""){
						rdShowMessageDialog("必须选择审批人,至少需要选择一个!");
						return false;							
					}	
										
					if(jtrim(opNote).length>30){
						rdShowMessageDialog("操作备注过长,请删减！");
						return false;							
					}
					
					var confirmFlag = rdShowConfirmDialog("确认要提交操作吗?");
					if(confirmFlag!=1){
						return false;
					}
					
					document.frm.action = "f9607_oprCfm.jsp?sPromptContent="+sPromptContent+"&sIsPrint="+sIsPrint+"&sValidFlag="+sValidFlag+"&sModifyGroupId="+sModifyGroupId+"&sIsCreaterStart="+sIsCreaterStart+"&sAuditLogins="+sAuditLogins+"&opNote="+opNote;
					document.frm.submit();					
				}else if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var iClassSeq = document.showFieldInfoFrame.document.all.iClassSeq.value;
					var sIsByValue = document.showFieldInfoFrame.document.all.sIsByValue.value;
					var sLimitRule = document.showFieldInfoFrame.document.all.sLimitRule.value;
					var sPromptContent2 = document.showFieldInfoFrame.document.all.sPromptContent2.value;
					var sIsPrint2 = document.showFieldInfoFrame.document.all.sIsPrint2.value;	
 					var sValidFlag2 = document.showFieldInfoFrame.document.all.sValidFlag2.value;
 					var sModifyGroupId2 = document.showFieldInfoFrame.document.all.sModifyGroupId2.value;
 					var sAuditLogins2 = document.showFieldInfoFrame.document.all.sAuditLogins.value;
 					var sIsCreaterStart2 = document.showFieldInfoFrame.document.all.sIsCreaterStart2.value;
 					var opNote2 = document.showFieldInfoFrame.document.all.opNote2.value;
 					
 					if(sValidFlag2==""||sValidFlag2=="none"){
 						rdShowMessageDialog("必须选择'有效标志'!");
 						return false;
 					}
 					
 					if(iClassSeq.search(/^[0-9]*[1-9][0-9]*$/)==-1){
 						rdShowMessageDialog("'输出顺序'必须是正整数!");
 						return false;
 					}
 	
					if(jtrim(sPromptContent2)==""){
						rdShowMessageDialog("提示内容不能为空！");
						return false;						
					}
									
					if(jtrim(sPromptContent2).length>512){
						rdShowMessageDialog("提示内容长度有误,不能大于512字！");
						return false;						
					}
					
					if(jtrim(sAuditLogins2)==""){
						rdShowMessageDialog("必须选择审批人,至少需要选择一个!");
						return false;							
					}
					
					if(jtrim(opNote2).length>30){
						rdShowMessageDialog("操作备注过长,请删减！");
						return false;							
					}
					
					var confirmFlag = rdShowConfirmDialog("确认要提交操作吗?");
					if(confirmFlag!=1){
						return false;
					}			
							 
					document.frm.action = "f9607_fieldCfm.jsp?iClassSeq="+iClassSeq+"&sIsByValue="+sIsByValue+"&sLimitRule="+sLimitRule+"&sPromptContent2="+sPromptContent2+"&sIsPrint2="+sIsPrint2+"&sValidFlag2="+sValidFlag2+"&sModifyGroupId2="+sModifyGroupId2+"&sAuditLogins2="+sAuditLogins2+"&sIsCreaterStart2="+sIsCreaterStart2+"&opNote2="+opNote2;
					document.frm.submit();
				}
			}
			/**过滤字符左右的空格**/
			function jtrim(str){
				if(str==null){
					return "";	
				}
				return str.replace( /^\s*/, "" ).replace( /\s*$/, "" );	
			}		
				
			/**重置页面**/
			function doReset(){
				//window.location.reload();
				//在"重置"页面时,利用这个标志自动跳转到重置前的那个页面
				window.location.href = "f9607_1.jsp?confirmFlag="+document.all.confirmFlag.value;
			}
			
			/**关闭页面**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
			}
			//-->
	</script>
	
	<!--这段css样式是用来设置切换标签的样式,,,如果有更好的切换标签来替换,,,请删除这段样式,不影响页面其他内容-->
	<style type="text/css">
	<!--
    body {
      margin:0;
      padding:0;
      font:  12px/1.5em Verdana;
    }
		
    #tabsJ {
      float:left;
      width:100%;
      background:#f6f6f6;
      font-size:93%;
      line-height:normal;
    }
    #tabsJ ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabsJ li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
    }
    #tabsJ a:hover {
      background-position:0% -42px;
    }
    #tabsJ a:hover span {
      background-position:100% -42px;
    }

    #tabsJ .current a {
      background-position:0% -42px;
    }
    #tabsJ .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }
	-->
	</style>
</head>

<!--
	发布动作类型,1,发布,2,收回,3,更新
	/**
		当打印类型为"1,提示"的时候,提示类型:12-事中
		当打印类型为"2,打印"的时候,提示类型:13-事后、2-资费说明
		当打印类型为"3,打印并提示"的时候,提示类型:12-事中
	**/
-->
			
<body>
	<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>
		<!--这个隐藏域非常重要.主要是通过它来控制是"根据界面修改"还是"根据业务修改"-->
		<input type="hidden" name="confirmFlag" value="oprPromptConfirm">
		<!--
			//这个参数createLogin来自子页面,用于判断:
			//当工号是区县的级别时,用这个创建工号跟修改人工号比对,
			//如果相等,则修改发起的途径为:创建人发起的修改
			//如果不相等,则修改发起的途径为:修改者发起的修改
		-->
		<input type="hidden" name="createLogin" value="">
		<!--以下为具体内容-->
		
		<div class="title">
			<div id="title_zi">请选择操作类型</div>
		</div>
		
		<!--切换标签,如果有更合适的标签,,可以替换-->
		 <table cellSpacing="0">
		 	<tr>
		 		<td>
					<div id="tabsJ">
						<ul id="guidanceUl">
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>根据界面修改</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>根据业务修改</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>

		<!--
			/*@service information
			 *@name						s9607Cfm1
			 *@description				注意事项库的修改
			 *@author					lugz
			 *@created	2008-10-10 9:05:18
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
			 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
			 *@inparam	opCode			功能代码	
			 *@inparam	loginNo			操作工号
			 *@inparam	loginPasswd		经过加密的工号密码
			 *@inparam	systemNote		系统备注
			 *@inparam	opNote			操作备注
			 *@inparam	ipAddr			IP地址
			 
			 *@inparam	sFunctionCode	提示操作功能
			 *@inparam	iBillType	票据类型
			 *@inparam	iPromptType	提示类型
			 *@inparam	iPromptSeq	提示序号
			 *@inparam	sReleaseGroup 发布来源
			 *@inparam	sPromptContent	提示内容
			 *@inparam	sIsPrint	是否打印
			 *@inparam	sValidFlag	有效标志
			 *@inparam	sModifyGroupId 修改节点
			 *@inparam	sIsCreaterStart Y/N
			 *@inparam	sAuditLogin	审批人
			 
			 *@output parameter information		
			 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
			 *@return SVR_ERR_NO 
			 */
		-->
		<div id="oprDiv" style="display:block">
			<table cellspacing="0" align="center">
				<tr>
					<td width="15%" class="blue" nowrap>操作代码</td>
					<td width="35%">
						<input type="text" name="sFunctionCode" value="" onKeyDown="if(event.keyCode==13){doQuery();}">&nbsp;
						<input type="hidden" name="sFunctionCodeHidden" value="">
						<input name="queryfcbutton" type="button" class="b_text" style="cursor:hand" onClick="getFucntionInfo()" value="获取">&nbsp;
						<input name="clearfcbutton"  type="button" class="b_text" style="cursor:hand" onClick="doClearFunctionInput()" value="清除">
					</td>
					<td width="15%" class="blue" nowrap>操作名称</td>
					<td>
						<input type="text" name="sFunctionName" value="" onKeyDown="if(event.keyCode==13){getFucntionInfo();}">&nbsp;<font class="orange">(匹配模糊查询)</font>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>提示类型</td>
					<td>
						<select name="iPromptType">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select prompt_type,prompt_type||'->'||prompt_name from sFuncPromptType where prompt_type = '11' or prompt_type = '10' or prompt_type='13' or prompt_type='2' order by prompt_type</wtc:sql><!--update by diling for 申告：注意事项库修改和删除不成功@2011/11/3-->
							</wtc:qoption>
						</select>	
						<input type="hidden" name="iPromptTypeHidden" value="">					
					</td>
					<td class="blue">票据类型</td>
					<td>
						<select name="iBillType">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>		
						<input type="hidden" name="iBillTypeHidden" value="">				
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>提示序号</td>
					<td width="35%" >
						<input type="text" name="iPromptSeq" value="">
						<input type="hidden" name="iPromptSeqHidden" value="">		
					</td>
					<td  class="blue" nowrap>渠道类型</td>
					<td >
						<select name="Channels_Code">
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql><%=sqlChn%></wtc:sql>
							</wtc:qoption>
						</select>				
						  <input type="hidden" name="Channels_CodeHidden" value="">									
					</td>			
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="showOprInfoFrame" align="center" name="showOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showOprInfoFrame').style.height=showOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
		</div>
		<!--
			/*@service information
			 *@name						s9607Cfm2
			 *@description				注意事项修改
			 *@author					lugz
			 *@created	2008-10-10 11:12:30
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
			 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
			 *@inparam	opCode			功能代码	
			 *@inparam	loginNo			操作工号
			 *@inparam	loginPasswd		经过加密的工号密码
			 *@inparam	systemNote		系统备注
			 *@inparam	opNote			操作备注
			 *@inparam	ipAddr			IP地址
			 
			 
			 *@inparam	sFunctionCode	提示操作功能
			 *@inparam	iBillType	票据类型
			 *@inparam	iClassSeq	输出顺序
			 *@inparam	iClassCode	代码
			 *@inparam	sClassValue	字段域值
			 *@inparam	sIsByValue	是否按照代码提示
			 *@inparam	sLimitRule	前项限制
			
			 *@inparam	iPromptType	提示类型
			 *@inparam	iPromptSeq	提示序号
			 *@inparam	sPromptContent	提示内容
			 *@inparam	sIsPrint	是否打印
			 *@inparam	sValidFlag	有效标志
			 *@inparam	sModifyGroupId 修改节点
			 *@inparam	sIsCreaterStart Y/N
			 *@inparam	sAuditLogin	审批人
			 *@output parameter information
			 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
			 *@return SVR_ERR_NO 
			 */
		-->
		<div id="fieldDiv" style="display:none">
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>代码</td>
					<td width="35%">
						<input type="text" name="iClassCode" value="">&nbsp;&nbsp;
						<input name="queryccbutton" type="button" class="b_text" style="cursor:hand" onClick="getFieldClassCode()" value="查询">
						<input type="hidden" name="iClassCodeHidden" value="">
					</td>
					<td width="15%" class="blue" nowrap>字段域名称</td>
					<td width="35%">
						<input type="text" name="iClassName" value="">&nbsp;<font class="orange">(支持模糊查询)</font>
					</td>	
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
							<iframe frameBorder="0" id="iClassCodeFrame" align="center" name="iClassCodeFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('iClassCodeFrame').style.height=iClassCodeFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>操作代码</td>
					<td width="35%">
						<input type="text" name="sFunctionCode2" value="" onKeyDown="if(event.keyCode==13){doQuery();}">&nbsp;&nbsp;
						<input name="queryfcbutton2" type="button" class="b_text" style="cursor:hand" onClick="getFucntionInfo2()" value="获取">&nbsp;
						<input name="clearfcbutton2"  type="button" class="b_text" style="cursor:hand" onClick="doClearFunctionInput2()" value="清除">
						<input type="hidden" name="sFunctionCode2Hidden" value="">
					</td>
					<td width="15%" class="blue" nowrap>操作名称</td>
					<td>
						<input type="text" name="sFunctionName2" value="" onKeyDown="if(event.keyCode==13){getFucntionInfo2();}">&nbsp;<font class="orange">(匹配模糊查询)</font>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue">字段域值</td>
					<td>
						<input type="text" name="sClassValue" value="">
						<input type="hidden" name="sClassValueHidden" value="">
					</td>	
					<td width="15%" class="blue">提示序号</td>
					<td>
						<input type="text" name="iPromptSeq2" value="">
						<input type="hidden" name="iPromptSeq2Hidden" value="">	
					</td>
				</tr>
				<tr>		
					<td width="15%" class="blue" nowrap>提示类型</td>
					<td>
						<select name="iPromptType2">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select prompt_type,prompt_type||'->'||prompt_name from sFuncPromptType where prompt_type = '12' or prompt_type = '10' or prompt_type='13' or prompt_type='2' order by prompt_type</wtc:sql><!--update by diling for 申告：注意事项库修改和删除不成功@2011/11/3-->
							</wtc:qoption>
						</select>
						<input type="hidden" name="iPromptType2Hidden" value="">						
					</td>
					<td class="blue">票据类型</td>
					<td>
						<select name="iBillType2">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>
						<input type="hidden" name="iBillType2Hidden" value="">						
					</td>
				</tr>
							<tr>
				<td  class="blue" nowrap>渠道类型</td>
					<td colspan="3">
						<select name="Channels_Code2">
						  <wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql><%=sqlChn%></wtc:sql>
							</wtc:qoption>
						</select>						
						<input type="hidden" name="Channels_Code2Hidden" value="">	
					</td>			
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryFieldInfoFrame" align="center" name="qryFieldInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="showFieldInfoFrame" align="center" name="showFieldInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showFieldInfoFrame').style.height=showFieldInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
		</div>
		<!--以下为操作部分-->
		<table cellSpacing="0">
      <tr> 
        <td id="footer"> 
        	 <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doQuery()">&nbsp;
           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()">&nbsp;
           <input type="button" name="confirmButton" class="b_foot" value="确定修改" style="cursor:hand;" onClick="doConfirm()" disabled>&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()">&nbsp;
        </td>
      </tr>
     </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
