<%
  /*
   * ����: ���ŷ��Ͳ�ѯ����
�� * �汾: 1.0
�� * ����: 2009/01/09
�� * ����: zengzq 
�� * ��Ȩ: sitech
   * update :liujied 20090930
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%
//jiangbing 20091118 ���������滻
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
    String sql=request.getParameter("sql");
    String loginNo = (String)session.getAttribute("workNo"); 
    String seq=request.getParameter("seq");// �����û�ѡ��״̬����
    String strseq=""; 
    String headName=request.getParameter("headName");
    String[][] dataRows = new String[][]{};
    //�󶨱����޸�
    int start=0;
    int end=0; 
    String start_date           =  request.getParameter("start_date");                 
    String end_date             =  request.getParameter("end_date");                   
    String user_phone           =  request.getParameter("user_phone");             
    String serial_no            =  request.getParameter("serial_no");               
    String pre_call_cause_id    =  request.getParameter("pre_call_cause_id");   
    String out_gateway_id   =  request.getParameter("gateway_id"); 
    String send_login_no    =  request.getParameter("send_login_no"); 
    String send_content     = request.getParameter("send_content");    
    
    
    
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // ��Ҫ�ӵ�ǰ��һҳ�洫����
    String sqlTemp ="";
    String sqlStr ="";
    String stautsflag=request.getParameter("stautsflag");  // �����û�ѡ��״̬����
    String strCountSql="select to_char(count(*)) count  from sms_push_rec_log";
    String[][] queryList = new String[][] {};
    		HashMap pMap=new HashMap();
    			pMap.put("op_code"        , "K181");
				pMap.put("boss_login_no", loginNo);
				pMap.put("sqlstr"         ,sql);
				pMap.put("start_date", start_date);
				pMap.put("end_date", end_date);
				pMap.put("user_phone", user_phone);
				pMap.put("serial_no",serial_no);
				pMap.put("pre_call_cause_id", pre_call_cause_id);
				pMap.put("out_gateway_id", out_gateway_id);
				pMap.put("send_login_no", send_login_no);
				pMap.put("send_content", send_content);
    
    
    //String strOrderSql=" order by send_time desc ";
    String statusSql="select t.field_id from DCALLEXPSTATUS t where t.boss_login_no=:loginNo and  t.op_code='K181'";
    myParamsExp="loginNo="+loginNo;
    String strOrderSql=" order by insert_time desc ";
	  String[] strHead =null;
	  String head[]=null;
	  String excelName="���ŷ��Ͳ�ѯ";
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
	  
	  sqlStr+="select "+sql+" from sms_push_rec_log"+sqlFilter+strOrderSql;
System.out.println("======at k181_expSelect.jsp===:"+sqlStr);
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
		rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K181_strCountSql",pMap)).intValue();
	      
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
		List queryList1 =(List)KFEjbClient.queryForList("query_K181_expcur",pMap); 
        queryList = getArrayFromListMap(queryList1 ,1,8);   
		XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   
  
   if("all".equalsIgnoreCase(expFlag)){
		  List iDataList2 =(List)KFEjbClient.queryForList("query_K181_expall",pMap);                              
		  queryList = getArrayFromListMap(iDataList2 ,0,8); 	
     
          XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
		  out.print("<script language='javascript'>window.close();</script>");		
	}
			//�����û�ѡ�����  
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K181'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K181',:v2,sysdate)&&"+loginNo+"^"+seq;
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
<%
   }   
%>


<html>
<head>
<title>���ŷ��Ͳ�ѯ����</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">�����б�</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>ȫѡ/ȡ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="to_char(serial_no)" value="��ˮ��" onclick="judgeCheckAll('area[]')" />��ˮ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="send_login_no" value="��½����" onclick="judgeCheckAll('area[]')" />��½����<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="user_phone" value="�绰����" onclick="judgeCheckAll('area[]')" />�绰����<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="insert_time" value="����ʱ��" onclick="judgeCheckAll('area[]')" />����ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="send_content" value="��������" onclick="judgeCheckAll('area[]')" />��������<br>
                             
<!--                                                      

<input name="area[]" type="checkbox" id="area[]" seq="0" sql="serial_no" value="��ˮ��" onclick="judgeCheckAll('area[]')" />��ˮ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="send_login_no" value="���͹���" onclick="judgeCheckAll('area[]')" />���͹���<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="user_phone" value="�û�����" onclick="judgeCheckAll('area[]')" />�û�����<br> 
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="to_char(send_time,'yyyy-MM-dd hh24:mi:ss')" value="�·�ʱ��" onclick="judgeCheckAll('area[]')" />�·�ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="send_url" value="�·�URL��ַ" onclick="judgeCheckAll('area[]')" />�·�URL��ַ<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="out_gateway_id" value="����ID" onclick="judgeCheckAll('area[]')" />����ID<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="send_content" value="��������" onclick="judgeCheckAll('area[]')" />��������<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="decode(trim(serv_type),'01','��ͨ����','03','WAP PUSH����')" value="��������" onclick="judgeCheckAll('area[]')" />��������<br>
-->

<input type="hidden" name="start_date"  value=""/>
<input type="hidden" name="end_date"  value=""/>
<input type="hidden" name="user_phone"  value=""/>
<input type="hidden" name="serial_no"  value=""/>
<input type="hidden" name="pre_call_cause_id"  value=""/>
<input type="hidden" name="out_gateway_id"  value=""/>
<input type="hidden" name="send_login_no"  value=""/>
<input type="hidden" name="send_content"  value=""/>


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
	var seq=getCheckboxSeq();
	var stautsflag="<%=stautsflag%>";
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	window.sitechform.page.value = opener.document.sitechform.page.value;
	window.sitechform.para.value = opener.document.sitechform.para.value;
    window.sitechform.headName.value = head;
    window.sitechform.sql.value = sql;
    window.sitechform.seq.value = seq;
    window.sitechform.stautsflag.value = stautsflag;
  
	window.sitechform.start_date.value       = opener.document.all("start_date").value;
	window.sitechform.end_date.value         = opener.document.all("end_date").value;
	window.sitechform.user_phone.value       = opener.document.all("0_=_user_phone").value;
	window.sitechform.serial_no.value        = opener.document.all("1_=_serial_no").value;
	//window.sitechform.pre_call_cause_id.value= opener.document.all("2_=_pre_call_cause_id").value;
	window.sitechform.out_gateway_id.value   = opener.document.all("3_=_out_gateway_id").value;
	window.sitechform.send_login_no.value    = opener.document.all("4_=_send_login_no").value;
	window.sitechform.send_content.value     = opener.document.all("5_like_send_content").value;
  
  
    if(head==''){
   	return;
   	}
   	temSql="select "+sql+ "from sms_push_rec_log"+ window.sitechform.sqlFilter.value;
   submitExp(expFlag);
 }
 function submitExp(str){
 	 window.sitechform.action="k181_expSelect.jsp?exp="+str;
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

 