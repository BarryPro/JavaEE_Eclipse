<!DOCTYPE html PUBLIC "-//W3C//Dth XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dth/xhtml1-transitional.dth">
<%
  /*
   * ����: IVRת�����̲�ѯ
�� * �汾: 1.0
�� * ����: 2010/06/12
�� * ����: hucw
�� * ��Ȩ: sitech
 ��*/
 
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="java.util.HashMap,java.util.List"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/commonfuns.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%  
		System.out.println("############aaaaaa################");  	
		//��ʼ����ĵط�
    String opCode="k175";
    String opName="�ۺϲ�ѯ-IVRת�����̲�ѯ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  /*midify by yinzx 20091113 ������ѯ�����滻*/
 		String myParams=request.getParameter("para");     
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String kf_longin_no=(String)session.getAttribute("kfWorkNo");	  
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
	  System.out.println("--------------aaaaaaa-------------------");
    String start_date = request.getParameter("start_date");           
    String end_date = request.getParameter("end_date");             
    String contact_id = request.getParameter("contact_id");       
    String accept_login_no = request.getParameter("accept_login_no");
    String caller_phone = request.getParameter("caller_phone");  
    String accept_phone = request.getParameter("accept_phone"); 
    String transtype = request.getParameter("transtype");   
      
    String[][] dataRows = new String[][]{};
    String tablename="";
    HashMap params = new HashMap();
    if(start_date == null || "".equals(start_date.trim())){
    	//tablename = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()));
    }else{
    	tablename = start_date.substring(0,6);
    }
    params.put("start_date",start_date);
  	params.put("end_date",end_date);
  	params.put("contact_id",contact_id);
  	params.put("accept_login_no",accept_login_no);
  	params.put("caller_phone",caller_phone);
  	params.put("accept_phone",accept_phone);
  	params.put("transtype",transtype);
  	params.put("tablename",tablename);
  	
  	String sqlFilter="";
    int rowCount =0;							 //total records
    int pageSize = 15;             // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;                // Transfered pages
    String myaction = request.getParameter("myaction");
  	if (myaction != null && "doLoad".equals(myaction.trim())) {
        rowCount = ((Integer)KFEjbClient.queryForObject("query_K175_count",params)).intValue(); 
        System.out.println("################"+rowCount+"###############");
				//������ҳ��             
        pageCount = rowCount/pageSize + (rowCount%pageSize>0?1:0);
        
        //��ȡ��ǰҳ��
        strPage = request.getParameter("page");

        if ( strPage == null || "".equals(strPage.trim())) {
          	curPage = 1; 
        }else{ 
        	curPage = Integer.parseInt(strPage);
        }
        System.out.println("pageCount="+pageCount);
        if(curPage <= 0) curPage = 1;
        if(curPage > pageCount) curPage = pageCount;
        System.out.println("curPage="+curPage);
        int start = (curPage-1)*pageSize+1;
      	int end = curPage*pageSize;

        //��ѯ�������
        params.put("start",""+start);
      	params.put("end",""+end);
 				System.out.println("start="+start+":end="+end);
        List queryList =(List)KFEjbClient.queryForList("query_K175_sqlStr",params);  
        System.out.println("list size()="+queryList.size());        
	      dataRows=getArrayFromListMap(queryList,1,12);
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

<title>IVRת�����̲�ѯ</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
$(document).ready(function() {
	$("tr").not("[input]").addClass("blue");
	$("th").not("[input]").addClass("Blue");
	$("#footer input:button").addClass("b_foot");
	$("td:not(#footer) input:button").addClass("b_text");
	$("input:text[@v_type]").blur(checkElement2);
	$("a").hover(function() {
		$(this).css("color", "orange");
	}, function() {
		$(this).css("color", "#159ee4");
	});
});

function checkElement2() {
	checkElement(this);
}

function submitInputCheck(orderColumn, orderCode){
	if( document.sitechform.start_date.value == ""){
		showTip(document.sitechform.start_date,"��ʼʱ�䲻��Ϊ��");
		sitechform.start_date.focus();
	}else if(document.sitechform.end_date.value == ""){
	  showTip(document.sitechform.end_date,"����ʱ�䲻��Ϊ��");
		sitechform.end_date.focus();
	}else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
	  showTip(document.sitechform.end_date,"����ʱ�������ڿ�ʼʱ��");
		sitechform.end_date.focus();
	}else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
	  showTip(document.sitechform.end_date,"ֻ�ܲ�ѯһ�����ڵļ�¼");
		sitechform.end_date.focus();
	}else{
	  hiddenTip(document.sitechform.start_date);
	  hiddenTip(document.sitechform.end_date);
	  submitMe();
	}
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="k175_ManToIVRQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

//��ת��ָ��ҳ��
function jumpToPage(operateCode){
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

//�������¼
function clearValue(){
	var e = document.forms[0].elements;
	for(var i=0;i<e.length;i++){
  	if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
  		if(e[i].id=="start_date"){
	  		e[i].value='<%=getCurrDateStr("00:00:00")%>';
	  	} else if(e[i].id=="end_date"){
	  		e[i].value='<%=getCurrDateStr("23:59:59")%>';
	  	} else{
	  		e[i].value="";
	  	}
  	} else if(e[i].type=="checkbox"){
  		e[i].checked=false;
  	}
 	}
  window.location="k175_ManToIVRQry.jsp";
}

function keepValue(){
	window.sitechform.start_date.value="<%=start_date%>";
	window.sitechform.end_date.value="<%=end_date%>";
	window.sitechform.contact_id.value="<%=contact_id%>";
	window.sitechform.accept_login_no.value="<%=accept_login_no%>";
	window.sitechform.caller_phone.value="<%=caller_phone%>";
}

//ȥ��ո�;
function ltrim(s){
  return s.replace( /^\s*/, "");
}

//ȥ�ҿո�;
function rtrim(s){
	return s.replace( /\s*$/, "");
}

//ȥ���ҿո�;
function trim(s){
	return rtrim(ltrim(s));
}
</script>
</head>

<body>
<form id=sitechform name=sitechform>
<div id="Operation_Table"" style="width: 100%;">
<table cellspacing="0">
	<tr>
		<td colspan="6">
			<div class="title">
				<div id="title_zi">����ת�Ӳ�ѯ</div>
			</div>
		</td>
	</tr>
	<tr>
		<td nowrap>��ʼʱ��</td>
		<td nowrap>
			<input id="start_date" name="start_date" type="text" value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>"
			onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);changeSize(2);"
			onchange="changeSize(1)"> 
			<img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);changeSize(2);"
			src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif"
			width="16" height="22" align="absmiddle"> 
			<font color="orange">*</font>
		</td>
		<td>������ˮ��</td>
		<td>
			<input id="contact_id" name="contact_id" type="text" 
			onbeforepaste="clipboardData.sethata('text',clipboardData.gethata('text').replace(/[^kf\d]/g,''))" value=<%=(contact_id==null)?"":contact_id%>>
		</td>
		<td>ת���˺�</td>
		<td>
			<input name="accept_login_no" type="text" id="accept_login_no" onbeforepaste="clipboardData.sethata('text',clipboardData.gethata('text').replace(/[^kf\d]/g,''))" value="<%=(accept_login_no==null)?"":accept_login_no%>">
		</td>
	</tr>
	<tr>
		<td nowrap>����ʱ��</td>
		<td nowrap><input id="end_date" name="end_date" type="text"
			value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>"
			onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);"
			onchange="changeSize(1)"> <img
			onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})"
			src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif"
			width="16" height="22" align="absmiddle"> <font color="orange">*</font>
		</td>
		<td >���к���</td>
		<td><input id="caller_phone" name="caller_phone" type="text"
			onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"
			onbeforepaste="clipboardData.sethata('text',clipboardData.gethata('text').replace(/[^a-zA-Z\d]/g,''))"
			value=<%=(caller_phone==null)?"":caller_phone%>></td>
		<td >�������</td>
		<td><input id="accept_phone" name="accept_phone" type="text"
			onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"
			onbeforepaste="clipboardData.sethata('text',clipboardData.gethata('text').replace(/[^a-zA-Z\d]/g,''))"
			value=<%=(accept_phone==null)?"":accept_phone%>></td>
	</tr>
	<tr>
		<td>ת�Ʒ�ʽ</td>
		<td><select id="transtype" name="transtype" size="1"
			onchange="operText.value=this.options[this.selectedIndex].text">
			<option selected="true" value="">ȫ��</option>
			<option value="0">�ͷ�ת��</option>
			<option value="1">����ת</option>
		</select></td>
	</tr>
	

	<!-- THE THIRD LINE OF THE CONTENT -->
	<!-- ICON IN THE MIDDLE OF THE PAGE-->
	<tr>
		<td colspan="6" id="footer" style="text-align:left;padding-left:25%;">
			<input name="search" type="button" id="search" value="��ѯ" onClick="submitInputCheck();return false;">&nbsp;&nbsp; 
			<input name="delete_value" type="button" id="add" value="����" onClick="clearValue();">&nbsp;&nbsp; 
			<input name="export" type="button" id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
		</td>
	</tr>
	</table>
	</div>
	
  <div id="Operation_Table">
	<table  cellspacing="0">
	<tr>
		<td align="left" colspan="12">
		<%if(pageCount!=0){%> ��<%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
		<%} else{%> <font color="orange">��ǰ��¼Ϊ�գ�</font> <%}%> <%if(pageCount!=1 && pageCount!=0){%>
		<a href="#" onClick="doLoad('first');return false;">��ҳ</a> <%}%> <%if(curPage>1){%>
		<a href="#" onClick="doLoad('pre');return false;">��һҳ</a> <%}%> <%if(curPage<pageCount){%>
		<a href="#" onClick="doLoad('next');return false;">��һҳ</a> <%}%> <%if(pageCount>1){%>
		<a href="#" onClick="doLoad('last');return false;">βҳ</a> 
		<!--modify hucw 20100829<a>����ѡ��</a>-->
    <span>����ѡ��</span>
		<select onchange="jumpToPage(this.value)" style="width:3em;height:2em">
			<%for(int i=1;i<=pageCount;i++){
        	          out.print("<option value='"+i+"'");
        	          if(i==curPage){
        	          out.print("selected");
        	          }
        	          out.print(">"+i+"</option>");
       }%>
		</select style="height:18px">&nbsp;&nbsp; 
		<!--modify hucw 20100829<a>������ת</a>-->
		<span>������ת</span>
		<input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height: 18px; width: 30px" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "	onbeforepaste="clipboardData.sethata('text',clipboardData.gethata('text').replace(/[^\d]/g,''))" />
		<a href="#" onClick="jumpToPage('jumpToPage');return false;"> 
			<font face=����>GO</font> 
		</a>
		<%}%>
		</td>
	</tr>

	<input type="hidden" name="page" value="">
	<input type="hidden" name="myaction" value="">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<input type="hidden" name="para" value="">
	<tr>
		<th align="center"	nowrap>ת����ˮ��</th>  
    <th align="center"	 nowrap>������ˮ��</th> 
    <th align="center"	nowrap>���к���</th>    
    <th align="center"	nowrap>�������</th>    
    <th align="center"	nowrap>���п�ʼʱ��</th>
    <th align="center"	nowrap>ת��ʱ��</th>    
    <th align="center"	nowrap>ת����</th>      
    <th align="center"	nowrap>ת������</th>    
    <th align="center"	nowrap>ת����</th>      
    <th align="center"	nowrap>ת������</th>    
    <th align="center"	nowrap>������</th>      
    <th align="center"	nowrap>ת��״̬</th>
	</tr>

	<% for ( int i = 0; i < dataRows.length; i++ ) {             
                                      %>
	<tr>
		<td align="center" width="6%"  nowrap><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
		<td align="center" width="12%" nowrap><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
		<td align="center" width="5%"  nowrap><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
		<td align="center" width="5%"  nowrap><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
		<td align="center" width="5%"  nowrap><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
		<td align="center" width="5%"  nowrap><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
		<td align="center" width="5%"  nowrap><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
		<td align="center" width="5%"  nowrap><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
		<td align="center" width="5%"  nowrap><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
		<td align="center" width="5%"  nowrap><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
		<td align="center" width="5%"  nowrap><%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
		<td align="center" width="5%"  nowrap><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td> 
	</tr>
	<% } %>
  <tr>
		<td align="right" colspan="12" style="font:black;">
		<%if(pageCount!=0){%> ��<%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
		<%} else{%> <font color="orange">��ǰ��¼Ϊ�գ�</font> <%}%> <%if(pageCount!=1 && pageCount!=0){%>
		<a href="#" onClick="doLoad('first');return false;">��ҳ</a> <%}%> <%if(curPage>1){%>
		<a href="#" onClick="doLoad('pre');return false;">��һҳ</a> <%}%> <%if(curPage<pageCount){%>
		<a href="#" onClick="doLoad('next');return false;">��һҳ</a> <%}%> <%if(pageCount>1){%>
		<a href="#" onClick="doLoad('last');return false;">βҳ</a> 
		<!--modify hucw 20100829<a>����ѡ��</a>-->
    <span>����ѡ��</span>
		<select onchange="jumpToPage(this.value)" style="width:3em;height:2em">
			<%for(int i=1;i<=pageCount;i++){
        	          out.print("<option value='"+i+"'");
        	          if(i==curPage){
        	          out.print("selected");
        	          }
        	          out.print(">"+i+"</option>");
       }%>
		</select style="height:18px">&nbsp;&nbsp; 
		<!--modify hucw 20100829<a>������ת</a>-->
		<span>������ת</span>
		<input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height: 18px; width: 30px" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "	onbeforepaste="clipboardData.sethata('text',clipboardData.gethata('text').replace(/[^\d]/g,''))" />
		<a href="#" onClick="jumpToPage('jumpToPage');return false;"> 
			<font face=����>GO</font> 
		</a>	
		<%}%>
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>

