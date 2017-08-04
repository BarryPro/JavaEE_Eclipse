<%
  /*
   * 功能: 质检结果查询
　 * 版本: 1.0
　 * 日期: 2008/11/10
　 * 作者: hanjc 
　 * 版权: sitech
   * 
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
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
			if (objs[0].toString().equalsIgnoreCase("str")){
    buffer.append(" and instr("+objs[1]+",'"+objs[2].toString()+"',-1,1)>0");
			}
      //只适用于本页面功能，判断是否已经复核--开始
      if (objs[0].toString().equalsIgnoreCase("<>")) {
        if(objs[2].toString().equalsIgnoreCase("1")){
          buffer.append(" and " + objs[1] + " = '"
				+ objs[2].toString().trim() + "' ");
        }
        if(objs[2].toString().equalsIgnoreCase("0")){
		buffer.append(" and " + objs[1] + " " + objs[0] + " '1' ");
        }
			}
      //只适用于本页面功能--结束
		}

        return buffer.toString();
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
        String headname = "质检结果查询";//Excel文件名
        try {
        OutputStream os = response.getOutputStream();//取得输出流
        response.reset();//清空输出流
        response.setContentType("application/ms-excel");//定义输出类型
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//设定输出文件头
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],queryList[i][8],queryList[i][9],queryList[i][10],
				                        queryList[i][11],queryList[i][12],queryList[i][13],queryList[i][14],queryList[i][15],queryList[i][16],queryList[i][17],queryList[i][18],queryList[i][19],queryList[i][20],queryList[i][21],
				                        queryList[i][22],queryList[i][23],queryList[i][24],queryList[i][25],queryList[i][26],queryList[i][27],queryList[i][28],queryList[i][29],queryList[i][30],queryList[i][31]};
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
    String opCode="K211";
    String opName="质检查询-质检结果查询";
	  //String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String start_date = request.getParameter("start_date");      
    String end_date = request.getParameter("end_date"); 
    boolean isModifyed = false;
    
	  String tableName = "dcallcall";
	  if(start_date!=null){
	    tableName += start_date.substring(0,6);
	  }		

    String beQcObjId        = request.getParameter("0_=_t1.objectid");       
    String errorlevelid     = request.getParameter("2_Str_t1.errorlevelid"    );
    String errorlevelName   = request.getParameter("errorlevelName"    );
    String qcobjectid       = request.getParameter("3_=_t1.contentid"        );
    String errorclassid     = request.getParameter("5_Str_t1.errorclassid"    );
    String errorclassName   = request.getParameter("errorclassName"    );
    String evterno          = request.getParameter("6_=_t1.evterno"         );
    String staffno          = request.getParameter("7_=_t1.staffno"         );
    String recordernum      = request.getParameter("8_=_t1.recordernum"     );
    String qcserviceclassid = request.getParameter("9_Str_t1.qcserviceclassid");
    String qcserviceclassName = request.getParameter("qcserviceclassName");
    
    String flag          = request.getParameter("10_=_t1.flag"); 
    
    String outplanflag   = request.getParameter("11_=_t1.outplanflag"); 
    String checkflag     = request.getParameter("12_<>_t1.checkflag"); 
    
    String qcGroupId     = request.getParameter("qcGroupId");
    String beQcGroupId   = request.getParameter("beQcGroupId");
    String qcobjectName  = request.getParameter("qcobjectName");
    String qcGroupName   = request.getParameter("qcGroupName");                                                         
    String beQcGroupName = request.getParameter("beQcGroupName");                                                       
    String beQcObjName   = request.getParameter("beQcObjName"); 
    String[][] dataRows  = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp ="";
    String strDateSql="";
    String action = request.getParameter("myaction");
    String[] strHead= {"流水号","被检流水号","被检工号","被检员姓名","员工批次","被检对象","质检标识","质检工号","考评内容","总得分","计划类型","等级","差错类别","差错等级","内容概括","处理情况","改进建议","放弃原因","考评方式","考评类别","业务类别","质检开始时间","质检结束时间","处理时长","放音监听时长","整理时长","质检总时长","确认人","确认日期","复核标识","总体评价","是否密码验证"};
	  String expFlag = request.getParameter("exp"); 
	  System.out.println("\n\n=========action======="+action);
    System.out.println("\n\n=========qcGroupId======="+qcGroupId);
    System.out.println("\n\n=========beQcGroupId======="+beQcGroupId);
    System.out.println("\n\n=========flag======="+flag);
	  String sqlFilter = request.getParameter("sqlFilter");
	  //查询条件
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
				strDateSql=" where 1=1 and  to_char(t1.starttime,'yyyymmdd hh24:mi:ss')>='"+start_date.trim()+"' and to_char(t1.starttime,'yyyymmdd hh24:mi:ss')<='"+end_date.trim()+"' ";
    	}
    	if(qcGroupId!=null&& !qcGroupId.trim().equals("")){
    	  strDateSql+=" and t1.evterno in (select check_login_no from dqccheckgrouplogin where check_group_id='"+qcGroupId+"') ";
    	}
    	if(beQcGroupId!=null&& !beQcGroupId.trim().equals("")){
    	  strDateSql+=" and t1.staffno in (select login_no from dqclogingrouplogin where login_group_id='"+beQcGroupId+"') ";
    	}
    	sqlFilter=strDateSql+returnSql(request);
    }
    
    String sqlStrTemp = "select min(t1.recordernum) from dqcinfo t1 "+strDateSql;
    sqlStrTemp+=sqlFilter;
%>		           
           <wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlStrTemp%>"/>
					</wtc:service>
				<wtc:array id="queryTempList"  scope="end"/>
<%
			if(queryTempList.length>0&&(queryTempList[0][0].trim()).length()>0){
			  tableName = "dcallcall";
			  tableName+=queryTempList[0][0].substring(4, 10);
			}	 

  	String sqlStr = "select "          
                   +"t1.serialnum,     " //流水号
                   +"t1.recordernum,   " //被检流水号
                   +"t1.staffno,       " //被检工号
                   +"v.login_name,  "       //被检员姓名
                   +"'',   " //员工批次,暂时没有此项。
                   +"t3.object_name,   " //被检对象
                   +"decode(t1.flag,'0','临时保存','1','已提交','2','已提交已修改','3','已确认','4','放弃')," //质检标识
                   +"t1.evterno,       " //质检工号
                   +"t4.name,          " //考评内容
                   +"t1.score,         " //总得分
                   +"decode(to_char(t1.outplanflag),'0','计划内质检','1',' 计划外质检'),     " //计划类型
                   +"t1.contentlevelid," //等级
                   +"t1.errorclassdesc,  " //差错类别
                   +"t1.errorleveldesc,  " //差错等级
                   +"t1.contentinsum,  " //内容概括
                   +"t1.handleinfo,    " //处理情况
                   +"t1.improveadvice, " //改进建议
                   +"t1.abortreasonid, " //放弃原因
                   +"decode(t1.kind,'0','自动分派','1','人工指定'),     " //考评方式
                   +"decode(t1.checktype,'0','实时质检','1','事后质检')," //考评类别
                   +"t1.serviceclassdesc," //业务类别
                   +"to_char(t1.starttime,'yyyy-MM-dd hh24:mi:ss')," //质检开始时间 
                   +"to_char(t1.endtime,'yyyy-MM-dd hh24:mi:ss')," //质检结束时间 
                   +"t1.dealduration,  " //处理时长
                   +"t1.lisduration,   " //放音监听时长 
                   +"t1.arrduration,   " //整理时长
                   +"t1.evtduration,   " //质检总时长
                   +"t1.signataryid,   " //确认人
                   +"to_char(t1.affirmtime,'yyyy-MM-dd hh24:mi:ss'),    " //确认日期
                   +"decode(t1.checkflag,'0','未复核','-1','未复核','1','已复核'),     " //复核标识
                   +"t1.commentinfo,   " //总体评价
                   +"'否',   " //是否密码验证 
                   +"t1.objectid,     " //被检对象id
                   +"t1.contentid,   " //考评内容id 
                   +"t1.flag,  "
                   +"t1.checkflag "     //复核标识id               
                   +"from dqcinfo t1,v_loginmsg v,v_loginmsgrelation vl,dqcobject t3,dqccheckcontect t4,dual t6 ";

		String strJoinSql=" and t1.is_del='N' and t1.objectid=t3.object_id(+) "                                                   
                     +" and t1.contentid=t4.contect_id(+) " 
                     +" and t1.objectid=t4.object_id(+) "  
                     +" and t1.staffno=vl.KF_LOGIN_NO(+) and v.LOGIN_NO=vl.BOSS_LOGIN_NO "
                     +"  order by t1.starttime desc" ;
                   
  	String strCountSql="select to_char(count(*)) count"
                      +" from dqcinfo t1,v_loginmsg v,v_loginmsgrelation vl,dqcobject t3,dqccheckcontect t4,dual t6 ";			
			   
%>			
<%	if ("doLoad".equals(action)) {
      sqlStr+=sqlFilter+strJoinSql;
      sqlTemp = strCountSql+sqlFilter+strJoinSql;
    	  %>	             
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
					</wtc:service> 
					<wtc:array id="rowsC4"  scope="end"/>	
					<% 		
				if(rowsC4.length!=0){            
	          rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
	      System.out.println("==============2================2=======================");
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
           <wtc:service name="s151Select" outnum="37">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="36"   scope="end"/>
				<%
				dataRows = queryList;
    }
   
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
 			  sqlStr+=sqlFilter+strJoinSql;
        sqlTemp = strCountSql+sqlFilter+strJoinSql;
    	  %>	             
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
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
           <wtc:service name="s151Select" outnum="37">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="32"   scope="end"/>
				<%
				this.toExcel(queryList,strHead,response);
   }
   
   if("all".equalsIgnoreCase(expFlag)){
     sqlStr+=sqlFilter+strJoinSql;    
%>	
					<wtc:service name="s151Select" outnum="37">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="32" scope="end"/>	
<% 
		this.toExcel(queryList,strHead,response);
   } 
%>


<html>
<head>
<title>质检结果查询</title>
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
			var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K042/lisenRecord.jsp","正在处理,请稍后...");
	     packet.data.add("retType" ,  "chkExample");
	     packet.data.add("filepath" ,  filepath);
	     packet.data.add("liscontactId" ,contact_id);
	    core.ajax.sendPacket(packet,doProcessNavcomring,true);
			packet =null;
}		
function checkCallListen(id){
		if(id==''){
		return;
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
	if(id==''){
		return;
		}		
//var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
openWinMid(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_getCallListen.jsp?flag_id="+id,'录音听取',650,850);
}
//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
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

    }else{
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    window.sitechform.sqlWhere.value="<%=sqlFilter%>";  
    submitMe();
    	}
}
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K211_qcResultQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}
//=========================================================================
// LOAD PAGES.
//=========================================================================
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
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_qcResultQry.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	  window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.end_date.value="<%=end_date%>";
    
    window.sitechform.errorlevelid.value="<%=errorlevelid%>";
    window.sitechform.qcobjectid.value="<%=qcobjectid%>";
    window.sitechform.errorclassid.value="<%=errorclassid%>";
    window.sitechform.evterno.value="<%=evterno%>";
    window.sitechform.staffno.value="<%=staffno%>";
    window.sitechform.recordernum.value="<%=recordernum%>";
    window.sitechform.qcserviceclassid.value="<%=qcserviceclassid%>";
    window.sitechform.flag.value="<%=flag%>";
    window.sitechform.outplanflag.value="<%=outplanflag%>";
    window.sitechform.checkflag.value="<%=checkflag%>";
    window.sitechform.qcobjectName.value="<%=qcobjectName%>";
    window.sitechform.qcGroupName.value="<%=qcGroupName%>";
    window.sitechform.beQcGroupName.value="<%=beQcGroupName%>";
    window.sitechform.beQcObjName.value="<%=beQcObjName%>";
    
    window.sitechform.beQcObjId.value="<%=beQcObjId%>";      
    window.sitechform.errorlevelName.value="<%=errorlevelName%>";
    window.sitechform.errorclassName.value="<%=errorclassName%>";
    window.sitechform.qcserviceclassName.value="<%=qcserviceclassName%>";
    window.sitechform.checkflag.value="<%=checkflag%>";
    window.sitechform.qcGroupId.value="<%=qcGroupId%>";
    window.sitechform.beQcGroupId.value="<%=beQcGroupId%>";
}

//显示质检结果详细信息
function getQcDetail(contact_id){
	//alert(contact_id);
		var path="K211_getResultDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
    window.open(path,"结果详情","height=750, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
    //window.showModalDialog(path,'质检结果详情',param);
	return true;
}

//显示修改质检结果详细信息
function getModDetail(contact_id,start_date,end_date){
	//alert(contact_id);
		var path="../K213/K213_qcModifyRecQry.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    path = path + "&end_date=" + end_date;
    path = path + "&opCodeFlag=K211";
    var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
    window.open(path,"结果详情","height=750, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
    //window.showModalDialog(path,'修改质检结果详情',param);
}

//质检内容
function getQcContentTree(){
	var path="K211_getQcContent.jsp";
  window.open(path,"选择质检内容","height=450, width=620,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
	return true;
}

//被检对象
function showObjectCheckTree(){
	var path="K211_beQcObjTree_1.jsp";
  var param  = 'dialogWidth=300px;dialogHeight=250px';
  var returnValue =window.showModalDialog(path,'选择被检对象',param);
	if(typeof(returnValue) != "undefined"){
		 var beQcObjId = document.getElementById("beQcObjId");
		 var beQcObjName   = document.getElementById("beQcObjName");
		 var temp = returnValue.split('_');
		 beQcObjId.value = trim(temp[0]);
		 beQcObjName.value   = trim(temp[1]);
	 }
}

//质检群组
function getQcGroupTree(){
	var path="K211_qcGroTree.jsp";
  var param  = 'dialogWidth=300px;dialogHeight=250px';
  var returnValue =window.showModalDialog(path,'选择质检群组',param);
	if(typeof(returnValue) != "undefined"){
		 var qcGroupId = document.getElementById("qcGroupId");
		 var qcGroupName   = document.getElementById("qcGroupName");
		 var temp = returnValue.split('_');
		 qcGroupId.value = trim(temp[0]);
		 qcGroupName.value   = trim(temp[1]);
	 }
}

//被检群组
function getBeQcGroTree(){
	var path="K211_beQcGroTree.jsp";
	var param  = 'dialogWidth=300px;dialogHeight=250px';
  var returnValue =window.showModalDialog(path,'选择被检群组',param);
	if(typeof(returnValue) != "undefined"){
		 var beQcGroupId = document.getElementById("beQcGroupId");
		 var beQcGroupName   = document.getElementById("beQcGroupName");
		 var temp = returnValue.split('_');
		 beQcGroupId.value = trim(temp[0]);
		 beQcGroupName.value   = trim(temp[1]);
	 }
}

//差错类别、差错等级、业务类别
function getThisTree(flag,title){
	var path="fK240toK270_tree.jsp?op_code="+flag;
	if(flag=='240'){
		title="选择差错类别";
	}else if(flag=='250'){
		title="选择差错等级";
	}else if(flag=='270'){
		title="选择业务类别";
	}
  openWinMid(path,title,300, 250);
}

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

/**
  *
  *弹出对质检结果修改窗口
  */
function updateQcResult(serialnum,staffno,object_id,content_id){
	var path ='../callbosspage/checkWork/K214/K214_modify_plan_qc_main.jsp?serialnum=' + serialnum +'&staffno=' + staffno+ '&object_id=' + object_id + '&content_id='+content_id;	
	//var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
	//window.showModalDialog(path,'质检结果修改',param);
  if(!parent.parent.document.getElementById(serialnum)){
    parent.parent.addTab(true,serialnum,'质检操作',path);
	}else{
    parent.parent.addTab(true,serialnum+1,'质检操作',path);
	  parent.removeTab(serialnum);
	}
}
/**
  *
  *弹出对质检结果复核窗口
  */
function checkResult(serialnum,staffno,object_id,content_id,flag,checkFlag){
  if(checkFlag!='1'){
	 if(flag=='1'||flag=='2'||flag=='3'){
	  //var path = '../callbosspage/checkWork/K219/K219_check_plan_qc_main.jsp?serialnum=' + serialnum + '&object_id=' + object_id + '&content_id='+content_id+'&staffno='+staffno;	
	  var  path = '/npage/callbosspage/checkWork/K219/K219_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno;
    if(!parent.parent.document.getElementById(serialnum)){
      parent.parent.addTab(true,serialnum,'质检操作',path);
  	}else{
      parent.parent.addTab(true,serialnum+1,'质检操作',path);
	    parent.removeTab(serialnum);
	  }
    //var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
    //window.showModalDialog(path,'质检结果复核',param);
	 }else{
    rdShowMessageDialog("该流水未提交，无法进行复核!",1); 
	 }
	}else{
		rdShowMessageDialog("该流水已完成复核!",1); 
	}
}

//删除质检结果
function deleteQcInfo(serialnum,flag){
	//只有放弃的结果才可以删除
	if(flag=='4'){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_deleteQcInfo_rpc.jsp","正在删除记录，请稍后...");
	  chkPacket.data.add("serialnum", serialnum);
    core.ajax.sendPacket(chkPacket,doProcessDeleteQcInfo,true);
	  chkPacket =null;
	}else{
		rdShowMessageDialog("您无删除记录的权限!",1);
	}
}

function doProcessDeleteQcInfo(packet){
  var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		rdShowMessageDialog("删除成功！",2);
		window.sitechform.myaction.value="doLoad";
    keepValue();
    window.sitechform.action="K211_qcResultQry.jsp";
    window.sitechform.method='post';
    document.sitechform.submit();
	}else{
		rdShowMessageDialog("删除失败！");
	}
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


	//居中打开窗口
	function openWinMidForLoad(url,name,iHeight,iWidth)
	{
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
	}
	//导出窗口
	function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
	  window.sitechform.sqlWhere.value="<%=sqlFilter%>";
	 
		openWinMidForLoad('k211_expSelect.jsp?flag='+flag,'选择导出列',340,320);
	 }
	 
	 
  function test(){
	 	 rdShowConfirmDialog("测试-1！",-1); 
	 	 rdShowConfirmDialog("测试0！",0); 
	 	 rdShowConfirmDialog("测试1！",1); 
	 	 rdShowConfirmDialog("测试2！",2); 
	 	 rdShowConfirmDialog("测试3！",3); 
	 	 rdShowConfirmDialog("测试4！",4);
	}
</script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">质检结果查询</div>
		<table cellspacing="0" style="width:650px">
    <!-- THE FIRST LINE OF THE CONTENT -->
  
      <tr >
      <td > 开始时间 </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > 质检群组 </td>
      <td >
				<input id="qcGroupName" name="qcGroupName" size="20" type="text" readOnly value="<%=(qcGroupName==null)?"":qcGroupName%>">
  			<input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>">
        <img onclick="getQcGroupTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
      <td >被检群组 </td>
      <td >
        <input id="beQcGroupName" name="beQcGroupName" size="20" type="text" readOnly value="<%=(beQcGroupName==null)?"":beQcGroupName%>">
  			<input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>">
        <img onclick="getBeQcGroTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
      <td >差错等级 </td>
      <td >
				<input  id="errorlevelName" name="errorlevelName" type="text" readOnly onclick=""   value="<%=(errorlevelName==null)?"":errorlevelName%>">
				<input  id="errorlevelid" name="2_Str_t1.errorlevelid" type="hidden"  onclick=""   value="<%=(errorlevelid==null)?"":errorlevelid%>">
        <img onclick="getThisTree('K250')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td > 结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
      <td > 质检内容 </td>
      <td >
      	<input id="qcobjectName" name="qcobjectName" size="20" type="text" readOnly value="<%=(qcobjectName==null)?"":qcobjectName%>">
				<input  id="qcobjectid" name="3_=_t1.contentid" type="hidden"  onclick="getQcContentTree()"   value="<%=(qcobjectid==null)?"":qcobjectid%>">
        <img onclick="getQcContentTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
      <td > 被检对象 </td>
      <td >
			  <input id="beQcObjName" name="beQcObjName" size="20" type="text" readOnly value="<%=(beQcObjName==null)?"":beQcObjName%>">
  			<input id="beQcObjId" name="0_=_t1.objectid" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>">
        <img onclick="showObjectCheckTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
      <td >差错类别 </td>
      <td >
				<input  id="errorclassName" name="errorclassName" type="text" readOnly onclick=""   value="<%=(errorclassName==null)?"":errorclassName%>">
				<input  id="errorclassid" name="5_Str_t1.errorclassid" type="hidden"  value="<%=(errorclassid==null)?"":errorclassid%>">
        <img onclick="getThisTree('k240')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>      
     </tr>
     <!-- THE THIRD LINE OF THE CONTENT -->
     <tr>
     	
      <td > 质检工号 </td>
      <td >
			  <input name ="6_=_t1.evterno" type="text" id="evterno"  maxlength="10" value="<%=(evterno==null)?"":evterno%>">
      </td> 
      
      <td > 被检工号 </td>
      <td >
			  <input name ="7_=_t1.staffno" type="text" id="staffno"  maxlength="10" value="<%=(staffno==null)?"":staffno%>">
      </td> 
      <td > 被检流水号 </td>
      <td >
			  <input id="recordernum" name="8_=_t1.recordernum" type="text"  value="<%=(recordernum==null)?"":recordernum%>">
      </td> 

      <td > 业务类别 </td>
      <td >
      	<input  id="qcserviceclassName" name="qcserviceclassName" type="text" readOnly onclick=""   value="<%=(qcserviceclassName==null)?"":qcserviceclassName%>">
				<input  id="qcserviceclassid" name="9_Str_t1.qcserviceclassid" type="hidden"  onclick=""   value="<%=(qcserviceclassid==null)?"":qcserviceclassid%>">
        <img onclick="getThisTree('K270')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>      
    <!-- THE FOURTH LINE OF THE CONTENT -->
    <tr >

      <td > 质检标识 </td>
      <td >
				<select name="10_=_t1.flag" id="flag" size="1" >
      	 	<option value="" selected >5-全部</option>
					<option value="0" <%="0".equals(flag)?"selected":""%>>0-临时保存</option>
					<option value="1" <%="1".equals(flag)?"selected":""%>>1-已提交</option>
					<option value="2" <%="2".equals(flag)?"selected":""%>>2-已提交已修改</option>
					<option value="3" <%="3".equals(flag)?"selected":""%>>3-已确认</option>
					<option value="4" <%="4".equals(flag)?"selected":""%>>4-放弃</option>
        </select> 
      </select> 
      </td> 

      <td > 计划类型 </td>
      <td >
				<select name="11_=_t1.outplanflag" id="outplanflag" size="1" >
      	 	<option value="" selected >2-全部</option>
          <option value="0" <%="0".equals(outplanflag)?"selected":""%>>0-计划内质检</option>
					<option value="1" <%="1".equals(outplanflag)?"selected":""%>>1-计划外质检</option>
        </select> 
      </select>
      </td> 

      <td > 复核标识 </td>
      <td >
				<select name="12_<>_t1.checkflag" id="checkflag" size="1" >
      	 	<option value="" selected >2-全部</option>
					<option value="0" <%="0".equals(checkflag)?"selected":""%>>0-未复核</option>
					<option value="1" <%="1".equals(checkflag)?"selected":""%>>1-已复核</option>
        </select> 
      </td> 

      <td > 计算等级 </td>
      <td >
				<select name="calLevel" id="calLevel" size="1"  >
      	 	<option value="" >--所有计算等级--</option>
        </select>
      </td>                   
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px">
        <input name="delete_value" type="button"  id="add" value="重设" onClick="clearValue();return false;">
       <input name="search" type="button"  id="search" value="查询" onClick="test();">
	
			 <input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
       <input name="exportAll" type="button"  id="add" value="导出全部" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('all')\"");%>>
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
  	<table  cellspacing="0">
    <tr >
      <td class="blue"  align="left" width="720">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#" onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>
        <%}%>
      </td>
    </tr>
  </table>
      <table  cellSpacing="0" >
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
          <tr >
            <th align="center" class="blue" width="5%" > 操作 </th>
            <th align="center" class="blue" width="5%" > 流水号 </th>
            <th align="center" class="blue" width="5%" > 被检流水号 </th>
            <th align="center" class="blue" width="5%" > 被检工号 </th>
            
            <th align="center" class="blue" width="5%" > 被检员姓名 </th>
            <th align="center" class="blue" width="5%" > 员工批次 </th>
            
            <th align="center" class="blue" width="5%" > 被检对象 </th>
            <th align="center" class="blue" width="5%" > 质检标识</th>
            <th align="center" class="blue" width="5%" > 质检工号 </th>
            <th align="center" class="blue" width="5%" > 考评内容 </th>
            <th align="center" class="blue" width="5%" > 总得分 </th>
            <th align="center" class="blue" width="5%" > 计划类型 </th>
            <th align="center" class="blue" width="5%" > 等级 </th>
            <th align="center" class="blue" width="5%" > 差错类别 </th>
            <th align="center" class="blue" width="5%" > 差错等级 </th>
            <th align="center" class="blue" width="5%" > 内容概括 </th>
            <th align="center" class="blue" width="5%" > 处理情况</th>
            <th align="center" class="blue" width="5%" > 改进建议 </th>
            <th align="center" class="blue" width="5%" > 放弃原因 </th>
            <th align="center" class="blue" width="5%" > 考评方式 </th>
            <th align="center" class="blue" width="5%" > 考评类别 </th>
            <th align="center" class="blue" width="5%" > 业务类别 </th>  
            <th align="center" class="blue" width="5%" > 质检开始时间 </th>
            <th align="center" class="blue" width="5%" > 质检结束时间</th>
            <th align="center" class="blue" width="5%" > 处理时长 </th>
            <th align="center" class="blue" width="5%" > 放音监听时长 </th>
            <th align="center" class="blue" width="5%" > 整理时长 </th>
            <th align="center" class="blue" width="5%" > 质检总时长 </th>
            <th align="center" class="blue" width="5%" > 确认人 </th>   
            <th align="center" class="blue" width="5%" > 确认日期 </th>
            <th align="center" class="blue" width="5%" > 复核标识 </th>
            <th align="center" class="blue" width="5%" > 总体评价 </th>
            <th align="center" class="blue" width="5%" > 是否密码验证 </th>
          </tr>
          <% for ( int i = 0; i < dataRows.length; i++ ) {
                if("2".equals(dataRows[i][34])&&!"3".equals(dataRows[i][34])){
                  isModifyed = true;
                }
             }%>
          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr  >
			<%}else{%>
	   <tr  >
	<%}%>
	    <td align="center" class="<%=tdClass%>"  >
       <img style="cursor:hand" onclick="checkCallListen('<%=dataRows[i][1]%>');return false;" alt="听取录音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif"  width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="getQcDetail('<%=dataRows[i][0]%>');return false;" alt="显示质检结果详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="updateQcResult('<%=dataRows[i][0]%>','<%=dataRows[i][2]%>','<%=dataRows[i][32]%>','<%=dataRows[i][33]%>');return false;" alt="修改质检结果" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif"  width="16" height="16" align="absmiddle">
       <%if(isModifyed){
          if("2".equals(dataRows[i][34])&&!"3".equals(dataRows[i][34])){%>
       <img style="cursor:hand" onclick="getModDetail('<%=dataRows[i][0]%>','<%=dataRows[i][21]%>','<%=dataRows[i][22]%>');return false;" alt="显示修改结果详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">
       <% }else{%>
       	&nbsp;&nbsp;&nbsp;
       <%	}
         }
       %>
       <%
       if(!"1".equals(dataRows[i][35])){%>
       <img style="cursor:hand" onclick="checkResult('<%=dataRows[i][0]%>','<%=dataRows[i][7]%>','<%=dataRows[i][32]%>','<%=dataRows[i][33]%>','<%=dataRows[i][34]%>','<%=dataRows[i][35]%>')" alt="对改流水进行质检复核" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif"  width="16" height="16" align="absmiddle">
       <% }else{%>
       	&nbsp;&nbsp;&nbsp;
       <%	}%>
       
       <img style="cursor:hand" onclick="deleteQcInfo('<%=dataRows[i][0]%>','<%=dataRows[i][34]%>')" alt="删除该条记录" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  width="16" height="16" align="absmiddle">
      </td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
     
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][13].length()!=0)?dataRows[i][13]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][14].length()!=0)?dataRows[i][14]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][16].length()!=0)?dataRows[i][16]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][17].length()!=0)?dataRows[i][17]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][18].length()!=0)?dataRows[i][18]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][19].length()!=0)?dataRows[i][19]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][20].length()!=0)?dataRows[i][20]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][21].length()!=0)?dataRows[i][21]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][22].length()!=0)?dataRows[i][22]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][23].length()!=0)?dataRows[i][23]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][24].length()!=0)?dataRows[i][24]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][25].length()!=0)?dataRows[i][25]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][26].length()!=0)?dataRows[i][26]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][27].length()!=0)?dataRows[i][27]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][28].length()!=0)?dataRows[i][28]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][29].length()!=0)?dataRows[i][29]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][30].length()!=0)?dataRows[i][30]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][31].length()!=0)?dataRows[i][31]:"&nbsp;"%></td>
      
      
    </tr>
      <% } %>
  </table>
  
  <table  cellspacing="0">
    <tr >
      <td class="blue"  align="right" width="720">
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
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

