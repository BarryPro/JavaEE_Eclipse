<%
   /*
   * ����: ʧ��ԭ��ά��
   * �汾: 1.0.0
   * ����: 
   * ����: 
   * ��Ȩ: sitech
   * update: yinzx 0716 �ͷ�����
   * 1.�޸�opCode opName��
   * 2.�淶��ʽ�ĵ���
   * 3.Դ��������߼�����,��������ݵ�λ�÷�����
   * 4.ΪsqlStr���"order by to_number(s.failure_code)"
   * modify wangyongjl 20090717 ������ʽ
   ��*/	
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
        try{
        String opCode="K411";
        String opName="ʧ��ԭ��ά��";
        String org_code = (String)session.getAttribute("orgCode");
 	      String regionCode = org_code.substring(0,2);
 	  
 	      
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


        if ("doLoad".equals(action)) {
        String sqlTemp = " select to_char(count(*)) from scalloutfailreson s  ";
        %>	
     <wtc:service  name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
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
        sqlStr = "select s.failure_code,s.failure_name from scalloutfailreson s";
        sqlStr += " order by to_number(s.failure_code)";    
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        
      

        %>	
     <wtc:service  name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
       <wtc:param value="<%=querySql%>"/>
     </wtc:service>
     <wtc:array id="queryList"  start="0" length="3" scope="end"/>	
     <% 

        
				dataRows=queryList;
        
        }



        //������ǰ��ʾ����
        if("cur".equalsIgnoreCase(expFlag)){    
        String sqlTemp = " select count(*) from scalloutfailreson s  ";
        %>	
     <wtc:service  name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
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
        sqlStr = "select s.failure_code,s.failure_name from scalloutfailreson s";     

        %>	
     <wtc:service  name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
       <wtc:param value="<%=sqlStr%>"/>
     </wtc:service>
     <wtc:array id="queryList"  start="1" length="2" scope="end"/>	
     <% 
	this.toExcel(queryList,strHead,response);
        }
        if("all".equalsIgnoreCase(expFlag)){    
	sqlStr = "select s.failure_code,s.failure_name from scalloutfailreson s";     

        %>	
     <wtc:service  name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
       <wtc:param value="<%=sqlStr%>"/>
     </wtc:service>
     <wtc:array id="queryList" start="0" length="2" scope="end"/>	
     <% 
	this.toExcel(queryList,strHead,response);
        }
        %>

     <html>
       <head>
         <title>���ʧ��ԭ��</title>
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
	                   alert("û��ѡ��Ҫɾ���ļ�¼");	
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
	                   alert("û��ѡ��Ҫ�޸ĵļ�¼");	
	                   return false;
	                   }
	                   var height = 700;
	                   var width = 1000;
	                   var top = screen.availHeight/2 - height/2;
	                   var left=screen.availWidth/2 - width/2;
	                   var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
                           openWinMid('modify.jsp?id='+planNo,'ʧ��ԭ���޸�',260,390); 
                           }
                           //ɾ����¼
                           function deleteRec(msg_id){
	                   var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/failReason/delete.jsp","����ɾ����ؼ�¼�����Ժ�......");
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
	<div id="Operation_Table">
           <div class="title"><div id="title_zi">ʧ��ԭ��ά��</div></div>
            <input type="hidden" name="checkPlanNo" value="">
      	    <input type="hidden" name="myaction" value="">
      	    <input type="hidden" name="page" value="">
      	    <% for ( int i = 0; i < dataRows.length; i++ ) { %>
      	    <input type="hidden" name ="plan_id<%=i%>"  value="<%=dataRows[i][0]%>">
      	    <% } 
             %>
           <table  cellSpacing="0" >
                   <tr >
          	     <th align="center" class="blue" width="10%" > ѡ�� </th>
                     <th align="center" class="blue" width="45%" > �������� </th>
                     <th align="center" class="blue" width="45%" > �������� </th>


                   </tr>

                   <% for ( int i = 0; i < dataRows.length; i++ ) {             
                                           String tdClass="one";
                                           %>

                      <%if((i+1)%2==1){
                         tdClass="two";
                         
                         %>
                      <tr >
			<%}else{%>
	              <tr  >
	                <%}%>
                        <td align="center" class="<%=tdClass%>" ><input type="radio" name="plan_id" onclick="setPlanNo('<%=i%>');" value="<%=dataRows[i][0]%>"/></td>
                        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
                        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
                      </tr>
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
                </div>
               </form>
               <%@ include file="/npage/include/footer.jsp"%>
               <% }catch(Exception e){
                  e.printStackTrace();}%>
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
	     //window.open("../../../../npage/callbosspage/failReason/add.jsp", "outHelp", winParam);
             openWinMid('add.jsp','����ʧ��ԭ��',260,390); 
             }



function viewCheck1(){
     var planNo=document.getElementById("checkPlanNo").value;
	     
     if(planNo=='')
     {
          alert("û��ѡ��Ҫ�鿴�ļ�¼");	
          return false;
     }
     var height = 300;
     var width = 420;
     var top = screen.availHeight/2 - height/2;
     var left=screen.availWidth/2 - width/2;
     var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
     window.open("../../../../npage/callbosspage/checkWork/K310/K310_query_detail_checkPerson.jsp?plan_id="+planNo, "outHelp", winParam);

}

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

</script>



