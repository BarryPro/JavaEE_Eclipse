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
	 String sCustomerProvinceNumber = request.getParameter("sCustomerProvinceNumber");
	 String sNeedOpButton = request.getParameter("sNeedOpButton");
	 String sp_Action= request.getParameter("sp_Action");
	 System.out.println("sNeedOpButton = "+sNeedOpButton);
%>


<div id="form">
	<input type="hidden" id=p_Action value="<%=sp_Action%>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="10%" nowrap>ѡ��</th>
	        <th width="25%" nowrap>IT��������</th>
	        <th width="25%" nowrap>�Ƿ���IT����</th>
	        <th width="25%" nowrap>�Ƿ���ר���ʷѷ���</th>
	        <th width="25%" nowrap>�ʷ��ײ�����</th>
	      </tr>
        <tbody>
<wtc:service name="s9101DetQry" outnum="26" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="1"/>
	<wtc:param value="<%=sCustomerProvinceNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="24" scope="end" />

 
 	
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){
		%>
		<!--ѭ��ȡ��ˮ -->
 		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="01"  id="seq"/>
		<%
		System.out.println("gaopengSeeLogExtInfoList===seq======"+seq);
		System.out.println("result["+i+"][21]:"+result[i][21]);
%>
  			  <tr class="extinfo_contenttr"
  			  	  a_HasITDept="<%=result[i][1]%>"
  			  	  a_ITDeptName="<%=result[i][2]%>"
  			  	  a_FeeCase="<%=result[i][3]%>"
  			  	  a_FeeCaseInfo="<%=result[i][4]%>"
  			  	  a_ARPU="<%=result[i][5]%>"
  			  	  a_DataARPU="<%=result[i][6]%>"
  			  	  a_AvgFee="<%=result[i][7]%>"
  			  	  a_Quota="<%=result[i][8]%>"
  			  	  a_RewardType="<%=result[i][9]%>"
  			  	  a_UnicomTone="<%=result[i][10]%>"
  			  	  a_UnicomData="<%=result[i][11]%>"
  			  	  a_Trends="<%=result[i][12]%>"
  			  	  a_MobileUser="<%=result[i][13]%>"
  			  	  a_MobileRate="<%=result[i][14]%>"
  			  	  a_Informationize="<%=result[i][15]%>"
  			  	  a_Intergration="<%=result[i][16]%>"
  			  	  a_Terminal="<%=result[i][17]%>"
  			  	  a_TransProv="<%=result[i][18]%>"
  			  	  a_SinglePay="<%=result[i][19]%>"
  			  	  a_Mas="<%=result[i][20]%>"
  			  	  a_CustomerProvinceNumber="<%=result[i][0]%>"
  			  	  a_ExtInfoAcceptID="<%=result[i][21]%>"
  			  	  a_CMCCPrdListCheck="0"
  			  	  a_OperType="OLD"
  			  	  a_ExtInfoAcceptID_NEW="<%=seq%>"
  			  	  a_button_open_flag="<%=seq%>false"
  			  	  
  			  	>
  			  	
						<td classes="grey"><input type="checkbox" name="ExtInfoListChkBox" value="0">
					  </td>
				    <td><a class="p_ITDeptName" style="cursor: hand;"><%=result[i][2]%>&nbsp;</a>
					  </td>
					  <td class=p_HasITDept><%=result[i][22]%>&nbsp;
					  &nbsp;</td>
					  <td class=p_FeeCase><%=result[i][23]%>&nbsp;
					  &nbsp;</td>
					  <td class=p_FeeCaseInfo><%=result[i][4]%>&nbsp;
					  &nbsp;</td>
	        </tr>
<%
    }
  }
}
%>

<%
if("1".equals(sNeedOpButton))
{
%>
          <tr id="extinfo_buttontr">

	        	<th colspan="5" align="center">
	        		<input type="button" class="b_text" id="ExtInfoAdd" value="����">
	        		&nbsp;
	        		<input type="button" class="b_text" id="ExtInfoDel" value="ɾ��">
	          </th>
	        </tr>
<%
}
%>
	      </tbody>
		</form>
	</table>
</div>

<script>
   $("#wait2").hide();
   $(document).ready(function(){
   //ע����������
	 $('#ExtInfoAdd').click(function(){
	     ExtInfoAdd();
	 });
	 //ע����º���
	 $('.p_ITDeptName').bind('click', ExtInfoUpdate);
	 //ע��ɾ������
	 $('#ExtInfoDel').click(function(){
	     ExtInfoDel();
	 });
	 //��������
	 function ExtInfoAdd(){	 	  
	 	  var extInfo=[
	 	            "",	 	                                        // 0�Ƿ���IT����
	 	            "",                                           // 1IT��������
	 	            "",                                           // 2�Ƿ���ר���ʷѷ���
	 	            "",                                           // 3�ʷ��ײ�����
	 	            "",                                           // 4ƽ������
	 	            "",                                           // 5ƽ������ҵ������
	 	            "",                                           // 6Ա����ƽ������
	 	            "",                                           // 7�����±������
	 	            "",                                           // 8���ѱ�����ʽ
	 	            "",                                           // 9�Ƿ�ʹ����ͨ����ҵ��
	 	            "",                                           //10�Ƿ�ʹ����ͨ����ҵ��
	 	            "",                                           //11δ���仯����
	 	            "",                                           //12�й��ƶ��ֻ���
	 	            "",                                           //13�й��ƶ��ֻ��û�����
	 	            "",                                           //14����Ϣ��������̶�
	 	            "",                                           //15����Ϣ�����ɵ�����̶�
	 	            "",                                           //16����ҵ�ն˶��Ƶ�����̶�
	 	            "",                                           //17�Կ�ʡһ�廯ʵʩ����������
	 	            "",                                           //18��һ���˵����������
	 	            "",                                           //19��MAS������̶�
	 	            $("#p_CustomerProvinceNumber").val(),         //20���Ź���ʡ����
	 	            "0",                                          //21��Ϣ����Ʒ��ˮ
	 	            "0",                                          //22�б�����ʶ
	 	            "" ,                                          //23�б�����
	 	            "NEW",                                         //24�Ƿ�����
	 	            $("#p_Action").val()                            //25  ��������
	 	         ];
	    var retInfo = window.showModalDialog
	    (
	    "f2002_ExtInfo_detail.jsp",
	    extInfo,
	    'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
	    );
      //��رհ�ť������
	    if(retInfo)
	    {

	    	 var p_HasITDept_tmp;
         if(extInfo[0]=="1"){
         		p_HasITDept_tmp="��";
         }else if(extInfo[0]=="2"){
         		p_HasITDept_tmp="û��";
         }else if(extInfo[0]=="3"){
         		p_HasITDept_tmp="δ֪/����";
         }

         var p_FeeCase_tmp;
         if(extInfo[2]=="1"){
         		p_FeeCase_tmp="��";
         }else if(extInfo[2]=="2"){
         		p_FeeCase_tmp="û��";
         }else if(extInfo[2]=="3"){
         		p_FeeCase_tmp="δ֪/����";
         }

	       var newtrstr =
	            "<tr class=\"extinfo_contenttr\" "+
  			  	  " a_HasITDept="+                 "'"+extInfo[0] +"'"+
  			  	  " a_ITDeptName="+                "'"+extInfo[1] +"'"+
  			  	  " a_FeeCase="+                   "'"+extInfo[2] +"'"+
  			  	  " a_FeeCaseInfo="+               "'"+extInfo[3] +"'"+
  			  	  " a_ARPU="+                      "'"+extInfo[4] +"'"+
  			  	  " a_DataARPU="+                  "'"+extInfo[5] +"'"+
  			  	  " a_AvgFee="+                    "'"+extInfo[6] +"'"+
  			  	  " a_Quota="+                     "'"+extInfo[7] +"'"+
  			  	  " a_RewardType="+                "'"+extInfo[8] +"'"+
  			  	  " a_UnicomTone="+                "'"+extInfo[9] +"'"+
  			  	  " a_UnicomData="+                "'"+extInfo[10]+"'"+
  			  	  " a_Trends="+                    "'"+extInfo[11]+"'"+
  			  	  " a_MobileUser="+                "'"+extInfo[12]+"'"+
  			  	  " a_MobileRate="+                "'"+extInfo[13]+"'"+
  			  	  " a_Informationize="+            "'"+extInfo[14]+"'"+
  			  	  " a_Intergration="+              "'"+extInfo[15]+"'"+
  			  	  " a_Terminal="+                  "'"+extInfo[16]+"'"+
  			  	  " a_TransProv="+                 "'"+extInfo[17]+"'"+
  			  	  " a_SinglePay="+                 "'"+extInfo[18]+"'"+
  			  	  " a_Mas="+                       "'"+extInfo[19]+"'"+
  			  	  " a_CustomerProvinceNumber="+    "'"+extInfo[20]+"'"+
  			  	  " a_ExtInfoAcceptID="+           "'"+extInfo[21]+"'"+
  			  	  " a_CMCCPrdListCheck="+          "'"+extInfo[22]+"'"+
  			  	  " a_CMCCPrdList=''"+
  			  	  " a_OperType='NEW'"+
  			  	  ">"+
						  "<td classes=\"grey\"><input type=\"checkbox\" name=\"ExtInfoListChkBox\">"+
					    "</td>"+
				      "<td><a class=\"p_ITDeptName\" style=\"cursor: hand;\">"+extInfo[1]+"</a>"+
					    "&nbsp</td>"+
					    "<td class=p_HasITDept>"+p_HasITDept_tmp+
					    "&nbsp</td>"+
					    "<td class=p_FeeCase>"+p_FeeCase_tmp+
					    "&nbsp</td>"+
					    "<td class=p_FeeCaseInfo>"+extInfo[3]+
					    "&nbsp</td>"+
	            "</tr>";
	       $("#extinfo_buttontr").before(newtrstr);
	       //Ϊ�����и���������
	       $(".extinfo_contenttr:last").data("a_CMCCPrdList",extInfo[23]);
	       //ע����º���
	       $('.p_ITDeptName').bind('click', ExtInfoUpdate);
	       //var deleteCMCCPrdArray=retInfo[1];
	       //if(deleteCMCCPrdArray){
	       //   $.each(deleteCMCCPrdArray, function(i){
	       //   	 var deleteCMCCPrd=new Array(5);
	       //   	 deleteCMCCPrd=deleteCMCCPrdArray[i];	          	 	          	 
	       //   	 if(deleteCMCCPrd[4]=="OLD"){
         //          var ii  = $("DIV.CMCCPrdInfo","#hiddendate_delete").size();
      	 //    	     var deletedate=
      	 //    	     "<DIV class='CMCCPrd'>" +
      	 //    	     "<input type='hidden' name='tableid"+ii+"'                           value='2'>" +
      	 //    	     "<input type='hidden' name='opertype"+ii+"'                          value='N'>" +
      	 //    	     "<input type='hidden' name='d_CMCCPrd"+ii+"'                         value='"+deleteCMCCPrd[0]+"'>"+
      	 //    	     "<input type='hidden' name='d_CustomerProvinceNumber_CMCCPrd"+ii+"' value='"+deleteCMCCPrd[1]+"'>"+
      	 //    	     "<input type='hidden' name='d_CMCCAcceptID"+ii+"'           value='"+deleteCMCCPrd[2]+"'>"+
      	 //    	     "<input type='hidden' name='d_ExtInfoAcceptID_CMCCPrd"+ii+"'        value='"+deleteCMCCPrd[3]+"'>"+
      	 //    	     "<input type='hidden' name='d_OperType"+ii+"'                        value='"+deleteCMCCPrd[4]+"'>"+
         //          "</DIV>";
      	 //    	     $("#hiddendate_delete").append(deletedate);
      	 //    	  }
	       //   });
	       //}
	 	  }
	 }

	 //���º��� IT�������Ƶ���¼�
	 function ExtInfoUpdate(){
      var extInfoTR = $(this).parent().parent();
      var extInfo=[
  	  	        $(extInfoTR).attr("a_HasITDept"             ),  // 0    �Ƿ���IT����
  	  	        $(extInfoTR).attr("a_ITDeptName"            ),  // 1    IT��������
  	  	        $(extInfoTR).attr("a_FeeCase"               ),  // 2    �Ƿ���ר���ʷѷ���
  	  	        $(extInfoTR).attr("a_FeeCaseInfo"           ),  // 3    �ʷ��ײ�����
  	  	        $(extInfoTR).attr("a_ARPU"                  ),  // 4    ƽ������
  	  	        $(extInfoTR).attr("a_DataARPU"              ),  // 5    ƽ������ҵ������
  	  	        $(extInfoTR).attr("a_AvgFee"                ),  // 6    Ա����ƽ������
  	  	        $(extInfoTR).attr("a_Quota"                 ),  // 7    �����±������
  	  	        $(extInfoTR).attr("a_RewardType"            ),  // 8    ���ѱ�����ʽ
  	  	        $(extInfoTR).attr("a_UnicomTone"            ),  // 9    �Ƿ�ʹ����ͨ����ҵ��
  	  	        $(extInfoTR).attr("a_UnicomData"            ),  //10    �Ƿ�ʹ����ͨ����ҵ��
  	  	        $(extInfoTR).attr("a_Trends"                ),  //11    δ���仯����
  	  	        $(extInfoTR).attr("a_MobileUser"            ),  //12    �й��ƶ��ֻ���
  	  	        $(extInfoTR).attr("a_MobileRate"            ),  //13    �й��ƶ��ֻ��û�����
  	  	        $(extInfoTR).attr("a_Informationize"        ),  //14    ����Ϣ��������̶�
  	  	        $(extInfoTR).attr("a_Intergration"          ),  //15    ����Ϣ�����ɵ�����̶�
  	  	        $(extInfoTR).attr("a_Terminal"              ),  //16    ����ҵ�ն˶��Ƶ�����̶�
  	  	        $(extInfoTR).attr("a_TransProv"             ),  //17    �Կ�ʡһ�廯ʵʩ����������
  	  	        $(extInfoTR).attr("a_SinglePay"             ),  //18    ��һ���˵����������
  	  	        $(extInfoTR).attr("a_Mas"                   ),  //19    ��MAS������̶�
  	  	        $(extInfoTR).attr("a_CustomerProvinceNumber"),  //20    ���Ź���ʡ����
  	  	        $(extInfoTR).attr("a_ExtInfoAcceptID"       ),  //21    ��Ϣ����Ʒ��ˮ
  	  	        $(extInfoTR).attr("a_CMCCPrdListCheck"      ),  //22    �б�����ʶ  	  	        
  	  	        $(extInfoTR).data("a_CMCCPrdList")           ,  //23    �б�����
  	  	        $(extInfoTR).attr("a_OperType"              ),   //24    �Ƿ�����
								$("#p_Action").val(),                             //25  ��������
								$(extInfoTR).attr("a_ExtInfoAcceptID_NEW"       ),//26 ��������ˮ
								$(extInfoTR).attr("a_button_open_flag"       )//27 ȷ�ϰ�ť�Ƿ���
								
								
								
  	  	        ];
     var retInfo = window.showModalDialog
     (
     "f2002_ExtInfo_detail.jsp",
     extInfo,
     'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
     );
      //this.tr.attr��ֵ
      $(extInfoTR).attr("a_HasITDept"             , extInfo[0]) ;   // 0    �Ƿ���IT����
      $(extInfoTR).attr("a_ITDeptName"            , extInfo[1]) ;   // 1    IT��������
      $(extInfoTR).attr("a_FeeCase"               , extInfo[2]) ;   // 2    �Ƿ���ר���ʷѷ���
      $(extInfoTR).attr("a_FeeCaseInfo"           , extInfo[3]) ;   // 3    �ʷ��ײ�����
      $(extInfoTR).attr("a_ARPU"                  , extInfo[4]) ;   // 4    ƽ������
      $(extInfoTR).attr("a_DataARPU"              , extInfo[5]) ;   // 5    ƽ������ҵ������
      $(extInfoTR).attr("a_AvgFee"                , extInfo[6]) ;   // 6    Ա����ƽ������
      $(extInfoTR).attr("a_Quota"                 , extInfo[7]) ;   // 7    �����±������
      $(extInfoTR).attr("a_RewardType"            , extInfo[8]) ;   // 8    ���ѱ�����ʽ
      $(extInfoTR).attr("a_UnicomTone"            , extInfo[9]) ;   // 9    �Ƿ�ʹ����ͨ����ҵ��
      $(extInfoTR).attr("a_UnicomData"            , extInfo[10]);   //10    �Ƿ�ʹ����ͨ����ҵ��
      $(extInfoTR).attr("a_Trends"                , extInfo[11]);   //11    δ���仯����
      $(extInfoTR).attr("a_MobileUser"            , extInfo[12]);   //12    �й��ƶ��ֻ���
      $(extInfoTR).attr("a_MobileRate"            , extInfo[13]);   //13    �й��ƶ��ֻ��û�����
      $(extInfoTR).attr("a_Informationize"        , extInfo[14]);   //14    ����Ϣ��������̶�
      $(extInfoTR).attr("a_Intergration"          , extInfo[15]);   //15    ����Ϣ�����ɵ�����̶�
      $(extInfoTR).attr("a_Terminal"              , extInfo[16]);   //16    ����ҵ�ն˶��Ƶ�����̶�
      $(extInfoTR).attr("a_TransProv"             , extInfo[17]);   //17    �Կ�ʡһ�廯ʵʩ����������
      $(extInfoTR).attr("a_SinglePay"             , extInfo[18]);   //18    ��һ���˵����������
      $(extInfoTR).attr("a_Mas"                   , extInfo[19]);   //19    ��MAS������̶�
      $(extInfoTR).attr("a_CustomerProvinceNumber", extInfo[20]);   //20    ���Ź���ʡ����
      $(extInfoTR).attr("a_ExtInfoAcceptID"       , extInfo[21]);   //21    ��Ϣ����Ʒ��ˮ
      if(extInfo){
      	$(extInfoTR).attr("a_CMCCPrdListCheck"      , extInfo[22]);   //22    �б�����ʶ
      }      
      $(extInfoTR).data("a_CMCCPrdList",extInfo[23]);               //23    �б�����
      $(extInfoTR).attr("a_ExtInfoAcceptID_NEW"       , extInfo[26]);   //21    ��Ϣ����Ʒ��ˮ
      $(extInfoTR).attr("a_button_open_flag"       , extInfo[27]);   //21    ��Ϣ����Ʒ��ˮ
      
      
      //Ϊ�����и���������
      $('.p_ITDeptName',extInfoTR).text(extInfo[1]);
      if(extInfo[0]=="1"){
      	$('.p_HasITDept',extInfoTR).text("��");
      }else if(extInfo[0]=="2"){
      	$('.p_HasITDept',extInfoTR).text("û��");
      }else if(extInfo[0]=="3"){
      	$('.p_HasITDept',extInfoTR).text("δ֪/����");
      }

      if(extInfo[2]=="1"){
      	$('.p_FeeCase',extInfoTR).text("��");
      }else if(extInfo[2]=="2"){
      	$('.p_FeeCase',extInfoTR).text("û��");
      }else if(extInfo[2]=="3"){
      	$('.p_FeeCase',extInfoTR).text("δ֪/����");
      }

      $('.p_FeeCaseInfo',extInfoTR).text(extInfo[3]);

      if(retInfo)
      {
      	 var deleteCMCCPrdArray=retInfo[1];
      	 if(deleteCMCCPrdArray){
           $.each(deleteCMCCPrdArray, function(i){
           	 var deleteCMCCPrd=new Array(5);
           	 deleteCMCCPrd=deleteCMCCPrdArray[i]; 
           	 if(deleteCMCCPrd[4]=="OLD"){
                var i  = $("DIV.CMCCPrdInfo","#hiddendate_delete").size();
      	     	  var deletedate=
      	     		"<DIV class='CMCCPrdInfo'>" +
      	     		"<input type='text' name='tableid"+i+"'                           value='2'>" +
      	     		"<input type='text' name='opertype"+i+"'                          value='N'>" +
      	     		"<input type='text' name='d_CMCCPrd"+i+"'                         value='"+deleteCMCCPrd[0]+"'>"+
      	     		"<input type='text' name='d_CustomerProvinceNumber_CMCCPrd"+i+"'  value='"+deleteCMCCPrd[1]+"'>"+      	     		                          
      	     		"<input type='text' name='d_ExtInfoAcceptID_CMCCPrd"+i+"'         value='"+deleteCMCCPrd[2]+"'>"+
      	     		"<input type='text' name='d_CMCCPrdAcceptID"+i+"'                 value='"+deleteCMCCPrd[3]+"'>"+
      	     		"<input type='text' name='d_OperType"+i+"'                        value='"+deleteCMCCPrd[4]+"'>"+
                "</DIV>";
      	     		$("#hiddendate_delete").append(deletedate);
      	     }
           });
         }
      }
	 }

	 //ɾ������
   function ExtInfoDel(){
      $("input[@name='ExtInfoListChkBox']").each(function()
      {
      var checkTR = $(this.parentNode.parentNode);
      if($(this).attr("checked")){
      	  if($(checkTR).attr("a_OperType")=="OLD")//��������ݿ���ȡ�������ݣ���ӵ�ɾ��������
      	  {
      	  	  var i  = $("DIV.ExtInfo","#hiddendate_delete").size();
      	  		var deletedate=
      	  		"<DIV class='ExtInfo'>" +
      	  		"<input type='text' name='tableid"+i+"'                          value='1'>" +                                                           //������ 0-���ſͻ��ؼ�����Ϣ 1-���ſͻ���չ��Ϣ 2-�ƶ���Ϣ����Ʒ 3-���ſͻ�������Ϣ
      	  		"<input type='text' name='opertype"+i+"'                         value='N'>" +                                                           //�������� Y-�������޸� N-ɾ��(0,1,2)
      	  		"<input type='text' name='d_ITDeptName"+i+"'                     value='"+$(checkTR).attr("a_ITDeptName")+"'>"+                          //�Ƿ���IT����
      	  		"<input type='text' name='d_HasITDept"+i+"'                      value='"+$(checkTR).attr("a_HasITDept")+"'>"+                           //IT��������
      	  		"<input type='text' name='d_FeeCase"+i+"'                        value='"+$(checkTR).attr("a_FeeCase")+"'>"+                             //�Ƿ���ר���ʷѷ���
      	  		"<input type='text' name='d_FeeCaseInfo"+i+"'                    value='"+$(checkTR).attr("a_FeeCaseInfo")+"'>"+                         //�ʷ��ײ�����
      	  		"<input type='text' name='d_ARPU"+i+"'                           value='"+$(checkTR).attr("a_ARPU")+"'>"+                                //ƽ������
      	  		"<input type='text' name='d_DataARPU"+i+"'                       value='"+$(checkTR).attr("a_DataARPU")+"'>"+                            //ƽ������ҵ������
      	  		"<input type='text' name='d_AvgFee"+i+"'                         value='"+$(checkTR).attr("a_AvgFee")+"'>"+                              //Ա����ƽ������
      	  		"<input type='text' name='d_Quota"+i+"'                          value='"+$(checkTR).attr("a_Quota")+"'>"+                               //�����±������
      	  		"<input type='text' name='d_RewardType"+i+"'                     value='"+$(checkTR).attr("a_RewardType")+"'>"+                          //���ѱ�����ʽ
              "<input type='text' name='d_UnicomTone"+i+"'                     value='"+$(checkTR).attr("a_UnicomTone")+"'>"+                          //�Ƿ�ʹ����ͨ����ҵ��
              "<input type='text' name='d_UnicomData"+i+"'                     value='"+$(checkTR).attr("a_UnicomData")+"'>"+                          //�Ƿ�ʹ����ͨ����ҵ��
              "<input type='text' name='d_Trends"+i+"'                         value='"+$(checkTR).attr("a_Trends")+"'>"+                              //δ���仯����
              "<input type='text' name='d_MobileUser"+i+"'                     value='"+$(checkTR).attr("a_MobileUser")+"'>"+                          //�й��ƶ��ֻ���
              "<input type='text' name='d_MobileRate"+i+"'                     value='"+$(checkTR).attr("a_MobileRate")+"'>"+                          //�й��ƶ��ֻ��û�����
              "<input type='text' name='d_Informationize"+i+"'                 value='"+$(checkTR).attr("a_Informationize")+"'>"+                      //����Ϣ��������̶�
              "<input type='text' name='d_Intergration"+i+"'                   value='"+$(checkTR).attr("a_Intergration")+"'>"+                        //����Ϣ�����ɵ�����̶�
              "<input type='text' name='d_Terminal"+i+"'                       value='"+$(checkTR).attr("a_Terminal")+"'>"+                            //����ҵ�ն˶��Ƶ�����̶�
              "<input type='text' name='d_TransProv"+i+"'                      value='"+$(checkTR).attr("a_TransProv")+"'>"+                           //�Կ�ʡһ�廯ʵʩ����������
              "<input type='text' name='d_SinglePay"+i+"'                      value='"+$(checkTR).attr("a_SinglePay")+"'>"+                           //��һ���˵����������
              "<input type='text' name='d_Mas"+i+"'                            value='"+$(checkTR).attr("a_Mas")+"'>"+                                 //��MAS������̶�
              "<input type='text' name='d_CustomerProvinceNumber_ExtInfo"+i+"' value='"+$(checkTR).attr("a_CustomerProvinceNumber")+"'>"+              //���Ź���ʡ����
              "<input type='text' name='d_ExtInfoAcceptID"+i+"'                value='"+$(checkTR).attr("a_ExtInfoAcceptID")+"'>"+                     //��չ��Ϣ��ˮ
              "</DIV>";
      	  		$("#hiddendate_delete").append(deletedate);
      	  }
       		checkTR.remove();
      }
      });
   }
});
</script>
