<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��ϯǿ�Ʋ�����ѯ
�� * �汾: 1.0
�� * ����: 2008/10/17
�� * ����: donglei 
�� * ��Ȩ: sitech
   * 
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
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
    String opCode="K17A";
    String opName="�ۺϲ�ѯ-��ϯǿ�Ʋ�����ѯ";
     /*midify by yinzx 20091113 ������ѯ�����滻*/
 		String myParams=request.getParameter("para");     
 		 
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
		
  	String sqlStr = "select to_char(t1.operate_begin,'yyyy-MM-dd hh24:mi:ss'),t3.boss_login_no staffno,t4.boss_login_no operate_object,t2.forcetype_name from DAGENTOPRINFO t1,sforcetype t2,dloginmsgrelation t3,dloginmsgrelation t4 ";
  	String sqlJoinStr = " and t1.operate_type=t2.forcetype_code ";
        String strCountSql="select to_char(count(*)) count  from DAGENTOPRINFO t1,sforcetype t2,dloginmsgrelation t3,dloginmsgrelation t4 ";
		String strDateSql="";
    String strOrderSql=" order by t1.operate_begin desc";

    String start_date    =  request.getParameter("start_date");      
    String end_date      =  request.getParameter("end_date");        
//  String login_no      =  request.getParameter("0_=_t1.staffno");    
//  String be_login_no   =  request.getParameter("1_=_t1.operate_object");
    String login_no      =  request.getParameter("0_=_t3.boss_login_no");    
    String be_login_no   =  request.getParameter("1_=_t4.boss_login_no");
    String op_type       =  request.getParameter("2_=_t1.operate_type");     

    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp ="";
    String action = request.getParameter("myaction");
    String[] strHead= {"����ʱ��","ִ�й���","��ִ�й���","��������"};
    String[] strbind= {"",""};
	  String expFlag = request.getParameter("exp"); 
	  String sqlFilter = request.getParameter("sqlFilter");
	  //��ѯ����
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
				strDateSql=" where operate_begin>=to_date(:start_date,'yyyymmdd hh24:mi:ss') and t1.operate_begin<=to_date(:end_date,'yyyymmdd hh24:mi:ss')";
				myParams="start_date="+start_date.trim()+" ,end_date="+end_date.trim();
    	}
    	strbind=returnSql(request);
    	sqlFilter=strDateSql+strbind[0]+sqlJoinStr;
    	myParams+=strbind[1];
    	//added by liujied 20090921  modify by yinzx ������Ӧ���� ���� 20091116  �������һֱ�ۼ� ������
      sqlFilter += " and t1.staffno = t3.kf_login_no(+) and t1.operate_object = t4.kf_login_no(+) ";
    }
    
%>			
<%	if ("doLoad".equals(action)) {
      sqlStr+=sqlFilter+strOrderSql;
      sqlTemp = strCountSql+sqlFilter;
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
        //System.out.println("sql="+querySql);
        %>		           
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="4"   scope="end"/>
				<%
				dataRows = queryList;
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
<title>��ϯǿ�Ʋ�����ѯ</title>
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
		     showTip(document.sitechform.end_date,"ֻ�ܲ�ѯ�����ڵļ�¼"); 
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
   window.sitechform.action="k1710_forceOprDetailQry.jsp";
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
	 
   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
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
 window.location="k1710_forceOprDetailQry.jsp";
}

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k1710_forceOprDetailQry.jsp?exp="+expFlag;
    keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	  window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.para.value="<%=myParams%>";
    window.sitechform.end_date.value="<%=end_date%>";
    window.sitechform.opType.value="<%=request.getParameter("opType")%>";
    window.sitechform.op_type.value="<%=request.getParameter("2_=_t1.operate_type")%>";
    
    window.sitechform.login_no.value="<%=login_no%>";
    window.sitechform.be_login_no.value="<%=be_login_no%>";
}

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//��������
	function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
	  window.sitechform.sqlWhere.value="<%=sqlFilter%>";
	  window.sitechform.para.value="<%=myParams%>";
		openWinMid('k1710_expSelect.jsp?flag='+flag,'ѡ�񵼳���',340,320);
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
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
	<div id="Operation_Table">
		<table cellspacing="0" >
     <tr><td colspan='6' ><div class="title"><div id="title_zi">��ϯǿ�Ʋ�����ѯ</div></div></td></tr>
     <tr >
      <td > ��ʼʱ�� </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > ִ�й���</td>
      <td >
      <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^kf\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
				<input id="login_no" name="0_=_t3.boss_login_no" type="text" maxlength="10" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value=<%=(login_no==null)?"":login_no%> >
      </td>
		  <td > ��ִ�й��� </td>
      <td >
			  <input name ="1_=_t4.boss_login_no" type="text" id="be_login_no"  maxlength="10" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="<%=(be_login_no==null)?"":be_login_no%>">
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
       <td >��������</td>
      <td >
				<select name="2_=_t1.operate_type" id="op_type" size="1" onchange="opType.value=this.options[this.selectedIndex].text" >
        <%if(op_type==null || op_type.equals("")|| request.getParameter("opType").equals("")|| request.getParameter("opType")==null){%>
		  	<option value="" selected>--���в�������--</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select forcetype_code ,  '-->' ||forcetype_name from sforcetype order by forcetype_code</wtc:sql>
				</wtc:qoption>		  	
		  	<%}else {%>
           <option value="" >--���в�������--</option>
      	 		<option value="<%=op_type%>" selected >
      	 			<%=request.getParameter("opType")%>
      	 		</option>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql>select forcetype_code ,  '-->' ||forcetype_name from sforcetype where forcetype_code<>'<%=op_type%>' order by forcetype_code</wtc:sql>
				</wtc:qoption>      	 	 	
      	 	<%}%>
        </select>
        <input name="opType" type="hidden" value="<%=request.getParameter("opType")%>">
        </select>
      </td> 
		  <td colspan="2">&nbsp; </td>       
     </tr>
	 <tr >
      
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
      <td class="blue"  align="left" colspan="4">
	
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
		        <% for(int i=1;i<=pageCount;i++){
		        	out.print("<option value='"+i+"'");
		        	if(i==curPage){
		        	 out.print("selected");
		        	}
		        	out.print(">"+i+"</option>");
		        }%>
      		</select>&nbsp;&nbsp;
	        <!--modify hucw 20100830<a>������ת</a>-->
		    	<span>������ת</span>
	        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
	        <font face=����>GO</font>          
        <%}%>
      </td>
    </tr>

			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
			  <input type="hidden" name="para" value="">
          <tr >
            <th align="center" class="blue" width="30%" > ����ʱ�� </th>
            <th align="center" class="blue" width="25%" > ִ�й��� </th>
            <th align="center" class="blue" width="25%" > ��ִ�й���</th>
            <th align="center" class="blue" width="25%"  > �������� </th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr  >
			<%}else{%>
	   <tr  >
	<%}%>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
       <td align="center" class="<%=tdClass%>" ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
    </tr>
      <% } %>

    <tr >
      <td class="blue"  align="right" colspan="4">
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
<!--
<%@ include file="/npage/include/footer.jsp"%>
-->
</body>
</html>

