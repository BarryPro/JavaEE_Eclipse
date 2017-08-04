<%
  /*
   * 功能: 来电原因异动查询
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者: donglei 
　 * 版权: sitech
   * 
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
		if (value.equals("")) {
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
			//下面对like 和 = ,str分别处理.
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
		}

        return buffer.toString();
}
%>

<%!
//导出Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " 开始导出Excel文件 " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "来电原因异动查询";//Excel文件名
        try {
        OutputStream os = response.getOutputStream();//取得输出流
        response.reset();//清空输出流
        response.setContentType("application/ms-excel");//定义输出类型
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//设定输出文件头
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4]};
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
    String opCode="k174";
    String opName="综合查询-来电原因异动查询";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
  	String sqlStr = "select contact_id,login_no,to_char(oper_date,'yyyy-MM-dd hh24:mi:ss'),pre_call_cause_des,last_call_cause_des  from DLOGCALLCAUSEHIS";
		String strCountSql="select to_char(count(*)) count  from DLOGCALLCAUSEHIS";
		String strDateSql="";

    int Temp =0;

   
    String start_date           =  request.getParameter("start_date");                 
    String end_date             =  request.getParameter("end_date");                   
    String contact_id           =  request.getParameter("0_=_contact_id");             
    String login_no             =  request.getParameter("1_=_login_no");               
    String pre_call_cause_id    =  request.getParameter("2_str_pre_call_cause_id");   
    String last_call_cause_id   =  request.getParameter("3_str_last_call_cause_id");  
    String pre_cause_name       =  request.getParameter("pre_cause_name");
    String last_cause_name      = request.getParameter("last_cause_name");

    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 2;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp="";
    String action = request.getParameter("myaction");
    String[] strHead= {"流水号","修改工号","修改时间","修改前来电原因","修改后来电原因"};
	  String expFlag = request.getParameter("exp"); 
    ///////查询条件在这
    String sqlFilter = request.getParameter("sqlFilter");
	  //查询条件
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
      strDateSql=" where 1=1 and  to_char(oper_date,'yyyymmdd')>='"+start_date.trim()+"' and to_char(oper_date,'yyyymmdd')<='"+end_date.trim()+"' ";
    	}
    	sqlFilter=strDateSql+returnSql(request);
    }
%>	
			
<%	if ("doLoad".equals(action)) {
      sqlStr+=sqlFilter; 
      sqlTemp = strCountSql+sqlFilter;
      //out.println(sqlStr);
    	%>	             
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
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
           <wtc:service name="s151Select" outnum="6">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="5"   scope="end"/>
				<%
				dataRows = queryList;
				//if(queryList!=null){
				//	out.println("queryList:\t"+queryList.length);
				//	out.println("retCode:\t"+retCode);
				//	}
    }
    
    
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
        sqlTemp = strCountSql+sqlFilter;
    	%>	             
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
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
           <wtc:service name="s151Select" outnum="6">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="5"   scope="end"/>
				<%
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){   
   		sqlStr+=sqlFilter; 
%>	
					<wtc:service name="s151Select" outnum="5">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="5" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }
%>


<html>
<head>
<title>来电原因异动查询</title>
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
function getCallListen(id){
var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
//window.open("k170_getCallListen.jsp?flag_id="+id);
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
    submitMe();
    	}
}
function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="k174_callCauseHisQry.jsp";
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
  if(e[i].type=="select-one"||e[i].type=="text")
   e[i].value="";
 }
   window.sitechform.pre_call_cause_id.value="";
   window.sitechform.last_call_cause_id.value="";
   window.sitechform.pre_cause_name_id.value="";
   window.sitechform.last_cause_name_id.value="";
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k174_callCauseHisQry.jsp?exp="+expFlag;
	  window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

//显示通话详细信息
function getCallDetail(contact_id,start_date){
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    window.open(path,"newwindow","height=768, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}
function showCallCauseTree(strflag){
window.open("k174_callCauseSelectTree.jsp?flag="+strflag,'来电原因','scrollbars=yes,height=500, width=400');
}

function keepValue(){
	 window.sitechform.start_date.value="<%=start_date%>";//为显示详细信息页面传递开始时间
	 window.sitechform.end_date.value="<%=end_date%>";
   window.sitechform.sqlFilter.value="<%=sqlFilter%>";
   
   window.sitechform.contact_id.value="<%=contact_id%>";
   window.sitechform.login_no.value="<%=login_no%>";
   window.sitechform.pre_call_cause_id.value="<%=pre_call_cause_id%>";
   window.sitechform.last_call_cause_id.value="<%=last_call_cause_id%>";
   window.sitechform.pre_cause_name.value="<%=pre_cause_name%>";
   window.sitechform.last_cause_name.value="<%=last_cause_name%>";
}
</script>
</head>


<body>
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">来电原因异动</div>
		<table cellspacing="0" >
    <!-- THE FIRST LINE OF THE CONTENT -->

        <tr >
      <td > 开始时间 </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd'});hiddenTip(this);"  readOnly="true" value="<%=(start_date==null)?"":start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > 流水号 </td>
      <td >
				<input id="contact_id" name="0_=_contact_id" type="text"  value=<%=(contact_id==null)?"":contact_id%> >

      </td>
		  <td > 修改工号 </td>
      <td >
			  <input name ="1_=_login_no" type="text" id="login_no"  value="<%=(login_no==null)?"":login_no%>">
      </td> 
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td > 结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text" readOnly="true"  value="<%=(end_date==null)?"":end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd'})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
       <td > 修改前来电原因 </td>
      <td >
      	<input id="pre_cause_name_id" readOnly="true"  name="pre_cause_name" type="text"   value=<%=(pre_cause_name==null)?"":pre_cause_name%> >
				<input id="pre_call_cause_id"   name="2_str_pre_call_cause_id" type="hidden"   value=<%=(pre_call_cause_id==null)?"":pre_call_cause_id%> >
        <img onclick="showCallCauseTree(1);return false;"  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
      </td>
      </td> 
		        <td > 修改后来电原因</td>
      <td >
      	<input name ="last_cause_name" readOnly="true"  type="text" id="last_cause_name_id"  value="<%=(last_cause_name==null)?"":last_cause_name%>">
			  <input name ="3_str_last_call_cause_id"   type="hidden" id="last_call_cause_id"  value="<%=(last_call_cause_id==null)?"":last_call_cause_id%>">
			   <img onclick="showCallCauseTree(2);return false;"  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
		  </td> 
 </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px">
       <input name="delete_value" type="button"  id="add" value="重设" onClick="clearValue();return false;"> 
       <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
	
			 <input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('cur')\"");%>>
       <input name="exportAll" type="button"  id="add" value="导出全部" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('all')\"");%>>
       
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
      <table  cellSpacing="0" >
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
          <tr >
            <th align="center" class="blue" width="10%" > 操作 </th>
            <th align="center" class="blue" width="10%" > 流水号 </th>
            <th align="center" class="blue" width="10%" > 修改工号</th>
            <th align="center" class="blue" width="10%"  > 修改时间 </th>
            <th align="center" class="blue" width="30%"  >修改前来电原因</th>
             <th align="center" class="blue" width="30%" >修改后来电原因</th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           if((i+1)%2==1){
             tdClass="grey";
            } 
           %>
	   <tr  >

      <td align="center" class="<%=tdClass%>"  >
       <img onclick="getCallListen('<%=dataRows[i][0]%>');return false;" alt="听取语音" src="<%=request.getContextPath()%>/images/callimage/1.GIF" width="16" height="22" align="absmiddle">
       <img onclick="getCallDetail('<%=dataRows[i][0]%>','<%=start_date%>');return false;" alt="显示该通话的详细情况" src="<%=request.getContextPath()%>/images/callimage/2.GIF" width="16" height="22" align="absmiddle">
      </td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][0]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][1]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][2]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][3]%></td>
       <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][4]%></td>
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

