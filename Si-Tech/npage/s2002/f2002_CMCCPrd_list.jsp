<%
   /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: piaoyi
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%
String workNo = (String)session.getAttribute("workNo");
String org_code = (String)session.getAttribute("orgCode");
String regionCode=org_code.substring(0,2);
String checkflag = request.getParameter("checkflag");//ҳ���Ƿ���ع�
String sCustomerProvinceNumber = request.getParameter("sCustomerProvinceNumber");
String sExtInfoAcceptID = request.getParameter("sExtInfoAcceptID");

String sp_Action = request.getParameter("sp_Action");
%>
<div id="form">
	<input type="hidden" id=p_Action value="<%=sp_Action%>" >
	<input type="hidden" id=p_ExtInfoAcceptID value="<%=sExtInfoAcceptID%>" >
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="10%" nowrap>ѡ��</th>
	        <th width="90%" nowrap>�й��ƶ���Ϣ����Ʒ</th>
	      </tr>
      
<%
if("0".equals(checkflag)){
%>
<wtc:service name="s9101DetQry" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="2"/>
	<wtc:param value="<%=sExtInfoAcceptID%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="4" scope="end" />
<%
	if(retCode.equals("000000")){
		if(result.length>0){
			 for(int i=0;i<result.length;i++){
			 System.out.println("result[i][0]|"+result[i][0]);
%>
			 <tr class="cmcc_contenttr" 
			 	   a_CMCCPrd="<%=result[i][1]%>" 
			 	   a_CustomerProvinceNumber="<%=result[i][0]%>" 
			 	   a_ExtInfoAcceptID="<%=result[i][2]%>" 
			 	   a_CMCCPrdAcceptID="<%=result[i][3]%>" 
			 	   a_OperType="OLD">
			 		<td classes="grey">
			 			<input type="Checkbox" name="CMCCPrdListChkBox">
			 		</td>
			 		<td>
			 			<a class="p_CMCCPrd" style="cursor: hand;"><%=result[i][1]%>
			 			</a>
			 		</td>
			 </tr>
<%
	     }
	  }
	}
}
%>

        <tr id="buttontr">
	      	<th colspan="5" align="center">
	      		<%
if(!"3".equals(sp_Action))
{
%>
	      		<input type="button" class="b_text" id="CMCCPrdAdd" value="����">
	      		&nbsp;
	      		<input type="button" class="b_text" id="CMCCPrdDel" value="ɾ��">
	<%
}
%>	      		
	        </th>
	      </tr>
	      
		</form>
	</table>

</div>
<script>

$("#wait2").hide();

//��������
function CMCCPrdAdd(){
	  var CMCCPrdTR;
	  
	  var CMCCPrd=[
	      "",                                    //0 �й��ƶ���Ϣ����Ʒ
	      $("#p_CustomerProvinceNumber").val(),  //1 ���Ź���ʡ����
	      $("#p_ExtInfoAcceptID").val(),         //2 ��չ��Ϣ��ˮ
	      "0",                                   //3 ��Ʒ��ˮ
	      "NEW" ,                                 //4 ������ʶ
	      $("#p_Action").val()                    //5 ��������
	    ];	 	    
   var retInfo = window.showModalDialog
   (
   'f2002_CMCCPrd_detail.jsp',
   CMCCPrd,
   'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
   );
   if(retInfo=="Y"){//��رհ�ť������	 	    	 
   	 var CMCCPrd0 = CMCCPrd[0];
   	 var CMCCPrd1 = CMCCPrd[1];
   	 var CMCCPrd2 = CMCCPrd[2];
   	 var CMCCPrd3 = CMCCPrd[3];
   	 var CMCCPrd4 = CMCCPrd[4]; 	    	 	    	 	    	 	    	 	    	 	    	 
  		 var newtrstr =
  		 "<tr"+
  		 " class=\"cmcc_contenttr\""+
  		 " a_CMCCPrd="+                  "'"+CMCCPrd0+"'"+
  		 " a_CustomerProvinceNumber="+   "'"+CMCCPrd1+"'"+
  		 " a_ExtInfoAcceptID="+          "'"+CMCCPrd2+"'"+
  		 " a_CMCCPrdAcceptID="+          "'"+CMCCPrd3+"'"+
  		 " a_OperType="+                 "'"+CMCCPrd4+"'"+
  		 ">"+
  		 "<td classes=\"grey\">"+
  		 "<input type=\"Checkbox\" name=\"CMCCPrdListChkBox\">"+
  		 "</td>"+
  		 "<td>"+
  		 "<a class=\"p_CMCCPrd\" style=\"cursor: hand;\">"+CMCCPrd0+
  		 "</a>"+
  		 "</td>"+
  		 "</tr>";
  		 $("#buttontr").before(newtrstr);
	     //ע����º���
      $('.p_CMCCPrd').bind('click', CMCCPrdUpdate);
	  }
}
//���º���
function CMCCPrdUpdate(){
   var CMCCPrdTR = $(this).parent().parent();
   var CMCCPrd = new Array(5);//����������,���ݸ���ϸ��Ϣҳ��
	  CMCCPrd=[
	  	        $(CMCCPrdTR).attr("a_CMCCPrd"),
	  	        $(CMCCPrdTR).attr("a_CustomerProvinceNumber"),
	  	        $(CMCCPrdTR).attr("a_ExtInfoAcceptID"),
	  	        $(CMCCPrdTR).attr("a_CMCCPrdAcceptID"),
	  	        $(CMCCPrdTR).attr("a_OperType"),
	  	        $("#p_Action").val()                    //5 ��������
	  	      ];	 	   	  	      
   var retInfo = window.showModalDialog
   (
   "f2002_CMCCPrd_detail.jsp",
   CMCCPrd,
   'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
   );	    
   //this.tr.attr��ֵ
   $(CMCCPrdTR).attr("a_CMCCPrd", CMCCPrd[0]);
   $(CMCCPrdTR).attr("a_CustomerProvinceNumber", CMCCPrd[1]);
   $(CMCCPrdTR).attr("a_ExtInfoAcceptID", CMCCPrd[2]);
   $(CMCCPrdTR).attr("a_CMCCPrdAcceptID", CMCCPrd[3]);
   $(CMCCPrdTR).attr("a_OperType", CMCCPrd[4]);
   $('.p_CMCCPrd',CMCCPrdTR).text(CMCCPrd[0]);
}


//ɾ������
function CMCCPrdDel(){
   var deleteArrayTmp;//�ϲ���β�����ʱ����
	 deleteArrayTmp=new Array($("input[@name='CMCCPrdListChkBox']:checked").size());
   $("input[@name='CMCCPrdListChkBox']:checked").each(function(i)
   {
      var checkTR = $(this.parentNode.parentNode);      
      //if($(checkTR).attr("a_OperType")=="OLD")//��������ݿ���ȡ�������ݣ���ӵ�ɾ��������
      //{
         var deltr = new Array(5);
         deltr[0]=$(checkTR).attr("a_CMCCPrd");
         deltr[1]=$(checkTR).attr("a_CustomerProvinceNumber");
         deltr[2]=$(checkTR).attr("a_ExtInfoAcceptID");
         deltr[3]=$(checkTR).attr("a_CMCCPrdAcceptID");
         deltr[4]=$(checkTR).attr("a_OperType");
         deleteArrayTmp[i]=deltr;
      //}
      checkTR.remove();
   });   
   if(deleteArray)
   {
   	  deleteArray=deleteArray.concat(deleteArrayTmp);
   }else{
   	  deleteArray=deleteArrayTmp;
   }   
}
   
$(document).ready(function(){
	 //����б�ҳ����ع����������������б�	 
	 if(extInfo[22]=="1"){
	 	  if(CMCCPrdListArray){
	 		  $.each(CMCCPrdListArray, function(i){
	 		  	var CMCCPrd = CMCCPrdListArray[i];//����������,���ݸ���ϸ��Ϣҳ��
	   	  	 var newtrstr =
	   	  	 "<tr"+
	   	  	 " class=\"cmcc_contenttr\""+
	   	  	 " a_CMCCPrd="+                  "'"+CMCCPrd[0]+"'"+
	   	  	 " a_CustomerProvinceNumber="+   "'"+CMCCPrd[1]+"'"+
	   	  	 " a_ExtInfoAcceptID="+          "'"+CMCCPrd[2]+"'"+
	   	  	 " a_CMCCPrdAcceptID="+          "'"+CMCCPrd[3]+"'"+
	   	  	 " a_OperType="+                 "'"+CMCCPrd[4]+"'"+
	   	  	 ">"+
	   	  	 "<td classes=\"grey\">"+
	   	  	 "<input type=\"Checkbox\" name=\"CMCCPrdListChkBox\">"+
	   	  	 "</td>"+
	   	  	 "<td>"+
	   	  	 "<a class=\"p_CMCCPrd\" style=\"cursor: hand;\">"+CMCCPrd[0]+
	   	  	 "</a>"+
	   	  	 "</td>"+
	   	  	 "</tr>";
        
	 		    $("#buttontr").before(newtrstr);
	 		  });
	 	  }
	 }else{
	 		extInfo[22]="1";
	 }	 	 	 	 
   //ע����������
	 $('#CMCCPrdAdd').click(function(){
	     CMCCPrdAdd();
	 });
	 //ע����º���
	 $('.p_CMCCPrd').bind('click', CMCCPrdUpdate);
	 //ע��ɾ������
	 $('#CMCCPrdDel').click(function(){
	     CMCCPrdDel();
	 });  
});
</script>
