<%
  /*
   * ����: �ʼ�����ϸ
�� * �汾: 1.0
�� * ����: 2008/10/20
�� * ����: hanjc
�� * ��Ȩ: sitech
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.* ,java.util.*,"%>

<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String myParams1="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

    String opCode="k209";
    String opName="�ʼ��ѯ-�ʼ�����ϸ��Ϣ";
    String tName="��ɾ���ʼ�����ϸ��Ϣ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 

    String contact_id   = request.getParameter("contact_id");
    String[][] detailRecList = new String[][]{};
    String[][] detailItemList = new String[][]{};
    String[][] detailItemSubListTemp = new String[][]{};
    ArrayList detailItemSubList = new ArrayList();
    String isPwdVer = request.getParameter("isPwdVer");
    if(null == isPwdVer||"".equals(isPwdVer)){
    		isPwdVer = "��";
    }
    String sqlStr="";
    String tableName = request.getParameter("tableName");
    String action = request.getParameter("myaction");
		
    if (contact_id!=null) {
    sqlStr = "select "                                             
            +"t1.recordernum,   " //������ˮ��
            +"t1.staffno,       " //���칤��
            +"t3.object_name,   " //�������
            +"t4.name,          " //��������
            +"to_char(decode(substr(to_char(trim(t1.score)),0,1),'.','0'||to_char(trim(t1.score)),to_char(t1.score)))," //�ܵ÷�
            +"t1.contentlevelid," //�ȼ�
            +"t1.evterno,       " //�ʼ칤��
            +"decode(t1.kind,'0','�Զ�����','1','�˹�ָ��'),          " //������ʽ
            +"decode(t1.checktype,'0','ʵʱ�ʼ�','1','�º��ʼ�'),     " //�������
            +"to_char(t1.starttime,'yyyyMMdd hh24:mi:ss'),     " //�ʼ쿪ʼʱ��
            +"to_char(t1.endtime,'yyyyMMdd hh24:mi:ss'),       " //�ʼ����ʱ��
            +"to_char(t1.dealduration),  " //����ʱ��
            +"to_char(t1.lisduration),   " //��������ʱ��
            +"to_char(t1.arrduration),   " //����ʱ��
            +"to_char(t1.evtduration),   " //�ʼ���ʱ��
            +"decode(t1.flag,'0','��ʱ����','1','���ύ','2','���ύ���޸�','3','��ȷ��','4','����'),          " //�ʼ���
            +"t1.signataryid,   " //ȷ����
            +"to_char(t1.affirmtime,'yyyyMMdd hh24:mi:ss'),    " //ȷ������
            +"t1.contentinsum,  " //���ݸ�Ҫ
            +"t1.handleinfo,    " //�������
            +"t1.improveadvice, " //�Ľ�����
            +"t1.commentinfo,   " //��������
            +"t1.trainadvice,    " //��ѵ����
            +"t1.objectid,   " //�������id
            +"t1.contentid    " //��������id           
            +"from dqcinfo t1,dqcobject t3,dqccheckcontect t4 where t1.serialnum= :contact_id";  
		String strJoinSql=" and t1.objectid=t3.object_id(+) "                                                    
                     +" and t1.contentid=t4.contect_id(+) "
                      +" and t1.is_del = 'Y' ";
    sqlStr +=strJoinSql; 
    myParams = "contact_id="+contact_id ;   
%>	         
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="25">
						<wtc:param value="<%=sqlStr%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
<%           
    	detailRecList = queryList;
    	if(detailRecList.length>0){
    	//zengzq modify 20091022  ���Ӳ�ѯ���ؽ���Ƿ����ֵĿ�����is_scored  'U'Ϊ��  'N'Ϊ��
         sqlStr="select t.item_name, t.formula, to_char(t.weight), t.item_id,t.is_scored  " +
               "from dqccheckitem t "+
               "where t.object_id =:detailRecList023 and t.contect_id =:detailRecList024 and t.bak1='Y' ";         
         String strParentSql=" and t.parent_item_id='0'  order by t.item_id"; 
         sqlStr += strParentSql; 
       myParams = "detailRecList023="+detailRecList[0][23]+",detailRecList024="+detailRecList[0][24] ;   
%>	            
			   		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="5">
			   			<wtc:param value="<%=sqlStr%>"/>
			   			<wtc:param value="<%=myParams%>"/>
			   		</wtc:service>
			   		<wtc:array id="resultList" scope="end"/>	
<%              
			   detailItemList = resultList;
    	   sqlStr = "select "
		            + "t1.item_name,"//������Ŀ
		            + "t1.formula,"  //��ʽ
		            + "to_char(t1.weight),"   //Ȩ��
		            + "decode(substr(to_char(trim(t2.score)),0,1),'.','0'||to_char(trim(t2.score)),to_char(t2.score)),"    //�÷�
		            + "to_char(t2.orgvalue), " //ԭʼֵ
		            + "t1.item_id "   //������Ŀid
		            + "from dqccheckitem t1, dqcinfodetail t2 where t1.object_id= :detailRecList023 and t1.contect_id=:detailRecList024  and t1.bak1='Y' and t2.serialnum= :contact_id";       
         strJoinSql=" and t1.object_id(+)=t2.objectid and t1.contect_id(+)=t2.contentid and t1.item_id=t2.itemid ";
         sqlStr+=strJoinSql;
         myParams = "detailRecList023="+detailRecList[0][23]+",detailRecList024="+detailRecList[0][24]+",contact_id="+contact_id ;
    	   for(int i=0;i<detailItemList.length;i++){
    	     	if("N".equals(detailItemList[i][4])){
    	   			strParentSql=" and t1.parent_item_id=:detailItemListi3 order by t1.item_id";
    	   			myParams1 = myParams+",detailItemListi3="+detailItemList[i][3];
	    	   	}else{
	    	   			strParentSql=" and t1.item_id=:detailItemListi3 order by t1.item_id";
	    	   			myParams1 = myParams+",detailItemListi3="+detailItemList[i][3];
	    	   	}
%>	            
			   		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
			   			<wtc:param value="<%=sqlStr+strParentSql%>"/>
			   			<wtc:param value="<%=myParams1%>"/>
			   		</wtc:service>
			   		<wtc:array id="detailItemListTemp" scope="end"/>	
<% 
	          detailItemSubListTemp=detailItemListTemp;
	          detailItemSubList.add(detailItemSubListTemp);
    	   }
     } 
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
<!--%@ include file="/npage/include/header.jsp"%-->
<%@ include file="/npage/callbosspage/checkWork/K203/check_header.jsp"%>

<div class="title" id="footer">	 
 		<div id="title_zi">��ˮ��&nbsp;</div><input name="contact_id" type="text"  id="contact_id" readonly value="<%=contact_id%>" disabled/>
   <input name="tableName" type="hidden" value="<%=tableName%>">
</div>

<br>
	<div id="Operation_Table" style="width:100%;">
		<div class="title"><div id="title_zi">������Ϣ</div></div>
		<table cellspacing="0">
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
	   <tr >
	     <td > ȷ���� </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][16].length()!=0)?detailRecList[0][16]:" &nbsp;"%></td>
	     <td > ȷ������ </td>
   		 <td ><%=(detailRecList.length!=0 && detailRecList[0][17].length()!=0)? detailRecList[0][17]:" &nbsp;"%></td>
	     <td colspan="4">&nbsp; </td>
	    </tr>
		</table> 
</div>

<div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">�ۺ�����</div></div>
		<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][21].length()!=0)? detailRecList[0][21]:" &nbsp;"%></td>
    </tr>
  </table>
</div>
	
	<div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">�������</div></div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][19].length()!=0)? detailRecList[0][19]:" &nbsp;"%></td>
    </tr>
  </table>
 </div>
	
  <div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">�Ľ�����</div></div>  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][20].length()!=0)? detailRecList[0][20]:" &nbsp;"%></td>
    </tr>
  </table>
</div>

		<div id="Operation_Table" style="width:100%;">
		<div class="title"><div id="title_zi">���ݸ�Ҫ</div></div>   
		<table cellspacing="0">
			 <tr >
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][18].length()!=0)? detailRecList[0][18]:" &nbsp;"%></td>
	    </tr>
	  </table>
	</div>
	
<!--updated by tangsong 20100830
<div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">��ѵ����</div></div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][22].length()!=0)? detailRecList[0][22]:" &nbsp;"%></td>
    </tr>
  </table>
</div>
-->
<div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">��Ŀ������Ϣ</div></div>	  
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

<%
           for ( int i = 0; i < detailItemList.length; i++ ) {
           String[][] tempList = (String[][])detailItemSubList.get(i);  
           String tmpIsScore = (detailItemList[i][4].length()!=0)?detailItemList[i][4]:"N";
           String tmpItemScore = "0";
           if("Y".equals(tmpIsScore)){
         				if(tempList!=null && tempList.length>0){
         						tmpItemScore = (tempList[0][3].length()!=0)?tempList[0][3]:"0";
         				}
           }
                String tdClass="";
%>
<%
          if((i+1)%2==1){
          tdClass="grey";
%>
          <tr  >
<%
					}else{
%>
	   			<tr  >
<%
					}
%>
      <td align="left" class="<%=tdClass%>"  ><%=(detailItemList[i][0].length()!=0)?detailItemList[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][1].length()!=0)?detailItemList[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][2].length()!=0)?detailItemList[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=tmpItemScore%></td>
      <td align="center" class="<%=tdClass%>"  >0</td>
    </tr>
<%
    if("N".equals(tmpIsScore)){
      for(int j=0;j<tempList.length;j++){
%>
       <tr>
        <td align="left" class="<%=tdClass%>"  >&nbsp;&nbsp;<%=(tempList[j][0].length()!=0)?tempList[j][0]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(tempList[j][1].length()!=0)?tempList[j][1]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(tempList[j][2].length()!=0)?tempList[j][2]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(tempList[j][3].length()!=0)?tempList[j][3]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(tempList[j][4].length()!=0)?tempList[j][4]:"&nbsp;"%></td>
       </tr>
<%
      }
    }
%>
<% 
      }
%>
  </table>
</div>

<div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">������֤��Ϣ</div></div>	  
			  <table  cellspacing="0">
    <tr >
			<td>
				<%=isPwdVer.equals("��")? "������֤" : "��֤"%>
			</td>
    </tr>
  </table>
</div>
<br>
<div id="Operation_Table" style="width:100%;">
   <input name="search" type="button"  id="search" value="����" onClick="javascript:window.close()"> &nbsp;&nbsp;
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

