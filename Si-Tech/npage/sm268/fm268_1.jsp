<%
/********************
 
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-6-10 9:44:18-------------------
  ���ڶ�ά��ҵ�����ϵͳ��չʹ��Ⱥ�������
 -------------------------��̨��Ա�����--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
  	String opName      = WtcUtil.repNull(request.getParameter("opName"));
                     
  String workNo      = (String)session.getAttribute("workNo");
  String password    = (String)session.getAttribute("password");
  String workName    = (String)session.getAttribute("workName");
  String orgCode     = (String)session.getAttribute("orgCode");
  String ipAddrss    = (String)session.getAttribute("ipAddr");
  String regionCode  = (String)session.getAttribute("regCode");
  String currentDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  
  String numpage            = (String)request.getParameter("numpage") == null? "1":(String)request.getParameter("numpage");
  String endpanges          = (String)request.getParameter("numpage") == null? "0":(String)request.getParameter("numpage");
  String zongshus           = (String)request.getParameter("zongshus") == null? "0":(String)request.getParameter("zongshus");


	//ҵ��Ҫ�ش��ݹ����Ĳ���
	String phoneNo_t = (String)request.getParameter("phoneNo_t") == null? "":(String)request.getParameter("phoneNo_t");
	String loginNo_t = (String)request.getParameter("loginNo_t") == null? "":(String)request.getParameter("loginNo_t");
	
	String beginDate = (String)request.getParameter("beginDate") == null? currentDate:(String)request.getParameter("beginDate");
	String endDate   = (String)request.getParameter("endDate") == null? currentDate:(String)request.getParameter("endDate");
	String phoneNo_bl   = (String)request.getParameter("phoneNo_bl") == null? "":(String)request.getParameter("phoneNo_bl");
	

	    System.out.println("--------------numpage-------------> " + numpage);
%>

<wtc:service name="sm268Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="11">
  	<wtc:param value="0"/>
  	<wtc:param value="01"/>
  	<wtc:param value="<%=opCode%>"/>
  	<wtc:param value="<%=workNo%>"/>
  	<wtc:param value="<%=password%>"/>
    <wtc:param value="<%=phoneNo_t%>"/>
  	<wtc:param value=""/>
  	<wtc:param value="<%=loginNo_t%>"/>
  	<wtc:param value="<%=beginDate%>"/>	
  	<wtc:param value="<%=endDate%>"/>
  	<wtc:param value="<%=numpage%>"/>
  	<wtc:param value="<%=phoneNo_bl%>"/>
</wtc:service>

	<wtc:array id="result_t1" scope="end" start="0"  length="1"  />
	<wtc:array id="result_t2" scope="end" start="1"  length="10" />
<%

	System.out.println("-----------result_t1.length------------------>"+result_t1.length);
	System.out.println("-----------result_t2.length------------------>"+result_t2.length);
	if(retCode.equals("000000")){
	if(result_t1.length>0) {
    	
    
    	zongshus=result_t1[0][0];
    	
    	
		if(Integer.parseInt(result_t1[0][0].trim())==0) {
		 		endpanges="1";
		 }
		 if(Integer.parseInt(result_t1[0][0].trim())>0 && Integer.parseInt(result_t1[0][0].trim())<50) {
		 		endpanges="1";
		 }
		 if(Integer.parseInt(result_t1[0][0].trim())>50) {
		 		endpanges=(Integer.parseInt(result_t1[0][0].trim())/50+1)+"";
		 }
	  }
	}
%>



<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>
 
function pagecontione(nums) {  		
		
		if(!check_input())		return;
		
		window.location="fm268_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>"+
		"&phoneNo_t="+$("#phoneNo_t").val().trim()+
		"&loginNo_t="+$("#loginNo_t").val().trim()+
		"&beginDate="+$("#beginDate").val().trim()+
		"&endDate="+$("#endDate").val().trim()+
		
		"&numpage="+nums+"&endpanges=<%=endpanges%>&zongshus=<%=zongshus%>"+"&phoneNo_bl="+$("#phoneNo_bl").val().trim();			
}

function doQuery(){
	
	if(!check_input())		return;
	window.location="fm268_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>"+
		"&phoneNo_t="+$("#phoneNo_t").val().trim()+
		"&loginNo_t="+$("#loginNo_t").val().trim()+
		"&beginDate="+$("#beginDate").val().trim()+
		"&endDate="+$("#endDate").val().trim()+
		"&numpage=1&endpanges=<%=endpanges%>&zongshus=<%=zongshus%>"+"&phoneNo_bl="+$("#phoneNo_bl").val().trim();	
}  

/*
 * У���
 * ��ʼʱ��ͽ���ʱ�������д���Ƽ��ֻ�������Ƽ�����ֻ������������һ�������߶������롣 
 * ��ʼʱ��ͽ���ʱ�䲻�������Ȼ��
 */
function check_input(){
	if($("#phoneNo_t").val().trim()!=""&&$("#loginNo_t").val().trim()!=""){
		rdShowMessageDialog("�Ƽ��ֻ�������Ƽ�����ֻ������������һ�������߶�������");
		return false;
	}
	
	var beginDate = $("#beginDate").val().trim();
	var endDate   = $("#endDate").val().trim();
	
	if(beginDate==""){
		rdShowMessageDialog("��ѯ��ʼʱ���������");
		return false;
	}
	
	if(endDate==""){
		rdShowMessageDialog("��ѯ����ʱ���������");
		return false;
	}
	
	if(beginDate.substring(0,6)!=endDate.substring(0,6)){
		rdShowMessageDialog("��ʼʱ�䡢����ʱ�䲻�������Ȼ��");
		return false;
	}
	
	if(parseInt(beginDate)>parseInt(endDate)){
		rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��");
		return false;
	}
	
	return true;
}
function reSetThis(){
	window.location="fm268_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>"+
		"&phoneNo_t="+""+
		"&loginNo_t="+""+
		"&beginDate="+"<%=currentDate%>"+
		"&endDate="+"<%=currentDate%>"+
		"&numpage=1&endpanges=<%=endpanges%>&zongshus=<%=zongshus%>"+"&phoneNo_bl="+"";	
}

var excelObj;
function printTable()
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">��ѯ����</div></div>


<table cellSpacing="0">
	<tr>
		<td class="blue" width="=15%">ҵ������ֻ�����</td>
		<td width="35%" colspan="3">
			<input type="text" name="phoneNo_bl" id="phoneNo_bl" value="<%=phoneNo_bl%>">
		</td>
	</tr>
	<tr>
	    <td class="blue" width="15%">�Ƽ��ֻ�����</td>
		  <td width="35%">
			    <input type="text" name="phoneNo_t" id="phoneNo_t" value="<%=phoneNo_t%>" /> 
		  </td>
		  
		      <td class="blue" width="15%">�Ƽ�����</td>
		  <td width="35%">
			    <input type="text" name="loginNo_t" id="loginNo_t" value="<%=loginNo_t%>" /> 
		  </td>
	</tr>
	<tr>
		  <td class="blue" width="15%">��ʼʱ��</td>
		  <td width="35%">
			    <input type="text" name="beginDate" id="beginDate" value="<%=beginDate%>"  onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  
		  </td>
		  <td class="blue" width="15%">����ʱ��</td>
		  <td width="35%"> 
			    <input type="text" name="endDate" id="endDate" value="<%=endDate%>" onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />   
		  </td>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="��ѯ" onclick="doQuery()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
 <font class="orange">���Ƿ�������ֶν�������������1270��1272��g794ʱ��Ч</font> 
<div class="title"><div id="title_zi">��ά��Ӫ��ҵ������ѯ����б�</div></div>
<TABLE cellSpacing="0"  id="exportExcel" name="exportExcel">
    <tr>
        <th width="15%">�Ƽ�����/�ֻ�����</th>
        <th width="13%">�ֻ�����</th>	
        <th width="13%">����ʱ��</th>
        <th width="10%">��������</th>
        <th width="12%">������ˮ</th>
        <th width="10%">�ʷѴ���/Ӫ��������</th>
        <th width="12%">�ʷ�����/Ӫ��������</th>
        <th width="10%">��������</th>
        <th width="10%">��λ����</th>
        <th width="10%">�Ƿ����</th>
    </tr>
<%
if(retCode.equals("000000")){
	

	for(int i=0;i<result_t2.length;i++){
  		out.print("<tr>");
  		out.print("<td>"+result_t2[i][0]+"</td>");
  		out.print("<td>"+result_t2[i][1]+"</td>");
  		out.print("<td>"+result_t2[i][3]+"</td>");
  		out.print("<td>"+result_t2[i][4]+"</td>");
  		out.print("<td>"+result_t2[i][5]+"</td>");
  		out.print("<td>"+result_t2[i][6]+"</td>");
  		out.print("<td>"+result_t2[i][7]+"</td>");
  		
  		out.print("<td>"+result_t2[i][8]+"</td>");
  		out.print("<td>"+result_t2[i][9]+"</td>");
  		
  		out.print("<td>"+result_t2[i][2]+"</td>");
  		out.print("</tr>");
	}
}
%>    
</table>

<table cellspacing="0">
	<tr>
    <td colspan="7" align="center" id="footer">
    ��<%=zongshus%>����¼<input type="button" class="b_text" value="��һҳ" onClick="pagecontione('1')"/>&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="��һҳ" onClick="pagecontione('<%=Integer.parseInt(numpage) - 1%>')"/>&nbsp;&nbsp;&nbsp;<input type="button" value="��һҳ" class="b_text" onClick="pagecontione('<%=Integer.parseInt(numpage) + 1%>')" />&nbsp;&nbsp;&nbsp;<input type="button" value="���һҳ" class="b_text" onClick="pagecontione('<%=endpanges%>')" />
    &nbsp;&nbsp;&nbsp;<input class="b_foot" type=button name="excelExport" id="excelExport" value="����EXCEL" onclick="printTable();">
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>