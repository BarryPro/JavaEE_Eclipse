<%
   /***********************************************
   * ����: �޸�����
�� * �汾: 1.0
�� * ��Ȩ: sitech
   * �޸ģ�tangxlc
   * ���ڣ�2010/03/10 
   * ���ݣ��޸�����Ϊ���������Ӣ��
 ��************************************************/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*"%>
<%
    String opCode = "K315";
    String opName = "�޸�����";
  
    ArrayList retArray = (ArrayList)session.getAttribute("allArr");
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String orgName = (String)session.getAttribute("orgName");
		String deptCode = (String)session.getAttribute("deptCode");
		String orgId = (String)session.getAttribute("orgId");
		String groupId = (String)session.getAttribute("groupId");
		String powerCode = (String)session.getAttribute("powerCode");
		String powerRight = (String)session.getAttribute("powerRight");
		String orgCode = (String)session.getAttribute("orgCode");
		String contactID = (String)session.getAttribute("contactID");
		String login_name = (String)session.getAttribute("login_name");
		
		
		
		String aaa = (String)session.getAttribute("workNo");
System.out.print("tangxlc-------aaaa---------userId: \n"+aaa);
%>                 
<html>
<head>
<title>�޸�����</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
        
        $(document).ready
        (
            function()
            {
                $("td").not("[input]").addClass("blue");
                $("#footer input:button").addClass("b_foot");
                $("td:not(#footer) input:button").addClass("b_text");
                $("input:text[@v_type]").blur(checkElement2);   
                
                $("a").hover
                (
                    function() 
                    {              
                        $(this).css("color", "orange");
                    },function() 
                    {
                        $(this).css("color", "blue");
                    }
                );
            }
        );
        function checkElement2()
        { 
            checkElement(this); 
        }       
//=========================================================================
// �ж��ַ����Ƿ�������
//=========================================================================
function isDigital(str)         
{   
	    var ilen;
      for(ilen=0;ilen<str.length;ilen++)   
      {   
          if(str.charAt(ilen)<'0' || str.charAt(ilen) >'9')   
          {   
             return   false;   
          }         
      }   
      return   true;   
}
//=========================================================================
// �û�������ȷ�Լ��
//=========================================================================
function submitInputCheck(sqlFilter)
{
	  //����ĵ绰����
	  var phone_no =document.sitechform.phone_number.value;
	  
	  //�жϵ绰�����Ƿ�Ϊ��
	  if(phone_no =="")
    {
       showTip(document.sitechform.phone_number,"������벻��Ϊ��");  
       sitechform.phone_number.focus();
       return ;       
    }
    //�ж��û�����绰�����Ƿ�11λ������
    if(phone_no.length != '11' || !isDigital(phone_no))
    {
   	   showTip(document.sitechform.phone_number,"������ʮһλ�����ֵĵ绰���룡");
       sitechform.phone_number.focus(); 
       return;
    }
    hiddenTip(document.sitechform.phone_number);
    submitMe();
}
//=========================================================================
// �ύ��
//=========================================================================
function submitMe()
{  
   //��ѯ����
   var mypacket = new AJAXPacket("K315_cancelDefLangQry_Select.jsp","���ڲ�ѯ���֣����Ժ�......");
   var phoneno = window.sitechform.phone_number.value ;
	 mypacket.data.add("telphoneno",phoneno);
   core.ajax.sendPacket(mypacket,doProcessSelect,false);
	 mypacket=null;
}
//=========================================================================
// �����ѯ�������
//=========================================================================
function doProcessSelect(packet)
{
  var langcode="";
  var table_op="";
	var telphoneno = packet.data.findValueByName("telphoneno");
  var lang = packet.data.findValueByName("lang");
	if (lang =="1")langcode="����";
	else langcode="Ӣ��";
	
	if(telphoneno=="FAILURE")
	{
      table_op =           "<table  cellSpacing='0'  >";
      table_op =table_op + "<br><br><div class='title' align='center'>��ѯ���</div> "; 
      table_op =table_op + " <tr><th align='center'><font color='orange'>�޴��ֻ�����<font></th></tr>";
      table_op =table_op + "</table>";
	}
	else
  {
      table_op =           "<table  cellSpacing='0' >";
      table_op =table_op + "<br><br><div class='title' align='center'>��ѯ���</div> "; 
      table_op =table_op + "<tr >";
      table_op =table_op + "  <th align='center' class='blue' width='40%' > �ֻ����� </th>";
      table_op =table_op + "  <th align='center' class='blue' width='40%' > Ĭ������ </th>";
      table_op =table_op + "</tr>";
      table_op =table_op + "<tr>";
      table_op =table_op + "	<th id='phone' align='center' class='blue' width='40%'>"+telphoneno;
      table_op =table_op + "	</th>";
      table_op =table_op + "	<th id='languagecode' align='center' class='blue' width='40%'>"+langcode ;
      table_op =table_op + "	</th>	";
      table_op =table_op + " </tr>";
      table_op =table_op + "</table>";
  }
  document.getElementById("Reserch_Table").innerHTML=table_op;
}
//=========================================================================
// SUBMIT Update TO THE SERVELET
//=========================================================================
function UpdateLang()
{
	 //����ĵ绰����
	 var phone_no =document.sitechform.phone_number.value;
	 
	 //�жϵ绰�����Ƿ�Ϊ��
	 if(phone_no =="")
   {
       showTip(document.sitechform.phone_number,"������벻��Ϊ��");  
       sitechform.phone_number.focus();
       return false;       
   }
   //�ж��û�����绰�����Ƿ�11λ������
	 if(phone_no.length != '11' || !isDigital(phone_no))
   {
   	   showTip(document.sitechform.phone_number,"������ʮһλ�����ֵĵ绰���룡");
   	   sitechform.phone_number.focus(); 
   	   return;
   }
   hiddenTip(document.sitechform.phone_number);
   
   //�ж��Ƿ��Ѿ�ѡ��������
   if (window.sitechform.selectLangFlag.value==3)
   {
   	   showTip(document.sitechform.selectLangFlag,"��ѡ������"); 
       sitechform.selectLangFlag.focus();  
       return false;   
   }   	 
	 hiddenTip(document.sitechform.selectLangFlag);

   //ȷ���޸�����
	 if(rdShowConfirmDialog("ȷ���޸����֣�")!= 1) return ;
   var mypacket = new AJAXPacket("K315_cancelDefLangQry_update.jsp","�����޸����֣����Ժ�......");
   var phoneno = window.sitechform.phone_number.value ;
   var languagetype =window. sitechform.selectLangFlag.value ;
	 mypacket.data.add("telphoneno",phoneno);
	 mypacket.data.add("languagetype",languagetype);
	 mypacket.data.add("wordNo","<%=workNo%>");
	 mypacket.data.add("workName","<%=workName%>");
	 mypacket.data.add("contactID","<%=contactID%>");
   core.ajax.sendPacket(mypacket,doProcess,false);
	 mypacket=null;
	 submitMe();
}

//=========================================================================
// Clear page recodes.
//=========================================================================
function clearValue()
{
	
	document.getElementById("Reserch_Table").innerHTML="<br>";
	var e=window.sitechform;
  for(var i=0;i<e.length;i++)
  {
    if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden")
    {
    	  if(e[i].type=="select-one")
    	  {
    	  	e[i].value="3";
    	  }
    	  else
        {
        	e[i].value="";
        	hiddenTip(e[i]);
        }
    }
    if(e[i].type=="checkbox")
    {
        e[i].checked=false;
    }
  }

}
//=========================================================================
// DoProcess.
//=========================================================================
function doProcess(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="000000")
	{
	   rdShowMessageDialog("�����޸ĳɹ���",1);
	   return;
	}
  rdShowMessageDialog("���ֻ����������ּ�¼���޸�ʧ��!",1);
}
function changeOthers()
{
    hiddenTip(document.sitechform.phone_number);
    hiddenTip(document.sitechform.selectLangFlag);
}
</script>
</head>
<body >
<form id=sitechform name=sitechform>
  <div id="Operation_Table">
    <table cellspacing="0"> 	
    	<tr><%@ include file="/npage/include/header.jsp"%></tr>
      <tr >
        
     	  <div class="title" ></div>
        <td >�ֻ�����</td>
        <td >
          <input id="phone_number" name="phone_number" type="text" maxlength='11'>
          <font color="orange">*</font>
        <td > �޸�����Ϊ </td>
        <td >
        	<SELECT name="selectLangFlag" class="button" id="selectLangFlag" onChange="changeOthers()">
						<option value="3" selected>��ѡ������</option>
						<option value="1" >����</option>
						<option value="2" >Ӣ��</option>
					</SELECT>
        </td>
      </tr>
      <!-- ICON IN THE MIDDLE OF THE PAGE-->
      <tr >
        <td colspan="8" align="center" id="footer">	
      	  <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
      	  <input name="search" type="button"  id="search" value="�޸�" onClick="UpdateLang();return false;">
      	  <input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;">
        </td>
      </tr>
    </table>     
    <div id="Reserch_Table"> 
    </div>
  </div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

