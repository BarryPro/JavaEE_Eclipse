<%
  /*
   * ����: ����ԭ���춯��ѯ
�� * �汾: 1.0
�� * ����: 2008/10/17
�� * ����: donglei 
�� * ��Ȩ: sitech
   * 
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%! 
		/** 
		 ����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
		 ����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
		 */ 
        public String returnSql(HttpServletRequest request){
        StringBuffer buffer = new StringBuffer();

		   //�������.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
		String value="";
		//���������������.key������.�����ֽ�������.value�������object�����ֵ.
		for (int i = 0; i < objNames.length; i++) {
			name = objNames[i] == null ? "" : objNames[i]
			.toString();
			//String name
			names = name.split("_");
			//��name����'_'�ֳ�3������.
			if (names.length >= 3) {
		//������ܷ�˵�����ֲ��Ϸ�.̫�����ֲ���.
		    value = request.getParameter(name);
		//�������ֵõ�value
		if (value.equals("")) {
			//���value��""����.
			continue;
		}
		Object[] objs = new Object[3];
		objs[0] = names[1];
		//���� ��һ���ַ���.��like ���� =
		name = name.substring(name.indexOf("_") + 1);
		name = name.substring(name.indexOf("_") + 1);
		//��ط������ݿ���ֶδ���.������'_'�Ժ�Ķ������ݿ��ֶ���.
		objs[1] = name;
		//�ڶ����ַ���.��ѯ����.
		objs[2] = value;
		//������.��ѯ��ֵ.
	//	System.out.println("~~~~~~~~~~~~~" + objs[0]);
		try {
			temp.put(Integer.valueOf(names[0]), objs);
			//����ط��ǽ��ַ���ת��������.Ȼ���������.����19Ҫ��2֮��.
		} catch (Exception e) {

		}
		//������������key����,ojbs����ŵ�value����.
			}
		}
		Object[] objNos = temp.keySet().toArray();
		//�õ�һ�����������.
		Arrays.sort(objNos);
		//�����ֽ�������.
		for (int i = 0; i < objNos.length; i++) {
			Object[] objs = null;
			objs = (Object[]) temp.get(objNos[i]);
			//�����like �� = ,str�ֱ���.
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
//����Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " ��ʼ����Excel�ļ� " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "����ԭ���춯��ѯ";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4]};
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
%>

<%
    String opCode="k174";
    String opName="�ۺϲ�ѯ-����ԭ���춯��ѯ";
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
    String[] strHead= {"��ˮ��","�޸Ĺ���","�޸�ʱ��","�޸�ǰ����ԭ��","�޸ĺ�����ԭ��"};
	  String expFlag = request.getParameter("exp"); 
    ///////��ѯ��������
    String sqlFilter = request.getParameter("sqlFilter");
	  //��ѯ����
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
    
    
   //������ǰ��ʾ����
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
<title>����ԭ���춯��ѯ</title>
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
    	   showTip(document.sitechform.start_date,"��ʼʱ�䲻��Ϊ��"); 
    	   sitechform.start_date.focus(); 	

    }else if(document.sitechform.end_date.value == ""){
		     showTip(document.sitechform.end_date,"����ʱ�䲻��Ϊ��"); 
    	   sitechform.end_date.focus(); 	

    }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		     showTip(document.sitechform.end_date,"����ʱ�������ڿ�ʼʱ��"); 
    	   sitechform.end_date.focus(); 	

    }else{
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);
    window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
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
//�������¼
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

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k174_callCauseHisQry.jsp?exp="+expFlag;
	  window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

//��ʾͨ����ϸ��Ϣ
function getCallDetail(contact_id,start_date){
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    window.open(path,"newwindow","height=768, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}
function showCallCauseTree(strflag){
window.open("k174_callCauseSelectTree.jsp?flag="+strflag,'����ԭ��','scrollbars=yes,height=500, width=400');
}

function keepValue(){
	 window.sitechform.start_date.value="<%=start_date%>";//Ϊ��ʾ��ϸ��Ϣҳ�洫�ݿ�ʼʱ��
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
		<div class="title">����ԭ���춯</div>
		<table cellspacing="0" >
    <!-- THE FIRST LINE OF THE CONTENT -->

        <tr >
      <td > ��ʼʱ�� </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd'});hiddenTip(this);"  readOnly="true" value="<%=(start_date==null)?"":start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > ��ˮ�� </td>
      <td >
				<input id="contact_id" name="0_=_contact_id" type="text"  value=<%=(contact_id==null)?"":contact_id%> >

      </td>
		  <td > �޸Ĺ��� </td>
      <td >
			  <input name ="1_=_login_no" type="text" id="login_no"  value="<%=(login_no==null)?"":login_no%>">
      </td> 
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td > ����ʱ�� </td>
      <td >
			  <input id="end_date" name ="end_date" type="text" readOnly="true"  value="<%=(end_date==null)?"":end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd'})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
       <td > �޸�ǰ����ԭ�� </td>
      <td >
      	<input id="pre_cause_name_id" readOnly="true"  name="pre_cause_name" type="text"   value=<%=(pre_cause_name==null)?"":pre_cause_name%> >
				<input id="pre_call_cause_id"   name="2_str_pre_call_cause_id" type="hidden"   value=<%=(pre_call_cause_id==null)?"":pre_call_cause_id%> >
        <img onclick="showCallCauseTree(1);return false;"  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
      </td>
      </td> 
		        <td > �޸ĺ�����ԭ��</td>
      <td >
      	<input name ="last_cause_name" readOnly="true"  type="text" id="last_cause_name_id"  value="<%=(last_cause_name==null)?"":last_cause_name%>">
			  <input name ="3_str_last_call_cause_id"   type="hidden" id="last_call_cause_id"  value="<%=(last_call_cause_id==null)?"":last_call_cause_id%>">
			   <img onclick="showCallCauseTree(2);return false;"  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
		  </td> 
 </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px">
       <input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;"> 
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
	
			 <input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('cur')\"");%>>
       <input name="exportAll" type="button"  id="add" value="����ȫ��" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('all')\"");%>>
       
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
            <th align="center" class="blue" width="10%" > ���� </th>
            <th align="center" class="blue" width="10%" > ��ˮ�� </th>
            <th align="center" class="blue" width="10%" > �޸Ĺ���</th>
            <th align="center" class="blue" width="10%"  > �޸�ʱ�� </th>
            <th align="center" class="blue" width="30%"  >�޸�ǰ����ԭ��</th>
             <th align="center" class="blue" width="30%" >�޸ĺ�����ԭ��</th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           if((i+1)%2==1){
             tdClass="grey";
            } 
           %>
	   <tr  >

      <td align="center" class="<%=tdClass%>"  >
       <img onclick="getCallListen('<%=dataRows[i][0]%>');return false;" alt="��ȡ����" src="<%=request.getContextPath()%>/images/callimage/1.GIF" width="16" height="22" align="absmiddle">
       <img onclick="getCallDetail('<%=dataRows[i][0]%>','<%=start_date%>');return false;" alt="��ʾ��ͨ������ϸ���" src="<%=request.getContextPath()%>/images/callimage/2.GIF" width="16" height="22" align="absmiddle">
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

