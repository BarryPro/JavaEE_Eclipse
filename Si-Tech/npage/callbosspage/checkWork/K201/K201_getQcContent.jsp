<%
  /*
   * 功能: 考评项查询
　 * 版本: 1.0
　 * 日期: 2008/11/10
　 * 作者: hanjc 
　 * 版权: sitech
   * 
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%! 
		/** 
		 函数说明: 输入一个基本的sql.然后页面参数模式是  [排序号_=_字段名] 或  [排序号_like_字段名]
		 其中column为查询字段.第一位是排序号.排序号不能重复.重复多个将保存一个值.且必须是数字.大小不限如1,11,123.
		 */ 
        public String returnSql(HttpServletRequest request){
        StringBuffer buffer = new StringBuffer();

		   //输入语句.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
		String value="";
		//将结果保存在这里.key是数字.对数字进行排序.value里面放置object数组存值.
		for (int i = 0; i < objNames.length; i++) {
			name = objNames[i] == null ? "" : objNames[i]
			.toString();
			//String name
			names = name.split("_");
			//将name按照'_'分成3个数组.
			if (names.length >= 3) {
		//如果不能分说明名字不合法.太少区分不了.
		    value = request.getParameter(name);
		//按照名字得到value
		if (value.trim().equals("")) {
			//如果value是""跳过.
			continue;
		}
		Object[] objs = new Object[3];
		objs[0] = names[1];
		//保持 第一个字符串.是like 或是 =
		name = name.substring(name.indexOf("_") + 1);
		name = name.substring(name.indexOf("_") + 1);
		//这地方做数据库的字段处理.第三个'_'以后的都是数据库字段了.
		objs[1] = name;
		//第二个字符串.查询名字.
		objs[2] = value;
		//第三个.查询的值.
	//	System.out.println("~~~~~~~~~~~~~" + objs[0]);
		try {
			temp.put(Integer.valueOf(names[0]), objs);
			//这个地方是将字符串转换成数字.然后进行排序.比如19要在2之后.
		} catch (Exception e) {

		}
		//将排序号码放在key里面,ojbs数组放到value里面.
			}
		}
		Object[] objNos = temp.keySet().toArray();
		//得到一个倒序的数组.
		Arrays.sort(objNos);
		//对数字进行排序.
		for (int i = 0; i < objNos.length; i++) {
			Object[] objs = null;
			objs = (Object[]) temp.get(objNos[i]);
			//下面对like 和 = 分别处理.
			if (objs[0].toString().toLowerCase().equalsIgnoreCase(
			"like")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%"
				+ objs[2].toString().trim() + "%%' ");
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '"
				+ objs[2].toString().trim() + "' ");
			}
		}

        return buffer.toString();
}
    public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>

<%
    String opCode="K201";
    String opName="质检查询-考评项查询";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
		
  	String sqlStr = "select contact_id,contact_accept,caller_phone,callee_phone,cust_name,sm_code,grade_code,region_code,mail_address,fax_no,contact_address,contact_phone,accept_phone,begin_date,end_date,accept_long,accept_login_no,lang_code,statisfy_code,call_cause_id,qc_flag from dcallcall200810";
		String strCountSql="select to_char(count(*)) count  from dcallcall200810";
		String strDateSql="";
    int Temp =0;

    String start_date    =  request.getParameter("start_date");      
    String end_date      =  request.getParameter("end_date");        
    String login_no      =  request.getParameter("0_=_login_no");    
    String be_login_no   =  request.getParameter("1_=_be_login_no"); 
    String op_type       =  request.getParameter("2_=_op_type");     
%>			


<html>
<head>
<title>考评项查询</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K201_evaItemQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}

//清除表单记录
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text")
   e[i].value="";
 }
}


//显示通话详细信息
function getCallDetail(contact_id,start_date){
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    window.open(path,"newwindow","height=768, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

// 给iframemiddle传值并刷新页面
function sendIframemiddleId(selectedItemId){
	//alert(selectedItemId);
	var iframemiddle = window.frames['framemiddle']
	iframemiddle.location.href="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K201/K201_qcContent.jsp?selectedItemId="+selectedItemId;
	//iframemiddle.document.sitechform.selectedItemId.value=selectedItemId;
	//iframemiddle.location.reload();
 }
 
 // 给iframeright传值并刷新页面
function sendIframerightId(content_id,object_id){
	//alert(selectedItemId);
	var iframeright = window.frames['frameright']
	iframeright.location.href="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K201/K201_qcItem.jsp?content_id="+content_id+"&object_id="+object_id;
	//iframemiddle.document.sitechform.selectedItemId.value=selectedItemId;
	//iframeright.location.reload();
 }

//把选取的条件带回父窗口
function setQryCondition(){
	 window.opener.sitechform.beQcObjId.value=window.sitechform.beQcObjId.value;
	 window.opener.sitechform.contentid.value=window.sitechform.beQcContentId.value;
	 window.opener.sitechform.qccheckitemId.value=window.sitechform.beQcItemId.value;
	 window.opener.sitechform.beQcObjName.value=window.sitechform.beQcObjName.value;
	 window.opener.sitechform.qcobjectName.value=window.sitechform.beQcContentName.value;
	 window.opener.sitechform.qccheckitemName.value=window.sitechform.beQcItemName.value;
	 window.close();
}

</script>
</head>


<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table" style="width:100%;">
		<div class="title"><div id="title_zi">考评项查询</div></div>
		<table cellspacing="0" >
      <tr >
       <td > 所选被检对象 
				<input  id="beQcObjName" name="beQcObjName" type="text"  onclick=""   value="">
        所选质检内容
			  <input id="beQcContentName" name ="beQcContentName" type="text" onclick=""   value="">
        所选考评项 
				<input  id="beQcItemName" name="beQcItemName" type="text"  onclick=""   value="">
			</td>
    </tr>
		</table>
	</div>
	<iframe name="frameleft" id="frameleft" marginHeight="0" marginWidth="0" frameborder="1"  scrolling="auto" src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K201/K201_qcTree.jsp" width="30%" height="75%"></iframe>
	<iframe name="framemiddle" id="framemiddle" marginHeight="0" marginWidth="0" frameborder="1" scrolling="auto" src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K201/K201_qcContent.jsp" width="34%" height="75%"></iframe>
	<iframe name="frameright" id="frameright" marginHeight="0" marginWidth="0" frameborder="1" scrolling="auto" src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K201/K201_qcItem.jsp" width="35.5%" height="75%"></iframe>
				<p  align="center" id="footer" style="width:100%">
          <input name="delete_value" type="button"  id="add" value="确定" onClick="setQryCondition();return false;">
          <input name="search" type="button"  id="search" value="取消" onClick="window.close();return false;">
       </p>
  <input  id="beQcObjId" name="beQcObjId" type="hidden"  value="">
	<input id="beQcContentId" name ="beQcContentId" type="hidden"  value="">
	<input  id="beQcItemId" name="beQcItemId" type="hidden"  value="">
</form>
</body>
</html>

