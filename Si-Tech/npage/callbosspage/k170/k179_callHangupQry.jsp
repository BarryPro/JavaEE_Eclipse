<%
  /*
   * ����: ���б��ּ�¼
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
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%! 
		/** 
		 ����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
		 ����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
		 */ 
    public String[]  returnSql(HttpServletRequest request){
        StringBuffer buffer = new StringBuffer();
        StringBuffer bufferPara = new StringBuffer();
 
		   //�������.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
    String[] bingd= {"",""};
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
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%'||:v"
				+ objs[1].toString().replace('.','a') + "||'%%' ");
			bufferPara.append(",v"+objs[1].toString().replace('.','a')+"="+objs[2].toString().trim());
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " :v"
				+ objs[1].toString().replace('.','a') + "  ");
 
			bufferPara.append(",v"+objs[1].toString().replace('.','a')+"="+objs[2].toString().trim());
			}
		}
     bingd[0]=buffer.toString();
     bingd[1]=bufferPara.toString();
        return bingd;
}

 public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>
<%
//jiangbing 20091118 ���������滻
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
    String opCode="K179";
    String opName="�ۺϲ�ѯ-���б��ּ�¼��ѯ";
     /*midify by yinzx 20091113 ������ѯ�����滻*/
 		String myParams=request.getParameter("para");     
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String kf_longin_no=(String)session.getAttribute("kfWorkNo");	  	  
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
  	String sqlStr = "select t1.contact_id,t2.cust_name,t2.accept_phone,t2.caller_phone,to_char(t2.begin_date,'yyyy-MM-dd hh24:mi:ss'),to_char(t2.accept_long),t2.accept_login_no,t3.hangup_name,decode(t2.qc_flag,'Y','��','N','��','','��',NULL,'��'),";
           sqlStr +=" decode(trim(t1.op_type),'1','����','2','�ڲ�����'),to_char(t1.begin_time,'yyyy-MM-dd hh24:mi:ss'),to_char(t1.end_time,'yyyy-MM-dd hh24:mi:ss'),t2.accept_kf_login_no from dcallhangup t1, staffhangup t3,dcallcall";
		String strCountSql="select to_char(count(*)) count  from dcallhangup t1, dcallcall";
		String strAcceptLogSql="";
		String strDateSql="";
		String strOrderSql=" order by t1.begin_time desc ";
    String start_date        =  request.getParameter("start_date");                        
    String end_date          =  request.getParameter("end_date");                          
    String contact_id        =  request.getParameter("0_=_t1.contact_id");                 
    String staffcity         =  request.getParameter("17_=_t2.staffcity");
    //modified by liujied 20090921 ��Ϊʹ��BOSS���Ų�ѯ
    String accept_login_no   =  request.getParameter("2_=_t2.accept_login_no");            
    String accept_phone      =  request.getParameter("3_=_t2.accept_phone");               
    String mail_address      =  request.getParameter("4_=_t2.mail_address");               
    String contact_address   =  request.getParameter("5_=_t2.contact_address");            
    String grade_code        =  request.getParameter("6_=_t2.grade_code");                 
    String contact_phone     =  request.getParameter("7_=_t2.contact_phone");              
    String caller_phone      =  request.getParameter("8_=_t2.caller_phone");   //���к���  
    String op_type           =  request.getParameter("9_=_t1.op_type");                    
    String cust_name         =  request.getParameter("10_=_t2.cust_name");                 
    String fax_no            =  request.getParameter("11_=_t2.fax_no");                    
    String acceptid          =  request.getParameter("13_=_t2.acceptid");   
    String con_id            =  request.getParameter("con_id");                     
    String[][] dataRows = new String[][]{};
    String[] strbind= {"",""};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp ="";
    String action = request.getParameter("myaction");
    String sqlFilter = request.getParameter("sqlFilter");
	  //��ѯ����
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
       strDateSql=start_date.substring(0,6)+" t2 where 1=1 and t1.contact_id=t2.contact_id ";
       strDateSql+=" and  t1.begin_time >= to_date(:start_date ,'yyyy-mm-dd hh24:mi:ss') and t1.begin_time <= to_date(:end_date, 'yyyy-mm-dd hh24:mi:ss') ";
			 myParams="start_date="+start_date.trim()+" ,end_date="+end_date.trim();
    	}
    	strbind=returnSql(request);
    	myParams+=strbind[1];
    	sqlFilter=strDateSql+strbind[0];
    }    
        
  /*ȡ��ǰ��½���ŵĽ�ɫID��Ϊ���ŷָ���ַ��� hanjc add 20090423*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	if(powerCode==null) {
			powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
  String isCommonLogin="N";	
	/*
	 *�Ƿ��ǻ���Ա update by hanjc 20090719
        *01120O04Ϊ��ѵ��ɫid,01120O0EΪ�ʼ��ɫid,011202Ϊ�ͻ��绰Ӫҵ����01120O02����ͨ��ϯ
        *01120O02011202��01120201120O02�ǿͻ��绰Ӫҵ������ͨ��ϯ������ɫ��ƴ��
        *����Աֻ�пͻ��绰Ӫҵ������ͨ��ϯ������ɫ,��01120O02011202��01120201120O02��������С�鳤��
	 */
    /* modify by yinzx 20090826 ����ɽ������д�Ľ��ң�����д����ɫ��Ϣ ���Ը��죬������ʱ����
      //add by hanjc 20090719 �жϵ�ǰ�����Ƿ��ǻ���Ա��
      if(powerCodeArr.length==2){
         String tempVal = powerCodeArr[0].trim()+powerCodeArr[1].trim();
         if("01120O02011202".equals(tempVal)||"01120201120O02".equals(tempVal)){
		isCommonLogin="Y";	
         }
       } 
   *//*add by yinzx 090826*/
   for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<HUAWUYUAN_ID.length; j++){
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
				isCommonLogin="Y";
			}
		}
	}
%>	
			
<%	if ("doLoad".equals(action)) {
       sqlStr+=sqlFilter+" and t2.staffhangup=t3.hangup_code(+)"+strOrderSql;
       sqlTemp =strCountSql+sqlFilter;
    	  %>	             
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
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
        System.out.println("sql="+querySql);
        %>		           
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="14">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="13"   scope="end"/>
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
%>


<html>
<head>
		<style>
		img{
				cursor:hand;
		}
		
		input{
				height: 1.5em;
				width: 14.6em;
				font-size: 1em;
		}
  </style>	
<title>���б��ּ�¼��ѯ</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("tr").not("[input]").addClass("blue");
	    $("th").css("color","#3366FF").css("font-weight","bold");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "#159ee4");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	
// ¼����ȡ----��ʼ		
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
//�жϸ���ˮ��Ӧ�ļ��ǵ������Ƕ��
function checkCallListen(id,staffno){
		if(id==''){
		return;
		}
		if('<%=isCommonLogin%>'=='Y'){
			if('<%=kf_longin_no%>'!=staffno){
			  rdShowMessageDialog("��û����ȡ��¼����Ȩ�ޣ�");
			  return;
		  }
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
//var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
openWinMid("k170_getCallListen.jsp?flag_id="+id,'¼����ȡ',650,850);
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

    }else if(document.sitechform.end_date.value.substring(0,6)>document.sitechform.start_date.value.substring(0,6)){
		     showTip(document.sitechform.end_date,"ֻ�ܲ�ѯһ�����ڵļ�¼"); 
    	   sitechform.end_date.focus(); 	

    }else{
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);   
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
       window.sitechform.action="k179_callHangupQry.jsp?con_id="+vCon_id;
		}else{
			 window.sitechform.action="k179_callHangupQry.jsp";
		}
   window.sitechform.method='post';
   window.sitechform.submit(); 
}

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
  window.location="k179_callHangupQry.jsp";
}

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k179_callHangupQry.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}
//��������
function showExpWin(flag){
	window.sitechform.page.value="<%=curPage%>";
  window.sitechform.sqlWhere.value="<%=sqlFilter%>";
  window.sitechform.para.value="<%=myParams%>";
	openWinMid('k179_expSelect.jsp?flag='+flag,'ѡ�񵼳���',340,320);
 }

//��ʾͨ����ϸ��Ϣ
function getCallDetail(contact_id,start_date){
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    openWinMid(path,"��Ϣ����",680,960);
	return true;
}

function keepValue(){
	 window.sitechform.start_date.value="<%=start_date%>";//Ϊ��ʾ��ϸ��Ϣҳ�洫�ݿ�ʼʱ��
   window.sitechform.sqlFilter.value="<%=sqlFilter%>";
   window.sitechform.end_date.value="<%=end_date%>";
   
   window.sitechform.grade.value="<%=request.getParameter("grade")%>";
   window.sitechform.accid.value="<%=request.getParameter("accid")%>";
   window.sitechform.opType.value="<%=request.getParameter("opType")%>";
   window.sitechform.oper.value="<%=request.getParameter("oper")%>";
   window.sitechform.staffcity.value="<%=request.getParameter("17_=_t2.staffcity")%>";
   window.sitechform.grade_code.value="<%=request.getParameter("6_=_t2.grade_code")%>";
   window.sitechform.acceptid.value="<%=request.getParameter("13_=_t2.acceptid")%>";
   window.sitechform.op_type.value="<%=request.getParameter("9_=_t1.op_type")%>";
   
   window.sitechform.contact_id.value="<%=contact_id%>";
   window.sitechform.mail_address.value="<%=mail_address%>";
   window.sitechform.accept_login_no.value="<%=accept_login_no%>";
   window.sitechform.accept_phone.value="<%=accept_phone%>";
   window.sitechform.contact_address.value="<%=contact_address%>";
   window.sitechform.contact_phone.value="<%=contact_phone%>";
   window.sitechform.caller_phone.value="<%=caller_phone%>";
   window.sitechform.cust_name.value="<%=cust_name%>";
   window.sitechform.fax_no.value="<%=fax_no%>";
   window.sitechform.para.value="<%=myParams%>";

}

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

function qualityEval(){
	rdShowMessageDialog("�Ը���ˮ�Ž����ʼ쿼��",2);
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
  	planInQua(serialnum,staffno,flag);
    //checkIsQc(serialnum,flag,staffno);
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
function planInQua(serialnum,staffno,flag){
	var start_date = window.sitechform.start_date.value
	var  path = '/npage/callbosspage/checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum + '&staffno=' + staffno+ '&flag=' + flag + '&start_date=' + start_date;
	//�ƻ����ʼ�tabidΪ��ˮ��0���ƻ����ʼ�Ϊ��ˮ��1
	if(!parent.parent.document.getElementById(serialnum+0)){
	parent.parent.addTab(true,serialnum+0,'ִ���ʼ�ƻ�',path);
  }
	//var param  = 'dialogWidth=900px;dialogHeight=300px';
	//window.showModalDialog('../checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno, '', param);	
	//window.open('../checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno, '', 'width=900px;height=300px');
	//openWinMid('../checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno, '', 300,900);
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
</script>
</head>


<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table" style="width:100%;" >
		<table cellspacing="0" >
			 <tr><td colspan='6' ><div class="title"><div id="title_zi">���б��ּ�¼</div></div></td></tr>
       <tr >
      <td > ��ʼʱ�� </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onClick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > Ա������ </td>
      <td >
			 <select id="staffcity" name="17_=_t2.staffcity" size="1"  onchange="oper.value=this.options[this.selectedIndex].text">
        <%if(staffcity==null || staffcity.equals("")|| request.getParameter("oper")==null || request.getParameter("oper").equals("")){%>
			 	<option value="" selected>--����Ա������--</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>			 	
			 	<%}else {%>
      	 	 	<option value="" >--����Ա������--</option>			 	
      	 			<option value="<%=staffcity%>" selected >
      	 				<%=request.getParameter("oper")%>
      	 			</option>
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' and region_code<>'<%=staffcity%>' order by region_code</wtc:sql>
				  </wtc:qoption>      	 	 	
      	 	<%}%>
        </select>
        <input name="oper" type="hidden" value="<%=request.getParameter("oper")%>">
      </td>
            <td > ��ˮ�� </td>
      <td >
      <!--zhengjiang 20091010���onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
				<input id="contact_id" name="0_=_t1.contact_id"  type="text" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value=<%=(contact_id==null)?"":contact_id%>>
      </td>
          </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
     <td > ����ʱ�� </td>
      <td >
			  <input id="end_date" name ="end_date" type="text"  value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onClick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onClick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
     <td > �����ʼ� </td>
      <td >
			  <input name="4_=_t2.mail_address" type="text" maxlength="80"  id="mail_address"  value="<%=(mail_address==null)?"":mail_address%>">
      </td>

      	  <td > ��ϵ�绰 </td>
      <td >
			  <input name ="7_=_t2.contact_phone" type="text" id="contact_phone"  value="<%=(contact_phone==null)?"":contact_phone%>">
		  </td>
		       </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
       <tr > 
		  <td > ���к��� </td>
      <td >
			  <input name ="8_=_t2.caller_phone" type="text" id="caller_phone"  value="<%=(caller_phone==null)?"":caller_phone%>" onKeyUp="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
		  </td> 
		        <td > ��ϵ��ַ </td>
      <td >
			  <input name ="5_=_t2.contact_address" type="text" id="contact_address"  value="<%=(contact_address==null)?"":contact_address%>">
		  </td>          

      <td > �ͻ����� </td>
      <td >
			  <select name="6_=_t2.grade_code"  id="grade_code" size="1" onChange="grade.value=this.options[this.selectedIndex].text">
			  	<%if(grade_code==null || grade_code.equals("") || request.getParameter("grade").equals("") || request.getParameter("grade")==null){%>
			  	 <option value="" selected>--���пͻ�����--</option>
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from scallgradecode</wtc:sql>
				</wtc:qoption>			  	 
			  	<%}else {%>
      	 	 	<option value="" >--���пͻ�����--</option>			  	
			  	    <option value="<%=grade_code%>" selected >
      	 				<%=request.getParameter("grade")%>
      	 			</option>
					<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from scallgradecode where accept_code<>'<%=grade_code%>'</wtc:sql>
				</wtc:qoption>      	 	 	
      	 	<%}%>
        </select>
				<input name="grade" type="hidden" value="<%=request.getParameter("grade")%>"> 
		  </td> 
		       </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
       <tr >
		        <td > ������ </td>
      <td >
      <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="2_=_t2.accept_login_no" type="text" id="accept_login_no" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%=(accept_login_no==null)?"":accept_login_no%>">
      </td>
            <td > �ͻ����� </td>
      <td >
			  <input name ="10_=_t2.cust_name" type="text" id="cust_name"  value="<%=(cust_name==null)?"":cust_name%>">
		  </td>  

		  <td > �������� </td>
      <td >
      	 <select name="9_=_t1.op_type" id="op_type" size="1" onChange="opType.value=this.options[this.selectedIndex].text">
				<%if(op_type==null  || op_type.equals("") || request.getParameter("opType").equals("")|| request.getParameter("opType")==null){%>
		  	<option value="" selected>--���б��ַ�ʽ--</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select hold_code , hold_code|| '-->' ||hold_name from SHOLDTYPE</wtc:sql>
				</wtc:qoption>		  	
		  	<%}else {%>
          <option value="" >--���б��ַ�ʽ--</option>
      	 		<option value="<%=op_type%>" selected >
      	 			<%=request.getParameter("opType")%>
      	 		</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select hold_code , hold_code|| '-->' ||hold_name from SHOLDTYPE where hold_code<>'<%=op_type%>'</wtc:sql>
				</wtc:qoption>      	 	 	
      	 	<%}%>
        </select>
        <input name="opType" type="hidden" value="<%=request.getParameter("opType")%>">
        </select>
		  </td>          
           </tr>
    <!-- THE THIRD LINE OF THE CONTENT -->
       <tr >
      <td > ������� </td>
      <td >
			  <input name ="3_=_t2.accept_phone"  maxlength="15" type="text" id="accept_phone"  value="<%=(accept_phone==null)?"":accept_phone%>" onKeyUp="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
      </td> 
		        <td > ������� </td>
      <td >
			  <input name ="11_=_t2.fax_no" type="text" id="fax_no"  value="<%=(fax_no==null)?"":fax_no%>">
		  </td> 
		        <td > ����ʽ </td>
      <td >
		  <select name="13_=_t2.acceptid" id="acceptid" size="1" onChange="accid.value=this.options[this.selectedIndex].text">
		  	<%if(acceptid==null || acceptid.equals("") || request.getParameter("accid").equals("")|| request.getParameter("accid")==null){%>
		  	<option value="" selected>--��������ʽ--</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE</wtc:sql>
				</wtc:qoption>		  	
		  	<%}else {%>
      	 	 	<option value="" >--��������ʽ--</option>		  	
      	 			<option value="<%=acceptid%>" selected >
      	 				<%=request.getParameter("accid")%>
      	 			</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select accept_code , accept_code|| '-->' ||accept_name from SCALLACCEPTCODE where accept_code<>'<%=acceptid%>'</wtc:sql>
				</wtc:qoption>      	 	 	
      	 	<%}%>
        </select>
        <input name="accid" type="hidden" value="<%=request.getParameter("accid")%>"> 
		  </td>    
     </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" style="width:420px">
       <!--zhengjiang 20091004 ��ѯ�����û�λ��--> 
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
       <input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;">
			 <input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
        <!--<input name="exportAll" type="button"  id="add" value="����ȫ��" onClick="showExpWin('all')">-->
       
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
 	<table  cellspacing="0">
    <tr >
    <!--zhengjiang 20091016 add colspan="13"-->
      <td class="blue"  align="left" colspan="13">
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
        <!--modify hucw 20100830<a>����ѡ��</a>-->
	    	<span>����ѡ��</span>
        <select onChange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
     		</select style="height:18px">&nbsp;&nbsp;
        <!--modify hucw 20100830<a>������ת</a>-->
	    	<span>������ת</span>
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=����>GO</font>        
        <%}%>
      </td>
    </tr>
    <!--zhengjiang 20091016
  </table>
      <table  cellSpacing="0" >
    -->  
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
			 <input type="hidden" name="para" value="">
          <tr >
       <script>
       	var tempBool ='flase';
      	if(checkRole(K179A_RolesArr)==true||checkRole(K179B_RolesArr)==true||checkRole(K179C_RolesArr)==true){	
      		document.write('<th align="center" class="blue" width="15%" > ���� </th>');	
      		tempBool='true';
      	}
        </script>  
            <th align="center" class="blue" width="10%" nowrap > ��ˮ�� </th>
            <th align="center" class="blue" width="6%" nowrap > �ͻ����� </th>
             <th align="center" class="blue" width="7%" nowrap > �������</th>
             <th align="center" class="blue" width="7%" nowrap > ���к��� </th>
              <th align="center" class="blue" width="7%" nowrap > ����ʱ��</th>
             <th align="center" class="blue" width="7%"  nowrap > ����ʱ��</th>
              <th align="center" class="blue" width="5%" nowrap > ������ </th>
             <th align="center" class="blue" width="11%" nowrap > �һ��� </th>
             <th align="center" class="blue" width="6%" nowrap > �Ƿ��ʼ�</th>
                 <th align="center" class="blue" width="9%" nowrap >��������</th>
             <th align="center" class="blue" width="8%"  nowrap > ��ʼʱ��</th>
                 <th align="center" class="blue" width="8%" nowrap >����ʱ��</th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
                if((i+1)%2==1){
          tdClass="grey";
          
			      }
           %>
		<tr  >
      <script>
      	if(tempBool=='true'){
      		document.write('<td align="center" class="<%=tdClass%>"  >');
      	}
      	if(checkRole(K179A_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][6]%>\');return false;" alt="��ȡ����" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
        if(checkRole(K179B_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="getCallDetail(\'<%=dataRows[i][0]%>\',\'<%=start_date%>\');return false;" alt="��ʾ��ͨ������ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K179C_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=dataRows[i][0]%>\',1,\'<%=dataRows[i][6]%>\')" alt="�ƻ����ʼ쿼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}
      </script>
      <!--			
      <td align="center" class="<%=tdClass%>"  >
       <img onclick="checkCallListen('<%=dataRows[i][0]%>');return false;" alt="��ȡ����" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">
       <img onclick="getCallDetail('<%=dataRows[i][0]%>','<%=start_date%>');return false;" alt="��ʾ��ͨ������ϸ���" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif" width="16" height="16" align="absmiddle">
       <img onclick="checkIsQc('<%=dataRows[i][0]%>',1)" alt="�Ը���ˮ�����ʼ쿼��" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">
      </td>
      -->
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td><!--  modified by liujied 20090921 ��ʾΪboss����-->
       <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
    </tr>
      <% } %>
  <!--zhengjiang 20091016    
  </table>
  
  <table  cellspacing="0">
  add colspan="13"-->
    <tr >
      <td class="blue"  align="right" colspan="13">
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
        <!--modify hucw 20100830<a>����ѡ��</a>-->
	    	<span>����ѡ��</span>
        <select onChange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
     		</select style="height:18px">&nbsp;&nbsp;
        <!--modify hucw 20100830<a>������ת</a>-->
	    	<span>������ת</span>
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=����>GO</font>        
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
</body>
</html>

