<%
  /*
   * 功能: 呼叫保持记录
　 * 版本: 1.0
　 * 日期: 2008/10/14
　 * 作者: donglei 
　 * 版权: sitech
   * 
   *  
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
<%
//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
    String opCode="K179";
    String opName="综合查询-呼叫保持记录查询";
     /*midify by yinzx 20091113 公共查询服务替换*/
 		String myParams=request.getParameter("para");     
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String kf_longin_no=(String)session.getAttribute("kfWorkNo");	  	  
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
  	String sqlStr = "select t1.contact_id,t2.cust_name,t2.accept_phone,t2.caller_phone,to_char(t2.begin_date,'yyyy-MM-dd hh24:mi:ss'),to_char(t2.accept_long),t2.accept_login_no,t3.hangup_name,decode(t2.qc_flag,'Y','是','N','否','','否',NULL,'否'),";
           sqlStr +=" decode(trim(t1.op_type),'1','保持','2','内部求助'),to_char(t1.begin_time,'yyyy-MM-dd hh24:mi:ss'),to_char(t1.end_time,'yyyy-MM-dd hh24:mi:ss'),t2.accept_kf_login_no from dcallhangup t1, staffhangup t3,dcallcall";
		String strCountSql="select to_char(count(*)) count  from dcallhangup t1, dcallcall";
		String strAcceptLogSql="";
		String strDateSql="";
		String strOrderSql=" order by t1.begin_time desc ";
    String start_date        =  request.getParameter("start_date");                        
    String end_date          =  request.getParameter("end_date");                          
    String contact_id        =  request.getParameter("0_=_t1.contact_id");                 
    String staffcity         =  request.getParameter("17_=_t2.staffcity");
    //modified by liujied 20090921 改为使用BOSS工号查询
    String accept_login_no   =  request.getParameter("2_=_t2.accept_login_no");            
    String accept_phone      =  request.getParameter("3_=_t2.accept_phone");               
    String mail_address      =  request.getParameter("4_=_t2.mail_address");               
    String contact_address   =  request.getParameter("5_=_t2.contact_address");            
    String grade_code        =  request.getParameter("6_=_t2.grade_code");                 
    String contact_phone     =  request.getParameter("7_=_t2.contact_phone");              
    String caller_phone      =  request.getParameter("8_=_t2.caller_phone");   //主叫号码  
    String op_type           =  request.getParameter("9_=_t1.op_type");                    
    String cust_name         =  request.getParameter("10_=_t2.cust_name");                 
    String fax_no            =  request.getParameter("11_=_t2.fax_no");                    
    String acceptid          =  request.getParameter("13_=_t2.acceptid");   
    String con_id            =  request.getParameter("con_id");                     
    String[][] dataRows = new String[][]{};
    String[] strbind= {"",""};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp ="";
    String action = request.getParameter("myaction");
    String sqlFilter = request.getParameter("sqlFilter");
	  //查询条件
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
       strDateSql=start_date.substring(0,6)+" t2 where 1=1 and t1.contact_id=t2.contact_id ";
       strDateSql+=" and  t1.begin_time >= to_date(:start_date ,'yyyy-mm-dd hh24:mi:ss') and t1.begin_time <= to_date(:end_date, 'yyyy-mm-dd hh24:mi:ss') ";
			 myParams="start_date="+start_date.trim()+" ,end_date="+end_date.trim();
    	}
    	strbind=returnSql(request);
    	myParams+=strbind[1];
    	sqlFilter=strDateSql+strbind[0];
    }    
        
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
       sqlStr+=sqlFilter+" and t2.staffhangup=t3.hangup_code(+)"+strOrderSql;
       sqlTemp =strCountSql+sqlFilter;
    	  %>	             
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
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
        System.out.println("sql="+querySql);
        %>		           
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="14">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="13"   scope="end"/>
				<%
				dataRows = queryList;
				if(con_id!=null){
   //记录与客户接触日志
   strAcceptLogSql="insert into dbcalladm.wloginopr (login_accept,op_code,org_code,op_time,op_date,phone_no,login_no,contact_id,flag,contact_flag) values(SEQ_WLOGINOPR.NEXTVAL,:v1,:v2,sysdate,to_char(sysdate,'yyyymmdd'),:v3,:v4,:v5,'I','Y')&&"+opCode+"^"+orgCode+"^"+accept_phone+"^"+loginNo+"^"+con_id;
   List sqlList=new ArrayList();
   String[] sqlArr = new String[]{};
   sqlList.add(strAcceptLogSql);
   sqlArr = (String[])sqlList.toArray(new String[0]);
   String outnum = String.valueOf(sqlArr.length + 1);  
    %>
    <wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
    <%
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
				height: 1.5em;
				width: 14.6em;
				font-size: 1em;
		}
  </style>	
<title>呼叫保持记录查询</title>
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

    }else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
		     showTip(document.sitechform.end_date,"只能查询一个月内的记录"); 
    	   sitechform.end_date.focus(); 	

    }else{
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);   
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    window.sitechform.sqlWhere.value="<%=sqlFilter%>";     
    submitMe('0');
    
   }
}
function submitMe(flag){
   window.sitechform.myaction.value="doLoad";
       if(flag=='0'){
		 var vCon_id='';
		 var objSwap=window.top.document.getElementById('contactId');
		if(objSwap!=null&&objSwap!=null!=''){
			vCon_id=objSwap.value;
		}
       window.sitechform.action="k179_callHangupQry.jsp?con_id="+vCon_id;
		}else{
			 window.sitechform.action="k179_callHangupQry.jsp";
		}
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
	  var str='1';
   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
   	str='0';
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
    submitMe(str); 
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
  window.location="k179_callHangupQry.jsp";
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k179_callHangupQry.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}
//导出窗口
function showExpWin(flag){
	window.sitechform.page.value="<%=curPage%>";
  window.sitechform.sqlWhere.value="<%=sqlFilter%>";
  window.sitechform.para.value="<%=myParams%>";
	openWinMid('k179_expSelect.jsp?flag='+flag,'选择导出列',340,320);
 }

//显示通话详细信息
function getCallDetail(contact_id,start_date){
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    openWinMid(path,"信息详情",680,960);
	return true;
}

function keepValue(){
	 window.sitechform.start_date.value="<%=start_date%>";//为显示详细信息页面传递开始时间
   window.sitechform.sqlFilter.value="<%=sqlFilter%>";
   window.sitechform.end_date.value="<%=end_date%>";
   
   window.sitechform.grade.value="<%=request.getParameter("grade")%>";
   window.sitechform.accid.value="<%=request.getParameter("accid")%>";
   window.sitechform.opType.value="<%=request.getParameter("opType")%>";
   window.sitechform.oper.value="<%=request.getParameter("oper")%>";
   window.sitechform.staffcity.value="<%=request.getParameter("17_=_t2.staffcity")%>";
   window.sitechform.grade_code.value="<%=request.getParameter("6_=_t2.grade_code")%>";
   window.sitechform.acceptid.value="<%=request.getParameter("13_=_t2.acceptid")%>";
   window.sitechform.op_type.value="<%=request.getParameter("9_=_t1.op_type")%>";
   
   window.sitechform.contact_id.value="<%=contact_id%>";
   window.sitechform.mail_address.value="<%=mail_address%>";
   window.sitechform.accept_login_no.value="<%=accept_login_no%>";
   window.sitechform.accept_phone.value="<%=accept_phone%>";
   window.sitechform.contact_address.value="<%=contact_address%>";
   window.sitechform.contact_phone.value="<%=contact_phone%>";
   window.sitechform.caller_phone.value="<%=caller_phone%>";
   window.sitechform.cust_name.value="<%=cust_name%>";
   window.sitechform.fax_no.value="<%=fax_no%>";
   window.sitechform.para.value="<%=myParams%>";

}

//居中打开窗口
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

function qualityEval(){
	rdShowMessageDialog("对该流水号进行质检考评",2);
}


//判断当前工号是否有该流水工号的质检计划
function checkIsHavePlan(serialnum,flag,staffno){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","正在进行计划校验，请稍候......");
	mypacket.data.add("serialnum",serialnum);
  mypacket.data.add("start_date",window.sitechform.start_date.value);
  mypacket.data.add("flag",flag);
  mypacket.data.add("staffno",staffno);  
  core.ajax.sendPacket(mypacket,doProcessIsHavePlan,true);
	mypacket=null;
}

function doProcessIsHavePlan(packet){
	var serialnum = packet.data.findValueByName("serialnum");
	var planCounts = packet.data.findValueByName("planCounts");
	var flag = packet.data.findValueByName("flag");
  var staffno = packet.data.findValueByName("staffno");	
	//alert(parseInt(checkList)+parseInt(checkMutList));
  if(parseInt(planCounts)>0){
  	planInQua(serialnum,staffno,flag);
    //checkIsQc(serialnum,flag,staffno);
	}else{
		rdShowMessageDialog("您目前无该工号的质检计划！");
	}
}

//质检前判断是否已被质检过
//flag 0:计划外质检 1:计划内质检
function checkIsQc(serialnum,flag,staffno){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsQc_rpc.jsp","正在进行已质检校验，请稍候......");
	mypacket.data.add("serialnum",serialnum);
  mypacket.data.add("start_date",window.sitechform.start_date.value);
  mypacket.data.add("flag",flag);
  mypacket.data.add("staffno",staffno);  
  core.ajax.sendPacket(mypacket,doProcess,true);
	mypacket=null;
}

function doProcess(packet){
	var serialnum = packet.data.findValueByName("serialnum");
	var checkList = packet.data.findValueByName("checkList");
	var isOutPlanflag = packet.data.findValueByName("flag");
  var staffno = packet.data.findValueByName("staffno");	
	//alert(parseInt(checkList)+parseInt(checkMutList));
  if(parseInt(checkList)<1){
    planInQua(serialnum,staffno);
	}else{
		rdShowMessageDialog("该流水已经进行过质检，不能重复进行！");
	}
}
/**
  *
  *弹出对流水进行质检窗口
  */
function planInQua(serialnum,staffno,flag){
	var start_date = window.sitechform.start_date.value
	var  path = '/npage/callbosspage/checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum + '&staffno=' + staffno+ '&flag=' + flag + '&start_date=' + start_date;
	//计划内质检tabid为流水加0，计划外质检为流水加1
	if(!parent.parent.document.getElementById(serialnum+0)){
	parent.parent.addTab(true,serialnum+0,'执行质检计划',path);
  }
	//var param  = 'dialogWidth=900px;dialogHeight=300px';
	//window.showModalDialog('../checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno, '', param);	
	//window.open('../checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno, '', 'width=900px;height=300px');
	//openWinMid('../checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno, '', 300,900);
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
	<div id="Operation_Table" style="width:100%;" >
		<table cellspacing="0" >
			 <tr><td colspan='6' ><div class="title"><div id="title_zi">呼叫保持记录</div></div></td></tr>
       <tr >
      <td > 开始时间 </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > 员工地市 </td>
      <td >
			 <select id="staffcity" name="17_=_t2.staffcity" size="1"  onchange="oper.value=this.options[this.selectedIndex].text">
        <%if(staffcity==null || staffcity.equals("")|| request.getParameter("oper")==null || request.getParameter("oper").equals("")){%>
			 	<option value="" selected>--所有员工地市--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>			 	
			 	<%}else {%>
      	 	 	<option value="" >--所有员工地市--</option>			 	
      	 			<option value="<%=staffcity%>" selected >
      	 				<%=request.getParameter("oper")%>
      	 			</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' and region_code<>'<%=staffcity%>' order by region_code</wtc:sql>
				  </wtc:qoption>      	 	 	
      	 	<%}%>
        </select>
        <input name="oper" type="hidden" value="<%=request.getParameter("oper")%>">
      </td>
            <td > 流水号 </td>
      <td >
      <!--zhengjiang 20091010添加onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
				<input id="contact_id" name="0_=_t1.contact_id"  type="text" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value=<%=(contact_id==null)?"":contact_id%>>
      </td>
          </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
     <td > 结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text"  value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onClick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
     <td > 电子邮件 </td>
      <td >
			  <input name="4_=_t2.mail_address" type="text" maxlength="80"  id="mail_address"  value="<%=(mail_address==null)?"":mail_address%>">
      </td>

      	  <td > 联系电话 </td>
      <td >
			  <input name ="7_=_t2.contact_phone" type="text" id="contact_phone"  value="<%=(contact_phone==null)?"":contact_phone%>">
		  </td>
		       </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
       <tr > 
		  <td > 主叫号码 </td>
      <td >
			  <input name ="8_=_t2.caller_phone" type="text" id="caller_phone"  value="<%=(caller_phone==null)?"":caller_phone%>" onKeyUp="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td> 
		        <td > 联系地址 </td>
      <td >
			  <input name ="5_=_t2.contact_address" type="text" id="contact_address"  value="<%=(contact_address==null)?"":contact_address%>">
		  </td>          

      <td > 客户级别 </td>
      <td >
			  <select name="6_=_t2.grade_code"  id="grade_code" size="1" onChange="grade.value=this.options[this.selectedIndex].text">
			  	<%if(grade_code==null || grade_code.equals("") || request.getParameter("grade").equals("") || request.getParameter("grade")==null){%>
			  	 <option value="" selected>--所有客户级别--</option>
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from scallgradecode</wtc:sql>
				</wtc:qoption>			  	 
			  	<%}else {%>
      	 	 	<option value="" >--所有客户级别--</option>			  	
			  	    <option value="<%=grade_code%>" selected >
      	 				<%=request.getParameter("grade")%>
      	 			</option>
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from scallgradecode where accept_code<>'<%=grade_code%>'</wtc:sql>
				</wtc:qoption>      	 	 	
      	 	<%}%>
        </select>
				<input name="grade" type="hidden" value="<%=request.getParameter("grade")%>"> 
		  </td> 
		       </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
       <tr >
		        <td > 受理工号 </td>
      <td >
      <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="2_=_t2.accept_login_no" type="text" id="accept_login_no" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%=(accept_login_no==null)?"":accept_login_no%>">
      </td>
            <td > 客户姓名 </td>
      <td >
			  <input name ="10_=_t2.cust_name" type="text" id="cust_name"  value="<%=(cust_name==null)?"":cust_name%>">
		  </td>  

		  <td > 保持类型 </td>
      <td >
      	 <select name="9_=_t1.op_type" id="op_type" size="1" onChange="opType.value=this.options[this.selectedIndex].text">
				<%if(op_type==null  || op_type.equals("") || request.getParameter("opType").equals("")|| request.getParameter("opType")==null){%>
		  	<option value="" selected>--所有保持方式--</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select hold_code , hold_code|| '-->' ||hold_name from SHOLDTYPE</wtc:sql>
				</wtc:qoption>		  	
		  	<%}else {%>
          <option value="" >--所有保持方式--</option>
      	 		<option value="<%=op_type%>" selected >
      	 			<%=request.getParameter("opType")%>
      	 		</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select hold_code , hold_code|| '-->' ||hold_name from SHOLDTYPE where hold_code<>'<%=op_type%>'</wtc:sql>
				</wtc:qoption>      	 	 	
      	 	<%}%>
        </select>
        <input name="opType" type="hidden" value="<%=request.getParameter("opType")%>">
        </select>
		  </td>          
           </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
       <tr >
      <td > 受理号码 </td>
      <td >
			  <input name ="3_=_t2.accept_phone"  maxlength="15" type="text" id="accept_phone"  value="<%=(accept_phone==null)?"":accept_phone%>" onKeyUp="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
      </td> 
		        <td > 传真号码 </td>
      <td >
			  <input name ="11_=_t2.fax_no" type="text" id="fax_no"  value="<%=(fax_no==null)?"":fax_no%>">
		  </td> 
		        <td > 受理方式 </td>
      <td >
		  <select name="13_=_t2.acceptid" id="acceptid" size="1" onChange="accid.value=this.options[this.selectedIndex].text">
		  	<%if(acceptid==null || acceptid.equals("") || request.getParameter("accid").equals("")|| request.getParameter("accid")==null){%>
		  	<option value="" selected>--所有受理方式--</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE</wtc:sql>
				</wtc:qoption>		  	
		  	<%}else {%>
      	 	 	<option value="" >--所有受理方式--</option>		  	
      	 			<option value="<%=acceptid%>" selected >
      	 				<%=request.getParameter("accid")%>
      	 			</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE where accept_code<>'<%=acceptid%>'</wtc:sql>
				</wtc:qoption>      	 	 	
      	 	<%}%>
        </select>
        <input name="accid" type="hidden" value="<%=request.getParameter("accid")%>"> 
		  </td>    
     </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px">
       <!--zhengjiang 20091004 查询与重置换位置--> 
       <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
       <input name="delete_value" type="button"  id="add" value="重置" onClick="clearValue();return false;">
			 <input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
        <!--<input name="exportAll" type="button"  id="add" value="导出全部" onClick="showExpWin('all')">-->
       
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
 	<table  cellspacing="0">
    <tr >
    <!--zhengjiang 20091016 add colspan="13"-->
      <td class="blue"  align="left" colspan="13">
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
        <!--modify hucw 20100830<a>快速选择</a>-->
	    	<span>快速选择</span>
        <select onChange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
     		</select style="height:18px">&nbsp;&nbsp;
        <!--modify hucw 20100830<a>快速跳转</a>-->
	    	<span>快速跳转</span>
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=粗体>GO</font>        
        <%}%>
      </td>
    </tr>
    <!--zhengjiang 20091016
  </table>
      <table  cellSpacing="0" >
    -->  
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
			 <input type="hidden" name="para" value="">
          <tr >
       <script>
       	var tempBool ='flase';
      	if(checkRole(K179A_RolesArr)==true||checkRole(K179B_RolesArr)==true||checkRole(K179C_RolesArr)==true){	
      		document.write('<th align="center" class="blue" width="15%" > 操作 </th>');	
      		tempBool='true';
      	}
        </script>  
            <th align="center" class="blue" width="10%" nowrap > 流水号 </th>
            <th align="center" class="blue" width="6%" nowrap > 客户姓名 </th>
             <th align="center" class="blue" width="7%" nowrap > 受理号码</th>
             <th align="center" class="blue" width="7%" nowrap > 主叫号码 </th>
              <th align="center" class="blue" width="7%" nowrap > 受理时间</th>
             <th align="center" class="blue" width="7%"  nowrap > 受理时长</th>
              <th align="center" class="blue" width="5%" nowrap > 受理工号 </th>
             <th align="center" class="blue" width="11%" nowrap > 挂机方 </th>
             <th align="center" class="blue" width="6%" nowrap > 是否质检</th>
                 <th align="center" class="blue" width="9%" nowrap >保持类型</th>
             <th align="center" class="blue" width="8%"  nowrap > 开始时间</th>
                 <th align="center" class="blue" width="8%" nowrap >结束时间</th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
                if((i+1)%2==1){
          tdClass="grey";
          
			      }
           %>
		<tr  >
      <script>
      	if(tempBool=='true'){
      		document.write('<td align="center" class="<%=tdClass%>"  >');
      	}
      	if(checkRole(K179A_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][6]%>\');return false;" alt="听取语音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
        if(checkRole(K179B_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="getCallDetail(\'<%=dataRows[i][0]%>\',\'<%=start_date%>\');return false;" alt="显示该通话的详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K179C_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=dataRows[i][0]%>\',1,\'<%=dataRows[i][6]%>\')" alt="计划内质检考评" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}
      </script>
      <!--			
      <td align="center" class="<%=tdClass%>"  >
       <img onclick="checkCallListen('<%=dataRows[i][0]%>');return false;" alt="听取语音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">
       <img onclick="getCallDetail('<%=dataRows[i][0]%>','<%=start_date%>');return false;" alt="显示该通话的详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif" width="16" height="16" align="absmiddle">
       <img onclick="checkIsQc('<%=dataRows[i][0]%>',1)" alt="对该流水进行质检考评" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">
      </td>
      -->
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td><!--  modified by liujied 20090921 显示为boss工号-->
       <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
    </tr>
      <% } %>
  <!--zhengjiang 20091016    
  </table>
  
  <table  cellspacing="0">
  add colspan="13"-->
    <tr >
      <td class="blue"  align="right" colspan="13">
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
        <!--modify hucw 20100830<a>快速选择</a>-->
	    	<span>快速选择</span>
        <select onChange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
     		</select style="height:18px">&nbsp;&nbsp;
        <!--modify hucw 20100830<a>快速跳转</a>-->
	    	<span>快速跳转</span>
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=粗体>GO</font>        
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
</body>
</html>

