<%
  /*
   * ����: ����ԭ��
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
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*,java.util.*"%>
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
	    typeCheckBox.append(getInnerHtml(call_cause_desc_temp)+"��");
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
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
	   //�ж��ǵ���ȫ�����ǵ��뵱ǰҳ
    String sqlFilter = request.getParameter("sqlFilter");
    String sql=request.getParameter("sql");
    String loginNo = (String)session.getAttribute("workNo"); 
    String seq=request.getParameter("seq");// �����û�ѡ��״̬����
    String strseq=""; 
    String headName=request.getParameter("headName");
    String callCauseId=request.getParameter("callCauseId"); 
    //20091120 ���� 
    int start=0;
    int end=0;  
    String op_code="K172";
    String[][] queryList = new String[][] {};
    String start_date = request.getParameter("start_date"); //��ʼʱ��
	  String VERTIFY_PASSWD_FLAG_ISNOT_NULL = request.getParameter("VERTIFY_PASSWD_FLAG_ISNOT_NULL");
	  String end_date = request.getParameter("end_date"); //����ʱ��
	  String contact_id = request.getParameter("contact_id"); //��ˮ��  
	  String region_code = request.getParameter("region_code"); //�ͻ�����
	  String accept_login_no = request.getParameter("accept_login_no")==null?loginNo:request.getParameter("accept_login_no"); //������
	  String acceptid = request.getParameter("acceptid");
	  String accept_phone = request.getParameter("accept_phone"); //�������
	  String caller_phone = request.getParameter("caller_phone"); //���к���
	  String call_cause_id = request.getParameter("call_cause_id");
	  String accept_long_begin = request.getParameter("accept_long_begin"); //ͨ��ʱ��
	  String accept_long_end = request.getParameter("accept_long_end");
	  String sm_code = request.getParameter("sm_code"); //�ͻ�Ʒ��
	  String staffcity = request.getParameter("staffcity"); //Ա������
	  String statisfy_code = request.getParameter("statisfy_code"); //�ͻ������
	  String cause_id_is_null = request.getParameter("cause_id_is_null"); //����ԭ��Ϊ��
	  String nowday="";
	  HashMap pMap=new HashMap();
	  if(start_date!=null){
	  nowday = start_date.substring(0, 6);
	  }
		pMap.put("nowday", nowday);
		pMap.put("start_date", start_date);
		pMap.put("end_date", end_date);
		pMap.put("accept_long_begin", accept_long_begin);
		pMap.put("accept_long_end",accept_long_end);
		pMap.put("accept_login_no", accept_login_no);
		pMap.put("caller_phone", caller_phone);
		pMap.put("acceptid", acceptid);
		pMap.put("sm_code", sm_code);
		pMap.put("staffcity", staffcity);
		pMap.put("region_code", region_code);
		pMap.put("call_cause_id", call_cause_id);
		pMap.put("statisfy_code", statisfy_code);
		pMap.put("cause_id_is_null", cause_id_is_null);
		pMap.put("VERTIFY_PASSWD_FLAG_ISNOT_NULL", VERTIFY_PASSWD_FLAG_ISNOT_NULL);
		pMap.put("contact_id", contact_id);
		pMap.put("accept_phone", accept_phone);
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
    String stautsflag=request.getParameter("stautsflag");  // �����û�ѡ��״̬����	  
	  String[] strHead =null;
	  String head[]=null;
	  String excelName="����ԭ��";
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
%>	
		<%
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
        rowCount = ( ( Integer )KFEjbClient.queryForObject("query_callcause_strCountSql",pMap)).intValue();
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
    
        List queryList1 =(List)KFEjbClient.queryForList("query_callcause_exp_cur",pMap);     
        queryList = getArrayFromListMap(queryList1 ,1,21);   
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
 
		  List iDataList2 =(List)KFEjbClient.queryForList("query_callcause_exp_all",pMap);                              
		  queryList = getArrayFromListMap(iDataList2 ,0,14); 	
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
			//�����û�ѡ�����  
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K172'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K172',:v2,sysdate)&&"+loginNo+"^"+seq;
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
<title>����ԭ�򵼳�</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">�����б�</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>ȫѡ/ȡ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="contact_id" value="��ˮ��" onclick="judgeCheckAll('area[]')"/>��ˮ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi:ss')" value="����ʱ��" onclick="judgeCheckAll('area[]')"/>����ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="CALLCAUSEDESCS" value="����ԭ��" onclick="judgeCheckAll('area[]')"/>����ԭ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="CALLER_PHONE" value="���к���" onclick="judgeCheckAll('area[]')"/>���к���<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="replace(translate(cust_name,'^',' '),'','')" value="�ͻ�����" onclick="judgeCheckAll('area[]')"/>�ͻ�����<br> 
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="decode(region_code, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����')" value="�ͻ�����" onclick="judgeCheckAll('area[]')"/>�ͻ�����<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="decode(STATISFY_CODE,'1','����',NULL,'δ����','2','һ��','3','������','9','������û��һ�','4','����Ȱ�������')" value="�ͻ������" onclick="judgeCheckAll('area[]')"/>�ͻ������<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="ACCEPT_PHONE" value="�������" onclick="judgeCheckAll('area[]')"/>�������<br>
<!-- modified by liujied 20090922 -->                             
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="ACCEPT_LOGIN_NO" value="������" onclick="judgeCheckAll('area[]')"/>������<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="ACCEPT_LONG" value="ͨ��ʱ��" onclick="judgeCheckAll('area[]')"/>ͨ��ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="decode(ACCEPTID,'0','�˹�','1','�Զ�','2','����','3','����','4','����','5','EMail','6','Web','7','����','8','����ͨ��' ,'9','�ڲ�����' ,'10','��������','11','����','12','����')" value="����ʽ" onclick="judgeCheckAll('area[]')"/>����ʽ<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="CALL_ACCEPT_ID" value="�����ˮ��" onclick="judgeCheckAll('area[]')"/>�����ˮ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="BAK" value="��ע" onclick="judgeCheckAll('area[]')"/>��ע<br>

<input name="start_date"                       type="hidden" value="">
<input name="end_date"                         type="hidden" value="">
<input name="contact_id"                       type="hidden" value="">
<input name="region_code"                      type="hidden" value="">
<input name="accept_login_no"                  type="hidden" value="">    
<input name="acceptid"                         type="hidden" value="">
<input name="accept_phone"                     type="hidden" value="">
<input name="caller_phone"                     type="hidden" value="">
<input name="call_cause_id"                    type="hidden" value="">
<input name="accept_long_begin"                type="hidden" value="">
<input name="accept_long_end"                  type="hidden" value="">
<input name="sm_code"                          type="hidden" value="">
<input name="showCauseName"                    type="hidden" value="">
<input name="staffcity"                        type="hidden" value="">
<input name="statisfy_code"                    type="hidden" value="">
<input name="cause_id_is_null"                 type="hidden" value="">

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
   	count++;
   	}
  }
  //����ϴ�ȫѡ,��˴ν�"ȫѡ/ȡ��"��ѡ  
  	if(inps.length==count){
  			document.getElementById('checkAll').checked = true;
  	} else{
  			document.getElementById('checkAll').checked = false;
  	}
  	
 }
 }
 setStauts();
 
function s_exp(x){
	
	var formobj = window.opener.parent.queryFrame2.document.sitechform;
	var startdate = formobj.start_date.value;
	
	if(startdate > '<%=dateStr %>'){
		
		similarMSNPop("�����Ľ���ʱ�䲻�ܳ�����ǰʱ��");
		return;
	}
	var head=getCheckboxValue();
	var sql=getCheckboxSql();
	var seq=getCheckboxSeq();
	var stautsflag="<%=stautsflag%>";
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	
  window.sitechform.start_date.value                        = opener.sitechform.start_date.value;                    
  //window.sitechform.VERTIFY_PASSWD_FLAG_ISNOT_NULL.value    = opener.sitechform.VERTIFY_PASSWD_FLAG_ISNOT_NULL.value;
  window.sitechform.end_date.value                          = opener.sitechform.end_date.value;                      
  window.sitechform.contact_id.value                        = opener.sitechform.contact_id.value;                    
  window.sitechform.region_code.value                       = opener.sitechform.region_code.value;                   
  window.sitechform.accept_login_no.value                   = opener.sitechform.accept_login_no.value;               
  window.sitechform.acceptid.value                          = opener.sitechform.acceptid.value;                      
  window.sitechform.accept_phone.value                      = opener.sitechform.accept_phone.value;                  
  window.sitechform.caller_phone.value                      = opener.sitechform.caller_phone.value;                  
  window.sitechform.call_cause_id.value                     = opener.sitechform.call_cause_id.value;             
  window.sitechform.accept_long_begin.value                 = opener.sitechform.accept_long_begin.value;             
  window.sitechform.accept_long_end.value                   = opener.sitechform.accept_long_end.value;               
  window.sitechform.sm_code.value                           = opener.sitechform.sm_code.value;                       
  window.sitechform.showCauseName.value                     = opener.sitechform.showCauseName.value;                 
  window.sitechform.staffcity.value                         = opener.sitechform.staffcity.value;                     
  window.sitechform.statisfy_code.value                     = opener.sitechform.statisfy_code.value;                                       
  window.sitechform.cause_id_is_null.value                  = opener.sitechform.cause_id_is_null.value; 
	
	window.sitechform.page.value = opener.document.sitechform.page.value;
  window.sitechform.headName.value = head;
  window.sitechform.sql.value = sql;
  window.sitechform.seq.value = seq;
  window.sitechform.stautsflag.value = stautsflag;
    if(head==''){
   	return;
   	}
   	
   	temSql="select "+sql+ "from dcallcall"+ window.sitechform.sqlFilter.value;
   submitExp(expFlag);
 }
 function submitExp(str){
 	 window.sitechform.action="k172_expSelect.jsp?exp="+str;
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

/*******************************************/
//��Ϣ���� by libin 2009-05-15
var msn_popmenu = null;
var msn_count = 0;

function similarMSNPop_local(msgContent){
    msn_count++;
	var imgClose=msn_popmenu.oPopup.document.createElement("img");
	imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_off.gif";
	imgClose.style.cursor="pointer";
	imgClose.onmouseover=function()
	{
		imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_on.gif";
	}
	imgClose.onmouseout=function()
	{
		imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_off.gif";
	}
	imgClose.onclick=function()
	{
		//hiddenList(overDiv,120);
	}
	imgClose.setAttribute("id","msgImg");
	var titleDiv=msn_popmenu.oPopup.document.createElement("div");
	titleDiv.setAttribute("id","msgTitle");
	var titleDivTxt=msn_popmenu.oPopup.document.createTextNode("������");
	var contentDiv=msn_popmenu.oPopup.document.createElement("div");
	contentDiv.setAttribute("id","msgContent");
	contentDiv.innerHTML=msgContent;
	var overDiv = msn_popmenu.oPopup.document.createElement("div");
	overDiv.setAttribute("id","msg");
	overDiv.style.display="none";
	overDiv.style.overflow="hidden";
	
	overDiv.onclick=function(){
		hiddenList(overDiv,120);
	}
	
	titleDiv.appendChild(imgClose);
	titleDiv.appendChild(titleDivTxt);
	overDiv.appendChild(titleDiv);
	overDiv.appendChild(contentDiv);
	
	var bodyHtml=msn_popmenu.oPopup.document.getElementsByTagName("body");
	bodyHtml[0].appendChild(overDiv);
	
	showList(overDiv,120); 
	if(msn_popmenu.oPopup.document.getElementById("overDiv")) return false;
	
	
	var hidett = setTimeout(function(){hiddenList(overDiv,120)},10000);
	overDiv.setAttribute("hidett",hidett);
	
}

function showList(objectId,mH)
{
	var h =0;
	var maxHeight = mH;
	var anim = function()
	{ 
		h += 5;
		if(h > maxHeight)
		{ 
			objectId.style.height = mH+"px";  
			if(tt){window.clearInterval(tt);}  
		} 
		else
		{ 	
			objectId.style.height = h + "px";
			objectId.style.display="block";

		}
	} 
	var tt = window.setInterval(anim,15);  
} 

function hiddenList(objectId,mH)
{ 
	var h =mH; 
	var anim = function()
	{ 
		h -= 5;
		if(h <= 0)
		{ 
			objectId.style.display="none";
			if(tt){window.clearInterval(tt);
			if(objectId.getAttribute("hidett")!=null)
			{
				window.clearInterval(objectId.getAttribute("hidett"));
				}
			if(h>=-5){
			msn_count--;
			if(msn_count<0)
			   msn_count = 0;
			if(msn_count==0){
				msn_popmenu.stopthis();
				msn_popmenu.hide();
			}
			}
			}
			objectId.parentNode.removeChild(objectId);
		} 
		else
		{ 
			objectId.style.height = h + "px";
		} 
	} 
	var tt = window.setInterval(anim,15); 
} 
	
function similarMSNPop(msgContent){
    if(msn_popmenu == null){
    	var MSG1 = new CLASS_MSN_MESSAGE(180, 120, "");
		msn_popmenu = MSG1;
		MSG1.show();
    }else{
    	msn_popmenu.reshow();
    	}	
	similarMSNPop_local(msgContent);	
}

function CLASS_MSN_MESSAGE(width, height, title) {
	this.title = title;
	this.width = width ? width : 180;
	this.height = height ? height : 120;
	this.timeout = 500;
	this.speed = 150;
	this.step = 5;
	this.right = screen.width - 1;
	this.bottom = screen.height;
	this.left = this.right - this.width;
	this.top = this.bottom - this.height;
	this.timer = 0;
	this.pause = false;
	this.close = false;
	this.autoHide = true;

	this.clickClose = false;
}

CLASS_MSN_MESSAGE.prototype.hide = function () {
	this.oPopup.hide();
};

CLASS_MSN_MESSAGE.prototype.onunload = function () {
	return true;
};

CLASS_MSN_MESSAGE.prototype.show = function () {	
    this.oPopup = window.createPopup();
	this.Pop = this.oPopup;
	var w = this.width;
	var h = this.height;
	var x = this.right-this.width;
	var y = this.bottom-this.height;
	var str = '';
	var me = this.Pop;
	this.oPopup.document.createStyleSheet().addImport('<%= request.getContextPath() %>/nresources/default/css/layer_ob.css');
	this.oPopup.document.body.innerHTML = str;
	var fun = function () {
	    if(msn_count!=0)
		me.show(x, y, w, h);
	}
	this.timer = window.setInterval(fun, this.speed);	
	this.close = false;
};

/*  
*    ��Ϣֹͣ����  
*/
CLASS_MSN_MESSAGE.prototype.stopthis = function () {	
  
	 window.clearInterval(this.timer);
	 this.close = true;	
};
/*  
*    ��Ϣ��ʾ����  
*/
CLASS_MSN_MESSAGE.prototype.reshow = function () {	
  if(this.close==false){
  		return;
  	}
	var w = this.width;
	var h = this.height;
	var x = this.right-this.width;
	var y = this.bottom-this.height;
	var me = this.Pop;
	
	var fun = function () {
	    if(msn_count!=0)
		me.show(x, y, w, h);
	}
	this.timer = window.setInterval(fun, this.speed);	
	this.close = false;	
};

 </script>
