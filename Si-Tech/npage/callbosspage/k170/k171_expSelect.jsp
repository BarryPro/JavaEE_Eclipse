<%
  /*
   * ����: ������Ϣ
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
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
    System.out.println("start_date:~~~~~~~~~~~~~~~~~~~~"+request.getParameter("start_date"));
	   //�ж��ǵ���ȫ�����ǵ��뵱ǰҳ
    String sqlFilter = request.getParameter("sqlFilter");
    String sql=request.getParameter("sql");
    String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
    String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
    String sqlMulKfCfm="";
    //zengzq
    String loginNo = (String)session.getAttribute("workNo"); 
    String seq=request.getParameter("seq");// �����û�ѡ��״̬����
    String strseq=""; 
    int start=0;
    int end=0;
    String op_code="K171";
    String[][] queryList = new String[][] {};
    String headName=request.getParameter("headName");
    String start_date = request.getParameter("start_date");
    String end_date = request.getParameter("end_date");
    String contact_id = request.getParameter("contact_id");
    String region_code = request.getParameter("region_code");	
    String accept_login_no = request.getParameter("accept_login_no")==null?loginNo:request.getParameter("accept_login_no");
    String listen_flag = request.getParameter("listen_flag");
    String accept_phone = request.getParameter("accept_phone");
    String mail_address = request.getParameter("mail_address");
    String contact_address = request.getParameter("contact_address");
    String grade_code = request.getParameter("grade");
    String contact_phone = request.getParameter("contact_phone");
    String caller_phone = request.getParameter("caller_phone"); //���к���
    String statisfy_code = request.getParameter("statisfy_code");
    String cust_name = request.getParameter("cust_name");
    String fax_no = request.getParameter("fax_no");
    String accept_long_begin = request.getParameter("accept_long_begin");
    String accept_long_end = request.getParameter("accept_long_end");
    String callee_phone = request.getParameter("callee_phone");
    String skill_quence = request.getParameter("skill_quence");
    String staffHangup = request.getParameter("staffHangup");
    String acceptid = request.getParameter("accid");
    String staffcity = request.getParameter("staffcity");    
    String VERTIFY_PASSWD_FLAG_ISNOT_NULL = request.getParameter("VERTIFY_PASSWD_FLAG_ISNOT_NULL");
    HashMap hashMap =new HashMap();
    if(start_date!=null){
    hashMap.put("tablename",start_date.substring(0, 6));
    }
		hashMap.put("begin_date",start_date); 
    hashMap.put("end_date",end_date); 
    hashMap.put("accept_long_begin",accept_long_begin); 
    hashMap.put("accept_long_end",accept_long_end); 
    hashMap.put("other_passwd_flag",VERTIFY_PASSWD_FLAG_ISNOT_NULL); 
    hashMap.put("contact_id",contact_id);     
    hashMap.put("region_code",region_code);     
    hashMap.put("accept_login_no",accept_login_no);   
    hashMap.put("accept_phone",accept_phone);   
    hashMap.put("mail_address",mail_address); 
    hashMap.put("contact_address",contact_address); 
    hashMap.put("grade_code",grade_code); 
    hashMap.put("contact_phone",contact_phone); 
    hashMap.put("caller_phone",caller_phone); 
    hashMap.put("statisfy_code",statisfy_code); 
    hashMap.put("cust_name",cust_name); 
    hashMap.put("fax_no",fax_no); 
    hashMap.put("callee_phone",callee_phone); 
    hashMap.put("skill_quence",skill_quence); 
    hashMap.put("staffHangup",staffHangup); 
    hashMap.put("acceptid",acceptid); 
    hashMap.put("staffcity",staffcity); 
    hashMap.put("listen_flag",listen_flag);
    hashMap.put("op_code",op_code);
    hashMap.put("sqlstr",sql);
    hashMap.put("boss_login_no",loginNo);
    
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
	  String excelName="������Ϣ";
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

   //��һ������ҳ�棬��ȡ�ϴ�ѡ�м�¼
   if("cur".equalsIgnoreCase(pageFlag)||"all".equalsIgnoreCase(pageFlag)){
   		  List iDataList3 =(List)KFEjbClient.queryForList("dcallexpstatus",hashMap);  
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
      // sqlTemp =strCountSql+sqlFilter;
		   rowCount=((Integer)KFEjbClient.queryForObject("dcallcallcount",hashMap)).intValue();               
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
      //  String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
       
       start = (curPage - 1) * pageSize + 1;
		   end = curPage * pageSize;
		   if (end > rowCount){
			     end = rowCount;
		    }
		  hashMap.put("start",String.valueOf(start)); 
      hashMap.put("end",String.valueOf(end)); 
		  List iDataList =(List)KFEjbClient.queryForList("dcallcallexpcur",hashMap);                              
		  queryList = getArrayFromListMap(iDataList ,1,23); 	
      System.out.println("===queryList.length=="+queryList.length);
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

		  List iDataList1 =(List)KFEjbClient.queryForList("dcallcallexpall",hashMap);                              
		  queryList = getArrayFromListMap(iDataList1 ,0,22); 	

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
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K171'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K171',:v2,sysdate)&&"+loginNo+"^"+seq;
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
<title>������Ϣ����</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">�����б�</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>ȫѡ/ȡ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="CONTACT_ID" value="��ˮ��" onclick="judgeCheckAll('area[]')" />��ˮ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="decode(ACCEPTID,'0','�˹�','1','�Զ�','2','����','3','����','4','����','5','EMail','6','Web','7','����','8','����ͨ��' ,'9','�ڲ�����' ,'10','��������','11','����','12','����','13','δ����')" value="����ʽ" onclick="judgeCheckAll('area[]')"/>����ʽ<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="replace(translate(cust_name,'^',' '),'','')" value="�ͻ�����" />�ͻ�����<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="decode(region_code, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����')" value="�ͻ�����" onclick="judgeCheckAll('area[]')"/>�ͻ�����<br> 
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="ACCEPT_PHONE" value="�������" onclick="judgeCheckAll('area[]')"/>�������<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="CALLER_PHONE" value="���к���" onclick="judgeCheckAll('area[]')"/>���к���<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="CALLEE_PHONE" value="���к���" onclick="judgeCheckAll('area[]')"/>���к���<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi:ss')" value="����ʱ��" onclick="judgeCheckAll('area[]')"/>����ʱ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="ACCEPT_LONG" value="����ʱ��" onclick="judgeCheckAll('area[]')"/>����ʱ��<br>
<!-- modified by liujied 20090922 -->
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="ACCEPT_LOGIN_NO" value="������" onclick="judgeCheckAll('area[]')"/>������<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="decode(STAFFHANGUP,'0','�û�','1','����Ա','2','������֤ʧ���Զ��ͷ�')" value="�һ���" onclick="judgeCheckAll('area[]')"/>�һ���<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="decode(QC_FLAG,'Y','���ʼ�','N','δ�ʼ�','','δ�ʼ�',NULL,'δ�ʼ�')" value="�Ƿ��ʼ�" onclick="judgeCheckAll('area[]')" />�Ƿ��ʼ�<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="decode(STATISFY_CODE,'1','����',NULL,'δ����','2','һ��','3','������','9','������û��һ�','4','����Ȱ�������')" value="�ͻ������" onclick="judgeCheckAll('area[]')" />�ͻ������<br>
<input name="area[]" type="checkbox" id="area[]" seq="13" sql="decode(LANG_CODE,'1','��ͨ��','2','Ӣ��')" value="��������" onclick="judgeCheckAll('area[]')"/>��������<br>
<input name="area[]" type="checkbox" id="area[]" seq="14" sql="CALLCAUSEDESCS" value="����ԭ��" />����ԭ��<br>
<input name="area[]" type="checkbox" id="area[]" seq="15" sql="decode(LISTEN_FLAG,'Y','��','','��',NULL,'��','N','��')" value="¼����ȡ��־" onclick="judgeCheckAll('area[]')"/>¼����ȡ��־<br>
<input name="area[]" type="checkbox" id="area[]" seq="16" sql="decode(USE_FLAG,'Y','��','N','��')" value="�Ƿ�ʹ�÷���" onclick="judgeCheckAll('area[]')"/>�Ƿ�ʹ�÷���<br>
<input name="area[]" type="checkbox" id="area[]" seq="17" sql="QC_LOGIN_NO" value="�ʼ�Ա����" onclick="judgeCheckAll('area[]')"/>�ʼ�Ա����<br>
<!--zengzq modify decode�е����ݺͲ�ѯҳ�汣��һ�� start-->
<input name="area[]" type="checkbox" id="area[]" seq="18" sql="decode(VERTIFY_PASSWD_FLAG,'Y','��','N','��','YY','��(��ȷ)','YN','��(ʧ��)','','��',NULL,'��')" value="�Ƿ�������֤" onclick="judgeCheckAll('area[]')"/>�Ƿ�������֤<br>
<input name="area[]" type="checkbox" id="area[]" seq="19" sql="decode(OTHER_PASSWD_FLAG,'Y','��','N','��','YY','��(��ȷ)','YN','��(ʧ��)','','��',NULL,'��')" value="�Ƿ�������֤" onclick="judgeCheckAll('area[]')"/>�Ƿ�������֤<br>
<!--zengzq modify decode�е����ݺͲ�ѯҳ�汣��һ�� end-->
<input name="area[]" type="checkbox" id="area[]" seq="20" sql="BAK" value="��ע" onclick="judgeCheckAll('area[]')"/>��ע<br>
<input name="area[]" type="checkbox" id="area[]" seq="21" sql="TRANSFER_BAK" value="ת�ӱ�ע" />ת�ӱ�ע<br>
<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="headName" value="">
<input type="hidden" name="sql" value="">

<!--zengzq-->
<input type="hidden" name="stautsflag" value="stautsflag">
<input type="hidden" name="seq" value="">
<!--donglei20091120 �滻�󶨱��� start-->
<input name="start_date"        type="hidden" value="">         
<input name="end_date"          type="hidden" value="">   
<input name="contact_id"        type="hidden" value="">
<input name="region_code"	      type="hidden" value="">
<input name="accept_login_no"   type="hidden" value="">
<input name="listen_flag"       type="hidden" value="">
<input name="accept_phone"      type="hidden" value="">
<input name="mail_address"      type="hidden" value="">
<input name="contact_address"   type="hidden" value="">
<input name="grade_code"        type="hidden" value="">
<input name="contact_phone"     type="hidden" value="">
<input name="caller_phone"      type="hidden" value="">
<input name="statisfy_code"     type="hidden" value="">
<input name="cust_name"         type="hidden" value="">
<input name="fax_no"            type="hidden" value="">
<input name="accept_long_begin" type="hidden" value="">   
<input name="accept_long_end"   type="hidden" value="">   
<input name="callee_phone"      type="hidden" value="">
<input name="skill_quence"      type="hidden" value="">
<input name="staffHangup"       type="hidden" value="">
<input name="acceptid"          type="hidden" value="">
<input name="staffcity"         type="hidden" value="">
<input name="VERTIFY_PASSWD_FLAG_ISNOT_NULL"         type="hidden" value="">

<!--donglei20091120 �滻�󶨱��� end-->
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
	
	var formobj = window.opener.parent.queryFrame.document.sitechform;
	var startdate = formobj.start_date.value;
	
	if(startdate > '<%=dateStr %>'){
		
		similarMSNPop("�����Ľ���ʱ�䲻�ܳ�����ǰʱ��");
		return;
	}
	
	var head=getCheckboxValue();
	var sql=getCheckboxSql();
	
	//zengzq
	var seq=getCheckboxSeq(); 
	var stautsflag="<%=stautsflag%>";
	
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	//�滻�󶨱��� start
window.sitechform.start_date.value        =	opener.sitechform.start_date.value;                 
window.sitechform.end_date.value          =	opener.sitechform.end_date.value;             
window.sitechform.contact_id.value        =	opener.sitechform.contact_id.value;     
window.sitechform.region_code.value	      =	opener.sitechform.region_code.value;	   
window.sitechform.accept_login_no.value   =	opener.sitechform.accept_login_no.value;
window.sitechform.listen_flag.value       =	opener.sitechform.listen_flag.value;  
window.sitechform.accept_phone.value      =	opener.sitechform.accept_phone.value;   
window.sitechform.mail_address.value      =	opener.sitechform.mail_address.value;   
window.sitechform.contact_address.value   =	opener.sitechform.contact_address.value;
window.sitechform.grade_code.value        =	opener.sitechform.grade_code.value;     
window.sitechform.contact_phone.value     =	opener.sitechform.contact_phone.value;  
window.sitechform.caller_phone.value      =	opener.sitechform.caller_phone.value;   
window.sitechform.statisfy_code.value     =	opener.sitechform.statisfy_code.value;  
window.sitechform.cust_name.value         =	opener.sitechform.cust_name.value;     
window.sitechform.fax_no.value            =	opener.sitechform.fax_no.value;        
window.sitechform.accept_long_begin.value =	opener.sitechform.accept_long_begin.value;    
window.sitechform.accept_long_end.value   =	opener.sitechform.accept_long_end.value;      
window.sitechform.callee_phone.value      =	opener.sitechform.callee_phone.value;  
window.sitechform.skill_quence.value      =	opener.sitechform.skill_quence.value;  
window.sitechform.staffHangup.value       =	opener.sitechform.staffHangup.value;   
window.sitechform.acceptid.value          =	opener.sitechform.acceptid.value;      
window.sitechform.staffcity.value         =	opener.sitechform.staffcity.value;

window.sitechform.VERTIFY_PASSWD_FLAG_ISNOT_NULL.value         =	opener.sitechform.VERTIFY_PASSWD_FLAG_ISNOT_NULL.value;

//�滻�󶨱��� end
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
 	 window.sitechform.action="k171_expSelect.jsp?exp="+str;
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
