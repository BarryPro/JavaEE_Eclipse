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
		 System.out.println("sp_Action = "+sp_Action);
%>

<div id="form">
	<input type="hidden" id=p_Action value="<%=sp_Action%>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="10%" nowrap>ѡ��</th>
	        <th width="25%" nowrap>����</th>
	        <th width="25%" nowrap>��Ա��ɫ</th>
	        <th width="25%" nowrap>�Ա�</th>
	        <th width="25%" nowrap>��ϵ�绰</th>
	      </tr>
        <tbody>
<wtc:service name="s9101DetQry" outnum="22" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="0"/>
	<wtc:param value="<%=sCustomerProvinceNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="20" scope="end" />
<%
	if(retCode.equals("000000")){				   
		if(result.length>0){
			for(int i=0;i<result.length;i++){			  
%>
  			  <tr class="keyperson_contenttr"
  			  	  a_Role="<%=result[i][1]%>"
  			  	  a_PartyName="<%=result[i][2]%>"
  			  	  a_Sex="<%=result[i][3]%>"
  			  	  a_ContactPhone="<%=result[i][4]%>"
  			  	  a_Title="<%=result[i][5]%>"
  			  	  a_Alias="<%=result[i][6]%>"
  			  	  a_Birthday="<%=result[i][7]%>"
  			  	  a_Memorial="<%=result[i][8]%>"
  			  	  a_Mate="<%=result[i][9]%>"
  			  	  a_Secretary="<%=result[i][10]%>"
  			  	  a_School="<%=result[i][11]%>"
  			  	  a_ClassMates="<%=result[i][12]%>"
  			  	  a_Hobby="<%=result[i][13]%>"
  			  	  a_Leader="<%=result[i][14]%>"
  			  	  a_LeaderDept="<%=result[i][15]%>"
  			  	  a_Vassal="<%=result[i][16]%>"
  			  	  a_Intercourse="<%=result[i][17]%>"
  			  	  a_CustomerProvinceNumber="<%=result[i][0]%>"
  			  	  a_OperType="OLD"
  			  	>
						<td classes="grey"><input type="checkbox" name="KeyPersonListChkBox" value="0" >
					  </td>
				    <td><a class="p_PartyName" style="cursor: hand;"><%=result[i][2]%></a>
					  &nbsp</td>
					  <td class=p_Role><%=result[i][18]%>&nbsp					  	
					  </td>
					  <td class=p_Sex><%=result[i][19]%>&nbsp
					  </td>
					  <td class=p_ContactPhone><%=result[i][4]%>&nbsp
					  </td>
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
	        <tr id="keyPerson_buttontr">

	        	<th colspan="5" align="center">
	        		<input type="button" class="b_text" id="KeyPersonAdd" value="����">
	        		&nbsp;
	        		<input type="button" class="b_text" id="KeyPersonDel" value="ɾ��">
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


//���ع�����
$("#wait2").hide();

$(document).ready(function(){
	
	

   //ע����������
	 $('#KeyPersonAdd').click(function(){
	     KeyPersonAdd();
	 });

	 //ע����º���
	 $('.p_PartyName').bind('click', KeyPersonUpdate);

	 //ע��ɾ������
	 $('#KeyPersonDel').click(function(){
	     KeyPersonDel();
	 });

	 //��������
	 function KeyPersonAdd(){
	 	  var keyPerson = new Array(18);
	 	  keyPerson=[
	 	            "",                                  //0   ��Ա��ɫ
	 	            "",                                  //1   ����
	 	            "",                                  //2   �Ա�
	 	            "",                                  //3   ��ϵ�绰
	 	            "",                                  //4   ְ��
	 	            "",                                  //5   �ǳ�
	 	            "",                                  //6   ����
	 	            "",                                  //7   ������
	 	            "",                                  //8   ��ż����
	 	            "",                                  //9   ��������
	 	            "",                                  //10  ��ҵԺУ
	 	            "",                                  //11  ͬ��
	 	            "",                                  //12  ��Ȥ������
	 	            "",                                  //13  �ϼ��쵼
	 	            "",                                  //14  �ϼ�����
	 	            "",                                  //15  �¼�����
	 	            "",                                  //16  �罻Ȧ
	 	            $("#p_CustomerProvinceNumber").val(), //17  ���Ź���ʡ����
	 	            $("#p_Action").val()                  //18  ��������
	 	            ]
	    var retInfo = window.showModalDialog
	    (
	    'f2002_KeyPerson_detail.jsp?s_CustomerNumber='+$("#p_CustomerNumber").val(),
	    keyPerson,
	    'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
	    );
	    if(retInfo=="Y"){//��رհ�ť������

	    	 var p_Role_tmp;
	       if(keyPerson[0]=="1"){
         	p_Role_tmp="�쵼";
         }else if(keyPerson[0]=="2"){
         	p_Role_tmp="ҵ������";
         }else if(keyPerson[0]=="3"){
         	p_Role_tmp="��ϵ��";
         }else if(keyPerson[0]=="4"){
         	p_Role_tmp="����Ӱ����";
         }

         var p_Sex_tmp;
         if(keyPerson[2]=="1"){
         	p_Sex_tmp="��";
         }else if(keyPerson[2]=="2"){
         	p_Sex_tmp="Ů";
         }

	       var newtrstr =
	          "<tr class=\"keyperson_contenttr\"   "+
  			  	" a_Role="+                     "'"+keyPerson[0] +"'"+
  			  	" a_PartyName="+                "'"+keyPerson[1] +"'"+
  			  	" a_Sex="+                      "'"+keyPerson[2] +"'"+
  			  	" a_ContactPhone="+             "'"+keyPerson[3] +"'"+
  			  	" a_Title="+                    "'"+keyPerson[4] +"'"+
  			  	" a_Alias="+                    "'"+keyPerson[5] +"'"+
  			  	" a_Birthday="+                 "'"+keyPerson[6] +"'"+
  			  	" a_Memorial="+                 "'"+keyPerson[7] +"'"+
  			  	" a_Mate="+                     "'"+keyPerson[8] +"'"+
  			  	" a_Secretary="+                "'"+keyPerson[9] +"'"+
  			  	" a_School="+                   "'"+keyPerson[10]+"'"+
  			  	" a_ClassMates="+               "'"+keyPerson[11]+"'"+
  			  	" a_Hobby="+                    "'"+keyPerson[12]+"'"+
  			  	" a_Leader="+                   "'"+keyPerson[13]+"'"+
  			  	" a_LeaderDept="+               "'"+keyPerson[14]+"'"+
  			  	" a_Vassal="+                   "'"+keyPerson[15]+"'"+
  			  	" a_Intercourse="+  	          "'"+keyPerson[16]+"'"+
  			  	" a_CustomerProvinceNumber="+  	"'"+keyPerson[17]+"'"+
  			  	" a_OperType= 'NEW'"+
  			  	">"+
						"<td classes=\"grey\"><input type=\"Checkbox\" name=\"KeyPersonListChkBox\">"+
					  "</td>"+
				    "<td><a class=\"p_PartyName\" style=\"cursor: hand;\">"+keyPerson[1]+"</a>"+
					  "</td>"+
					  "<td class=p_Role>"+p_Role_tmp+
					  "</td>"+
					  "<td class=p_Sex>"+p_Sex_tmp+
					  "</td>"+
					  "<td class=p_ContactPhone>"+keyPerson[3]+
					  "</td>"+
	          "</tr>";
	       $("#keyPerson_buttontr").before(newtrstr);
	       //ע����º���
	       $('.p_PartyName').bind('click', KeyPersonUpdate);
	    }
	 }
	 //���º���
	 function KeyPersonUpdate(){
	 	  var keyPerson = new Array(17);
      var keyPersonTR = $(this).parent().parent();
	 	  keyPerson=[
	 	  	        $(keyPersonTR).attr("a_Role"                  ),//0
	 	  	        $(keyPersonTR).attr("a_PartyName"             ),//1
	 	  	        $(keyPersonTR).attr("a_Sex"                   ),//2
	 	  	        $(keyPersonTR).attr("a_ContactPhone"          ),//3
	 	  	        $(keyPersonTR).attr("a_Title"                 ),//4
	 	  	        $(keyPersonTR).attr("a_Alias"                 ),//5
	 	  	        $(keyPersonTR).attr("a_Birthday"              ),//6
	 	  	        $(keyPersonTR).attr("a_Memorial"              ),//7
	 	  	        $(keyPersonTR).attr("a_Mate"                  ),//8
	 	  	        $(keyPersonTR).attr("a_Secretary"             ),//9
	 	  	        $(keyPersonTR).attr("a_School"                ),//10
	 	  	        $(keyPersonTR).attr("a_ClassMates"            ),//11
	 	  	        $(keyPersonTR).attr("a_Hobby"                 ),//12
	 	  	        $(keyPersonTR).attr("a_Leader"                ),//13
	 	  	        $(keyPersonTR).attr("a_LeaderDept"            ),//14
	 	  	        $(keyPersonTR).attr("a_Vassal"                ),//15
	 	  	        $(keyPersonTR).attr("a_Intercourse"           ),//16
	 	  	        $(keyPersonTR).attr("a_CustomerProvinceNumber"), //17
	 	  	        $("#p_Action").val()                  //18  ��������
	 	  	        ];

	    var retInfo = window.showModalDialog
	    (
	    'f2002_KeyPerson_detail.jsp',
	    keyPerson,
	    'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
	    );

	    //this.tr.attr��ֵ
	    $(keyPersonTR).attr("a_Role"                   , keyPerson[0] );
      $(keyPersonTR).attr("a_PartyName"              , keyPerson[1] );
      $(keyPersonTR).attr("a_Sex"                    , keyPerson[2] );
      $(keyPersonTR).attr("a_ContactPhone"           , keyPerson[3] );
      $(keyPersonTR).attr("a_Title"                  , keyPerson[4] );
      $(keyPersonTR).attr("a_Alias"                  , keyPerson[5] );
      $(keyPersonTR).attr("a_Birthday"               , keyPerson[6] );
      $(keyPersonTR).attr("a_Memorial"               , keyPerson[7] );
      $(keyPersonTR).attr("a_Mate"                   , keyPerson[8] );
      $(keyPersonTR).attr("a_Secretary"              , keyPerson[9]);
      $(keyPersonTR).attr("a_School"                 , keyPerson[10]);
      $(keyPersonTR).attr("a_ClassMates"             , keyPerson[11]);
      $(keyPersonTR).attr("a_Hobby"                  , keyPerson[12]);
      $(keyPersonTR).attr("a_Leader"                 , keyPerson[13]);
      $(keyPersonTR).attr("a_LeaderDept"             , keyPerson[14]);
      $(keyPersonTR).attr("a_Vassal"	 	             , keyPerson[15]);
      $(keyPersonTR).attr("a_Intercourse"            , keyPerson[16]);
      $(keyPersonTR).attr("a_CustomerProvinceNumber" , keyPerson[17]);

      $('.p_PartyName',keyPersonTR).text(keyPerson[1]);

      if(keyPerson[0]=="1"){
      	$('.p_Role',keyPersonTR).text("�쵼");
      }else if(keyPerson[0]=="2"){
      	$('.p_Role',keyPersonTR).text("ҵ������");
      }else if(keyPerson[0]=="3"){
      	$('.p_Role',keyPersonTR).text("��ϵ��");
      }else if(keyPerson[0]=="4"){
      	$('.p_Role',keyPersonTR).text("����Ӱ����");
      }

      if(keyPerson[2]=="1"){
      	$('.p_Sex',keyPersonTR).text("��");
      }else if(keyPerson[2]=="2"){
      	$('.p_Sex',keyPersonTR).text("Ů");
      }

      $('.p_ContactPhone',keyPersonTR).text(keyPerson[3]);
	 }

	 //ɾ������
   function KeyPersonDel(){
      $("input[@name='KeyPersonListChkBox']").each(function()
      {
      var checkTR = $(this.parentNode.parentNode);
      if($(this).attr("checked")){
      	  if($(checkTR).attr("a_OperType")=="OLD")//��������ݿ���ȡ�������ݣ���ӵ�ɾ��������
      	  {         	  	  
      	  	  var ii  = $("DIV.KeyPerson","#hiddendate_delete").size();
      	  		var deletedate=
      	  		"<DIV class='KeyPerson'>" +
      	  		"<input type='text' name='tableid"+ii+"'        value='3'>" +
      	  		"<input type='text' name='opertype"+ii+"'       value='N'>" +
      	  		"<input type='text' name='d_Role"+ii+"'         value='"+$(checkTR).attr("a_Role")+"'>"+                         //��Ա��ɫ           
      	  		"<input type='text' name='d_PartyName"+ii+"'    value='"+$(checkTR).attr("a_PartyName")+"'>"+                    //����               
      	  		"<input type='text' name='d_Sex"+ii+"'          value='"+$(checkTR).attr("a_Sex")+"'>"+                          //�Ա�               
      	  		"<input type='text' name='d_ContactPhone"+ii+"' value='"+$(checkTR).attr("a_ContactPhone")+"'>"+                 //��ϵ�绰            
      	  		"<input type='text' name='d_Title"+ii+"'        value='"+$(checkTR).attr("a_Title")+"'>"+                        //ְ��               
      	  		"<input type='text' name='d_Alias"+ii+"'        value='"+$(checkTR).attr("a_Alias")+"'>"+                        //�ǳ�               
      	  		"<input type='text' name='d_Memorial"+ii+"'     value='"+$(checkTR).attr("a_Memorial")+"'>"+                     //����               
      	  		"<input type='text' name='d_Birthday"+ii+"'     value='"+$(checkTR).attr("a_Birthday")+"'>"+                     //������             
      	  		"<input type='text' name='d_Mate"+ii+"'         value='"+$(checkTR).attr("a_Mate")+"'>"+                         //��ż����           
      	  		"<input type='text' name='d_Secretary"+ii+"'    value='"+$(checkTR).attr("a_Secretary")+"'>"+                    //��������           
      	  		"<input type='text' name='d_School"+ii+"'       value='"+$(checkTR).attr("a_School")+"'>"+                       //��ҵԺУ           
              "<input type='text' name='d_ClassMates"+ii+"'   value='"+$(checkTR).attr("a_ClassMates")+"'>"+                  //ͬ��               
              "<input type='text' name='d_Hobby"+ii+"'        value='"+$(checkTR).attr("a_Hobby")+"'>"+                        //��Ȥ������         
              "<input type='text' name='d_Leader"+ii+"'       value='"+$(checkTR).attr("a_Leader")+"'>"+                       //�ϼ��쵼           
              "<input type='text' name='d_LeaderDept"+ii+"'   value='"+$(checkTR).attr("a_LeaderDept")+"'>"+                   //�ϼ�����           
              "<input type='text' name='d_Vassal"+ii+"'       value='"+$(checkTR).attr("a_Vassal")+"'>"+                       //�¼�����           
              "<input type='text' name='d_Intercourse"+ii+"'  value='"+$(checkTR).attr("a_Intercourse")+"'>"+                  //�罻Ȧ             
              "<input type='text' name='d_CustomerProvinceNumber_KeyPerson"+ii+"' value='"+$(checkTR).attr("a_CustomerProvinceNumber")+"'>"+       //���Ź���ʡ����     
              "</DIV>";                                                                                                            
      	  		$("#hiddendate_delete").append(deletedate);                                                                          
      	  }          
       		checkTR.remove();
      }
      })
   }
});
</script>
