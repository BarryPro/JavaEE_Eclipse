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
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
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
			if (objs[0].toString().equalsIgnoreCase("str")){
    	buffer.append(" and instr("+objs[1]+",'"+objs[2].toString()+"',-1,1)>0");
			}
      //ֻ�����ڱ�ҳ�湦�ܣ��ж��Ƿ��Ѿ�����--��ʼ
      if (objs[0].toString().equalsIgnoreCase("<>")) {
        if(objs[2].toString().equalsIgnoreCase("1")){
          buffer.append(" and " + objs[1] + " = '"
				+ objs[2].toString().trim() + "' ");
        }
	      if(objs[2].toString().equalsIgnoreCase("0")){
				buffer.append(" and " + objs[1] + " " + objs[0] + " '1' ");
	      }
			}
      //ֻ�����ڱ�ҳ�湦��--����
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
    String opCode="5700";
    String opName="��Ч����-�����������۽����ѯ";
	  //String loginNo = (String)session.getAttribute("kfWorkNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String start_date = request.getParameter("start_date");      
    String end_date = request.getParameter("end_date"); 
    boolean isModifyed = false;
    
	  String tableName = "dcallcall";
	  if(start_date!=null){
	    tableName += start_date.substring(0,6);
	  }		

    String beQcObjId        = request.getParameter("0_=_t1.objectid");       
    String errorlevelid     = request.getParameter("2_Str_t1.errorlevelid"    );
    String errorlevelName   = request.getParameter("errorlevelName"    );
    String qcobjectid       = request.getParameter("3_=_t1.contentid"        );
    String errorclassid     = request.getParameter("5_Str_t1.errorclassid"    );
    String errorclassName   = request.getParameter("errorclassName"    );
    String evterno          = request.getParameter("6_=_t1.evterno"         );
    String staffno          = request.getParameter("7_=_t1.staffno"         );
    String recordernum      = request.getParameter("8_=_t1.recordernum"     );
    String qcserviceclassid = request.getParameter("9_Str_t1.qcserviceclassid");
    String qcserviceclassName = request.getParameter("qcserviceclassName");
    String flag          = request.getParameter("10_=_t1.flag"); 
    String outplanflag   = request.getParameter("11_=_t1.outplanflag"); 
    String checkflag     = request.getParameter("12_<>_t1.checkflag");   
    String qcGroupId     = request.getParameter("qcGroupId");
    String beQcGroupId   = request.getParameter("beQcGroupId");
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
    String strDateSql="";
    String action = request.getParameter("myaction");
    String[] strHead= {"��ˮ��","������ˮ��","���칤��","����Ա����","Ա������","�������","�ʼ��ʶ","�ʼ칤��","��������","�ܵ÷�","�ƻ�����","�ȼ�","������","���ȼ�","���ݸ���","�������","�Ľ�����","����ԭ��","������ʽ","�������","ҵ�����","�ʼ쿪ʼʱ��","�ʼ����ʱ��","����ʱ��","��������ʱ��","����ʱ��","�ʼ���ʱ��","ȷ����","ȷ������","���˱�ʶ","��������","�Ƿ�������֤"};
	  String expFlag = request.getParameter("exp"); 
	  String sqlFilter = request.getParameter("sqlFilter");
  	//��ѯ����
   if(sqlFilter==null || sqlFilter.trim().length()==0){
  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
			strDateSql=" where 1=1 and  to_char(t1.starttime,'yyyymmdd hh24:mi:ss')>='"+start_date.trim()+"' and to_char(t1.starttime,'yyyymmdd hh24:mi:ss')<='"+end_date.trim()+"' ";
  	}
  	if(qcGroupId!=null&& !qcGroupId.trim().equals("")){
  	  strDateSql+=" and t1.evterno in (select check_login_no from dqccheckgrouplogin where check_group_id='"+qcGroupId+"') ";
  	}
  	if(beQcGroupId!=null&& !beQcGroupId.trim().equals("")){
  	  strDateSql+=" and t1.staffno in (select login_no from dqclogingrouplogin where login_group_id='"+beQcGroupId+"') ";
  	}
  	sqlFilter=strDateSql+returnSql(request);
  }
    
    String sqlStrTemp = "select min(t1.recordernum) from dqcinfo t1 "+strDateSql;
    sqlStrTemp+=sqlFilter;
%>		           
		<wtc:service name="s151Select" outnum="1">
				<wtc:param value="<%=sqlStrTemp%>"/>
		</wtc:service>
		<wtc:array id="queryTempList"  scope="end"/>
<%
		if(queryTempList.length>0&&(queryTempList[0][0].trim()).length()>0){
			  tableName = "dcallcall";
			  tableName+=queryTempList[0][0].substring(0, 6);
		}	 

  	String sqlStr = "select "          
                   +"t1.serialnum,     " //��ˮ��
                   +"t1.recordernum,   " //������ˮ��
                   +"t1.staffno,       " //���칤��
                   +"v.login_name,  "       //����Ա����
                   +"'',   " //Ա������,��ʱû�д��
                   +"t3.object_name,   " //�������
                   +"decode(t1.flag,'0','��ʱ����','1','���ύ','2','���ύ���޸�','3','��ȷ��','4','����')," //�ʼ��ʶ
                   +"t1.evterno,       " //�ʼ칤��
                   +"t4.name,          " //��������
                   +"decode(to_char(t1.score),'','0',null,'0',t1.score)," //�ܵ÷�
                   +"decode(to_char(t1.outplanflag),'0','�ƻ����ʼ�','1',' �ƻ����ʼ�'),     " //�ƻ�����
                   +"t1.contentlevelid," //�ȼ�
                   +"t1.errorclassdesc,  " //������
                   +"t1.errorleveldesc,  " //���ȼ�
                   +"t1.contentinsum,  " //���ݸ���
                   +"t1.handleinfo,    " //�������
                   +"t1.improveadvice, " //�Ľ�����
                   +"t1.abortreasondesc, " //����ԭ��
                   +"decode(t1.kind,'0','�Զ�����','1','�˹�ָ��'),     " //������ʽ
                   +"decode(t1.checktype,'0','ʵʱ�ʼ�','1','�º��ʼ�')," //�������
                   +"t1.serviceclassdesc," //ҵ�����
                   +"to_char(t1.starttime,'yyyy-MM-dd hh24:mi:ss')," //�ʼ쿪ʼʱ�� 
                   +"to_char(t1.endtime,'yyyy-MM-dd hh24:mi:ss')," //�ʼ����ʱ�� 
                   +"decode(to_char(t1.dealduration),'','0',null,'0',t1.dealduration)," //����ʱ��
                   +"decode(to_char(t1.lisduration),'','0',null,'0',t1.lisduration)," //��������ʱ�� 
                   +"decode(to_char(t1.arrduration),'','0',null,'0',t1.arrduration)," //����ʱ��
                   +"decode(to_char(t1.evtduration),'','0',null,'0',t1.evtduration)," //�ʼ���ʱ��
                   +"t1.signataryid,   " //ȷ����
                   +"to_char(t1.affirmtime,'yyyy-MM-dd hh24:mi:ss'),    " //ȷ������
                   +"decode(t1.checkflag,'0','δ����','-1','δ����','1','�Ѹ���'),     " //���˱�ʶ
                   +"t1.commentinfo,   " //��������
                   +"decode(t1.vertify_passwd_flag,'Y','��','N','��','','��',NULL,'��'),   " //�Ƿ�������֤ 
                   +"t1.objectid,     " //�������id
                   +"t1.contentid,   " //��������id 
                   +"t1.flag,  "
                   +"t1.checkflag "     //���˱�ʶid               
                   +"from dqcinfo t1,dloginmsg v,dloginmsgrelation vl,dqcobject t3,dqccheckcontect t4,dual t6 ";

		String strJoinSql=" and t1.is_del='N' and t1.objectid=t3.object_id(+) "                                                   
                     +" and t1.contentid=t4.contect_id(+) " 
                     +" and t1.objectid=t4.object_id(+) "  
                     +" and t1.staffno=vl.KF_LOGIN_NO(+) and v.LOGIN_NO=vl.BOSS_LOGIN_NO "
                     +"  order by t1.starttime desc" ;
                   
  	String strCountSql="select to_char(count(*)) count"
                      +" from dqcinfo t1,dloginmsg v,dloginmsgrelation vl,dqcobject t3,dqccheckcontect t4,dual t6 ";			
			   
%>			
<%	
		if ("doLoad".equals(action)) {
      sqlStr+=sqlFilter+strJoinSql;
      sqlTemp = strCountSql+sqlFilter+strJoinSql;
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
		<wtc:service name="s151Select" outnum="37">
				<wtc:param value="<%=querySql%>"/>
		</wtc:service>
		<wtc:array id="queryList"  start="1" length="36"   scope="end"/>
<%
		dataRows = queryList;
    }
   
   //������ǰ��ʾ����
   if("cur".equalsIgnoreCase(expFlag)){    
 			  sqlStr+=sqlFilter+strJoinSql;
        sqlTemp = strCountSql+sqlFilter+strJoinSql;
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
				<wtc:service name="s151Select" outnum="37">
						<wtc:param value="<%=querySql%>"/>
				</wtc:service>
				<wtc:array id="queryList"  start="1" length="32"   scope="end"/>
<%
				this.toExcel(queryList,strHead,response);
   }
   
   if("all".equalsIgnoreCase(expFlag)){
     	sqlStr+=sqlFilter+strJoinSql;    
%>	
			<wtc:service name="s151Select" outnum="37">
					<wtc:param value="<%=sqlStr%>"/>
			</wtc:service>
			<wtc:array id="queryList" start="0" length="32" scope="end"/>	
<% 
			this.toExcel(queryList,strHead,response);
   } 
%>


<html>
<head>
<title>�����������۽����ѯ</title>
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
function doProcessNavcomring(packet){
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
		    	if(retCode=="000000"){
		    	}else{
		    			return false;
		    	}
	    }
	 } 
 
function doLisenRecord(filepath,contact_id){
		   window.top.document.getElementById("recordfile").value=filepath;
		   window.top.document.getElementById("lisenContactId").value=contact_id;
		   window.top.document.getElementById("K042").click();
			 var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K042/lisenRecord.jsp","���ڴ���,���Ժ�...");
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
function getCallListen(id){
		if(id==''){
				return;
		}		
openWinMid(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_getCallListen.jsp?flag_id="+id,'¼����ȡ',650,850);
}
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
		    window.sitechform.sqlWhere.value="<%=sqlFilter%>";  
		    submitMe();
    }
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="5699_qcResultQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}

function doLoad(operateCode){
		if(operateCode=="load"){
				window.sitechform.page.value="";
		}else if(operateCode=="first"){
				window.sitechform.page.value=1;
		}else if(operateCode=="pre"){
				window.sitechform.page.value=<%=(curPage-1)%>;
		}else if(operateCode=="next"){
				window.sitechform.page.value=<%=(curPage+1)%>;
		}else if(operateCode=="last"){
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
						}else if(e[i].id=="end_date"){
								e[i].value='<%=getCurrDateStr("23:59:59")%>';
						}else{
								e[i].value="";
						}
				}else if(e[i].type=="checkbox"){
						e[i].checked=false;
				}
		}
}

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/5699_qcResultQry.jsp?exp="+expFlag;
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
    window.sitechform.beQcObjId.value="<%=beQcObjId%>";      
    window.sitechform.errorlevelName.value="<%=errorlevelName%>";
    window.sitechform.errorclassName.value="<%=errorclassName%>";
    window.sitechform.qcserviceclassName.value="<%=qcserviceclassName%>";
    window.sitechform.checkflag.value="<%=checkflag%>";
    window.sitechform.qcGroupId.value="<%=qcGroupId%>";
    window.sitechform.beQcGroupId.value="<%=beQcGroupId%>";
}

//��ʾ�ʼ�����ϸ��Ϣ
function getQcDetail(contact_id){
		var path="K211_getResultDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    
	  var height = 600;
		var width  = 1000;
		var top    = (screen.availHeight - height)/2;
		var left   = (screen.availWidth - width)/2;
		var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	             'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
 		window.open(path, 'detailWin', param);
		return true;
}

//��ʾ�޸��ʼ�����ϸ��Ϣ
function getModDetail(contact_id,start_date,end_date){
		var path="../K213/K213_qcModifyRecQry.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    path = path + "&end_date=" + end_date;
    path = path + "&opCodeFlag=K211";
    var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
    window.open(path,"�������","height=750, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
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
	  var param  = 'dialogWidth=300px;dialogHeight=250px';
	  var returnValue =window.showModalDialog(path,'ѡ�񱻼����',param);
		if(typeof(returnValue) != "undefined"){
				 var beQcObjId = document.getElementById("beQcObjId");
				 var beQcObjName   = document.getElementById("beQcObjName");
				 var temp = returnValue.split('_');
				 beQcObjId.value = trim(temp[0]);
				 beQcObjName.value   = trim(temp[1]);
		 }
}

//�ʼ�Ⱥ��
function getQcGroupTree(){
		var path="K211_qcGroTree.jsp";
	  var param  = 'dialogWidth=300px;dialogHeight=250px';
	  var returnValue =window.showModalDialog(path,'ѡ���ʼ�Ⱥ��',param);
		if(typeof(returnValue) != "undefined"){
				 var qcGroupId = document.getElementById("qcGroupId");
				 var qcGroupName   = document.getElementById("qcGroupName");
				 var temp = returnValue.split('_');
				 qcGroupId.value = trim(temp[0]);
				 qcGroupName.value   = trim(temp[1]);
		 }
}

//����Ⱥ��
function getBeQcGroTree(){
		var path="K211_beQcGroTree.jsp";
		var param  = 'dialogWidth=300px;dialogHeight=250px';
	  var returnValue =window.showModalDialog(path,'ѡ�񱻼�Ⱥ��',param);
		if(typeof(returnValue) != "undefined"){
				 var beQcGroupId = document.getElementById("beQcGroupId");
				 var beQcGroupName   = document.getElementById("beQcGroupName");
				 var temp = returnValue.split('_');
				 beQcGroupId.value = trim(temp[0]);
				 beQcGroupName.value   = trim(temp[1]);
		 }
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

function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}


//�жϵ�ǰ�����Ƿ����޸ĵ�ǰ��¼��Ȩ��
function checkRight(serialnum,staffno,evterno,object_id,content_id,flag){
		var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K211/K211_checkModRight_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
		mypacket.data.add("serialnum",serialnum);
		mypacket.data.add("staffno",staffno);
		mypacket.data.add("evterno",evterno);   
		mypacket.data.add("object_id",object_id);  
		mypacket.data.add("content_id",content_id); 
		mypacket.data.add("flag",flag); 
		core.ajax.sendPacket(mypacket,doProcessCheckRight,true);
		mypacket=null;
}

function doProcessCheckRight(packet){
		var serialnum = packet.data.findValueByName("serialnum");
		var flag = packet.data.findValueByName("flag");
		var staffno = packet.data.findValueByName("staffno");	
		var evterno = packet.data.findValueByName("evterno");	   
		var object_id = packet.data.findValueByName("object_id");
		var content_id = packet.data.findValueByName("content_id");
		var pass = packet.data.findValueByName("pass");	  
	
		if(pass=='Y'){
		  	updateQcResult(serialnum,staffno,object_id,content_id,flag);
		}else{
				rdShowMessageDialog("��û���޸Ĵ���ˮ��Ȩ�ޣ�");
		}
}

/**
  *
  *�������ʼ����޸Ĵ���
  */
function updateQcResult(serialnum,staffno,object_id,content_id,flag){
		if(flag!='4'){
			  var path ='../callbosspage/checkWork/K214/K214_modify_plan_qc_main.jsp?serialnum=' + serialnum +'&staffno=' + staffno+ '&object_id=' + object_id + '&content_id='+content_id+ '&mod_flag=mod';	
			  var opCode='K214';	
			  
			  if(!parent.parent.document.getElementById(opCode)){
				  	path = path+'&tabId='+opCode;
			      parent.parent.addTab(true,opCode,'�ʼ����޸�',path);
		  	}else{
			  		rdShowConfirmDialog("���ʼ����޸Ĵ����Ѵ򿪣�",1);
			  }
	  }else{
		   	rdShowConfirmDialog("�޷��޸��ѷ������ʼ�����",1);
	  }
}

//�жϵ�ǰ�����Ƿ��и���ˮ���ŵ��ʼ�ƻ�
function checkIsHavePlan(serialnum,staffno,object_id,content_id,flag,checkFlag){
		var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
		mypacket.data.add("serialnum",serialnum);
	  mypacket.data.add("start_date",window.sitechform.start_date.value);
	  mypacket.data.add("flag",flag);
	  mypacket.data.add("staffno",staffno);  
	  mypacket.data.add("object_id",object_id); 
	  mypacket.data.add("content_id",content_id); 
	  mypacket.data.add("checkFlag",checkFlag); 
	  core.ajax.sendPacket(mypacket,doProcessIsHavePlan,true);
		mypacket=null;
}

function doProcessIsHavePlan(packet){
		var serialnum = packet.data.findValueByName("serialnum");
		var planCounts = packet.data.findValueByName("planCounts");
		var flag = packet.data.findValueByName("flag");
	  var staffno = packet.data.findValueByName("staffno");	
		var object_id = packet.data.findValueByName("object_id");
		var content_id = packet.data.findValueByName("content_id");
	  var checkFlag = packet.data.findValueByName("checkFlag");	  
	  if(parseInt(planCounts)>0){
	    	checkResult(serialnum,staffno,object_id,content_id,flag,checkFlag);
		}else{
				rdShowMessageDialog("��Ŀǰ�޸ù��ŵĸ��˼ƻ���");
		}
}

/**
  *
  *�������ʼ������˴���
  */
function checkResult(serialnum,staffno,object_id,content_id,flag,checkFlag){
		if(checkFlag!='1'){
				if(flag=='1'||flag=='2'||flag=='3'){
				var  path = '/npage/callbosspage/checkWork/K219/K219_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno;
						if(!parent.parent.document.getElementById(serialnum+0)){
								parent.parent.addTab(true,serialnum+0,'�ʼ����',path);
						}
				}else{
						rdShowMessageDialog("����ˮδ�ύ���޷����и���!",1); 
				}
		}else{
				rdShowMessageDialog("����ˮ����ɸ���!",1); 
		}
}

//ɾ���ʼ���
function deleteQcInfo(serialnum,flag){
		//ֻ�з����Ľ���ſ���ɾ��
		if(rdShowConfirmDialog("��ȷ��ɾ���˼�¼ô��")=='1'){
		    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K211/K211_deleteQcInfo_rpc.jsp","����ɾ����¼�����Ժ�...");
			  chkPacket.data.add("serialnum", serialnum);
		    core.ajax.sendPacket(chkPacket,doProcessDeleteQcInfo,true);
			  chkPacket =null;
		}
}

function doProcessDeleteQcInfo(packet){
	  var retCode = packet.data.findValueByName("retCode");
		if(retCode=="00000"){
				rdShowMessageDialog("ɾ���ɹ���",2);
				window.sitechform.myaction.value="doLoad";
		    keepValue();
		    window.sitechform.action="5699_qcResultQry.jsp";
		    window.sitechform.method='post';
		    document.sitechform.submit();
		}else{
				rdShowMessageDialog("ɾ��ʧ�ܣ�");
		}
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


//���д򿪴���
function openWinMidForLoad(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
//��������
function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
	  window.sitechform.sqlWhere.value="<%=sqlFilter%>";
	 
		openWinMidForLoad('k211_expSelect.jsp?flag='+flag,'ѡ�񵼳���',340,320);
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
		<div class="title">�����������۽����ѯ</div>
		<table cellspacing="0" style="width:650px">
  
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
  			<input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>">
        <img onclick="getQcGroupTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
      <td >����Ⱥ�� </td>
      <td >
        <input id="beQcGroupName" name="beQcGroupName" size="20" type="text" readOnly value="<%=(beQcGroupName==null)?"":beQcGroupName%>">
  			<input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>">
        <img onclick="getBeQcGroTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
      <td >���ȼ� </td>
      <td >
				<input  id="errorlevelName" name="errorlevelName" type="text" readOnly onclick=""   value="<%=(errorlevelName==null)?"":errorlevelName%>">
				<input  id="errorlevelid" name="2_Str_t1.errorlevelid" type="hidden"  onclick=""   value="<%=(errorlevelid==null)?"":errorlevelid%>">
        <img onclick="getThisTree('K250')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
    </tr>
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
      </td>
      <td > ������� </td>
      <td >
			  <input id="beQcObjName" name="beQcObjName" size="20" type="text" readOnly value="<%=(beQcObjName==null)?"":beQcObjName%>">
  			<input id="beQcObjId" name="0_=_t1.objectid" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>">
        <img onclick="showObjectCheckTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
      <td >������ </td>
      <td >
				<input  id="errorclassName" name="errorclassName" type="text" readOnly onclick=""   value="<%=(errorclassName==null)?"":errorclassName%>">
				<input  id="errorclassid" name="5_Str_t1.errorclassid" type="hidden"  value="<%=(errorclassid==null)?"":errorclassid%>">
        <img onclick="getThisTree('k240')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>      
     </tr>
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
      	<input  id="qcserviceclassName" name="qcserviceclassName" type="text" readOnly onclick=""   value="<%=(qcserviceclassName==null)?"":qcserviceclassName%>">
				<input  id="qcserviceclassid" name="9_Str_t1.qcserviceclassid" type="hidden"  onclick=""   value="<%=(qcserviceclassid==null)?"":qcserviceclassid%>">
        <img onclick="getThisTree('K270')" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>      
    <tr >

      <td > �ʼ��ʶ </td>
      <td >
				<select name="10_=_t1.flag" id="flag" size="1" >
      	 	<option value="" selected >5-ȫ��</option>
					<option value="0" <%="0".equals(flag)?"selected":""%>>0-��ʱ����</option>
					<option value="1" <%="1".equals(flag)?"selected":""%>>1-���ύ</option>
					<option value="2" <%="2".equals(flag)?"selected":""%>>2-���ύ���޸�</option>
					<option value="3" <%="3".equals(flag)?"selected":""%>>3-��ȷ��</option>
					<option value="4" <%="4".equals(flag)?"selected":""%>>4-����</option>
        </select> 
      </select> 
      </td> 

      <td > �ƻ����� </td>
      <td >
				<select name="11_=_t1.outplanflag" id="outplanflag" size="1" >
      	 	<option value="" selected >2-ȫ��</option>
          <option value="0" <%="0".equals(outplanflag)?"selected":""%>>0-�ƻ����ʼ�</option>
					<option value="1" <%="1".equals(outplanflag)?"selected":""%>>1-�ƻ����ʼ�</option>
        </select> 
      </select>
      </td> 

      <td > ���˱�ʶ </td>
      <td >
				<select name="12_<>_t1.checkflag" id="checkflag" size="1" >
      	 	<option value="" selected >2-ȫ��</option>
					<option value="0" <%="0".equals(checkflag)?"selected":""%>>0-δ����</option>
					<option value="1" <%="1".equals(checkflag)?"selected":""%>>1-�Ѹ���</option>
        </select> 
      </td> 

      <td > ����ȼ� </td>
      <td >
				<select name="calLevel" id="calLevel" size="1"  >
      	 	<option value="" >--���м���ȼ�--</option>
        </select>
      </td>                   
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px">
        <input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;">
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
	
			 <!--input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
       <input name="exportAll" type="button"  id="add" value="����ȫ��" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('all')\"");%>-->
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
        <a href="#" onClick="doLoad('first');return false;">��ҳ</a>
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
			  <input type="hidden" name="sqlWhere" value="">
          <tr >
            
            <th align="center" class="blue" width="5%" > ���۶��󹤺� </th>      
            <th align="center" class="blue" width="5%" > ���۶������� </th>
            
            
            
            <th align="center" class="blue" width="5%" > ����������Ա </th>
            <th align="center" class="blue" width="5%" > ������ </th>
            <th align="center" class="blue" width="5%" > �÷� </th>
            
            
           
            
            <th align="center" class="blue" width="5%" > ���� </th>
           
             
            <th align="center" class="blue" width="5%" > ����ʱ�� </th>
            
           
          </tr>
<% 
          	for ( int i = 0; i < dataRows.length; i++ ) {
                if("2".equals(dataRows[i][34])&&!"3".equals(dataRows[i][34])){
                  isModifyed = true;
                }
             }
%>
<%
           for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
%>
<%
	          if((i+1)%2==1){
	          tdClass="grey";
%>
          	<tr onClick="changeColor('<%=tdClass%>',this);"  >
<%
						}else{
%>
	   				<tr onClick="changeColor('<%=tdClass%>',this);"  >
<%
					}
%>


 
      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td> 
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"0"%></td>  
      
       
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][16].length()!=0)?dataRows[i][16]:"&nbsp;"%></td>
      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][21].length()!=0)?dataRows[i][21]:"&nbsp;"%></td>      
      
    </tr>
<%
       } 
%>
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

