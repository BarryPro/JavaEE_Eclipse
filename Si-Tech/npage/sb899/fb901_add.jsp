<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����ϵ������ fb901
   * �汾: 1.0
   * ����: 2010/11/30
   * ����: wanglm
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%
	String opCode="b901";
	String opName="����ϵ������";
	String work_no = (String)session.getAttribute("workNo");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>����ϵ������</TITLE>
</HEAD>
<script language="javascript" >
	function selectGroup(){
    	window.open("grouptree.jsp",'_blank','height=600,width=300,scrollbars=yes');
	}
	function doSubmit(){
		if($("#groupId").val() == ""){
			rdShowMessageDialog("��ѡ����֯�ڵ�!");
			return;
		}
		if($("#serviceNo").val() == ""){
		  	rdShowMessageDialog("������벻��Ϊ��!");
			return;
		}else{
			var serviceNoVal = $("#serviceNo").val();
			if(serviceNoVal.substring(serviceNoVal.length-1) != "|"){
			   	$("#serviceNo").val(serviceNoVal+"|");
			}
		}
		if($("#administratorNo").val() == ""){
		  	rdShowMessageDialog("����Ա���벻��Ϊ��!");
			return;
		}else{
			var administratorNoVal = $("#administratorNo").val();
			if(administratorNoVal.substring(administratorNoVal.length-1) != "|"){
			   	$("#administratorNo").val(administratorNoVal+"|");
			}
		}
	   	form1.action = "fb901_sub.jsp?opCode=<%=opCode%>";
	   	form1.submit();
	}
</script>
<body>
	<FORM method="post" name="form1" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">����ϵ������</div>
    </div>
    <table cellSpacing="0">
    	<tr>
    		<td class="blue">��֯�ڵ�</td>
    		<td>
    			<input type="hidden" name="groupId" id="groupId">
    			<input type="text" name="groupName" id="groupName" class="InputGrey" readonly />
    			<font color="orange">*</font>
    			<input type="button" name="selectBtn" class="b_text" value="ѡ��" onclick="selectGroup()" />
    		</td>
    		<td class="blue">��æָ�� </td>
    	    <td>
    	    	<select name="busy" id="busy" style="width:100px">
    	    		<option value="1" />1
    	    		<option value="2" />2
    	    		<option value="3" />3
    	    		<option value="4" />4
    	    		<option value="5" />5
    	    	</select>
    	    	<font color="orange" >*</font>
    	    </td>
    	    <td class="blue">��æָ�� </td>
    	    <td>
    	    	<select name="varyBusy" id="varyBusy" style="width:100px">
    	    		<option value="1" />1
    	    		<option value="2" />2
    	    		<option value="3" />3
    	    		<option value="4" />4
    	    		<option value="5" />5
    	    		<option value="6" />6
    	    		<option value="7" />7
    	    		<option value="8" />8
    	    		<option value="9" />9
    	    		<option value="10" />10
    	    	</select>
    	    	<font color="orange" >*</font>
    	    </td>
    	</tr>
    	<tr>
    	    <td class="blue">�ȴ����� </td>
    	    <td>
    	    	<select name="waitPeoples" id="waitPeoples" style="width:100px">
    	    		<option value="10" />10
    	    		<option value="20" />20
    	    		<option value="30" />30
    	    		<option value="40" />40
    	    		<option value="50" />50
    	    		<option value="60" />60
    	    		<option value="70" />70
    	    		<option value="80" />80
    	    		<option value="90" />90
    	    		<option value="100" />100
    	    	</select>
    	    	<font color="orange" >*</font>
    	    </td>
    	    <td class="blue">�ȴ�ʱ�� </td>
    	    <td colspan="3">
    	    	<select name="waitTime" id="waitTime" style="width:100px">
    	    		<option value="10" />10����
    	    		<option value="20" />20����
    	    		<option value="30" />30����
    	    		<option value="40" />40����
    	    		<option value="50" />50����
    	    		<option value="60" />60����
    	    		<option value="70" />70����
    	    		<option value="80" />80����
    	    		<option value="90" />90����
    	    	</select>
    	    	<font color="orange" >*</font>
    	    </td>
        </tr>
        <tr>
           <td class="blue" >Ӫҵ��������Ա�ֻ���</td>	
           <td colspan="5">
              <input type="text" name="serviceNo" id="serviceNo" size="60" />
              <font color="orange" >*����������á�|���ָ���</font>	
           </td>
        </tr>	
        <tr>
           <td class="blue" >���зֹ�˾������Ա�ֻ���</td>	
           <td colspan="5">
              <input type="text" name="administratorNo" id="administratorNo" size="60" />
              <font color="orange" >*����������á�|���ָ���</font>	
           </td>
        </tr>
    	<tr>
			<td colspan="6" align="center" id="footer">
			<input class="b_foot" name="submits" type="button" onclick="doSubmit()" value="ȷ��" />
			<input class="b_foot" name="reee"    type="button" onClick="form1.reset()" value="���"/>
			<input class="b_foot" name="re"    type="button" onClick="javascript:history.go(-1);" value="����"/>
			<input class="b_foot" name="back"    type="button" onClick="removeCurrentTab()" value="�ر�"/>
			</td>
		</tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
 <font color="#0256b8" >
        &nbsp;&nbsp;����˵����
        <br/>
        <br/>
        &nbsp;&nbsp;1.���÷�æ�̶�ϵ��<br/>
        &nbsp&nbsp;Ӫҵ����æ�̶ȷ�Ϊ��æ����æ����æ����,�����õȺ�������Ӫҵ��̨ϯ������������ϵ������:<br/>
        &nbsp;&nbsp;Ӫҵ��̨ϯ��=N �Ⱥ�����=Y   <br/>
        &nbsp;&nbsp;��æ   (��æָ��)��N��Y��  0  ��N<br/>
        &nbsp;&nbsp;��æ   (��æָ��)��N��Y��(��æָ��)��N<br/>
        &nbsp;&nbsp;��æ    +�� ��N��Y��(��æָ��)��N<br/>
       &nbsp;&nbsp; ��Ӫҵ����æ״̬Ϊ��æ���æʱ���͸澯���ŵ����зֹ�˾\Ӫ�������������Ա�ֻ���:<br/>
        &nbsp;&nbsp;**Ӫҵ���� *ʱ*��״̬Ϊ��æ��<br/>
        <br/>
       &nbsp;&nbsp; 2.���ö��ŷ���ϵ��<br/>
        &nbsp;&nbsp;����Ӫҵ���ڵȺ�������ֵ����Ӫҵ���Ⱥ����������趨ϵ��ʱ�Զ����͸澯���ŵ�Ӫҵ��������Ա�ֻ���:<br/>
        &nbsp;&nbsp;**Ӫҵ���� *ʱ*�ֵȺ�����Ϊ**�ˡ�<br/>
        <br/>
        &nbsp;&nbsp;3.����ƽ���Ⱥ�ʱ�䷧ֵ<br/>
       &nbsp;&nbsp; ����Ӫҵ���ڵȺ�ʱ�䷧ֵ�����ͻ���Ӫҵ���ĵȺ�ʱ�䳬���趨�ķ�ֵʱ���͸澯���ŵ�Ӫҵ��������Ա�ֻ���:<br/>
       &nbsp;&nbsp; **Ӫҵ���� *ʱ*��*�ͻ��Ⱥ�ʱ�䳬��*���ӡ�<br/>
	  
        </font>
</body>
</html>
    		
    			