<%
  /*
   * ����: ���б��ּ�¼
�� * �汾: 1.0
�� * ����: 2008/10/14
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
		if (value.trim().equals("")) {
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
			//�����like �� = �ֱ���.
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
//����Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " ��ʼ����Excel�ļ� " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "���б��ּ�¼";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],queryList[i][8],queryList[i][9],queryList[i][10],queryList[i][11]};
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
    String opCode="k179";
    String opName="�ۺϲ�ѯ-���б��ּ�¼��ѯ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
  	String sqlStr = "select t1.contact_id,t2.cust_name,t2.accept_phone,t2.caller_phone,to_char(t2.begin_date,'yyyy-MM-dd hh24:mi:ss'),t2.accept_long,t2.accept_login_no,decode(t2.staffhangup,'0','�û�','1','����Ա','2','������֤ʧ���Զ��ͷ�'),decode(t2.qc_flag,'Y','��','N','��'),";
           sqlStr +=" decode(trim(t1.op_type),'0','����','1','�ڲ�����'),to_char(t1.begin_time,'yyyy-MM-dd hh24:mi:ss'),to_char(t1.end_time,'yyyy-MM-dd hh24:mi:ss') from dcallhangup t1, dcallcall";
		String strCountSql="select to_char(count(*)) count  from dcallhangup t1, dcallcall";
		String strDateSql="";
    int Temp =0;
    String start_date        =  request.getParameter("start_date");                        
    String end_date          =  request.getParameter("end_date");                          
    String contact_id        =  request.getParameter("0_=_t1.contact_id");                 
    //String staffcity       =  request.getParameter("15_=_t2.staffcity");                 
    String accept_login_no   =  request.getParameter("2_=_t2.accept_login_no");            
    String accept_phone      =  request.getParameter("3_=_t2.accept_phone");               
    String mail_address      =  request.getParameter("4_=_t2.mail_address");               
    String contact_address   =  request.getParameter("5_=_t2.contact_address");            
    String grade_code        =  request.getParameter("6_=_t2.grade_code");                 
    String contact_phone     =  request.getParameter("7_=_t2.contact_phone");              
    String caller_phone      =  request.getParameter("8_=_t2.caller_phone");   //���к���  
    String op_type           =  request.getParameter("9_=_t1.op_type");                    
    String cust_name         =  request.getParameter("10_=_t2.cust_name");                 
    String fax_no            =  request.getParameter("11_=_t2.fax_no");                    
    String acceptid          =  request.getParameter("13_=_t2.acceptid");                        
    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 2;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp ="";
    String action = request.getParameter("myaction");
    String[] strHead= {"��ˮ��","�ͻ�����","�������","���к���","����ʱ��","����ʱ��","������","�һ���","�Ƿ��ʼ�","����","��ʼʱ��","����ʱ��"};
    //String[] conStaffhangup= {"�û�","����Ա","������֤ʧ���Զ��ͷ�"};
	  String expFlag = request.getParameter("exp");
    String sqlFilter = request.getParameter("sqlFilter");
	  //��ѯ����
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
       strDateSql=start_date.substring(0,6)+" t2 where 1=1 and t1.contact_id=t2.contact_id ";
       strDateSql+=" and  to_char(t1.begin_time,'yyyymmdd')>='"+start_date.trim()+"' and to_char(t1.begin_time,'yyyymmdd')<='"+end_date.trim()+"' ";
    	}
    	sqlFilter=strDateSql+returnSql(request);
    }
%>	
			
<%	if ("doLoad".equals(action)) {
       sqlStr+=sqlFilter;
       sqlTemp =strCountSql+sqlFilter;
System.out.println("=====179=======sqlStr==============="+sqlStr);
System.out.println("=====179=======sqlTemp==============="+sqlTemp);
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
           <wtc:service name="s151Select" outnum="13">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="12"   scope="end"/>
				<%
				dataRows = queryList;
    }
    
   //������ǰ��ʾ����
   if("cur".equalsIgnoreCase(expFlag)){    
       sqlStr+=sqlFilter;
       sqlTemp =strCountSql+sqlFilter;
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
        <wtc:service name="s151Select" outnum="13">
					<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="12"   scope="end"/>
				<%
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){    
				sqlStr+=sqlFilter;
%>		           
        <wtc:service name="s151Select" outnum="12">
					<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="12"   scope="end"/>
<%

				this.toExcel(queryList,strHead,response);
   }
    
%>


<html>
<head>
<title>���б��ּ�¼��ѯ</title>
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
// SUBMIT INPUTS TO THE SERVLET
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
   window.sitechform.action="k179_callHangupQry.jsp";
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
}

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k179_callHangupQry.jsp?exp="+expFlag;
    keepValue();
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

function keepValue(){
	 window.sitechform.start_date.value="<%=start_date%>";//Ϊ��ʾ��ϸ��Ϣҳ�洫�ݿ�ʼʱ��
   window.sitechform.sqlFilter.value="<%=sqlFilter%>";
   window.sitechform.end_date.value="<%=end_date%>";
   
   window.sitechform.grade.value="<%=request.getParameter("grade")%>";
   window.sitechform.accid.value="<%=request.getParameter("accid")%>";
   window.sitechform.opType.value="<%=request.getParameter("opType")%>";
   window.sitechform.grade_code.value="<%=request.getParameter("6_=_t2.grade_code")%>";
   window.sitechform.acceptid.value="<%=request.getParameter("13_=_t2.acceptid")%>";
   window.sitechform.op_type.value="<%=request.getParameter("9_=_t1.op_type")%>";
   
   window.sitechform.contact_id.value="<%=contact_id%>";
   window.sitechform.mail_address.value="<%=mail_address%>";
   window.sitechform.accept_login_no.value="<%=accept_login_no%>";
   window.sitechform.accept_phone.value="<%=accept_phone%>";
   window.sitechform.contact_address.value="<%=contact_address%>";
   window.sitechform.contact_phone.value="<%=contact_phone%>";
   window.sitechform.caller_phone.value="<%=caller_phone%>";
   window.sitechform.cust_name.value="<%=cust_name%>";
   window.sitechform.fax_no.value="<%=fax_no%>";

}
</script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">���б��ּ�¼</div>
		<table cellspacing="0" >
    <!-- THE FIRST LINE OF THE CONTENT -->
       <tr >
      <td > ��ʼʱ�� </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd'});hiddenTip(this);"  readOnly="true" value="<%=(start_date==null)?"":start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > Ա������ </td>
      <td >
			 <select id="staffcity" name="17_=_t2.staffcity" size="1">
             <option value="">ʡ����</option>
        </select>
      </td>
            <td > ��ˮ�� </td>
      <td >
				<input id="contact_id" name="0_=_t1.contact_id"  type="text"  value=<%=(contact_id==null)?"":contact_id%>>
      </td>
      <td > �����ʼ� </td>
      <td >
			  <input name="4_=_t2.mail_address" type="text" maxlength="80"  id="mail_address"  value="<%=(mail_address==null)?"":mail_address%>">
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
		  <td > ��ϵ�绰 </td>
      <td >
			  <input name ="7_=_t2.contact_phone" type="text" id="contact_phone"  value="<%=(contact_phone==null)?"":contact_phone%>">
		  </td> 
		  <td > ���к��� </td>
      <td >
			  <input name ="8_=_t2.caller_phone" type="text" id="caller_phone"  value="<%=(caller_phone==null)?"":caller_phone%>" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td> 
		        <td > ��ϵ��ַ </td>
      <td >
			  <input name ="5_=_t2.contact_address" type="text" id="contact_address"  value="<%=(contact_address==null)?"":contact_address%>">
		  </td>          
     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
       <tr >
      <td > �ͻ����� </td>
      <td >
			  <select name="6_=_t2.grade_code"  id="grade_code" size="1" onchange="grade.value=this.options[this.selectedIndex].text">
			  	<%if(grade_code==null || grade_code.equals("") || request.getParameter("grade").equals("") || request.getParameter("grade")==null){%>
			  	 <option value="" selected>--���пͻ�����--</option>
			  	<%}else {%>
			  	    <option value="<%=grade_code%>" selected >
      	 				<%=request.getParameter("grade")%>
      	 			</option>
      	 	 	<option value="" >--���пͻ�����--</option>
      	 	<%}%>
					<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from scallgradecode</wtc:sql>
				</wtc:qoption>
        </select>
				<input name="grade" type="hidden" value="<%=request.getParameter("grade")%>"> 
		  </td> 
		        <td > ������ </td>
      <td >
			  <input name ="2_=_t2.accept_login_no" type="text" id="accept_login_no"   value="<%=(accept_login_no==null)?"":accept_login_no%>">
      </td>
            <td > �ͻ����� </td>
      <td >
			  <input name ="10_=_t2.cust_name" type="text" id="cust_name"  value="<%=(cust_name==null)?"":cust_name%>">
		  </td>  

		  <td > �������� </td>
      <td >
      	 <select name="9_=_t1.op_type" id="op_type" size="1" onchange="opType.value=this.options[this.selectedIndex].text">
				<%if(op_type==null  || op_type.equals("") || request.getParameter("opType").equals("")|| request.getParameter("opType")==null){%>
		  	<option value="" selected>--���б��ַ�ʽ--</option>
		  	<%}else {%>
      	 		<option value="<%=op_type%>" selected >
      	 			<%=request.getParameter("opType")%>
      	 		</option>
      	 	 	<option value="" >--���б��ַ�ʽ--</option>
      	 	<%}%>
				<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select hold_code , hold_code|| '-->' ||hold_name from SHOLDTYPE</wtc:sql>
				</wtc:qoption>
        </select>
        <input name="opType" type="hidden" value="<%=request.getParameter("opType")%>">
        </select>
		  </td>          
     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
       <tr >
      <td > ������� </td>
      <td >
			  <input name ="3_=_t2.accept_phone" type="text" id="accept_phone"  value="<%=(accept_phone==null)?"":accept_phone%>" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
      </td> 
		        <td > ������� </td>
      <td >
			  <input name ="11_=_t2.fax_no" type="text" id="fax_no"  value="<%=(fax_no==null)?"":fax_no%>">
		  </td> 
		        <td > ����ʽ </td>
      <td >
		  <select name="13_=_t2.acceptid" id="acceptid" size="1" onchange="accid.value=this.options[this.selectedIndex].text">
		  	<%if(acceptid==null || acceptid.equals("") || request.getParameter("accid").equals("")|| request.getParameter("accid")==null){%>
		  	<option value="" selected>--��������ʽ--</option>
		  	<%}else {%>
      	 			<option value="<%=acceptid%>" selected >
      	 				<%=request.getParameter("accid")%>
      	 			</option>
      	 	 	<option value="" >--��������ʽ--</option>
      	 	<%}%>
				<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE</wtc:sql>
				</wtc:qoption>
        </select>
        <input name="accid" type="hidden" value="<%=request.getParameter("accid")%>"> 
		  </td> 
		        <td colspan="2" > &nbsp; </td>       
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
      <td class="blue"  align="left">
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
            <th align="center" class="blue" width="9%" > ���� </th>
            <th align="center" class="blue" width="10%" > ��ˮ�� </th>
            <th align="center" class="blue" width="6%"  > �ͻ����� </th>
             <th align="center" class="blue" width="7%"  > �������</th>
             <th align="center" class="blue" width="7%" > ���к��� </th>
              <th align="center" class="blue" width="7%" > ����ʱ��</th>
             <th align="center" class="blue" width="7%"  > ����ʱ��</th>
              <th align="center" class="blue" width="5%" > ������ </th>
             <th align="center" class="blue" width="11%" > �һ��� </th>
             <th align="center" class="blue" width="6%"  > �Ƿ��ʼ�</th>
                 <th align="center" class="blue" width="9%" >����</th>
             <th align="center" class="blue" width="8%"  > ��ʼʱ��</th>
                 <th align="center" class="blue" width="8%" >����ʱ��</th>
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
       <img onclick="" alt="�Ը���ˮ�����ʼ쿼��" src="<%=request.getContextPath()%>/images/callimage/3.GIF" width="16" height="22" align="absmiddle">
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

