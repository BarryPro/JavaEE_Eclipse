 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-10 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
	<head>
	<title>����ҵ��������������</title>
<%
  	String opCode = "7378";		
	String opName = "����ҵ��������������";	//header.jsp��Ҫ�Ĳ���   
%>

	<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
	<script language=javascript>
	  onload = function(){
	      document.all.srv_no.focus();
	  }
		
		function setupAction(){
        if(document.all.opFlag[0].checked==true){
            frm.action="f7378_2.jsp";
        }
        if(document.all.opFlag[1].checked==true){
            frm.action="f7378_4.jsp";
        }
        if(document.all.opFlag[2].checked==true){	 	
            frm.action="f7378_5.jsp";
        }
        if(document.all.opFlag[3].checked==true){	 	
            frm.action="f7378_batchOperation.jsp";
        }
        if(document.all.opFlag[4].checked==true){	 	
            frm.action="f7378_export.jsp";
        }
	  }

		function docomm(){
        if(!check(frm)) return false; 
 
        setupAction();
  		  frm.submit();	
		}
	</script>
</head>
<body>	
	<form name="frm" method="POST" onKeyUp="chgFocus(frm)">		
		 <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">����ҵ�������������� </div>
		</div>
    
    <table  cellspacing="0" >          
   		<tr> 
    		<TD width="16%" class="blue">��������</TD>
      	  <TD width="34%" >		
  					<input type="radio" name="opFlag" value="two" checked>����&nbsp;&nbsp;
  					<input type="radio" name="opFlag" value="three">ɾ��&nbsp;&nbsp;
  					<input type="radio" name="opFlag" value="one">��ѯ
  					<input type="radio" name="opFlag" value="one">������Ӻ�ɾ��
  					<input type="radio" name="opFlag" value="one">��������
        	</TD>	          
      </tr>    
     	
     	<tr> 
  			<td width="16%"  nowrap class="blue"> 
    				�ֻ�����
  			</td>
  			<td nowrap  width="34%" >             
      			<input  type="text" size="12" name="srv_no" id="srv_no"
      			   v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   
      			   maxlength="11" index="0" value =<%=activePhone%>  readonly class="InputGrey">
      			<font class="orange">*</font>
  			</td>     
     	</tr>       
    
     	<TR id="listtype_id">
    		<TD width="16%" class="blue">��������</TD>
      	  <TD width="34%">
  					<select name="listtype">
  						<option value="W">������</option>
  						<option value="B">������</option>
  					</select>
			      <font class="orange">*</font>
          </TD>         
     	</TR>    
    </table>
    
    <table  cellspacing="0" >          
     	<tr> 
        <td id="footer">              
      		<input type=button name="confirm"class="b_foot"  value="ȷ��" onClick="docomm()" index="2">    
      		<input type=button name=back value="���" class="b_foot" onClick="frm.reset()">
          <input type=button name=qryP value="�ر�" class="b_foot" onClick="removeCurrentTab();">             
        </td>
    	</tr>
    </table>
      
    <%@ include file="/npage/include/footer.jsp" %>   
  </form>
</body>
</html>