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
  System.out.println("sPOSpecNumber:"+sPOSpecNumber);	 
  System.out.println("sPOOrderNumber:"+sPOOrderNumber);
  
  String p_OperType = WtcUtil.repNull(request.getParameter("p_OperType"));
%>

<div id="form">
	<input type="hidden" id="p_OperType" value="<%=p_OperType%>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	      	<th width="10%" nowrap>ѡ��</th>
	        <th width="20%" nowrap>�ʷѲ��Ա���</th>
	        <th width="70%" nowrap>�ʷѲ�������</th>		        
	      </tr>
        <tbody>
<wtc:service name="s9102DetQry" outnum="14" routerKey="region" routerValue="<%=regionCode%>">			
	<wtc:param value="<%=sPOOrderNumber%>"/>	
	<wtc:param value="<%=sPOSpecNumber%>"/>
  <wtc:param value="1"/>
</wtc:service>
<wtc:array id="result" start="2" length="12" scope="end" />
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){	
			System.out.println("-----="+result[i][6]);
%>
  			  <tr class="pospecratepolicy_contenttr"
  			  	 a_POSpecRatePolicyID = "<%=result[i][4]%>"
  			  	 a_Name               = "<%=result[i][5]%>"
  			  	 a_POOrderNumber      = "<%=sPOOrderNumber%>"
  			  	 a_POSpecNumber	      = "<%=sPOSpecNumber%>"  			     
  			  	 a_OperType           = "OLD"  
  			  	 a_RatePlansListCheck = "0"  
  			  	 a_AcceptID           = "<%=result[i][6]%>"  			  	  			  	  			  	  			  	  			  	  			  	  			  	  			  	  			  	  			  	
  			  >	
  			 
  			    <td classes="grey"><input type="checkbox" name="DeleteCheckBox2" value="0">
					  </td>			
					  <td>
					  <a class="p_POSpecRatePolicyID" style="cursor: hand;"><%=result[i][4]%></a>						  	
					  </td>
					  <td class="p_Name"><%=result[i][5]%>
					  </td>
	        </tr>
<%
    }
  }
}
%>
          <tr id="pospecratepolicy_buttontr">
	        	<th colspan="5" align="center">
	        		<input type="button" class="b_text" id="POSpecRatePolicyAdd" value="����">
	        		&nbsp;      
	        		<input type="button" class="b_text" id="POSpecRatePolicyDel" value="ɾ��">      
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
	function POSpecRatePolicyUpdate(){	
			
    var CheckTR = $(this).parent().parent();
	 	var  POSpecRatePolicy=[
	 	  	        $(CheckTR).attr("a_POSpecRatePolicyID"),//0�ײ�ID
	 	  	        $(CheckTR).attr("a_Name"),              //1�ײ�����
	 	  	        '<%=sPOOrderNumber%>',                  //2��Ʒ������
	 	  	        '<%=sPOSpecNumber%>',                   //3��Ʒ�����
	 	  	        $(CheckTR).data("a_RatePlansList"),     //4�б�����
	 	  	        $(CheckTR).attr("a_OperType"),          //5�Ƿ�����
	 	  	        $("#hiddendate_delete"),                //6��ҳ�滺����
	 	  	        $(CheckTR).attr("a_RatePlansListCheck"),//7�����ʶ
	 	  	        $(CheckTR).attr("a_AcceptID")           ,//8
	 	  	        '<%=p_OperType%>' ,                       //9 �������� wuxy alter
	 	  	        '1'
	 	  	        ];
	  var retInfo = window.showModalDialog
	  (
	  'f2029_POSpecRatePolicy_detail.jsp',
	  POSpecRatePolicy,
	  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
	  );
    if(retInfo){
   	$(CheckTR).attr("a_RatePlansListCheck"       , POSpecRatePolicy[7] );   //7�����ʶ
    }      
    $(CheckTR).data("a_RatePlansList",POSpecRatePolicy[4]);
    $('.p_POSpecRatePolicyID',CheckTR).text(POSpecRatePolicy[0]);
    $('.p_Name',CheckTR).text(POSpecRatePolicy[1]);    
       
	  return true;
	}
		 //��������
	 function POSpecRatePolicyAdd(){
	 	  var pospecnumber='<%=sPOSpecNumber%>';
	 	  if(pospecnumber=="")
	 	  {
	 	  	rdShowMessageDialog("��ѡ��һ����Ʒ���"); 
       	     return;
	 	 }
	 	  
	 	  var POSpecRatePolicy=[
	 	            "",	 	                                  //0�ײ�ID      
	 	            "",                                     //1�ײ�����    
	 	            '<%=sPOOrderNumber%>',                  //2��Ʒ������  
	 	            '<%=sPOSpecNumber%>',                   //3��Ʒ�����
	 	            "",                                     //4�б�����
	 	            "NEW",                                  //5�Ƿ�����
	 	            $("#hiddendate_delete"),                //6��ҳ�滺����
	 	            "0",	 	                                //7�����ʶ
	 	            "0"  ,                                   //8
	 	            '<%=p_OperType%>' ,                       //9 �������� wuxy alter
	 	  	        '2'
	 	         ];
	    var retInfo = window.showModalDialog
	    (
	    "f2029_POSpecRatePolicy_detail.jsp",
	    POSpecRatePolicy,
	    'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
	    );
	    //yuanqs add 2011-3-15 17:07:03 �����ʷѲ��Ա��벻���ظ� begin
	    var count = $(".pospecratepolicy_contenttr").size();
		if (count > 0)
		{
			for (var i=0; i<count; i++)
			{
				if ( POSpecRatePolicy[0] == $($(".pospecratepolicy_contenttr").get(i)).attr("a_POSpecRatePolicyID") )
				{
					rdShowMessageDialog("�ʷѲ��Ա��벻���ظ�!");
			  		return;
				}
			}
			
		}
		//yuanqs add 2011-3-15 17:07:38 end
      //��رհ�ť������
	    if(retInfo)
	    {
	       var newtrstr =
	            "<tr class=\"pospecratepolicy_contenttr\" "+
  			  	  " a_POSpecRatePolicyID='"+POSpecRatePolicy[0] +"'"+
  			  	  " a_Name              ='"+POSpecRatePolicy[1] +"'"+
  			  	  " a_POOrderNumber     ='"+POSpecRatePolicy[2] +"'"+
  			  	  " a_POSpecNumber      ='"+POSpecRatePolicy[3] +"'"+
  			  	  " a_OperType          ='"+POSpecRatePolicy[5] +"'"+
  			  	  " a_RatePlansListCheck='"+POSpecRatePolicy[7] +"'"+
  			  	  " a_AcceptID='"          +POSpecRatePolicy[8] +"'"+
  			  	  ">"+
						  "<td classes=\"grey\"><input type=\"checkbox\" name=\"DeleteCheckBox2\">"+
					    "</td>"+
				      "<td><a class=\"p_POSpecRatePolicyID\" style=\"cursor: hand;\">"+POSpecRatePolicy[0]+"</a>"+
					    "</td>"+
					    "<td class=p_Name>"+POSpecRatePolicy[1]+
					    "&nbsp</td>"+					    
	            "</tr>";
	       $("#pospecratepolicy_buttontr").before(newtrstr);
	       //Ϊ�����и���������
	       $(".pospecratepolicy_contenttr:last").data("a_RatePlansList",POSpecRatePolicy[4]);
	       //ע����º���
	       $('.p_POSpecRatePolicyID').bind('click', POSpecRatePolicyUpdate);	       
	 	  }
	 }

	 //ɾ������
   function POSpecRatePolicyDel(){
   	 
      $("input[@name='DeleteCheckBox2']").each(function()
      {
      var checkTR = $(this.parentNode.parentNode);
      if($(this).attr("checked")){
      	  if($(checkTR).attr("a_OperType")=="OLD")//��������ݿ���ȡ�������ݣ���ӵ�ɾ��������
      	  {
      	  	  var i  = $("DIV.PospecratePolicy","#hiddendate_delete").size();
      	  		var deletedate=
      	  		"<DIV class='PospecratePolicy' style='display:none'>"+
      	  		"<input type='text' name='tableid_POS"+i+"'              value='1'>" +                                         //
      	  		"<input type='text' name='d_POSpecRatePolicyID_POS"+i+"' value='"+$(checkTR).attr("a_POSpecRatePolicyID")+"'>"+//0 �ײ�ID           
      	  		"<input type='text' name='d_Name_POS"+i+"'               value='"+$(checkTR).attr("a_Name")+"'>"+              //1 �ײ�����         
      	  		"<input type='text' name='d_POOrderNumber_POS"+i+"'      value='"+$(checkTR).attr("a_POOrderNumber")+"'>"+     //2 ��Ʒ������  
      	  		"<input type='text' name='d_POSpecNumber_POS"+i+"'       value='"+$(checkTR).attr("a_POSpecNumber")+"'>"+      //3 ��Ʒ�����
      	  		//"<input type='text' name='d_opertype_POS"+i+"'           value='N'>"+ 
      	  		"<input type='text' name='d_AcceptID_POS"+i+"'           value='"+$(checkTR).attr("a_AcceptID")+"'>"+  
              "</DIV>";
      	  		$("#hiddendate_delete").append(deletedate);  
      	  		
      	  }
       		checkTR.remove();
      }
      });
   }	 
$(document).ready(function(){
	 //ע����º���
	 $('.p_POSpecRatePolicyID').bind('click', POSpecRatePolicyUpdate);
	 
	 //ע����������
	 $('#POSpecRatePolicyAdd').click(function(){
	     POSpecRatePolicyAdd();
	 });	 
	 //ע��ɾ������
	 $('#POSpecRatePolicyDel').click(function(){
	     POSpecRatePolicyDel();
	 });
	 
	 var p_OperType = "<%=p_OperType%>";
	 if(p_OperType=="1"){
	 	$("#pospecratepolicy_buttontr").hide();	
	 }
	 //rendi add for ѡ���ѯ��Ԥ������ͨʱʱ��ť�����ɼ�
	 if(p_OperType=="2"){
	 	$("#pospecratepolicy_buttontr").hide();	
	 }
	 if(p_OperType=="3"){
	 	$("#pospecratepolicy_buttontr").hide();	
	 }
});                            
</script>
