<%
  /*
   * ����: �����ʼ�����ѯ����
�� * �汾: 1.0
�� * ����: 2009/09/08
�� * ����: guozw
�� * ��Ȩ: sitech
 ��*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%
    String expFlag      = request.getParameter("exp");               //�жϵ�����ǰҳ���ǵ���ȫ��
    String pageFlag     = request.getParameter("flag");              //�ж��ǵ���ȫ�����ǵ��뵱ǰҳ
    String seq          = request.getParameter("seq");               //�����û�ѡ��״̬����
    String loginNo      = (String)session.getAttribute("workNo");
    String strseq       = "";
    String headName     = request.getParameter("headName");
    int rowCount        = 0;
    int pageSize        = 15;            // Rows each page
    int pageCount       = 0;             // Number of all pages
    int curPage         = 0;             // Current page
    String strPage;                      // ��Ҫ�ӵ�ǰ��һҳ�洫����
    String stautsflag   = request.getParameter("stautsflag");  // �����û�ѡ��״̬
    
    String sql          = request.getParameter("sql");               //��ѡ�е����ֶ�ת�����ɵ�sql���
	String sqlFilter    = request.getParameter("sqlFilter");         //��ѯҳ��ļ�������    
    //������㵼�������ļ�¼����
	String sqlGetCount = "SELECT count(*) count FROM dqcinfo t1 " + sqlFilter + " AND t1.is_del='N'"; 
	
    //��δ��ҳ�ĵ������ݲ�ѯ���    
	String sqlStr = "SELECT " + sql + " FROM dqcinfo t1 " + sqlFilter + 
	                " AND t1.is_del='N' ORDER BY t1.starttime DESC";

    String statusSql = "select t.field_id from DCALLEXPSTATUS t where t.boss_login_no='"+loginNo+"'and  t.op_code='K212'";
	String[] strHead =null;
	String head[]=null;
	String excelName="�ʼ�����ѯ";
	int intMaxRow = 5000+1;
	if(headName!=null){
		if(!"".equalsIgnoreCase(headName)){
			head =headName.split(",");
			strHead =new String[head.length];
			for (int i = 0; i < head.length; i++) {
				strHead[i]=head[i];
			}
		}
	}
%>

<%
	//��һ������ҳ�棬��ȡ�ϴ�ѡ�м�¼
	if("cur".equalsIgnoreCase(pageFlag) || "all".equalsIgnoreCase(pageFlag)){
%>
		<wtc:service name="s151Select" outnum="1">
		<wtc:param value="<%=statusSql%>"/>
		</wtc:service>
		<wtc:row id="row" length="1">
<%
		strseq=row[0];
		if(!"".equalsIgnoreCase(strseq)){
			stautsflag="Y";
		}
%>
		</wtc:row>
<%
	}
%>

<%
	if("cur".equalsIgnoreCase(expFlag)){ //������ǰ��ʾ����
%>
		<wtc:service name="s151Select" outnum="1">
		<wtc:param value="<%=sqlGetCount%>"/>
		</wtc:service>
		<wtc:array id="rowCountList"  scope="end"/>
<%
		if(rowCountList.length != 0){
			rowCount = Integer.parseInt(rowCountList[0][0]);
		}
	      
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
          	curPage = 1;
        }else {
			curPage = Integer.parseInt(strPage);
			if( curPage < 1 ) curPage = 1;
        }
        
        pageCount = (rowCount + pageSize - 1) / pageSize;
        if (curPage > pageCount){
        	curPage = pageCount;
        }
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>
		<wtc:service name="s151Select" outnum="37">
		<wtc:param value="<%=querySql%>"/>
		</wtc:service>
		<wtc:array id="queryList" start="0" length="36" scope="end"/>

<%
		XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
		out.print("<script language='javascript'>window.close();</script>");
	}
   
	if("all".equalsIgnoreCase(expFlag)){//����ȫ��
		int expAllCount = 0;//����������ȫ����¼��
%>
		<wtc:service name="s151Select" outnum="3">
			<wtc:param value="<%=sqlGetCount%>"/>
		</wtc:service>
		<wtc:array id="countList" scope="end"/>
<%
		
		if(countList.length > 0){
			expAllCount = Integer.parseInt(countList[0][0]);
		}
		if(expAllCount < 2000){ //С��2000ֱ�ӵ���
%>
			<wtc:service name="s151Select" outnum="37">
			<wtc:param value="<%=sqlStr%>"/>
			</wtc:service>
			<wtc:array id="queryList" start="0" length="36" scope="end"/>
<%
			XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
			out.print("<script language='javascript'>window.close();</script>");
		}else if(expAllCount >= 2000 && expAllCount <= 50000){ //����2000ʱ��������ѯ������ƴ�ӵ�һ��Excel�ļ���
			String[][] dataRows = new String[expAllCount][];
			int n = 0;//�������ݷ�n�ν��в���
			if(expAllCount % 1999 == 0){
				n = expAllCount / 1999;
			}else{
				n = expAllCount / 1999 + 1;
			}
			String sqlStrSum = "";
			for(int a = 0; a < n; a++){
				if(a == n - 1){
					sqlStrSum = "SELECT * FROM (SELECT ROWNUM rnm, aa.* FROM (" + sqlStr + ") aa WHERE ROWNUM <= " + 
					            expAllCount + ") WHERE rnm >= " + (a * 1999 + 1);				
				}else{
					sqlStrSum = "SELECT * FROM (SELECT ROWNUM rnm, aa.* FROM (" + sqlStr + ") aa WHERE ROWNUM <= " + 
					            (( a + 1) * 1999) + ") WHERE rnm >= " + (a * 1999 + 1);					
				}
				//sqlStrSum = "SELECT * FROM (SELECT ROWNUM rnm, aa.* FROM (" + sqlStr + ") aa WHERE ROWNUM <= " + 
				//            (( a + 1) * 1999) + ") WHERE rnm >= " + (a * 1999 + 1);
				//sqlStrSum = "SELECT * FROM (SELECT ROWNUM rnm, aa.* FROM (" + sqlStr + ") aa WHERE ROWNUM <= " + 
				//            (a * 1999 + 1 + 1999) + ") WHERE rnm >= " + (a * 1999 + 1);
%>
				<wtc:service name="s151Select" outnum="37">
					<wtc:param value="<%=sqlStrSum%>"/>
				</wtc:service>
				<wtc:array id="queryList" start="0" length="36" scope="end"/>
<%				
				System.arraycopy(queryList, 0, dataRows, a*1999, queryList.length);
			}
			XLSExport.toExcel(strHead,dataRows,intMaxRow,excelName,response);
			out.print("<script language='javascript'>window.close();</script>");
		}else if(expAllCount > 50000){
			out.println("<font color='red'>һ�����ɵ���5��������</font>");		
		}
	}
	//�����û�ѡ�����
	if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
		String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no='"+loginNo+"' and t.op_code='K212'";
		String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values('"+loginNo+"','K212','"+seq+"',sysdate)";
		List sqlList=new ArrayList();
		String[] sqlArr = new String[]{};
		if("Y".equalsIgnoreCase(stautsflag)){
			sqlList.add(deleteStatus);
		}
		sqlList.add(insertStatus);
		sqlArr = (String[])sqlList.toArray(new String[0]);
		String outnum = String.valueOf(sqlArr.length + 1);
%>
		<wtc:service name="sPubModify"  outnum="<%=outnum%>">
		<wtc:params value="<%=sqlArr%>"/>
		<wtc:param value="dbcall"/>
		</wtc:service>
		<wtc:array id="retRows"  scope="end"/>
<%
   }
%>

<html>
<head>
<title>�����ʼ�����ѯ����</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">�����б�</div></div>
<div id="title_zi">
<input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>ȫѡ/ȡ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="t1.serialnum" value="��ˮ��" onclick="judgeCheckAll('area[]')"/>��ˮ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="t1.recordernum" value="������ˮ��" onclick="judgeCheckAll('area[]')"/>������ˮ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="t1.staffno" value="���칤��" onclick="judgeCheckAll('area[]')"/>���칤��<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="t1.login_name" value="����Ա����" onclick="judgeCheckAll('area[]')"/>����Ա����<br>
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="''" value="Ա������" onclick="judgeCheckAll('area[]')"/>Ա������<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="(SELECT object_name FROM dqcobject WHERE object_id = t1.objectid)" value="�������" onclick="judgeCheckAll('area[]')"/>�������<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="decode(t1.flag,'0','��ʱ����','1','���ύ','2','���ύ���޸�','3','��ȷ��','4','����')" value="�ʼ��ʶ" onclick="judgeCheckAll('area[]')"/>�ʼ��ʶ<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="t1.evterno" value="�ʼ칤��" onclick="judgeCheckAll('area[]')"/>�ʼ칤��<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="(SELECT name FROM dqccheckcontect WHERE object_id=t1.objectid AND contect_id=t1.contentid)" value="��������" onclick="judgeCheckAll('area[]')"/>��������<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="decode(to_char(t1.score),'','0',null,'0',t1.score)" value="�ܵ÷�" onclick="judgeCheckAll('area[]')"/>�ܵ÷�<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="decode(to_char(t1.outplanflag),'0','�ƻ����ʼ�','1',' �ƻ����ʼ�')" value="�ƻ�����" onclick="judgeCheckAll('area[]')"/>�ƻ�����<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="t1.contentlevelid" value="�ȼ�" onclick="judgeCheckAll('area[]')"/>�ȼ�<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="t1.errorclassdesc" value="������" onclick="judgeCheckAll('area[]')"/>������<br>
<input name="area[]" type="checkbox" id="area[]" seq="13" sql="t1.errorleveldesc" value="���ȼ�" onclick="judgeCheckAll('area[]')"/>���ȼ�<br>
<input name="area[]" type="checkbox" id="area[]" seq="14" sql="t1.contentinsum" value="���ݸ���" onclick="judgeCheckAll('area[]')"/>���ݸ���<br>
<input name="area[]" type="checkbox" id="area[]" seq="15" sql="t1.handleinfo" value="�������" onclick="judgeCheckAll('area[]')"/>�������<br>
<input name="area[]" type="checkbox" id="area[]" seq="16" sql="t1.improveadvice" value="�Ľ�����" onclick="judgeCheckAll('area[]')"/>�Ľ�����<br>
<input name="area[]" type="checkbox" id="area[]" seq="17" sql="t1.abortreasondesc" value="����ԭ��" onclick="judgeCheckAll('area[]')"/>����ԭ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="18" sql="decode(t1.kind,'0','�Զ�����','1','�˹�ָ��')" value="������ʽ" onclick="judgeCheckAll('area[]')"/>������ʽ<br>
<input name="area[]" type="checkbox" id="area[]" seq="19" sql="decode(t1.checktype,'0','ʵʱ�ʼ�','1','�º��ʼ�')" value="�������" onclick="judgeCheckAll('area[]')"/>�������<br>
<input name="area[]" type="checkbox" id="area[]" seq="20" sql="t1.serviceclassdesc" value="ҵ�����" onclick="judgeCheckAll('area[]')"/>ҵ�����<br>
<input name="area[]" type="checkbox" id="area[]" seq="21" sql="to_char(t1.starttime,'yyyy-MM-dd hh24:mi:ss')" value="�ʼ쿪ʼʱ��" onclick="judgeCheckAll('area[]')"/>�ʼ쿪ʼʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="22" sql="to_char(t1.endtime,'yyyy-MM-dd hh24:mi:ss')" value="�ʼ����ʱ��" onclick="judgeCheckAll('area[]')"/>�ʼ����ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="23" sql="decode(to_char(t1.dealduration),'','0',null,'0',t1.dealduration)" value="����ʱ��" onclick="judgeCheckAll('area[]')"/>����ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="24" sql="decode(to_char(t1.lisduration),'','0',null,'0',t1.lisduration)" value="��������ʱ��" onclick="judgeCheckAll('area[]')"/>��������ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="25" sql="decode(to_char(t1.arrduration),'','0',null,'0',t1.arrduration)" value="����ʱ��" onclick="judgeCheckAll('area[]')"/>����ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="26" sql="decode(to_char(t1.evtduration),'','0',null,'0',t1.evtduration)" value="�ʼ���ʱ��" onclick="judgeCheckAll('area[]')"/>�ʼ���ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="27" sql="t1.signataryid" value="ȷ����" onclick="judgeCheckAll('area[]')"/>ȷ����<br>
<input name="area[]" type="checkbox" id="area[]" seq="28" sql="to_char(t1.affirmtime,'yyyy-MM-dd hh24:mi:ss')" value="ȷ������" onclick="judgeCheckAll('area[]')"/>ȷ������<br>
<input name="area[]" type="checkbox" id="area[]" seq="29" sql="decode(t1.checkflag,'0','δ����','-1','δ����','1','�Ѹ���')" value="���˱�ʶ" onclick="judgeCheckAll('area[]')"/>���˱�ʶ<br>
<input name="area[]" type="checkbox" id="area[]" seq="30" sql="t1.commentinfo" value="��������" onclick="judgeCheckAll('area[]')"/>��������<br>
<input name="area[]" type="checkbox" id="area[]" seq="31" sql="decode(t1.vertify_passwd_flag,'Y','��','N','��','','��',NULL,'��')" value="�Ƿ�������֤" onclick="judgeCheckAll('area[]')"/>�Ƿ�������֤<br>


<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="headName" value="">
<input type="hidden" name="sql" value="">
<input type="hidden" name="stautsflag" value="stautsflag">
<input type="hidden" name="seq" value="">
<input type="button" name="expbutton" value="����" class="b_text" onclick="s_exp('area[]')"/>
<input type="button" name="expclose" value="�ر�" class="b_text" onclick="window.close();"/>
</div>
</p>
</div>
</form>
</body>
</html>

<script language="javascript" type="text/javascript">
$(document).ready(
	function(){
		$("td").not("[input]").addClass("blue");
		$("#footer input:button").addClass("b_foot");
		$("td:not(#footer) input:button").addClass("b_text");
		$("input:text[@v_type]").blur(checkElement2);
		$("a").hover(function() {$(this).css("color", "orange");}, 
					 function() {$(this).css("color", "blue");});
	}
);

function checkElement2() {
	checkElement(this);
}

 function s_all(x){
 	var tmpCheck = document.getElementById("checkAll");
  var inps = document.getElementsByName(x);
  if(tmpCheck.checked==true){
  	for(var i=0;i<inps.length;i++){
  		inps[i].checked = true;
  	}
  }
  if(tmpCheck.checked==false){
  	for(var i=0;i<inps.length;i++){
  		inps[i].checked = false;
  	}
  }
 }

 //��ȫѡ��ȥ��ĳ��ѡ����,��ȫѡ������ zengzq add
 function judgeCheckAll(x){
 	var tmpCheck = document.getElementById("checkAll");
 	var inps = document.getElementsByName(x);
 	var count = 0;
 		for(var i=0;i<inps.length;i++){
  		if(inps[i].checked == false){
  			tmpCheck.checked = false;
  			count++ ;
  		}
  	}
  	if(count==0){
  			tmpCheck.checked = true;
  	}
 }

 //�ж�һ���ַ����Ƿ������г���
function isStr(str,strArr){
	if(strArr!=null&&strArr!=''){
		for(var j=0;j<strArr.length;j++){
     		if(str==strArr[j]){
     			return true;
     		}
		}
	}
	return false;
}
//�����û��ϻ�����״̬
 function setStauts(){
  var inps = document.forms['sitechform'].elements['area[]'];
  var arrid ="<%=strseq%>";
  var temarr=new Array();
  //zengzq add
  var count = 0;
  if(arrid!=''){
  	temarr=arrid.split(",");
  	for(var i=0;i<inps.length;i++){
	   	if(isStr(inps[i].seq,temarr)){
	   	inps[i].checked=true;
	   	//zengzq add
	   	count++;
	   	}
  	}
  	//����ϴ�ȫѡ,��˴ν�"ȫѡ/ȡ��"��ѡ zengzq add
  	if(inps.length==count){
  			document.getElementById('checkAll').checked = true;
  	} else{
  			document.getElementById('checkAll').checked = false;
  	}
 }
 }
 setStauts();

/**
  *����ȫ��
  */
function s_exp(x){
	var head=getCheckboxValue();
	var sql=getCheckboxSql();
	var seq=getCheckboxSeq();
	var stautsflag="<%=stautsflag%>";
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	window.sitechform.page.value = opener.document.sitechform.page.value;
	window.sitechform.headName.value = head;
	window.sitechform.sql.value = sql;
	window.sitechform.seq.value = seq;
	window.sitechform.stautsflag.value = stautsflag;
	if(head==''){
		return;
	}
	temSql="select " + sql + "from dqcinfo t1,dqcobject t3,dqccheckcontect t4,dual t5 "+ window.sitechform.sqlFilter.value;
	submitExp(expFlag);
}

function submitExp(str){
	window.sitechform.action="k212_expSelect.jsp?exp="+str;
	window.sitechform.method='post';
	window.sitechform.submit();
}
 	
function getCheckboxValue(){
   var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox')
	{ return (checkbox.checked)?checkbox.value:''; }

	if (checkbox[0].tagName.toLowerCase() != 'input' ||
		checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked)
		{
			val[val.length] = checkbox[i].value;
		}
	}

	return (val.length)?val:'';
}

/**
  *����ѡ�е��ֶ����ɼ����ֶ�SQL���
  */
function getCheckboxSql(){
	var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox'){ 
		return (checkbox.checked)?checkbox.value:''; 
	}

	if (checkbox[0].tagName.toLowerCase() != 'input' || checkbox[0].type.toLowerCase() != 'checkbox'){ 
		return ''; 
	}

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++){
		if (checkbox[i].checked){
			val[val.length] = checkbox[i].sql;
		}
	}
	return (val.length)?val:'';
}

function getCheckboxSeq()
{
   var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox')
	{ return (checkbox.checked)?checkbox.value:''; }

	if (checkbox[0].tagName.toLowerCase() != 'input' ||
		checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked)
		{
			val[val.length] = checkbox[i].seq;
		}
	}

	return (val.length)?val:'';
}
 </script>