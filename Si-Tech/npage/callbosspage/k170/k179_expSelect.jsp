<%
  /*
   * ����: ���б��ּ�¼����
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
<%
	String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
	String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
	String sqlMulKfCfm="";
	
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
     /*midify by yinzx 20091113 ������ѯ�����滻*/
    String myParams=request.getParameter("para");
    String myParamsExp="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	   //�ж��ǵ���ȫ�����ǵ��뵱ǰҳ
    String sqlFilter = request.getParameter("sqlFilter");
    String loginNo = (String)session.getAttribute("workNo");  
    String sql=request.getParameter("sql");
    String seq=request.getParameter("seq");// �����û�ѡ��״̬����
    String strseq="";                     // new
    String headName=request.getParameter("headName");
    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // ��Ҫ�ӵ�ǰ��һҳ�洫����
    String sqlTemp ="";
    String sqlStr ="";
    String stautsflag=request.getParameter("stautsflag");  // �����û�ѡ��״̬����
		String strCountSql="select to_char(count(*)) count  from dcallhangup t1, dcallcall";
	  String strOrderSql=" order by t1.begin_time desc ";
	  //����sql
	  String statusSql="select t.field_id from DCALLEXPSTATUS t where t.boss_login_no=:loginNo and  t.op_code='K179'";
	  myParamsExp="loginNo="+loginNo;
	  String[] strHead =null;
	  String head[]=null;
	  String excelName="���б��ּ�¼";
	  int intMaxRow=5000+1;
	  if(headName!=null){
	  if(!"".equalsIgnoreCase(headName)){
	   head =headName.split(",");
	   strHead =new String[head.length];
	  for (int i = 0; i < head.length; i++) {
	    strHead[i]=head[i];
      }
    }
	  }        
	  
	  sqlStr+="select "+sql+" from dcallhangup t1, staffhangup t3,dcallcall"+sqlFilter+" and t2.staffhangup=t3.hangup_code(+)"+strOrderSql;
%>	
			
<%	
   //��һ������ҳ�棬��ȡ�ϴ�ѡ�м�¼
   if("cur".equalsIgnoreCase(pageFlag)||"all".equalsIgnoreCase(pageFlag)){
%>
         <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
					<wtc:param value="<%=statusSql%>"/>
				  <wtc:param value="<%=myParamsExp%>"/>
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
   //������ǰ��ʾ���� 
   if("cur".equalsIgnoreCase(expFlag)){    
       sqlTemp =strCountSql+sqlFilter;
    	  %>	             
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myParams%>"/>
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
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="13">
					<wtc:param value="<%=querySql%>"/>
					<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="12"   scope="end"/>
				<%
				XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
%>		           
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="12">
					<wtc:param value="<%=sqlStr%>"/>
					<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="12"   scope="end"/>
<%
        XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
				//out.print("<script language='javascript'>window.close();</script>");		
   }
//�����û�ѡ�����  
if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){

	String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K179'&&"+loginNo;
	String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K179',:v2,sysdate)&&"+loginNo+"^"+seq;

List sqlList=new ArrayList();
String[] sqlArr = new String[]{};
if("Y".equalsIgnoreCase(stautsflag)){
sqlList.add(deleteStatus);
}
		     sqlList.add(insertStatus);
		     sqlArr = (String[])sqlList.toArray(new String[0]);
String outnum = String.valueOf(sqlArr.length + 1);      
%>
	
			<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
			<wtc:param value="<%=sqlMulKfCfm%>"/>
			<wtc:param value="dbchange"/>
			<wtc:params value="<%=sqlArr%>"/>
			</wtc:service>
			<wtc:array id="retRows"  scope="end"/>	
<%}%>

<html>
<head>
<title>���б��ֵ���</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">�����б�</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>ȫѡ/ȡ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="t1.contact_id" value="��ˮ��" onclick="judgeCheckAll('area[]')"/>��ˮ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="t2.cust_name" value="�ͻ�����" onclick="judgeCheckAll('area[]')"/>�ͻ�����<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="t2.accept_phone" value="�������" onclick="judgeCheckAll('area[]')"/>�������<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="t2.caller_phone" value="���к���" onclick="judgeCheckAll('area[]')"/>���к���<br> 
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="to_char(t2.begin_date,'yyyy-MM-dd hh24:mi:ss')" value="����ʱ��" onclick="judgeCheckAll('area[]')"/>����ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="to_char(t2.accept_long)" value="����ʱ��" onclick="judgeCheckAll('area[]')"/>����ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="t2.accept_login_no" value="������" onclick="judgeCheckAll('area[]')"/>������<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="t3.hangup_name" value="�һ���" onclick="judgeCheckAll('area[]')"/>�һ���<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="decode(t2.qc_flag,'Y','��','N','��','','��',NULL,'��')" value="�Ƿ��ʼ�" onclick="judgeCheckAll('area[]')"/>�Ƿ��ʼ�<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="decode(trim(t1.op_type),'1','����','2','�ڲ�����')" value="��������" onclick="judgeCheckAll('area[]')"/>��������<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="to_char(t1.begin_time,'yyyy-MM-dd hh24:mi:ss')" value="��ʼʱ��" onclick="judgeCheckAll('area[]')"/>��ʼʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="to_char(t1.end_time,'yyyy-MM-dd hh24:mi:ss')" value="����ʱ��" onclick="judgeCheckAll('area[]')"/>����ʱ��<br>
<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="para" value="">
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
function s_exp(x){
	var head=getCheckboxValue();
	var sql=getCheckboxSql();
  //����start
	var seq=getCheckboxSeq();
	var stautsflag="<%=stautsflag%>";
	//����end
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	window.sitechform.page.value = opener.document.sitechform.page.value;
	window.sitechform.para.value = opener.document.sitechform.para.value;
  window.sitechform.headName.value = head;
  window.sitechform.sql.value = sql;
  //����start
  window.sitechform.seq.value = seq;
  window.sitechform.stautsflag.value = stautsflag;
  //����end
    if(head==''){
   	return;
   	}
   	temSql="select "+sql+ "from dcallhangup t1, staffhangup t3,dcallcall"+ window.sitechform.sqlFilter.value;
    submitExp(expFlag);
 }
 function submitExp(str){
 	 window.sitechform.action="k179_expSelect.jsp?exp="+str;
 	 window.sitechform.method='post';
   window.sitechform.submit(); 
 	}
function getCheckboxValue()
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
			val[val.length] = checkbox[i].value;
		}
	}
	
	return (val.length)?val:'';
}
function getCheckboxSql()
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
