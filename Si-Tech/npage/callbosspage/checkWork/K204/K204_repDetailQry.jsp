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
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="java.text.DecimalFormat"%>

<%
	String opCode="K204";
	String opName="质检查询-服务评价报告查询";
%>

<%!
	

	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}

%>

<%

	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	/*midify by yinzx 20091113 公共查询服务替换*/
	String myParamspub="";  
 	String regionCode = orgCode.substring(0,2);
	String start_date     =  request.getParameter("start_date");
	String end_date       =  request.getParameter("end_date");
	String staffno        =  request.getParameter("staffno");
	if(staffno==null || "".equals(staffno)){
     staffno =  request.getParameter("1_=_t1.staffno");
  }
  String objectid      =  request.getParameter("objectid");
    
  if(objectid==null || "".equals(objectid)){
     objectid =  request.getParameter("0_str_t1.object_id");
  }
  if(objectid==null){
  	objectid="";
  }
	String group_flag 		=  request.getParameter("group_flag");
	String isCheckLogin  = "N";								//是否有权限查看所有业务代表的服务评价报告("Y"有，"N"无)
	String bossLoginNo  = "";

	/*取当前登陆工号的角色ID，为逗号分割的字符串*/
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
    
    
    String objectTypeName =  request.getParameter("objectTypeName");


    String[][] dataRows = new String[][]{};
    String action = request.getParameter("myaction");

   
    String thSqlStr = "select t1.name,t1.object_id,t1.contect_id  from dqccheckcontect t1,dqcobject t2 where t1.object_id=:objectid and t1.object_id=t2.object_id  and t1.bak1='Y' and t2.bak1='Y' order by t1.object_id";
    myParamspub= "objectid="+objectid.trim() ;
 %>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=thSqlStr%>"/>
	<wtc:param value="<%=myParamspub%>"/>
	</wtc:service>
	<wtc:array id="contentName"  scope="end"/>

<%
    HashMap hashMap =new HashMap();
		hashMap.put("start_date",start_date); 
    hashMap.put("end_date",end_date); 
    hashMap.put("staffno",staffno); 
    hashMap.put("objectid",objectid); 
    hashMap.put("group_flag",group_flag); 
    hashMap.put("hasMoreCondition","Y"); 
    //hashMap.put("isCheckLogin",isCheckLogin);
    List iDataList3 =(List)KFEjbClient.queryForList("k204repdetailselect",hashMap);                              
		dataRows = getArrayFromListMap(iDataList3 ,0,6); 	
%>
<%
String content_id = "";
if(dataRows!=null&&!("".equals(dataRows))&&dataRows.length>0){
	 content_id = dataRows[0][4];
	 String getHighScoreSql = "select to_char(sum(high_score)) from dqccheckitem " +
                          	"where object_id=:objectid and contect_id=:contect_id and is_leaf='Y' and is_scored='Y' and bak1='Y' ";
   myParamspub= "objectid="+objectid.trim()+",contect_id="+ content_id;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=getHighScoreSql%>"/>
	<wtc:param value="<%=myParamspub%>"/>
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
<style>
  img{
  cursor:hand;
  }
</style>
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
   window.sitechform.action="K204_repDetailQry.jsp";
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
	  }else if(e[i].id=="group_flag"){
	  	e[i].value='0';
	  }else{
	  	e[i].value="";
	  }
  }else if(e[i].type=="checkbox"){
  	e[i].checked=false;
  }
 }
}

function keepValue(){
	  window.sitechform.sqlFilter.value="";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.end_date.value="<%=end_date%>";
    window.sitechform.objectTypeName.value="<%=objectTypeName%>";
    window.sitechform.objectid.value="<%=objectid%>";
    window.sitechform.staffno.value="<%=staffno%>";
     window.sitechform.group_flag.value="<%=group_flag%>";
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
      <td > 被检对象 </td>
      <td >
			 	<input id="objectTypeName" name ="objectTypeName" size="20" type="text" onclick="showObjectCheckTree(0);" value="<%=(objectTypeName==null)?"":objectTypeName%>" >
     <img onclick="showObjectCheckTree(0)" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
     <!-- <td > 结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> -->
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
		  
      <td > 结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
		 <td > 被检工号 </td>
      <td >
			  <input name ="1_=_t1.staffno" type="text" id="staffno"  maxlength="10" value="<%=(staffno==null)?"":staffno%>">
			  <font color="orange">*</font>
      </td>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
    <tr>
    	<td>考核类别</td>
			<td colspan='3'>
				<select name="group_flag" id="group_flag" size="1"  >
                                <option value="" selected >2-全部</option>
				<option value="0" <%="0".equals(group_flag)?"selected":""%>>个人考评</option>
				<option value="1" <%="1".equals(group_flag)?"selected":""%>>团体考评</option>
				</select>
			</td>
    </tr>
      <td colspan="4" align="left" id="footer" style="width:420px">
      	        <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">&nbsp;&nbsp;&nbsp;&nbsp;
        <input name="delete_value" type="button"  id="add" value="重置" onClick="clearValue();return false;">

      </td>
    </tr>
		</table>
		<input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
        <input id="objectid" name ="0_str_t1.object_id" size="20"  type="hidden" value="<%=(objectid==null)?"":objectid%>"> 
	</div>
	<%
      if(dataRows==null||"".equals(dataRows)||dataRows.length<1){
  %>
  <div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
     <table cellspacing="0" style="width:100%;" >
     
                
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
  <div id="Operation_Table" style="width:100%;">
      <table cellspacing="0">
			  
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
           	    //updated by tangsong 20100525 修改综合得分为平均分
           	    //integratedScore = integratedScore-(fullScore-temp);
            %>
           <tr >
           <td align="left" onClick="getQcDetail('<%=dataRows[j][5]%>')" style="cursor:hand" class="<%=tdClass%>"  ><%=(dataRows[j][0].length()!=0)?dataRows[j][0]:"&nbsp;"%></td>
           <td align="left" class="<%=tdClass%>"  ><%=(dataRows[j][1].length()!=0)?dataRows[j][1]:"&nbsp;"%></td>
           <td align="right" class="<%=tdClass%>"  ><%=(dataRows[j][2].length()!=0)?dataRows[j][2]:"&nbsp;"%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          </tr>
        <%}}
        	//added by tangsong 20100525 修改综合得分为平均分
        	integratedScore = totalScore/(dataRows.length);
        %>
       	</table>
      </td>
    </tr>
      <% } %>
   <tr >
     <td align="left" style="background:pink" width="30%" > 综合得分 </th>
     <%
     		//updated by tangsong 20100525 四舍五入
     		/*
     		//将float值为整数时的数据去除小数点后面的".0"  如98.0最后得到为98
				String lastIntegratedScore = "";
				String tmpIntegratedScore =  Float.toString(integratedScore);
				//如果浮点数为整值，去掉".0"
				if(tmpIntegratedScore.endsWith(".0")){
					lastIntegratedScore = tmpIntegratedScore.substring(0,tmpIntegratedScore.length()-2);

				}else{
					lastIntegratedScore = tmpIntegratedScore;
				}
				*/
				
				DecimalFormat df = new DecimalFormat("0.00");
				String strScore = df.format(integratedScore);
     %>
   	 <td align="right" style="background:pink" width="70%" > <%=strScore%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
   </tr>
  </table>
</div>
<%}%>

</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>
                                                                                                                                    
