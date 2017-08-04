<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String id=request.getParameter("id");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String params = "id="+id;
String sqltotal="SELECT c.caller_call_out_id,c.Caller_Call_Out_Phone,c.classid,s.class_name,c.Region_Code,c.Region_Code||'-->'||r.Region_Name,c.Note,c.outflag FROM Dcallercalloutphone c ,scallclass s ,scallregioncode r WHERE s.Class_Id = c.Classid AND c.Region_Code = r.Region_Code  AND c.Caller_Call_Out_Id = :id" ;


%>

<wtc:service name="TlsPubSelCrm" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqltotal%>"/>
		<wtc:param value="<%=params%>"/>
</wtc:service>
<wtc:array id="totalPlan" start="0" length="8" scope="end"/>	
<html>
<head>
<title>外呼班组对应关系</title>
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

<%
   String start_date=totalPlan[0][1];
    String end_date=totalPlan[0][2];
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
    			window.sitechform.action="list.jsp";
          window.sitechform.method='post';
          document.sitechform.submit();
	   	}else{
	   		rdShowMessageDialog("修改失败");
	   		return false;
	   	}   

}
 
  function submitInputCheck(){
   if( document.sitechform.phone.value == ""){
    	   showTip(document.sitechform.phone,"呼出号码不能为空"); 
    	   sitechform.phone.focus(); 	
    	 return false;
    }
    if(isNaN(document.sitechform.phone.value)){
    		showTip(document.sitechform.phone,"呼出号码只能是数字"); 
    	   sitechform.phone.focus(); 	
    	   return false;
    	}
     if(document.sitechform.class_id.value == ""){
		     showTip(document.sitechform.class_id,"请选择班组"); 
    	   sitechform.class_id.focus(); 	
    	   return false;
    }
    submitQcContent();
    	
}
  
function submitQcContent()
{
	

	
  var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/callerGroup/update.jsp","请稍后...");

   
       //本页变量

 var id = document.getElementById("id").value;
 var phone = document.getElementById("phone").value;
 var class_id = document.getElementById("class_id").value;
 var Region_Code = document.getElementById("Region_Code").value;
 var note = document.getElementById("note").value;
 var outflag = document.getElementById("outflag").value;
 
 chkPacket.data.add("id", id);
 chkPacket.data.add("phone", phone);
 chkPacket.data.add("class_id", class_id);
 chkPacket.data.add("Region_Code", Region_Code);
 chkPacket.data.add("note", note);
 chkPacket.data.add("outflag", outflag);

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
</script>

</head>
<body>

<form  name="sitechform" id="sitechform">




<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>外呼班组对应关系</B></div>
    <div id="Operation_Table">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	
    	<input type="hidden" name="id" value="<%=totalPlan[0][0]%>">
      <tr>
      	<td width="15%" class="blue">呼出号码</td>
        <td width="15%">
        <input name ="phone" value="<%=totalPlan[0][1]%>" type="text" id="phone" size='22' maxlength='20'>
        	</select> 
        </td>
        <td width=15% class="blue">班组</td>
        <td width="20%">  
       	
        	<select id="class_id" name="class_id" >
         	 <option value="">--请选择--</option>
         	 
         	 		<option value="<%=totalPlan[0][2]%>" selected >
      	 				<%=totalPlan[0][2]%>--><%=totalPlan[0][3]%>
      	 			</option>
         	 
          <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>SELECT class_id,class_id||'-->'||class_name FROM scallclass ORDER BY class_id</wtc:sql>
				  </wtc:qoption>
        	</select>
        </td>
        
         <td width=15% class="blue">地市</td>
        <td width="20%">  
			 <select id="Region_Code" name="Region_Code" size="1" >
      	<option value="" >--所有地市--</option>
      	
      	 	 		<option value="<%=totalPlan[0][4]%>" selected >
      	 				<%=totalPlan[0][5]%>
      	 			</option>
      	
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select Region_Code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y'order by region_code</wtc:sql>
				  </wtc:qoption>
        </select>    
        </td>
      </tr>
       
             <tr>
      	<td width="16%" class="blue">备注</td>
        <td width="34%" colspan='5'>
        <input name="note"  id="note" type="text" size='52' maxlength='50' value="<%=totalPlan[0][6]%>" >  
        </td>

     </tr>
     
      		  <tr>
        <td class="blue" >号码类型</td>
        <td colspan = '5'> 
			 <select id="outflag" name="outflag" size="1" >
      	 	 		<option value="<%=totalPlan[0][7]%>" selected >
      	 				<%=(totalPlan[0][7].equals("Y"))?"呼出号码":"呼入号码"%>
      	 			</option>
      	 			
      	 			
      	 			        <option value="N" >-- 呼入号码 --</option>			 	
      	<option value="Y" >-- 呼出号码 --</option>
        </select>
        </td>  
      </tr>
      </table>


  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr>
         <td width="100%">  
        &nbsp;
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

</form>
</body>
</html>
 





