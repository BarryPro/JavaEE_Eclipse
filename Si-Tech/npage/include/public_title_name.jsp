<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page errorPage="/npage/common/errorpage.jsp" %><%/*update by diling for 营业生产主机weblogic报错自查流程@2011/10/27 */%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.math.BigDecimal"%>
<%
    /* BEGIN : add by qidp for 系统换肤 @ 2010-04-19 */
    String versonType = WtcUtil.repNull((String)session.getAttribute("versonType"));    // 页面框架版本:: normal:普通版;simple:高速版.
    System.out.println("$ versonType = "+versonType);
    
    String cssPath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
    
    //防止重复变量名
    String accountType_f_Ng35 =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");
%>

<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="/njs/extend/jquery/jquery.dimensions.js"></script>	
<script type="text/javascript" src="/njs/extend/jquery/tooltip/jquery.tooltip.pack.js"></script>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/csp/checkWork_dialog.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<!-- <script type="text/javascript" src="/njs/si/rightKey.js" defer="true"></script>	 -->
<script language="JavaScript" src="/njs/si/desAPI.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<script language="JavaScript" src="/njs/si/prompt.js"></script>
<script language="JavaScript" src="/njs/si/rewriteSMD.js"></script>
<link href="/nresources/<%=cssPath%>/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/prompt.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/rightKey.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/njs/extend/jquery/tooltip/jquery.tooltip.js"></script>	
<link href="/njs/extend/jquery/tooltip/jquery.tooltip.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/ng35_kf.css" rel="stylesheet" type="text/css"></link><!--hejwa 增加 ng3.5样式-->
<!------hejwa黑龙江ng3.5项目改造-----2012-12-12-------------开始----------------------->
<style>
	input.input-style2{	background-color:#ffffcc;}
	tr.even_hig{	background-color:#cfc; }
	td.even_ng35_trcolor{background:#F7F7F7;}
</style>
<!------hejwa黑龙江ng3.5项目改造-----2012-12-12-------------结束----------------------->
	<%-- /**  modified by hejwa in 20110714 多OP改造--工作区通讯改造  begin **/ --%>
<% 

String rightkey_public_flag = (String)session.getAttribute("rightkey_public_flag");
String rightkey_public = "0";
String rightKeyArr = "";//保存全部

if(rightkey_public_flag==null){//如果为空，第一次查询
String wkSql_public = "select to_char(is_commu) from dwkspace where login_no=:login_no";
String wkparam_public ="login_no="+(String)session.getAttribute("workNo");
String region_code_public = ((String)session.getAttribute("orgCode")).substring(0,2);

%>
<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" retcode="wkretCode" retmsg="wkretMsg" routerValue="<%=region_code_public%>">
  	<wtc:param value="<%=wkSql_public%>"/>
  	<wtc:param value="<%=wkparam_public%>"/>
</wtc:service>
<wtc:array id="wkResult_public" scope="end"/>
<%
	System.out.println(wkretCode);
	if("000000".equals(wkretCode)){
			if(wkResult_public.length>0){
					rightkey_public = wkResult_public[0][0].trim();	
					session.setAttribute("rightkey_public_flag",rightkey_public);	
			}else{
				session.setAttribute("rightkey_public_flag","0");	
			}	
	}else{
		session.setAttribute("rightkey_public_flag","0");
	}
	System.out.println("rightkey_public="+rightkey_public);
}else{
	rightkey_public = (String)session.getAttribute("rightkey_public_flag");
}	
if("1".equals(rightkey_public)) {//开启工作区通讯
%> 
	<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/rightKey.js" defer="true" ></script>  --%>
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/rightKey.css" rel="stylesheet" type="text/css"></link>
	

	<%
		String wkCode = request.getParameter("opCode");
		String wk_sql = "select lower(wkspace_code),field from dcommunicate where lower(wkspace_code) in (:wkspace_code ,'all') and is_effect ='1'";
		String wk_param = "wkspace_code="+wkCode;
		System.out.println("-----------------wkCode---------------------"+wkCode);
		%>
		<wtc:service name="TlsPubSelCrm"  retcode="wkspaceRetCode" retmsg="wkspaceRetMsg"  outnum="2">
			<wtc:param value="<%=wk_sql%>" />
			<wtc:param value="<%=wk_param%>" />
		</wtc:service>
		<wtc:array id="wkspace" scope="end"/>
		<%	
	for(int iii=0;iii<wkspace.length;iii++){
		for(int jjj=0;jjj<wkspace[iii].length;jjj++){
			System.out.println("---------------------wkspace["+iii+"]["+jjj+"]=-----------------"+wkspace[iii][jjj]);
		}
	}
		//工作区通讯
		
		int allWkFlag = 0; //变量【通讯字段：全部；工作区：全局】
		
		String opCodeStr = "";
		String allWkStr = "";			
		
		if("000000".equals(wkspaceRetCode)){ 
			if(wkspace.length>0){
				allWkFlag = 1;
				for(int i=0;i<wkspace.length;i++){
					if("all".equals(wkspace[i][0])){
						allWkStr = wkspace[i][1];
					}else{
						opCodeStr = wkspace[i][1];
					}
				}
			}
		}
		if(allWkFlag != 0){
		    rightKeyArr = allWkStr;
		    if(!"".equals(opCodeStr)){
		        if(!"".equals(rightKeyArr)){
		            rightKeyArr+=","+opCodeStr;
		        }else{
		            rightKeyArr = opCodeStr;
		        }
		    }
		}
		
	%>
	
<%}%>
<script type="text/javascript" language="JavaScript">
  		var rightKeyArr = '<%=rightKeyArr%>'.split(",");
	</script>
<%-- /**  modified by hejwa in 20110714 多OP改造--工作区通讯改造  end **/ --%>
<!-- 20091215 add by fengry for MAC地址 -->
<%
	String qxjy_allowEnd = (String)session.getAttribute("allowend");
	if (qxjy_allowEnd != null) {
		String qxjy_cccTime=new java.text.SimpleDateFormat("HHmmss", Locale.getDefault()).format(new java.util.Date());
		System.out.println("----- qxjy ----- " + Integer.parseInt(qxjy_allowEnd) + " , " + Integer.parseInt(qxjy_cccTime));
		if("".equals(qxjy_allowEnd) || Integer.parseInt(qxjy_allowEnd)<Integer.parseInt(qxjy_cccTime))
		{
		String setLoginOutWorkNo = (String)session.getAttribute("workNo");
		String setLoginOutRegionCode = (String)session.getAttribute("regCode");
		%>
		<wtc:service name="sLoginOut" outnum="0" routerKey="region" routerValue="<%=setLoginOutRegionCode%>" 
			 retmsg="msg2" retcode="code2" >
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value=""/>
				<wtc:param value="<%=setLoginOutWorkNo%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
		</wtc:service>
		<%
			session.invalidate();
	%>
			<script language="JavaScript">
			{
				rdShowMessageDialog("该工号的有效操作时间已过期！");
				//工号有效操作时间过期后退出业务界面到登陆初始化界面
				window.open('/npage/login/index.html','','width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
				window.opener=null;
			  this.close();
			}
			</script>
	<%
		}
	}
%>

<!-- 20091215 end -->

<SCRIPT language="JavaScript">
	function esckeydown()
	{
	    if(event.keyCode==27){
	       event.returnValue = null;
	    }
	}
	 //------hejwa黑龙江ng3.5项目改造-----2012-12-12-------------开始-----------------------
$(document).ready(function(){
	//焦点移入变色
	$("input[type='text']:visible").bind("focus",function(){
		if(typeof($(this).attr("readonly"))=="undefined"){
			$(this).addClass("input-style2");
		}
	})
	$("input[type='text']:visible").bind("blur",function(){
		if(typeof($(this).attr("readOnly"))=="undefined"){
			$(this).removeClass("input-style2");
		}
	})
	//只需要将table增加一个vColorTr='set' 属性就可以隔行变色
	$("table[vColorTr='set']").each(function(){
		$(this).find("tr").each(function(i,n){
			$(this).bind("mouseover",function(){
				$(this).addClass("even_hig");
			});
			
			$(this).bind("mouseout",function(){
				$(this).removeClass("even_hig");
			});
			
			if(i%2==0){
				$(this).addClass("even");
			}
		});
	});

	

  //解决客服 问题
	if("2"=="<%=accountType_f_Ng35%>"){
		//tab背景色与生产一致
		/*
	  $("table").find("td").each(function(){
	  	$(this).addClass("even_ng35_trcolor");
		});
		*/
		//readOnly输入框字体黑色
		$("input[type='text']:visible").each(function(){
			if(typeof($(this).attr("readOnly"))!="undefined"){
				$(this).attr("style","color:#000000");
			}
		});
	}else{
		//解决<a href="#"> 点击样式问题
		$("a[href='#']").each(function(){
					$(this).attr("href","javascript:void(0)");
		});
//解决size属性长度	
		$("input[type='text']:visible").each(function(){
			if(typeof($(this).attr("size"))!="undefined"){
				$(this).css("width","auto")
			}					 
		});
	}
//单选框增加文字选中属性，为了不重复名字起长点
	$("q[vType='setNg35Attr']").each(function(){
			$(this).attr("style","cursor:hand");
			var oldtext = $(this).text();
			var oldhtml = $(this).html();
			oldhtml = oldhtml.substring(0,oldhtml.indexOf(oldtext));
			var newhtml = oldhtml+"<a style='cursor:hand;color:#159ee4;' onclick='ng35_cheThisAttr(this)'>"+oldtext+"</a>";
			$(this).html(newhtml);
	});

//复选框增加文字选中属性，为了不重复名字起长点
	$("q[vType='setNg35ChekbAttr']").each(function(){
			$(this).attr("style","cursor:hand");
			var oldtext = $(this).text();
			var oldhtml = $(this).html();
			oldhtml = oldhtml.substring(0,oldhtml.indexOf(oldtext));
			var newhtml = oldhtml+"<a style='cursor:hand;color:#159ee4;' onclick='ng35_cheThisCheckb(this)'>"+oldtext+"</a>";
			$(this).html(newhtml);
	});

});

function ng35_cheThisCheckb(bt){
	var b = $(bt).prev().attr("checked");
	if(typeof(b)=="undefined") b = false; else b =true;
	$(bt).prev().attr("checked",b);
	if($(bt).prev().attr("click")){//如果有click事件
		$(bt).prev().click();
	}
}
function ng35_cheThisAttr(bt){
	$(bt).prev().attr("checked",true);
	if($(bt).prev().attr("click")){//如果有click事件
		$(bt).prev().click();
	}
}


/**输入完成焦点自动切换到下一个元素
* 输入框调用方法  onkeyup="ng35_autoChgFocus(this,n,nextId)"
* this = 元素指针
* n = 第n个字符切换焦点
* nextId = 下一个得到焦点的ID，精确定位
*/
function ng35_autoChgFocus(bt,n,nextId){
	if(countCharacters($(bt).val())>=n){
		$("#"+nextId).focus();
	}
}
//统计字符数
function countCharacters(str){
  var totalCount = 0; 
  for (var i=0; i<str.length; i++) { 
    var c = str.charCodeAt(i); 
    if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) { 
           totalCount++; 
        }else {    
           totalCount++;//totalCount+=2; 汉字双字节，此处也+1，
        } 
    }
  return totalCount;
}
	$(document).bind("keydown",function(){
		 
	   //alt +x 切换页面
		 var oEvent = window.event;
	   if (oEvent.keyCode == 88 && oEvent.altKey) {
	   	//alert(1);
	    parent.parent.altD_tab();
	   }
	   
	   //alt+c 关闭页面
	   if(oEvent.keyCode == 67 && oEvent.altKey) {
	   	parent.parent.altC_tab();
	    //removeCurrentTab();
	   }
	});
	
	//------hejwa黑龙江ng3.5项目改造-----2012-12-12-------------结束-----------------------
	document.onkeydown=esckeydown;
//屏蔽右键
//document.oncontextmenu=new Function("event.returnValue=false");

//function disableKeys(eve)
//{
//	var ev=(document.all)?window.event:eve;
//	var evCode=(document.all)?ev.keyCode:ev.which;
//	var srcElement=(document.all)?ev.srcElement:ev.target;
//	//Backspace 
//		if(srcElement.type!="textarea"&&srcElement.type!="text"&&srcElement.type!="Password")
//		{
//				if(evCode==8)
//				{
//					return  false;
//				}
//		}
//}
//(document.all)?(document.onkeydown=disableKeys):(document.onkeypress=disableKeys);
//var his = window.history.go;
/******************
author:zhouyg

功能：解决iframe中goHistory(-1)回退错误
已测试浏览器：ie6，ie7，ie8，firefox3
*******************/
/*
var framenum = null;
(
function() {
    if (parent != null) {
        var len = parent.window.frames.length;
        for (var i = 0; i < len; i++) {
            if (parent.window.frames[i].window.document == document)
                if (typeof eval("parent.lc" + i) != "undefined") {
                eval("parent.lc" + i).push(location.href);
                framenum = i;
                break;
            }
            else {
                eval("parent.lc" + i + "=[]");
                eval("parent.lc" + i).push(location.href);
                framenum = i;
                break;
            }
        }
    }
   
    window.history.go = function(num) {
        if (num == -1) {
            if (typeof eval("parent.lc" + framenum) != "undefined") {
                if (eval("parent.lc" + framenum).length > 1) {
                    eval("parent.lc" + framenum + ".length=parent.lc" + framenum + ".length-1"); window.location.href = eval("parent.lc" + framenum)[eval("parent.lc" + framenum).length - 1];
                }
            }
        }
        else
            his(num);
    }


}
)()
*/

/*********************
 * 解决select下拉框的option内容过长时，显示不完全问题；
 * 调整下拉框宽度为180px；
 * 为option标记设置title属性，鼠标悬停在option时，浮出option title显示当前option text的内容(对IE7.0+有效)。
 *********************/
$(document).ready(function(){
    var selects = document.getElementsByTagName("select");
    if (selects.length > 0){
        for (var i = 0; i < selects.length; i++){
            var options = selects[i].options;
            if (selects[i].options.length > 0){
                for (var j = 0; j < options.length; j++){
                    if (options[j].title == ""){
                        options[j].title = options[j].text;
                    }
                }
            }
            if(!(selects[i].style.width)){
                //selects[i].style.width="180px"; // ng35统一长度 hejwa 注释
            }
        }
    }
});
</SCRIPT>	
<%
	String external_workNo = (String)session.getAttribute("workNo");
	String external_regionCode = (String)session.getAttribute("regCode");
	String region_code_public = ((String)session.getAttribute("orgCode")).substring(0,2);
	int external_timeDifference = 10;
	int external_n = 10;
	int external_m = 1000;
	/* list长度和时间差阀值放到properties配置文件中 */
	Properties external_props = new Properties();
	String external_timeDifferencekey = "external.timeDifference";
	String external_lengthkey = "external.listLength";
	String external_valvekey = "external.valve";
	String external_path = request.getRealPath("npage/properties")+"/externalCfg.properties";
	InputStream external_in = new BufferedInputStream(new FileInputStream(external_path));
	try {
		external_props.load(external_in);
		String external_timeDifferenceStr =new String(external_props.getProperty(external_timeDifferencekey).getBytes("ISO-8859-1"),"gbk"); 
		String external_listLength =new String(external_props.getProperty(external_lengthkey).getBytes("ISO-8859-1"),"gbk"); 
		String external_valve =new String(external_props.getProperty(external_valvekey).getBytes("ISO-8859-1"),"gbk"); 
		external_n = Integer.parseInt(external_listLength); 
		external_m = Integer.parseInt(external_valve);
		external_timeDifference = Integer.parseInt(external_timeDifferenceStr);
	} catch (FileNotFoundException ex) {
		ex.printStackTrace();
	}catch (Exception e) {
		e.printStackTrace();
	}finally{
		external_in.close();
	}
	System.out.println("ningtn external_m " + external_n + " , " + external_m + " , " + external_timeDifference);
	/******************
		禁止同一工号重复登录并使用BOSS系统的需求
		ningtn 2012-6-7 16:05:56
		session中新增时间信息存session中（工号名+pubTime）
		如果是非客服工号，每次调用public_title_name.jsp时
		比较系统当前时间与session中记录的上次调用时间
		如果间隔大于一个固定的时间频率（暂时定为10秒）
		则调用根据工号代码查询sessionId服务
	*/
	String publicSessionId = session.getId();
	String publicNowTime=new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
	/*session中存放的服务调用时间*/
	String publicSessionTime = (String)session.getAttribute(external_workNo+"pubTime");
	if(publicSessionTime == null){
		/*为空的话，就是第一次调用，存进来*/
		publicSessionTime = publicNowTime;
		session.setAttribute(external_workNo+"pubTime",publicSessionTime);
	}
	BigDecimal bd1 = new BigDecimal(publicNowTime);
	BigDecimal bd2 = new BigDecimal(publicSessionTime);
	System.out.println("ningtn double " + bd1.subtract(bd2));
	/* 为电话经理新增，排除例外 */
	boolean psmFlag = false;
	String loginNoClassCode = (String)session.getAttribute("class_code");
	System.out.println("ningtn loginNoClassCode " + loginNoClassCode);
	if(loginNoClassCode == null){
		/*第一次调用，取一下classCode，放session中，防止多次调用服务*/
		String getClassCodeSql = "select class_code from dchngroupmsg where group_id=:groupId";
		String[] external_inParams = new String[2];
		external_inParams[0] = getClassCodeSql;
		external_inParams[1] = "groupId="+(String)session.getAttribute("groupId");
%>
			<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" 
				 routerValue="<%=external_regionCode%>" retcode="external_retCode" retmsg="external_retMsg">
				<wtc:param value="<%=external_inParams[0]%>"/>
				<wtc:param value="<%=external_inParams[1]%>"/>
			</wtc:service>
			<wtc:array id="external_result" scope="end"/>
<%
		if("000000".equals(external_retCode)){
			if(external_result != null && external_result.length > 0){
				loginNoClassCode = external_result[0][0];
			}
			session.setAttribute("class_code",loginNoClassCode);
		}
	}
	System.out.println("=====ningtn loginNoClassCode " + external_workNo + " : " + loginNoClassCode);
	if("203".equals(loginNoClassCode)){
		/*class_code 为203 的是电话经理工号*/
		psmFlag = true;
	}
	if(!"2".equals((String)session.getAttribute("accountType")) 
		&& bd1.subtract(bd2).intValue() > external_timeDifference
		&& !"aaa1zh".equals(external_workNo)
		&& !"aaaaxp".equals(external_workNo)
		&& !"aa0102".equals(external_workNo)
		&& !psmFlag
		){
		 
	}


	/********
		检查工号异常调用系统页面程序次数、识别外挂的需求
		ningtn 2012-6-4 15:49:15
		将调用事件，记录在List中。List存在session中（工号名+external）
		当已记录数达到n时，校验最小时间与最大时间之间的时间差小于m值，
		则视该session对应的操作有外挂嫌疑。
		n为10，m为1秒
	*/
	
	java.util.List external_list = (java.util.List)session.getAttribute(external_workNo+"external");
	String external_nowTime = "" +System.currentTimeMillis();
	if(external_list == null){
		System.out.println("ningtn list 还没有呢");
		external_list = new ArrayList();
		external_list.add(external_list.size(),external_nowTime);
		session.setAttribute(external_workNo+"external",external_list);
	}else{
		if(external_list.size() < external_n){
			external_list.add(external_list.size(), external_nowTime);
		}
	}
	
	System.out.println("ningtn list size " + external_list.size());
	if(external_list.size() == external_n){
		/*更新时间完毕*/
		/*判断最初的时间和结尾的时间差，如果超过阀值m，就记录日志*/
		BigDecimal bdFirst = new BigDecimal((String)external_list.get(0));
		BigDecimal bdLast = new BigDecimal((String)external_list.get(external_list.size()-1));
		System.out.println("======== ningtn, bdFirst " + bdFirst + "   bdLast  " + bdLast + " size " + external_list.size());
		System.out.println("ningtn " + external_workNo + " external_time " + bdLast.subtract(bdFirst));
		if(bdLast.subtract(bdFirst).intValue() < external_m){
			/*超过阀值，需要将工号、IP、时间差等信息作为日志输出*/
			String external_log = "\r\n===================监控到异常 开始====================";
			external_log += "\r\n 工号：" + external_workNo;
			external_log += "\r\n IP：" + (String)session.getAttribute("ipAddr");
			external_log += "\r\n 时间差(精确到毫秒)：" + bdLast.subtract(bdFirst);
			external_log += "\r\n 当前时间：" + new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
			external_log += "\r\n 当前操作业务：" + WtcUtil.repNull(request.getParameter("opCode")) + " " + WtcUtil.repNull(request.getParameter("opName"));
			external_log += "\r\n===================监控到异常 结束====================";
			String fileName = "externalList.log";
			FileWriter externalWriter = new FileWriter(fileName, true);
			externalWriter.write(external_log);
			externalWriter.close();
		}
		external_list.clear();
	}
%>
<%
  String tabcloseId = WtcUtil.repNull(request.getParameter("closeId"));
	String activePhone  = (String)request.getParameter("activePhone");
	String appCnttFlag  = (String)application.getAttribute("appCnttFlag");//接触平台状态
	String opBeginTime  = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());//业务开始时间
	//System.out.println("opBeginTime=="+opBeginTime);
%>
