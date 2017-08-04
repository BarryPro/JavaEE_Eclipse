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
    
 		String opCode = "9648";
 		String opName = "注意事项库查询";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		String accountType = (String)session.getAttribute("accountType"); /*取工号类型 2为客服工号*/
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
		
		StringBuffer  sql = new StringBuffer();
		if(loginRootDistance==1||("2".equals(accountType)))
		{
			sql.append("select region_code,to_char(region_code)||'->'||region_name from sregioncode ");
			sql.append(" where region_code<='13' order by region_code   ");
			System.out.println("sql====="+sql);
		}
		else
		{
			sql.append("select region_code,to_char(region_code)||'->'||region_name from sregioncode ");
			sql.append(" where region_code<='13' and group_id='"+groupId+"' order by region_code   ");
			System.out.println("sql====="+sql);
		}
%>

<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<html>
<head>
<title>黑龙江BOSS-注意事项库查询</title>
<script language="javascript">
<!--

onload=function()
{	
	if(<%=loginRootDistance%>==1)
	{
		
	}
}

/**显示"根据界面查询"**/
function showOprInfo(){
	doReset();
	oprDiv.style.display="block";
	fieldDiv.style.display="none";
	billDiv.style.display="none";
	document.all.confirmFlag.value="oprPromptConfirm";
	document.getElementById("qryFieldInfoFrame").style.display = "none";
	document.getElementById("qryBillInfoFrame").style.display = "none";
}

/**显示"根据业务查询"**/
function showFieldInfo(){
	doReset();
	oprDiv.style.display="none";
	fieldDiv.style.display="block";
	billDiv.style.display="none";
	document.all.confirmFlag.value="fieldPromptConfirm";
	document.getElementById("qryOprInfoFrame").style.display="none";
	document.getElementById("qryBillInfoFrame").style.display = "none";
}

/**显示"根据资费说明查询"**/
function showBillInfo()
{
	doReset();
	oprDiv.style.display="none";
	fieldDiv.style.display="none";
	billDiv.style.display="block";
	document.all.confirmFlag.value="billPromptConfirm";
	document.getElementById("qryOprInfoFrame").style.display="none";
	document.getElementById("qryFieldInfoFrame").style.display = "none";
}

/**点击切换标签调用事件**/
function showMessage(flag){
	var guidanceUl=document.getElementById("guidanceUl");
	for(var i=0;i<guidanceUl.childNodes.length;i++){
		guidanceUl.childNodes[i].className="";
	}
	eval("document.getElementById('li"+flag+"')").className="current";	
	if(flag==1){
		//根据界面查询
		showOprInfo();
	}else if(flag==2){
		//根据业务查询
		showFieldInfo();
	}else if(flag==3){
		//根据资费说明查询
		showBillInfo();
	}
}		
			
/**开始查询**/
function doQuery()
{	
	if(document.all.confirmFlag.value=="oprPromptConfirm")
	{
		
		var op_code1 = document.all.op_code1.value;
		var op_time_begin1 = document.all.op_time_begin1.value;
		var op_time_end1 = document.all.op_time_end1.value;
		var region_code1 = document.all.region_code1.value;
		
		if(document.all.region_code1.length<3)
		{
			if(region_code1=="")
			{
				rdShowMessageDialog("省市标志不能为空！");
				return;
			}
		}
		
		document.getElementById("qryOprInfoFrame").style.display="block"; 
		document.qryOprInfoFrame.location = "f9648_get1.jsp?op_code1="+op_code1+"&op_time_begin1="+op_time_begin1+"&op_time_end1="+op_time_end1+"&region_code1="+region_code1;
	}
	
	if(document.all.confirmFlag.value=="fieldPromptConfirm")
	{
		var class_code2 = document.all.class_code2.value;
		var class_value2 = document.all.class_value2.value;
		var region_code2 = document.all.region_code2.value;

		if(document.all.region_code2.length<3)
		{
			if(region_code2=="")
			{
				rdShowMessageDialog("省市标志不能为空！");
				return;
			}
		}
		
		document.getElementById("qryFieldInfoFrame").style.display = "block";
		document.qryFieldInfoFrame.location = "f9648_get2.jsp?class_code2="+class_code2+"&class_value2="+class_value2+"&region_code2="+region_code2;					
	}
	
	if(document.all.confirmFlag.value=="billPromptConfirm")
	{
		var bill_code3 = document.all.bill_code3.value;
		var power_right3 = document.all.power_right3.value;
		var region_code3 = document.all.region_code3.value;

		if(document.all.region_code3.length<3)
		{
			if(region_code3=="")
			{
				rdShowMessageDialog("省市标志不能为空！");
				return;
			}
		}
		
		document.getElementById("qryBillInfoFrame").style.display = "block";
		document.qryBillInfoFrame.location = "f9648_get3.jsp?bill_code3="+bill_code3+"&power_right3="+power_right3+"&region_code3="+region_code3;					
	}
}
			
/**重置页面**/
function doReset(){
	//因为document.all.confirmFlag.value随着切换拥有不同的值
	//如果frm.reset(),则容易错误.
	//可废弃以下的代码,修改成:window.location.reload()或者window.location.href="xxxx"
	var e = document.forms[0].elements;
	for(var i=0;i<e.length;i++){
	  if(e[i].type=="select-one"){
	  	e[i].value="";
	  	e[i].disabled=false;
	  }
	  if(e[i].type=="text"&&e[i].name!="confirmFlag"){
	  	e[i].value="";
	  	e[i].disabled=false;
	  }
	}
	
	//隐藏所有的显示的iframe
	var iframes = document.getElementsByTagName("iframe");
	for(var i=0;i<iframes.length;i++){
		iframes[i].style.display = "none";	
	}
}
			
/**关闭页面**/
function doClose()
{
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
						<li id="li1" class="current"><a onclick="showMessage(1)"><span>根据界面查询</span></a></li>
						<li id="li2"><a onclick="showMessage(2)"><span>根据业务查询</span></a></li>
						<li id="li3"><a onclick="showMessage(3)"><span>根据资费说明查询</span></a></li>
					</ul>
				</div>
			</td>
		</tr>
	</table>
	
	<!--
		/*@service information
		 *@name						s9648
		 *@description		根据界面查询
		 *@author					dujl
		 *@created	2009-05-29 
		 *@version %I%, %G%
		 *@since 1.00
		 *@return SVR_ERR_NO 
		 */
	-->
	<div id="oprDiv" style="display:block">
		<table cellspacing="0">
			<tr>
				<td width="13%" class="blue" nowrap>操作代码</td>
				<td width="33%">
					<input type="text" name="op_code1" id="op_code1"  size="18" value="">
				</td>
				<td width="13%" class="blue" nowrap>操作时间</td>
				<td>
					<input type="text" name="op_time_begin1" id="op_time_begin1" size="10" value="">&nbsp;-&nbsp;
					<input type="text" name="op_time_end1" size="10" value="">
					<font class="orange"><span>(格式：yyyymmdd)</span>
				</td>
			</tr>
			<tr>
				<td width="13%" class="blue" nowrap>省市标志</td>
				<td width="33%">
					<select name="region_code1">
						<option value="" selected>请选择</option>
						<%for (int i = 0; i < result.length; i++) {%>
				      		<option value="<%=result[i][0]%>"><%=result[i][1]%>
				      		</option>
				    	<%}%>
					</select>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<table cellSpacing="0">
	      <tr> 
	        <td id="footer"> 
	           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()">&nbsp;
	           <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doQuery()">&nbsp;
	           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()">&nbsp;
	        </td>
	      </tr>
	    </table>
	</div>
	<!--
		/*@service information
		 *@name						s9648
		 *@description		根据业务查询
		 *@author					dujl
		 *@created	2009-05-29 
		 *@version %I%, %G%
		 *@since 1.00
		 *@return SVR_ERR_NO 
		 */
	-->
	<div id="fieldDiv" style="display:none">
		<table cellspacing="0">
			</tr>
			<tr>
				<td width="15%" class="blue" nowrap>代码</td>
				<td width="35%">
					<select name="class_code2">
						<option value="" selected>请选择</option>
						<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>select class_code,to_char(class_code)||'->'||class_name from sClass where class_code in (10431,10442,10702)</wtc:sql>
						</wtc:qoption>
					</select>
				</td>
				<td width="15%" class="blue" nowrap>字段域值</td>
				<td width="35%"><input type="text" name="class_value2" value="">&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td width="15%" class="blue" nowrap>省市标志</td>
				<td width="35%">
					<select name="region_code2">
						<option value="" selected>请选择</option>
						<%for (int i = 0; i < result.length; i++) {%>
				      		<option value="<%=result[i][0]%>"><%=result[i][1]%>
				      		</option>
				    	<%}%>
					</select>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>				
		</table>
		<table cellSpacing="0">
	      <tr> 
	        <td id="footer"> 
	           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()">&nbsp;
	           <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doQuery()">&nbsp;
	           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()">&nbsp;
	        </td>
	      </tr>
     	</table>
    	</div>
  <!--
		/*@service information
		 *@name						s9648
		 *@description		根据资费说明查询
		 *@author					dujl
		 *@created	2009-05-29 
		 *@version %I%, %G%
		 *@since 1.00
		 *@return SVR_ERR_NO 
		 */
	-->
   <div id="billDiv" style="display:none">
		<table cellspacing="0">
			<tr>
				<td width="15%" class="blue" nowrap>资费代码</td>
				<td width="35%">
					<input type="text" name="bill_code3" value="" size="18">&nbsp;&nbsp;
				</td>
				<td width="15%" class="blue" nowrap>有效标志</td>
				<td width="35%">
					<select name="power_right3">
						<option value="" selected>请选择</option>
						<option value="1">有效</option>
						<option value="99">无效</option>
					</select>	
				</td>
			</tr>
			<tr>
				<td width="15%" class="blue" nowrap>省市标志</td>
				<td width="35%">
					<select name="region_code3">
						<option value="" selected>请选择</option>
						<%for (int i = 0; i < result.length; i++) {%>
				      		<option value="<%=result[i][0]%>"><%=result[i][1]%>
				      		</option>
				    	<%}%>
					</select>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<table cellSpacing="0">
	      <tr> 
	        <td id="footer"> 
	           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()">&nbsp;
	           <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doQuery()">&nbsp;
	           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()">&nbsp;
	        </td>
	      </tr>
     	</table>
    	</div>
    	
 		<table cellspacing="0">
			<tr>
				<td style="height:0;">
					<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
				</td>
			</tr>
			<tr>
				<td style="height:0;">
					<iframe frameBorder="0" id="qryFieldInfoFrame" align="center" name="qryFieldInfoFrame" scrolling="yes" style="height:300px  ;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+50+'px'"></iframe>
				</td>
			</tr>
			<tr>
				<td style="height:0;">
					<iframe frameBorder="0" id="qryBillInfoFrame" align="center" name="qryBillInfoFrame" scrolling="yes" style="height:300px  ;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryBillInfoFrame').style.height=qryBillInfoFrame.document.body.scrollHeight+50+'px'"></iframe>
				</td>
			</tr>
		</table>
		<!--以下为操作部分-->
		<table cellspacing="0">
			<tr>
				<td style="height:0;">
					<iframe frameBorder="0" id="qryOprAuditInfoFrame" align="center" name="qryOprAuditInfoFrame" scrolling="yes" style="height:300px; overflow-x:auto;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
				</td>
			</tr>
			<tr>
				<td style="height:0;">
					<iframe frameBorder="0" id="qryFieldAuditInfoFrame" align="center" name="qryFieldAuditInfoFrame" scrolling="yes" style="height:300px; overflow-x:auto;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+50+'px'"></iframe>
				</td>
			</tr>
			<tr>
				<td style="height:0;">
					<iframe frameBorder="0" id="qryFieldAuditInfoFrame" align="center" name="qryFieldAuditInfoFrame" scrolling="yes" style="height:300px; overflow-x:auto;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryBillInfoFrame').style.height=qryBillInfoFrame.document.body.scrollHeight+50+'px'"></iframe>
				</td>
			</tr>
		</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

