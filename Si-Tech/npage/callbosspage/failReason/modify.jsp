<%
   /*
   * 功能: 失败原因修改
   * 版本: 1.0.0
   * 日期: 
   * 作者: 
   * 版权: sitech
   * update: liujied 0716 客服调试
   * 1.修改页面title:外呼失败原因 改为 失败原因
   * 2.规范样式的调整
   * 3.对失败原因页面做了修改
   * 4.屏蔽掉System.out.println()
   */	
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String id=request.getParameter("id");
//System.out.println("xxxxxx: "+id);
String sqltotal="select s.failure_code,s.failure_name from scalloutfailreson s WHERE s.failure_code =:id" ;
myParams = "id="+id ;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
	<wtc:param value="<%=sqltotal%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="totalPlan" start="0" length="2" scope="end"/>	
<html>
<head>
<title>失败原因修改</title>
<style>
.content_02
{
	font-size:12px;
}
#tabtit
{
	height:23px;
	padding:0px 0 0 12px;
} 
#tabtit ul
{
	height:23px;
	position:absolute;
} 
#tabtit ul li
{
	float:left;
	margin-right:2px;
	display:inline;
	text-align:center;
	padding-top:7px;
	cursor:pointer;
	height:22px;
	width:100px;
}
#tabtit .normaltab
{
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit .hovertab 
{ 
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(../../../../nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
	padding:8px 12px;
}
.undis
{
	display:none;
}
.content_02 .dis li
{
	line-height:1.8em;
	padding-left:12px;
}
</style>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
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
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}

%>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script>

function doProcessAddQcContent(packet)
{
	   var retType = packet.data.findValueByName("retType");
	   var retCode = packet.data.findValueByName("retCode");
	   var retMsg = packet.data.findValueByName("retMsg");
   		if(retCode=="000000"){
    			rdShowMessageDialog("修改成功",'2');
          window.opener.location.href=window.opener.location.href;
          window.close();
	   	}else{
	   		rdShowMessageDialog("修改失败");
	   		return false;
	   	}   

}
 
  function submitInputCheck(){
   if( document.sitechform.code.value == ""){
    	   showTip(document.sitechform.code,"错误类型不能为空"); 
    	   sitechform.code.focus(); 	
    	 return false;
    }
    if(isNaN(document.sitechform.code.value)){
    		showTip(document.sitechform.code,"错误类型只能是数字"); 
    	   sitechform.code.focus(); 	
    	   return false;
    	}
     if(document.sitechform.name.value == ""){
		     showTip(document.sitechform.name,"错误名称不能为空"); 
    	   sitechform.name.focus(); 	
    	   return false;
    }
    submitQcContent();
    	
}
  
function submitQcContent()
{

  var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/failReason/update.jsp","请稍后...");
  
       //本页变量

 var id = document.getElementById("code").value;
 var phone = document.getElementById("name").value;
 
 chkPacket.data.add("code", id);
 chkPacket.data.add("name", phone);

    core.ajax.sendPacket(chkPacket,doProcessAddQcContent,true);
	  chkPacket =null;
}
		
	function g(o)
{
	return document.getElementById(o);
}

function HoverLi(n){
	for(var i=1;i<=2;i++)
	{

		g('tb_'+i).className='normaltab';
		g('tbc_0'+i).className='undis';
	}
	g('tbc_0'+n).className='dis';
	g('tb_'+n).className='hovertab';
}
function closeWin()
{
  window.close();
}

</script>

</head>
<body>

<form  name="sitechform" id="sitechform">
<!--{--><!--失败原因原来部分-->
<!--
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>失败原因</B></div>
    <div id="Operation_Table">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	
    	<input type="hidden" name="id" value="<%=totalPlan[0][0]%>">
     <tr>
      	<td width="16%" class="blue">错误类型</td>
        <td width="34%" >
        <input name="code"  id="code" type="text" readOnly size='5' maxlength='5' value="<%=totalPlan[0][0]%>" >  
        </td>

     </tr>
     <tr>
      	<td width="16%" class="blue">错误名称</td>
        <td width="34%" >
        <input name="name"  id="name" type="text" size='40' maxlength='40' value="<%=totalPlan[0][1]%>" >  
        </td>

     </tr>

      </table>

 

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submita" type="button" value="确认" onclick="submitInputCheck()">
        	<input class="b_foot" name="reset1" type="button"  onclick="window.close()" value="退出">
        </td>
       </tr>  
     </table>
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>

-->
<!--}-->
<!--{--><!--替换部分-->
<div id="Operation_Table">
		<div class="title"><div id="title_zi">失败原因修改</div></div>
		<table>
		  <tr>
  		    <td class="blue">错误类型</td>
  		    <td width="34%">
  		      <input id="code" name="code" size="20" maxlength="6" type="text" readonly value="<%=totalPlan[0][0]%>">
                        
	  	      </td>
		    </tr>
		  <tr>
  		    <td class="blue">错误名称</td>
  		    <td width="70%">
                      <input id="name" name="name" size="20" type="text" maxlength="40"  value="<%=totalPlan[0][1]%>">
	  	      </td>
		    </tr>
		    
		  <tr >
  		    <td colspan="2" align="center" id="footer">
   		      <input name="submita" type="button" class="b_text" id="btn_internalcall" value="确认" onClick="submitInputCheck()">
   			<input name="reset1" type="button" class="b_text" id="close" value="退出" onClick="closeWin()">
  			  </td>
			</tr>
		      </table>
	            </div>

<!--}-->
</form>
</body>
</html>
 
