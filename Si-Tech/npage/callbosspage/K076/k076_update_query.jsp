<%
  /*
   * ����: �ͻ��˰汾������ѯ
�� * �汾: 1.0
�� * ����: 2009/10/28
�� * ����: fangyuan
�� * ��Ȩ: sitech
 ��*/
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
<title>�ͻ������������ѯ</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/nresources/default/css/nextPages.css" ></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" language="javascript" src="/njs/si/base.js"></script>
<SCRIPT type="text/javascript" language=javascript src="/njs/si/ajax.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<%!
	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}	
%>
<%
	String opCode="K076";
  String opName="�ͻ������������ѯ";
  String myParams="";
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode = org_code.substring(0,2);
	//��¼����
	String kf_longin_no = (String) session.getAttribute("workNo");
	/**��ȡ��ѯ����**/
	//��ǰҳ��
	String pageNow = WtcUtil.repNull(request.getParameter("page"));
	if(pageNow.equals("")){
		pageNow = "1";
	}
	String pagesize = WtcUtil.repNull(request.getParameter("pagesize"));
	if(pagesize.equals("")){
		pagesize = "10";
	}
	String totalCount = "0";
	String client_ip = WtcUtil.repNull(request.getParameter("client_ip"));
	String upd_starttime = WtcUtil.repNull(request.getParameter("upd_starttime"));
	String upd_endtime = WtcUtil.repNull(request.getParameter("upd_endtime"));
	String issuccess = WtcUtil.repNull(request.getParameter("issuccess"));
	String version_no = WtcUtil.repNull(request.getParameter("version_no"));
	
	String sql_condition = " 1=1 ";
	boolean hasCondition = false;
	if(!upd_starttime.equals("")){
			sql_condition += " and update_time>=to_date(:upd_starttime,'yyyy-mm-dd hh24:mi:ss') ";
			myParams = (hasCondition?",":"")+"upd_starttime="+upd_starttime;
			hasCondition = true;
	}
	if(!upd_endtime.equals("")){
			sql_condition += " and update_time<=to_date(:upd_endtime,'yyyy-mm-dd hh24:mi:ss') ";
			myParams = (hasCondition?",":"")+"upd_endtime="+upd_endtime;
			hasCondition = true;
	}
	if(!version_no.equals("")){
			sql_condition += " and version=:version_no ";
			myParams = (hasCondition?",":"")+"version_no="+version_no;
			hasCondition = true;
	}
	if(!issuccess.equals("")){
			sql_condition += " and success_flag=:issuccess ";
			myParams = (hasCondition?",":"")+"issuccess="+issuccess;
			hasCondition = true;
	}
	if(!client_ip.equals("")){
			sql_condition += " and client_ip=:client_ip ";
			myParams = (hasCondition?",":"")+"client_ip="+client_ip;
			hasCondition = true;
	}
	
	String sql_count = "select to_char(count(*)) from dcallclientupd where "+ sql_condition;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
	<wtc:param value="<%=sql_count%>"/>
	<wtc:param value="<%=myParams%>"/>
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
	String sql_temp = "select T.CLIENT_UPD_ID,t.client_ip,to_char(t.update_time,'yyyy-MM-dd hh24:mi:ss'),t.version,decode(success_flag,'Y','�ɹ�','ʧ��') from dcallclientupd t where  "
	+ sql_condition 
	+ "  order by CLIENT_UPD_ID desc";
	sql_temp = PageFilterSQL.getOraQuerySQL(sql_temp, pageNow, pagesize, totalCount);
	System.out.println(sql_temp);
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="9">
		<wtc:param value="<%=sql_temp%>"/>
		<wtc:param value="<%=myParams%>"/>
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

	//�ύ
	function submitInputCheck(){
		document.sitechform.page.value = "1";
		document.sitechform.submit();
	}
	//��ת��ҳ
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
				rdShowMessageDialog('��������ʵ�����:1~'+maxPage,2);	
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
		if(rdShowConfirmDialog("��ȷ��ɾ���˼�¼ô��")=='1'){
			var url_k074_del="/npage/callbosspage/k074/k074_del.jsp?updatelog_id="+updatelog_id;   
      asyncGetText(url_k074_del,doDelete); 
		}
	}
	function doDelete(txt){
		if(txt=='Y'){
			rdShowMessageDialog('ɾ���ɹ���',2);	
			document.sitechform.submit();
		}else{
			rdShowMessageDialog('ɾ��ʧ�ܣ�',2);	
		}
	}
	function saveCondition(){
		document.sitechform.client_ip.value = "<%=client_ip%>";
		document.sitechform.version_no.value = "<%=version_no%>";
		document.sitechform.upd_starttime.value = "<%=upd_starttime%>";
		document.sitechform.upd_endtime.value = "<%=upd_endtime%>"; 
		document.sitechform.issuccess.value = "<%=issuccess%>";
	}
</script>
</head>

<body onload="saveCondition()">
<form id=sitechform name=sitechform>
	
	<input type="hidden" name="page" value="<%=pageNow%>">
	<input type="hidden" name="pagesize" value="<%=pagesize%>">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<div id="Operation_Table" style="width: 100%;">	
		<div class="title">
		 	<div id="title_zi">�ͻ������������ѯ</div>
		</div>
		<table>	 
     <tr >
      <td class='Blue' >������ʼʱ��</td>
          <td  nowrap >
			  <input id="upd_starttime" name ="upd_starttime" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.upd_starttime);">
		    <img onclick="WdatePicker({el:$dp.$('upd_starttime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
	  	<td class='Blue'>ip��ַ</td>
      <td nowrap  >
			  <input name ="client_ip" type="text" id="client_ip"  value="">
		  </td>
	  <td class='Blue'>�汾��</td>
      <td  nowrap >
			  <input name ="version_no" type="text" id="version_no"  value="">
		  </td>	  
	  
     </tr>
     <tr >
      <td class='Blue' >��������ʱ��</td>
          <td  nowrap >
			  <input id="upd_endtime" name ="upd_endtime" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.upd_endtime);">
		    <img onclick="WdatePicker({el:$dp.$('upd_endtime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
	  <td class='Blue'>�Ƿ�ɹ�</td>
      <td  nowrap >
			  <select name="issuccess">
			  	<option value="" selected>--ȫ��--</option>
			  	<option value='Y'>�ɹ�</option>	
			  	<option value='N'>ʧ��</option>
			  </select>
		  </td>	 
	  <td class='Blue' colspan=2></td>	  	  
     </tr>
     <tr >
      <td colspan="8" align="center" id="footer">    
       <input name="search" type="button" class="b_foot" id="search" value="��ѯ" onClick="submitInputCheck();">
       <input name="delete_value" type="reset" class="b_foot"  id="reset" value="����">
      
      </td>
     </tr>
		</table>
		<div class="title">
			<div id="title_zi">�ͻ���������¼�б�</div>
		</div>
		<table cellspacing="0">	
			<tr> 
        <th align="center" class="blue" width="10%" nowrap >����ʱ��</th>
        <th align="center" class="blue" width="8%" nowrap >�ͷ���IP</th>
        <th align="center" class="blue" width="12%" nowrap >�汾��</th>
        <th align="center" class="blue" width="18%" nowrap >�������</th>
        
      
    	</tr>
<%
		for(int i=0;i<tmpData.length;i++){
%>
			<tr> 
        <td align="center" class="blue" width="10%" nowrap ><%=tmpData[i][2]%></td>
        <td align="center" class="blue" width="8%" nowrap ><%=tmpData[i][1]%></td>
        <td align="center" class="blue" width="12%" nowrap ><%=tmpData[i][3]%></td>
        <td align="center" class="blue" width="18%" nowrap ><%=tmpData[i][4]%></td>
  
 
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
			<div style="float:left;"><a style="float:left;"><font face=����>������ת</font></a></div>
			<div style="float:left;">
				<input id="thePage" name="thePage" type="text" value="1" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>
			</div>
			<div style="float:left;">
				<a href="#" onClick="jumpToPage('input');return false;"><font face=����>GO</font></a>
		  </div>
			<span class="pages">�ܼ�¼����<%=totalCount%> </span>
			<span class="pages">��<%=pageNow%>/<%=totalpage%>ҳ</span>
		</div> 
		<table  cellSpacing="0">
			
	  </table>
	 </div>
	</form>
</body>
