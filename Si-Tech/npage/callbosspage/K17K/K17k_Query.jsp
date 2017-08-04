<%@page import="java.text.SimpleDateFormat"%>
<%
  /*
   * 功能: 现场解决
　 * 版本: 1.0
　 * 日期: 2011/08/18
　 * 作者: tangxlc
　 * 版权: sitech
   *
 　*/
%>
<%!
    String getCurrDateStr() 
    {
		    java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
		    return objSimpleDateFormat.format(new java.util.Date());
	  }
	  
	  String getPreDateYYYYMMDD000000() 
    {
		    java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd 00:00:00");
		    return objSimpleDateFormat.format(new java.util.Date());
	  }
	  String getCurDateYYYYMMDD000000() 
    {
		    java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd 23:59:59");
		    return objSimpleDateFormat.format(new java.util.Date());
	  }
    String getPre24HStr() 
    {
    	  Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				calendar.add(Calendar.DAY_OF_MONTH,-1);
				String preday = sdf.format(calendar.getTime());
		    return preday;
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
    String password = (String) session.getAttribute("password");

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
	if(kf_longin_no.equals("106"))
	{
		powerCodeArr[powerCodeArr.length-1] = "0100020H";
	}
	else if(kf_longin_no.equals("4366"))
	{
		powerCodeArr[powerCodeArr.length-1] = "0100020I";
	}

  for(int i = 0; i < powerCodeArr.length; i++)
  {
		if(XZZ_ID.equals(powerCodeArr[i]))
		{
			isCommonLogin2="Y";
		}
		for(int j=0; j<HUAWUYUAN_ID.length; j++)
		{
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) 
			{
				isCommonLogin2="Y";
			}
		}
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="java.util.Calendar"%>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>

<html>
<head>
<style>
		img{cursor:hand; }
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
				});
				
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

	function submitInputCheck()
	{
		var preday = "<%=getPre24HStr()%>";

		//用户输入数据，有效性效性判断
		var startDate = new Date(document.sitechform.start_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
		var endDate = new Date(document.sitechform.end_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
		if( document.sitechform.start_date.value == "")
		{
			showTip(document.sitechform.start_date,"开始时间不能为空");
			sitechform.start_date.focus();
		}
		else if(document.sitechform.end_date.value == "")
		{
			showTip(document.sitechform.end_date,"结束时间不能为空");
			sitechform.end_date.focus();
		}
		else if(document.sitechform.end_date.value<=document.sitechform.start_date.value)
		{
			showTip(document.sitechform.end_date,"结束时间必须大于开始时间");
			sitechform.end_date.focus();
		}
		else if(document.sitechform.start_date.value < preday )
		{
			showTip(document.sitechform.start_date,"必须大于当前时间减24小时，\n当前时间为" +  "<%=getCurrDateStr()%>");
			sitechform.end_date.focus();
		}
  	else
  	{
			hiddenTip(document.sitechform.start_date);
			hiddenTip(document.sitechform.end_date);
			submitMe('0','0','0');
		}		
	}

	/*zengzq 20100125 调整submitMe方法，增加参数 isFirstQry,若为0，则为查询，若为1 则为点击下一页，上一页，跳转等*/
	function submitMe(flag,isFirstQry,rCount)
	{
		//zengzq 20100125 如果是点击下一页等，
		//则直接将总条数传递返回 isFirstQry为1则标志为点击下一页等进行的查询，
		//rowCount表示查询结果条数--针对下一页等
		if(flag=='0')
		{
			var vCon_id='';
			var objSwap=window.top.document.getElementById('contactId');
			if(objSwap!=null&&objSwap!='')
			{
				vCon_id=objSwap.value;
			}
			window.sitechform.action="K17k_Result.jsp?con_id="+vCon_id+"&isFirstQry="+isFirstQry+"&rCount="+rCount;
		}
		else
		{
			window.sitechform.action="K17k_Result.jsp?isFirstQry="+isFirstQry+"&rCount="+rCount;
		}
			
		window.sitechform.method='post';
		window.sitechform.target = 'frameset_result';
		window.sitechform.submit();
	}

	//打开投诉业务类型树
	function showCallCauseTree(strflag)
	{
		openWinMid("K17K_BizTypeSelectTree.jsp",'请选择现场解决业务类型',500, 400);
	}
			
	//工单整理
	function showOrderManager()
	{
		var pWindow = window.top;
		
		//获取工号
		var login_no = pWindow.document.getElementById('loginNo').value;
		var pass_word = "<%=password%>";
		
		//测试环境使用
		var targeturl = "http://10.110.0.206:6600/workflow/swf297/swf297editList.jsp";
		var path = "http://10.110.0.206:6600/workflow/common/cspAuth.jsp"+ "?login_no="+login_no+ "&targeturl="+targeturl;
 
		//alert("path:"+path+"\npassWord"+pass_word);
		
		//生产环境使用
    //var targeturl = "http://10.110.0.100:21000/workflow/swf297/swf297editList.jsp" ;
    //var path = "http://10.110.0.100:21000/workflow/common/cspAuth.jsp"+ "?login_no="+login_no+ "&targeturl="+targeturl;

    var features = "resizable:no;dialogWidth:820px;dialogHeight:650px;";
    window.showModalDialog(path,window,features);
	}

</script>
</head>
<body onclick="changeSize(1)">
<form id=sitechform name=sitechform >
	<input type="hidden" name="page" value="">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<div id="Operation_Table">
		<table cellspacing="0" width="90%">
			
		<div class="title">
			<div id="title_zi">现场解决</div>
		</div>
			
		<!-- THE FIRST LINE OF THE CONTENT -->
    <tr >
     	<td nowrap> 开始时间 </td>
     		<td  nowrap><input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);changeSize(2);" onchange="changeSize(1);"  value="<%=getPreDateYYYYMMDD000000()%>">
       		<img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);changeSize(2);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
       		<font color="orange">*</font>
     		</td>
     	<td   nowrap > 流水号 </td>
     		<td  nowrap >
				<input id="contact_id" name="contact_id" onclick="changeSize(1)" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" type="text"   value="">
     	</td>
     	<td   nowrap > 受理号码 </td>
      	<td  nowrap >
			 		<input name ="accept_phone"  maxlength="15" type="text" id="accept_phone"  value="" onclick="changeSize(1)" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
   		</td>
    </tr>
   	
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td   nowrap > 结束时间 </td>
      	<td  nowrap >
      		<input  id="end_date" name="end_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);changeSize(2);" onchange="changeSize(1);"  value="<%=getCurDateYYYYMMDD000000()%>">
		    	<img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});changeSize(3);hiddenTip(document.sitechform.end_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    	<font color="orange">*</font>
		    	<input id = "month_interval" name="month_interval" type="hidden"/>
		  </td>
	  	<td   nowrap > 受理工号 </td>
      	<td >
			  	<input name ="accept_login_no" type="text" id="accept_login_no" onclick="changeSize(1)" onkeyup="hiddenTip(this);" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<% if("Y".equals(isCommonLogin2)){out.println(kf_longin_no);} %>">
		  </td>
	    <td nowrap > 主叫号码 </td>
      <td >
			  <input name ="caller_phone" type="text" id="caller_phone"  onclick="changeSize(1)" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  value="">
		  </td>
    </tr>
     
    <!-- THE THIRD LINE OF THE CONTENT -->
    <tr >
			<td nowrap> 业务类型 </td>
				<td nowrap><input name="biz_type" onclick="changeSize(1)" id="biz_type" type="text" value="">
				<img tyle="margin-left:0;" onclick="showCallCauseTree();"  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
			</td>
			<td nowrap> 客户品牌 </td>
      <td nowrap >
			 	<select name="sm_code" id="sm_code" size="1" onclick="changeSize(1)" onchange="brand.value=this.options[this.selectedIndex].value">
			 		<option value="" selected>--所有品牌--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select distinct sm_code , '-->' ||sm_name from ssmcode where allow_flag = '1' and sm_code in ('dn','cb','gn','z0','zn','hl')</wtc:sql>
				  </wtc:qoption>

        </select>
        <input name="brand" type="hidden" value="">
		  </td>
	  	<td   nowrap > 已生成工单 </td>
      	<td >
				  <select name="gen_flag" id="gen_flag" size="1" onclick="changeSize(1)" onchange="genflag.value=this.options[this.selectedIndex].value">
		
				  	<option value="2">--所有工单--</option>
				  	<option value="1">--已生成工单--</option>
		        <option value="0" selected>--未生成工单--</option>
		        </select>
		        <input name="genflag" type="hidden" value="">
  	  </td>
    </tr>
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px" nowrap >
       <input name="search" type="button" class="b_foot"  id="search" value="查询" onClick="submitInputCheck();return false;">
       <input name="delete_value" type="reset" class="b_foot"  id="add" value="重置">

      </td>
    </tr>
	</table>
  </div>
</form>
</body>
</html>

<script>
	function changeSize(typeA)
	{
				var row;
				if(typeA=="1")
				{
					parent.frames['frameset_main'].rows='170,*';
				}else if(typeA=="2"){
					parent.frames['frameset_main'].rows='295,*';
				}else if("3" == typeA){
					parent.frames['frameset_main'].rows='325,*';
				}else{
					parent.frames['frameset_main'].rows='295,*';
			  }
	}
	
	function hideContent()
	{
		parent.frames['frameset_main'].rows='175,*';
	}
	function showContent()
	{
		parent.frames['frameset_main'].rows='225,*';
	}
	</script>