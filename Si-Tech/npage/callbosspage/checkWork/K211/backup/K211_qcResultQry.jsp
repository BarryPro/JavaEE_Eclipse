<%
  /*
   * ����: �ʼ�����ѯ
�� * �汾: 1.0
�� * ����: 2008/11/10
�� * ����: hanjc 
�� * ��Ȩ: sitech
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
    public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>

<%!
//����Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " ��ʼ����Excel�ļ� " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "�ʼ�����ѯ";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],queryList[i][8],queryList[i][9],queryList[i][10],
				                        queryList[i][11],queryList[i][12],queryList[i][13],queryList[i][14],queryList[i][15],queryList[i][16],queryList[i][17],queryList[i][18],queryList[i][19],queryList[i][20],queryList[i][21],
				                        queryList[i][22],queryList[i][23],queryList[i][24],queryList[i][25],queryList[i][26],queryList[i][27],queryList[i][28],queryList[i][29],queryList[i][30],queryList[i][31]};
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
    String opCode="K211";
    String opName="�ʼ��ѯ-�ʼ�����ѯ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String start_date = request.getParameter("start_date");      
    String end_date = request.getParameter("end_date"); 
    
	  String tableName = "dcallcall";
	  if(start_date!=null){
	    tableName += start_date.substring(0,6);
	  }		
  	String sqlStr = "select "          
                   +"t1.serialnum,     " //��ˮ��
                   +"t1.recordernum,   " //������ˮ��
                   +"t1.staffno,       " //���칤��
                   +"t1.STAFFGROUPID,    " //����Ա����
                   +"t1.ERRORCLASSDESC,      " //Ա������
                   +"t3.object_name,   " //�������
                   +"t1.flag,          " //�ʼ��ʶ
                   +"t1.evterno,       " //�ʼ칤��
                   +"t4.name,          " //��������
                   +"t1.score,         " //�ܵ÷�
                  // +"t1.serialnum,     " //�ƻ�����
                   +"t1.contentlevelid," //�ȼ�
                   +"t1.errorclassid,  " //������
                   +"t1.errorlevelid,  " //���ȼ�
                   +"t1.contentinsum,  " //���ݸ���
                   +"t1.handleinfo,    " //�������
                   +"t1.improveadvice, " //�Ľ�����
                   +"t1.abortreasonid, " //����ԭ��
                   +"t1.kind,          " //������ʽ
                   +"t1.checktype,     " //�������
                   +"t1.serviceclassid," //ҵ�����
                   +"t1.starttime,     " //�ʼ쿪ʼʱ�� 
                   +"t1.endtime,       " //�ʼ����ʱ�� 
                   +"t1.dealduration,  " //����ʱ��
                   +"t1.lisduration,   " //��������ʱ�� 
                   +"t1.arrduration,   " //����ʱ��
                   +"t1.evtduration,   " //�ʼ���ʱ��
                   +"t1.signataryid,   " //ȷ����
                   +"t1.affirmtime,    " //ȷ������
                   +"t1.checkflag,     " //���˱�ʶ
                   +"t1.commentinfo,   " //��������
                   +"decode(t5.vertify_passwd_flag,'Y','��','N','��')   " //�Ƿ�������֤ 
                   +"from dqcinfo t1,dqcobject t3,dqccheckcontect t4,"+tableName+" t5 ";
		String strDateSql="";
		String strJoinSql=" and t1.objectid=t3.object_id(+) "                                                    
                     +" and t1.contentid=t4.contect_id(+) "  
                     +" and t1.recordernum=t5.contact_id(+) " ;
                   
  	String strCountSql="select to_char(count(*)) count"
                      +" from dqcinfo t1,dqcobject t3,dqccheckcontect t4,"+tableName+" t5 ";

    String objectid         = request.getParameter("0_=_t1.objectid");       
    String errorlevelid     = request.getParameter("2_=_t1.errorlevelid"    );
    String errorlevelName   = request.getParameter("errorlevelName"    );
    String qcobjectid       = request.getParameter("3_=_t1.contentid"        );
    String errorclassid     = request.getParameter("5_=_t1.errorclassid"    );
    String errorclassName   = request.getParameter("errorclassName"    );
    String evterno          = request.getParameter("6_=_t1.evterno"         );
    String staffno          = request.getParameter("7_=_t1.staffno"         );
    String recordernum      = request.getParameter("8_=_t1.recordernum"     );
    String qcserviceclassid = request.getParameter("9_=_t1.qcserviceclassid");
    String qcserviceclassName = request.getParameter("qcserviceclassName");
    
    String flag          = request.getParameter("10_=_t1.flag"); 
    String outplanflag   = request.getParameter("11_=_t1.outplanflag"); 
    String checkflag     = request.getParameter("12_=_t1.checkflag"); 
    
    String qcGroupId     = request.getParameter("30_=_t1.qcGroupId");
    String beQcGroupId   = request.getParameter("1_=_t1.beQcGroupId");
    String qcobjectName  = request.getParameter("qcobjectName");
    String qcGroupName   = request.getParameter("qcGroupName");                                                         
    String beQcGroupName = request.getParameter("beQcGroupName");                                                       
    String beQcObjName   = request.getParameter("beQcObjName"); 
    String[][] dataRows  = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp ="";
    String action = request.getParameter("myaction");
    String[] strHead= {"��ˮ��","������ˮ��","���칤��","����Ա����","Ա������","�������","�ʼ��ʶ","�ʼ칤��","��������","�ܵ÷�","�ƻ�����","�ȼ�","������","���ȼ�","���ݸ���","�������","�Ľ�����","����ԭ��","������ʽ","�������","ҵ�����","�ʼ쿪ʼʱ��","�ʼ����ʱ��","����ʱ��","��������ʱ��","����ʱ��","�ʼ���ʱ��","ȷ����","ȷ������","���˱�ʶ","��������","�Ƿ�������֤"};
	  String expFlag = request.getParameter("exp"); 
	  System.out.println("=========action======="+action);
	  String sqlFilter = request.getParameter("sqlFilter");
	  //��ѯ����
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
				strDateSql=" where 1=1 and  to_char(t1.starttime,'yyyymmdd hh24:mi:ss')>='"+start_date.trim()+"' and to_char(t1.starttime,'yyyymmdd hh24:mi:ss')<='"+end_date.trim()+"' ";
    	}
    	sqlFilter=strDateSql+returnSql(request)+strJoinSql;
    }
%>			
<%	if ("doLoad".equals(action)) {
      sqlStr+=sqlFilter;
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
           <wtc:service name="s151Select" outnum="32">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="31"   scope="end"/>
				<%
				dataRows = queryList;
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
	      rowCount = Integer.parseInt(rowsC4[0][0]);
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
           <wtc:service name="s151Select" outnum="32">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="31"   scope="end"/>
				<%
				this.toExcel(queryList,strHead,response);
   }
   
   if("all".equalsIgnoreCase(expFlag)){
     sqlStr+=sqlFilter;    
%>	
					<wtc:service name="s151Select" outnum="31">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="31" scope="end"/>	
<% 
		this.toExcel(queryList,strHead,response);
   } 
%>


<html>
<head>
<title>�ʼ�����ѯ</title>
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
   window.sitechform.action="K211_qcResultQry.jsp";
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
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_qcResultQry.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	  window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.end_date.value="<%=end_date%>";
    
    window.sitechform.errorlevelid.value="<%=errorlevelid%>";
    window.sitechform.qcobjectid.value="<%=qcobjectid%>";
    window.sitechform.errorclassid.value="<%=errorclassid%>";
    window.sitechform.evterno.value="<%=evterno%>";
    window.sitechform.staffno.value="<%=staffno%>";
    window.sitechform.recordernum.value="<%=recordernum%>";
    window.sitechform.qcserviceclassid.value="<%=qcserviceclassid%>";
    window.sitechform.flag.value="<%=flag%>";
    window.sitechform.outplanflag.value="<%=outplanflag%>";
    window.sitechform.checkflag.value="<%=checkflag%>";
    window.sitechform.qcobjectName.value="<%=qcobjectName%>";
    window.sitechform.qcGroupName.value="<%=qcGroupName%>";
    window.sitechform.beQcGroupName.value="<%=beQcGroupName%>";
    window.sitechform.beQcObjName.value="<%=beQcObjName%>";
    window.sitechform.outplanflagValue.value="<%=request.getParameter("outplanflagValue")%>";
    window.sitechform.checkflagValue.value="<%=request.getParameter("checkflagValue")%>";
    window.sitechform.flagValue.value="<%=request.getParameter("flagValue")%>";
}

//��ʾͨ����ϸ��Ϣ
function getQcDetail(contact_id){
		var path="K211_getResultDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    window.open(path,"newwindow","height=768, width=1072,top=50,left=100,scrollbars=auto, resizable=no,location=no, status=yes");
	return true;
}
//�ʼ�����
function getQcContentTree(){
		var path="K211_getQcContent.jsp";
    window.open(path,"ѡ���ʼ�����","height=450, width=620,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
	return true;
}

//�������
function showObjectCheckTree(){
	var path="K211_beQcObjTree_1.jsp";
  openWinMid(path,'ѡ�񱻼����',300, 250);
}

//�ʼ�Ⱥ��
function getQcGroupTree(){
	var path="K211_qcGroTree.jsp";
  openWinMid(path,'ѡ���ʼ�Ⱥ��',300, 250);
}

//����Ⱥ��
function getBeQcGroTree(){
	var path="K211_beQcGroTree.jsp";
  openWinMid(path,'ѡ�񱻼�Ⱥ��',300, 250);
}

//�����𡢲��ȼ���ҵ�����
function getThisTree(flag,title){
	var path="fK240toK270_tree.jsp?op_code="+flag;
	if(flag=='240'){
		title="ѡ�������";
	}else if(flag=='250'){
		title="ѡ����ȼ�";
	}else if(flag=='270'){
		title="ѡ��ҵ�����";
	}
  openWinMid(path,title,300, 250);
}

function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //ת����ҳ�ĵ�ַ;
  //var name; //��ҳ���ƣ���Ϊ��;
  //var iWidth; //�������ڵĿ��;
  //var iHeight; //�������ڵĸ߶�;
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
</script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">�ʼ�����ѯ</div>
		<table cellspacing="0" >
    <!-- THE FIRST LINE OF THE CONTENT -->
  
         <tr >
      <td > ��ʼʱ�� </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > �ʼ�Ⱥ�� </td>
      <td >
				<input id="qcGroupName" name="qcGroupName" size="20" type="text" readOnly value="<%=(qcGroupName==null)?"":qcGroupName%>">
  			<input id="qcGroupId" name="0_=_t1.qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>">
        <img onclick="getQcGroupTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td >����Ⱥ�� </td>
      <td >
        <input id="beQcGroupName" name="beQcGroupName" size="20" type="text" readOnly value="<%=(beQcGroupName==null)?"":beQcGroupName%>">
  			<input id="beQcGroupId" name="1_=_t1.beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>">
        <img onclick="getBeQcGroTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td >���ȼ� </td>
      <td >
				<input  id="errorlevelName" name="errorlevelName" type="text"  onclick=""   value="<%=(errorlevelName==null)?"":errorlevelName%>">
				<input  id="errorlevelid" name="2_=_t1.errorlevelid" type="hidden"  onclick=""   value="<%=(errorlevelid==null)?"":errorlevelid%>">
        <img onclick="getThisTree('K250')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
      <td > ����ʱ�� </td>
      <td >
			  <input id="end_date" name ="end_date" type="text" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
      <td > �ʼ����� </td>
      <td >
      	<input id="qcobjectName" name="qcobjectName" size="20" type="text" readOnly value="<%=(qcobjectName==null)?"":qcobjectName%>">
				<input  id="qcobjectid" name="3_=_t1.contentid" type="hidden"  onclick="getQcContentTree()"   value="<%=(qcobjectid==null)?"":qcobjectid%>">
        <img onclick="getQcContentTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > ������� </td>
      <td >
			  <input id="beQcObjName" name="beQcObjName" size="20" type="text" readOnly value="<%=(beQcObjName==null)?"":beQcObjName%>">
  			<input id="beQcObjId" name="0_=_t1.objectid" size="20"  type="hidden" value="<%=(objectid==null)?"":objectid%>">
        <img onclick="showObjectCheckTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td >������ </td>
      <td >
				<input  id="errorclassName" name="errorclassName" type="text"  onclick=""   value="<%=(errorclassName==null)?"":errorclassName%>">
				<input  id="errorclassid" name="5_=_t1.errorclassid" type="hidden"  value="<%=(errorclassid==null)?"":errorclassid%>">
        <img onclick="getThisTree('k240')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>      
     </tr>
     <!-- THE THIRD LINE OF THE CONTENT -->
     <tr>
     	
      <td > �ʼ칤�� </td>
      <td >
			  <input name ="6_=_t1.evterno" type="text" id="evterno"  maxlength="10" value="<%=(evterno==null)?"":evterno%>">
      </td> 
      
      <td > ���칤�� </td>
      <td >
			  <input name ="7_=_t1.staffno" type="text" id="staffno"  maxlength="10" value="<%=(staffno==null)?"":staffno%>">
      </td> 
      <td > ������ˮ�� </td>
      <td >
			  <input id="recordernum" name="8_=_t1.recordernum" type="text"  value="<%=(recordernum==null)?"":recordernum%>">
      </td> 

      <td > ҵ����� </td>
      <td >
      	<input  id="qcserviceclassName" name="qcserviceclassName" type="text"  onclick=""   value="<%=(qcserviceclassName==null)?"":qcserviceclassName%>">
				<input  id="qcserviceclassid" name="9_=_t1.qcserviceclassid" type="hidden"  onclick=""   value="<%=(qcserviceclassid==null)?"":qcserviceclassid%>">
        <img onclick="getThisTree('K270')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>      
    <!-- THE FOURTH LINE OF THE CONTENT -->
    <tr >

      <td > �ʼ��ʶ </td>
      <td >
				<select name="10_=_t1.flag" id="flag" size="1" onchange="flagValue.value=this.options[this.selectedIndex].text">
      	 	<%if(flag==null || flag.equals("") || request.getParameter("flagValue")==null || request.getParameter("flagValue").equals("")){%>
      	 	<option value="" selected >5-ȫ��</option>
      	 	<%}else {%>
      	 			<option value="<%=flag%>" selected >
      	 				<%=request.getParameter("flagValue")%>
      	 			</option>
      	 	 	<option value="" >5-ȫ��</option>
      	 	<%}%>
					<option value="0" >0-��ʱ����</option>
					<option value="1" >1-���ύ</option>
					<option value="2" >2-���ύ���޸�</option>
					<option value="3" >3-��ȷ��</option>
					<option value="4" >4-����</option>
        </select> 
       <input name="flagValue" type="hidden" value="<%=request.getParameter("flagValue")%>"> 
      </select> 
      </td> 

      <td > �ƻ����� </td>
      <td >
				<select name="11_=_t1.outplanflag" id="outplanflag" size="1" onchange="outplanflagValue.value=this.options[this.selectedIndex].text">
      	 	<%if(outplanflag==null || outplanflag.equals("") || request.getParameter("outplanflagValue")==null || request.getParameter("outplanflagValue").equals("")){%>
      	 	<option value="" selected >2-ȫ��</option>
      	 	<%}else {%>
      	 			<option value="<%=outplanflag%>" selected >
      	 				<%=request.getParameter("outplanflagValue")%>
      	 			</option>
      	 	 	<option value="" >2-ȫ��</option>
      	 	<%}%>
					<option value="1" >0-�ƻ����ʼ�</option>
					<option value="0" >1-�ƻ����ʼ�</option>
        </select> 
       <input name="outplanflagValue" type="hidden" value="<%=request.getParameter("outplanflagValue")%>"> 
      </select>
      </td> 

      <td > ���˱�ʶ </td>
      <td >
				<select name="12_=_t1.checkflag" id="checkflag" size="1" onchange="checkflagValue.value=this.options[this.selectedIndex].text">
      	 	<%if(checkflag==null || checkflag.equals("") || request.getParameter("checkflagValue")==null || request.getParameter("checkflagValue").equals("")){%>
      	 	<option value="" selected >2-ȫ��</option>
      	 	<%}else {%>
      	 			<option value="<%=checkflag%>" selected >
      	 				<%=request.getParameter("checkflagValue")%>
      	 			</option>
      	 	 	<option value="" >2-ȫ��</option>
      	 	<%}%>
					<option value="0" >0-δ����</option>
					<option value="1" >1-�Ѹ���</option>
        </select> 
       <input name="checkflagValue" type="hidden" value="<%=request.getParameter("checkflagValue")%>"> 
      </select>      		

      </td> 

      <td > ����ȼ� </td>
      <td >
				<select name="calLevel" id="calLevel" size="1"  >
      	 	<option value="" >--���м���ȼ�--</option>
        </select>
      </td>                   
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
            <th align="center" class="blue" width="5%" > ���� </th>
            <th align="center" class="blue" width="5%" > ��ˮ�� </th>
            <th align="center" class="blue" width="5%" > ������ˮ�� </th>
            <th align="center" class="blue" width="5%" > ���칤�� </th>
            <!--<th align="center" class="blue" width="5%" > ����Ա���� </th>
            <th align="center" class="blue" width="5%" > Ա������ </th>-->
            <th align="center" class="blue" width="5%" > ������� </th>
            <th align="center" class="blue" width="5%" > �ʼ��ʶ</th>
            <th align="center" class="blue" width="5%" > �ʼ칤�� </th>
            <th align="center" class="blue" width="5%" > �������� </th>
            <th align="center" class="blue" width="5%" > �ܵ÷� </th>
            <th align="center" class="blue" width="5%" > �ƻ����� </th>
            <th align="center" class="blue" width="5%" > �ȼ� </th>
            <th align="center" class="blue" width="5%" > ������ </th>
            <th align="center" class="blue" width="5%" > ���ȼ� </th>
            <th align="center" class="blue" width="5%" > ���ݸ��� </th>
            <th align="center" class="blue" width="5%" > �������</th>
            <th align="center" class="blue" width="5%" > �Ľ����� </th>
            <th align="center" class="blue" width="5%" > ����ԭ�� </th>
            <th align="center" class="blue" width="5%" > ������ʽ </th>
            <th align="center" class="blue" width="5%" > ������� </th>
            <th align="center" class="blue" width="5%" > ҵ����� </th>  
            <th align="center" class="blue" width="5%" > �ʼ쿪ʼʱ�� </th>
            <th align="center" class="blue" width="5%" > �ʼ����ʱ��</th>
            <th align="center" class="blue" width="5%" > ����ʱ�� </th>
            <th align="center" class="blue" width="5%" > ��������ʱ�� </th>
            <th align="center" class="blue" width="5%" > ����ʱ�� </th>
            <th align="center" class="blue" width="5%" > �ʼ���ʱ�� </th>
            <th align="center" class="blue" width="5%" > ȷ���� </th>   
            <th align="center" class="blue" width="5%" > ȷ������ </th>
            <th align="center" class="blue" width="5%" > ���˱�ʶ </th>
            <th align="center" class="blue" width="5%" > �������� </th>
            <th align="center" class="blue" width="5%" > �Ƿ�������֤ </th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr  >
			<%}else{%>
	   <tr  >
	<%}%>
	    <td align="center" class="<%=tdClass%>"  >
       <img onclick="" alt="��ȡ¼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif"  width="16" height="16" align="absmiddle">
       <img onclick="getQcDetail('<%=dataRows[i][0]%>');return false;" alt="��ʾ�ʼ�����ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">
       <img onclick="getCallDetail('<%=dataRows[i][0]%>');return false;" alt="�޸��ʼ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif"  width="16" height="16" align="absmiddle">
       <img onclick="getCallDetail('<%=dataRows[i][0]%>');return false;" alt="��ʾ�޸Ľ����ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">
       <img onclick="" alt="�ʼ�" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif"  width="16" height="16" align="absmiddle">
       <img onclick="" alt="ɾ��������¼" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/6.gif"  width="16" height="16" align="absmiddle">
      </td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
     <!-- <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>-->
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  >�ƻ����ʼ�</td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][11-1].length()!=0)?dataRows[i][11-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][12-1].length()!=0)?dataRows[i][12-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][13-1].length()!=0)?dataRows[i][13-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][14-1].length()!=0)?dataRows[i][14-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][15-1].length()!=0)?dataRows[i][15-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][16-1].length()!=0)?dataRows[i][16-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][17-1].length()!=0)?dataRows[i][17-1]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][18-1].length()!=0)?dataRows[i][18-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][19-1].length()!=0)?dataRows[i][19-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][20-1].length()!=0)?dataRows[i][20-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][21-1].length()!=0)?dataRows[i][21-1]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][22-1].length()!=0)?dataRows[i][22-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][23-1].length()!=0)?dataRows[i][23-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][24-1].length()!=0)?dataRows[i][24-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][25-1].length()!=0)?dataRows[i][25-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][26-1].length()!=0)?dataRows[i][26-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][27-1].length()!=0)?dataRows[i][27-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][28-1].length()!=0)?dataRows[i][28-1]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][29-1].length()!=0)?dataRows[i][29-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][30-1].length()!=0)?dataRows[i][30-1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][31-1].length()!=0)?dataRows[i][31-1]:"&nbsp;"%></td>
      
      
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

