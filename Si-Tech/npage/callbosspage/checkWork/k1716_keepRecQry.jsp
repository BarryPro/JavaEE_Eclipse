<%
  /*
   * ����: ת��¼����ѯ
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
    void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " ��ʼ����Excel�ļ� " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "ת��¼����ѯ";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],queryList[i][8],queryList[i][9],queryList[i][10],queryList[i][11],queryList[i][12]};
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
    String opCode="k1716";
    String opName="�ۺϲ�ѯ-ת��¼����ѯ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode");
	   
    String start_date        =  request.getParameter("start_date");            //��ʼʱ��
    String end_date          =  request.getParameter("end_date");              //����ʱ��
    String contact_id        =  request.getParameter("0_=_contact_id");        //��ˮ��
    String region_code       =  request.getParameter("1_=_region_code");       //�ͻ�����
    String accept_login_no   =  request.getParameter("2_=_accept_login_no");   //������
    String accept_phone      =  request.getParameter("3_=_accept_phone");      //�������
    String mail_address      =  request.getParameter("4_=_mail_address");      //�����ʼ�
    String contact_address   =  request.getParameter("5_=_contact_address");   //��ϵ��ַ
    String grade_code        =  request.getParameter("6_=_grade_code");        //�ͻ�����
    String contact_phone     =  request.getParameter("7_=_contact_phone");     //��ϵ�绰
    String caller_phone      =  request.getParameter("8_=_caller_phone");      //���к���  
    String statisfy_code     =  request.getParameter("9_=_statisfy_code");     //�����
    String cust_name         =  request.getParameter("10_=_cust_name");        //�ͻ�����
    String fax_no            =  request.getParameter("11_=_fax_no");           //�������
    String accept_long_begin =  request.getParameter("accept_long_begin");     //����ʱ��(��ʼ)
    String accept_long_end   =  request.getParameter("accept_long_end");       //����ʱ��(����)
    String callee_phone      =  request.getParameter("12_=_callee_phone");     //���к���  
    String skill_quence      =  request.getParameter("14_=_skill_quence");     //�жӼ���
    String staffHangup       =  request.getParameter("15_=_staffHangup");      //�һ���
    String acceptid          =  request.getParameter("16_=_acceptid");         //����ʽ 
    String oper_code         =  request.getParameter("17_=_oper_code");        //Ա������
    String[][] dataRows = new String[][]{};                      
    int rowCount=0;
    int pageSize = 2;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    
    String sqlStr="select CONTACT_ID,to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi;ss'),CALLER_PHONE,ACCEPTID,CUST_NAME,ACCEPT_PHONE,CONTACT_PHONE,FAX_NO,ACCEPT_LOGIN_NO,SERVICECITY,REGION_CODE,to_char(ACCEPT_LONG),bak from dcallcall";
		String strCountSql="select to_char(count(*)) count  from dcallcall";
		String strAcceptTimeSql="";
		String strDateSql="";
		
    String action = request.getParameter("myaction");
    String expFlag = request.getParameter("exp"); 
    String[] strHead= {"��ˮ��","�ͻ�����","�ͻ�����","�������","���к���","���к���","����ʱ��","����ʱ��","������","�һ���","�Ƿ��ʼ�","�ͻ������","����ԭ�� "};
System.out.println("=========action======="+action);
		//��ѯ����
		String sqlFilter = request.getParameter("sqlFilter");
System.out.println("=========sqlFilter=========="+sqlFilter);
  	if(sqlFilter==null || sqlFilter.trim().length()==0){
       if(start_date!=null&&!"".equals(start_date)){
           strDateSql=" where 1=1 and  to_char(begin_date,'yyyymmdd')>='"+start_date+"' and to_char(begin_date,'yyyymmdd')<='"+end_date+"' ";
             if(accept_long_begin!=null&&accept_long_begin.trim().length()!=0&&accept_long_end!=null&&accept_long_end.trim().length()!=0){
                strAcceptTimeSql=" and  accept_long>="+Long.valueOf(accept_long_begin).longValue()+" and accept_long<="+Long.valueOf(accept_long_end).longValue();
             }
           sqlFilter=start_date.substring(0,6)+strDateSql+returnSql(request)+strAcceptTimeSql;
        } 
    }
    if ("doLoad".equals(action)) {
        String sqlTemp = strCountSql+sqlFilter;
        sqlStr += sqlFilter;
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
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
System.out.println("\n\n=======start_date+end_date============="+start_date+"+"+end_date);
System.out.println("\n\n=======sqlStr:"+sqlStr);
%>	
					<wtc:service name="s151Select" outnum="14">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="1" length="13" scope="end"/>	
<% 
					dataRows=queryList;
System.out.println("\n\n=======queryList.length:"+queryList.length);
   }  
   
   //������ǰ��ʾ����
   if("cur".equalsIgnoreCase(expFlag)){    
 				 String sqlTemp = strCountSql+sqlFilter;
 				 sqlStr += sqlFilter;
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
System.out.println("\n\n=======start_date+end_date============="+start_date+"+"+end_date);
System.out.println("\n\n=======sqlStr:"+sqlStr);
%>	
					<wtc:service name="s151Select" outnum="14">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="1" length="13" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){    
				sqlStr += sqlFilter;
System.out.println("\n\n===ȫ��====start_date+end_date============="+start_date+"+"+end_date);
System.out.println("\n\n===ȫ��====sqlStr:"+sqlStr);
%>	
					<wtc:service name="s151Select" outnum="13">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="13" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }  
%>

<html>
<head>
<title>ת��¼����ѯ</title>
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
   if( document.sitechform.start_date.value == ""){
    	  showTip(document.sitechform.start_date,"��ʼ���ڲ���Ϊ�գ������ѡ�������");
        sitechform.start_date.focus();
    } else if(document.sitechform.end_date.value == ""){
		showTip(document.sitechform.end_date,"�������ڲ���Ϊ�գ������ѡ�������");
		sitechform.end_date.focus();
    } else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		     showTip(document.sitechform.end_date,"����ʱ�������ڿ�ʼʱ��"); 
    	   sitechform.end_date.focus(); 	
    } else if(parseInt(document.sitechform.accept_long_end.value)<=parseInt(document.sitechform.accept_long_begin.value)){
		     showTip(document.sitechform.accept_long_end,"����ʱ���Ҳ�ֵ����������ֵ"); 
    	   sitechform.accept_long_end.focus(); 	

    }  
//  else if(document.sitechform.oper_code.value == ""){
//		showTip(document.sitechform.oper_code,"Ա�����в���Ϊ�գ������ѡ�������");
//		sitechform.oper_code.focus();
//    }  
//  else if(document.sitechform.contact_id.value == ""){
//		showTip(document.sitechform.contact_id,"��ˮ�Ų���Ϊ�գ������ѡ�������");
//		sitechform.contact_id.focus();
//    }  
//  else if(document.sitechform.accLogNo.value == ""){
//		showTip(document.sitechform.accLogNo,"�����Ų���Ϊ�գ������ѡ�������");
//		sitechform.accLogNo.focus();
//    }  
//  else if(document.sitechform.accNo.value == ""){
//		showTip(document.sitechform.accNo,"������벻��Ϊ�գ������ѡ�������");
//		sitechform.accNo.focus();
//    }  
    else {
    	
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);
    window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
    doSubmit();
    }
}
function doSubmit(){
	  window.sitechform.myaction.value="doLoad";
    window.sitechform.action="k1716_keepRecQry.jsp";
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
   window.sitechform.myaction.value="doLoad";
   keepValue();
   window.sitechform.action="k1716_keepRecQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
    }

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k1716_keepRecQry.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

//������ѯ��ֵ
function keepValue(){
   window.sitechform.grade.value="<%=request.getParameter("grade")%>";
   window.sitechform.accid.value="<%=request.getParameter("accid")%>";
   window.sitechform.region.value="<%=request.getParameter("region")%>";
   window.sitechform.hangup.value="<%=request.getParameter("hangup")%>";
   //window.sitechform.listen.value="<%=request.getParameter("listen")%>";
   window.sitechform.skill.value="<%=request.getParameter("skill")%>";
   window.sitechform.region_code.value="<%=request.getParameter("1_=_region_code")%>";
   window.sitechform.statisfy_code.value="<%=request.getParameter("9_=_statisfy_code")%>";
   window.sitechform.grade_code.value="<%=request.getParameter("6_=_grade_code")%>";
   window.sitechform.acceptid.value="<%=request.getParameter("16_=_acceptid")%>";
   window.sitechform.staffHangup.value="<%=request.getParameter("15_=_staffHangup")%>";
   //window.sitechform.listen_flag.value="<%=request.getParameter("13_=_listen_flag")%>";
   window.sitechform.skill_quence.value="<%=request.getParameter("14_=_skill_quence")%>";	
   
   window.sitechform.start_date.value="<%=start_date%>";//Ϊ��ʾ��ϸ��Ϣҳ�洫�ݿ�ʼʱ��
   window.sitechform.end_date.value="<%=end_date%>";
   window.sitechform.sqlFilter.value="<%=sqlFilter%>";
   //window.sitechform.oper_code.value="";//Ա������
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
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">��ѯ����</div>
		<table cellspacing="0"  style="width:650px">
    <!-- THE FIRST LINE OF THE CONTENT -->
    <tr >
      <td > ��ʼʱ�� </td>
      <td >
			  <input id="start_date" name ="start_date" type="text" readonly value="<%=(start_date==null)?"":start_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.start_date);">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd'})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
      <td > Ա������ </td>
      <td >
			 <select id="oper_code" name="17_=_oper_code" size="1"  onclick="hiddenTip(this)">
			 	<!-- value Ϊ�գ���ѯʱ���Զ����Դ�����-->
             <option value=""> ʡ����</option>
        </select>
			  <font color="red">+</font>

      </td>
      <td > ��ˮ�� </td>
      <td >
				<input id="contact_id" name="0_=_contact_id" onkeyup="hiddenTip(this)" type="text" value=<%=(contact_id==null)?"":contact_id%>>
				<font color="red">+</font>
      </td>
      </td>
      <td > �����ʼ� </td>
      <td >
			  <input name="4_=_mail_address" type="text" maxlength="80"  id="mail_address"  value="<%=(mail_address==null)?"":mail_address%>">
      </td>
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td > ����ʱ�� </td>
      <td >
			  <input id="end_date" name ="end_date" type="text" readonly  value="<%=(end_date==null)?"":end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd'})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
		  <td > ������ </td>
      <td >
			  <input name ="2_=_accept_login_no" type="text" id="accept_login_no" onkeyup="hiddenTip(this)"  value="<%=(accept_login_no==null)?"":accept_login_no%>">
		    <!--img onclick="" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" -->
		    <font color="red">+</font>
		  </td> 
		  <td > ������� </td>
      <td >
			  <input name ="3_=_accept_phone" type="text" id="accept_phone"  value="<%=(accept_phone==null)?"":accept_phone%>" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		   <font color="red">+</font>
		  </td> 
		  <td > ��ϵ��ַ </td>
      <td >
			  <input name ="5_=_contact_address" type="text" id="contact_address"  value="<%=(contact_address==null)?"":contact_address%>">
     </td>      
     </tr>
     <!-- THE THIRD LINE OF THE CONTENT -->
     <tr >
           <td > �ͻ����� </td>
      <td >
			  <select name="6_=_grade_code" id="grade_code" size="1" onchange="grade.value=this.options[this.selectedIndex].text">
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
		  <td > ��ϵ�绰 </td>
      <td >
			  <input name ="7_=_contact_phone" type="text" id="contact_phone"  value="<%=(contact_phone==null)?"":contact_phone%>">
		  </td> 
		  <td > ���к��� </td>
      <td >
			  <input name ="8_=_caller_phone" type="text" id="caller_phone"  value="<%=(caller_phone==null)?"":caller_phone%>" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td> 
		  <td > ����� </td>
      <td >
      	 <select name="9_=_statisfy_code" id="statisfy_code" size="1" onchange="statisfy.value=this.options[this.selectedIndex].text">
      	 	<%if(statisfy_code==null || statisfy_code.equals("") || request.getParameter("statisfy")==null || request.getParameter("statisfy").equals("")){%>
      	 	<option value="" selected >--���������--</option>
      	 	<%}else {%>
      	 			<option value="<%=statisfy_code%>" selected >
      	 				<%=request.getParameter("statisfy")%>
      	 			</option>
      	 	 	<option value="" >--���������--</option>
      	 	<%}%>
				  <wtc:qoption name="s151Select" outnum="2">
				   <wtc:sql>select satisfy_code , satisfy_code|| '-->' ||satisfy_name from ssatisfytype where valid_flag = '1'</wtc:sql>
				  </wtc:qoption>
        </select> 
       <input name="statisfy" type="hidden" value="<%=request.getParameter("statisfy")%>"> 
		  </td> 
    </tr>
     <!-- THE FOURTH LINE OF THE CONTENT -->
     <tr >
      <td > �ͻ����� </td>
      <td >
			  <input name ="10_=_cust_name" type="text" id="cust_name"  value="<%=(cust_name==null)?"":cust_name%>">
		  </td> 
		  <td > ������� </td>
      <td >
			  <input name ="11_=_fax_no" type="text" id="fax_no"  value="<%=(fax_no==null)?"":fax_no%>">
		  </td> 
		  <td > ����ʽ </td>
      <td >
		  <select name="16_=_acceptid"  id="acceptid"  size="1" onchange="accid.value=this.options[this.selectedIndex].text">
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
		  <td > ����ʱ�� </td>
      <td >
			  ><input name ="accept_long_begin" type="text" id="accept_long_begin"  maxlength="5" style="width:60px" value="<%=(accept_long_begin==null)?"":accept_long_begin%>" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			  <<input name ="accept_long_end" type="text" id="accept_long_end"      maxlength="5" style="width:60px"  value="<%=(accept_long_end==null)?"":accept_long_end%>" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td>    
    </tr>
    <!-- THE FIFTH LINE OF THE CONTENT -->
     <tr >
      <td > �ͻ����� </td>
      <td >
			 <select id="region_code" name="1_=_region_code" size="1" onchange="region.value=this.options[this.selectedIndex].text">
			 	<%if(region_code==null || region_code.equals("")|| request.getParameter("region")==null || request.getParameter("region").equals("")){%>
			 	<option value="" selected>--���пͻ�����--</option>
			 	<%}else {%>
      	 			<option value="<%=region_code%>" selected >
      	 				<%=request.getParameter("region")%>
      	 			</option>
      	 	 	<option value="" >--���пͻ�����--</option>
      	 	<%}%>
				    <wtc:qoption name="s151Select" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = '1'</wtc:sql>
				  </wtc:qoption>
        </select>
        <input name="region" type="hidden" value="<%=request.getParameter("region")%>">
      </td>
      <td > ���к��� </td>
      <td >
<input name ="12_=_callee_phone" type="text" id="callee_phone"  value="<%=(callee_phone==null)?"":callee_phone%>" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			
      </td>
            <td > �һ��� </td>
      <td >
      <select name="15_=_staffHangup" id="staffHangup" size="1" onchange="hangup.value=this.options[this.selectedIndex].text">
        	<%if(staffHangup==null|| staffHangup.equals("")||request.getParameter("hangup").equals("") || request.getParameter("hangup")==null){%>
        	<option value="" selected>ȫ��</option>
        		<%}else {%>
      	 			<option value="<%=staffHangup%>" selected >
      	 				<%=request.getParameter("hangup")%>
      	 			</option>
      	 	 	<option value="" >ȫ��</option>
      	 	<%}%>
				<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select hangup_code , hangup_code|| '-->' ||hangup_name from staffhangup</wtc:sql>
				</wtc:qoption>
        </select>
        <input name="hangup" type="hidden" value="<%=request.getParameter("hangup")%>">
      </td>
      <td >���ܶ��� </td>
      <td colspan="8" >
        <select id="skill_quence" name="14_=_skill_quence" size="1" onchange="skill.value=this.options[this.selectedIndex].text">
        	<%if(skill_quence==null || skill_quence.equals("")|| request.getParameter("skill")==null || request.getParameter("skill").equals("")){%>
        	<option value="" selected>--���м��ܶ���--</option>
        	<%}else {%>
      	 			<option value="<%=skill_quence%>" selected >
      	 				<%=request.getParameter("skill")%>
      	 			</option>
      	 	 	<option value="" >--���м��ܶ���--</option>
      	 	 <%}%>
				  <wtc:qoption name="s151Select" outnum="2">
				  <wtc:sql>select skill_queue_id , skill_queue_id|| '-->' ||skill_queud_name from dagskillqueue</wtc:sql>
				  </wtc:qoption>
        </select>
        <input name="skill" type="hidden" value="<%=request.getParameter("skill")%>">
      </td>
    </tr>

        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
       <td colspan="8" align="center" id="footer" style="width:420px">
        <input name="clear" type="button"  id="clear" value="����" onClick="clearValue()">
        
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInput()"> &nbsp;&nbsp;
       
        <input name="toOut" type="button"  id="toOut" value="����" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('cur')\"");%>>
	
       <input name="toOutAll" type="button"  id="toOutAll" value="����ȫ��" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('all')\"");%>>
       
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
        <input type="hidden" name="chkBoxNum"  value="<%=dataRows.length%>">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter"  value="">
			  
          <tr >
            <th align="center" class="blue" width="10%"  > ���� </th>
            <th align="center" class="blue" width="9%" > ��ˮ�� </th>
            <th align="center" class="blue" width="6%" > �ͻ����� </th>
            <th align="center" class="blue" width="6%" > �ͻ����� </th>
            <th align="center" class="blue" width="6%" > ������� </th>
            <th align="center" class="blue" width="6%" > ���к��� </th>
            <th align="center" class="blue" width="6%" > ���к��� </th>
            <th align="center" class="blue" width="7%" > ����ʱ�� </th>
            <th align="center" class="blue" width="6%"  > ����ʱ�� </th>
            <th align="center" class="blue" width="6%" > ������ </th>
            <th align="center" class="blue" width="10%" > �һ��� </th>
            <th align="center" class="blue" width="6%" > �Ƿ��ʼ� </th>
            <th align="center" class="blue" width="6%" > �ͻ������ </th>
            <th align="center" class="blue" width="10%" > ����ԭ�� </th>
          </tr>


           <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
           
         <%if((i+1)%2==1){
          tdClass="grey";
          }%>
	   <tr>
      <td align="center" class="<%=tdClass%>"  >
        <%=dataRows[i][0]%>
      </td>
      <td align="center" class="<%=tdClass%>"  >
      	<%=dataRows[i][0]%>
      </td>
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

