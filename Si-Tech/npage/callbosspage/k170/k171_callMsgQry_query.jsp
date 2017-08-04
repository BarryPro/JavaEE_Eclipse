
<%
  /*
   * 功能: 来电信息查询
　 * 版本: 1.0
　 * 日期: 2008/10/14
　 * 作者: donglei
　 * 版权: sitech
   * update: libin 2009/04/27 客户归属
   * update yinzx 20090826 修改角色
 　*/
 %>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>

<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<html>
<head>
<style>
	img{
				cursor:hand;
		}

	input{
		height: 1.6em;
		line-height: 1.6em;
		width: 10em;
		font-size: 1em;
	}
</style>
<title>来电信息查询</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<%!
 public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}



%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
  /*modify by yinzx 0923 */
	String kf_longin_no = (String) session.getAttribute("workNo");

    /*取当前登陆工号的角色ID，为逗号分割的字符串 hanjc add 20090423*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
  //added by tangsong 20100406
	if (powerCode == null) {
		powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
	String isCommonLogin2="N";
	/*
	 *是否是话务员 update by hanjc 20090719
        *01120O04为培训角色id,01120O0E为质检角色id,011202为客户电话营业厅，01120O02是普通座席
        *01120O02011202和01120201120O02是客户电话营业厅和普通座席两个角色的拼接
        *话务员只有客户电话营业厅和普通座席两个角色,即01120O02011202和01120201120O02，不包括小组长。
        *01120201120O0G和01120O0G011202为小组张角色id拼接
	 */
	 /* modify by yinzx 20090826 由于山西代码写的较乱，而且写死角色信息 所以改造，并运行时调整
      //add by hanjc 20090719 判断当前工号是否是普通坐席。如果是非普通坐席，查询条件工号默认为空。
      if(powerCodeArr.length==2){
         String tempVal = powerCodeArr[0].trim()+powerCodeArr[1].trim();
         if("01120O02011202".equals(tempVal)||"01120201120O02".equals(tempVal)||"01120201120O0G".equals(tempVal)||"01120O0G011202".equals(tempVal)){
		        isCommonLogin2="Y";
         }
       }
   */
   for(int i = 0; i < powerCodeArr.length; i++){
		if(XZZ_ID.equals(powerCodeArr[i]) ){
			isCommonLogin2="Y";
		}
		for(int j=0; j<HUAWUYUAN_ID.length; j++){
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
				isCommonLogin2="Y";
			}
		}
	}	
%>


<script language="javascript">
    //居中打开窗口
		function openWinMid(url,name,iHeight,iWidth)
		{
		  //var url; //转向网页的地址;
		  //var name; //网页名称，可为;
		  //var iWidth; //弹出窗口的宽度;
		  //var iHeight; //弹出窗口的高度;
		  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
		  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
		  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
		}

function getLoginNo(){
  openWinMid('k170_getLoginNo.jsp','工号查询',240,400);
}

$(document).ready(
		function()
		{
	    $("tr").not("[input]").addClass("blue");
	    $("th").css("color","#3366FF").css("font-weight","bold");
			$("a").hover(function(){
				$(this).css("color", "orange");
			}, function(){
				$(this).css("color", "#159ee4");
			});
		}
	);

//导出窗口
function showExpWin(flag){
	 var startDate = new Date(document.sitechform.start_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var endDate = new Date(document.sitechform.end_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var month_interval = getMonths(startDate,endDate);
	 document.sitechform.month_interval.value = month_interval;
  openWinMid('k171_expSelect.jsp?flag='+flag,'expSelect',340,320);
}

//判断stratDate,endDate相隔几个月,0同月份,1相隔一个月
function getMonths(startDate,endDate){
 number = 0;
 yearToMonth = (endDate.getFullYear() - startDate.getFullYear()) * 12;
 number += yearToMonth;
 monthToMonth = endDate.getMonth() - startDate.getMonth();
 number += monthToMonth;

 return number;
}

function submitInputCheck(orderColumn, orderCode){
	 var startDate = new Date(document.sitechform.start_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var endDate = new Date(document.sitechform.end_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var month_interval = getMonths(startDate,endDate);
	 document.sitechform.month_interval.value = month_interval;
   if( document.sitechform.start_date.value == ""){
    	   showTip(document.sitechform.start_date,"开始时间不能为空");
    	   sitechform.start_date.focus();

    }else if(document.sitechform.end_date.value == ""){
		     showTip(document.sitechform.end_date,"结束时间不能为空");
    	   sitechform.end_date.focus();

    }else if("Y"=="<%=isCommonLogin2 %>" && (document.getElementById("caller_phone").value == "") && (document.getElementById("contact_id").value == "") && (document.getElementById("accept_login_no").value == "") && (document.getElementById("accept_phone").value == "")){

    		 	showTip(document.getElementById("accept_login_no"),"输入筛选条件");


    }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		     showTip(document.sitechform.end_date,"结束时间必须大于开始时间");
    	   sitechform.end_date.focus();

    }else if(month_interval > 1){
    		 showTip(document.sitechform.end_date,"只能查询2个月内的记录");
    		 sitechform.end_date.focus();
  	}
    /*common by hucw,20100915,实现跨月查询功能，但只能跨一个月
    else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
		     showTip(document.sitechform.end_date,"只能查询一个月内的记录");
    	   sitechform.end_date.focus();
    }*/else if(parseInt(document.sitechform.accept_long_end.value)<=parseInt(document.sitechform.accept_long_begin.value)){
		     showTip(document.sitechform.accept_long_end,"受理时长右侧值必须大于左侧值");
    	   sitechform.accept_long_end.focus();
    }
    else
    {
				hiddenTip(document.sitechform.start_date);
				hiddenTip(document.sitechform.end_date);
				hiddenTip(document.sitechform.accept_long_end);
				hiddenTip(document.getElementById('contact_id'));
				hiddenTip(document.getElementById('accept_login_no'));
				hiddenTip(document.getElementById('accept_phone'));
				//added by tangsong 20100531 增加排序功能
				//begin
				window.sitechform.orderColumn.value=orderColumn;
				window.sitechform.orderCode.value=orderCode;
				//end
				submitMe('0','0','0');
    	}
}

function changeCheckBoxStatus(){
	var checkBox= document.getElementById("VERTIFY_PASSWD_FLAG_ISNOT_NULL");
	if(checkBox.checked==true){
		window.sitechform.VERTIFY_PASSWD_FLAG_ISNOT_NULL.value="Y";
	}
}

/*zengzq 20100125 调整submitMe方法，增加参数 isFirstQry,若为0，则为查询，若为1 则为点击下一页，上一页，跳转等*/
function submitMe(flag,isFirstQry,rCount){
		//updated by tansong 20101221 不再使用遮罩层
		/*
		//zengzq 20100125 查询结果未返回时，增加遮挡，将页面遮挡
		parent.resultFrame.hiddenOperate();
		*/

		//zengzq 20100125 如果是点击下一页等，则直接将总条数传递返回 isFirstQry为1则标志为点击下一页等进行的查询，rowCount表示查询结果条数--针对下一页等
   	//flag为0，记录客户接触日志
   	if(flag=='0'){
		 	var vCon_id='';
		 	var objSwap=window.top.document.getElementById('contactId');
			if(objSwap!=null&&objSwap!=null!=''){
				vCon_id=objSwap.value;
			}
      window.sitechform.action="result.jsp?con_id="+vCon_id+"&isFirstQry="+isFirstQry+"&rCount="+rCount;
		}else{
			window.sitechform.action="result.jsp?isFirstQry="+isFirstQry+"&rCount="+rCount;
		}
   window.sitechform.method='post';
   window.sitechform.target = 'resultFrame';
   window.sitechform.submit();
}
function changeSize(typeA){

	var row;
	//全视图时
	if(document.getElementById('show_content_btn').style.display=='none')
		row = 290;
	else
		row = 165;
				if(typeA==1){
					parent.frames['frameset110'].rows=''+row+',*';
				}else if(typeA==2){
					parent.frames['frameset110'].rows='290,*';
				}else if(3==typeA){
					parent.frames['frameset110'].rows='320,*';
				}else{
					parent.frames['frameset110'].rows='290,*';
			  }
			}
			
	function search1(){	
	   $.ajax({
			type: "post",
			url: "K171_callMsgQry_quence.jsp",
			data: "skill_quence_choose="+document.sitechform.skill_quence_choose.value,
			success: function(data){
				$("#skill_quence").empty();
				$("#skill_quence").append(data);
			}
		});  

	}

</script>
</head>

<body>
<form id=sitechform name=sitechform>
	<input type="hidden" name="page" value="">
	<input type="hidden" name="myaction" value="doLoad">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<!-- added by tangsong 20100331 用于排序 -->
	<input type="hidden" name="orderColumn" id="orderColumn" value="" />
	<input type="hidden" name="orderCode" id="orderCode" value="" />
	<div id="Operation_Table" style="width:100%">
		<table cellspacing="0">
		<div class="title">
			<div id="title_zi">来电信息</div>
			<div style='float:right;width:70px'>
			<a id='show_content_btn' onclick="showContent()" style="cursor:pointer">更多&gt;&gt;</a>
			<a id='hide_content_btn' onclick="hideContent()" style='display:none;cursor:pointer'>更多&lt;&lt;</a>
			</div>
		</div>

    <tr >
      <td  nowrap > 开始时间 </td>
      <td  nowrap >
			  <input  id="start_date" name ="start_date" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);changeSize(2);" onchange="changeSize(1)">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});changeSize(2);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" style="width:16px;height:22px" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
      <td  nowrap > 员工地市 </td>
      <td  nowrap >
			 <select style="width:10em" id="staffcity" name="staffcity" size="1"  onchange="oper.value=this.options[this.selectedIndex].value">
			 	<!-- value 为空，查询时会自动忽略此条件-->

			 	<option value="" selected>--所有员工地市--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select region_name , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>

        </select>
        <input name="oper" type="hidden" value="<%=request.getParameter("oper")%>">
			  <font color="red">*</font>
      </td>
      <td  nowrap > 流水号 </td>
      <td  nowrap >
      <!--zhengjiang 20091010添加value=value.replace(/[^a-zA-Z\d]/g,'');和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
				<input style="width:12em" id="contact_id" name="contact_id" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" type="text" value="">
				<font color="red">*</font>
      </td>
    </tr>
    <tr >
      <td  nowrap > 结束时间 </td>
      <td  nowrap >
			  <input id="end_date" name ="end_date" type="text"   value="<%=getCurrDateStr("23:59:59")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});changeSize(3);" onchange="changeSize(1);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);changeSize(3);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		    <input id = "month_interval" name="month_interval" type="hidden"/>
		  </td>
	  	<td  nowrap > 受理工号 </td>
      <td  nowrap >
			  <!--input name ="2_=_accept_kf_login_no" type="text" id="accept_login_no" onkeyup="hiddenTip(this)"  value="<%="Y".equals(isCommonLogin2) ? kf_longin_no:"" %>" -->
			  <!--zhengjiang 20091010 增加value=value.replace(/[^kf\d]/g,'');和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="accept_login_no" type="text" id="accept_login_no" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%="Y".equals(isCommonLogin2) ? kf_longin_no:"" %>">
		    <img onclick="getLoginNo()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" >
		    <font color="red">*</font>
		  </td>
	  	<td  nowrap > 受理号码 </td>
      <td  nowrap >
			  <input name ="accept_phone"  maxlength="15" type="text" id="accept_phone"  value="" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" >
		   <font color="red">*</font>
		  </td>

     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
     <tr >
      <td  nowrap > 客户级别 </td>
      <td  nowrap >
			  <select style="width:10em" name="usertype" id="grade_code" size="1" onchange="grade.value=this.options[this.selectedIndex].value">

			  <option value="" selected>--所有客户级别--</option>
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
					<wtc:sql>select user_class_id , accept_code|| '-->' ||accept_name from scallgradecode order by accept_code</wtc:sql>
					</wtc:qoption>
        </select>
				<input name="grade" type="hidden" value="">
		  </td>
	  	<td  nowrap > 联系电话 </td>
      <td nowrap  >
			  <input name ="contact_phone" type="text" id="contact_phone"  value="">
		  </td>
	  	<td  nowrap > 主叫号码 </td>
      <td  nowrap >
			  <input name ="caller_phone" type="text" id="caller_phone"  value="" "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td>
     </tr>
	<tbody id='hidenSection' style="display:none">
    <!-- THE THIRD LINE OF THE CONTENT hide section-->
    <tr >
     <td  nowrap > 客户姓名 </td>
      <td  nowrap >
			  <input name ="cust_name" type="text" id="cust_name"  value="">
		  </td>
		 <td  nowrap > 传真号码 </td>
     <td  nowrap >
			  <input name ="fax_no" type="text" id="fax_no"  value="">
		 </td>
		 <td  nowrap > 受理方式 </td>
     <td  nowrap >
		  <select style="width:10em" name="acceptid" id="acceptid" size="1" onchange="accid.value=this.options[this.selectedIndex].value">
		  	  <option value="" selected>--所有受理方式--</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				   <wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE</wtc:sql>
				  </wtc:qoption>
        </select>
        <input name="accid" type="hidden" value="">
		  </td>
    </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
    <tr >
    <td  nowrap > 客户地市 </td>
      <td  nowrap >
			 <select style="width:10em" id="region_code" name="region_code" size="1" onchange="region.value=this.options[this.selectedIndex].value">

			 	<option value="" selected>--所有客户地市--</option>
				   <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				   </wtc:qoption>

        </select>
        <input name="region" type="hidden" value="">
      </td>
     <td  nowrap >被叫号码 </td>
      <td >
<input name ="callee_phone" type="text" id="callee_phone"  value="" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">

      </td>
     <td  nowrap > 挂机方 </td>
      <td  nowrap >
        <select style="width:10em" name="staffHangup" id="staffHangup" size="1" onchange="hangup.value=this.options[this.selectedIndex].value">
                  <!-- add by jiyk 2012-06-14 -->
        	   <option value="" selected>全部</option>
				     <option value="0" >用户</option>
				     <option value="1" >话务员</option>
				      <option value="3" >密码验证失败自动释放</option>
				       <option value="4" >转IVR挂机</option>
				        <option value="5">其他</option> 
				        <option value="6">转队列挂机</option>


        </select>
        <input name="hangup" type="hidden" value="">
      </td>

    </tr>
        <!-- THE THIRD LINE OF THE CONTENT -->
    <tr >
     <td  nowrap > 录音听取标志 </td>
     <td  nowrap >
				<%
					//updated by tangsong 20100603 普通话务员不能选择录音听取标志
					boolean isHWY = false;
					for(int i = 0; i < powerCodeArr.length; i++){
						for(int j = 0; j < HUAWUYUAN_ID.length; j++){
							if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
								isHWY = true;
								break;
							}
						}
					}
					if (!isHWY) {
				%>
        <select style="width:10em" id="listen_flag" name="listen_flag" size="1" onchange="listen.value=this.options[this.selectedIndex].value">
        	<option value="" selected>全部</option>
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
					<wtc:sql>select listen_flag_code , listen_flag_code|| '-->' ||listen_flag_name from SLISTENFLAG</wtc:sql>
					</wtc:qoption>
        </select>
        <input name="listen" type="hidden" value="<%=request.getParameter("listen")%>">
				<%
					} else {
				%>
        <select style="width:10em" id="listen_flag" name="listen_flag" size="1" disabled>
        	<option value="" selected>全部</option>
        </select>
				<%
					}
				%>
        <input name="listen" type="hidden" value="<%=request.getParameter("listen")%>">
      	</td>
     		<td  nowrap > 受理时长 </td>
      	<td >
			  >=<input name ="accept_long_begin" type="text" id="accept_long_begin"  maxlength="5" style="width:5.5em" value="" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			  <=<input name ="accept_long_end" type="text" id="accept_long_end"      maxlength="5" style="width:5.5em"  value="" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  	</td>
	      <td  nowrap > 客户满意度 </td>
	      <td >
      	 <select style="width:10em" name="statisfy_code" id="statisfy_code" size="1" onchange="statisfy.value=this.options[this.selectedIndex].value">

      	 	<option value="all" selected >--所有满意度--</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				   <wtc:sql>select satisfy_code , satisfy_code|| '-->' ||satisfy_name from ssatisfytype where valid_flag = '1'</wtc:sql>
				  </wtc:qoption>

        </select>
       <input name="statisfy" type="hidden" value="<%=request.getParameter("statisfy")%>">
		  	</td>
    	</tr>
    <tr>
    <td  nowrap > 电子邮件 </td>
      <td  nowrap >
			  <input name="mail_address" type="text" maxlength="80"  id="mail_address"  value="">
      </td>
    <td  nowrap > 联系地址 </td>
      <td >
			  <input name ="contact_address" type="text" id="contact_address"  value="">
      </td>
     <td  nowrap > 已进行密码验证 </td>
      <td  nowrap >
			  <input name ="VERTIFY_PASSWD_FLAG_ISNOT_NULL" type="checkbox"  id="VERTIFY_PASSWD_FLAG_ISNOT_NULL" onClick="changeCheckBoxStatus();" value="">
      </td>
    </tr>
    <tr>
    	<td  nowrap >技能队列筛选</td>
    	 <td >
    	<input name ="skill_quence_choose" type="text" id="skill_quence_choose"  value="">
    	<input name="searchE" type="button"  id="searchE" value="查询" style="width:3em" onClick="search1();">
    	</td >
      <td  nowrap >技能队列 </td>
      <td colspan="3" nowrap >
        <select style="width:30em" id="skill_quence" name="skill_quence" size="1" onchange="skill.value=this.options[this.selectedIndex].value">
        	<option value="" selected>--所有技能队列--</option>
        	 <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				  <wtc:sql>select skill_queud_name , skill_queue_id ||'-->' || skill_queud_name from dagskillqueue</wtc:sql>
				  </wtc:qoption>
        </select>
        <input name="skill" type="hidden" value="<%=request.getParameter("skill")%>">
      </td>
    </tr>
	 <tr >

    </tr>
    </tbody>
    <tr >
      <td colspan="6" align="center" id="footer" style="width:600px">

       <!--zhengjiang 20091004 查询与重置换位置-->
       <input name="search" type="button" class="b_foot" id="search" value="查询" onClick="submitInputCheck('','');">
       <input name="delete_value" type="reset" class="b_foot"  id="add" value="重置">
       <input name="export" type="button" class="b_foot"  id="search" value="导出" onClick="showExpWin('cur');"%>
       <input name="exportAll" type="button" class="b_foot"  id="add" value="导出全部" onClick="showExpWin('all');"%>
       <script>
       if(checkRole(K171M_RolesArr)==true){//p20130227 录音下载权限控制 生产环境修改 K171M_RolesArr
             		document.write('<input name="downloadAll" type="button" class="b_foot"  id="downloadAll" value="下载录音" onClick="parent.frames[\'resultFrame\'].download()"/>');
       }
       </script>
      </td>
    </tr>
		</table>
	</div>
	</form>
</body>

<script>

	function hideContent(){
		document.getElementById('show_content_btn').style.display='block';
		document.getElementById('hide_content_btn').style.display='none';
		document.getElementById('hidenSection').style.display='none';
		//$("#hidenSection").slideUp("fast");
		parent.frames['frameset110'].rows='165,*';
	}
	function showContent(){
		document.getElementById('show_content_btn').style.display='none';
		document.getElementById('hide_content_btn').style.display='block';
		document.getElementById('hidenSection').style.display='block';
		//$("#hidenSection").slideDown("fast");
		parent.frames['frameset110'].rows='290,*';
	}


</script>
