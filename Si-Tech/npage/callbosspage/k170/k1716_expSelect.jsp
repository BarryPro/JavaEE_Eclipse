<%
  /*
   * ����: ת��¼��
�� * �汾: 1.0
�� * ����: 2009/01/08
�� * ����: zengzq 
�� * ��Ȩ: sitech
   * 
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%!
//��������ԭ��ȥ�����ݿ��е�html����
	StringBuffer typeCheckBox = new StringBuffer();
	public  String removeHtmlCode(String call_cause_desc){
		if(call_cause_desc==null||call_cause_desc==""){return "";}
	    int tempBegin = call_cause_desc.indexOf("<span", 0);
	    if(tempBegin<0){
	    	tempBegin = call_cause_desc.indexOf("<SPAN", 0);
	    }
	    int tempend = call_cause_desc.indexOf("</span>", tempBegin);
	    if(tempend<0){
	    	tempend = call_cause_desc.indexOf("</SPAN>", tempBegin);
	    }
	    if(tempend<0){return typeCheckBox.toString();}
	    String call_cause_desc_temp = call_cause_desc.substring(0,tempend);
	    typeCheckBox.append(getInnerHtml(call_cause_desc_temp)+",");
	    call_cause_desc=call_cause_desc.substring(tempend+7,call_cause_desc.length());
	    //call_cause_desc_temp=call_cause_desc.substring(0,tempend);
	    removeHtmlCode(call_cause_desc).toString();
	    return typeCheckBox.toString();
		}
		
	public String getInnerHtml(String call_cause_desc_temp){
	    int tempBegin = call_cause_desc_temp.indexOf(">", 0);
	    int tempend = call_cause_desc_temp.indexOf("<", tempBegin+2);
	    if(tempend<0){return "";}
		return call_cause_desc_temp.substring(tempBegin+1,tempend);
	}
%>
<%
//jiangbing 20091118 ���������滻
    String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
    String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
    String sqlMulKfCfm="";
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
	   //�ж��ǵ���ȫ�����ǵ��뵱ǰҳ
    String sqlFilter = request.getParameter("sqlFilter");
    String sql=request.getParameter("sql");
    
    //zengzq
    String loginNo = (String)session.getAttribute("workNo"); 
    String seq=request.getParameter("seq");// �����û�ѡ��״̬����
    String strseq=""; 
    
    String headName=request.getParameter("headName");
    String[][] queryList = new String[][] {};
    String start_date        =  request.getParameter("start_date");            //��ʼʱ��
    String end_date          =  request.getParameter("end_date");              //����ʱ��
    String contact_id        =  request.getParameter("contact_id");        //��ˮ��
    String region_code       =  request.getParameter("region_code");       //�ͻ�����
    String accept_login_no   =  request.getParameter("accept_login_no");   //������
    String accept_phone      =  request.getParameter("accept_phone");      //�������
    String mail_address      =  request.getParameter("mail_address");      //�����ʼ�
    String contact_address   =  request.getParameter("contact_address");   //��ϵ��ַ
    String grade_code        =  request.getParameter("grade_code");        //�ͻ�����
    String contact_phone     =  request.getParameter("contact_phone");     //��ϵ�绰
    String caller_phone      =  request.getParameter("caller_phone");      //���к���  
    String statisfy_code     =  request.getParameter("statisfy_code");     //�ͻ������
    String cust_name         =  request.getParameter("cust_name");        //�ͻ�����
    String fax_no            =  request.getParameter("fax_no");           //�������
    String accept_long_begin =  request.getParameter("accept_long_begin");     //����ʱ��(��ʼ)
    String accept_long_end   =  request.getParameter("accept_long_end");       //����ʱ��(����)
    String callee_phone      =  request.getParameter("callee_phone");     //���к���  
    String skill_quence      =  request.getParameter("skill_quence");     //�жӼ���
    String staffHangup       =  request.getParameter("staffHangup");      //�һ���
    String acceptid          =  request.getParameter("acceptid");         //����ʽ 
    String oper_code         =  request.getParameter("staffcity");        //Ա������
    String kf_login_no       =  request.getParameter("kf_login_no");      //ת�湤��
    String ipAddr            =  request.getParameter("bak2");          //ת��IP 
    String tablename = "";
    String op_code="K17D";
    int start=0;
    int end=0;  
    HashMap pMap=new HashMap();
		pMap.put("start_date", start_date);
		pMap.put("end_date", end_date);
		pMap.put("contact_id", contact_id);
		pMap.put("region_code", region_code);
		pMap.put("accept_login_no", accept_login_no);
		pMap.put("accept_phone", accept_phone);
		pMap.put("mail_address", mail_address);
		pMap.put("contact_address", contact_address);
		pMap.put("grade_code", grade_code);
		pMap.put("contact_phone", contact_phone);
		pMap.put("caller_phone", caller_phone);
		pMap.put("statisfy_code", statisfy_code);
		pMap.put("cust_name", cust_name);
		pMap.put("fax_no", fax_no);
		pMap.put("accept_long_begin", accept_long_begin);
		pMap.put("accept_long_end", accept_long_end);
		pMap.put("callee_phone", callee_phone);
		pMap.put("skill_quence", skill_quence);
		pMap.put("staffHangup", staffHangup);
		pMap.put("acceptid", acceptid);
		pMap.put("oper_code", oper_code);
		pMap.put("kf_login_no", kf_login_no);
		pMap.put("ipAddr", ipAddr);  
		if(start_date!=null){
		tablename = start_date.substring(0, 6); 
		}
		pMap.put("tablename", tablename); 
		pMap.put("op_code",op_code);
    pMap.put("sqlstr",sql);
    pMap.put("boss_login_no",loginNo);
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // ��Ҫ�ӵ�ǰ��һҳ�洫����
    String sqlTemp ="";
    String sqlStr ="";
    
    //zengzq
    String stautsflag=request.getParameter("stautsflag");  // �����û�ѡ��״̬����  
	  String[] strHead =null;
	  String head[]=null;
          //String excelName="������Ϣ";
	  String excelName="ת��¼����ѯ";
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
		//zengzq
   //��һ������ҳ�棬��ȡ�ϴ�ѡ�м�¼
   if("cur".equalsIgnoreCase(pageFlag)||"all".equalsIgnoreCase(pageFlag)){
   		  List iDataList3 =(List)KFEjbClient.queryForList("dcallexpstatus",pMap);  
   		  if(iDataList3.size()!=0){                            
		    queryList = getArrayFromListMap(iDataList3 ,0,1); 	
				strseq=queryList[0][0];
				}
				if(!"".equalsIgnoreCase(strseq)){
					stautsflag="Y";
					}
		}
   //������ǰ��ʾ����
   if("cur".equalsIgnoreCase(expFlag)){    
        rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K17D_strCountSql",pMap)).intValue();
        System.out.println("rowCount___________________________"+rowCount);
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
		    List iDataList2 =(List)KFEjbClient.queryForList("query_K17D_expcur",pMap);     
		    queryList = getArrayFromListMap(iDataList2 ,1,16);  
		    System.out.println("queryList___________________________cur"+queryList.length);
             for(int i=0;i<queryList.length;i++){
              for(int j=0;j<queryList[i].length;j++){
              if(queryList[i][j]!=null){
                  if(queryList[i][j].startsWith("<SPAN") ||queryList[i][j].startsWith("<span")){
                    queryList[i][j]=removeHtmlCode(queryList[i][j]);
                  } 
                }
               }
	           typeCheckBox=typeCheckBox.delete(0, typeCheckBox.capacity());
             }
				XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
      List iDataList5 =(List)KFEjbClient.queryForList("query_K17D_expall",pMap);                              
		  queryList = getArrayFromListMap(iDataList5 ,0,13); 	
		  System.out.println("queryList_________________________________-"+queryList.length);
             for(int i=0;i<queryList.length;i++){
              for(int j=0;j<queryList[i].length;j++){
              if(queryList[i][j]!=null){
                  if(queryList[i][j].startsWith("<SPAN") ||queryList[i][j].startsWith("<span")){
                    queryList[i][j]=removeHtmlCode(queryList[i][j]);
                  } 
                }
               }
            typeCheckBox=typeCheckBox.delete(0, typeCheckBox.capacity());
             }
        XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
				out.print("<script language='javascript'>window.close();</script>");
				
			//zengzq
			}
			//�����û�ѡ�����  
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K17D'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K17D',:v2,sysdate)&&"+loginNo+"^"+seq;
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
<title>ת��¼������</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">�����б�</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>ȫѡ/ȡ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="t1.CONTACT_ID" value="��ˮ��" onclick="judgeCheckAll('area[]')" />��ˮ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="CUST_NAME" value="�ͻ�����" onclick="judgeCheckAll('area[]')" />�ͻ�����<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="decode(region_code, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����') region_code" value="�ͻ�����" onclick="judgeCheckAll('area[]')"/>�ͻ�����<br> 
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="ACCEPT_PHONE" value="�������" onclick="judgeCheckAll('area[]')"/>�������<br>
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="CALLER_PHONE" value="���к���" onclick="judgeCheckAll('area[]')"/>���к���<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="CALLEE_PHONE" value="���к���" onclick="judgeCheckAll('area[]')"/>���к���<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi:ss') BEGIN_DATE" value="����ʱ��" onclick="judgeCheckAll('area[]')"/>����ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="to_char(ACCEPT_LONG)" value="����ʱ��" onclick="judgeCheckAll('area[]')"/>����ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="ACCEPT_LOGIN_NO" value="������" onclick="judgeCheckAll('area[]')"/>������<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="decode(STAFFHANGUP,'0','�û�','1','����Ա','2','������֤ʧ���Զ��ͷ�') STAFFHANGUP" value="�һ���" onclick="judgeCheckAll('area[]')"/>�һ���<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="decode(QC_FLAG,'Y','���ʼ�','N','δ�ʼ�','','δ�ʼ�',NULL,'δ�ʼ�') QC_FLAG" value="�Ƿ��ʼ�" onclick="judgeCheckAll('area[]')" />�Ƿ��ʼ�<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="decode(STATISFY_CODE,'0','����','1','δ����','2','һ��','3','������','4','����ȵ���һ�') STATISFY_CODE" value="�ͻ������" onclick="judgeCheckAll('area[]')" />�ͻ������<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="CALLCAUSEDESCS" value="����ԭ��" onclick="judgeCheckAll('area[]')" />����ԭ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="t2.login_no" value="ת�湤��" onclick="judgeCheckAll('area[]')" />ת�湤��<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="t2.bak2" value="ת��IP" onclick="judgeCheckAll('area[]')" />ת��IP<br>

<input name="start_date"                type="hidden" value="">               
<input name="end_date"                  type="hidden" value="">
<input name="contact_id"         type="hidden" value="">
<input name="region_code"           type="hidden" value="">
<input name="accept_login_no"       type="hidden" value="">
<input name="accept_phone"          type="hidden" value="">
<input name="mail_address"          type="hidden" value="">
<input name="contact_address"       type="hidden" value="">
<input name="grade_code"            type="hidden" value="">
<input name="contact_phone"         type="hidden" value="">
<input name="caller_phone"          type="hidden" value="">
<input name="statisfy_code"         type="hidden" value="">
<input name="cust_name"            type="hidden" value="">
<input name="fax_no"               type="hidden" value="">
<input name="accept_long_begin"         type="hidden" value="">
<input name="accept_long_end"           type="hidden" value="">
<input name="callee_phone"         type="hidden" value="">
<input name="skill_quence"         type="hidden" value="">
<input name="staffHangup"          type="hidden" value="">
<input name="acceptid"             type="hidden" value="">
<input name="staffcity"            type="hidden" value="">
<input name="kf_login_no"          type="hidden" value="">
<input name="bak2"              type="hidden" value="">


<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="headName" value="">
<input type="hidden" name="sql" value="">

<!--zengzq-->
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
 
 
 //zengzq
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
	
	//zengzq
	var seq=getCheckboxSeq();
	var stautsflag="<%=stautsflag%>";
	
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	
	document.all("start_date").value           = opener.document.all("start_date").value;       
  document.all("end_date").value             = opener.document.all("end_date").value;         
  document.all("contact_id").value    = opener.document.all("0_=_t1.contact_id").value;  
  document.all("region_code").value      = opener.document.all("1_=_region_code").value;    
  document.all("accept_login_no").value  = opener.document.all("2_=_accept_login_no").value;
  document.all("accept_phone").value     = opener.document.all("3_=_accept_phone").value;   
  document.all("mail_address").value     = opener.document.all("4_=_mail_address").value;   
  document.all("contact_address").value  = opener.document.all("5_=_contact_address").value;
  document.all("grade_code").value       = opener.document.all("6_=_grade_code").value;     
  document.all("contact_phone").value    = opener.document.all("7_=_contact_phone").value;  
  document.all("caller_phone").value     = opener.document.all("8_=_caller_phone").value;   
  document.all("statisfy_code").value    = opener.document.all("9_=_statisfy_code").value;  
  document.all("cust_name").value       = opener.document.all("10_=_cust_name").value;     
  document.all("fax_no").value          = opener.document.all("11_=_fax_no").value;        
  document.all("accept_long_begin").value    = opener.document.all("accept_long_begin").value;  
  document.all("accept_long_end").value      = opener.document.all("accept_long_end").value;    
  document.all("callee_phone").value    = opener.document.all("12_=_callee_phone").value;  
  document.all("skill_quence").value    = opener.document.all("14_=_skill_quence").value;  
  document.all("staffHangup").value     = opener.document.all("15_=_staffHangup").value;   
  document.all("acceptid").value        = opener.document.all("16_=_acceptid").value;      
  document.all("staffcity").value       = opener.document.all("17_=_staffcity").value;     
  document.all("kf_login_no").value     = opener.document.all("18_=_t2.kf_login_no").value;   
  document.all("bak2").value         = opener.document.all("19_=_t2.bak2").value;       
	window.sitechform.page.value = opener.document.sitechform.page.value;
  window.sitechform.headName.value = head;
  window.sitechform.sql.value = sql;
  
  //zengzq
  window.sitechform.seq.value = seq;
  window.sitechform.stautsflag.value = stautsflag;
  
    if(head==''){
   	return;
   	}
   	temSql="select "+sql+ "from dcallcall"+ window.sitechform.sqlFilter.value;
   submitExp(expFlag);
 }
 function submitExp(str){
 	 window.sitechform.action="k1716_expSelect.jsp?exp="+str;
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


//zengzq
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
