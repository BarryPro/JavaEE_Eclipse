<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.crmpd.core.wtc.*"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>	

<HTML><HEAD><TITLE>��������</TITLE>
</HEAD>
<SCRIPT type=text/javascript>
	function doSearch(){
		$("#searchResult").toggle();
	}
	
	function callDetail(){
		window.showModalDialog("callDetail.jsp","","dialogWidth:50;dialogHeight:45;");
	}
</SCRIPT>
<body>
<div id="operation">
<FORM method=post name="frm1102">
	<%@ include file="/npage/include/header.jsp" %>
 	<div id="operation_table">
 		<div class="input">
 			<div class="title">
          <div class="text">��ѯ����</div> 
      </div>
          <table>
                <TR> 
                	<Th>��ѯ������</Th>
                  <TD> 
                  	<select name="idType" id="idType" onchange="">
                  		<option value="0">�������</option>
                  		<option value="1">�ͻ�����ID</option>
                  		<option value="1">�ͻ���������ID</option>
                  		<option value="1">���񶨵�ID</option>
                  	</select> 
                  </TD>
                	 <Th><span class="red">*����ֵ��</span></Th>
                  <TD> 
                    <input type="text" name="servno" class="required" onchange=""/>
                  </TD>
                </TR>
           </table>
      </div>
      <div class="list" id="searchResult" style="display:none">
      	<table id="dataTable">
      		<tr>
	      		<th>ѡ��</th>
	      		<th>�ͻ���������ID</th>
	      		<th>�ͻ�������������</th>
	      		<th>���񶨵�</th>
	      		<th>��������</th>
	      		<th>�������</th>
	      		<th>����</th>
	      	</tr>
	      	<tr>
	      		<td><input type="checkbox" ></td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td><a href="#" onclick="callDetail()">����</a></td>
	      	</tr>
	      	<tr>
	      		<td><input type="checkbox" ></td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td><a href="#" onclick="callDetail()">����</a></td>
	      	</tr>
	      	<tr>
	      		<td><input type="checkbox" ></td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td><a href="#" onclick="callDetail()">����</a></td>
	      	</tr>
      	</table>
      </div>
    </div>
         <div id="operation_button">                
              <input class="b_foot" onclick="doSearch()"  type=button value="��ѯ"/>
              <input class="b_foot" id="doSubmit()"  onclick=""  type=button value="ȷ��"/>
              <input class="b_foot" name="quit"  onclick="window.close()"  type=button value="�˳�"/>
		  	</div>

  <!------------------------> 

<%@ include file="/npage/include/footer.jsp" %>
</form>
</div>
</body>
</html> 	