<%
  /*
   * 功能: 系统版本升级查询
　 * 版本: 1.0
　 * 日期: 2009/10/12
　 * 作者: jiangbing
　 * 版权: sitech
 　*/
%>
 
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>

<html>
<head>
<style>
		img{
				cursor:hand;
		}
</style>	
<title>系统版本升级查询</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/nresources/default/css/nextPages.css" ></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" language="javascript" src="/njs/si/base.js"></script>
<SCRIPT type="text/javascript" language=javascript src="/njs/si/ajax.js"></SCRIPT>
<%!
	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}	
%>
<%
	String opCode="K074";
  String opName="版本维护记录";
      /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	//登录工号
	String kf_longin_no = (String) session.getAttribute("workNo");
	/**获取查询条件**/
	//当前页码
	String pageNow = WtcUtil.repNull(request.getParameter("page"));
	if(pageNow.equals("")){
		pageNow = "1";
	}
	String pagesize = WtcUtil.repNull(request.getParameter("pagesize"));
	if(pagesize.equals("")){
		pagesize = "10";
	}
	String totalCount = "0";
	String module_id = WtcUtil.repNull(request.getParameter("module_id"));
	String version_no = WtcUtil.repNull(request.getParameter("version_no"));
	String login_no = WtcUtil.repNull(request.getParameter("login_no"));
	
	String sql_condition = " type='A' and is_del='N' ";
	if(!module_id.equals("")){
			sql_condition += " and DCALLUPDATELOG.module_id=:vmodule_id  ";
			myParams+="vmodule_id="+module_id;
	}
	if(!version_no.equals("")){
			sql_condition += " and version_no=:vversion_no  ";
			myParams+=",vversion_no="+version_no;
	}
	if(!login_no.equals("")){
			sql_condition += " and login_no=:vlogin_no ";
		  myParams+=",vlogin_no="+login_no;
	}
	String sql_count = "select to_char(count(*)) from DCALLUPDATELOG where "+ sql_condition;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
	<wtc:param value="<%=sql_count%>" />
	<wtc:param value="<%=myParams%>" />
</wtc:service>
<wtc:array id="tmpCount" scope="end" />
<%
	totalCount = tmpCount[0][0];
	String first = "first_no";
	String previous = "previous_no";
	String forward = "forward_no";
	String last = "last_no";
	int totalCount_int = Integer.parseInt(totalCount);
	int pagesize_int = Integer.parseInt(pagesize);
	int pageNow_int = Integer.parseInt(pageNow);
	int totalpage = totalCount_int/pagesize_int;
	if(totalpage*pagesize_int<totalCount_int){
		totalpage = totalpage+1;
	}
	if(totalpage==0){
		totalpage = 1;
	}
	if(pageNow_int>1){
		first = "first";
		previous = "previous";
	}
	if(totalCount_int>pagesize_int*pageNow_int){
		forward = "forward";
	  last = "last";
	}
	String sql_temp = "select to_char(UPDATELOG_ID),LOGIN_NAME,TO_CHAR(OP_DATE,'yyyy-dd-mm hh24:mi:ss'),MODULE_NAME,VERSION_NO,VERSION_REMARK,CONTEXT from DCALLUPDATELOG,DCALLMODULE where  "
	+ sql_condition 
	+ " and DCALLUPDATELOG.module_id=DCALLMODULE.module_id order by op_date desc";
	sql_temp = PageFilterSQL.getOraQuerySQL(sql_temp, pageNow, pagesize, totalCount);
	System.out.println(sql_temp);
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
	<wtc:param value="<%=sql_temp%>" />
	<wtc:param value="<%=myParams%>" />
</wtc:service>
<wtc:array id="tmpData" scope="end" />
	
<script language="javascript">
	function isNumber(str){ 
		var mynumber="0123456789"; 
		for(var i=0;i<str.length;i++){ 
			var c=str.charAt(i); 
			if(mynumber.indexOf(c)==-1){ 
				return false; 
			} 
		} 
		return true; 
	} 

	//提交
	function submitInputCheck(){
		document.sitechform.page.value = "1";
		document.sitechform.submit();
	}
	//跳转分页
	function jumpToPage(mode){
		var total = <%=totalCount%>;
		var pagesize = <%=pagesize%>;
		var nowPage = <%=pageNow%>;
		var maxPage = Math.ceil(total/pagesize);
		if(maxPage==0){
			maxPage = 1;
		}
		if(mode=='first'){
			if(nowPage>1){
				document.sitechform.page.value = "1";
			}else{
				return false;	
			}
	  }else if(mode=='previous'){
	  	if(nowPage>1){
				document.sitechform.page.value = nowPage-1;
			}else{
				return false;	
			}
	  }else if(mode=='forward'){
	  	if(total>pagesize*nowPage){
				document.sitechform.page.value = nowPage+1;
			}else{
				return false;	
			}
	  }else if(mode=='last'){
	  	if(total>pagesize*nowPage){
				document.sitechform.page.value = maxPage;
			}else{
				return false;	
			}
	  }else if(mode=='input'){
	  	var thePage = document.sitechform.thePage.value;	 
	  	if(isNumber(thePage)&&parseInt(thePage)>=1&&parseInt(thePage)<=maxPage){
				document.sitechform.page.value = thePage;
			}else{
				rdShowMessageDialog('请输入合适的数字:1~'+maxPage,2);	
				return false;
			}
	  }
		document.sitechform.submit();
		return true;
	}
	function addLog(){
		var height = 350;
		var width = 700;
		var top = screen.availHeight/2 - height/2;
		var left = screen.availWidth/2 - width/2;
		var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=yes";
		window.open("/npage/callbosspage/k074/k074_addlog.jsp?op_type=add", "addupdatelog", winParam);
	}
	function modifyLog(updatelog_id){
		var height = 350;
		var width = 700;
		var top = screen.availHeight/2 - height/2;
		var left = screen.availWidth/2 - width/2;
		var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=yes";
		window.open("/npage/callbosspage/k074/k074_addlog.jsp?op_type=modify&updatelog_id="+updatelog_id, "modifyupdatelog", winParam);
	}
	function deleteLog(updatelog_id){
		if(rdShowConfirmDialog("你确定删除此记录么？")=='1'){
			var url_k074_del="/npage/callbosspage/k074/k074_del.jsp?updatelog_id="+updatelog_id;   
      asyncGetText(url_k074_del,doDelete); 
		}
	}
	function doDelete(txt){
		if(txt=='Y'){
			rdShowMessageDialog('删除成功！',2);	
			document.sitechform.submit();
		}else{
			rdShowMessageDialog('删除失败！',2);	
		}
	}
	function saveCondition(){
		document.sitechform.module_id.value = "<%=module_id%>";
		document.sitechform.version_no.value = "<%=version_no%>";
		document.sitechform.login_no.value = "<%=login_no%>";
	}
</script>
</head>

<body onload="saveCondition()">
<form id=sitechform name=sitechform>
	<%@ include file="/npage/include/header.jsp"%>
	<input type="hidden" name="page" value="<%=pageNow%>">
	<input type="hidden" name="pagesize" value="<%=pagesize%>">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<div id="Operation_Table" style="width: 100%;">	
		<div class="title">
		 	<div id="title_zi">版本维护查询</div>
		</div>
		<table>	 
     <tr >
      <td class='Blue' nowrap >模块</td>
      <td  nowrap >
			  <select name="module_id" id="module_id">	  	
			  <option value="" selected>--所有模块--</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
					<wtc:sql>select to_char(MODULE_ID) , MODULE_NAME from DCALLMODULE order by MODULE_NAME</wtc:sql>
				</wtc:qoption>			  	
        </select>
		  </td>
	  	<td class='Blue' nowrap >版本号</td>
      <td nowrap  >
			  <input name ="version_no" type="text" id="version_no"  value="">
		  </td>
	  	<td class='Blue' nowrap >升级人员工号</td>
      <td  nowrap >
			  <input name ="login_no" type="text" id="login_no"  value="">
		  </td>	  
     </tr>
     <tr >
      <td colspan="6" align="center" id="footer">    
       <input name="search" type="button" class="b_foot" id="search" value="查询" onClick="submitInputCheck();">
       <input name="delete_value" type="reset" class="b_foot"  id="reset" value="重置">
       <input name="add" type="button" class="b_foot" id="add" value="新增" onClick="addLog();">
      </td>
     </tr>
		</table>
		<div class="title">
			<div id="title_zi">版本升级记录列表</div>
		</div>
		<table cellspacing="0">	
			<tr> 
        <th align="center" class="blue" width="10%" nowrap >模块</th>
        <th align="center" class="blue" width="8%" nowrap >升级人员</th>
        <th align="center" class="blue" width="12%" nowrap >版本号</th>
        <th align="center" class="blue" width="18%" nowrap >版本描述</th>
        <th align="center" class="blue" width="12%" nowrap >升级时间</th>
        <th align="center" class="blue" style="word-break:break-all" >升级描述</th>
        <th align="center" class="blue" width="9%" nowrap >操作</th>
    	</tr>
<%
		for(int i=0;i<tmpData.length;i++){
%>
			<tr> 
        <td align="left" class="blue" width="10%" nowrap ><%=tmpData[i][3]%></td>
        <td align="left" class="blue" width="8%" nowrap ><%=tmpData[i][1]%></td>
        <td align="left" class="blue" width="12%" nowrap ><%=tmpData[i][4]%></td>
        <td align="left" class="blue" width="18%" nowrap ><%=tmpData[i][5]%></td>
        <td align="left" class="blue" width="12%" nowrap ><%=tmpData[i][2]%></td>
        <td align="left" class="blue" style="word-break:break-all" ><%=tmpData[i][6]%></td>
        <td align="left" class="blue" width="9%" nowrap >
        	<img onclick="deleteLog('<%=tmpData[i][0]%>')" alt="删除" src="/nresources/default/images/callimage/operImage/del.gif"  width="16" height="16" align="absmiddle">
        	&nbsp;
        	<img onclick="modifyLog('<%=tmpData[i][0]%>')" alt="修改" src="/nresources/default/images/callimage/operImage/2.gif"  width="16" height="16" align="absmiddle">
        </td>
    	</tr>
<%		
		}
%>
		</table>
		<div class="nextPages">
		 	<div class="<%=first%>" ><a href="#" onClick="jumpToPage('first')" ></a></div> 
			<div class="<%=previous%>" ><a href="#" onClick="jumpToPage('previous')" ></a></div> 
			<div class="<%=forward%>" ><a href="#" onClick="jumpToPage('forward')"></a></div> 
			<div class="<%=last%>" ><a href="#" onClick="jumpToPage('last')"></a></div>
			<div style="float:left;"><a style="float:left;"><font face=粗体>快速跳转</font></a></div>
			<div style="float:left;">
				<input id="thePage" name="thePage" type="text" value="1" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>
			</div>
			<div style="float:left;">
				<a href="#" onClick="jumpToPage('input');return false;"><font face=粗体>GO</font></a>
		  </div>
			<span class="pages">总记录数：<%=totalCount%> </span>
			<span class="pages">第<%=pageNow%>/<%=totalpage%>页</span>
		</div> 
		<table  cellSpacing="0">
			
	  </table>
	 </div>
	</form>
</body>
