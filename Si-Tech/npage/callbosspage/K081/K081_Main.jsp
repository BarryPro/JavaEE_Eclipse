<%
   /*
   * ����: ��������
   * �汾: 1.0.0
   * ����: 
   * ����: yinzx
   * ��Ȩ: sitech
   *
   */	
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <%@ page contentType="text/html;charset=gb2312"%>
  <%@ include file="/npage/include/public_title_name.jsp" %>
  <%@ page import="com.sitech.crmpd.core.wtc.util.* "%>
  
     <%
        try{
        String opCode="K081";
        String opName="��������";
            /*midify by yinzx 20091113 ������ѯ�����滻*/
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);

        
        //��������
        String[][] dataRows = new String[][]{};
        String[][] dataTemp = new String[][]{};
        int rowCount=0;
        int pageSize = 10;            // Rows each page
        int pageCount=0;               // Number of all pages
        int curPage=0;                 // Current page
        String strPage="";               // Transfered pages
        String sqlStr="";
 
        String action = "doLoad";
	 


 
        String sqlTemp = " select to_char(count(*)) from dcrmcallcfg s  ";
        %>	
     <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
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
        sqlStr = "select s.agent_ip,s.mainccsip,s.mainccsip2,s.ccsid,s.agenttype,"+
        				 " decode(bak2,1,'����',2,'����') severadd,s.bak2" +
								 " from dcrmcallcfg s";
        sqlStr += " order by  agent_ip desc";    
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
    %>
     <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
       <wtc:param value="<%=querySql%>"/>
     </wtc:service>
     <wtc:array id="queryList"  start="0" length="8" scope="end"/>	
     <%
				dataRows=queryList;    
     %>

     <html>
       <head>
         <title>��������</title>
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
 
           window.sitechform.action="K081_Main.jsp";
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

                         
									//add by hucw,20100617,���serv_addr�ֶΣ�
                 function deleteCheck(){
	                   var planNo=document.getElementById("checkPlanNo").value;
	                   var serv_addr=document.getElementById("serverAddr").value;
	                   if(planNo=='')
	                   {
	                   alert("û��ѡ��Ҫɾ���ļ�¼");	
	                   return false;
	                   }
	                   if(rdShowConfirmDialog("��ȷ����Ҫɾ��������¼��")=="1"){
		                      deleteRec(planNo,serv_addr);
	                   }
                 }

                    function mendCheck(){
	                   var planNo=document.getElementById("checkPlanNo").value;
	     							 var serverAddr=document.getElementById("serverAddr").value;
	                   if(planNo=='' || serverAddr=='')
	                   {
	                   alert("û��ѡ��Ҫ�޸ĵļ�¼");	
	                   return false;
	                   }
	                   var height = 700;
	                   var width = 1000;
	                   var top = screen.availHeight/2 - height/2;
	                   var left=screen.availWidth/2 - width/2;
	                   var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
                           openWinMid('modify.jsp?id='+planNo+'&server_addr='+serverAddr,'ʧ��ԭ���޸�',260,390); 
                           }
                           //ɾ����¼
                    function deleteRec(msg_id,serv_addr)
                    {
	                  	  	 var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K081/delete.jsp","����ɾ����ؼ�¼�����Ժ�......");
	                      	 mypacket.data.add("msg_id",msg_id);
	                      	 mypacket.data.add("serv_addr",serv_addr);
                           core.ajax.sendPacket(mypacket,doProcess,false);
	                  			 mypacket=null;
                    }

                           function doProcess(packet){
	                   var retCode = packet.data.findValueByName("retCode");
	                   if(retCode=="00000"){
		           rdShowMessageDialog("ɾ���ɹ���",2);
		           window.sitechform.myaction.value="doLoad";
                           window.sitechform.action="K081_Main.jsp";
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
           <div class="title"><div id="title_zi">��������</div></div>
            <input type="hidden" name="checkPlanNo" id="checkPlanNo" value="">
            <input type="hidden" name="serverAddr" id="serverAddr" value="">
      	    <input type="hidden" name="myaction" value="">
      	    <input type="hidden" name="page" value="">
      	    <% for ( int i = 0; i < dataRows.length; i++ ) { %>
      	    <input type="hidden" name ="plan_id<%=i%>"  value="<%=dataRows[i][0]%>">
      	    <input type="hidden" name ="sever_addr<%=i%>" value="<%=dataRows[i][6]%>">
      	    <% }
             %>
           <table  cellSpacing="0" >
                   <tr >
          	     <th align="center" class="blue"  > ѡ�� </th>
                     <th align="center" class="blue"  > IP��ַ�� </th>
                     <th align="center" class="blue"  > ����CCS��IP��ַ </th>
                     <th align="center" class="blue"   > ����CCS��IP��ַ </th>
                     <th align="center" class="blue"   > ����������ID </th>
                     <th align="center" class="blue"  > ��ϯ���� </th>
                     <th align="center" class="blue"  >��������ַ</th>
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
                         <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
                        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
                        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
                        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
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
             	var serverAddr="sever_addr"+planNop;
	     			 	document.getElementById("checkPlanNo").value =document.getElementById(nono).value;
	     			 	document.getElementById("serverAddr").value=document.getElementById(serverAddr).value;
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



 

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

</script>