 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-12 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String opCode = "3052";		
	String opName = "ҵ��������Ա�ʷѹ�ϵά��";	//header.jsp��Ҫ�Ĳ��� 	
%>	

<html>
<head>	
	<title>ҵ��������Ա�ʷѹ�ϵά��</title>
	<script language=javascript>
	
		function queryEC(){		
			var bizCode = document.all.bizCode.value;
			var spCode = document.all.spCode.value;
			document.middle.location="f3052QueryList.jsp?"
				+ "&spCode=" + spCode
				+ "&bizCode=" + bizCode;
			 tabBusi.style.display="";
		}
		
		function addEC(){			
			window.open("f3052Add.jsp","","height=600,width=800,scrollbars=yes");
		}
	
	</script>

</head>
<body>
<form action="" name="form1"  method="post">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">��ѯ����</div>
		</div>	
      <table cellspacing="0">
	    <tr >	     
		  <TD width="16%" class="blue">SI/EC��ҵ����</TD>
	  	  <TD  width="34%">
		  	<input type=text name=spCode  v_type=int v_must=0  v_maxlength=6 />
		  	<font class="orange">*</font>
		  </TD>		 
		  <TD width="16%" class="blue">ҵ�����</TD>
	  	  <TD width="34%">
		      <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10  name=bizCode maxlength=10 value="" />
		      <font class="orange">*</font>
		  </TD>
	    </tr>
	  </table>		
      	<TABLE id="tabBtn" style="display:block"  cellspacing="0" >	    
		<TR> 
	 	  <TD id="footer"> 
	 	    <input name="queryAcBtn" class="b_foot" style="cursor:hand" type="button"  value="��  ѯ" onClick="queryEC();">
	 	    &nbsp;
	 	    <input name="newAcBtn"   class="b_foot" style="cursor:hand" type="button"  value="��  ��" onClick="addEC();">
	 	    &nbsp;  
	 	    <input name="" type="button" class="b_foot" style="cursor:hand"  value="��  ��" onClick="removeCurrentTab();" >
	 	  </TD>
		</TR>
      </TABLE> 
      <br>	  
      <div class="title">
	  <div id="title_zi">ҵ����Ϣ</div>
      </div>	
      <TABLE id="tabBusi" style="display:none"  id="mainOne"  cellspacing="0" >	
        <TR> 
	      <td nowrap>
		    <IFRAME frameBorder=0 id=middle name=middle scrolling="yes" style=" VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
		    </IFRAME>
	      </td> 
        </TR>
     </TABLE>
      <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>

