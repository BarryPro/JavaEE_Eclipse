<%
  /*
   * 功能: 来电信息查询
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
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*"%>
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
		}

        return buffer.toString();
}
%>

<%!
//导出Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " 开始导出Excel文件 " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "来电信息查询";//Excel文件名
        try {
        OutputStream os = response.getOutputStream();//取得输出流
        response.reset();//清空输出流
        response.setContentType("application/ms-excel");//定义输出类型
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//设定输出文件头
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],
				                       queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],
				                       queryList[i][8],queryList[i][9],queryList[i][10],queryList[i][11],
				                       queryList[i][12],queryList[i][13],queryList[i][14],queryList[i][15],
				                       queryList[i][16],queryList[i][17],queryList[i][18],queryList[i][19]};
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
    String opCode="k171";
    String opName="综合查询-来电信息查询";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
  	String sqlStr = "select CONTACT_ID,decode(ACCEPTID,'0','人工','1','自动','2','来人','3','来函','4','传真','5','EMail','6','Web','7','呼出','8','三方通话' ,'9','内部呼叫' ,'10','呼出反馈','11','其它','12','短信'),CUST_NAME,REGION_CODE,ACCEPT_PHONE,CALLER_PHONE,";	          
           sqlStr+="CALLEE_PHONE,to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi:ss'),ACCEPT_LONG,ACCEPT_LOGIN_NO,";       
           sqlStr+="decode(STAFFHANGUP,'0','用户','1','话务员','2','密码验证失败自动释放'),decode(QC_FLAG,'Y','是','N','否'),decode(STATISFY_CODE,'0','满意','1','未处理','2','一般','3','不满意','4','满意度调查挂机'),LANG_CODE,CALLCAUSEDESCS,decode(LISTEN_FLAG,'Y','是','N','否'),";								
           sqlStr+="decode(USE_FLAG,'Y','是','N','否'),QC_LOGIN_NO,decode(VERTIFY_PASSWD_FLAG,'Y','是','N','否'),BAK,TRANSFER_BAK  from dcallcall";    
		String strCountSql="select to_char(count(*)) count  from dcallcall";
		String strAcceptTimeSql="";
		String strDateSql="";
		String headname = "开始导出";//Excel文件名

    String start_date    ="";
    String end_date      ="";
    String region_code   ="";
    String contact_id    = "";
    String accept_login_no="";
    String listen_flag  ="";
    String accept_phone="";
    String contact_address="";
    String mail_address="";
    String grade_code="";
    String contact_phone="";
    String caller_phone="";
    String statisfy_code="";
    String cust_name="";
    String fax_no="";
    String accept_long_begin="";
    String accept_long_end="";
    String callee_phone="";
    String skill_quence="";
    String staffHangup="";
    String acceptid="";
    //String oper_code="";
    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 2;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String param = "";
    String sqlTemp="";
    String querySql="";
    String[] strHead = { "流水号", "受理方式", "客户姓名", "客户地市", "受理号码", "主叫号码",
			"被叫号码", "受理时间", "受理时长","受理工号", "挂机方", "是否质检", "客户满意度",  "服务语种",
			"来电原因", "录音听取标志", "是否使用放音", "质检员工号", "是否密码验证", "备注", "转接备注" };
		//String[] conStaffhangup= {"用户","话务员","密码验证失败自动释放"};
		//String[] conStaffcity = {"满意","未处理","一般","不满意","满意度调查挂机"};
		String[] conAcceptid= {"人工","自动","来人","来函","传真","EMail","Web","呼出","三方通话" ,"内部呼叫" ,"呼出反馈","其它","短信"};
      String action = request.getParameter("myaction");
      String expFlag = request.getParameter("exp"); 
      start_date        =  request.getParameter("start_date");
      end_date          =  request.getParameter("end_date");
			contact_id        =  request.getParameter("0_=_contact_id");
			region_code       =  request.getParameter("1_=_region_code");
			accept_login_no   =  request.getParameter("2_=_accept_login_no");
			listen_flag       =  request.getParameter("13_=_listen_flag");
			accept_phone      =  request.getParameter("3_=_accept_phone");
			mail_address      =  request.getParameter("4_=_mail_address");
			contact_address   =  request.getParameter("5_=_contact_address");
      grade_code        =  request.getParameter("6_=_grade_code");
      contact_phone     =  request.getParameter("7_=_contact_phone");
      caller_phone      =  request.getParameter("8_=_caller_phone");   //主叫号码
      statisfy_code     =  request.getParameter("9_=_statisfy_code"); 
      cust_name         =  request.getParameter("10_=_cust_name"); 
      fax_no            =  request.getParameter("11_=_fax_no");
      accept_long_begin =  request.getParameter("accept_long_begin");
      accept_long_end   =  request.getParameter("accept_long_end");
      callee_phone      =  request.getParameter("12_=_callee_phone");
      skill_quence      =  request.getParameter("14_=_skill_quence");
      staffHangup       =  request.getParameter("15_=_staffHangup");
      acceptid          =  request.getParameter("16_=_acceptid");
      //oper_code         =  request.getParameter("17_=_oper_code");
      ///////查询条件在这
      String sqlFilter=request.getParameter("sqlFilter");
  	  if(sqlFilter==null || sqlFilter.trim().length()==0){
         if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
             strDateSql=" where 1=1 and  to_char(begin_date,'yyyymmdd')>='"+start_date.trim()+"' and to_char(begin_date,'yyyymmdd')<='"+end_date.trim()+"' ";
             if(accept_long_begin!=null&&accept_long_begin.trim().length()!=0&&accept_long_end!=null&&accept_long_end.trim().length()!=0){
                strAcceptTimeSql=" and  accept_long>="+Long.valueOf(accept_long_begin.trim()).longValue()+" and accept_long<="+Long.valueOf(accept_long_end.trim()).longValue();
             }
             sqlFilter=start_date.substring(0,6)+strDateSql+returnSql(request)+strAcceptTimeSql;
        } 
    }
%>	
			
<%	if ("doLoad".equals(action)) {
        sqlStr+=sqlFilter;
     // sqlStr+=sqlStr+start_date.substring(0,6);
      
        sqlTemp = strCountSql+sqlFilter;
    //  sqlTemp+=sqlTemp+start_date.substring(0,6);
System.out.println("=========sqlStr========"+sqlStr);
System.out.println("=========sqlTemp========"+sqlTemp);
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
        querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        %>		           
           <wtc:service name="s151Select" outnum="30">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="29"   scope="end"/>
				<%
				dataRows = queryList;
    }
    
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){  
       sqlStr+=sqlFilter;
       sqlTemp = strCountSql+sqlFilter;  
System.out.println("====cur=====sqlStr========"+sqlStr);
System.out.println("======cur===sqlTemp========"+sqlTemp);
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
        querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        %>		           
           <wtc:service name="s151Select" outnum="30">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="29"   scope="end"/>
				<%
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){ 
       sqlStr+=sqlFilter;
       System.out.println("======all===sqlStr========"+sqlStr);
%>	
					<wtc:service name="s151Select" outnum="29">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="29" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }

%>


<html>
<head>
<title>来电信息查询</title>
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
//var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
window.open("k170_getCallListen.jsp?flag_id="+id,'录音听取','height=650, width=850');
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

    }else if(parseInt(document.sitechform.accept_long_end.value)<=parseInt(document.sitechform.accept_long_begin.value)){
		     showTip(document.sitechform.accept_long_end,"受理时长右侧值必须大于左侧值"); 
    	   sitechform.accept_long_end.focus(); 	

    }
//    else if(document.getElementById('contact_id').value == ""){
//	       showTip(document.getElementById('contact_id'),"流水号不能为空"); 
//		     document.getElementById('contact_id').focus();
//   }else if(document.getElementById('accept_login_no').value == ""){
//	       showTip(document.getElementById('accept_login_no'),"受理工号不能为空"); 
//		     document.getElementById('accept_login_no').focus();
//   }else if(document.getElementById('accept_phone').value == ""){
//	       showTip(document.getElementById('accept_phone'),"受理号码不能为空"); 
//		     document.getElementById('accept_phone').focus();
//   }
    else
    {
         hiddenTip(document.sitechform.start_date);
         hiddenTip(document.sitechform.end_date); 
         hiddenTip(document.sitechform.accept_long_end);
         hiddenTip(document.getElementById('contact_id')); 
         hiddenTip(document.getElementById('accept_login_no')); 
         hiddenTip(document.getElementById('accept_phone'));
         window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
         submitMe();
    	}
    	
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="k171_callMsgQry.jsp";
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
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k171_callMsgQry.jsp?exp="+expFlag;
    window.sitechform.page.value="<%=curPage%>";
    keepValue();
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
 //保留查询的值
function keepValue(){
   window.sitechform.statisfy.value="<%=request.getParameter("statisfy")%>";
   window.sitechform.grade.value="<%=request.getParameter("grade")%>";
   window.sitechform.accid.value="<%=request.getParameter("accid")%>";
   window.sitechform.region.value="<%=request.getParameter("region")%>";
   window.sitechform.hangup.value="<%=request.getParameter("hangup")%>";
   window.sitechform.listen.value="<%=request.getParameter("listen")%>";
   window.sitechform.skill.value="<%=request.getParameter("skill")%>";
   window.sitechform.region_code.value="<%=request.getParameter("1_=_region_code")%>";
   window.sitechform.statisfy_code.value="<%=request.getParameter("9_=_statisfy_code")%>";
   window.sitechform.grade_code.value="<%=request.getParameter("6_=_grade_code")%>";
   window.sitechform.acceptid.value="<%=request.getParameter("16_=_acceptid")%>";
   window.sitechform.staffHangup.value="<%=request.getParameter("15_=_staffHangup")%>";
   window.sitechform.listen_flag.value="<%=request.getParameter("13_=_listen_flag")%>";
   window.sitechform.skill_quence.value="<%=request.getParameter("14_=_skill_quence")%>";
   
   window.sitechform.start_date.value="<%=start_date%>";//为显示详细信息页面传递开始时间
   window.sitechform.end_date.value="<%=end_date%>";
   window.sitechform.sqlFilter.value="<%=sqlFilter%>";
   //window.sitechform.oper_code.value="";//员工地市
   window.sitechform.contact_id.value="<%=contact_id%>";
   window.sitechform.mail_address.value="<%=mail_address%>";
   window.sitechform.accept_login_no.value="<%=accept_login_no%>";
   window.sitechform.accept_phone.value="<%=accept_phone%>";
   window.sitechform.contact_address.value="<%=contact_address%>";
   window.sitechform.contact_phone.value="<%=contact_phone%>";
   window.sitechform.caller_phone.value="<%=caller_phone%>";
   window.sitechform.cust_name.value="<%=cust_name%>";
   window.sitechform.fax_no.value="<%=fax_no%>";
   window.sitechform.accept_long_begin.value="<%=accept_long_begin%>";
   window.sitechform.accept_long_end.value="<%=accept_long_end%>";
   window.sitechform.callee_phone.value="<%=callee_phone%>";
   
}

</script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">来电信息查询</div>
		<table cellspacing="0" style="width:650px">
  
      <tr >
      <td > 开始时间 </td>
      <td >
			  <input id="start_date" name ="start_date" type="text" readonly value="<%=(start_date==null)?"":start_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss'});hiddenTip(document.sitechform.start_date);">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss'})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
      <td > 员工地市 </td>
      <td >
			 <select id="oper_code" name="17_=_oper_code" size="1"  onclick="hiddenTip(this)">
			 	<!-- value 为空，查询时会自动忽略此条件-->
             <option value=""> 省中心</option>
        </select>
			  <font color="red">+</font>
      </td>
      <td > 流水号 </td>
      <td >
				<input id="contact_id" name="0_=_contact_id" onkeyup="hiddenTip(this)" type="text" value=<%=(contact_id==null)?"":contact_id%>>
				<font color="red">+</font>

      </td>
      <td > 电子邮件 </td>
      <td >
			  <input name="4_=_mail_address" type="text" maxlength="80"  id="mail_address"  value="<%=(mail_address==null)?"":mail_address%>">
      </td>
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td > 结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text" readonly  value="<%=(end_date==null)?"":end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss'});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss'})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
		  <td > 受理工号 </td>
      <td >
			  <input name ="2_=_accept_login_no" type="text" id="accept_login_no" onkeyup="hiddenTip(this)"  value="<%=(accept_login_no==null)?"":accept_login_no%>">
		    <!--img onclick="" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" -->
		    <font color="red">+</font>
		  </td> 
		  <td > 受理号码 </td>
      <td >
			  <input name ="3_=_accept_phone" type="text" id="accept_phone"  value="<%=(accept_phone==null)?"":accept_phone%>" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		   <font color="red">+</font>
		  </td> 
		  <td > 联系地址 </td>
      <td >
			  <input name ="5_=_contact_address" type="text" id="contact_address"  value="<%=(contact_address==null)?"":contact_address%>">
     </td>          
     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
     <tr >
      <td > 客户级别 </td>
      <td >
			  <select name="6_=_grade_code" id="grade_code" size="1" onchange="grade.value=this.options[this.selectedIndex].text">
			  	<%if(grade_code==null || grade_code.equals("") || request.getParameter("grade").equals("") || request.getParameter("grade")==null){%>
			  	 <option value="" selected>--所有客户级别--</option>
			  	<%}else {%>
			  	    <option value="<%=grade_code%>" selected >
      	 				<%=request.getParameter("grade")%>
      	 			</option>
      	 	 	<option value="" >--所有客户级别--</option>
      	 	<%}%>
					<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from scallgradecode</wtc:sql>
				</wtc:qoption>
        </select>
				<input name="grade" type="hidden" value="<%=request.getParameter("grade")%>"> 
		  </td> 
		  <td > 联系电话 </td>
      <td >
			  <input name ="7_=_contact_phone" type="text" id="contact_phone"  value="<%=(contact_phone==null)?"":contact_phone%>">
		  </td> 
		  <td > 主叫号码 </td>
      <td >
			  <input name ="8_=_caller_phone" type="text" id="caller_phone"  value="<%=(caller_phone==null)?"":caller_phone%>" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td> 
		  <td > 满意度 </td>
      <td >
      	 <select name="9_=_statisfy_code" id="statisfy_code" size="1" onchange="statisfy.value=this.options[this.selectedIndex].text">
      	 	<%if(statisfy_code==null || statisfy_code.equals("") || request.getParameter("statisfy")==null || request.getParameter("statisfy").equals("")){%>
      	 	<option value="" selected >--所有满意度--</option>
      	 	<%}else {%>
      	 			<option value="<%=statisfy_code%>" selected >
      	 				<%=request.getParameter("statisfy")%>
      	 			</option>
      	 	 	<option value="" >--所有满意度--</option>
      	 	<%}%>
				  <wtc:qoption name="s151Select" outnum="2">
				   <wtc:sql>select satisfy_code , satisfy_code|| '-->' ||satisfy_name from ssatisfytype where valid_flag = '1'</wtc:sql>
				  </wtc:qoption>
        </select> 
       <input name="statisfy" type="hidden" value="<%=request.getParameter("statisfy")%>"> 
		  </td>          
     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
     <tr >
      <td > 客户姓名 </td>
      <td >
			  <input name ="10_=_cust_name" type="text" id="cust_name"  value="<%=(cust_name==null)?"":cust_name%>">
		  </td> 
		  <td > 传真号码 </td>
      <td >
			  <input name ="11_=_fax_no" type="text" id="fax_no"  value="<%=(fax_no==null)?"":fax_no%>">
		  </td> 
		  <td > 受理方式 </td>
      <td >
		  <select name="16_=_acceptid" id="acceptid" size="1" onchange="accid.value=this.options[this.selectedIndex].text">
		  	<%if(acceptid==null || acceptid.equals("") || request.getParameter("accid").equals("")|| request.getParameter("accid")==null){%>
		  	<option value="" selected>--所有受理方式--</option>
		  	<%}else {%>
      	 			<option value="<%=acceptid%>" selected >
      	 				<%=request.getParameter("accid")%>
      	 			</option>
      	 	 	<option value="" >--所有受理方式--</option>
      	 	<%}%>
				<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE</wtc:sql>
				</wtc:qoption>
        </select>
        <input name="accid" type="hidden" value="<%=request.getParameter("accid")%>"> 
		  </td> 
		  <td > 受理时长 </td>
      <td >
			  ><input name ="accept_long_begin" type="text" id="accept_long_begin"  maxlength="5" style="width:60px" value="<%=(accept_long_begin==null)?"":accept_long_begin%>" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			  <<input name ="accept_long_end" type="text" id="accept_long_end"      maxlength="5" style="width:60px"  value="<%=(accept_long_end==null)?"":accept_long_end%>" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td>          
     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
    <tr >
      <td > 客户地市 </td>
      <td >
			 <select id="region_code" name="1_=_region_code" size="1" onchange="region.value=this.options[this.selectedIndex].text">
			 	<%if(region_code==null || region_code.equals("")|| request.getParameter("region")==null || request.getParameter("region").equals("")){%>
			 	<option value="" selected>--所有客户地市--</option>
			 	<%}else {%>
      	 			<option value="<%=region_code%>" selected >
      	 				<%=request.getParameter("region")%>
      	 			</option>
      	 	 	<option value="" >--所有客户地市--</option>
      	 	<%}%>
				    <wtc:qoption name="s151Select" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = '1'</wtc:sql>
				  </wtc:qoption>
        </select>
        <input name="region" type="hidden" value="<%=request.getParameter("region")%>">
      </td>
      <td > 被叫号码 </td>
      <td >
<input name ="12_=_callee_phone" type="text" id="callee_phone"  value="<%=(callee_phone==null)?"":callee_phone%>" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			
      </td>
            <td > 挂机方 </td>
      <td >
        <select name="15_=_staffHangup" id="staffHangup" size="1" onchange="hangup.value=this.options[this.selectedIndex].text">
        	<%if(staffHangup==null|| staffHangup.equals("")||request.getParameter("hangup").equals("") || request.getParameter("hangup")==null){%>
        	<option value="" selected>全部</option>
        		<%}else {%>
      	 			<option value="<%=staffHangup%>" selected >
      	 				<%=request.getParameter("hangup")%>
      	 			</option>
      	 	 	<option value="" >全部</option>
      	 	<%}%>
				<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select hangup_code , hangup_code|| '-->' ||hangup_name from staffhangup</wtc:sql>
				</wtc:qoption>
        </select>
        <input name="hangup" type="hidden" value="<%=request.getParameter("hangup")%>">
      </td>
      <td > 录音听取 </td>
      <td >
        <select id="listen_flag" name="13_=_listen_flag" size="1" onchange="listen.value=this.options[this.selectedIndex].text">
        	<%if(listen_flag==null || listen_flag.equals("") || request.getParameter("listen").equals("")|| request.getParameter("listen")==null){%>
        	<option value="" selected>全部</option>
        		<%}else {%>
      	 			<option value="<%=listen_flag%>" selected >
      	 				<%=request.getParameter("listen")%>
      	 			</option>
      	 	 	<option value="" >全部</option>
      	 	<%}%>
				<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select listen_flag_code , listen_flag_code|| '-->' ||listen_flag_name from SLISTENFLAG</wtc:sql>
				</wtc:qoption>
        </select>
        <input name="listen" type="hidden" value="<%=request.getParameter("listen")%>">
      </td>
    </tr>
        <!-- THE THIRD LINE OF THE CONTENT -->
    <tr >
      <td >技能队列 </td>
      <td colspan="8" >
        <select id="skill_quence" name="14_=_skill_quence" size="1" onchange="skill.value=this.options[this.selectedIndex].text">
        	<%if(skill_quence==null || skill_quence.equals("")|| request.getParameter("skill")==null || request.getParameter("skill").equals("")){%>
        	<option value="" selected>--所有技能队列--</option>
        	<%}else {%>
      	 			<option value="<%=skill_quence%>" selected >
      	 				<%=request.getParameter("skill")%>
      	 			</option>
      	 	 	<option value="" >--所有技能队列--</option>
      	 	 <%}%>
				  <wtc:qoption name="s151Select" outnum="2">
				  <wtc:sql>select skill_queue_id , skill_queue_id|| '-->' ||skill_queud_name from dagskillqueue</wtc:sql>
				  </wtc:qoption>
        </select>
        <input name="skill" type="hidden" value="<%=request.getParameter("skill")%>">
      </td>
    </tr>
	 <tr >
      
    </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px">
       <input name="delete_value" type="button"  id="add" value="重设" onClick="clearValue();">
       <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();">
	
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
            <th align="center" class="blue" width="15%" > 操作 </th>
            <th align="center" class="blue" width="8%" > 流水号 </th>
            <th align="center" class="blue" width="8%" > 受理方式</th>
            <th align="center" class="blue" width="8%"  > 客户姓名 </th>
            <th align="center" class="blue" width="8%"  > 客户地市 </th>
            <th align="center" class="blue" width="8%"  > 受理号码</th>
            <th align="center" class="blue" width="8%" > 主叫号码 </th>
            <th align="center" class="blue" width="8%"  > 被叫号码</th>
            <th align="center" class="blue" width="8%" > 受理时间</th>
            <th align="center" class="blue" width="8%"  > 受理时长</th>
            <th align="center" class="blue" width="8%"  > 受理工号</th>
            <th align="center" class="blue" width="8%" > 挂机方 </th>
            <th align="center" class="blue" width="8%"  > 是否质检</th>
            <th align="center" class="blue" width="8%" > 客户满意度 </th>
            <th align="center" class="blue" width="8%" > 服务语种</th>
            <th align="center" class="blue" width="8%"  > 来电原因</th>
            <th align="center" class="blue" width="8%" > 录音听取标志 </th>
            <th align="center" class="blue" width="8%"  > 是否使用放音</th>
            <th align="center" class="blue" width="8%" > 质检员工号</th>
            <th align="center" class="blue" width="8%"  > 是否密码验证</th>
            <th align="center" class="blue" width="8%" > 备注</th>
            <th align="center" class="blue" width="8%"  > 转接备注</th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
           
         <%if((i+1)%2==1){
          tdClass="grey";
          }%>
	   <tr  >

      <td align="center" class="<%=tdClass%>"  >
       <img onclick="getCallListen('<%=dataRows[i][0]%>');return false;" alt="听取语音" src="<%=request.getContextPath()%>/images/callimage/1.GIF"  align="absmiddle">
       <img onclick="getCallDetail('<%=dataRows[i][0]%>','<%=start_date%>');return false;" alt="显示该通话的详细情况" src="<%=request.getContextPath()%>/images/callimage/2.GIF" width="16" height="22" align="absmiddle">
       <img onclick="" alt="显示呼叫轨迹" src="<%=request.getContextPath()%>/images/callimage/3.GIF" width="16" height="22" align="absmiddle">
       <img onclick="" alt="另存录音到本地" src="<%=request.getContextPath()%>/images/callimage/4.GIF" width="16" height="22" align="absmiddle">
       <img onclick="" alt="计划内质检" src="<%=request.getContextPath()%>/images/callimage/5.GIF" width="16" height="22" align="absmiddle">
       <img onclick="" alt="计划外质检" src="<%=request.getContextPath()%>/images/callimage/6.GIF" width="16" height="22" align="absmiddle">
     <img onclick="" alt="计划外质检" src="<%=request.getContextPath()%>/images/callimage/7.GIF" width="16" height="22" align="absmiddle">
     <img onclick="" alt="查看对应工单信息" src="<%=request.getContextPath()%>/images/callimage/8.GIF" width="16" height="22" align="absmiddle">
      </td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][0]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][1]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][2]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][3]%></td>
       <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][4]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][5]%></td>
       <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][6]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][7]%></td>
       <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][8]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][9]%></td>
       <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][10]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][11]%></td>
       <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][12]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][13]%></td>
       <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][14]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][15]%></td>
       <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][16]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][17]%></td>
       <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][18]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][19]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][20]%></td>
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

