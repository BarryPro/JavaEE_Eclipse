<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%!
//����Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " ��ʼ����Excel�ļ� " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "֪ͨ���Ͳ�ѯ";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
           System.out.println( " ����Excel�ļ�[�ɹ�] ");
        }catch  (Exception e1) {
           System.out.println( " ����Excel�ļ�[ʧ��] ");
           e1.printStackTrace();
        } 
    }
    
%>
<%
    String opCode="";
    String opName="��������Ӧ��ϵ";
    
    String Caller_Call_Out_Phone = "";
    String Class_Name = "";
    String Region_Code = "";
    String Note = "";

    
    
    
             //��������
    String[][] dataRows = new String[][]{};
    String[][] dataTemp = new String[][]{};
    int rowCount=0;
    int pageSize = 10;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlStr="";
    String[] strHead= {"���͹���","���չ���","֪ͨ����","����ʱ��","��Ϣ���"};
    String action = "doLoad";
	  String expFlag = request.getParameter("exp");        //������ʾ
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String params = "";

    if ("doLoad".equals(action)) {
        String sqlTemp = " SELECT count(*) FROM Dcallercalloutphone c  ";
%>	
					<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=sqlTemp%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
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
        sqlStr = "SELECT c.caller_call_out_id,c.Caller_Call_Out_Phone,s.Class_Name,c.Region_Code,r.Region_Name,c.Note,c.outflag FROM Dcallercalloutphone c ,scallclass s,scallregioncode r WHERE s.Class_Id = c.Classid AND c.Region_Code = r.Region_Code(+)";     
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));

%>	
					<wtc:service name="TlsPubSelCrm" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="8" scope="end"/>	
<% 
					dataRows=queryList;
}


    //������ǰ��ʾ����
   if("cur".equalsIgnoreCase(expFlag)){    
String sqlTemp = " SELECT count(*) FROM Dcallercalloutphone c  ";
%>	
					<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=sqlTemp%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
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
        sqlStr = "SELECT c.caller_call_out_id,c.Caller_Call_Out_Phone,s.Class_Name,c.Region_Code,c.Note FROM Dcallercalloutphone c ,scallclass s WHERE s.Class_Id = c.Classid";     

%>	
					<wtc:service name="TlsPubSelCrm" outnum="13" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="1" length="12" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){    
				sqlStr = "SELECT c.caller_call_out_id,c.Caller_Call_Out_Phone,s.Class_Name,c.Region_Code,c.Note FROM Dcallercalloutphone c ,scallclass s WHERE s.Class_Id = c.Classid";     

%>	
					<wtc:service name="TlsPubSelCrm" outnum="12" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="12" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }
%>

<html>
<head>
<title>��������Ӧ��ϵ</title>
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

function doSubmit(){
    window.sitechform.myaction.value="doLoad";
    window.sitechform.action="list.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
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
   window.sitechform.myaction.value="doLoad";
   keepValue();
   window.sitechform.action="list.jsp";
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

//����
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k180/K310_query_total.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){

}

function deleteCheck(){
	var planNo=document.getElementById("checkPlanNo").value;
	if(planNo=='')
	{
	//alert("û��ѡ��Ҫɾ���ļ�¼");
	rdShowMessageDialog("û��ѡ��Ҫɾ���ļ�¼!",1);	
	return false;
	}
	if(rdShowConfirmDialog("��ȷ����Ҫɾ��������¼��")=="1"){
		deleteRec(planNo);
	}
}

function mendCheck(){
	 var planNo=document.getElementById("checkPlanNo").value;
	if(planNo=='')
	{
	//alert("û��ѡ��Ҫ�޸ĵļ�¼");
	rdShowMessageDialog("û��ѡ��Ҫ�޸ĵļ�¼!",1);		
	return false;
	}
	var height = 700;
	var width = 1000;
	var top = screen.availHeight/2 - height/2;
	var left=screen.availWidth/2 - width/2;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
	
	window.open("../../../../npage/callbosspage/callerGroup/modify.jsp?id="+planNo, "outHelp", winParam);
	

}
//ɾ����¼
function deleteRec(msg_id){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/callerGroup/delete.jsp","����ɾ����ؼ�¼�����Ժ�......");
	mypacket.data.add("msg_id",msg_id);
  core.ajax.sendPacket(mypacket,doProcess,false);
	mypacket=null;
}

function doProcess(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		rdShowMessageDialog("ɾ���ɹ���",2);
		window.sitechform.myaction.value="doLoad";
    window.sitechform.action="list.jsp";
    window.sitechform.method='post';
    document.sitechform.submit();
	}else{
		rdShowMessageDialog("ɾ��ʧ�ܣ�");
	}
}

</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>


  <div id="Operation_Table">
      <table  cellSpacing="0" >
      	<input type="hidden" name="checkPlanNo" value="">
      	<input type="hidden" name="myaction" value="">
      	<input type="hidden" name="page" value="">
  
          <tr >
          	<th align="center" class="blue" width="10%"  > ѡ�� </th>
            <th align="center" class="blue" width="15%"  > �������� </th>
            <th align="center" class="blue" width="15%" > ���� </th>
            <th align="center" class="blue" width="20%" > ���� </th>
            <th align="center" class="blue" width="20%" > ��ע </th>
            <th align="center" class="blue" width="20%" > �������� </th>

          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>

          <%if((i+1)%2==1){
          tdClass="grey";
          
          %>
          <tr >
			<%}else{%>
	   <tr  >
	<%}%>
      <td align="center" class="<%=tdClass%>" ><input type="radio" name="plan_id" onclick="setPlanNo('<%=i%>');" value="<%=dataRows[i][0]%>"/></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][7].equals("Y"))?"��������":"�������"%></td>
      <input type="hidden" name ="plan_id<%=i%>"  value="<%=dataRows[i][1]%>">
     
      <% } 
      %>
      

  </table>   
  <table  cellspacing="0">
    <tr >
      <td class="blue"  align="right" width="720">
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
        <%}%>
      </td>
    </tr>
  </table>
  
       <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
          <input class="b_foot" name="addContent" type="button" value="����" onclick="submitQcContent()">
        	<input class="b_foot" name="modifyOne" type="button"  value="�޸�" onclick="mendCheck();" >
       		<input class="b_foot" name="deletOne" type="button"  value="ɾ��" onclick="deleteCheck();" >
        
        </td>
       </tr>   
     </table>
   
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>
<script language="javascript">

function setPlanNo(planNop)
{
  var nono = "plan_id"+planNop;
	document.getElementById("checkPlanNo").value =document.getElementById(nono).value;

}
function submitQcContent()
{
		var height = 700;
		var width = 1000;
		var top = screen.availHeight/2 - height/2;
		var left=screen.availWidth/2 - width/2;
		var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
		//alert(winParam);
	  window.open("../../../../npage/callbosspage/callerGroup/callerGroupMain.jsp", "outHelp", winParam);
}


function viewCheck1(){
	 var planNo=document.getElementById("checkPlanNo").value;
	 
	if(planNo=='')
	{
	//alert("û��ѡ��Ҫ�鿴�ļ�¼");	
	rdShowMessageDialog("û��ѡ��Ҫ�鿴�ļ�¼!",1);
	return false;
	}
	var height = 300;
	var width = 420;
	var top = screen.availHeight/2 - height/2;
	var left=screen.availWidth/2 - width/2;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
	window.open("../../../../npage/callbosspage/checkWork/K310/K310_query_detail_checkPerson.jsp?plan_id="+planNo, "outHelp", winParam);
	

}
</script>


