<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 来电原因查询
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者: donglei
　 * 版权: sitech
   * update: fangyuan 样式调整 20091006
   *
 　*/
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="java.util.Calendar"%>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>

<%!
	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>
<%

     /*midify by yinzx 20091113 公共查询服务替换*/
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	/*String kf_longin_no  = (String) session.getAttribute("kfWorkNo");
	/modify wangyong 20090923 修改为boss工号信息*/
	String kf_longin_no  = (String) session.getAttribute("workNo");
	String isCommonLogin2 = "N";

	/*取当前登陆工号的角色ID，为逗号分割的字符串 hanjc add 20090423*/
	//String  powerCode = (String)session.getAttribute("powerCode");
	//String[]  powerCodeArr = powerCode.split(",");

    //+++测试代码begin，给106（kfaa06）添加普通坐席角色，给4366（kfaa12）添加质检员角色
	String  powerCode      = (String)session.getAttribute("powerCodekf");
	//added by tangsong 20100406
	if (powerCode == null) {
		powerCode = "";
	}
	String[] tempPowerCode = powerCode.split(",");
	String[]  powerCodeArr = new String[tempPowerCode.length + 1];
	powerCodeArr           = powerCode.split(",");
//added by liujied
        System.out.println("kf_longin_no"+kf_longin_no);
	if(kf_longin_no.equals("106")){
		powerCodeArr[powerCodeArr.length-1] = "0100020H";
	}else if(kf_longin_no.equals("4366")){
		powerCodeArr[powerCodeArr.length-1] = "0100020I";
	}
	//+++测试代码end，给106（kfaa06）添加普通坐席角色，给4366（kfaa12）添加质检员角色
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
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>


		<script language="javascript">
			function changeCheckBoxStatus(){
				var causeCheckBox= document.getElementById("cause_id_is_null");
				if(causeCheckBox.checked==true){
						window.sitechform.cause_id_is_null.value="checked";
				} else if (causeCheckBox.checked==false){
						window.sitechform.cause_id_is_null.value="";
					}
			}

			$(document).ready(
		function()
		{
	    $("tr").not("[input]").addClass("blue");
	    $("th").css("color","#3366FF").css("font-weight","bold");

			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "#159ee4");
			});
		}
	);

			//居中打开窗口
			function openWinMid(url,name,iHeight,iWidth)
				{
				  //var url; //转向网页的地址;
				  //var name; //网页名称，可为空;
				  //var iWidth; //弹出窗口的宽度;
				  //var iHeight; //弹出窗口的高度;
				  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
				  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
				  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
				}

			//导出窗口
			function showExpWin(flag){
				 var startDate = new Date(document.sitechform.start_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
				 var endDate = new Date(document.sitechform.end_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
				 var month_interval = getMonths(startDate,endDate);
				 document.sitechform.month_interval.value = month_interval;
				openWinMid('k172_expSelect.jsp?flag='+flag,'选择导出列',340,320);
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

			function submitInputCheck(){
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
			    }else if("Y" == "<%=isCommonLogin2 %>" && (document.getElementById("caller_phone").value == "") && (document.getElementById("contact_id").value == "") && (document.getElementById("accept_login_no").value == "") && (document.getElementById("accept_phone").value == "")){
    		 	     showTip(document.getElementById("accept_login_no"),"输入筛选条件");
          }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
					     showTip(document.sitechform.end_date,"结束时间必须大于开始时间");
			    	   sitechform.end_date.focus();
			    }else if(month_interval > 1){
			    		 showTip(document.sitechform.end_date,"只能查询2个月内的记录");
			    		 sitechform.end_date.focus();
  				}
  				/*comment by hucw,20100915,实现跨月查询功能
  					else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
					     showTip(document.sitechform.end_date,"只能查询一个月内的记录");
			    	   sitechform.end_date.focus();

			    }*/else if(parseInt(document.sitechform.accept_long_end.value)<=parseInt(document.sitechform.accept_long_begin.value)){
					     showTip(document.sitechform.accept_long_end,"通话时长右侧值必须大于左侧值");
			    	   sitechform.accept_long_end.focus();

			    }else if(document.getElementById("cause_id_is_null").checked==true&&window.sitechform.show_CauseName.value!=""){
					     showTip(document.sitechform.show_CauseName,"来电原因和来电原因为空不能同时选择！");
					     sitechform.show_CauseName.focus();
				  }
			    else{
			      hiddenTip(document.sitechform.start_date);
			      hiddenTip(document.sitechform.end_date);
			      hiddenTip(document.sitechform.accept_long_end);
			      hiddenTip(document.sitechform.show_CauseName);
			      hiddenTip(document.getElementById('accept_login_no'));
			      submitMe('0','0','0');
			    }
			}

			/*zengzq 20100125 调整submitMe方法，增加参数 isFirstQry,若为0，则为查询，若为1 则为点击下一页，上一页，跳转等*/
			function submitMe(flag,isFirstQry,rCount){
				 //updated by tansong 20101221 不再使用遮罩层
				 /*
				 //zengzq 20100125 查询结果未返回时，增加遮挡，将页面遮挡
				 parent.resultFrame2.hiddenOperate();
				 */

				 //zengzq 20100125 如果是点击下一页等，则直接将总条数传递返回 isFirstQry为1则标志为点击下一页等进行的查询，rowCount表示查询结果条数--针对下一页等
			    if(flag=='0'){
					 var vCon_id='';
					 var objSwap=window.top.document.getElementById('contactId');
					if(objSwap!=null&&objSwap!=''){
						vCon_id=objSwap.value;
					}
			       window.sitechform.action="result_cause.jsp?con_id="+vCon_id+"&isFirstQry="+isFirstQry+"&rCount="+rCount;;
					}else{
						 window.sitechform.action="result_cause.jsp?isFirstQry="+isFirstQry+"&rCount="+rCount;
					}
			   window.sitechform.method='post';
			   window.sitechform.target = 'resultFrame2';
			   window.sitechform.submit();
			}

			//展开来电原因树
			function showCallCauseTree(strflag){
			  openWinMid("k174_callCauseSelectTree.jsp?flag="+strflag,'选择来电原因',500, 400);
			}

			function changeSize(typeA){
				var row;
				//全视图时
				if(document.getElementById('show_content_btn').style.display=='none')
					row = 225;
				else
					row = 175;
				if(typeA==1){
					parent.frames['frameset120'].rows=''+row+',*';
				}else if(typeA==2){
					parent.frames['frameset120'].rows='295,*';
				}else if(3 == typeA){
					parent.frames['frameset120'].rows='325,*';
				}else{
					parent.frames['frameset120'].rows='295,*';
			  }
			}
		</script>
	</head>


<body>
<form id=sitechform name=sitechform>
		<input type="hidden" name="page" value="">
		<input type="hidden" name="sqlFilter" value="">
		<input type="hidden" name="sqlWhere" value="">
		<div id="Operation_Table">
			<table cellspacing="0" width="100%">
			<div class="title">
				<div id="title_zi">来电原因</div>
				<div style='float:right;width:70px'>
				<a id='show_content_btn' onclick="showContent()" style="cursor:pointer;color:#159ee4;">更多>></a>
				<a id='hide_content_btn' onclick="hideContent()" style='display:none;cursor:pointer;color:#159ee4;'>更多<<</a>
			</div>
		</div>

    <!-- THE FIRST LINE OF THE CONTENT -->

      <tr >
      <td  nowrap > 开始时间 </td>
      <td  nowrap >
		<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);changeSize(2);" onchange="changeSize(1);"  value="<%=getCurrDateStr("00:00:00")%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);changeSize(2);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>

      <td   nowrap > 流水号 </td>
      <td  nowrap >
      <!--zhengjiang 20091010添加value=value.replace(/[^a-zA-Z\d]/g,'');和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
				<input id="contact_id" name="contact_id" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" type="text"   value="">
      </td>
      <td   nowrap > 受理号码 </td>
      <td  nowrap >
			  <input name ="accept_phone"  maxlength="15" type="text" id="accept_phone"  value="" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
     </td>

    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td   nowrap > 结束时间 </td>
      <td  nowrap >
			  <input id="end_date" name ="end_date" type="text" value="<%=getCurrDateStr("23:59:59")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);changeSize(3);" onchange="changeSize(1);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});changeSize(3);hiddenTip(document.sitechform.end_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		    <input id = "month_interval" name="month_interval" type="hidden"/>
		  </td>
	  <td   nowrap > 受理工号 </td>
      <td >
      <!--zhengjiang 20091010 增加value=value.replace(/[^kf\d]/g,'');和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="accept_login_no" type="text" id="accept_login_no" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<% if("Y".equals(isCommonLogin2)){out.println(kf_longin_no);} %>">

		  </td>
	    <td nowrap > 主叫号码 </td>
      <td >
			  <input name ="caller_phone" type="text" id="caller_phone"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  value="">
		  </td>
     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
        <tr >
      <td   nowrap > 来电原因 </td>
      <td  nowrap >
      	<input name="showCauseName"  id="show_CauseName"  readOnly="true" type="text" value="">
		  <img onclick="showCallCauseTree('0');"  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
		  </td>
	  <td   nowrap > 受理方式 </td>
      <td >
		  <select name="acceptid" id="acceptid" size="1" onchange="accid.value=this.options[this.selectedIndex].value">

		  	<option value="" selected>--所有受理方式--</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE</wtc:sql>
				</wtc:qoption>

        </select>
        <input name="accid" type="hidden" value="">

		  </td>
	  <td  nowrap > 客户品牌 </td>
      <td nowrap >
			 	<select name="sm_code" id="sm_code" size="1" onchange="brand.value=this.options[this.selectedIndex].value">
			 		<!--zhengjiang 20091010 修改sql条件allow_flag='Y' and sm_code in ('dn','z1','gn')改为allow_flag = '1' and sm_code in ('dn','cb','gn','z0','hn')-->
			 		<option value="" selected>--所有品牌--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select distinct sm_code , '-->' ||sm_name from ssmcode where allow_flag = '1' and sm_code in ('dn','cb','gn','z0','zn','hl')</wtc:sql>
				  </wtc:qoption>

        </select>
        <input name="brand" type="hidden" value="">
		  </td>

     </tr>
    <tbody id='hidenSection' style="display:none">
    <tr>
	  <td  nowrap > 员工地市 </td>
      <td nowrap >
			 <select id="staffcity" name="staffcity" size="1"  onchange="oper.value=this.options[this.selectedIndex].value">

			 	<option value="" selected>--所有员工地市--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>

        </select>
        <input name="oper" type="hidden" value="">
     </td>
      <td  nowrap > 通话时长 </td>
      <td>
			 &gt
			 <input name ="accept_long_begin" type="text" id="accept_long_begin"  maxlength="5" style="width:5.5em;height:1.2em;padding:1px" value="" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			 &lt;
			 <input name ="accept_long_end" type="text" id="accept_long_end"  maxlength="5" style="width:5.5em;height:1.2em;padding:1px" value="" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" >
		  </td>
	  <td  nowrap > 客户地市 </td>
      <td >
			 <select id="region_code" name="region_code" size="1" onchange="region.value=this.options[this.selectedIndex].value">

			 	<option value="" selected>--所有客户地市--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>

        </select>
        <input name="region" type="hidden" value="">
        <input name ="call_cause_id" type="hidden" id="call_cause_id"  value="">
      </td>
		</tr>

     <tr>
	  <td  nowrap > 客户满意度 </td>
      <td nowrap >
      	 <select name="statisfy_code" id="statisfy_code" size="1" onchange="statisfy.value=this.options[this.selectedIndex].value">

      	 	<option value="all" selected >--所有满意度--</option>
				  <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				   <wtc:sql>select satisfy_code , satisfy_code|| '-->' ||satisfy_name from ssatisfytype where valid_flag = '1'</wtc:sql>
				  </wtc:qoption>

        </select>
       <input name="statisfy" type="hidden" value="<%=request.getParameter("statisfy")%>">
		  </td>
      <td  nowrap > 来电原因为空 </td>
      <td nowrap >
			  <input name ="cause_id_is_null" type="checkbox" id="cause_id_is_null" onClick="changeCheckBoxStatus();" value="">
		  </td>
		  <td colspan="6"  nowrap >&nbsp;</td>
		</tr>
    </tbody>
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px" nowrap >
      <!--zhengjiang 20091004 查询与重置换位置-->
       <input name="search" type="button" class="b_foot"  id="search" value="查询" onClick="submitInputCheck();return false;">
       <input name="delete_value" type="reset" class="b_foot"  id="add" value="重置">
			 <input name="export" type="button" class="b_foot"  id="search" value="导出" onClick="showExpWin('cur');">
       <input name="exportAll" type="button" class="b_foot"  id="add" value="导出全部" onClick="showExpWin('all');">

      </td>
    </tr>
		</table>
	</div>
</form>
</body>
</html>

<script>

	function hideContent(){
		document.getElementById('show_content_btn').style.display='block';
		document.getElementById('hide_content_btn').style.display='none';
		//$("#hidenSection").slideUp("fast");
		document.getElementById('hidenSection').style.display='none';
		parent.frames['frameset120'].rows='175,*';
	}
	function showContent(){
		document.getElementById('show_content_btn').style.display='none';
		document.getElementById('hide_content_btn').style.display='block';
		document.getElementById('hidenSection').style.display='block';
		//$("#hidenSection").slideDown("fast");
		parent.frames['frameset120'].rows='225,*';
	}



</script>
