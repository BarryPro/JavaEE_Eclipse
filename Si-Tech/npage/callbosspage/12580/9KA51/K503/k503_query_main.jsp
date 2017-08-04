
<%
	 /*
	 * 功能: 12580预约服务
	 * 版本: 1.0.0
	 * 日期: 2009/01/12
	 * 作者: xingzhan
	 * 版权: sitech
	 * update:
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%@ include file="../../headTotal.jsp" %>
<%
  
  
  String opCode = "K503";
  String opName = "预约服务";
 
  String ACCEPT_NO = "";
  
  int rowCount = 0;
  int pageSize = 15; // Rows each page
  int pageCount = 0; // Number of all pages
  int curPage = 0; // Current page
  String strPage; // Transfered pages
  
  String loginNo = (String) session.getAttribute("workNo");
  String orgCode = (String) session.getAttribute("orgCode");
  String kf_longin_no = (String) session.getAttribute("kfWorkNo");
  
  String strCountSql = "select to_char(count(*)) count from DPRESERVICE ";
  String strOrderSql = " order by SERIAL_NO  ";
  
  String con_id = "";
  String[][] dataRows = new String[][] {};
  ArrayList  runNum = new ArrayList();
  String param = "";
  String sqlTemp = "";
  String querySql = "";
  int count_num = 0;
  String flagdiabled ="";
  String action = request.getParameter("myaction");
  String flag = request.getParameter("flag");
  String pnno = (String)session.getAttribute("capn");//呼入号码
  ACCEPT_NO = request.getParameter("ACCEPT_NO")==null?pnno:request.getParameter("ACCEPT_NO");
  String sqlStr = "select d.SERIAL_NO,d.ACCEPT_NO,to_char(d.CREATE_TIME,'yyyy-MM-dd HH24:mi:ss'),d.TARGET_PHONE_NO,to_char(d.PRE_TIME,'yyyy-MM-dd HH24:mi:ss'),d.TIMES,d.INTERV_TIME,d.MSG_CONTENT,decode(d.TIMES_FLAG,'Y','是','N','否') from DPRESERVICE d where d.accept_no='"+ACCEPT_NO+"' and d.PRE_TYPE = '1'";
  con_id = request.getParameter("con_id");
  String countnum = "select count(*) from DPRESERVICE where accept_no='"+ACCEPT_NO+"' and PRE_TYPE = '1'";  
  String sqlFilter = request.getParameter("sqlFilter");
  if (sqlFilter == null || sqlFilter.trim().length() == 0) {
  
  	sqlFilter = " where 1=1 and PRE_TYPE ='1' and ACCEPT_NO = '" + ACCEPT_NO + "' ";
  	
  }
	//sqlStr += sqlFilter +strOrderSql;
		sqlTemp = strCountSql + sqlFilter;
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlTemp%>" />
</wtc:service>
<wtc:array id="rowsC4" scope="end" />
<% 
if (rowsC4.length != 0) {

		rowCount = Integer.parseInt(rowsC4[0][0]);
    }
    strPage = request.getParameter("page");
		if (strPage == null || strPage.equals("")
		|| strPage.trim().length() == 0) {
			curPage = 1;
		} else {
			curPage = Integer.parseInt(strPage);
			if (curPage < 1)
		curPage = 1;
		}
		pageCount = (rowCount + pageSize - 1) / pageSize;
		if (curPage > pageCount)
			curPage = pageCount;
		querySql = PageFilterSQL.getOraQuerySQL(sqlStr, String
		.valueOf(curPage), String.valueOf(pageSize), String
		.valueOf(rowCount));
%>
<wtc:service name="s151Select" outnum="24">
	<wtc:param value="<%=querySql%>" />
</wtc:service>
<wtc:array id="queryList" start="1" length="23" scope="end" />
<%
	dataRows = queryList;
	if(dataRows.length>0){
     for(int n =0; n<dataRows.length;n++){
     String querySqlnum = "select count(*) from DPRESERVICETIME dp,sms_push_rec_12580 ss,DPRESERVICE dd where dp.serial_no=dd.serial_no and dp.sms_push_rec_sn = ss.serial_no and ss.send_flag ='1' and dd.serial_no='"+dataRows[n][0]+"'";
//chengh 
%>
<wtc:service name="s151Select" outnum="1">
	 <wtc:param value="<%=querySqlnum%>" />
</wtc:service>
<wtc:array id="queryList12" scope="end" />
<%   
     if(queryList12.length>0){
      runNum.add(String.valueOf(queryList12[0][0])); 
     }
    }
  }
%>
<wtc:service name="s151Select" outnum="1">
	 <wtc:param value="<%=countnum%>" />
</wtc:service>
<wtc:array id="queryList13" scope="end" />
<%   
     if(queryList13.length>0){
        count_num = Integer.parseInt(queryList13[0][0]);
        if(count_num>=5){
           flagdiabled = "disabled";
        }
     }
//chengh 结束
%>
<html>
	<head>
		<title>预约服务</title>
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
		<script language=javascript>
		//chengh 20090426 提醒话务员进行密码验证
		smp();
		function smp(){
			var falg = "<%=flag %>";
			if(falg=="Y"){
		  	parent.similarMSNPop("请进行密码验证！");
		  }
		  else
		  	return;
	  }
		//清除表单记录
		function clearValue(){
			var e = document.sitechform.elements;
			for(var i=0;i<e.length;i++){
				if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
				  e[i].value="";
				}else{
			  		e[i].checked=false;
			    }
			} 
		}
		
		function submitMe(flag){
		   //window.sitechform.myaction.value="doLoad";
		   	if(flag=='0'){
				   var vCon_id=window.top.document.getElementById('contactId').value;
		       window.sitechform.action="k503_query_main.jsp?con_id="+vCon_id;
				}else{
					 window.sitechform.action="k503_query_main.jsp";
				}
		   window.sitechform.method='post';
		   window.sitechform.submit(); 
		}
		function setObjID(idvalue)
		{
			var name = document.getElementsByName("obj_id");
			//alert(name.length);
			var n = 0;
			for(var i = 0;i<name.length;i++){
				
				//alert(name[i].value);
				if(name[i].checked){
					
				    document.getElementById("checkid").value = name[i].value;
				    n++;
				}
			}
			if(n==0){
				document.getElementById("checkid").value  = "0";
			}
			//alert(document.getElementById("checkid").value);
		}
		function keepValue()
    	{
			
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
	    function submitQcContent()
		{
				//var tf32 = document.getElementById("tf32ty").value;//判断是否开通移动秘书服务
				
				//if(tf32 != "availability"){
				//	rdShowMessageDialog("呼入号码没有开通移动秘书服务或已失效！");
				//	return;
			//	}
		    var ACCEPT_NO = document.getElementById("ACCEPT_NO").value
		    if(""==ACCEPT_NO){
		    	parent.similarMSNPop("受理号不能为空！");
		    	//rdShowMessageDialog("受理号不能为空！",0)
		    	return;
		    }
		    if(!f_check_mobile(ACCEPT_NO)){
		    	parent.similarMSNPop("受理号格式不正确！");
					//rdShowMessageDialog("受理号格式不正确！",0);
					return;
				}
			var winParam = 'dialogWidth=600px;dialogHeight=400px';
			window.showModelessDialog("../../../../callbosspage/12580/9KA51/K503/k503_newedit_obj.jsp?ACCEPT_NO="+ACCEPT_NO,window, winParam);
			
		}
		function submitUpContent(){
			
			var name = document.getElementsByName("obj_id");
			var n="0";
			for(var i =0;i<name.length;i++){
				if(name[i].checked){
					n++;
				}
			}
			
			var obj_id = document.getElementById("checkid").value;
			//alert(obj_id+"-"+n);
			if("0"==obj_id||n>1){
				 parent.similarMSNPop("请先选择一条记录！");
			   //rdShowMessageDialog("请先选择一条记录！",0);
			   return;
			}
			
			var winParam = 'dialogWidth=600px;dialogHeight=400px';
			window.showModelessDialog("../../../../callbosspage/12580/9KA51/K503/k503_newedit_obj.jsp?SERIAL_NO="+obj_id,window, winParam);
		 
		}
		function submitDELContent(){
			
			var name = document.getElementsByName("obj_id");
			var obj_id="0";
			for(var i =0;i<name.length;i++){
				
				if(name[i].checked){
					
					var obj_iid = name[i].value;
					obj_id = obj_id + "_"+obj_iid;
				}
			}
		
			if("0"==obj_id){
				 parent.similarMSNPop("请先选择一条记录！");
			   //rdShowMessageDialog("请先选择一条记录！",0);
			   return;
			}
			
			if(rdShowConfirmDialog("确实要删除吗?",2) != 1){
				
			}else{
					 if(rdShowConfirmDialog("只会删除还未执行的预约服务，已执行预约服务不可删除！是否继续删除？",2) != 1){
					 	
					}else{
					 
		    	 var myPacket = new AJAXPacket("k503_delete_obj.jsp","正在提交，请稍候......");
			     myPacket.data.add("obj_id",obj_id);
			     core.ajax.sendPacket(myPacket,doProcess,true);
			     myPacket=null;
			    }   
			}     
		}
		function doProcess(myPacket)
		{
		
		    var retType = myPacket.data.findValueByName("retType");
			var retCode = myPacket.data.findValueByName("retCode");
			var retMsg = myPacket.data.findValueByName("retMsg");
				if(retCode=="000000"){
					//alert("插入成功");
					parent.similarMSNPop("成功");
					//rdShowMessageDialog("成功",2);
					submitMe('1');
				    //window.close();
				}else{
					//alert("插入失败!");
					parent.similarMSNPop("失败");
					//rdShowMessageDialog("失败",0);
					return false;
				}
		 } 
		 function getPhoneNum(){
			//document.getElementById("ACCEPT_NO").value = window.top.cCcommonTool.getCaller();
			document.getElementById("ACCEPT_NO").value = "13709811146";
			setTimeout("getPhoneNum()", 1000);
		}
		var bool = false;
		function setAllCheck(){
		
			var name = document.getElementsByName("obj_id");
			if(bool){
				bool = false;
				for(var i = 0;i<name.length;i++){
					
					name[i].checked="";
					setObjID();
				}
			}else{
				bool = true;
				for(var i = 0;i<name.length;i++){
					
					name[i].checked="checked";
					setObjID();
				}
			}
		}
		
		function browseTime(serial_no){
			
			var winParam = 'dialogWidth=600px;dialogHeight=400px';
			window.showModelessDialog("../../../../callbosspage/12580/9KA51/K503/k503_browse_time.jsp?serial_no="+serial_no,window, winParam);			
			
		}
		</script>
	</head>
	<body>
		<%@ include file="/npage/include/header.jsp"%>
	    <form name="sitechform" id="sitechform">
				<!--<div class="title">
					受理号&nbsp;--><input type="hidden" name="ACCEPT_NO" id="ACCEPT_NO" value="<%=(ACCEPT_NO!=null)?ACCEPT_NO:"" %>" >
				<!--</div>-->
				<div>
					<!--<input name="delete_value" class="b_foot" type="button" id="add" value="重设" onClick="clearValue();">-->
					<input name="search" class="b_foot" type="button" id="search" value="查询" onClick="submitMe('1');">
					<input name="new" class="b_foot" type="button" id="new" value="新建"  <%=flagdiabled %> onClick="submitQcContent();">
					<input name="update" class="b_foot" type="button" id="update" value="修改" onClick="submitUpContent();">
					<input name="delete" class="b_foot" type="button" id="delete" value="删除" onClick="submitDELContent();">
					
					
				</div>
				<table cellspacing="0">
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
				<table cellSpacing="0">
					<input type="hidden" name="page" value="">
					<input type="hidden" name="myaction" value="">
					<input type="hidden" name="sqlFilter" value="">
					<input type="hidden" name="sqlWhere" value="">
				
					<tr>
						 <th align="center">选择所有<input type="checkbox" id="allcheck" name="allcheck" onclick="setAllCheck();" value="0" > </th>  
						 <th align="center">流水号</th> 
						 <th align="center" class="blue">受理号码</th> 
					     <th align="center" class="blue">受理时间</th> 
					     <th align="center" class="blue">目标号码</th>
					     <th align="center" class="blue">约定时间</th> 
					     <th align="center" class="blue">执行次数</th> 
					     <th align="center" class="blue">已执行次数</th>
					     <th align="center" class="blue">预约内容</th>
					      <th align="center" class="blue">是否执行</th> 
					     
					</tr>
					<div id ="checknull" style="display: none;">
						<input type="hidden" name="checkid" id ="checkid" value="0">
					</div>
					
					<%
							for (int i = 0; i < dataRows.length; i++) {
							String tdClass = "";
					
								if ((i + 1) % 2 == 1) {
								tdClass = "grey";
							}
					%>
					<tr>
						<td align="center" class="<%=tdClass%>" nowrap="nowrap"><input type="checkbox" name="obj_id"  value="<%= dataRows[i][0]%>" onclick="setObjID(this.value);"></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][0].length() != 0) ? dataRows[i][0]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][1].length() != 0) ? dataRows[i][1]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][2].length() != 0) ? dataRows[i][2]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][3].length() != 0) ? dataRows[i][3]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][4].length() != 0) ? dataRows[i][4]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" style="cursor:pointer" onClick="browseTime('<%=dataRows[i][0] %>');"><%=(dataRows[i][5].length() != 0) ? dataRows[i][5]: "&nbsp;"%></td>
					<% 
					//chengh
					  if(runNum.size()>0){
					%>
						<td align="center" class="<%=tdClass%>" ><font color="red"><%=runNum.get(i).toString() %></font></td>				
					<%
					   }
					%>	
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][7].length() != 0) ? dataRows[i][7]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[0][8].length() != 0) ? dataRows[i][8]: "&nbsp;"%></td>
						
					</tr>
					<%
					}
					
					%>
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
			
		</form>
	    <%@ include file="/npage/include/footer.jsp"%>	
	</body>	  
</html>