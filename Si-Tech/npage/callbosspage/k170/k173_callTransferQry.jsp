<%
  /*
   * 功能: 来电转接查询
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者: donglei 
　 * 版权: sitech
   * modify by yinzx 20091004
   * modify by yinzx 20091116 sql 优化
 　*/
 
 %>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
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
    public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>

<%!
//导出Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " 开始导出Excel文件 " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "来电转接查询";//Excel文件名
        try {
        OutputStream os = response.getOutputStream();//取得输出流
        response.reset();//清空输出流
        response.setContentType("application/ms-excel");//定义输出类型
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//设定输出文件头
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],queryList[i][8]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
           System.out.println( " 导出Excel文件[成功] ");
        }catch  (Exception e1) {
           System.out.println( " 导出Excel文件[失败] ");
           e1.printStackTrace();
        } 
    }
%>

<%
    String opCode="k173";
    String opName="综合查询-来电转接查询";
	  String loginNo = (String)session.getAttribute("workNo");  
	  /*midify by yinzx 20091113 公共查询服务替换*/
 		String myParams=request.getParameter("para");     
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String kf_longin_no=(String)session.getAttribute("kfWorkNo");	  
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
        //modified by liujied 20090922
        //String sqlStr = "select contact_id,ransfer_kf_login_no,accept_kf_login_no,caller_phone,to_char(accept_date,'yyyy-MM-dd hh24:mi:ss'),sltranstype_name,skill_quence,decode(transfer_type,'0','呼叫转移','1','拦截','2','内部求助','3','内部呼叫','4','三方应答','5','夜班抢答','7','旁听','8','插入','9','拦截','10','强制示闲','11','强制示忙','12','强制签出'),decode(success_flag,'Y','成功','N','失败') from dcalltransfer t1,sltranstype t2 ";
          String sqlStr = "select contact_id,transfer_login_no,accept_login_no,decode(t3.boss_login_no,null,t1.caller_phone,t3.boss_login_no),to_char(accept_date,'yyyy-MM-dd hh24:mi:ss'),sltranstype_name,skill_quence,decode(transfer_type,'0','呼叫转移','1','拦截','2','内部求助','3','内部呼叫','4','三方应答','5','夜班抢答','7','旁听','8','插入','9','拦截','10','强制示闲','11','强制示忙','12','强制签出'),decode(success_flag,'Y','成功','N','失败') from dcalltransfer t1,sltranstype t2,dloginmsgrelation t3	";

		String strCountSql="select to_char(count(*)) count  from dcalltransfer t1,sltranstype t2,dloginmsgrelation t3 ";
		String strDateSql="";
    String strOrderSql=" order by accept_date desc ";
    String strJoinSql=" and t1.transfer_type=t2.sltranstype_code(+) ";
    
   
    String start_date        =  request.getParameter("start_date");           
    String end_date          =  request.getParameter("end_date");             
    String contact_id        =  request.getParameter("0_=_contact_id");       
    String transfer_login_no =  request.getParameter("1_=_transfer_login_no");
    String accept_login_no   =  request.getParameter("2_=_accept_login_no");  
    String oper_type         =  request.getParameter("3_=_transfer_type");        
    String[][] dataRows = new String[][]{};
    String[] strbind= {"",""};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String param = "";
    String sqlTemp="";
    String action = request.getParameter("myaction");
    String[] strHead= {"流水号","转接/拦截工号","受理/被拦截工号","主叫号码","受理时间","操作类型","技能队列","转接类型","结果"};
    //String[] conTransferType = {"呼叫转移","拦截","内部求助","内部呼叫","三方应答","夜班抢答"};
	  String expFlag = request.getParameter("exp"); 
    String sqlFilter = request.getParameter("sqlFilter");
	  //查询条件
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
      strDateSql=" where 1=1 and  accept_date>=to_date(:start_date,'yyyymmdd hh24:mi:ss')  and accept_date <=to_date(:end_date ,'yyyymmdd hh24:mi:ss') ";
      myParams="start_date="+start_date.trim()+" ,end_date="+end_date.trim();
    	}
    	strbind=returnSql(request);
    	myParams+=strbind[1];
    	sqlFilter=strDateSql+strbind[0]+strJoinSql;
    }
       sqlFilter += " and t1.caller_phone  = t3.kf_login_no(+) ";
        
  /*取当前登陆工号的角色ID，为逗号分割的字符串 hanjc add 20090423*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	if(powerCode==null) {
			powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
  String isCommonLogin="N";	
	/*
	 *是否是话务员 update by hanjc 20090719
        *01120O04为培训角色id,01120O0E为质检角色id,011202为客户电话营业厅，01120O02是普通座席
        *01120O02011202和01120201120O02是客户电话营业厅和普通座席两个角色的拼接
        *话务员只有客户电话营业厅和普通座席两个角色,即01120O02011202和01120201120O02，不包括小组长。
	 */
    	/* modify by yinzx 20090826 由于山西代码写的较乱，而且写死角色信息 所以改造，并运行时调整
      //add by hanjc 20090719 判断当前工号是否是话务员。
      if(powerCodeArr.length==2){
         String tempVal = powerCodeArr[0].trim()+powerCodeArr[1].trim();
         if("01120O02011202".equals(tempVal)||"01120201120O02".equals(tempVal)){
		isCommonLogin="Y";	
         }
       } 
   *//*add by yinzx 090826*/
   for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<HUAWUYUAN_ID.length; j++){
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
				isCommonLogin="Y";
			}
		}
	}
    
%>	
			
<%	if ("doLoad".equals(action)) {
        sqlStr+=sqlFilter+strOrderSql;
        sqlTemp = strCountSql+sqlFilter;
        //out.println(sqlStr);
        
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

        //System.out.println("---------------------");
        //System.out.println(querySql);
        //System.out.println("---------------------");
        %>		           
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="10">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="9"   scope="end"/>
				<%
				dataRows = queryList;
				//if(queryList!=null){
				//	out.println("queryList:\t"+queryList.length);
				//	out.println("retCode:\t"+retCode);
				//}
    }
    
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
        sqlStr+=sqlFilter+strOrderSql;
        sqlTemp = strCountSql+sqlFilter;
        //out.println(sqlStr);
    	  %>	             
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service> 
					<wtc:array id="rowsC4"  scope="end"/>	
					<%             
	      rowCount = Integer.parseInt(rowsC4[0][0]);
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
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="10">
             <wtc:param value="<%=querySql%>"/>
             <wtc:param value="<%=myParams%>"/>
           </wtc:service>
           <wtc:array id="queryList"  start="0" length="9"   scope="end"/>
				<%
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){   
   		sqlStr+=sqlFilter+" and t1.oper_code=t2.sltranstype_code(+)"+strOrderSql; 
%>	
				<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
				  <wtc:param value="<%=sqlStr%>"/>
				  <wtc:param value="<%=myParams%>"/>
				</wtc:service>
				<wtc:array id="queryList" start="0" length="9" scope="end"/>	
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
				width: 15em;
				font-size: 1em;
		}
		
		.xxxxx{
			  color:#159ee4;
		}	
</style>	
<title>来电转接查询</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("tr").not("[input]").addClass("blue");
	    $("th").css("color","#3366FF").css("font-weight","bold");
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
// 录音听取----开始		
function doProcessNavcomring(packet)	 
	 {
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("处理成功!");
	    	}else{
	    		//alert("处理失败!");
	    		return false;
	    	}
	    }
	 } 
 function doLisenRecord(filepath,contact_id)
{
		   window.top.document.getElementById("recordfile").value=filepath;
		   window.top.document.getElementById("lisenContactId").value=contact_id;
		  window.top.document.getElementById("K042").click();
			var packet = new AJAXPacket("../../../npage/callbosspage/K042/lisenRecord.jsp","正在处理,请稍后...");
	     packet.data.add("retType" ,  "chkExample");
	     packet.data.add("filepath" ,  filepath);
	     packet.data.add("liscontactId" ,contact_id);
	    core.ajax.sendPacket(packet,doProcessNavcomring,true);
			packet =null;
}
//判断该流水对应文件是单个还是多个
function checkCallListen(id,staffno){
		if(id==''){
		return;
		}
		if('<%=isCommonLogin%>'=='Y'){
			if('<%=kf_longin_no%>'!=staffno){
			  rdShowMessageDialog("您没有听取该录音的权限！");
			  return;
		  }
		}		
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("contact_id",id);
	core.ajax.sendPacket(packet,doProcessGetPath,false);
	packet=null;
}		
function doProcessGetPath(packet){
   var file_path = packet.data.findValueByName("file_path");
   var flag = packet.data.findValueByName("flag");
   var contact_id = packet.data.findValueByName("contact_id"); 
   if(flag=='Y'){
   	doLisenRecord(file_path,contact_id);
   	}else{
   	getCallListen(contact_id)	;
   	}
}				
function getCallListen(id){
//var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
openWinMid("k170_getCallListen.jsp?flag_id="+id,'录音听取',650,850);
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

    }/*else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
		     showTip(document.sitechform.end_date,"只能查询一个月内的记录"); 
    	   sitechform.end_date.focus(); 	

    }*/else{
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    window.sitechform.sqlWhere.value="<%=sqlFilter%>";  
    submitMe();
    	}
}
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="k173_callTransferQry.jsp";
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
  window.location="k173_callTransferQry.jsp";
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k173_callTransferQry.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

//显示通话详细信息
function getCallDetail(contact_id,start_date){
		if(contact_id==''){
		return;
		}
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    openWinMid(path,"信息详情",680,960);
	return true;
}
 //保留查询的值
function keepValue(){
	 window.sitechform.start_date.value="<%=start_date%>";//为显示详细信息页面传递开始时间
	 window.sitechform.end_date.value="<%=end_date%>";
   window.sitechform.sqlFilter.value="<%=sqlFilter%>";
   window.sitechform.para.value="<%=myParams%>";
   window.sitechform.operText.value="<%=request.getParameter("operText")%>";
   window.sitechform.oper_type.value="<%=request.getParameter("3_=_transfer_type")%>";
   
   window.sitechform.transfer_login_no.value="<%=transfer_login_no%>";
   window.sitechform.accept_login_no.value="<%=accept_login_no%>";
   window.sitechform.contact_id.value="<%=contact_id%>";
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
		openWinMid('k173_expSelect.jsp?flag='+flag,'选择导出列',340,320);
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
    <!--
    <%@ include file="/npage/include/header.jsp"%>
    -->
    <div id="Operation_Table">
      <table cellspacing="0" >
        <tr>
        	<td colspan='6' >
        	<div class="title">
        		<div id="title_zi">来电转接查询</div>
        	</div>
        	</td>
       	</tr>
        <tr >
          <td nowrap > 开始时间 </td>
          <td nowrap>
	    			<input  id="start_date" name="start_date" type="text"  value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);changeSize(2);" onchange="changeSize(1)">
              <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);changeSize(2);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                <font color="orange">*</font>
          </td>
              
          <td nowrap> 转接/拦截工号 </td>
          <td >
              <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
							<input id="transfer_login_no" name="1_=_transfer_login_no" type="text" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"  value=<%=(transfer_login_no==null)?"":transfer_login_no%> >
          </td>
	      	<td > 受理/被拦截工号 </td>
          <td >
              <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
							<input name ="2_=_accept_login_no" type="text" id="accept_login_no" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%=(accept_login_no==null)?"":accept_login_no%>">
          </td>
        </tr>
<!-- THE SECOND LINE OF THE CONTENT -->
				<tr>
				  <td nowrap > 结束时间 </td>
				  <td nowrap>
				    <input id="end_date" name ="end_date" type="text"  value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);" onchange="changeSize(1)">
				      <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
							<font color="orange">*</font>
				  </td> 
				  <td > 流水号</td>
				  <td >
				   <!--zhengjiang 20091010添加onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->   
						<input id="contact_id" name="0_=_contact_id" type="text" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value=<%=(contact_id==null)?"":contact_id%> > 
					</td>
				  <td > 操作类型 </td>
				  <td >
						<select id="oper_type" name="3_=_transfer_type" size="1"  onchange="operText.value=this.options[this.selectedIndex].text">
					  <%if(oper_type==null || oper_type.equals("")|| request.getParameter("operText").equals("")|| request.getParameter("operText")==null){%>
						   <option value="">--所有操作类型--</option> 
						   <option value="0">呼叫转移转接</option> 
						   <option value="9">拦截转接</option>  	 		
				    <%}else {%>
					    <option value="">--所有操作类型--</option> 		  	
					    <option value="0">呼叫转移转接</option> 
							<option value="9">拦截转接</option>  	 		
				    <%}%>
				    </select>
				    <input name="operText" type="hidden" value="<%=request.getParameter("operText")%>">
				    </select>
				  </td>        
				</tr>
				    <!-- THE THIRD LINE OF THE CONTENT -->
				    <!-- ICON IN THE MIDDLE OF THE PAGE-->
				<tr >
				  <td colspan="8" align="center" id="footer" style="width:420px">
				        <!--zhengjiang 20091004 查询与重置换位置--> 
				     <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
					   <input name="delete_value" type="button"  id="add" value="重置" onClick="clearValue();return false;">      
					   <!--input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('cur')\"");%>>
				     <input name="exportAll" type="button"  id="add" value="导出全部" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('all')\"");%>-->
				     <input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
				     <!--<input name="exportAll" type="button"  id="add" value="导出全部" onClick="showExpWin('all')">-->
				  </td>
				</tr>
	  </table>    
	</div>
  <div id="Operation_Table">
  	  <table  cellspacing="0">
            <tr >
              <td align="left" colspan="9">
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
      <select onchange="jumpToPage(this.value)">
        <%for(int i=1;i<=pageCount;i++){
        	          out.print("<option value='"+i+"'");
        	          if(i==curPage){
        	          out.print("selected");
        	          }
        	          out.print(">"+i+"</option>");
                          }%>
                  </select style="height:18px">&nbsp;&nbsp;
        <!--modify hucw 20100829<a>快速跳转</a>-->
        <span>快速跳转</span> 
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
          <font face=粗体>GO</font>        
          <%}%>
        </td>
      </tr>

      <input type="hidden" name="page" value="">
			<input type="hidden" name="myaction" value="">
	  	<input type="hidden" name="sqlFilter" value="">
	    <input type="hidden" name="sqlWhere" value="">
	    <input type="hidden" name="para" value="">
              <tr >
                <script>
       	          var tempBool ='flase';
      	          if(checkRole(K173A_RolesArr)==true||checkRole(K173B_RolesArr)==true){	
      		  document.write('<th align="center" class="blue" width="15%" > 操作 </th>');	
      		  tempBool='true';
      	          }
                </script>  
                <th align="center" width="10%" nowrap > 流水号 </th>
                <th align="center" width="8%" nowrap > 转接/拦截工号</th>
                <th align="center" width="8%" nowrap > 受理/被拦截工号</th>
                <th align="center" width="8%" nowrap > 主叫号码 </th>
                <th align="center" width="8%" nowrap > 受理时间</th>
           <!--    <th align="center" class="blue" width="8%" nowrap > 操作类型</th>-->
                <th align="center" width="8%" nowrap > 技能队列 </th>
                <th align="center" width="8%" nowrap > 转接类型</th>
                <th align="center" width="8%" nowrap > 结果</th>
              </tr>

              <% for ( int i = 0; i < dataRows.length; i++ ) {             
                                      String tdClass="";
                                      if((i+1)%2==1){
                                      tdClass="grey";
                                      }
                                      %>
	         <tr>
                   <script>
      	             if(tempBool=='true'){
      		     document.write('<td align="center" class="<%=tdClass%>"  >');
      	               }      	
      	               if(checkRole(K173A_RolesArr)==true){	
      		       document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][2]%>\');return false;" alt="听取语音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	                 }
                         if(checkRole(K173B_RolesArr)==true){	
      		         document.write('<img style="cursor:hand" onclick="getCallDetail(\'<%=dataRows[i][0]%>\',\'<%=start_date%>\');return false;" alt="显示该通话的详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');	
      	                   }
                           if(tempBool=='true'){
      		           document.write('</td>');
      	                 }      	
                       </script>      	
                       <!--
                           <img onclick="checkCallListen('<%=dataRows[i][0]%>');return false;" alt="听取语音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">
                             <img onclick="getCallDetail('<%=dataRows[i][0]%>','<%=start_date%>');return false;" alt="显示该通话的详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif" width="16" height="16" align="absmiddle">
                               -->
                     <td align="center" nowrap ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
                     <td align="center" nowrap ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
                     <td align="center" nowrap ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
                     <td align="center" nowrap ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
                     <td align="center" nowrap ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
                   <!--  <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td> -->
                     <td align="center" nowrap ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
                     <td align="center" nowrap ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
                     <td align="center" nowrap ><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
                     </tr>
                     <% } %>
 
                     <tr >
                       <td align="right" colspan="9">
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
              <select onchange="jumpToPage(this.value)">
                <%for(int i=1;i<=pageCount;i++){
        	                  out.print("<option value='"+i+"'");
        	                  if(i==curPage){
        	                  out.print("selected");
        	                  }
        	                  out.print(">"+i+"</option>");
                                  }%>
                          </select style="height:18px">&nbsp;&nbsp;
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

