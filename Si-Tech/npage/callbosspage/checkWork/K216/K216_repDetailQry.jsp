<%
   /*
    * 功能: 服务评价报告查询
　 * 版本: 1.0
　 * 日期: 2008/11/10
　 * 作者: hanjc
　 * 版权: sitech
    *  upd :
    *          mixh  2009/03/27
    *          1、变更权限校验
    *
 　*/
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%
	String opCode="K216";
	String opName="质检查询-个人服务评价报告查询";
%>

<%!
	/**
	   *函数说明: 输入一个基本的sql.然后页面参数模式是  [排序号_=_字段名] 或  [排序号_like_字段名]
	   *其中column为查询字段.第一位是排序号.排序号不能重复.重复多个将保存一个值.且必须是数字.大小不限如1,11,123.
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

	String loginNo = (String)session.getAttribute("kfWorkNo");
	String orgCode = (String)session.getAttribute("orgCode");

	String start_date     =  request.getParameter("start_date");
	String end_date       =  request.getParameter("end_date");
	String staffno          =  request.getParameter("staffno");
	String isCheckLogin  = "N";								//是否有权限查看所有业务代表的服务评价报告("Y"有，"N"无)
	String bossLoginNo  = "";

	/*取当前登陆工号的角色ID，为逗号分割的字符串 mixh add 20090327*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	String[]  powerCodeArr = powerCode.split(",");

	
	/*
	 *是否是质检员 测试环境：[0100020I] 生产环境：[01120O0E]，   上线时改一下
	 *是否是复核员 测试环境：[0100020K] 生产环境：[01120O0B]，   上线时改一下
	 *是否是质检组长 测试环境：[0100020J] 生产环境：[01120O0C]，上线时改一下
	 *
	 */
			for(int i = 0; i < powerCodeArr.length; i++){
				for(int j=0; j<ZHIJIANYUAN_ID.length; j++) {
					if(ZHIJIANYUAN_ID[j].equals(powerCodeArr[i]) ||FUHEYUAN_ID.equals(powerCodeArr[i])){
							isCheckLogin="Y";	
					}
				}
				for(int k=0; k<ZHIJIANZUZHANG_ID.length; k++){
					if(ZHIJIANZUZHANG_ID[k].equals(powerCodeArr[i])) {
						isCheckLogin="Y";
					}
				}
			}
%>

<%
    float totalScore = 0;//总分
    float temp = 0;//中间变量
    float fullScore = 0;// 满分
    float integratedScore = 0;//综合得分，默认为满分
    
    if(staffno==null || "".equals(staffno)){
      	staffno =  request.getParameter("1_=_t1.staffno");
    }
    String objectid      =  request.getParameter("objectid");
    
    if(objectid==null || "".equals(objectid)){
      	objectid =  request.getParameter("0_str_t1.object_id");
    }
    String objectTypeName =  request.getParameter("objectTypeName");

	 	String sqlStr = "select "
                +"t1.recordernum,   " //被检流水号
                +"decode(t1.checktype,'0','实时考评','1','事后考评'),   " //考评类别
                +"decode(substr(to_char(trim(t1.score)),0,1),'.','0'||trim(t1.score),t1.score),       " //得分
                +"t1.objectid,t1.contentid,t1.serialnum "
                +"from dqcinfo t1 ";
    String strJoinSql=" and t1.is_del != 'Y' and t1.objectid='"+objectid+"' and  t1.flag<>'0' and t1.flag<>'4' ";
    
    if(staffno!=null || !"".equals(staffno)&&!"Y".equals(isCheckLogin)){
      	strJoinSql+="and t1.staffno='"+staffno+"' ";
    }
		String strDateSql="";
    String sqlLogin="";
    //非话务员可以查看所有的服务评价报告息
    if("Y".equals(isCheckLogin)){

    }else if("N".equals(isCheckLogin)){
    		sqlLogin=" and t1.staffno='"+loginNo+"' ";
  	}

    String[][] dataRows = new String[][]{};
    String action = request.getParameter("myaction");
	  String sqlFilter = request.getParameter("sqlFilter");

	 //查询条件
   if(sqlFilter==null || sqlFilter.trim().length()==0){
			if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
					strDateSql=" where 1=1 and  to_char(t1.starttime,'yyyymmdd hh24:mi:ss')>='"+start_date.trim()+"' and to_char(t1.starttime,'yyyymmdd hh24:mi:ss')<='"+end_date.trim()+"' ";
			}
			sqlFilter=strDateSql+returnSql(request)+strJoinSql+sqlLogin+"and t1.group_flag='0' order by t1.starttime desc ";	//guozw20090907
   }
   String thSqlStr = "select t1.name,t1.object_id,t1.contect_id  from dqccheckcontect t1,dqcobject t2 where t1.object_id='"+objectid+"' and t1.object_id=t2.object_id  and t1.bak1='Y' and t2.bak1='Y' order by t1.object_id";
   %>
   <wtc:service name="s151Select" outnum="3">
			<wtc:param value="<%=thSqlStr%>"/>
	 </wtc:service>
	<wtc:array id="contentName"  scope="end"/>

<%
    sqlStr+=sqlFilter;
%>
    <wtc:service name="s151Select" outnum="6">
				<wtc:param value="<%=sqlStr%>"/>
		</wtc:service>
		<wtc:array id="queryList" scope="end"/>
<%
		dataRows = queryList;
%>
<%
String content_id = "";
if(dataRows!=null&&!("".equals(dataRows))&&dataRows.length>0){
	 content_id = dataRows[0][4];
	 String getHighScoreSql = "select sum(high_score) from dqccheckitem " +
                          	"where object_id='" + objectid +
                          	"' and contect_id='" + content_id +
                          	"' and is_leaf='Y' and is_scored='Y' and bak1='Y' ";
%>
<wtc:service name="s151Select" outnum="3">
		<wtc:param value="<%=getHighScoreSql%>"/>
</wtc:service>
<wtc:array id="sumHighScore" scope="end"/>
<%
	if(sumHighScore!=null&&!("".equals(sumHighScore))){
			fullScore = Integer.parseInt(sumHighScore[0][0]);
			integratedScore = fullScore;
	}
}
%>
<html>
<head>
<title>服务评价报告查询</title>
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

function submitInputCheck(){
   if( document.sitechform.start_date.value == ""){
    	   showTip(document.sitechform.start_date,"开始时间不能为空");
    	   sitechform.start_date.focus();

    }else if(document.sitechform.end_date.value == ""){
		     showTip(document.sitechform.end_date,"结束时间不能为空");
    	   sitechform.end_date.focus();

    }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		     showTip(document.sitechform.end_date,"结束时间必须大于开始时间");
    	   sitechform.end_date.focus();

    }else if(document.sitechform.objectTypeName.value==""){
		     showTip(document.sitechform.objectTypeName,"被检对象不能为空！");
    	   sitechform.objectTypeName.focus();

    }else if(document.sitechform.staffno.value==""){
		     showTip(document.sitechform.staffno,"被检工号不能为空！");
    	   sitechform.staffno.focus();

    }else{
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);
    hiddenTip(document.sitechform.objectTypeName);
    hiddenTip(document.sitechform.staffno);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    submitMe();
    	}
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K216_repDetailQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

//清除表单记录
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
  	if(e[i].id=="start_date"){
	  	e[i].value='<%=getCurrDateStr("00:00:00")%>';
	  }else if(e[i].id=="end_date"){
	  	e[i].value='<%=getCurrDateStr("23:59:59")%>';
	  }else{
	  	e[i].value="";
	  }
  }else if(e[i].type=="checkbox"){
  	e[i].checked=false;
  }
 }
 document.getElementById("groupflag").value = "0";	//个人为0
}

function keepValue(){
	  window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.end_date.value="<%=end_date%>";
    window.sitechform.objectTypeName.value="<%=objectTypeName%>";
    window.sitechform.objectid.value="<%=objectid%>";
    window.sitechform.staffno.value="<%=staffno%>";
}

//被检对象
function showObjectCheckTree(){
   var path= 'K204_objectIdTree.jsp';
   var param  = 'dialogWidth=300px;dialogHeight=250px';
   var returnValue = window.showModalDialog(path,'选择质检群组',param);

	if(typeof(returnValue) != "undefined"){
		 var objectid = document.getElementById("objectid");
		 var objectTypeName   = document.getElementById("objectTypeName");
		 var temp = returnValue.split('_');
		 objectid.value = trim(temp[0]);
		 objectTypeName.value = trim(temp[1]);
	 }
}

//显示质检结果详细信息
function getQcDetail(contact_id){
		var path="../K211/K211_getResultDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
 	  window.showModalDialog(path,'质检结果详情',param);
		return true;
}

function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//去左空格;
function ltrim(s){
  	return s.replace( /^\s*/, "");
}
//去右空格;
function rtrim(s){
		return s.replace( /\s*$/, "");
}
//去左右空格;
function trim(s){
		return rtrim(ltrim(s));
}

</script>
</head>
<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
		<div class="title"><div id="title_zi">服务评价报告查询</div></div>
		<table cellspacing="0" style="width:100%;">
    <!-- THE FIRST LINE OF THE CONTENT -->
     <tr >
      <td > 开始时间 </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > 结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
		  <td > 被检对象 </td>
      <td >
			 	<input id="objectTypeName" name ="objectTypeName" size="20" type="text" onclick="showObjectCheckTree(0);" value="<%=(objectTypeName==null)?"":objectTypeName%>" >
  			<input id="objectid" name ="0_str_t1.object_id" size="20"  type="hidden" value="<%=(objectid==null)?"":objectid%>">
		    <img onclick="showObjectCheckTree(0)" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
		 <td > 被检工号 </td>
      <td >
			  <input name ="1_=_t1.staffno" type="text" id="staffno"  maxlength="10" value="<%=(staffno==null)?"":staffno%>">
			  <font color="orange">*</font>
			  <!-- 个人是0，多人是1 -->
			  <input name ="2_=_t1.group_flag" type="hidden" id="groupflag" value="0">
      </td>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="4" align="left" id="footer" style="width:420px">
        <input name="delete_value" type="button"  id="add" value="重设" onClick="clearValue();return false;">&nbsp;&nbsp;&nbsp;&nbsp;
        <input name="search" type="button"  id="search" value="开始查询" onClick="submitInputCheck();return false;">
      </td>
    </tr>
		</table>
	</div>
	<%
      if(dataRows==null||"".equals(dataRows)||dataRows.length<1){
  %>
  <div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
     <table cellspacing="0" style="width:100%;">
     		<input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
     	 <tr><th align="center" class="blue" width="100%" colspan="2"> <%=(staffno==null)?"":staffno%>服务评价报告 </th></tr>
     	<%
	    if("Y".equals(isCheckLogin)){
	    %>
	     <tr><td align="center">无满足条件的服务评价报告!</td></tr>
	    <%
	   	}else{
	   %>
	   	<tr><td align="center">您没有权限查看该工号服务评价报告!</td></tr>
	   <%
	   }
	   %>
   	</table>
  </div>
   <%
    }else{
   %>
  <div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
      <table cellspacing="0">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <tr><th align="center" class="blue" width="100%" colspan="2"> <%=(staffno==null)?"":staffno%>服务评价报告 </th></tr>
          <tr >
            <th align="center" class="blue" width="10%" > 考评内容 </th>
            <th align="center" class="blue" width="10%" > 指标项及分数 </th>
          </tr>

          <% for ( int i = 0; i < contentName.length; i++ ) {
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr>
		<%
			}else{
		%>
	   <tr  >
	<%}%>
      <td align="center" class="<%=tdClass%>"><%=(contentName[i][0].length()!=0)?contentName[i][0]:"&nbsp;"%></td>
      <td style="margin:0px;padding:0px">
        	<table style="width:100%;height:100%;" cellspacing="0" >
          <tr >
            <th align="left" class="blue" width="40%" > 被检流水号 </th>
            <th align="left" class="blue" width="40%" > 考评类别 </th>
            <th align="center" class="blue" width="12%" > 得分 </th>
          </tr>
           <% for(int j = 0; j < dataRows.length;j++ ) {
              if(dataRows[j][3].equals(contentName[i][1])&&dataRows[j][4].equals(contentName[i][2])){
                temp = Float.parseFloat((dataRows[j][2].length()!=0)?dataRows[j][2]:"0");
           	    totalScore+=temp;
           	    integratedScore = integratedScore-(fullScore-temp);
            %>
           <tr >
           <td align="left" onClick="getQcDetail('<%=dataRows[j][5]%>')" style="cursor:hand" class="<%=tdClass%>"  ><%=(dataRows[j][0].length()!=0)?dataRows[j][0]:"&nbsp;"%></td>
           <td align="left" class="<%=tdClass%>"  ><%=(dataRows[j][1].length()!=0)?dataRows[j][1]:"&nbsp;"%></td>
           <td align="right" class="<%=tdClass%>"  ><%=(dataRows[j][2].length()!=0)?dataRows[j][2]:"&nbsp;"%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          </tr>
        <%}}%>
       	</table>
      </td>
    </tr>
      <% } %>
   <tr >
     <td align="left" style="background:pink" width="30%" > 综合得分 </th>
     <%
     		//将float值为整数时的数据去除小数点后面的".0"  如98.0最后得到为98
				String lastIntegratedScore = "";
				String tmpIntegratedScore =  Float.toString(integratedScore);
				//如果浮点数为整值，去掉".0"
				if(tmpIntegratedScore.endsWith(".0")){
					lastIntegratedScore = tmpIntegratedScore.substring(0,tmpIntegratedScore.length()-2);

				}else{
					lastIntegratedScore = tmpIntegratedScore;
				}
     %>
   	 <td align="right" style="background:pink" width="70%" > <%=lastIntegratedScore%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
   </tr>
  </table>
</div>
<%}%>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>