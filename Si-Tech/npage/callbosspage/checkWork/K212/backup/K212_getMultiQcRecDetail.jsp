<%
  /*
   * ����: �����ʼ�����ϸ
�� * �汾: 1.0
�� * ����: 2008/10/20
�� * ����: hanjc
�� * ��Ȩ: sitech
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.* "%>

<%
    String opCode="k212";
    String opName="�ʼ��ѯ-�����ʼ�����ϸ��Ϣ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 

    String contact_id   = request.getParameter("contact_id");
    String[][] detailRecList = new String[][]{};
    String[][] detailItemList = new String[][]{};
    String isPwdVer = "N";
    String sqlStr="";
    String tableName = request.getParameter("tableName");
    String action = request.getParameter("myaction");
		
    if (contact_id!=null) {
    sqlStr = "select "                                             
            +"t1.recordernum,   " //������ˮ��
            +"t1.staffno,       " //���칤��
            +"t3.object_name,   " //�������
            +"t4.name,          " //��������
            +"t1.score,         " //�ܵ÷�
            +"t1.contentlevelid," //�ȼ�
            +"t1.evterno,       " //�ʼ칤��
            +"t1.kind,          " //������ʽ
            +"t1.checktype,     " //�������
            +"t1.starttime,     " //�ʼ쿪ʼʱ��
            +"t1.endtime,       " //�ʼ����ʱ��
            +"t1.dealduration,  " //����ʱ��
            +"t1.lisduration,   " //��������ʱ��
            +"t1.arrduration,   " //����ʱ��
            +"t1.evtduration,   " //�ʼ���ʱ��
            +"t1.flag,          " //�ʼ���
            +"t1.contentinsum,  " //���ݸ�Ҫ
            +"t1.handleinfo,    " //�������
            +"t1.improveadvice, " //�Ľ�����
            +"t1.trainadvice    " //��ѵ����
            +"from dqcmulinfo t1,dqcobject t3,dqccheckcontect t4 where t1.serialnum= '"+contact_id+"'";  
		String strJoinSql=" and t1.objectid=t3.object_id(+) "                                                    
                     +" and t1.contentid=t4.contect_id(+) ";
    sqlStr +=strJoinSql;    
    System.out.println("==========sqlStr=========="+sqlStr);
%>	         
					<wtc:service name="s151Select" outnum="20">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
<%           
    		detailRecList = queryList;
    	System.out.println("==========detailRecList.length========"+detailRecList.length);
    	sqlStr = "select "
        +"t2.item_name"//������Ŀ
        +"t2.formula"  //��ʽ
        +"t1.weight"   //Ȩ��
        +"t1.score"    //�÷�
        +"t1.orgvalue" //ԭʼֵ
        +"from dqcmulinfodetail t1,dqccheckitem t2 where t1.serialnum="+contact_id;
        
      strJoinSql=" and t1.itemid=t2.item_id ";
      sqlStr += strJoinSql;

%>	         
					<wtc:service name="s151Select" outnum="5">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
<%           
				detailItemList = queryList;
    	System.out.println("detailItemList============length=="+detailItemList.length);
    	System.out.println("sqlStr=====2=======value=="+sqlStr);
}             
%>	         


<html>
<head>
<title>�ʼ�����ϸ��Ϣ</title>
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
function submitInput(url){
   if( document.sitechform.contact_id.value == ""){
    	  showTip(document.sitechform.contact_id,"��ˮ�Ų���Ϊ�գ�������ѡ�������");
        sitechform.contact_id.focus();
    }   
    else {
    	
    hiddenTip(document.sitechform.contact_id);
    doSubmit(url);
    }
}
function doSubmit(url){
    window.sitechform.action=url;
    window.sitechform.method='post';
    window.sitechform.submit();
}

//�رմ���
function closeWin(){
  window.close();	
}


</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
		<div class="title" id="footer">	 
 		��ˮ��&nbsp;<input name="contact_id" type="text"  id="contact_id" value="<%=contact_id%>" >
   <input name="tableName" type="hidden" value="<%=tableName%>">
</div>

<br>
	<div id="Operation_Table">
		<div class="title">������Ϣ</div>
		<table cellspacing="0">
    <!-- THE FIRST LINE OF THE CONTENT -->
      <tr >
	     <td > ������ˮ�� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][0].length()!=0)? detailRecList[0][0]:"&nbsp;"%></td>
	     <td > ���칤�� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][1].length()!=0)? detailRecList[0][1]:"&nbsp; "%></td>
	     <td > ������� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][2].length()!=0)? detailRecList[0][2]:" &nbsp;"%></td>
	     <td > �������� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][3].length()!=0)? detailRecList[0][3]:" &nbsp;"%></td>
	   </tr>
	   <!-- THE SECOND LINE OF THE CONTENT -->
	   <tr >
	     <td > �÷� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][4].length()!=0)? detailRecList[0][4]:" &nbsp;"%></td>
	     <td > �ȼ� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][5].length()!=0)? detailRecList[0][5]:" &nbsp;"%></td>
	     <td > �ʼ칤�� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][6].length()!=0)? detailRecList[0][6]:" &nbsp;"%></td>
	     <td > ������ʽ </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][7].length()!=0)? detailRecList[0][7]:" &nbsp;"%></td>   
	    </tr>
	    
	  <!-- THE THIRD LINE OF THE CONTENT -->
	   <tr >
	     <td > ������� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][8].length()!=0)? detailRecList[0][8]:" &nbsp;"%></td>
	     <td > �ʼ쿪ʼʱ�� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][9].length()!=0)? detailRecList[0][9]:" &nbsp;"%></td> 
	     <td>�ʼ����ʱ�� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][10].length()!=0)? detailRecList[0][10]:" &nbsp;"%></td>
	     <td > �ʼ�ʱ�� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][11].length()!=0)? detailRecList[0][11]:" &nbsp;"%></td>   
	    </tr>
	    
	   <!-- THE FOURTH LINE OF THE CONTENT -->
	   <tr >
	     <td > ��������ʱ�� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][12].length()!=0)? detailRecList[0][12]:" &nbsp;"%></td>
	     <td > ����ʱ�� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][13].length()!=0)? detailRecList[0][13]:" &nbsp;"%>
	     </td> 
	     <td >���ʼ�ʱ�� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][14].length()!=0)? detailRecList[0][14]:" &nbsp;"%>
	     </td>
	     <td > �ʼ��� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][15].length()!=0)? detailRecList[0][15]:" &nbsp;"%>
	     </td>   
	    </tr>
		</table> 

</div>
		<div id="Operation_Table">
		<div class="title">���ݸ�Ҫ</div>	   
		<table cellspacing="0">
			 <tr >
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][16].length()!=0)? detailRecList[0][16]:" &nbsp;"%></td>
	    </tr>
	  </table>
	</div>
	
	<div id="Operation_Table">
  	<div class="title">�������</div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][17].length()!=0)? detailRecList[0][17]:" &nbsp;"%></td>
    </tr>
  </table>
 </div>
	
  <div id="Operation_Table">
  	<div class="title">�Ľ�����</div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][18].length()!=0)? detailRecList[0][18]:" &nbsp;"%></td>
    </tr>
  </table>
</div>

<div id="Operation_Table">
  	<div class="title">��ѵ����</div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][19].length()!=0)? detailRecList[0][19]:" &nbsp;"%></td>
    </tr>
  </table>
</div>

<div id="Operation_Table">
  	<div class="title">��Ŀ������Ϣ</div>	  
      <table  cellSpacing="0" >
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
          <tr >
            <th align="center" class="blue" width="25%" > ������Ŀ </th>
            <th align="center" class="blue" width="30%" > ��ʽ </th>
            <th align="center" class="blue" width="15%" > Ȩ�� </th>
            <th align="center" class="blue" width="15%" > �÷� </th>
            <th align="center" class="blue" width="15%" > ԭʼֵ </th>
          </tr>

          <% for ( int i = 0; i < detailRecList.length; i++ ) {             
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr  >
			<%}else{%>
	   <tr  >
	<%}%>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][0].length()!=0)?detailItemList[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][1].length()!=0)?detailItemList[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][2].length()!=0)?detailItemList[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][3].length()!=0)?detailItemList[i][3]:"&nbsp;"%></td>
    </tr>
      <% } %>
  </table>
</div>

<div id="Operation_Table">
  	<div class="title">������֤��Ϣ</div>	  
			  <table  cellspacing="0">
    <tr >
			<td>
				<%=isPwdVer.equals("Y")? "��֤" : "������֤"%>
			</td>
    </tr>
  </table>
</div>
<br>
<div id="Operation_Table" >
   <input name="search" type="button"  id="search" value="����" onClick="javascript:window.close()"> &nbsp;&nbsp;
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

