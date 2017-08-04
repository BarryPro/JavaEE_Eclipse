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
    
 		String opCode = "9605";
 		String opName = "注意事项库增加";
 		
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
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
		
		/***以下是来判断工号有无增加注意事项的权限的:
		如果是营业厅级工号,则没有权限***/
		String sReleaseGroupName = "";
		String getGroupNameSql = "select group_name ,root_distance from dChnGroupMsg where group_id  = '"+groupId+"'";		
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=getGroupNameSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%
	int root_distance_int = 0;
	/*zhangyan add 工号类型,用于区别人工客服*/
	String accountType=(String)session.getAttribute("accountType");
	System.out.println("zhangyan~~~~accoutType~~~~"+accountType);
	if(retCode1.equals("000000")){
		/*zhangyan 登录工号所在组织机构的root_distance*/
		String root_distance = sVerifyTypeArr[0][1];
		root_distance_int = Integer.parseInt(root_distance);
		
		/*zhangyan 修改只有非人工客服工号才判断*/
		if ( !(accountType.equals("2")) )
		{
			if(root_distance_int>3 )
			{
			%>
				<script>
				rdShowMessageDialog("该工号无增加权限!");
				window.close();
				</script>
			<%
			return ;
			}
		}
		if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
			sReleaseGroupName = sVerifyTypeArr[0][0];
		}
	}
	

	String sqlChn="select Channels_Code,Channels_Name "
		+"	from sChannelsCode "
		+"	where root_distance >="+root_distance_int;
		
	if (accountType.equals("2"))
	{
		sqlChn+=" and Channels_Code='08' ";
	}		
	else
	{
		sqlChn+=" and Channels_Code<>'08' ";
	}
	sqlChn+="	order by Channels_Code  ";
	

		
%>
<html>
	<head>
	<title>黑龙江BOSS-注意事项库增加</title>
	<script language="javascript">
		<!--
			/**
				*因为后来用户需求的大量调整,,所以后来写的代码没用rdShowMessageDialog(),用了alert(),,以加快页面响应速度
				*本模块中使用的jtrim(),不是老方法jtrim(),是在模块中重写的方法,所以无须更改
				*页面逻辑复杂,使用嵌套iframe,也是应用户的要求
				*请再次修改的时候,,一定要看清楚逻辑,,
				*/
			
			
			onload=function(){
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
					//根据界面增加
					showOprInfo();
				}else if(flag==2){
					//根据业务增加
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
        var path = "f9605_getFucntionInfo.jsp?sFunctionCode="+sFunctionCode+"&sFunctionName="+sFunctionName;
        var ret = window.showModalDialog(path, impFrm, prop);				
			}
			
			/**清除输入的操作模块信息,便于yyy查询**/
			function doClearFunctionInput(){
				document.all.sFunctionCode.value = "";
				document.all.sFunctionName.value = "";
				document.all.sFunctionCode.focus();
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
        var path = "f9605_getFucntionInfo.jsp?sFunctionCode="+sFunctionCode+"&sFunctionName="+sFunctionName;
        var ret = window.showModalDialog(path, impFrm, prop);				
			}	
	
			/**清除输入的操作模块信息,便于yyy查询**/
			function doClearFunctionInput2(){
				document.all.sFunctionCode2.value = "";
				document.all.sFunctionName2.value = "";
				document.all.sFunctionCode2.focus();
			}
							
			/**
			当打印类型为"1,提示"的时候,提示类型:11-事前、13-事后
			当打印类型为"2,打印"的时候,提示类型:13-事后  @20081024 选小区代码时，打印选择只有“打印”，提示类型只有“资费说明”
			当打印类型为"3,打印并提示"的时候,提示类型:11-事前、13-事后
			**/
			function doChangeIsPrintSelect(obj){
				
				var iPromptType = document.getElementById("iPromptType");
				var ln=iPromptType.length;
				while(ln--)
        {
          iPromptType.options[ln] = null;
        }
        
				if(obj.value=="1"){
						var option =new Option("11-事前","11");  
           iPromptType.add(option); 
           
					 var option =new Option("13-事后","13");  
           iPromptType.add(option); 
				}else if(obj.value=="2"){
				
           var option =new Option("13-事后","13");  
           iPromptType.add(option); 
				
				}else if(obj.value=="3"){
				
					 var option =new Option("11-事前","11");  
           iPromptType.add(option); 
           
           var option =new Option("13-事后","13");  
           iPromptType.add(option); 
				
				}
			}
			
							
			/**
			当打印类型为"1,提示"的时候,提示类型:12-事中
			当打印类型为"2,打印"的时候,提示类型:13-事后、2-资费说明
			当打印类型为"3,打印并提示"的时候,提示类型:12-事中
			**/
			function doChangeIsPrint2Select(obj){
				
				var iPromptType = document.getElementById("iPromptType2");
				var ln=iPromptType.length;
				while(ln--)
        {
          iPromptType.options[ln] = null;
        }
        
				if(obj.value=="1"){
					
					 var option =new Option("12-事中","12");  
           iPromptType.add(option); 
				
				}else if(obj.value=="2"){
				
           var option =new Option("13-事后","13");  
           iPromptType.add(option); 
           
           if(document.getElementById("iClassCode").value=="10442"||document.getElementById("iClassCode").value=="10702")
           {
           	//var option =new Option("2-资费说明","2");  
           	//iPromptType.add(option);
           	
           	if(document.getElementById("iClassCode").value=="10702"){
           		iPromptType.value="2";
           		iPromptType.disabled = true;
           	}else{
           		iPromptType.disabled = false;	
           	}
           }
				
				}else if(obj.value=="3"){
				
					 var option =new Option("12-事中","12");  
           iPromptType.add(option); 
				}
				
			}
			
			/**改变发布节点类型触发的事件**/
			function doChangePromNodeType(){
				
				var confirmFlag = document.all.confirmFlag.value;
				document.all.townByRegionTr.style.display = "none";
				var promulgateNodeType = document.all.promulgateNodeType;
				
				if(promulgateNodeType.value=="none"){
					document.getElementById("promulgateNodeFrame").style.display="none";
					return false;
				}
				document.getElementById("promulgateNodeFrame").style.display = "block";
				
				if(promulgateNodeType.value=="0"){
					
					document.promulgateNodeFrame.location = "f9605_getPromNodeByProvince.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
				}
				else if(promulgateNodeType.value=="1"){
					if("<%=groupId%>"=="10014"&&
							confirmFlag=="fieldPromptConfirm"&&
							document.getElementById("iPromptType2").value=="2"&&
							(document.getElementById("iClassCode").value=="10442"||document.getElementById("iClassCode").value=="10702"))
					{
							document.promulgateNodeFrame.location = "f9605_getPromNodeByRegion_all.jsp?root_distance_int=<%=root_distance_int%>";
					}
					else
					{
							document.promulgateNodeFrame.location = "f9605_getPromNodeByRegion.jsp?root_distance_int=<%=root_distance_int%>";
					}
				}else if(promulgateNodeType.value=="2"){
					document.all.townByRegionTr.style.display = "block";
					document.promulgateNodeFrame.location = "f9605_getPromNodeByTown.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
				}
			}
			
			/**发布节点类型是"区县"时,选择"地市"调用的函数**/
			function doChangeTownByRegion(){
				document.promulgateNodeFrame.location = "f9605_getPromNodeByTown.jsp?prom_group_id="+document.all.townByRegionSelect.value+"&root_distance_int=<%=root_distance_int%>";
			}
			
			/**选择代码**/
			function getFieldClassCode(){
				document.getElementById("iClassCodeFrame").style.display = "block";
				document.iClassCodeFrame.location = "f9605_getFieldClassCode.jsp?iClassCode="+jtrim(document.all.iClassCode.value)+"&iClassName="+jtrim(document.all.iClassName.value);
			}
			
			/**过滤字符左右的空格**/
			function jtrim(str){
				if(str==null){
					return "";	
				}
				return str.replace( /^\s*/, "" ).replace( /\s*$/, "" );	
			}
			
			/**提交页面**/
			function doConfirm(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					
					if(jtrim(document.all.sFunctionCode.value)==""){
						rdShowMessageDialog("请填写操作代码!");
						document.all.sFunctionCode.focus();
						return false;
					}
					
					if(document.getElementById("iBillType").value=="none")
					{
						rdShowMessageDialog("请选择票据类型");
						return false
					}
					
					if(document.getElementById("sIsPrint").value=="none")
					{
						rdShowMessageDialog("请选择打印选择");
						return false
					}
					
					if(document.getElementById("iPromptType").value=="none")
					{
						rdShowMessageDialog("请选择提示类型");
						return false
					}
					
				  if(document.getElementById("Channels_Code").value=="none")
					{
						rdShowMessageDialog("请选择渠道类型");
						return false
					}
					
					//验证生效时间与失效时间
					if(jtrim(document.all.sValidTime.value)==""){
						rdShowMessageDialog("生效时间不能为空!");
						return false;
					}
					
					if(parseInt(jtrim(document.all.sValidTime.value))<<%=dateStr%>){
						rdShowMessageDialog("生效时间不能小于当前时间!");
						return false;						
					}

					if(jtrim(document.all.sInvalidTime.value)==""){
						rdShowMessageDialog("失效时间不能为空!");
						return false;
					}
					
					if(parseInt(jtrim(document.all.sInvalidTime.value))<<%=dateStr%>){
						rdShowMessageDialog("失效时间不能小于当前时间!");
						return false;						
					}
					
					chkTime(parseInt(jtrim(document.all.sInvalidTime.value)),parseInt(jtrim(document.all.sValidTime.value)));				
										
					if(document.getElementById("sPromptContent").value=="")
					{
						rdShowMessageDialog("请输入提示内容");
						document.getElementById("sPromptContent").focus();
						return false;
					}
					
					if(document.getElementById("sPromptContent").value.length>512)
					{
						rdShowMessageDialog("提示内容长度有误,不能大于512字！");
						return false;
					}					
					
					if(document.all.sGroupId.value==""){
							rdShowMessageDialog("请选择发布区域!");
							return false;
					}
					
					if(document.all.sAuditLogins.value == ""){
							rdShowMessageDialog("请选择审批人,审批人至少需要一人!");
							return false;							
					}
				}
				
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					
					if(jtrim(document.all.iClassCode.value)==""){
						rdShowMessageDialog("请填写代码!");
						document.all.iClassCode.focus();
						return false						
					}
					
					if(document.getElementById("sClassValue").value=="")
					{
						rdShowMessageDialog("请输入字段域值");
						document.getElementById("sClassValue").focus();
						return false
					}
					
					//客户:建议根据业务增加界面加提醒功能：当选择按资费模板代码进行增加时，
					//因资费代码均为８位，当字段域值输入少于８位时，给予提醒！
					/*产品改造yanpx注释 
					if(document.all.iClassCode.value=="10442"){
						if(jtrim(document.all.sClassValue.value).length!=8){
							rdShowMessageDialog("当选择按资费模板代码进行增加时,字段域值长度应为8位!");
							document.all.sClassValue.focus();
							document.all.sClassValue.select();
							return false;
						}
					}
					*/
					if(document.getElementById("iClassSeq").value=="")
					{
						rdShowMessageDialog("请输入输出顺序");
						document.getElementById("iClassSeq").focus();
						return false
					}
					
						if(document.getElementById("iBillType2").value=="none")
					{
						rdShowMessageDialog("请选择票据类型");
						return false
					}
					
					if(document.getElementById("sIsPrint2").value=="none")
					{
						rdShowMessageDialog("请选择打印选择");
						return false
					}
					
					if(document.getElementById("iPromptType2").value=="none")
					{
						rdShowMessageDialog("请选择提示类型");
						return false
					}
										
					if(document.getElementById("Channels_Code2").value=="none")
					{
						rdShowMessageDialog("请选择渠道类型");
						return false
					}
					
					if(jtrim(document.all.sFunctionCode2.value)==""){
						rdShowMessageDialog("请填写操作代码!");
						document.all.sFunctionCode2.focus();
						return false;
					}
					
					/**根据业务增加的,模块代码可以为"ALL"**/
					if(jtrim(document.all.sFunctionCode2.value).toUpperCase()=="ALL"){
						/**服务要求传入的必须是大写的"ALL",防止页面传入的不是大写**/
						document.all.sFunctionCode2.value = jtrim(document.all.sFunctionCode2.value).toUpperCase();
					}
					
					//验证生效时间与失效时间
					if(jtrim(document.all.sValidTime2.value)==""){
						rdShowMessageDialog("生效时间不能为空!");
						return false;
					}
					
					if(parseInt(jtrim(document.all.sValidTime2.value))<<%=dateStr%>){
						rdShowMessageDialog("生效时间不能小于当前时间!");
						return false;						
					}

					if(jtrim(document.all.sInvalidTime2.value)==""){
						rdShowMessageDialog("失效时间不能为空!");
						return false;
					}
					
					if(parseInt(jtrim(document.all.sInvalidTime2.value))<<%=dateStr%>){
						rdShowMessageDialog("失效时间不能小于当前时间!");
						return false;						
					}
					
					chkTime(parseInt(jtrim(document.all.sInvalidTime2.value)),parseInt(jtrim(document.all.sValidTime2.value)));				
					
					if(jtrim(document.all.sPromptContent2.value)=="")
					{
						rdShowMessageDialog("请输入提示内容");
						document.all.sPromptContent2.focus();
						return false;
					}
					
					if(document.all.sPromptContent2.value.length>512)
					{
						rdShowMessageDialog("提示内容长度有误,不能大于512字！");
						return false;
					}
					
					if(document.all.sGroupId.value==""){
							rdShowMessageDialog("请选择发布区域!");
							return false;
					}
					
					if(document.all.sAuditLogins.value == ""){
							rdShowMessageDialog("请选择审批人,审批人至少需要一人!");
							return false;							
					}
				}
				
				var confirmFlag = rdShowConfirmDialog("确认要提交操作吗?");
				if(confirmFlag!=1){
					return false;
				}
				
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					/**传递如下参数,用来解决disabled不能传值问题**/
					var iPromptType = document.all.iPromptType.value;
					var sValidFlag = document.all.sValidFlag.value;
					var sCreateLogin = document.all.sCreateLogin.value;
					var sCreateTime = document.all.sCreateTime.value;

					document.frm.action = "f9605_oprCfm.jsp?iPromptType="+iPromptType+"&sValidFlag="+sValidFlag+"&sCreateLogin="+sCreateLogin+"&sCreateTime="+sCreateTime;
					document.frm.submit();					
				} 
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					/**传递如下参数,用来解决disabled不能传值问题**/
					var iPromptType2 = document.all.iPromptType2.value;
					var sValidFlag2 = document.all.sValidFlag2.value;
					var sCreateLogin2 = document.all.sCreateLogin2.value;
					var sCreateTime2 = document.all.sCreateTime2.value;
					var sIsByValue = document.all.sIsByValue.value;
					var sIsPrint2 = document.all.sIsPrint2.value;
					
					document.frm.action = "f9605_fieldCfm.jsp?iPromptType2="+iPromptType2+"&sValidFlag2="+sValidFlag2+"&sCreateLogin2="+sCreateLogin2+"&sCreateTime2="+sCreateTime2+"&sIsByValue="+sIsByValue+"&sIsPrint2="+sIsPrint2;
					document.frm.submit();
				}
			}
			
			/**重置页面**/
			function doReset(){
				//在"重置"页面时,利用confirmFlag这个标志自动跳转到重置前的那个页面
				window.location.href = "f9605_1.jsp?confirmFlag="+document.all.confirmFlag.value;
			}
			
			/**关闭页面**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
			}
			
			function chkTime(time1,time2)
			{
				if(parseInt(time2.value)<=parseInt(time1.value))
				{
					time2.select();
					rdShowMessageDialog("失效时间应大于生效时间");
					return;
				}
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

<body>
	<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>
		
		<input type="hidden" name="confirmFlag" value="oprPromptConfirm">
		
		<div class="title">
			<div id="title_zi">请选择操作类型</div>
		</div>
		
		<!--切换标签,如果有更合适的标签,,可以替换-->
		 <table cellSpacing="0">
		 	<tr>
		 		<td>
					<div id="tabsJ">
						<ul id="guidanceUl">
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>根据界面增加</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>根据业务增加</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>

		<!--
	   <table cellSpacing="0">
			<tr height=20 background="../../images/jl_background_4.gif" style="height=100%">
				<td  style="height=100%" width="5%" nowrap>
					<a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showOprInfo()" value="1">&nbsp;&nbsp;<font id="font1" color="3366cc">根据界面增加&nbsp;&nbsp;</font></a>
				</td>            
	 			<td  width="5%" nowrap>
					<a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabdisp" href="javascript:onclick=showFieldInfo()" value="1">&nbsp;&nbsp;<font id="font2" color="">根据业务增加&nbsp;&nbsp;</font></a>
				</td> 
				<td width="90%">&nbsp;</td>
			</tr>
		</table>
		-->
	
		<!--
		/*@service information
			 *@name						s9605Cfm1
			 *@description				注意事项增加
			 *@author					lugz
			 *@created	2008-10-07 17:13:21
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
			 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
			 *@inparam	opCode			功能代码	
			 *@inparam	loginNo			操作工号
			 *@inparam	loginPasswd		经过加密的工号密码
			 *@inparam	opNote			操作备注
			 *@inparam	ipAddr			IP地址
			 
			 
			 *@inparam	sFunctionCode	提示操作功能
			 *@inparam	iBillType	票据类型
			 *@inparam	iPromptType	提示类型
			 *@inparam	iPromptSeq	提示序号
			 *@inparam	sReleaseGroup 发布来源
			 *@inparam	iReleaseAction 发布动作类型
			 *@inparam	sPromptContent	提示内容
			 *@inparam	sIsPrint	是否打印
			 *@inparam	sValidFlag	有效标志
			 *@inparam	sCreateLogin	创建工号
			 *@inparam	sCreateTime	创建时间
			 *@inparam	sGroupId		发布节点
			 *@inparam	sValidTime 生效时间
			 *@inparam	sInvalidTime 失效时间
			 *@output parameter information
			 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
			 *@return SVR_ERR_NO 
			 */
		-->
		<div id="oprDiv" style="display:block">
			<!--发布动作类型,1,发布,2,收回,3,更新-->
			<input type="hidden" name="iReleaseAction" value="1">
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>操作代码</td>
					<td width="35%">
						<input type="text" name="sFunctionCode" value="">&nbsp;&nbsp;
						<input name="" type="button" class="b_text" style="cursor:hand" onClick="getFucntionInfo()" value="获取">&nbsp;
						<input name=""  type="button" class="b_text" style="cursor:hand" onClick="doClearFunctionInput()" value="清除">
					</td>
					<td width="15%" class="blue" nowrap>操作名称</td>
					<td>
						<input type="text" name="sFunctionName" value="">&nbsp;<font class="orange">(匹配模糊查询)</font>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>票据类型</td>
					<td>
						<select name="iBillType">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
					<td class="blue">打印选择</td>
					<td>
						<select name="sIsPrint" onchange="doChangeIsPrintSelect(this)">
							<option value="none" selected>请选择</option>
							<option value="1">提示</option>
							<option value="2">打印</option>
							<option value="3">打印并提示</option>
						</select>
					</td>	
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>提示类型</td>
					<td>
						<select name="iPromptType">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select prompt_type,prompt_type||'->'||prompt_name from sFuncPromptType where prompt_type = '11' or prompt_type = '10' or prompt_type = '13'order by prompt_type desc</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
					<td class="blue">有效标志</td>
					<td>
						<select name="sValidFlag" disabled>
							<option value="Y" selected>有效</option>
							<option value="N">无效</option>
						</select>
					</td>	
				</tr>
				<tr>
					<td class="blue">发布机构</td>
					<td >
						<input type="text" name="sReleaseGroupName" value="<%=sReleaseGroupName%>" disabled>
						<input type="hidden" name="sReleaseGroup" value="<%=groupId%>">
					</td>
					<td  class="blue" nowrap>渠道类型</td>
					<td >
						<select name="Channels_Code">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql><%=sqlChn%></wtc:sql>
							</wtc:qoption>
						</select>						
					</td>			
				</tr>
				<tr>
					<td class="blue">创建工号</td>
					<td><input type="text" name="sCreateLogin" value="<%=workNo%>" disabled></td>
					<td class="blue">创建时间</td>
					<td><input type="text" name="sCreateTime" value="<%=dateStr1%>" disabled></td>
				</tr>
				<tr>
					<td class="blue">生效时间</td>
					<td><input type="text" name="sValidTime" value="<%=dateStr%>" maxlength="8" onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;"></td>
					<td class="blue">失效时间</td>
					<td><input type="text" onblur="chkTime(document.getElementById('sValidTime'),document.getElementById('sInvalidTime'))" name="sInvalidTime" value="20500101" maxlength="8" onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;"></td>
				</tr>
				<tr>
					<td class="blue">提示内容</td>
					<td colspan="3">
						<textarea name="sPromptContent" rows="8" cols="75"></textarea>&nbsp;(最多512字)
					</td>
				</tr>	
			</table>
		</div>
		
		<!--
			/*@service information
			 *@name						s9605Cfm2
			 *@description				注意事项增加
			 *@author					lugz
			 *@created	2008-10-8 13:01:58
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
			 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
			 *@inparam	opCode			功能代码	
			 *@inparam	loginNo			操作工号
			 *@inparam	loginPasswd		经过加密的工号密码
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
			 *@inparam	sReleaseGroup 发布来源
			 *@inparam	iReleaseAction 发布动作类型
			 *@inparam	sGroupId		发布节点
			 *@inparam	sPromptContent	提示内容
			 *@inparam	sIsPrint	是否打印
			 *@inparam	sValidFlag	有效标志
			 *@inparam	sCreateLogin	创建工号
			 *@inparam	sCreateTime	创建时间
			 *@inparam	sValidTime 生效时间
			 *@inparam	sInvalidTime 失效时间
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
						<input type="text" name="iClassCode" value="" onKeyDown="if(event.keyCode==13){getFieldClassCode();}">&nbsp;&nbsp;
						<input name="" type="button" class="b_text" style="cursor:hand" onClick="getFieldClassCode()" value="查询">
					</td>
					<td width="15%" class="blue" nowrap>字段域名称</td>
					<td width="35%">
						<input type="text" name="iClassName" value="" onKeyDown="if(event.keyCode==13){getFieldClassCode();}">&nbsp;<font class="orange">(匹配模糊查询)</font>
					</td>			
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="iClassCodeFrame" align="center" name="iClassCodeFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('iClassCodeFrame').style.height=iClassCodeFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td class="blue">字段域值</td>
					<td>
						<input type="text" name="sClassValue" value="">
					</td>
					<td width="15%" class="blue">输出顺序</td>
					<td>
						<input type="text" name="iClassSeq" value="" readonly >
					</td>
				</tr>
				<tr>		
					<td class="blue">票据类型</td>
					<td>
						<select name="iBillType2">
							<!--<option value="none" selected>请选择</option>-->
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
					<td class="blue">打印选择</td>
					<td>
						<select name="sIsPrint2" onchange="doChangeIsPrint2Select(this)">
							<option value="none" selected>请选择</option>
							<option value="1">提示</option>
							<option value="2">打印</option>
							<option value="3">打印并提示</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>提示类型</td>
					<td >
						<select name="iPromptType2">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select prompt_type,prompt_type||'->'||prompt_name from sFuncPromptType where prompt_type = '12' or prompt_type = '10' order by prompt_type desc</wtc:sql>
							</wtc:qoption>
						</select>						
					</td>
						<td width="15%" class="blue" nowrap>渠道类型</td>
					<td >
						<select name="Channels_Code2">
							<option value="none" selected>请选择</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql><%=sqlChn%></wtc:sql>
							</wtc:qoption>
						</select>						
					</td>			
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>操作代码</td>
					<td>
						<input type="text" name="sFunctionCode2" value="">&nbsp;&nbsp;
						<input name="" type="button" class="b_text" style="cursor:hand" onClick="getFucntionInfo2()" value="获取">&nbsp;
						<input name="clearBtn" id="clearBtn"  type="button" class="b_text" style="cursor:hand" onClick="doClearFunctionInput2()" value="清除">
					</td>
					<td width="15%" class="blue" nowrap>操作名称</td>
					<td>
						<input type="text" name="sFunctionName2" value="">&nbsp;<font class="orange">(匹配模糊查询)</font>
					</td>	
				</tr>
				<tr>
					<td class="blue">生效时间</td>
					<td><input type="text" name="sValidTime2" value="<%=dateStr%>" maxlength="8" onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;"></td>
					<td class="blue">失效时间</td>
					<td><input type="text"  onblur="chkTime(document.getElementById('sValidTime2'),document.getElementById('sInvalidTime2'))" name="sInvalidTime2" value="20500101" maxlength="8" onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;"></td>
				</tr>
				<tr>					
					<td class="blue">是否按照代码提示</td>
					<td>
						<select name="sIsByValue" disabled>
							<option value="Y" selected>是</option>
							<option value="N">否</option>
						</select>							
					</td>		
					<td class="blue">有效标志</td>
					<td>
						<select name="sValidFlag2" disabled>
							<option value="Y" selected>有效</option>
							<option value="N">无效</option>
						</select>
					</td>	
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>发布动作类型</td>
					<td>
						<select name="iReleaseAction2" disabled>
							<option value="1" selected>发布</option>
							<option value="2">收回</option>
							<option value="3">更新</option>
						</select>	
					</td>					
					<td class="blue">发布机构</td>
					<td>
						<input type="text" name="sReleaseGroupName2" value="<%=sReleaseGroupName%>" disabled>
						<input type="hidden" name="sReleaseGroup2" value="<%=groupId%>">
					</td>
				</tr>
				<tr>
					<td class="blue">创建工号</td>
					<td><input type="text" name="sCreateLogin2" value="<%=workNo%>" disabled></td>
					<td class="blue">创建时间</td>
					<td><input type="text" name="sCreateTime2" value="<%=dateStr1%>" disabled></td>
				</tr>
				<tr>
					<td class="blue">提示内容</td>
					<td colspan="3">
						<textarea name="sPromptContent2" rows="8" cols="75"></textarea>&nbsp;<font class="orange">(最多512字)</font>
					</td>
				</tr>	
			</table>
		</div>
		
		<!--以下为"根据界面增加"和"根据业务增加"的公共部分-->
		<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>发布区域类型</td>
					<td>
						<select name="promulgateNodeType" onchange="doChangePromNodeType()">
							<option value="none" selected>请选择</option>
							<%
							if(root_distance_int==1)
							{
							%>
							<option value="0">省</option>
							<option value="1">地市</option>
							<%}
							if(root_distance_int==2)
							{
							%>
							<option value="1">地市</option>
							<option value="2">区县</option>
							<%}
							if(root_distance_int>2)
							{
							%>
							<option value="2">区县</option>
						</select>		
							<%}%>
					</td>
				</tr>
				<tr id="townByRegionTr" style="display:none">
					<td width="15%" class="blue">请选择地市</td>
					<td>
						<select name="townByRegionSelect" onchange="doChangeTownByRegion()">
						<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>select group_id,group_id||'->'||group_name from dChnGroupMsg where group_id in (select parent_group_id from dChnGroupInfo  where group_id = '<%=groupId%>' ) and ROOT_DISTANCE = 2</wtc:sql>
						</wtc:qoption>
						</select> 
					</td>
				</tr>
				<tr>
					<td colspan="2" style="height:0;">
						<iframe frameBorder="0" id="promulgateNodeFrame" align="center" name="promulgateNodeFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('promulgateNodeFrame').style.height=promulgateNodeFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>已选的发布区域</td>
					<td>
						<textarea name="sGroupInfo" rows="5" cols="75" readonly></textarea>
						<input type="hidden" name="sGroupId" value="">
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>请选择审批人</td>
					<td>
						<iframe frameBorder="0" src="f9605_getAuditLoginInfo.jsp?createLoginNo=<%=workNo%>" id="sAuditLoginInfoFrame" align="center" name="sAuditLoginInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1;"  onload="document.getElementById('sAuditLoginInfoFrame').style.height=sAuditLoginInfoFrame.document.body.scrollHeight+'px'"></iframe>
						<input type="hidden" name="sAuditLogins" value="">
					</td>
				</tr>
				<tr>
					<td class="blue" nowrap>操作备注</td>
					<td><input type="text" name="opNote" value="" size="90" maxlength="60"></td>
				</tr>
		</table>
		
		<!--以下为操作部分-->
		<table cellspacing="0">
      <tr> 
        <td id="footer"> 
           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()" >&nbsp;
           <input type="button" name="confirmButton" class="b_foot" value="确定" style="cursor:hand;" onClick="doConfirm()" >&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()" >&nbsp;
        </td>
      </tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %> 
	</form>
</body>
</html>
