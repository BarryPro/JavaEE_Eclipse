<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �����Ϣ��ѯ
�� * �汾: 1.0
�� * ����: 2008/10/18
�� * ����: hanjc
�� * ��Ȩ: sitech
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%!
//����Excel
    void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " ��ʼ����Excel�ļ� " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "�����Ϣ��ѯ";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
           System.out.println( " ����Excel�ļ�[�ɹ�] ");
        }catch  (Exception e1) {
           System.out.println( " ����Excel�ļ�[ʧ��] ");
           e1.printStackTrace();
        } 
    }
    public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>
<%
    String opCode="k1719";
    String opName="�ۺϲ�ѯ-�����Ϣ��ѯ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  
    String beginTime    =  request.getParameter("beginTime");         //��ʼʱ��
    String endTime      =  request.getParameter("endTime");           //����ʱ��
    String restLogNo    =  request.getParameter("restLogNo");         //�����
    String cancelLogNo  =  request.getParameter("cancelLogNo");       //������
    String cur_stat     =  request.getParameter("cur_stat");          //��ǰ״̬
    String oper_code    =  request.getParameter("oper_code");         //Ա������
    String[][] dataRows = new String[][]{};
    int rowCount=0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlStr="";
    String action = request.getParameter("myaction");
    String expFlag = request.getParameter("exp"); 
    String[] strHead= {"�����","���ʱ��","��ʼ���ʱ��","�ݼٽ���ʱ��","����ʱ��","������","��ǰ״̬"};
System.out.println("=========action======="+action);
		String sqlFilter = request.getParameter("sqlFilter");
System.out.println("=========sqlFilter=========="+sqlFilter);
    if(sqlFilter==null || sqlFilter.trim().length()==0){
    	if(beginTime!=null &&!beginTime.trim().equals("")&& endTime!=null&&!endTime.trim().equals("")){
        sqlFilter = " where to_char(rest_begin_time,'yyyyMMdd') > '"+beginTime.trim()+"' and to_char(rest_begin_time,'yyyyMMdd') < '"+endTime.trim()+"' ";
        if(restLogNo!=null && !restLogNo.equals("")){
            sqlFilter = sqlFilter+" and rest_login_no = '"+restLogNo.trim()+"' ";
        }
        if(cur_stat!=null && !cur_stat.equals("")){
            sqlFilter = sqlFilter+" and current_status ='"+cur_stat.trim()+"' ";
        }
        if(cancelLogNo!=null && !cancelLogNo.equals("")){
            sqlFilter = sqlFilter+" and rest_cancel_login_no ='"+cancelLogNo.trim()+"' ";
        }
        if(oper_code!=null && !oper_code.equals("")){
            sqlFilter = sqlFilter+" and  region_code='"+oper_code.trim()+"' ";
        }
      }
    }
    sqlStr = "select rest_login_no,rest_time,to_char(rest_begin_time,'yyyy-MM-dd hh24:mi:ss'),to_char(rest_end_time,'yyyy-MM-dd hh24:mi:ss'),to_char(rest_cancel_time,'yyyy-MM-dd hh24:mi:ss'),rest_cancel_login_no,REST_NAME from drestlog,SCALLRESTTYPE "+sqlFilter+"and CURRENT_STATUS=REST_TYPE(+) order by rest_time,rest_begin_time,rest_end_time,rest_cancel_time desc";     
    if ("doLoad".equals(action)) {
       String sqlTemp = "select to_char(count(*)) count  from drestlog "+sqlFilter;
%>	
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
<% 
				if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
System.out.println("\n\n=====sqlTemp==========="+sqlTemp);
System.out.println("\n\n=====rowCount==========="+rowCount);
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
        int beginPos = (curPage-1)*pageSize;
        
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
System.out.println("\n\n=======beginTime+endTime============="+beginTime+"+"+endTime);
System.out.println("\n\n=======sqlStr:"+sqlStr);
%>	
					<wtc:service name="s151Select" outnum="8">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="7" scope="end"/>	
<% 
					dataRows=queryList;
//System.out.println("dataRows[0][3]="+dataRows[0][3]);
System.out.println("queryList.length="+queryList.length);
   } 
   //������ǰ��ʾ����
   if("cur".equalsIgnoreCase(expFlag)){    
 				 String sqlTemp = "select to_char(count(*)) count  from drestlog "+sqlFilter;
%>	
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
<% 
				if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
System.out.println("\n\n=====sqlTemp==========="+sqlTemp);
System.out.println("\n\n=====rowCount==========="+rowCount);
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
        int beginPos = (curPage-1)*pageSize;
        //sqlStr = "select rest_login_no,rest_time,to_char(rest_begin_time,'yyyy-MM-dd hh24:mi:ss'),to_char(rest_end_time,'yyyy-MM-dd hh24:mi:ss'),to_char(rest_cancel_time,'yyyy-MM-dd hh24:mi:ss'),rest_cancel_login_no,current_status from drestlog "+sqlFilter+" order by rest_time,rest_begin_time,rest_end_time,rest_cancel_time desc";     
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
System.out.println("\n\n=======beginTime+endTime============="+beginTime+"+"+endTime);
System.out.println("\n\n=======sqlStr:"+sqlStr);
%>	
					<wtc:service name="s151Select" outnum="8">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="7" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){    
				
				//sqlStr = "select rest_login_no,rest_time,to_char(rest_begin_time,'yyyy-MM-dd hh24:mi:ss'),to_char(rest_end_time,'yyyy-MM-dd hh24:mi:ss'),to_char(rest_cancel_time,'yyyy-MM-dd hh24:mi:ss'),rest_cancel_login_no,current_status from drestlog "+sqlFilter+" order by rest_time,rest_begin_time,rest_end_time,rest_cancel_time desc";     
System.out.println("\n\n===ww====sqlStr:"+sqlStr);
%>	
					<wtc:service name="s151Select" outnum="8">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="8" scope="end"/>	
<% 
System.out.println("\n\n=======queryList.length:"+queryList.length);
				this.toExcel(queryList,strHead,response);
   }   
%>

<html>
<head>
<title>�����Ϣ��ѯ</title>
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

//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInput(){
   if( document.sitechform.beginTime.value == ""){
    	  showTip(document.sitechform.beginTime,"��ʼ���ڲ���Ϊ�գ������ѡ�������");
        sitechform.beginTime.focus();
    }
	else if(document.sitechform.endTime.value == ""){
		showTip(document.sitechform.endTime,"�������ڲ���Ϊ�գ������ѡ�������");
		sitechform.endTime.focus();
    }
  else if(document.sitechform.endTime.value<=document.sitechform.beginTime.value){
		     showTip(document.sitechform.endTime,"����ʱ�������ڿ�ʼʱ��"); 
    	   sitechform.endTime.focus(); 	

    }else if(document.sitechform.endTime.value.substring(0,6)>document.sitechform.beginTime.value.substring(0,6)){
		     showTip(document.sitechform.endTime,"ֻ�ܲ�ѯһ�����ڵļ�¼"); 
    	   sitechform.end_date.focus(); 	

    }   
    else {
    	
    hiddenTip(document.sitechform.beginTime);
    hiddenTip(document.sitechform.endTime);
    window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
    doSubmit();
    }
}
function doSubmit(){
	  window.sitechform.myaction.value="doLoad";
    window.sitechform.action="k1719_restMsgQry.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}
//�������¼
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
   window.location="k1719_restMsgQry.jsp";
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
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="k1719_restMsgQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
    }
    
//�������¼
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text")
   e[i].value="";
 }
}
//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k1719_restMsgQry.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	 window.sitechform.beginTime.value="<%=beginTime%>";
	 window.sitechform.endTime.value="<%=endTime%>";
   window.sitechform.statText.value="<%=request.getParameter("statText")%>";
   window.sitechform.cur_stat.value="<%=request.getParameter("cur_stat")%>";
   window.sitechform.sqlFilter.value="<%=sqlFilter%>";
   window.sitechform.restLogNo.value="<%=request.getParameter("restLogNo")%>";
   window.sitechform.cancelLogNo.value="<%=request.getParameter("cancelLogNo")%>";
   
   window.sitechform.oper.value="<%=request.getParameter("oper")%>";
   window.sitechform.oper_code.value="<%=request.getParameter("oper_code")%>";
}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>


<body>
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">��ѯ����</div>
		<table cellspacing="0">
    <!-- THE FIRST LINE OF THE CONTENT -->
    <tr >
      <td > ��ʼʱ�� </td>
      <td >
				<input id="beginTime" name="beginTime" type="text"  value="<%=(beginTime==null)?getCurrDateStr("00:00:00"):beginTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);">
				<img onclick="WdatePicker({el:$dp.$('beginTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				<font color="orange">*</font>
      </td>
      <td > ����� </td>
      <td >
			  <input name="restLogNo" type="text" value=<%=(restLogNo==null)?"":restLogNo%>>
      </td>
      <td > ������ </td>
      <td >
			  <input name="cancelLogNo" type="text" value=<%=(cancelLogNo==null)?"":cancelLogNo%>>
      </td>
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td > ����ʱ�� </td>
      <td>
			  <input name ="endTime" type="text" id="endTime"   value="<%=(endTime==null)?getCurrDateStr("23:59:59"):endTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);">
			  <img onclick="WdatePicker({el:$dp.$('endTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			  <font color="orange">*</font>
		  </td>     
		  <td> ��ǰ״̬</td>
      <td>
			   <select id="cur_stat" name="cur_stat" size="1" onchange="statText.value=this.options[this.selectedIndex].text">
         <%if(cur_stat==null || cur_stat.equals("") || request.getParameter("statText").equals("")|| request.getParameter("statText")==null){%>
      	 	<option value="" selected >--����״̬����--</option>
      	 	<%}else {%>
      	 			<option value="<%=cur_stat%>" selected >
      	 				<%=request.getParameter("statText")%>
      	 			</option>
      	 	 	<option value="" >--����״̬����--</option>
      	 	<%}%>
				 <wtc:qoption name="s151Select" outnum="2">
				  <wtc:sql>select rest_type , rest_type|| '-->' ||rest_name from scallresttype </wtc:sql>
				 </wtc:qoption>
        </select>
       <input name="statText" type="hidden" value="<%=request.getParameter("statText")%>"> 
		  </td>  
		  <td >Ա������</td>
      <td>
			 <select id="oper_code" name="oper_code" size="1"  onchange="oper.value=this.options[this.selectedIndex].text">
        <%if(oper_code==null || oper_code.equals("")|| request.getParameter("oper")==null || request.getParameter("oper").equals("")){%>
			 	<option value="" selected>--���пͻ�����--</option>
			 	<%}else {%>
      	 			<option value="<%=oper_code%>" selected >
      	 				<%=request.getParameter("oper")%>
      	 			</option>
      	 	 	<option value="" >--���пͻ�����--</option>
      	 	<%}%>
				    <wtc:qoption name="s151Select" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y'order by region_code</wtc:sql>
				  </wtc:qoption>
        </select>
        <input name="oper" type="hidden" value="<%=request.getParameter("oper")%>">
		  </td>     
     </tr>

        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="left" id="footer">
        <input name="clear" type="button"  id="clear" value="����" onClick="clearValue()">
        
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInput()"> &nbsp;&nbsp;
       
        <input name="toOut" type="button"  id="toOut" value="����" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('cur')\"");%>>
         <!--<input name="toOutAll" type="button"  id="toOutAll" value="����ȫ��" onClick="expExcel('all')">-->
       
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
			  <table  cellspacing="0">
    <tr >
      <td class="blue"  align="left" width="720">
        <%if(pageCount!=0){%>
        ��<%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
        <%} else{%>
        <font color="orange">��ǰ��¼Ϊ�գ�</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">��ҳ</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">��һҳ</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">��һҳ</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">βҳ</a>
        <%}%>
      </td>
    </tr>
  </table>
      <table  cellSpacing="0" >
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
          <tr >
            <!--<th align="center" class="blue" width="40"  > ���� </th>-->
            <th align="center" class="blue" width="70" > ����� </th>
            <th align="center" class="blue" width="120" > ���ʱ�� </th>
            <th align="center" class="blue" width="120" > ��ʼ���ʱ�� </th>
            <th align="center" class="blue" width="120" > �ݼٽ���ʱ�� </th>
            <th align="center" class="blue" width="120" > ����ʱ�� </th>
            <th align="center" class="blue" width="70" > ������ </th>
            <th align="center" class="blue" width="70" > ��ǰ״̬ </th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr >
			<%}else{%>
	   <tr  >
	<%}%>
      <!--<td align="center" class="<%=tdClass%>"  >&nbsp;</td>-->
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][0]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
    </tr>
      <% } %>
  </table>   
  <table  cellspacing="0">
    <tr >
      <td class="blue"  align="right" width="720">
        <%if(pageCount!=0){%>
        ��<%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
        <%} else{%>
        <font color="orange">��ǰ��¼Ϊ�գ�</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">��ҳ</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">��һҳ</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">��һҳ</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">βҳ</a>
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

