<%
  /*
   * ����: ��Ч����
�� * �汾: 1.0
�� * ����: 2009/04/10
�� * ����: donglei
�� * ��Ȩ: sitech
   *
   *
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>

<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%!
		/**
		 ����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
		 ����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
		 */
    public String returnSql(HttpServletRequest request){
    StringBuffer buffer = new StringBuffer();

   	//�������
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
		String value="";
		//���������������.key������.�����ֽ�������.value�������object�����ֵ
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
			  if(objs[1].toString().equalsIgnoreCase("acceptid")&&objs[2].toString().equalsIgnoreCase("7")){
               buffer.append(" and op_code='K025' ");
			  }else{
		buffer.append(" and " + objs[1] + " " + objs[0] + " '"
				+ objs[2].toString().trim() + "' ");
				}
			}

			if (objs[0].toString().equalsIgnoreCase("!=")) {
			 if(objs[2].toString().equalsIgnoreCase("Y")){
			  buffer.append(" and " + objs[1] + " = '"
				+ objs[2].toString().trim() + "' ");
			  }else{
		      buffer.append(" and (" + objs[1] + " " + objs[0] + " 'Y' or "+objs[1]+" is null) ");
			  }
			 }
		}

        return buffer.toString();
}
	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}
	public  String ReturnSysTime(String strStyle) {
		String s = "";
		java.util.Date date = new java.util.Date();
		java.text.SimpleDateFormat dformat = new java.text.SimpleDateFormat(strStyle);
		s = dformat.format(date);
		return s;
	}
	//zengzq add for �в� start
	public  String getFirstDateOfMonth() {
  	java.util.Calendar cal = java.util.Calendar.getInstance();
  	cal.set(GregorianCalendar.DAY_OF_MONTH, 1);
  	java.util.Date firstDayOfMonth = cal.getTime();
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(firstDayOfMonth) + " 00:00:00";
	}
	//zengzq add for �в� end
%>

<%!
//����Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " ==��ʼ����Excel�ļ�== " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "������Ϣ��ѯ";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],
				                       queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],
				                       queryList[i][8],queryList[i][9],queryList[i][10],queryList[i][11],
				                       queryList[i][12],queryList[i][13],queryList[i][14],queryList[i][15],
				                       queryList[i][16],queryList[i][17],queryList[i][18],queryList[i][19],queryList[i][20]};
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
//jiangbing 20091118 ���������滻
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
     String opCode="90027";
     String opName="��Ч����";
	  String loginNo = (String)session.getAttribute("workNo");
	  String orgCode = (String)session.getAttribute("orgCode");
	  String kf_longin_no=(String)session.getAttribute("kfWorkNo");

     String sqlStr = "select CONTACT_ID,decode(ACCEPTID,'0','�˹�','1','�Զ�','2','����','3','����','4','����','5','EMail','6','Web','7','����','8','����ͨ��' ,'9','�ڲ�����' ,'10','��������','11','����','12','����'),CUST_NAME,decode(region_code, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����'),ACCEPT_PHONE,CALLER_PHONE,";
           sqlStr+="CALLEE_PHONE,to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi:ss'),ACCEPT_LONG,ACCEPT_LOGIN_NO,";
           sqlStr+="decode(STAFFHANGUP,'0','�û�','1','����Ա','2','������֤ʧ���Զ��ͷ�'),decode(QC_FLAG,'Y','���ʼ�','N','δ�ʼ�','','δ�ʼ�',NULL,'δ�ʼ�'),decode(STATISFY_CODE,'0','����','1','δ����','2','һ��','3','������','4','����ȵ���һ�'),decode(LANG_CODE,'1','��ͨ��','2','Ӣ��'),CALLCAUSEDESCS,decode(LISTEN_FLAG,'Y','����','','δ��',NULL,'δ��','N','δ��'),";
           sqlStr+="decode(USE_FLAG,'Y','��','N','��'),QC_LOGIN_NO,decode(VERTIFY_PASSWD_FLAG,'Y','��','N','��','','��',NULL,'��'),decode(OTHER_PASSWD_FLAG,'Y','��','N','��','','��',NULL,'��'),BAK,TRANSFER_BAK,accept_kf_login_no  from dcallcall";
	 String strCountSql="select to_char(count(*)) count  from dcallcall";
	 String strAcceptLogSql="";
	 String strAcceptTimeSql="";
	 String strDateSql="";
	 String strOrderSql=" order by begin_date desc ";

    String start_date    ="";
    String end_date      ="";
    String region_code   ="";
    String contact_id    = "";
    String accept_login_no="";
    String listen_flag  ="";
    String accept_phone="";
    String contact_address="";
    String mail_address="";
    String grade_code="";
    String contact_phone="";
    String caller_phone="";
    String statisfy_code="";
    String cust_name="";
    String fax_no="";
    String accept_long_begin="";
    String accept_long_end="";
    String callee_phone="";
    String skill_quence="";
    String staffHangup="";
    String acceptid="";
    String oper_code="";
    String con_id="";
    String[][] dataRows = new String[][]{};

    //zengzq add for �в� start
    String[][] testRows = new String[][]{};
  	//zengzq add for �в� end

    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String param = "";
    String sqlTemp="";
    String querySql="";

    String[] strHead = { "��ˮ��", "����ʽ", "�ͻ�����", "�ͻ�����", "�������", "���к���",
			"���к���", "����ʱ��", "����ʱ��","������", "�һ���", "�Ƿ��ʼ�", "�ͻ������",  "��������",
			"����ԭ��", "¼����ȡ��־", "�Ƿ�ʹ�÷���", "�ʼ�Ա����", "�Ƿ�������֤","�Ƿ�������֤", "��ע", "ת�ӱ�ע" };
		//String[] conStaffhangup= {"�û�","����Ա","������֤ʧ���Զ��ͷ�"};
		//String[] conStaffcity = {"����","δ����","һ��","������","����ȵ���һ�"};
		String[] conAcceptid= {"�˹�","�Զ�","����","����","����","EMail","Web","����","����ͨ��" ,"�ڲ�����" ,"��������","����","����"};
      String action = request.getParameter("myaction");

      //zengzq add for �в� start
      String test_flag = request.getParameter("test_flag");
      //zengzq add for �в� finished

      String expFlag = request.getParameter("exp");
      start_date        =  request.getParameter("start_date");
      end_date          =  request.getParameter("end_date");
			contact_id        =  request.getParameter("0_=_contact_id");
			region_code       =  request.getParameter("1_=_region_code");
			accept_login_no   =  request.getParameter("2_=_accept_kf_login_no");
			listen_flag       =  request.getParameter("13_!=_listen_flag");
			accept_phone      =  request.getParameter("3_=_accept_phone");
			mail_address      =  request.getParameter("4_=_mail_address");
			contact_address   =  request.getParameter("5_=_contact_address");
      grade_code        =  request.getParameter("6_=_grade_code");
      contact_phone     =  request.getParameter("7_=_contact_phone");
      caller_phone      =  request.getParameter("8_=_caller_phone");   //���к���
      statisfy_code     =  request.getParameter("9_=_statisfy_code");
      cust_name         =  request.getParameter("10_=_cust_name");
      fax_no            =  request.getParameter("11_=_fax_no");
      accept_long_begin =  request.getParameter("accept_long_begin");
      accept_long_end   =  request.getParameter("accept_long_end");
      callee_phone      =  request.getParameter("12_=_callee_phone");
      skill_quence      =  request.getParameter("14_=_skill_quence");
      staffHangup       =  request.getParameter("15_=_staffHangup");
      acceptid          =  request.getParameter("16_=_acceptid");
      oper_code         =  request.getParameter("17_=_staffcity");
      con_id            =  request.getParameter("con_id");
      System.out.println("\n\n_______________________region_code__________"+request.getParameter("region"));
      System.out.println("\n\n______________________start_date___________"+start_date);
      ///////��ѯ��������
      String sqlFilter=request.getParameter("sqlFilter");
  	  if(sqlFilter==null || sqlFilter.trim().length()==0){
         if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){

             strDateSql=" where 1=1 and  to_char(begin_date,'yyyymmdd hh24:mi:ss')>='"+start_date.trim()+"' and to_char(begin_date,'yyyymmdd hh24:mi:ss')<='"+end_date.trim()+"' ";
             if(accept_long_begin!=null&&accept_long_begin.trim().length()!=0){
                strAcceptTimeSql=" and  accept_long>="+Long.valueOf(accept_long_begin.trim()).longValue();
             }
             if(accept_long_end!=null&&accept_long_end.trim().length()!=0){
               strAcceptTimeSql+=" and accept_long<="+Long.valueOf(accept_long_end.trim()).longValue();
             }
             sqlFilter=start_date.substring(0,6)+strDateSql+returnSql(request)+strAcceptTimeSql+strOrderSql;
        }
    }
%>
<%
	//ͨ����sql��ֵ�ж��Ƿ����ʼ�Ա
	  String tmpCountSql = "SELECT COUNT(CHECK_LOGIN_NO) FROM DQCCHECKGROUPLOGIN "+
	  										 "WHERE TRIM(CHECK_LOGIN_NO)="+kf_longin_no.trim() + " AND VALID_FLAG='Y' ";
	  int tmpCoun = 0;
%>

<%
//zengzq add for �в� start

 //if(test_flag!=null&&"1".equals(test_flag.trim())){
 		String testStartDate = getFirstDateOfMonth();
 		String testEndDate = getCurrDateStr("23:59:59");
 		String testStrDateSql=" where 1=1 and  to_char(begin_date,'yyyymmdd hh24:mi:ss')>='" + testStartDate + "' and to_char(begin_date,'yyyymmdd hh24:mi:ss')<='" + testEndDate + "'";
 		String sqlFilter1=testStartDate.substring(0,6)+testStrDateSql ;
 		String tQuerySql = sqlStr + sqlFilter1;
 		String tSqlTemp = strCountSql+sqlFilter1;

%>
		<wtc:service name="s151Select" outnum="1">
			<wtc:param value="<%=tSqlTemp%>"/>
			</wtc:service>
		<wtc:array id="tSqlTempData"  scope="end"/>

<%
		int testDataNum = 0;
		if(tSqlTempData.length!=0){
		    testDataNum = Integer.parseInt(tSqlTempData[0][0]);
		 }
		 //���м�¼�����������������ڲ�ѯ�����һ����¼
		 if(testDataNum>0){
		 int rowNum = (int)(Math.random()*testDataNum);
		 if(rowNum==0){
		 		rowNum = 1;
		 }


%>
			<wtc:service name="s151Select" outnum="24">
					<wtc:param value="<%=tQuerySql%>"/>
			</wtc:service>
			<wtc:array id="tQueryList"  start="0" length="23" scope="end"/>
<%
			testRows = tQueryList;
			System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
			System.out.println("tQueryList[0][0]:"+tQueryList.length);
 		}
 	//}
//zengzq add for �в� finished
%>
<%	if ("doLoad".equals(action)) {
        sqlStr+=sqlFilter;
     // sqlStr+=sqlStr+start_date.substring(0,6);

        sqlTemp = strCountSql+sqlFilter;
    //  sqlTemp+=sqlTemp+start_date.substring(0,6);
		System.out.println("=========sqlStr========"+sqlStr);
		System.out.println("=========sqlTemp========"+sqlTemp);
%>
    	  	<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=tmpCountSql%>"/>
					</wtc:service>
					<wtc:array id="tmpCount"  scope="end"/>
					<%
						if(tmpCount.length!=0){
		      		tmpCoun = Integer.parseInt(tmpCount[0][0]);
		      	}
		      	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
	  				System.out.println(tmpCountSql);
	  				System.out.println(tmpCoun);
	  				System.out.println(kf_longin_no);
	  				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
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
        querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        %>
           <wtc:service name="s151Select" outnum="24">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="23" scope="end"/>
				<%
				dataRows = queryList;
   if(con_id!=null){
   //��¼��ͻ��Ӵ���־
   strAcceptLogSql="insert into dbcalladm.wloginopr (login_accept,op_code,org_code,op_time,op_date,phone_no,login_no,contact_id,flag,contact_flag) values(SEQ_WLOGINOPR.NEXTVAL,:v1,:v2,sysdate,to_char(sysdate,'yyyymmdd'),:v3,:v4,:v5,'I','Y')&&"+opCode+"^"+orgCode+"^"+accept_phone+"^"+loginNo+"^"+con_id;
   List sqlList=new ArrayList();
   String[] sqlArr = new String[]{};
   sqlList.add(strAcceptLogSql);
   sqlArr = (String[])sqlList.toArray(new String[0]);
   String outnum = String.valueOf(sqlArr.length + 1);
   %>
   <wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
   <%
    }
    }
   //������ǰ��ʾ����
   if("cur".equalsIgnoreCase(expFlag)){
       sqlStr+=sqlFilter;
       sqlTemp = strCountSql+sqlFilter;
System.out.println("====cur=====sqlStr========"+sqlStr);
System.out.println("======cur===sqlTemp========"+sqlTemp);
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
        querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        %>
           <wtc:service name="s151Select" outnum="24">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="22"   scope="end"/>
				<%
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){
       sqlStr+=sqlFilter;
       System.out.println("======all===sqlStr========"+sqlStr);
%>
					<wtc:service name="s151Select" outnum="23">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="22" scope="end"/>
<%
				this.toExcel(queryList,strHead,response);
   }

%>


<html>
<head>
<title>��Ч����-��������ѯ</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>

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
function doProcessNavcomring(packet)
	 {
	    var retType = packet.data.findValueByName("retType");
	    var retCode = packet.data.findValueByName("retCode");
	    var retMsg = packet.data.findValueByName("retMsg");
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("����ɹ�!");
	    	}else{
	    		//alert("����ʧ��!");
	    		return false;
	    	}
	    }
	 }

 function doLisenRecord(filepath,contact_id)
{
		   window.top.document.getElementById("recordfile").value=filepath;
		   window.top.document.getElementById("lisenContactId").value=contact_id;
		   window.top.document.getElementById("K042").click();
			var packet = new AJAXPacket("../../../npage/callbosspage/K042/lisenRecord.jsp","���ڴ���,���Ժ�...");
	     packet.data.add("retType" ,  "chkExample");
	     packet.data.add("filepath" ,  filepath);
	     packet.data.add("liscontactId" ,contact_id);
	    core.ajax.sendPacket(packet,doProcessNavcomring,true);
			packet =null;
}
function checkCallListen(id){
		if(id==''){
		return;
		}
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("contact_id",id);
	core.ajax.sendPacket(packet,doProcessGetPath,false);
	packet=null;
}
function doProcessGetPath(packet){
   var file_path = packet.data.findValueByName("file_path");
   var flag = packet.data.findValueByName("flag");
   var contact_id = packet.data.findValueByName("contact_id");
   if(flag=='Y'){
   	doLisenRecord(file_path,contact_id);
   	}else{
   	getCallListen(contact_id)	;
   	}

}
 function saveContact()
{
			var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k1712_contact_rpc.jsp","���ڴ���,���Ժ�...");
			var strContactId =window.top.document.getElementById('contactId').value;
			var strAcceptPhoneNo =window.top.document.getElementById('acceptPhoneNo').value;
	     //alert(strContactId);
	     packet.data.add("strContactId" ,strContactId);
	     packet.data.add("strAcceptPhoneNo" ,strAcceptPhoneNo);
	    core.ajax.sendPacket(packet,dosaveContacting,true);
			packet =null;
}
function dosaveContacting(packet)
	 {
	    var retCode = packet.data.findValueByName("retCode");
	 }

		saveContact();

function getCallListen(id){
	if(id==''){
		return;
		}
//var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
openWinMid("k170_getCallListen.jsp?flag_id="+id,'¼����ȡ',650,850);
}
//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInputCheck(){
	//alert(document.sitechform.end_date.value.substring(0,6));
	//alert(document.sitechform.start_date.value.substring(5,6));
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
    }else if(parseInt(document.sitechform.accept_long_end.value)<=parseInt(document.sitechform.accept_long_begin.value)){
		     showTip(document.sitechform.accept_long_end,"����ʱ���Ҳ�ֵ����������ֵ");
    	   sitechform.accept_long_end.focus();

    }
//    else if(document.getElementById('contact_id').value == ""){
//	       showTip(document.getElementById('contact_id'),"��ˮ�Ų���Ϊ��");
//		     document.getElementById('contact_id').focus();
//   }else if(document.getElementById('accept_login_no').value == ""){
//	       showTip(document.getElementById('accept_login_no'),"�����Ų���Ϊ��");
//		     document.getElementById('accept_login_no').focus();
//   }else if(document.getElementById('accept_phone').value == ""){
//	       showTip(document.getElementById('accept_phone'),"������벻��Ϊ��");
//		     document.getElementById('accept_phone').focus();
//   }
    else
    {
         hiddenTip(document.sitechform.start_date);
         hiddenTip(document.sitechform.end_date);
         hiddenTip(document.sitechform.accept_long_end);
         hiddenTip(document.getElementById('contact_id'));
         hiddenTip(document.getElementById('accept_login_no'));
         hiddenTip(document.getElementById('accept_phone'));
         window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
         window.sitechform.sqlWhere.value="<%=sqlFilter%>";
         submitMe('0');

    	}


}

function submitMe(flag){
   window.sitechform.myaction.value="doLoad";
   	if(flag=='0'){
		 var vCon_id='';
		 var objSwap=window.top.document.getElementById('contactId');
		if(objSwap!=null&&objSwap!=null!=''){
			vCon_id=objSwap.value;
		}
       window.sitechform.action="k1712_contact.jsp?con_id="+vCon_id;
		}else{
			 window.sitechform.action="k1712_contact.jsp";
		}
   window.sitechform.method='post';
   window.sitechform.submit();
}

//zengzq add for �в� start
function testRandomCheck(){
	if(1>'<%=testRows.length%>'){
		rdShowMessageDialog('δ��ȡ�������¼���������ʼ�',0);
		return false;
	}else{
		//alert("����ʼ�:"+'<%=testRows.length%>');
		testCheckPlan('<%=testRows[((int)(Math.random()*testDataNum))][0]%>','<%=testRows[((int)(Math.random()*testDataNum))][22]%>');


	}
}
//zengzq add for �в� end

//��ת��ָ��ҳ��
function jumpToPage(operateCode){
	//alert(operateCode);
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
//=========================================================================
// LOAD PAGES.
//=========================================================================
function doLoad(operateCode){
	 var str='1';
   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
   	str='0';
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
    submitMe(str);
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
 window.location="k1712_contact.jsp";
}

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k1712_contact.jsp?exp="+expFlag;
    window.sitechform.page.value="<%=curPage%>";
    keepValue();
    document.sitechform.method='post';
    document.sitechform.submit();
}

//��ʾͨ����ϸ��Ϣ
function getCallDetail(contact_id,start_date){
	if(contact_id==''){
		return;
		}
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    openWinMid(path,"��Ϣ����",680,960);
	return true;
}
 //������ѯ��ֵ
function keepValue(){
   window.sitechform.statisfy.value="<%=request.getParameter("statisfy")%>";
   window.sitechform.grade.value="<%=request.getParameter("grade")%>";
   window.sitechform.accid.value="<%=request.getParameter("accid")%>";
   window.sitechform.region.value="<%=request.getParameter("region")%>";
   window.sitechform.oper.value="<%=request.getParameter("oper")%>";
   window.sitechform.hangup.value="<%=request.getParameter("hangup")%>";
   window.sitechform.listen.value="<%=request.getParameter("listen")%>";
   window.sitechform.skill.value="<%=request.getParameter("skill")%>";
   window.sitechform.region_code.value="<%=request.getParameter("1_=_region_code")%>";
   window.sitechform.oper_code.value="<%=request.getParameter("17_=_staffcity")%>";
   window.sitechform.statisfy_code.value="<%=request.getParameter("9_=_statisfy_code")%>";
   window.sitechform.grade_code.value="<%=request.getParameter("6_=_grade_code")%>";
   window.sitechform.acceptid.value="<%=request.getParameter("16_=_acceptid")%>";
   window.sitechform.staffHangup.value="<%=request.getParameter("15_=_staffHangup")%>";
   window.sitechform.listen_flag.value="<%=request.getParameter("13_!=_listen_flag")%>";
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


//���д򿪴���
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

function getLoginNo(){
  openWinMid('k170_getLoginNo.jsp','���Ų�ѯ',240,320);
}
function keepRec(id){
	//rdShowMessageDialog("���¼��������",2);
	if(id==''){
		return;
		}
  //var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
 openWinMid("k170_download.jsp?flag_id="+id,'���¼��������',450,850);
}
function showCallLoc(){
	//rdShowMessageDialog("��ʾ���й켣",2);
	//openWinMid("k170_showCallLoc.jsp",'��ʾ���й켣',480,640);
}

//�жϵ�ǰ�����Ƿ��и���ˮ���ŵ��ʼ�ƻ�
function checkIsHavePlan(serialnum,flag,staffno){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
	mypacket.data.add("serialnum",serialnum);
  mypacket.data.add("start_date",window.sitechform.start_date.value);
  mypacket.data.add("flag",flag);
  mypacket.data.add("staffno",staffno);
  core.ajax.sendPacket(mypacket,doProcessIsHavePlan,true);
	mypacket=null;
}

function doProcessIsHavePlan(packet){
	var serialnum = packet.data.findValueByName("serialnum");
	var planCounts = packet.data.findValueByName("planCounts");
	var flag = packet.data.findValueByName("flag");
  var staffno = packet.data.findValueByName("staffno");
	//alert(parseInt(checkList)+parseInt(checkMutList));
  if(parseInt(planCounts)>0){
    checkIsQc(serialnum,flag,staffno);
	}else{
		rdShowMessageDialog("��Ŀǰ�޸ù��ŵ��ʼ�ƻ���");
	}
}

//�ʼ�ǰ�ж��Ƿ��ѱ��ʼ��
//flag 0:�ƻ����ʼ� 1:�ƻ����ʼ�
function checkIsQc(serialnum,flag,staffno){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsQc_rpc.jsp","���ڽ������ʼ�У�飬���Ժ�......");
	mypacket.data.add("serialnum",serialnum);
  mypacket.data.add("start_date",window.sitechform.start_date.value);
  mypacket.data.add("flag",flag);
  mypacket.data.add("staffno",staffno);
  core.ajax.sendPacket(mypacket,doProcess,true);
	mypacket=null;
}

function doProcess(packet){
	var serialnum = packet.data.findValueByName("serialnum");
	var checkList = packet.data.findValueByName("checkList");
	var isOutPlanflag = packet.data.findValueByName("flag");
  var staffno = packet.data.findValueByName("staffno");
	//alert(parseInt(checkList)+parseInt(checkMutList));
  if(parseInt(checkList)<1){
    planInQua(serialnum,staffno);
	}else{
		rdShowMessageDialog("����ˮ�Ѿ����й��ʼ죬�����ظ����У�");
	}
}
/**
  *
  *��������ˮ�����ʼ촰��
  */
function planInQua(serialnum,staffno){
	var  path = '/npage/callbosspage/checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno;
	//�ƻ����ʼ�tabidΪ��ˮ��0���ƻ����ʼ�Ϊ��ˮ��1
	if(!parent.parent.document.getElementById(serialnum+0)){
	parent.parent.addTab(true,serialnum+0,'ִ���ʼ�ƻ�',path);
  }
}

/**
  *
  *��������ˮ�ƻ����ʼ�������
  */
function planInQuaMain(serialnum,staffno,object_id,content_id_checked){
	var  path = '../checkWork/K217/K217_exec_out_plan_qc_main.jsp?serialnum=' + serialnum+'&object_id='+object_id+'&opCode=K218&opName=����ˮ�ʼ�&content_id=' + content_id_checked +'&isOutPlanflag=0&staffno='+staffno;
	var param  = 'dialogWidth=900px;dialogHeight=300px';
	openWinMid(path, '', 760,1024);
}

/**
  *
  *�����ƻ����ʼ촰��
  */
function planOutQua(serialnum,staffno){
	var  path ='/npage/callbosspage/checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0';
	var param  = 'dialogWidth=900px;dialogHeight=300px';
	//window.showModalDialog('../checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0','', param);
	//window.open(path,'', 'width=900px;height=300px');
	//alert(serialnum);
		if(!parent.parent.document.getElementById(serialnum+1)){
	   parent.parent.addTab(true,serialnum+1,'ִ���ʼ�ƻ�',path);
    }
}

 //zengzq add for �в� start
 function testCheckPlan(serialnum,staffno){
 //alert("serialnum:"+serialnum);
 //alert("staffno:"+staffno);
 //return false;
	var  path ='/npage/callbosspage/checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0&isTest=0';
	var param  = 'dialogWidth=900px;dialogHeight=300px';
		if(!parent.parent.document.getElementById(serialnum+1)){
	   parent.parent.addTab(true,serialnum+1,'ִ���ʼ�ƻ�',path);
    }
  self.window.location.href = self.window.location.href;
}
 //zengzq add for �в� end

/**
  *
  *��������ˮ�ƻ����ʼ�������
  */
  /*
function planOutQuaMain(serialnum,staffno,object_id,content_id){
	//alert("open");
	var param  = 'dialogWidth=900px;dialogHeight=300px';
	//window.showModalDialog('../checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno, '', param);
	//window.open('../K217/K217_exec_out_plan_qc_main.jsp?serialnum=' + serialnum + '&object_id=' +object_id + '&content_id=' + content_id +'&isOutPlanflag=1&staffno='+staffno, '', 'width=1024px;height=768px');
	 openWinMid('../K217/K217_exec_out_plan_qc_main.jsp?serialnum=' + serialnum + '&object_id=' +object_id + '&content_id=' + content_id +'&isOutPlanflag=1&staffno='+staffno,'',760,1024);
}
*/
function keepRecToSer(){
	//rdShowMessageDialog("ת��¼����������",2);
}
function getWorkInfo(){
	//rdShowMessageDialog("�鿴��Ӧ������Ϣ",2);
}

	//��������
	function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
		//alert("<%=sqlFilter%>");
	  window.sitechform.sqlWhere.value="<%=sqlFilter%>";

		openWinMid('k171_expSelect.jsp?flag='+flag,'ѡ�񵼳���',340,320);
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

//ѡ���и�����ʾ
var hisObj="";//������һ����ɫ����
var hisColor=""; //������һ������ԭʼ��ɫ

/**
   *hisColor ����ǰtr��className
   *obj       ����ǰtr����
   */
function changeColor(color,obj){

  //�ָ�ԭ��һ�е���ʽ
  if(hisObj != ""){
	 for(var i=0;i<hisObj.cells.length;i++){
		var tempTd=hisObj.cells.item(i);
		tempTd.className=hisColor;
	 }
	}
		hisObj   = obj;
		hisColor = color;

  //���õ�ǰ�е���ʽ
	for(var i=0;i<obj.cells.length;i++){
		var tempTd=obj.cells.item(i);
		tempTd.className='bright';
	}
}


/**
  *desc  : �в��ã������ˮ,�в������ɾ��
  *author: mixh
  *date  : 2009/04/10
  */
function makeSign(){
	var time     = new Date();
	var url      = 'k1711_pop_sign.jsp?time='+time+'&sign_login_no=' + 'sign_login_no' + '&be_sign_login_no=' + 'be_sign_login_no';
	var winParam = 'dialogWidth=800px;dialogHeight=360px';
	window.showModalDialog(url, window, winParam);
}
</script>
<style>
	#Operation_Table {
	margin: 5px;
	padding: 0px;
	width: 100%;
	height:1%;
}
#Operation_Table table{
	font-size: 12px;
	color:#000000;/*#a5b5c0*/
	text-align: left;
	width:100%;
	background-color: #F5F5F5;
	border-top-width: 1px;
	border-left-width: 1px;
	border-top-style: solid;
	border-left-style: solid;
	border-top-color: #b9b9b9;
	border-left-color: #b9b9b9;
}
#Operation_Table th{
	padding: 5px;
	text-indent: 5px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #b9b9b9;
	background-color: #DBE7E8;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #b9b9b9;
	margin: 0px;
	font-weight: bold;
	color: #003399;
	text-decoration: none;
	font-size: 12px;
	white-space: nowrap;
}
#Operation_Table td{
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #b9b9b9;
	background-color: #F7F7F7;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #b9b9b9;
	margin: 0px;
	padding-top: 3px;
	padding-right: 8px;
	padding-bottom: 3px;
	padding-left: 8px;
	color: #003399;
	white-space: nowrap;
}
#Operation_Table td.Grey {
	color: #003399;
	background-color: #FFFFFF;
}

#Operation_Table td.Blue {
	color: #003399;
	white-space: nowrap;
}

/*hanjc add*/
#Operation_Table td.bright {
	color: #003399;
	background-color: #C1CDCD;
}

#Operation_Table td span {
	white-space: nowrap;
}


#Operation_Table .title {
	background-color: #ececec;
	height: 28px;
	background-image: url(../images/ab.gif);
	background-repeat: no-repeat;
	background-position: 10px 10px;
	padding-left: 28px;
	font-size: 12px;
	font-weight: bold;
	text-decoration: none;
	color: #0066CC;
	text-align: left;
	padding-top: 10px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #b9b9b9;
}
</style>

</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title"> </div>
		<table cellspacing="0" style="width:650px">

      <tr >
      <td > ��ʼʱ�� </td>
      <td >
			  <input id="start_date" name ="start_date" type="text"  value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);return false;">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
      <td > Ա������ </td>
      <td >
			 <select id="oper_code" name="17_=_staffcity" size="1"  onchange="oper.value=this.options[this.selectedIndex].text">
			 	<!-- value Ϊ�գ���ѯʱ���Զ����Դ�����-->
        <%if(oper_code==null || oper_code.equals("")|| request.getParameter("oper")==null || request.getParameter("oper").equals("")){%>
			 	<option value="" selected>--����Ա������--</option>
				    <wtc:qoption name="s151Select" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>
			 	<%}else {%>
      	 	 	<option value="" >--����Ա������--</option>
      	 			<option value="<%=oper_code%>" selected >
      	 				<%=request.getParameter("oper")%>
      	 			</option>
				    <wtc:qoption name="s151Select" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' and region_code<>'<%=oper_code%>' order by region_code</wtc:sql>
				  </wtc:qoption>
      	 	<%}%>
        </select>
        <input name="oper" type="hidden" value="<%=request.getParameter("oper")%>">
			  <font color="red">+</font>
      </td>
      <td > ��ˮ�� </td>
      <td >
				<input id="contact_id" name="0_=_contact_id" onkeyup="hiddenTip(this)" type="text" value=<%=(contact_id==null)?"":contact_id%>>
				<font color="red">+</font>

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
			  <input id="end_date" name ="end_date" type="text"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
		  <td > ������ </td>
      <td >
			  <input name ="2_=_accept_kf_login_no" type="text" id="accept_login_no" onkeyup="hiddenTip(this)"  value="<%=(accept_login_no==null)?"":accept_login_no%>">
		    <img onclick="getLoginNo()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle" >
		    <font color="red">+</font>
		  </td>
		  <td > ������� </td>
      <td >
			  <input name ="3_=_accept_phone"  maxlength="15" type="text" id="accept_phone"  value="<%=(accept_phone==null)?"":accept_phone%>" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
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
					<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from scallgradecode order by accept_code</wtc:sql>
				</wtc:qoption>
			  	<%}else {%>
      	 	 	<option value="" >--���пͻ�����--</option>
			  	    <option value="<%=grade_code%>" selected >
      	 				<%=request.getParameter("grade")%>
      	 			</option>
					<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from scallgradecode where accept_code<>'<%=grade_code%>' order by accept_code</wtc:sql>
				</wtc:qoption>
      	 	<%}%>

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
		  <td > �ͻ������ </td>
      <td >
      	 <select name="9_=_statisfy_code" id="statisfy_code" size="1" onchange="statisfy.value=this.options[this.selectedIndex].text">
      	 	<%if(statisfy_code==null || statisfy_code.equals("") || request.getParameter("statisfy")==null || request.getParameter("statisfy").equals("")){%>
      	 	<option value="" selected >--���������--</option>
				  <wtc:qoption name="s151Select" outnum="2">
				   <wtc:sql>select satisfy_code , satisfy_code|| '-->' ||satisfy_name from ssatisfytype where valid_flag = '1'</wtc:sql>
				  </wtc:qoption>
      	 	<%}else {%>
      	 	 	<option value="" >--���������--</option>
      	 			<option value="<%=statisfy_code%>" selected >
      	 				<%=request.getParameter("statisfy")%>
      	 			</option>
				  <wtc:qoption name="s151Select" outnum="2">
				   <wtc:sql>select satisfy_code , satisfy_code|| '-->' ||satisfy_name from ssatisfytype where valid_flag = '1' and satisfy_code<>'<%=statisfy_code%>'</wtc:sql>
				  </wtc:qoption>
      	 	<%}%>
        </select>
       <input name="statisfy" type="hidden" value="<%=request.getParameter("statisfy")%>">
		  </td>
     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
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
		  <select name="16_=_acceptid" id="acceptid" size="1" onchange="accid.value=this.options[this.selectedIndex].text">
		  	<%if(acceptid==null || acceptid.equals("") || request.getParameter("accid").equals("")|| request.getParameter("accid")==null){%>
		  	  <option value="" selected>--��������ʽ--</option>
				  <wtc:qoption name="s151Select" outnum="2">
				   <wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE</wtc:sql>
				  </wtc:qoption>
		  	<%}else {%>
		  	  <option value="" >--��������ʽ--</option>
          <option value="<%=acceptid%>" selected ><%=request.getParameter("accid")%></option>
				  <wtc:qoption name="s151Select" outnum="2">
				   <wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE where accept_code<>'<%=acceptid%>'</wtc:sql>
				  </wtc:qoption>
      	 	<%}%>
        </select>
        <input name="accid" type="hidden" value="<%=request.getParameter("accid")%>">
		  </td>
		  <td > ����ʱ�� </td>
      <td >
			  ><input name ="accept_long_begin" type="text" id="accept_long_begin"  maxlength="5" style="width:60px" value="<%=(accept_long_begin==null)?"":accept_long_begin%>" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			  <<input name ="accept_long_end" type="text" id="accept_long_end"      maxlength="5" style="width:60px"  value="<%=(accept_long_end==null)?"":accept_long_end%>" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td>
     </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
    <tr >
      <td > �ͻ����� </td>
      <td >
			 <select id="region_code" name="1_=_region_code" size="1" onchange="region.value=this.options[this.selectedIndex].text">
			 	<%if(region_code==null || "".equals(region_code)|| request.getParameter("region")==null || request.getParameter("region").equals("")){%>
			 	<option value="" selected>--���пͻ�����--</option>
				   <wtc:qoption name="s151Select" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				   </wtc:qoption>
			 	<%}else {%>
      	 	 	<option value="" >--���пͻ�����--</option>
      	 		<option value="<%=region_code%>" selected ><%=request.getParameter("region")%></option>
				    <wtc:qoption name="s151Select" outnum="2">
				     <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' and region_code<>'<%=region_code%>' order by region_code</wtc:sql>
				    </wtc:qoption>
      	 <%}%>
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
				      <wtc:qoption name="s151Select" outnum="2">
				       <wtc:sql>select hangup_code , hangup_code|| '-->' ||hangup_name from staffhangup order by hangup_code</wtc:sql>
				      </wtc:qoption>
        	<%}else {%>
      	 	 	<option value="" >ȫ��</option>
      	 		<option value="<%=staffHangup%>" selected ><%=request.getParameter("hangup")%></option>
				     <wtc:qoption name="s151Select" outnum="2">
				      <wtc:sql>select hangup_code , hangup_code|| '-->' ||hangup_name from staffhangup  where hangup_code<>'<%=staffHangup%>' order by hangup_code</wtc:sql>
				     </wtc:qoption>
      	 	<%}%>
        </select>
        <input name="hangup" type="hidden" value="<%=request.getParameter("hangup")%>">
      </td>
      <td > ¼����ȡ��־ </td>
      <td >
        <select id="listen_flag" name="13_!=_listen_flag" size="1" onchange="listen.value=this.options[this.selectedIndex].text">
        	<%if(listen_flag==null || listen_flag.equals("") || request.getParameter("listen").equals("")|| request.getParameter("listen")==null){%>
        	<option value="" selected>ȫ��</option>
				<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select listen_flag_code , listen_flag_code|| '-->' ||listen_flag_name from SLISTENFLAG</wtc:sql>
				</wtc:qoption>
        		<%}else {%>
      	 	 	<option value="" >ȫ��</option>
      	 			<option value="<%=listen_flag%>" selected >
      	 				<%=request.getParameter("listen")%>
      	 			</option>
				<wtc:qoption name="s151Select" outnum="2">
				<wtc:sql>select listen_flag_code , listen_flag_code|| '-->' ||listen_flag_name  from SLISTENFLAG where listen_flag_code<>'<%=listen_flag%>'</wtc:sql>
				</wtc:qoption>
      	 	<%}%>
        </select>
        <input name="listen" type="hidden" value="<%=request.getParameter("listen")%>">
      </td>
    </tr>
        <!-- THE THIRD LINE OF THE CONTENT -->
    <tr >
      <td >���ܶ��� </td>
      <td colspan="7" >
        <select id="skill_quence" name="14_=_skill_quence" size="1" onchange="skill.value=this.options[this.selectedIndex].text">
        	<%if(skill_quence==null || skill_quence.equals("")|| request.getParameter("skill")==null || request.getParameter("skill").equals("")){%>
        	<option value="" selected>--���м��ܶ���--</option>
				  <wtc:qoption name="s151Select" outnum="2">
				  <wtc:sql>select skill_queue_id , skill_queue_id|| '-->' ||skill_queud_name from dagskillqueue</wtc:sql>
				  </wtc:qoption>
        	<%}else {%>
           <option value="" >--���м��ܶ���--</option>
      	 			<option value="<%=skill_quence%>" selected >
      	 				<%=request.getParameter("skill")%>
      	 			</option>
				  <wtc:qoption name="s151Select" outnum="2">
				  <wtc:sql>select skill_queue_id , skill_queue_id|| '-->' ||skill_queud_name from dagskillqueue where skill_queue_id<>'<%=skill_quence%>' </wtc:sql>
				  </wtc:qoption>
      	 	 <%}%>
        </select>
        <input name="skill" type="hidden" value="<%=request.getParameter("skill")%>">
      </td>
    </tr>
	 <tr >

    </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" style="width:600px">
       <input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();">
       <!--input name="delete_value" type="button"  id="add" value="����" onClick="history.go(0);"-->
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();">

			 <!--input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('cur')\"");%>>
       <input name="exportAll" type="button"  id="add" value="����ȫ��" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('all')\"");%>-->

       <!--zengzq add for �в�-->

      </td>
    </tr>
		</table>
	</div>
  <div id="Operation_Table">
  	<table  cellspacing="0">
    <tr>
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
        <a href="#" onClick="doLoad('last');return false;">βҳ</a>&nbsp;
        <a>����ѡ��</a>
        <select onchange="jumpToPage(this.value)">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <a>������ת</a>
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=����>GO</font>
        <%}%>
      </td>
    </tr>
  </table>
      <table  cellSpacing="0" >
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
          <tr >
       <script>
       	var tempBool ='flase';
      	if(checkRole(K171A_RolesArr)==true||checkRole(K171B_RolesArr)==true||checkRole(K171C_RolesArr)==true||checkRole(K171D_RolesArr)==true||checkRole(K171E_RolesArr)==true||checkRole(K171F_RolesArr)==true||checkRole(K171G_RolesArr)==true||checkRole(K171H_RolesArr)==true){
      		//document.write('<th align="center" class="blue" width="15%" > ���� </th>');
      		//tempBool='true';
      	}
        </script>
            <th align="center" class="blue" width="8%" > ��ˮ�� </th>
            <th align="center" class="blue" width="8%" > ����ʽ</th>
            <th align="center" class="blue" width="8%" > �ͻ����� </th>
            <th align="center" class="blue" width="8%" > �ͻ����� </th>
            <th align="center" class="blue" width="8%" > �������</th>
            <th align="center" class="blue" width="8%" > ���к��� </th>
            <th align="center" class="blue" width="8%" > ���к���</th>
            <th align="center" class="blue" width="8%" > ����ʱ��</th>
            <th align="center" class="blue" width="8%" > ����ʱ��</th>
            <th align="center" class="blue" width="8%" > ������</th>
            <th align="center" class="blue" width="8%" > �һ��� </th>
            <th align="center" class="blue" width="8%" > �Ƿ��ʼ�</th>
            <th align="center" class="blue" width="8%" > �ͻ������ </th>
            <th align="center" class="blue" width="8%" > ��������</th>
            <th align="center" class="blue" width="8%" > ����ԭ��</th>
            <th align="center" class="blue" width="8%" > ¼����ȡ��־ </th>
           <!-- <th align="center" class="blue" width="8%" > �Ƿ�ʹ�÷���</th>-->
            <th align="center" class="blue" width="8%" > �ʼ�Ա����</th>
            <th align="center" class="blue" width="8%" > �Ƿ�������֤</th>
            <th align="center" class="blue" width="8%" > �Ƿ�������֤</th>
            <th align="center" class="blue" width="8%" > ��ע</th>
            <th align="center" class="blue" width="8%" > ת�ӱ�ע</th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {
                String tdClass="";
           %>

         <%if((i+1)%2==1){
          tdClass="grey";
          }%>
	   <tr onClick="changeColor('<%=tdClass%>',this);"  >

     
      <!--
       <img style="cursor:hand" onclick="checkCallListen('<%=dataRows[i][0]%>');return false;" alt="��ȡ����" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle"
       <img style="cursor:hand" onclick="getCallDetail('<%=dataRows[i][0]%>','<%=start_date%>');return false;" alt="��ʾ��ͨ������ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="keepRec('<%=dataRows[i][0]%>')" alt="���¼��������" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/3.gif" width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="showCallLoc()" alt="��ʾ���й켣" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/11.gif" width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="checkIsHavePlan('<%=dataRows[i][0]%>',1,'<%=dataRows[i][22]%>')" alt="�ƻ����ʼ쿼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="planOutQua('<%=dataRows[i][0]%>','<%=dataRows[i][22]%>')" alt="�ƻ����ʼ쿼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="keepRecToSer()" alt="ת��¼����������" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/6.gif" width="16" height="16" align="absmiddle">
       <img style="cursor:hand" onclick="getWorkInfo()" alt="�鿴��Ӧ������Ϣ" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/10.gif" width="16" height="16" align="absmiddle">
       -->
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" ><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][22].length()!=0)?dataRows[i][22]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" ><%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" ><%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][13].length()!=0)?dataRows[i][13]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" ><%=(dataRows[i][14].length()!=0)?dataRows[i][14]:"&nbsp;"%></td>

      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>

       <!--td align="center" class="<%=tdClass%>" ><%=(dataRows[i][16].length()!=0)?dataRows[i][16]:"&nbsp;"%></td-->
      <!--td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][17].length()!=0)?dataRows[i][17]:"&nbsp;"%></td-->
      <td align="center" class="<%=tdClass%>"  ><%=(tmpCoun>0)?((dataRows[i][17].length()!=0)?dataRows[i][17]:"&nbsp;"):"******"%></td>
       <td align="center" class="<%=tdClass%>" ><%=(dataRows[i][18].length()!=0)?dataRows[i][18]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][19].length()!=0)?dataRows[i][19]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][20].length()!=0)?dataRows[i][20]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][21].length()!=0)?dataRows[i][21]:"&nbsp;"%></td>
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
        <a href="#" onClick="doLoad('last');return false;">βҳ</a>&nbsp;
        <a>����ѡ��</a>
        <select onchange="jumpToPage(this.value)">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <a>������ת</a>
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=����>GO</font>
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

