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
  String sPOOrderNumber = request.getParameter("sPOOrderNumber");
  String sPOSpecNumber = request.getParameter("sPOSpecNumber");
  String sProductOrderNumber = request.getParameter("sProductOrderNumber"); 
  String sProductSpecNumber = request.getParameter("sProductSpecNumber");
  String sParAcceptID = request.getParameter("sParAccpetID"); 
  String sCheckFlag2 = request.getParameter("sCheckFlag2");   
  String p_OperType = WtcUtil.repNull(request.getParameter("p_OperType"));    //wuxy add  
  System.out.println("sCheckFlag++++++****************|"+sCheckFlag2);
%>
<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	      	<th width="15%" nowrap>ѡ��</th>
	        <th width="25%" nowrap>֧��ʡ����</th>
	        <th width="60%" nowrap>֧��ʡ����</th>
	      </tr>
        <tbody>
<wtc:service name="s9102DetQry" outnum="14" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sProductOrderNumber%>"/>
  <wtc:param value=""/>
	<wtc:param value="6"/>
</wtc:service>
<wtc:array id="result" start="2" length="12" scope="end" />
<%  
if(sCheckFlag2.equals("0")){
	if(retCode.equals("000000")){				   
		if(result.length>0){
			for(int i=0;i<result.length;i++){			 
%>
  			  <tr class="ProductPayCompany_contenttr"
  			  	a_PayCompanyID="<%=result[i][1]%>"
  			  	a_PayCompanyName="<%=result[i][2]%>"
  			  	a_POOrderNumber="<%=sPOOrderNumber%>"
  			  	a_POSpecNumber="<%=sPOSpecNumber%>"
  			  	a_ProductOrderNumber="<%=sProductOrderNumber%>"
  			  	a_OperType="OLD"
  			  	a_ProductSpecNumber="<%=sProductSpecNumber%>"
  			  	a_ParAcceptID="<%=sParAcceptID%>"
  			  	a_AcceptID="<%=result[i][3]%>"  			  	 			  	
  			  >
  		      <td classes="grey"><input type="checkbox" name="DeleteCheckBox" value="0">
					  </td>	
				    <td p_PayCompanyID><%=result[i][1]%>
					  </td>
            <td class="p_PayCompanyName"><%=result[i][2]%>
					  </td>					  
	        </tr>
<%
       }
     }
  }
 }
%>
          <tr id="buttontr2">
	        	<th  colspan="3" align="center">
	        		<input type="button" class="b_text" id="PayCompanyAdd" value="����">
	        		&nbsp;      
	        		<input type="button" class="b_text" id="PayCompanyDel" value="ɾ��">      
	          </th>
	        </tr>
	      </tbody>
		</form>
	</table>
</div>
<script>
	

	
	
//���ع�����
$("#wait2").hide();
	 //���º���
	function PayCompanyUpd(){
    var PayCompanyTR = $(this).parent().parent();    
	 	var PayCompany=[
	 	  	        	$(PayCompanyTR).attr("a_PayCompanyID")     ,//0 
	 	  	        	$(PayCompanyTR).attr("a_PayCompanyName")   ,//1	  	              
	 	  	        	'<%=sPOOrderNumber%>'                      ,//2                    
	 	  	        	'<%=sPOSpecNumber%>'                       ,//3                     	  	        
	 	  	        	'<%=sProductOrderNumber%>'                 ,//4 
	 	            	$(PayCompanyTR).attr("a_OperType")         ,//5
	 	            	$(PayCompanyTR).attr("a_ProductSpecNumber"),//6
	 	            	$(PayCompanyTR).attr("a_ParAcceptID")      ,//7
	 	            	$(PayCompanyTR).attr("a_AcceptID")	, 	      //8       
	 	            	'<%=p_OperType%>' ,                           //9
	 	            	'1' 	
	               ];	  
	  var retInfo = window.showModalDialog
	  (
	  'f2029_PayCompany_detail.jsp',
	  PayCompany,
	  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
	  );
	  
    $(PayCompanyTR).attr("a_PayCompanyID"      ,PayCompany[0] );//0 
    $(PayCompanyTR).attr("a_PayCompanyName"    ,PayCompany[1] );//1         
    $(PayCompanyTR).attr("a_POOrderNumber"     ,PayCompany[2] );//2         
    $(PayCompanyTR).attr("a_POSpecNumber"      ,PayCompany[3] );//3         
    $(PayCompanyTR).attr("a_ProductOrderNumber",PayCompany[4] );//4         
    $(PayCompanyTR).attr("a_OperType"          ,PayCompany[5] );//5 
    $(PayCompanyTR).attr("a_ParAcceptID"       ,PayCompany[7] );//7
    $(PayCompanyTR).attr("a_AcceptID"          ,PayCompany[8] );//8
    $('.p_PayCompanyID' ,PayCompanyTR).text(PayCompany[0]);
    $('.p_PayCompanyName' ,PayCompanyTR).text(PayCompany[1]);
    return true;                                                                    
	}
	
//��������                                                                                    
function PayCompanyAdd(){	                                                                
	var PayCompany=[
	  	        ""                        ,//0	  	        	  	        
	  	        ""                        ,//1
	  	        '<%=sPOOrderNumber%>'     ,//2 
	  	        '<%=sPOSpecNumber%>'      ,//3
	  	        '<%=sProductOrderNumber%>',//4
	  	        "NEW"                     ,//5
	  	        '<%=sProductSpecNumber%>' ,//6
	  	        '<%=sParAcceptID%>'       ,//7
	  	        '0'	,  	                   //8
	  	        '<%=p_OperType%>' ,                           //9
	 	        '1' 	
	  	        ];                                        
   var retInfo = window.showModalDialog                                                         
   (                                                                                            
   "f2029_PayCompany_detail.jsp",                                                                 
   PayCompany,                                                                                    
   'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'    
   );                                                                                           
   //��رհ�ť������                                                 
   if(retInfo)                                                                                  
   {      	                                                                                       
      var newtrstr =                                                                            
           "<tr class=\"ProductPayCompany_contenttr\" "+                                                
		  	  " a_PayCompanyID='"       +PayCompany[0] +"'"+                                    
		  	  " a_PayCompanyName='"     +PayCompany[1] +"'"+
		  	  " a_POOrderNumber='"      +PayCompany[2] +"'"+ 
		  	  " a_POSpecNumber='"       +PayCompany[3] +"'"+ 
		  	  " a_ProductOrderNumber='" +PayCompany[4] +"'"+
		  	  " a_OperType='"           +PayCompany[5] +"'"+
		  	  " a_ProductSpecNumber='"  +PayCompany[6] +"'"+	                                                                           
		  	  " a_ParAcceptID='"        +PayCompany[7] +"'"+
		  	  " a_AcceptID='"           +PayCompany[8] +"'"+
		  	  ">"+                                                                                 
				  "<td classes=\"grey\"><input type=\"checkbox\" name=\"DeleteCheckBox\">"+            
			    "</td>"+                                                                             
		      "<td class=p_PayCompanyID>"+PayCompany[0]+
			    "</td>"+                                                           
			    "<td class=p_PayCompanyName>"+PayCompany[1]+                                              
			    "</td>"+					    					                                                                   
          "</tr>";                                                                               
      $("#buttontr2").before(newtrstr);                                                                                                                                                      
      //ע����º���                                                                            
      $('.p_PayCompanyID').bind('click', PayCompanyUpd);	                               
	  }
}

//ɾ������
function PayCompanyDel(){
   $("input[@name='DeleteCheckBox']").each(function()
   {
   var checkTR = $(this.parentNode.parentNode);
   if($(this).attr("checked")){
   	  if($(checkTR).attr("a_OperType")=="OLD")//��������ݿ���ȡ�������ݣ���ӵ�ɾ��������
   	  { 	  	 
   	  	  var i  = $("DIV.PayCompany","#hiddendate_delete").size();
   	  		var deletedate=
   	  		    "<DIV class='PayCompany' style='display:none'>"+
   	  		    "<input type='text' name='tableid_PayCompany"+i+"'                value='7'>" +
   	  		    "<input type='text' name='d_PayCompanyID_PayCompany"+i+"'       value='"+$(checkTR).attr("a_PayCompanyID")+"'>"+                          
   	  		    "<input type='text' name='d_PayCompanyName_PayCompany"+i+"'     value='"+$(checkTR).attr("a_PayCompanyName")+"'>"+            
   	  		    "<input type='text' name='d_POOrderNumber_PayCompany"+i+"'      value='"+$(checkTR).attr("a_POOrderNumber")+"'>"+
   	  		    "<input type='text' name='d_POSpecNumber_PayCompany"+i+"'       value='"+$(checkTR).attr("a_POSpecNumber")+"'>"+
   	  		    "<input type='text' name='d_ProductOrderNumber_PayCompany"+i+"' value='"+$(checkTR).attr("a_ProductOrderNumber")+"'>"+
   	  		    "<input type='text' name='d_ProductSpecNumber_PayCompany"+i+"'  value='"+$(checkTR).attr("a_ProductSpecNumber")+"'>"+
   	  		    "<input type='text' name='d_ParAcceptID_PayCompany"+i+"'        value='"+$(checkTR).attr("a_ParAcceptID")+"'>"+
   	  		    "<input type='text' name='d_AcceptID_PayCompany"+i+"'           value='"+$(checkTR).attr("a_AcceptID")+"'>"+
   	  		    "</DIV>";
   	  		ProductOrder[12].append(deletedate);
   	  }
      checkTR.remove();
   }
   });
}

$(document).ready(function(){
   if(ProductOrder[18]=="1"){
   		if(ProductOrder[14]){   			 
   			 $.each(ProductOrder[14], function(i){   			 	
   			 	   var PayCompany = ProductOrder[14][i];//����������,���ݸ���ϸ��Ϣҳ��	
   			     var newtrstr =                                                                            
             "<tr class=\"ProductPayCompany_contenttr\""  +                                                
		  	     " a_PayCompanyID='"       +PayCompany[0] +"'"+                                    
		  	     " a_PayCompanyName='"     +PayCompany[1] +"'"+
		  	     " a_POOrderNumber='"      +PayCompany[2] +"'"+ 
		  	     " a_POSpecNumber='"       +PayCompany[3] +"'"+ 
		  	     " a_ProductOrderNumber='" +PayCompany[4] +"'"+
		  	     " a_OperType='"           +PayCompany[5] +"'"+	  	                                                                           
		  	     " a_ProductSpecNumber='"  +PayCompany[6] +"'"+	
		  	     " a_ParAcceptID='"        +PayCompany[7] +"'"+	
		  	     " a_AcceptID='"           +PayCompany[8] +"'"+	
		  	     ">"+                                                                                 
				     "<td classes=\"grey\"><input type=\"checkbox\" name=\"DeleteCheckBox\">"+            
			       "</td>"+                                                                             
		         "<td class=p_PayCompanyID>"+PayCompany[0]+      
			       "</td>"+                                                           
			       "<td class=p_PayCompanyName>"+PayCompany[1]+                                              
			       "</td>"+					    					                                                                   
             "</tr>";                                                                                        
             $("#buttontr2").before(newtrstr);                          
             //ע����º���
             $('.p_PayCompanyID').bind('click', PayCompanyUpd);
   			 });
   		}
   }else{   	  
   	  ProductOrder[18]="1"   	  
   }   
   //ע����º���
	 $('.p_PayCompanyID').bind('click', PayCompanyUpd);	 
	 //ע����������
	 $('#PayCompanyAdd').click(function(){
	     PayCompanyAdd();
	 });
	 //ע��ɾ������
	 $('#PayCompanyDel').click(function(){
	     PayCompanyDel();
	 });
	 //wuxy add
	 var p_OperType = "<%=p_OperType%>";
	 if(p_OperType=="1"){
	 	$("#buttontr2").hide();	
	 }
	 //add by rendi 	
	 if(p_OperType=="2"){
	 	$("#buttontr2").hide();	
	 }	 
	 if(p_OperType=="3"){
	 	$("#buttontr2").hide();	
	 }		 	  
});
</script>
