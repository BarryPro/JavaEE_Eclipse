<%
  /*
   * ����: ϵͳ�汾������ѯ
�� * �汾: 1.0
�� * ����: 2009/10/12
�� * ����: jiangbing
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
<title>ҵ���ѯ</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/nresources/default/css/nextPages.css" ></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>

<%!
	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}	
%>
<%
	String opCode="K075";
  String opName="ҵ���ѯ";
      /*midify by yinzx 20091113 ������ѯ�����滻*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
 	  
	//��¼����
	String kf_longin_no = (String) session.getAttribute("workNo");
	/**��ȡ��ѯ����**/
	//��ǰҳ��
	String pageNow = WtcUtil.repNull(request.getParameter("page"));
	boolean needSearch = true;
	if(pageNow.equals("")){
		needSearch = false;
		pageNow = "1";
	}
	String pagesize = WtcUtil.repNull(request.getParameter("pagesize"));
	if(pagesize.equals("")){
		pagesize = "10";
	}
	String totalCount = "0";
	String acceptphone = WtcUtil.repNull(request.getParameter("acceptphone"));
	String callerno = WtcUtil.repNull(request.getParameter("callerno"));
	String begin_date = WtcUtil.repNull(request.getParameter("begin_date"));
	String end_date = WtcUtil.repNull(request.getParameter("end_date"));
	
	String sql_condition = " 1=1 ";
	if(!needSearch){
		sql_condition = " 1=2 ";
	}
	if(!acceptphone.equals("")){
			sql_condition += " and acceptphone=:vacceptphone  ";
		  myParams+="vacceptphone="+acceptphone;
	}
	if(!callerno.equals("")){
			sql_condition += " and callerno=:vcallerno  ";
			myParams+=",vcallerno="+callerno;
	}
	if(!begin_date.equals("")){
			sql_condition += " and LOGDATE>to_date(:begin_date ,'yyyymmdd hh24:mi:ss') ";
			myParams+=",begin_date="+begin_date;
	}
	if(!end_date.equals("")){
			sql_condition += " and LOGDATE<to_date(:end_date ,'yyyymmdd hh24:mi:ss') ";
			myParams+=",end_date="+end_date;
	}
	String sql_count = "select to_char(count(*)) from dbcalladm.V_HUAWEI_CALLINFO where "+ sql_condition;
	System.out.println(sql_count);
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
	<wtc:param value="<%=sql_count%>" />
	<wtc:param value="<%=myParams%>" />
</wtc:service>
<wtc:array id="tmpCount" scope="end" />
<%
	if (tmpCount != null && tmpCount.length != 0) {
		totalCount = tmpCount[0][0];
	}
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
	
	String sql_temp = "SELECT ACCEPTPHONE,CALLERNO,TO_CHAR(LOGDATE,'yyyy-dd-mm hh24:mi:ss') logdate,OPERATETRACE, AUTOSERVICENAME, OPRESULTDSC from dbcalladm.V_HUAWEI_CALLINFO where  "
	+ sql_condition 
	+ " order by LOGDATE desc";
	sql_temp = PageFilterSQL.getOraQuerySQL(sql_temp, pageNow, pagesize, totalCount);
	System.out.println(sql_temp);
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
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

	//�ύ
	function submitInputCheck(){
		if( document.sitechform.acceptphone.value == ""){
    	   showTip(document.sitechform.acceptphone,"������벻��Ϊ��");
    	   sitechform.acceptphone.focus();
    	   return;

    }else if( !isNumber(document.sitechform.acceptphone.value)){
    	   showTip(document.sitechform.acceptphone,"��������ʽ����ȷ");
    	   sitechform.acceptphone.focus();
    	   return;

    }else if( !isNumber(document.sitechform.callerno.value)){
    	   showTip(document.sitechform.callerno,"���к����ʽ����ȷ");
    	   sitechform.callerno.focus();
    	   return;

    }else if( document.sitechform.begin_date.value == ""){
    	   showTip(document.sitechform.begin_date,"��ʼʱ�䲻��Ϊ��");
    	   sitechform.begin_date.focus();
    	   return;

    }else if(document.sitechform.end_date.value == ""){
		     showTip(document.sitechform.end_date,"����ʱ�䲻��Ϊ��");
    	   sitechform.end_date.focus();
    	   return;
    }
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
	  saveCondition();
		document.sitechform.submit();
		return true;
	}

	function saveCondition(){
		<% 
			if(needSearch){
		%>
		
		document.sitechform.acceptphone.value = "<%=acceptphone%>";
		document.sitechform.callerno.value = "<%=callerno%>";
		document.sitechform.begin_date.value = "<%=begin_date%>";
		document.sitechform.end_date.value = "<%=end_date%>";
		<%
			}
		%>
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
		 	<div id="title_zi">ҵ���ѯ</div>
		</div>
		<table>	 
     <tr >
      <td class='Blue' nowrap >�������<font color="orange">*</font></td>
      <td  nowrap >
				<input name ="acceptphone" type="text" id="acceptphone"  value="">
		  </td>
	  	<td class='Blue' nowrap >���к���</td>
      <td nowrap  >
			  <input name ="callerno" type="text" id="callerno"  value="">
		  </td>
     </tr>
     <tr >
      <td class='Blue' nowrap >��ʼʱ��<font color="orange">*</font></td>
      <td  nowrap >
      	<input id="begin_date" name ="begin_date" type="text"  value="<%=needSearch?begin_date:getCurrDateStr("00:00:00")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});" readonly="readonly">
		  </td>
	  	<td class='Blue' nowrap >����ʱ��<font color="orange">*</font></td>
      <td nowrap  >
			  <input id="end_date" name ="end_date" type="text"  value="<%=needSearch?end_date:getCurrDateStr("23:59:59")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});" readonly="readonly">
		  </td>
     </tr>
     <tr >
      <td colspan="4" align="center" id="footer">    
       <input name="search" type="button" class="b_foot" id="search" value="��ѯ" onClick="submitInputCheck();">
       <input name="delete_value" type="reset" class="b_foot"  id="reset" value="����">
      </td>
     </tr>
		</table>
		<div class="title">
			<div id="title_zi">ҵ������б�</div>
		</div>
		<table cellspacing="0">	
			<tr> 
        <th align="center" class="blue" width="12%" nowrap >�������</th>
        <th align="center" class="blue" width="12%" nowrap >���к���</th>
        <th align="center" class="blue" width="15%" nowrap >����ʱ��</th>
        <th align="center" class="blue" width="12%" nowrap >����·��</th>
        <th align="center" class="blue" width="10%" nowrap >ҵ������</th>
        <th align="center" class="blue" >���ر�ʶ</th>
    	</tr>
<%
		for(int i=0;i<tmpData.length;i++){
%>
			<tr> 
        <td align="left" class="blue" width="12%" nowrap ><%=tmpData[i][0]%></td>
        <td align="left" class="blue" width="12%" nowrap ><%=tmpData[i][1]%></td>
        <td align="left" class="blue" width="15%" nowrap ><%=tmpData[i][2]%></td>
        <td align="left" class="blue" width="12%" nowrap ><%=tmpData[i][3]%></td>
        <td align="left" class="blue" width="10%" nowrap ><%=tmpData[i][4]%></td>
        <td align="left" class="blue" ><%=tmpData[i][5]%></td>
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
