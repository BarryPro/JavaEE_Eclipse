<%
  /*
   * ����: ͨ���ͻ�����ģ�������û���Ϣ
�� * �汾: 1.0
�� * ����: 2008/12/24
�� * ����: hanjc
�� * ��Ȩ: sitech
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode="";
    String opName="�û���Ϣ";
	  String loginNo = (String)session.getAttribute("workNo");  
    String orgCode = (String)session.getAttribute("orgCode");
    if(orgCode==null){
      orgCode="0101";
    }
    String regionCode=orgCode.substring(0,2);
    String cust_name   = request.getParameter("cust_name");         //��ʼʱ��
    
    String[][] dataRows = new String[][]{};
    String action = request.getParameter("myaction");
    
    if("doLoad".equals(action)){

%>	
					<wtc:service name="sPubSelect" outnum="7">
						<wtc:param value="<%=cust_name%>"/>
					  <wtc:param value="<%=regionCode%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
 <%}%>
<html>
<head>
<title>����ҵ��</title>
<script language=javascript>

//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInput(){
	if( document.sitechform.cust_name.value == ""){
    	  showTip(document.sitechform.cust_name,"�ͻ���������Ϊ�գ�");
        sitechform.cust_name.focus();
  }else {
     hiddenTip(document.sitechform.cust_name);
     doSubmit();
	}
}

//�ύ
function doSubmit(){
	  window.sitechform.myaction.value="doLoad";
    window.sitechform.action="K182_getCustInfoQry.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}

//�������¼
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text")
   e[i].value="";
 }
}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">��ѯ����</div>
		<table cellspacing="0">
    <!-- THE FIRST LINE OF THE CONTENT -->
      <tr >
       <td align="center"> �ͻ�����  </td>
	     <td width="90%">
			  <input name="cust_name" type="text" value="<%=(cust_name==null)?"":cust_name%>" onkeyup="hiddenTip(this);">    
        <font color="orange">*</font>
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInput()"> &nbsp;&nbsp;
       
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">

      <table  cellSpacing="0" >
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  
          <tr >
            <th align="center" class="blue" width="15%" > �������</th>
            <th align="center" class="blue" width="20%" > �û�����</th>
            <th align="center" class="blue" width="15%" > �û���ַ</th>
            <th align="center" class="blue" width="12%" > ���֤��</th>
            <th align="center" class="blue" width="20%" > �ʱ�    </th>
            <th align="center" class="blue" width="18%" > �û�״̬</th>
          <th align="center" class="blue" width="18%"   >����ʱ�� </th>
          </tr> 
         <% for ( int i = 0; i < dataRows.length; i++ ) {             
           String tdClass="";
           if((i+1)%2==1){
             tdClass="grey";
            } 
           %>
       <tr>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      </tr>
      <% } %>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

