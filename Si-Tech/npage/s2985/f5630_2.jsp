<%
   /*
   * ����: ��������ϸ����
�� * �汾: v1.0
�� * ����: 2008/04/21
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:2009/05/14      �޸���:leimd      �޸�Ŀ��:��Ӧ������
 ��*/
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%
	String opCode = "2985";
	String opName = "��������ϸ����";
	String loginNo = (String)session.getAttribute("workNo");
	String nopass  = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
     
    String param_set   = request.getParameter("param_set");
	String  set_name    = request.getParameter("set_name");
     
    String [] check = request.getParameterValues("check");    
    String [] vParamCodeIn   = {""};     
	String [] vParamNameIn      = {""};   

    if(check!=null)
    { 		
		String [] vParamCode   = request.getParameterValues("ParamCode");
		String [] vParamName       = request.getParameterValues("ParamName");
		
		vParamCodeIn         = new String [check.length];	
		vParamNameIn         = new String [check.length];	
		
		for(int i=0;i<check.length;i++)
		{
			vParamCodeIn[i]    =vParamCode[new Integer(check[i]).intValue()];
			vParamNameIn[i]    =vParamName[new Integer(check[i]).intValue()];
		}
	}
	 
 	for( int m=0;m<check.length;m++)
	{
	   System.out.println("vParamCodeIn[0]="+vParamCodeIn[m]);
	   System.out.println("vParamNameIn[0]="+vParamNameIn[m]);
	}  
	
	 int len=0;
	 String sqlStr = "select Param_Group,Group_Name from sBizParamGroup";
%>  
<wtc:pubselect name="sPubSelect" outnum="2" retcode="retCode" retmsg="retMesg" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:sql><%=sqlStr%> </wtc:sql>
</wtc:pubselect>

<wtc:array id="rows" scope="end"/>
<%			
	if(retCode.equals("000000"))
	{	
	        System.out.println("rows.length="+rows.length);
             for( int n=0;n<rows.length;n++){
	             System.out.println("rows["+n+"][0]"+rows[n][0]);
	             System.out.println("rows["+n+"][1]"+rows[n][1]);
            }	
        len=rows.length;
      }
	else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("��ѯҵ�������������!",0);
			document.location.replace("<%=request.getContextPath()%>/npage/s2985/f2985.jsp");
		</script>
<%
		}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<script language=javascript>   
	 onload=function() {
     self.status="";
	 core.ajax.onreceive = doProcess;
	}
	
//����rpc���ؽ��
function doProcess(packet) {	
	  self.status="";	

	 var qryType=packet.data.findValueByName("rpcType");
	 var errCode=packet.data.findValueByName("errCode");
	 var errMsg=packet.data.findValueByName("errMsg");
	
 if(qryType == "checkParamSet"){	 
	 if(errCode == "000000")
	    {
		  rdShowMessageDialog("������Ϣ��"+errMsg + "<br>���ش��룺"+errCode,1);
		  document.form1.AddBtn.disabled=false; 
		  document.form1.allSelectt.disabled=false;
		  document.form1.noSelectt.disabled=false;
	   }else
	   	   {		   	   	
	   	   rdShowMessageDialog("������Ϣ��"+errMsg + "<br>������룺"+errCode, 0);
	        }
      }	
}	  
//У���������
function checkParamSet()
{
	if(document.form1.param_set.value=="")
	{
		rdShowMessageDialog("��������������룡");
		document.form1.param_set.focus();
		return false;
	}
	var myPacket = new AJAXPacket("fcheckParamSet_rpc.jsp","�����ύ�����Ժ�......"); 
	myPacket.data.add("param_set",document.form1.param_set.value);
	myPacket.data.add("rpcType","checkParamSet");
	core.ajax.sendPacket(myPacket);
	myPacket=null;	
} 
//ѡ��ͬ����������
function showTab(){
	if(document.form1.param_type.value=="10"){
		tabSelect.style.display="";
		tabSql.style.display="none";
	}
	else if(document.form1.param_type.value=="20"){
		tabSelect.style.display="none";
		tabSql.style.display="";
	}
}
//�ύ
function Submit(){
	  if(document.all.check==undefined)
		{
			rdShowMessageDialog("ûѡ�κβ������룡");
			return;
		}
       if(rdShowConfirmDialog('ȷ���ύ����������')==1)
	   {
		  document.form1.action="f5630Cfm.jsp"; 
		  document.form1.submit();
	   }
}	

//ҳ��ɾ����
function dynDelRow(){			 		        			
		 var args=dynDelRow.arguments[0];
		 var objTD =args.parentElement;
		 var objTR =objTD.parentElement;
		 var currRowIndex = objTR.rowIndex;
		 tbs1.deleteRow(currRowIndex);	   
 }
 
 //���ù������棬����Ŀ��ƽ̨ѡ��
function getBizTarget(num)
{ 
    var pageTitle = "ҵ�����ѡ��";
    var fieldName = "��������|��������|";
    var sqlStr = "";
    var selType = "M";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "target_code"+num+"|target_name"+num+"|";

    if(PubSimpSelBizTarget(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,num));
}

function PubSimpSelBizTarget(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,num)
{
  var path = "<%=request.getContextPath()%>/npage/s2985/fqueryBizTarget.jsp";
  path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
  path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
  path = path + "&selType=" + selType + "&retToField=" + retToField+ "&num=" +num;
     retInfo = window.open(path,"newwindow2","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
   return true;
}
//

//var n=0;
function getValueBizTarget(retInfo,num)
{
    var retToField = "target_code_array"+num+"|target_name_array"+num+"|";
    if(retInfo ==undefined)      
    {   return false;   }
    
    var target_code_array="";
    var target_name_array="";
    var flag=0;
    var chPos_retInfo = retInfo.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_retInfo > -1)
    {
        valueStr = retInfo.substring(0,chPos_retInfo);
        if(flag==0)
        {
        	target_code_array =target_code_array+ valueStr+"|";
            flag=1;
        }
        else if(flag==1)
        {
          target_name_array =target_name_array+ valueStr+"|";
        	flag=0;       	        	
        }
        else
        {
        	rdShowMessageDialog("��ѯ����ƽ̨���ز�������!",0);
        	return false;
        }
      
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_retInfo = retInfo.indexOf("|");       
    }    
     var chPos_field = retToField.indexOf("|");
     var obj;
     obj = retToField.substring(0,chPos_field);
     //alert(obj);
     document.all(obj).value = target_code_array;
     retToField = retToField.substring(chPos_field + 1);
     chPos_field = retToField.indexOf("|");   
     obj = retToField.substring(0,chPos_field);
     document.all(obj).value = target_name_array; 
     //document.all.num.value = n;        
     //document.form1.target_code_array.value=target_code_array;
     //document.form1.target_name_array.value=target_name_array;
     //document.form1.subBtn.disabled=false;
}
</script>
</head>
<body>
<FORM method="post" action="" name="form1"> 
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="loginPass" value="<%=nopass%>">
<input type="hidden" name="opNote" value="<%=loginNo%>���в�������ϸ����">
<input type="hidden" name="loginAccept" value="0">   
<input type="hidden" name="num" value="<%=check.length%>">	  

<div class="title">
	<div id="title_zi">��������ϸ����</div>
</div>
<table cellspacing="0">
	<tr>
		<TD class="blue">���������� </TD>
		<TD>	
			<input type=text v_type="string" class="button" v_must=1 v_minlength=8  v_maxlength=8 v_name="����������"  name=param_set value="<%=param_set%>" maxlength=8  readonly></input>
			<font color="orange">*</font>
			<input type="button" class="b_text"  name="check"  onClick="checkParamSet()"  value="У��" disabled >                   	              
		</TD>
		<TD class="blue">���������� </TD>
		<TD>
			<input type=text v_type="string"  class="button" v_must=1 v_minlength=8  v_maxlength=30 v_name="����������"  name=set_name value="<%=set_name%>"  maxlength=30 readonly ></input>
		</TD>	                
	</TR>
</table>

</div>
<div id="Operation_Table" >
	<div class="title">
		<div id="title_zi">��������ϸ </div>
</div>					
<TABLE id="tbs1" style=display="" cellspacing="0">
	<tr align="center">	
		<th>��������</th>
		<th>��������</th>
		<th>����˳��</th>
		<th>ȱʡֵ</th>
		<th>�Ƿ�ɿ�</th>
		<th>��ʾ����</th>
		<th>�Ƿ�ֻ��</th>
		<th>�Ƿ�����</th>
		<th>�Ƿ���޸�</th>	
		<th>����</th>		
	</tr>
		<%
	  for( int j = 0;j < check.length; j++)
		{   
        %>
	       <TR align="center">
			   <TD class="blue">	
				     <%=vParamCodeIn[j] %>
				  	<input type ="hidden" name="param_code" value=<%=vParamCodeIn[j] %>   >     
	           </TD>
			   <TD class="blue">
			      <%=vParamNameIn[j] %>   
			      <input type ="hidden" name="param_name" value=<%=vParamNameIn[j] %>>     
			</TD>
			<TD class="blue">
			       <input type ="text" name="param_order" value=""  size=5  length=2   maxlength=3   v_type="int">     
			</TD>
			<TD class="blue">
			      <input type ="text" name="default_value" value=""  size=6>     
			</TD>
			 <TD class="blue">
			      <select name="Null_Able">
					<option value="Y">���� </option>	
				     <option value= "N" >������ </option>
				</select>
			</TD>
			<TD class="blue">
			      <select name="Des_Able">
					<option value="Y">��ʾ </option>	
				     <option value= "N" >����ʾ </option>
				</select>
			</TD>
			 <TD class="blue">
			      <select name="Read_Only">
			      	<option value= "N" >�ɱ༭ </option>
					<option value="Y">ֻ�� </option>	
				</select>
			</TD>
			
			<TD class="blue">
				  
			      <select name="open_param_flag" >
						<option value="Y">�� </option>	
						<option value= "N">�� </option>
				 </select>
			</TD>	
			
		    <TD class="blue">
			     <select name="update_flag">
			      <option value="Y">�� </option>
			      <option value="N">�� </option>	
				 </select>
				 <input type="hidden" name="Multi_Able"   value="N" readonly><!---�Ƿ�������--->
				<input type="hidden" name="Param_Group"  value="" readonly><!---��������--->
	          
		  </TD>
		  	
			<td class="blue" style="display:none">
			    <input type="hidden" name="target_code_array<%=j%>" value="PADC" readonly>
			    <input type="hidden" name="target_name_array<%=j%>" value="ADCƽ̨">
			  <!-- <input type="button" name="checkFatherBtn<%=j%>" value="��ѯ" onclick="getBizTarget(<%=j%>)" >
			--></td>
		  <TD >
		     <input type="button" class="b_text"  name="delButton<%=j%>" onClick="dynDelRow(this)" value="ɾ��"  >  
		 </TD>							         		                
		  </TR>					
	        <%
			}
	        %>
</TABLE> 

	<TABLE align="center" cellSpacing="0">
	   <TR>
			<TD height="30" align="center">
				<input name="backBtn"  class="b_foot" type="button" value="��һ��" onClick="history.go(-1);">
				&nbsp;
				<input name="AddBtn"   class="b_foot" type="button" value="�ύ"  onClick="Submit()"  >
				&nbsp;
				<input name="closeBtn"  class="b_foot" type="button" value="�ر�"  onClick="removeCurrentTab();">
				&nbsp;
			</TD>
	     </TR>
	</TABLE>
	        	
	       <%@ include file="/npage/include/footer.jsp" %>
	    </form>
	 </body>
	</html>
		   