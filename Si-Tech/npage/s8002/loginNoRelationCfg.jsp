<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ���Ź�ϵ������-��ѯ����
�� * �汾: 1.0
�� * ����: 2009/06/06
�� * ����: donglei 
�� * ��Ȩ: sitech
   * update yinzx 090715  �ͷ����� 1.sPubSelect ����ոʱ�滻Ϊs151Select ��ʽ���滻����
   *                               2.�޸�ԭ�߼����� start=1����Ϊstart=0            
   *  														 3.����'k%' �ж�
   * update yinzx 090825 ��dloginmsgrelation �ŵ�boss����
 ��*/
 %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*"%>

<%

    String opCode="K096";
    String opName="���Ź�ϵ������";
	  String loginNo = (String)session.getAttribute("workNo");
	      /*midify by yinzx 20091113 ������ѯ�����滻*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
 	     
  	String sqlStr = "SELECT T.LOGIN_NO,T1.KF_LOGIN_NO,T.LOGIN_NAME,T1.CREATE_LOGIN_NO,to_char(T1.CREATE_DATE,'yyyy-Mm-dd hh24:mi:ss'),T1.UPDATE_LOGIN_NO,to_char(T1.UPDATE_DATE,'yyyy-Mm-dd hh24:mi:ss'),decode(T1.VALID_FLAG,'Y','����','N','ʧЧ',NULL,'δ��'),T1.VALID_FLAG ";
  	       sqlStr+= "FROM DLOGINMSG T,DLOGINMSGRELATION T1 ";
  	       sqlStr+= "WHERE T.LOGIN_NO=T1.BOSS_LOGIN_NO(+) and substr(t.login_no,1,1)='8'";
		String strCountSql="select to_char(count(*)) FROM DLOGINMSG T,DLOGINMSGRELATION T1 WHERE T.LOGIN_NO=T1.BOSS_LOGIN_NO(+)  and substr(t.login_no,1,1)='8'";
    String strOrderSql=" order by t1.CREATE_DATE desc ";

    String boss_login_no =  request.getParameter("boss_login_no");       //��ʼʱ��
    String kf_login_no   =  request.getParameter("kf_login_no");         //����ʱ��
    String login_name  =  request.getParameter("login_name");    //ip��ַ
    String login_status   =  request.getParameter("login_status");     //����
    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp="";
    String action = request.getParameter("myaction");
		String sqlFilter = request.getParameter("sqlFilter");
	  //��ѯ����
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(boss_login_no!=null&&!("").equals(boss_login_no)){
      	sqlFilter+="and T.login_no like '%'||:boss_login_no||'%' ";
      	myParams+="boss_login_no="+boss_login_no.trim();
    	}
    	if(kf_login_no!=null&&!("").equals(kf_login_no)){
      	sqlFilter+="and T1.kf_login_no like '%'||:kf_login_no||'%'";
      	myParams+=",kf_login_no="+kf_login_no.trim();
    	}
    	if(login_name!=null&&!("").equals(login_name)){
      	sqlFilter+="and T.login_name like '%'||:vlogin_name||'%'";
      	myParams+=",vlogin_name="+login_name.trim();
    	}
    	//״̬�ж�
    	if(login_status!=null&&!("").equals(login_status)){
      	if("Y".equals(login_status)){
      	sqlFilter+=" and T1.VALID_FLAG ='Y'"; 
      	}
      	if("N".equals(login_status)){
      	sqlFilter+=" and T1.VALID_FLAG ='N'"; 
      	}
      	if("S".equals(login_status)){
      	sqlFilter+=" and T1.VALID_FLAG is null"; 
      	}
    	}
    }
%>	
			
<%	if ("doLoad".equals(action)) {
				sqlStr+=sqlFilter+strOrderSql;
        sqlTemp = strCountSql+sqlFilter;
        
        System.out.println("---------sqlTemp------------"+sqlTemp);
    	  %>	             
					<wtc:service  name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
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
        
        System.out.println("-----------curPage---------------|"+curPage);
        System.out.println("-----------pageSize--------------|"+pageSize);
        System.out.println("-----------rowCount--------------|"+rowCount);
        
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        System.out.println("-------querySql----------"+querySql);
        System.out.println("-------myParams----------"+myParams);
        %>		           
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="10">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="9"   scope="end"/>
				<%
				dataRows = queryList;
				
				
    }
    
%>

<html>
<head>
<title>���Ź�ϵ������</title>
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
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
//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInputCheck(){
    window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
    window.sitechform.sqlWhere.value="<%=sqlFilter%>";  
    submitMe();
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="loginNoRelationCfg.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}

//��ת��ָ��ҳ��
function jumpToPage(operateCode){
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
//=========================================================================
// LOAD PAGES.
//=========================================================================
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
	  	e[i].value="";
  }
 }
      window.location="loginNoRelationCfg.jsp";
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.boss_login_no.value="<%=boss_login_no%>";
	window.sitechform.kf_login_no.value="<%=kf_login_no%>";
	window.sitechform.login_name.value="<%=login_name%>";
	window.sitechform.login_status.value="<%=login_status%>";
	window.sitechform.oper.value="<%=request.getParameter("oper")%>";
}

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
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
//������ϵ 
function addRelation(boss_login_no){
  openWinMid('addLoginNoRelation.jsp?boss_login_no='+boss_login_no,'�������Ű󶨹�ϵ',200,300); 
}
//�޸Ĺ�ϵ 
function modifyRelation(boss_login_no,kf_login_no,flag){
   openWinMid('modifyLoginNoRelation.jsp?boss_login_no='+boss_login_no+'&kf_login_no='+kf_login_no+'&flag='+flag,'�޸Ĺ��Ű󶨹�ϵ',200,300); 
}
//ɾ����ϵ 
function delRelation(boss_login_no){
	var packet = new AJAXPacket("loginNoRelation_rpc.jsp","...");
	packet.data.add("retType","delRelation");
	packet.data.add("boss_login_no",boss_login_no);
	core.ajax.sendPacket(packet,doProcessDelRelation,true);
	packet=null;
}

/**
  *���ش�����
  */
function doProcessDelRelation(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	if (retType == 'delRelation' && retCode == "000000") {
		rdShowMessageDialog("�󶨹�ϵɾ���ɹ���");		
	  document.sitechform.search.click();
	} else {
		rdShowMessageDialog("�󶨹�ϵɾ��ʧ�ܣ�");
	}
	
}


function EnterKey(){ 

  if(event.keyCode==13)   
  {   
  document.sitechform.search.focus();
  document.sitechform.search.click();
  
  }   
  }   


function historyGo(){
	
	location = "f8002.jsp";	
}
</script>
</head>


<body >
<form id="sitechform" name="sitechform">
<div id="Main">
		 
   <DIV id="Operation_Table"> 

		<div class="title"><div id="title_zi">���Ź�ϵ������</div></div>
		<table cellspacing="0" onkeydown="EnterKey();">
    <!-- THE FIRST LINE OF THE CONTENT -->
     <tr >
      <td > BOSS���� </td>
      <td >
				<input  id="boss_login_no" name="boss_login_no" type="text" maxlength="6"   value="<%=(boss_login_no==null)?"":boss_login_no%>"  >
        
      </td>
      <td > ƽ̨���� </td>
      <td >
				<input id="kf_login_no" name="kf_login_no" type="text" maxlength="6"   value="<%=(kf_login_no==null)?"":kf_login_no%>" >

      </td>
    </tr>
    <tr>
		  <td > �������� </td>
      <td >
			  <input name ="login_name" type="text" id="login_name"  value="<%=(login_name==null)?"":login_name%>">
      </td> 
      <td >״̬ </td>
      <td >
			  <select id="login_status" name="login_status" size="1" onchange="this.value=login_status.options[this.selectedIndex].value;oper.value=login_status.options[this.selectedIndex].value;">
			 	<%if(login_status==null || ("").equals(login_status)|| request.getParameter("oper")==null || ("").equals(request.getParameter("oper"))){%>
			 	<option value="" selected>--ȫ��--</option>
			 	<option value="Y" >--����--</option>
        <option value="N" >--ʧЧ--</option>
        <option value="S" >--δ��--</option>
			 	<%}else{
			 	 if(("Y").equals(request.getParameter("oper"))){
			 	  %>
			 	<option value="Y" selected>--����--</option>
        <option value="N" >--ʧЧ--</option>
        <option value="S" >--δ��--</option>
        <option value=""  >--ȫ��--</option>
			 	<%}else if(("N").equals(request.getParameter("oper"))){%>
			 	<option value="Y" >--����--</option>
        <option value="N" selected>--ʧЧ--</option>
        <option value="S" >--δ��--</option>
        <option value=""  >--ȫ��--</option>
        <%}else if(("S").equals(request.getParameter("oper"))){%>
			 	<option value="Y" >--����--</option>
        <option value="N" >--ʧЧ--</option>
        <option value="S" selected>--δ��--</option>
        <option value=""  >--ȫ��--</option>
			 	<%}}%>
      	 </select>
			  <input name="oper" type="hidden" value="<%=request.getParameter("oper")%>">
      </td> 
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" >
      	<input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
        <input name="clear" type="button"  id="clear" value="����" onClick="clearValue();return false;">              
        <input name="retbut" type="button"  id="retbut" value="����"  class="b_foot" onClick="historyGo();return false;">              
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
  	<table  cellspacing="0">
    <tr >
      <td class="blue"  align="left">
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
        <a>����ѡ��</a>
        <select onchange="jumpToPage(this.value)">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <a>������ת</a> 
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=����>GO</font>        
        <%}%>
      </td>
    </tr>
  </table>
      <table  cellSpacing="0">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
          <tr > 
            <th align="center" class="Blue" width="10%" >BOSS����</th>
            <th align="center" class="Blue" width="10%" >ƽ̨����</th>
            <th align="center" class="blue" width="10%" >��������</th>
            <th align="center" class="blue" width="10%" >��������</th>
            <th align="center" class="blue" width="10%" >����ʱ��</th>
            <th align="center" class="blue" width="10%" >�޸Ĺ���</th>
            <th align="center" class="blue" width="10%" >�޸�ʱ��</th>
            <th align="center" class="blue" width="10%" >״̬</th>
            <th align="center" class="blue" width="10%" >����</th>
         </tr>                                                          
          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="one";
           %>
          <%if((i+1)%2==1){ 
          			tdClass="two";
          %>
          <tr  >
			<%}else{%>
	   <tr  >
	<%}%>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td> 
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%if(dataRows[i][1]==null||("").equals(dataRows[i][1])){%><a href="#" onclick="addRelation('<%=dataRows[i][0]%>');return false;">��</a>
        <%}else{%>
        <a href="#" onclick="modifyRelation('<%=dataRows[i][0]%>','<%=dataRows[i][1]%>','<%=dataRows[i][8]%>');return false;">�޸�</a>
        <a href="#" onclick="delRelation('<%=dataRows[i][0]%>');return false;">ɾ��</a>
        <%}%></td>     
    </tr>
      <% } %> 
  </table>
  
  <table  cellspacing="0"> 
    <tr >
      <td class="blue"  align="right">
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
        <a>����ѡ��</a>
        <select onchange="jumpToPage(this.value)">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <a>������ת</a> 
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=����>GO</font>        
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>


	<%if(sqlFilter==null){%>
		<script language=javascript>
			submitInputCheck();
		</script>
	<%}%>

</html>


