<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: �޸ļ�¼��ѯ����
�� * �汾: 1.0
�� * ����: 2009/01/09
�� * ����: zengzq
�� * ��Ȩ: sitech
   *
   *
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%
	String expFlag = request.getParameter("exp");
	String pageFlag = request.getParameter("flag");
	 //�ж��ǵ���ȫ�����ǵ��뵱ǰҳ
	String sqlFilter = request.getParameter("sqlFilter");
	String sql=request.getParameter("sql");
	String loginNo = (String)session.getAttribute("workNo");
	String seq=request.getParameter("seq");// �����û�ѡ��״̬����
	String strseq="";
	String headName=request.getParameter("headName");
	String[][] dataRows = new String[][]{};
	//20091120 �󶨱�������
	int start=0;
	int end=0;
	String start_date    =  request.getParameter("start_date");
	String end_date      =  request.getParameter("end_date");
	String mod_start_date    =  request.getParameter("mod_start_date");
	String mod_end_date      =  request.getParameter("mod_end_date");
	String staffno       =  request.getParameter("staffno");
	String evterno       =  request.getParameter("evterno");
	String serialnum     =  request.getParameter("serialnum");
	String modevterno    =  request.getParameter("modevterno");
	String contact_id =  request.getParameter("contact_id");
	String[][] queryList = new String[][] {};

	int rowCount =0;
	int pageSize = 15;            // Rows each page
	int pageCount=0;               // Number of all pages
	int curPage=0;                 // Current page
	String strPage;               // ��Ҫ�ӵ�ǰ��һҳ�洫����
	String sqlTemp ="";
	String sqlStr ="";
	String stautsflag=request.getParameter("stautsflag");  // �����û�ѡ��״̬����

	HashMap pMap=new HashMap();
	pMap.put("op_code", "K213");
	pMap.put("sqlstr",sql);
	pMap.put("boss_login_no", loginNo);
	pMap.put("starttime", start_date);
	pMap.put("endtime", end_date);
	pMap.put("modstarttime", mod_start_date);
	pMap.put("modendtime", mod_end_date);
	pMap.put("staffno", staffno);
	pMap.put("evterno", evterno);
	pMap.put("serialnum", serialnum);
	pMap.put("modevterno", modevterno);
	pMap.put("contact_id", contact_id);

	String[] strHead =null;
	String head[]=null;
	String excelName="�޸ļ�¼��ѯ";
	int intMaxRow=5000;
	if(headName!=null){
		if(!"".equalsIgnoreCase(headName)){
			head =headName.split(",");
			strHead =new String[head.length];
			for (int i = 0; i < head.length; i++) {
				strHead[i]=head[i];
			}
		}
	}

	  sqlStr+="select "+sql+" from dqcmodinfo m, dqcmodinfo n"+sqlFilter;
%>
<%
    //��һ������ҳ�棬��ȡ�ϴ�ѡ�м�¼
   if("cur".equalsIgnoreCase(pageFlag)||"all".equalsIgnoreCase(pageFlag)){
   		  List iDataList3 =(List)KFEjbClient.queryForList("dcallexpstatus",pMap);
		    queryList = getArrayFromListMap(iDataList3 ,0,1);
		    if(queryList.length!=0){
				strseq=queryList[0][0];
			}
			if(!"".equalsIgnoreCase(strseq)){
				stautsflag="Y";
			}
	}

   //������ǰ��ʾ����
   if("cur".equalsIgnoreCase(expFlag)){
		rowCount = ( ( Integer )KFEjbClient.queryForObject("query_k213_qcModifyRec_strCountSql",pMap)).intValue();

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
        start = (curPage - 1) * pageSize + 1;
		end = curPage * pageSize;
		pMap.put("start", ""+start);
		pMap.put("end", ""+end);
		List queryList1 =(List)KFEjbClient.queryForList("exp_k213_qcModifyRec_cur",pMap);
        queryList = getArrayFromListMap(queryList1 ,1,22);
		XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
		  List iDataList2 =(List)KFEjbClient.queryForList("exp_k213_qcModifyRec_all",pMap);
		  queryList = getArrayFromListMap(iDataList2 ,0,21);

          XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
		  out.print("<script language='javascript'>window.close();</script>");
	}

			//�����û�ѡ�����
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K213'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K213',:v2,sysdate)&&"+loginNo+"^"+seq;
			List sqlList=new ArrayList();
			String[] sqlArr = new String[]{};

			if("Y".equalsIgnoreCase(stautsflag)){
					sqlList.add(deleteStatus);
			}
      sqlList.add(insertStatus);
      sqlArr = (String[])sqlList.toArray(new String[0]);
			String outnum = String.valueOf(sqlArr.length + 1);
			//jiangbing 20091118 ���������滻
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2);
String sqlMulKfCfm="";
%>

<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
<%
   }
%>


<html>
<head>
<title>�޸ļ�¼��ѯ����</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">�����б�</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>ȫѡ/ȡ��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="11" sql="m.updatechoose" value="�޸�ѡ��" onclick="judgeCheckAll('area[]')" />�޸�ѡ��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="0" sql="m.recordernum" value="������ˮ��" onclick="judgeCheckAll('area[]')" />������ˮ��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="1" sql="m.serialnum" value="�ʼ�����ˮ��" onclick="judgeCheckAll('area[]')" />�ʼ�����ˮ��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="2" sql="(select o.object_name from dqcobject o where o.object_id = m.objectid) objectName" value="�������" onclick="judgeCheckAll('area[]')" />�������<br>
		<input name="area[]" type="checkbox" id="area[]" seq="3" sql="(select c.name from dqccheckcontect c where c.object_id = m.objectid and c.contect_id = m.contentid) contentName" value="�ʼ�����" onclick="judgeCheckAll('area[]')" />�ʼ�����<br>
		<input name="area[]" type="checkbox" id="area[]" seq="4" sql="m.modevterno" value="�޸���" onclick="judgeCheckAll('area[]')" />�޸���<br>
		<input name="area[]" type="checkbox" id="area[]" seq="5" sql="m.staffno" value="���칤��" onclick="judgeCheckAll('area[]')" />���칤��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="6" sql="m.evterno" value="�ʼ칤��" onclick="judgeCheckAll('area[]')" />�ʼ칤��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="7" sql="n.score oldScore" value="ԭ���÷�" onclick="judgeCheckAll('area[]')" />ԭ���÷�<br>
		<input name="area[]" type="checkbox" id="area[]" seq="8" sql="m.score newScore" value="�޸ĵ÷�" onclick="judgeCheckAll('area[]')" />�޸ĵ÷�<br>
		<input name="area[]" type="checkbox" id="area[]" seq="9" sql="n.errorleveldesc oldLevel" value="ԭ���ȼ�" onclick="judgeCheckAll('area[]')" />ԭ���ȼ�<br>
		<input name="area[]" type="checkbox" id="area[]" seq="10" sql="m.errorleveldesc newLevel" value="�޸ĵȼ�" onclick="judgeCheckAll('area[]')" />�޸ĵȼ�<br>
		<input name="area[]" type="checkbox" id="area[]" seq="12" sql="to_char(m.starttime,'yyyy-mm-dd hh24:mi:ss') starttime" value="�ʼ쿪ʼʱ��" onclick="judgeCheckAll('area[]')" />������ʼʱ��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="13" sql="to_char(m.endtime,'yyyy-mm-dd hh24:mi:ss') endtime" value="�ʼ����ʱ��" onclick="judgeCheckAll('area[]')" />��������ʱ��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="14" sql="to_char(m.modtime,'yyyy-mm-dd hh24:mi:ss') modtime" value="�޸�ʱ��" onclick="judgeCheckAll('area[]')" />�޸�ʱ��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="15" sql="decode(to_char(m.dealduration), '', '0', null, '0', m.dealduration) dealduration" value="����ʱ��" onclick="judgeCheckAll('area[]')" />����ʱ��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="16" sql="decode(to_char(m.lisduration), '', '0', null, '0', m.lisduration) lisduration" value="����ʱ��" onclick="judgeCheckAll('area[]')" />����ʱ��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="17" sql="decode(to_char(m.arrduration), '', '0', null, '0', m.arrduration) arrduration" value="����ʱ��" onclick="judgeCheckAll('area[]')" />����ʱ��<br>
		<input name="area[]" type="checkbox" id="area[]" seq="18" sql="decode(to_char(m.evtduration), '', '0', null, '0', m.evtduration) evtduration" value="�ʼ���ʱ��" onclick="judgeCheckAll('area[]')" />�ʼ���ʱ��<br>

		<input name="start_date" type="hidden" value="">
		<input name="end_date" type="hidden" value="">
		<input name="mod_start_date" type="hidden" value="">
		<input name="mod_end_date" type="hidden" value="">
		<input name="staffno" type="hidden" value="">
		<input name="evterno" type="hidden" value="">
		<input name="serialnum" type="hidden" value="">
		<input name="modevterno" type="hidden" value="">
		<input name="contact_id" type="hidden" value="">

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
	  var count = 0;
	  if(arrid!=''){
	  		temarr=arrid.split(",");
					for(var i=0;i<inps.length;i++){
							if(isStr(inps[i].seq,temarr)){
									inps[i].checked=true;
							}
					}
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

	    //20091120 �󶨱�������
    	window.sitechform.start_date.value = opener.sitechform.start_date.value;
    	window.sitechform.end_date.value = opener.sitechform.end_date.value;
    	window.sitechform.mod_start_date.value = opener.sitechform.mod_start_date.value;
    	window.sitechform.mod_end_date.value = opener.sitechform.mod_end_date.value;
    	window.sitechform.staffno.value = opener.sitechform.staffno.value;
    	window.sitechform.evterno.value = opener.sitechform.evterno.value;
    	window.sitechform.serialnum.value = opener.sitechform.serialnum.value;
    	window.sitechform.modevterno.value = opener.sitechform.modevterno.value;
    	window.sitechform.contact_id.value = opener.sitechform.contact_id.value;
		//:~
	    if(head==''){
	   	return;
	   	}
	   	temSql="select "+sql+ " from dqcmodinfo m, dqcmodinfo n "+ window.sitechform.sqlFilter.value;
	   submitExp(expFlag);
}

function submitExp(str){
		window.sitechform.action="k213_expSelect.jsp?exp="+str;
		window.sitechform.method='post';
		window.sitechform.submit();
}

function getCheckboxValue(){
	  var checkbox=document.forms['sitechform'].elements['area[]'];
		if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') {
				return (checkbox.checked)?checkbox.value:'';
		}

		if (checkbox[0].tagName.toLowerCase() != 'input' ||
				checkbox[0].type.toLowerCase() != 'checkbox')
		{ return ''; }

		var val = [];
		var len = checkbox.length;

		for(i=0; i<len; i++){
				if (checkbox[i].checked){
						val[val.length] = checkbox[i].value;
				}
		}
		return (val.length)?val:'';
}

function getCheckboxSql(){
	  var checkbox=document.forms['sitechform'].elements['area[]'];
		if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') {
				return (checkbox.checked)?checkbox.value:'';
		}

		if (checkbox[0].tagName.toLowerCase() != 'input' ||
				checkbox[0].type.toLowerCase() != 'checkbox')
		{ return ''; }

		var val = [];
		var len = checkbox.length;

		for(i=0; i<len; i++){
				if (checkbox[i].checked){
						val[val.length] = checkbox[i].sql;
				}
		}

		return (val.length)?val:'';
}

function getCheckboxSeq(){
  var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') {
			return (checkbox.checked)?checkbox.value:'';
	}

	if (checkbox[0].tagName.toLowerCase() != 'input' ||
			checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++){
			if (checkbox[i].checked){
					val[val.length] = checkbox[i].seq;
			}
	}

	return (val.length)?val:'';
}
 </script>