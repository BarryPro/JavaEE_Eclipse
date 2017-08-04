<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "8676";
 		String opName = "随e行G3笔记本绑定关系查询";
 		
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
		/**如果工号的级别比区县更小,则不能进行修改操作;1.判断工号的级别,如果root_distance==1,省级,==2,地市,==3,区县,>3,营业厅或更小的级别**/
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
%>
<html>
	<head>
	<title>黑龙江BOSS-随e行G3笔记本绑定关系查询</title>
	<!--调用js库-->
	<script language="javascript">
		<!--

				
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
			
			/**点击"查询"按钮产生的事件**/
			function doQuery(){
				var phoneNo = "";
				var imeiNo = "";

				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					phoneNo = jtrim(document.all.phoneNo.value);
					
					if(phoneNo==""||phoneNo.length==0){
						rdShowMessageDialog("手机号码不能为空!");
						return;							
					}
	
					if(phoneNo.length!=11){
						rdShowMessageDialog("您输入的手机号码长度有误!");
						return;							
					}
	
					if(!checkElement(document.all.phoneNo)){
						document.frm.phoneNo.value = "";
						return;
					}
							
					document.frm.queryButton.disabled = true;
					document.frm.phoneNo.disabled = true;
				
					document.getElementById("qryOprInfoFrame").style.display="block";
					document.qryOprInfoFrame.location.href = "f8676_2.jsp?phoneNo="+phoneNo+"&imeiNo"+imeiNo+"&rootDistance=<%=loginRootDistance%>";
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					imeiNo = jtrim(document.all.imeiNo.value);
					
					if(imeiNo==""||imeiNo.length==0){
						rdShowMessageDialog("IMEI码不能为空!");
						return;							
					}
	
					if(!checkElement(document.all.imeiNo)){
						document.frm.imeiNo.value = "";
						return;
					}
					
					document.frm.queryButton.disabled = true;
					document.frm.phoneNo.disabled = true;
					
					document.getElementById("qryFieldInfoFrame").style.display = "block";
					document.qryFieldInfoFrame.location.href = "f8676_3.jsp?imeiNo="+imeiNo+"&phoneNo"+phoneNo+"&rootDistance=<%=loginRootDistance%>";						
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
				window.location.href = "f8676_1.jsp?confirmFlag="+document.all.confirmFlag.value;
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
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>根据客户手机号码查询</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>根据笔记本IMEI码查询</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>

		<div id="oprDiv" style="display:block">
			<table cellspacing="0" align="center">
				<tr>
					<td width="15%" class="blue" nowrap>请输入手机号码</td>
					<td width="35%">
						<input type="text" name="phoneNo" value="" onKeyDown="if(event.keyCode==13){doQuery();}">&nbsp;
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

		<div id="fieldDiv" style="display:none">
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>请输入笔记本IMEI码</td>
					<td width="35%">
						<input type="text" name="imeiNo" value="">&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
							<iframe frameBorder="0" id="iClassCodeFrame" align="center" name="iClassCodeFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('iClassCodeFrame').style.height=iClassCodeFrame.document.body.scrollHeight+'px'"></iframe>
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
           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()">&nbsp;
        </td>
      </tr>
     </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
