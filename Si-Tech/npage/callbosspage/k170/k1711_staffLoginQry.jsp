<%
  /*
   * 功能: 坐席签入签出班记录查询
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者: donglei
　 * 版权: sitech
   * 修改:    liujied 20090921
   *
 　*/
 %>
 <%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>
 <%!
 /**
  *将秒数时间格式化为如下格式：xx小时xx分xx秒
 */
 /**
 	public String formatDate(String mi){
    if(mi==null||"".equals(mi)||"0".equals(mi)){
			return "";
		}
		String result="0";
		int seconds=0;
		int temp=0;
		int temp1=0;
		int temp2=0;
		try {
			seconds=Integer.parseInt(mi);
			if(seconds<60){
				result=seconds+"秒";
			}else if(seconds<3600){
				temp=seconds/60;//分钟
				temp1=seconds%60;//秒
				result=temp+"分"+temp1+"秒";
			}else if(seconds>=3600){
				temp=seconds/3600;//小时
				temp1=seconds%3600;
				if(temp1==0){
					result=temp+"小时";
					return result;
				}
				temp2=temp1%60;
				temp1=temp1/60;//分钟
				if(temp2==0){
					result=temp+"小时"+temp1+"分";
					return result;
				}
				temp2=temp2%60;//秒
				result=temp+"小时"+temp1+"分"+temp2+"秒";
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			return result;
		}
		return result;
	}
	*/
 %>
 <%!
 //查询两个字符串的日期秒数的差值
 //s1是签入时间格式 yyyy-MM-dd hh:mi:ss
 //s2是签出时间格式 yyyy-MM-dd hh:mi:ss
 public long getDis(String s1, String s2){
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String t1 = s1.replace('-','/');
    String t2 = "";
    if(s2.length() > 0){
    	t2 = s2.replace('-','/');
    }else{
    	t2 = df.format(new Date()).replace('-','/');
    }
    long l = 0;
    try{
        Date dt1= new Date(t1);
        Date dt2= new Date(t2);
        l = dt2.getTime() - dt1.getTime();
    }catch(Exception e){

    }
		return l/1000;
	}
 %>
 <%!
 //String类型转变为long型
 public static final long intTolong(String value){
        long temp=0;
       if(!value.equals("")){
         temp = (long) Integer.parseInt(value);
        if(Integer.parseInt(value) < 0){
            temp = temp << 32;
            temp = temp >>> 32;
        }
        }
        return temp;
    }
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%!
		/**
		 函数说明: 输入一个基本的sql.然后页面参数模式是  [排序号_=_字段名] 或  [排序号_like_字段名]
		 其中column为查询字段.第一位是排序号.排序号不能重复.重复多个将保存一个值.且必须是数字.大小不限如1,11,123.
		 */
         public String[]  returnSql(HttpServletRequest request){
        StringBuffer buffer = new StringBuffer();
        StringBuffer bufferPara = new StringBuffer();

		   //输入语句.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
    String[] bingd= {"",""};
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
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%'||:v"
				+ objs[1].toString().replace('.','a') + "||'%%' ");
			bufferPara.append(",v"+objs[1].toString().replace('.','a')+"="+objs[2].toString().trim());
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " :v"
				+ objs[1].toString().replace('.','a') + "  ");

			bufferPara.append(",v"+objs[1].toString().replace('.','a')+"="+objs[2].toString().trim());
			}
		}
     bingd[0]=buffer.toString();
     bingd[1]=bufferPara.toString();
        return bingd;
}
%>

<%!
//导出Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){

        XLSExport e  =   new  XLSExport(null);
        String headname = "坐席签入签出班记录查询";//Excel文件名
        try {
        OutputStream os = response.getOutputStream();//取得输出流
        response.reset();//清空输出流
        response.setContentType("application/ms-excel");//定义输出类型
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//设定输出文件头
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][7],queryList[i][8],queryList[i][6]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
        }catch  (Exception e1) {
           e1.printStackTrace();
        }
    }
   public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>

<%
    String opCode="K17B";
    String opName="综合查询-坐席签入签出班记录查询";
    /*midify by yinzx 20091113 公共查询服务替换*/
 		String myParams=request.getParameter("para");
 		String[] strbind= {"",""};
	  String loginNo = (String)session.getAttribute("workNo");
	  String orgCode = (String)session.getAttribute("orgCode");
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
		String sqlStr = "select t1.login_no,t1.sign_in_name,to_char(t1.sign_in_time,'yyyy-Mm-dd hh24:mi:ss'),to_char(t1.sign_out_time,'yyyy-Mm-dd hh24:mi:ss'),to_char(t1.sign_in_time_long),to_char(t1.sign_out_time_long),t1.sign_in_ip,to_char(t1.sign_in_time_long/60,'FM9999990.0'),to_char(nvl(t1.sign_out_time_long,0)/60,'FM9999990.0'),t1.serial_no from dloginlog t1  ";
		String strCountSql="select to_char(count(*)) count from dloginlog t1  ";
		String strDateSql="";
    String strOrderSql=" order by t1.sign_in_time desc ";

    String start_date =  request.getParameter("start_date");       //开始时间
    String end_date   =  request.getParameter("end_date");         //结束时间
    String sign_in_ip  =  request.getParameter("0_=_t1.sign_in_ip");    //ip地址
    String login_no   =  request.getParameter("1_=_t1.login_no");     //工号
    String singIntime_is_null  =  "";     //2009/8/8 add合计签入时长标记

    if (request.getParameter("singIntime_is_null") != "" && request.getParameter("singIntime_is_null") != null){
        singIntime_is_null = "checked";
    }

    %>

    <%
  //2009/8/9 end
    //String grade_code =  request.getParameter("3_=_grade_code");   //类别
    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp="";
    String action = request.getParameter("myaction");
    String[] strHead= {"话务员工号","话务员姓名","签入时间","签出时间","签入时长（分）","签出时长（分）","ip地址"};
    //String[] content= {"登录座席","换班或退出座席","签入成功","签出成功","签入失败","签出失败"};
	  String expFlag = request.getParameter("exp");
		String sqlFilter = request.getParameter("sqlFilter");
	  //查询条件
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	   /*sql 语句优化 yinzx to_char 改为 to_date */
	  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
      	strDateSql=" where 1=1 and t1.sign_in_time>=to_date(:start_date,'yyyymmdd hh24:mi:ss') and t1.sign_in_time <=to_date(:end_date,'yyyymmdd hh24:mi:ss') ";
    	  myParams="start_date="+start_date.trim()+" ,end_date="+end_date.trim();

    	}
    	strbind=returnSql(request);
    	myParams+=strbind[1];

    	sqlFilter=strDateSql+strbind[0];
    }

%>

<%	if ("doLoad".equals(action)) {

		   //2009/8/9 add start
        if (singIntime_is_null != "" && singIntime_is_null != null){
            sqlStr = "select t1.login_no,t1.sign_in_name,to_char(Sum(nvl(sign_in_time_long,0))) from dloginlog t1  ";
		        strOrderSql=" Group By login_no ,sign_in_name ";
            strCountSql = "select Distinct t1.login_no from dloginlog t1 ";

            sqlStr+=sqlFilter+strOrderSql;
            sqlTemp = strCountSql + sqlFilter;
        }else{
       //2009/8/9 add end
          sqlStr+=sqlFilter+strOrderSql;
          sqlTemp = strCountSql+sqlFilter;
        }
    	  %>

					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="rowsC4"  scope="end"/>
					<%

					if(rowsC4.length!=0){
					//2009/8/9 add start
					  if (singIntime_is_null != "" && singIntime_is_null != null){
                rowCount = rowsC4.length;
            }else{
          //2009/8/9 add end
                rowCount = Integer.parseInt(rowsC4[0][0]);
                }
         }

        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
          	curPage = 1;
        }
        else {
        	curPage = Integer.parseInt(strPage);
          	if( curPage < 1 ) curPage = 1;
        }
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        //System.out.println("sql="+querySql);
        %>
         <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="11">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="10"   scope="end"/>
				<%
				dataRows = queryList;


    }

   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){
 			  sqlStr+=sqlFilter+strOrderSql;
        sqlTemp = strCountSql+sqlFilter;
    	  %>
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="rowsC4"  scope="end"/>
					<%
	      if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
          	curPage = 1;
        }
        else {
        	curPage = Integer.parseInt(strPage);
          	if( curPage < 1 ) curPage = 1;
        }
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        %>
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="11">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="10"   scope="end"/>
				<%
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){
   		sqlStr+=sqlFilter+strOrderSql;
%>
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="11">
						<wtc:param value="<%=sqlStr%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="10" scope="end"/>
<%
				this.toExcel(queryList,strHead,response);
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
<title>坐席签入签出班记录查询</title>

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

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
				$(this).css("color", "#159ee4");
			});
		}
	);

	function checkElement2() {
				checkElement(this);
		}
function getCallListen(id){
var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
//window.open("k170_getCallListen.jsp?flag_id="+id);
}
//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================

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
   if( document.sitechform.start_date.value == ""){
    	   showTip(document.sitechform.start_date,"开始时间不能为空");
    	   sitechform.start_date.focus();

    }else if(document.sitechform.end_date.value == ""){
		     showTip(document.sitechform.end_date,"结束时间不能为空");
    	   sitechform.end_date.focus();

    }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		     showTip(document.sitechform.end_date,"结束时间必须大于开始时间");
    	   sitechform.end_date.focus();

    }else if(month_interval > 1){
    		 showTip(document.sitechform.end_date,"只能查询2个月内的记录");
    		 sitechform.end_date.focus();
  	}else{
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    window.sitechform.sqlWhere.value="<%=sqlFilter%>";
    submitMe();
    	}
}
	  //2009/8/8 add start 新增合计签入时长功能
    function changeCheckBoxStatus(){
        var causeCheckBox= document.getElementById("singIntime_is_null");
				if(causeCheckBox.checked==true){
						window.sitechform.singIntime_is_null.value="checked";
				}
		}

		//2009/8/8 add end 新增合计签入时长功能
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="k1711_staffLoginQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
  }

//跳转到指定页面
function jumpToPage(operateCode){
	//alert(operateCode);
	 if(operateCode=="jumpToPage")
   {
   	  var thePage=document.getElementById("thePage").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
   		 doLoad('0');
   	  }
   }
   else if(operateCode=="jumpToPage1")
   {
   	  var thePage=document.getElementById("thePage1").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
       doLoad('0');
      }
   }else if(trim(operateCode)!=""){
   	 window.sitechform.page.value=parseInt(operateCode);
   	 doLoad('0');
   }
}
function doLoad(operateCode){

   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
   }
   else if(operateCode=="first")
   {
   	window.sitechform.page.value=1;
   }
   else if(operateCode=="pre")
   {
   	window.sitechform.page.value=<%=(curPage-1)%>;
   }
   else if(operateCode=="next")
   {
   	window.sitechform.page.value=<%=(curPage+1)%>;
   }
   else if(operateCode=="last")
   {
   	window.sitechform.page.value=<%=pageCount%>;
   }
    keepValue();
    submitMe();
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
      window.location="k1711_staffLoginQry.jsp";
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k1711_staffLoginQry.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.start_date.value="<%=start_date%>";
	window.sitechform.end_date.value="<%=end_date%>";
	window.sitechform.para.value="<%=myParams%>";
	window.sitechform.sign_in_ip.value="<%=sign_in_ip%>";
	window.sitechform.login_no.value="<%=login_no%>";
	if ("<%=singIntime_is_null%>" !="" && "<%=singIntime_is_null%>" !=null){
	  window.sitechform.singIntime_is_null.value="checked";
  }
}

//居中打开窗口
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//导出窗口
	function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
	  window.sitechform.sqlWhere.value="<%=sqlFilter%>";
	  window.sitechform.para.value="<%=myParams%>";

		openWinMid('k1711_expSelect.jsp?flag='+flag,'选择导出列',340,320);
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
function getSkillsDetail(serial_no){
		openWinMid('k1711_getSkillDetail.jsp?serial_no='+serial_no,'显示所选的技能队列',260,430);
}
</script>
</head>


<body >


<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
	<div id="Operation_Table">
		<table cellspacing="0" >
    <tr><td colspan='6' ><div class="title"><div id="title_zi">坐席签入签出班记录查询</div></div></td></tr>
     <tr >
      <td > 开始时间 </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > ip地址 </td>
      <td >
				<input id="sign_in_ip" name="0_=_t1.sign_in_ip" type="text" maxlength="14"   value=<%=(sign_in_ip==null)?"":sign_in_ip%> >

      </td>
		  <td > 话务员工号 </td>
      <td >
      <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="1_=_t1.login_no" type="text" id="login_no" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%=(login_no==null)?"":login_no%>">
      </td>
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td > 结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>

		<!--2009/8/8 add start-->

      <td > 合计签入时长 </td>
      <td >
        <input name ="singIntime_is_null" type="checkbox"  id="singIntime_is_null" onClick="changeCheckBoxStatus()"  <%=singIntime_is_null%> >
		  </td>
		  <td colspan="2">&nbsp;</td>
		<!--2009/8/8 add end-->
     </tr>
	 <tr >

    </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px">
       <!--zhengjiang 20091004 查询与重置换位置-->
       <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
			 <input name="delete_value" type="button"  id="add" value="重置" onClick="clearValue();return false;">
			 <input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
       <input name="exportAll" type="button"  id="add" value="导出全部"  <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('all')\"");%>>
      </td>
    </tr>
	</table>
	</div>
  <div id="Operation_Table">
  <table  cellspacing="0">
    <tr >
      <td colspan="8" align="left" class="Blue">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>
         <!--modify hucw 20100829<a>快速选择</a>-->
		    <span>快速选择</span>
				<select onchange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select>&nbsp;&nbsp;
        <!--modify hucw 20100829<a>快速跳转</a>-->
			<span>快速跳转</span>
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=粗体>GO</font>
        <%}%>
      </td>
    </tr>
  <% if (singIntime_is_null =="" || singIntime_is_null == null) {%>
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
			  <input type="hidden" name="para" value="">
          <tr >
          	<th align="center" class="blue" width="5%" >操作</th>
            <th align="center" class="blue" width="10%" >话务员工号</th>
            <th align="center" class="blue" width="10%" >话务员姓名</th>
            <th align="center" class="blue" width="10%" >签入时间  </th>
            <th align="center" class="blue" width="10%" >签出时间  </th>
            <th align="center" class="blue" width="10%" >签入时长（分）</th>
            <th align="center" class="blue" width="10%" >签出时长（分）</th>
            <th align="center" class="blue" width="10%" >ip地址    </th>
         </tr>
         <%
         		long signTotal = 0;
         %>
          <% for ( int i = 0; i < dataRows.length; i++ ) {
		          if(i == 0 && dataRows[0][3].length() == 0){
		         		//signTotal = signTotal + getDis(dataRows[0][2],"");
		         	}else if(i == 0 && dataRows[0][3].length() > 0){
		         		signTotal = signTotal + getDis(dataRows[0][2],dataRows[0][3]);
		         	}else{
		         		signTotal = signTotal + intTolong(dataRows[i][4]);
		         	}
              String tdClass="";
          %>
		          <%if((i+1)%2==1){
		          	tdClass="grey";
		          %>
							<%}else{%>
							<%}%>
					<tr>
						<td align="center" class="<%=tdClass%>"  >
					  <script>
					  document.write('<img style="cursor:hand" onclick="getSkillsDetail(\'<%=dataRows[i][9]%>\');return false;" alt="显示所签入的技能队列情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');	
					  </script>
					  </td>
			      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
			      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
			      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
			      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
			      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
			      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
			      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
    			</tr>
     		 <% } %>
		     <tr>
		     	<td align="right" colspan="4">合计签入时长</td>
		     	<td colspan="4"><%=signTotal/60 %>(分钟)</td>
		    </tr>
  <!--2009/8/8 start 新增坐席签入系统时长功能-->
  <% }else {%>
        <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
			  <input type="hidden" name="para" value="">
          <tr >
            <th align="center" class="blue" width="10%" >话务员工号</th>
            <th align="center" class="blue" width="10%" >话务员姓名</th>
            <th align="center" class="blue" width="10%" >合计签入时长(分钟) </th>
          </tr>
          <%
             long tempLong = 0;
             String  tempStr = "";
          %>
          <% for ( int i = 0; i < dataRows.length; i++ ) {
              if(dataRows[i][2].length() > 0){
		         		 tempLong = intTolong(dataRows[i][2]);
		         		 tempLong = tempLong/60;
		         		 tempStr  = tempLong + "";
		         	}
              String tdClass="";
              if((i+1)%2==1){
                  tdClass="grey";
          %>
            <%}else{%>
	          <%}%>
	         <tr>
            <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
            <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
            <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?tempStr:"&nbsp;"%></td>
           </tr>
          <%}%>
  <%}%>
  <!--2009/8/8 end 新增坐席签入系统时长功能-->
    <tr >
      <td class="Blue" align="right" colspan="8">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>
        <!--modify hucw 20100829<a>快速选择</a>-->
		    <span>快速选择</span>
				<select onchange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select>&nbsp;&nbsp;
       <!--modify hucw 20100829<a>快速跳转</a>-->
			<span>快速跳转</span>
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=粗体>GO</font>
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
<!--
<%@ include file="/npage/include/footer.jsp"%>
-->
</body>
</html>