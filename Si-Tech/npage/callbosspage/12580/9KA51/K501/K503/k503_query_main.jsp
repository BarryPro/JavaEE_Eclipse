
<%
	 /*
	 * ����: 12580ԤԼ����
	 * �汾: 1.0.0
	 * ����: 2009/01/12
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>

<%
  
  String opCode = "K503";
  String opName = "ԤԼ����";
 
  String ACCEPT_NO = "";
  
  int rowCount = 0;
  int pageSize = 15; // Rows each page
  int pageCount = 0; // Number of all pages
  int curPage = 0; // Current page
  String strPage; // Transfered pages
  
  String loginNo = (String) session.getAttribute("workNo");
  String orgCode = (String) session.getAttribute("orgCode");
  String kf_longin_no = (String) session.getAttribute("kfWorkNo");
  
  String sqlStr = "select SERIAL_NO,ACCEPT_NO,CREATE_TIME,TARGET_PHONE_NO,PRE_TIME,TIMES,INTERV_TIME,MSG_CONTENT,TIMES_FLAG,MSG_DESCR from DPRESERVICE ";
  String strCountSql = "select to_char(count(*)) count from DPRESERVICE ";
  String strOrderSql = " order by SERIAL_NO  ";
  
  String con_id = "";
  String[][] dataRows = new String[][] {};
  String param = "";
  String sqlTemp = "";
  String querySql = "";
  
  String action = request.getParameter("myaction");
  ACCEPT_NO = request.getParameter("ACCEPT_NO");
  con_id = request.getParameter("con_id");
  System.out.println("_________________________________" + con_id);
  
  ///////��ѯ��������
  String sqlFilter = request.getParameter("sqlFilter");
  if (sqlFilter == null || sqlFilter.trim().length() == 0) {
  
  	sqlFilter = " where 1=1 and PRE_TYPE ='1' ";
  	if (ACCEPT_NO != null && !ACCEPT_NO.trim().equals("")) {

		sqlFilter += " and ACCEPT_NO = '" + ACCEPT_NO + "'";
	}
  }
  
  if ("doLoad".equals(action)) {

		sqlStr += sqlFilter +strOrderSql;
		sqlTemp = strCountSql + sqlFilter;
		System.out.println("=========sqlStr========" + sqlStr);
		System.out.println("=========sqlTemp========" + sqlTemp);
%>

<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlTemp%>" />
</wtc:service>
<wtc:array id="rowsC4" scope="end" />
<% 
if (rowsC4.length != 0) {

		rowCount = Integer.parseInt(rowsC4[0][0]);
    }
    strPage = request.getParameter("page");
		if (strPage == null || strPage.equals("")
		|| strPage.trim().length() == 0) {
			curPage = 1;
		} else {
			curPage = Integer.parseInt(strPage);
			if (curPage < 1)
		curPage = 1;
		}
		pageCount = (rowCount + pageSize - 1) / pageSize;
		if (curPage > pageCount)
			curPage = pageCount;
		querySql = PageFilterSQL.getOraQuerySQL(sqlStr, String
		.valueOf(curPage), String.valueOf(pageSize), String
		.valueOf(rowCount));
%>
<wtc:service name="s151Select" outnum="24">
	<wtc:param value="<%=querySql%>" />
</wtc:service>
<wtc:array id="queryList" start="1" length="23" scope="end" />
<%
	dataRows = queryList;
	}
%>
<html>
	<head>
		<title>ԤԼ����</title>
		<script language=javascript>
		//�������¼
		function clearValue(){
			var e = document.forms[0].elements;
			for(var i=0;i<e.length;i++){
				if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
				  e[i].value="";
				}else{
			  		e[i].checked=false;
			    }
			} 
		}
		
		function submitMe(flag){
		   window.sitechform.myaction.value="doLoad";
		   	if(flag=='0'){
				   var vCon_id=window.top.document.getElementById('contactId').value;
		       window.sitechform.action="k503_query_main.jsp?con_id="+vCon_id;
				}else{
					 window.sitechform.action="k503_query_main.jsp";
				}
		   window.sitechform.method='post';
		   window.sitechform.submit(); 
		}
		function setObjID(idvalue)
	    {
		   document.getElementById("checkid").value = idvalue;
	    } 
		function keepValue()
    	{
			
		}
		function doLoad(operateCode){
		   var str='1';
		   if(operateCode=="load")
		   {
		   	window.sitechform.page.value="";
		   	str='0';
		   }
		   else if(operateCode=="first")
		   {
		   	window.sitechform.page.value=1;
		   }
		   else if(operateCode=="pre")
		   {
		   	window.sitechform.page.value=<%=(curPage-1)%>;
		   }
		   else if(operateCode=="next")
		   {
		   	window.sitechform.page.value=<%=(curPage+1)%>;
		   }
		   else if(operateCode=="last")
		   {
		   	window.sitechform.page.value=<%=pageCount%>;
		   }
		    keepValue();
		    submitMe(str); 
	    }
	    function submitQcContent()
		{
		    var ACCEPT_NO = document.getElementById("ACCEPT_NO").value
		    if(""==ACCEPT_NO){
		    	
		    	rdShowMessageDialog("����Ų���Ϊ�գ�",0)
		    	return;
		    }
			var winParam = 'dialogWidth=800px;dialogHeight=500px';
			window.showModalDialog("../../../../callbosspage/12580/9KA51/K503/k503_newedit_obj.jsp?ACCEPT_NO="+ACCEPT_NO,window, winParam);
		
		}
		function submitUpContent(){
			
			var obj_id = document.getElementById("checkid").value;

			if("0"==obj_id){
			   rdShowMessageDialog("����ѡ��һ����¼��",0);
			   return;
			}
			
			var winParam = 'dialogWidth=800px;dialogHeight=500px';
			window.showModalDialog("../../../../callbosspage/12580/9KA51/K503/k503_newedit_obj.jsp?SERIAL_NO="+obj_id,window, winParam);
		 
		}
		function submitDELContent(){
			
			var obj_id = document.getElementById("checkid").value;
		
			if("0"==obj_id){
			   rdShowMessageDialog("����ѡ��һ����¼��",0);
			   return;
			}
			
			if(rdShowConfirmDialog("ȷʵҪɾ����?",2) != 1){
				
			}else{
			
		    	 var myPacket = new AJAXPacket("k503_delete_obj.jsp","�����ύ�����Ժ�......");
			     myPacket.data.add("SERIAL_NO",obj_id);
			     core.ajax.sendPacket(myPacket,doProcess);
			     myPacket=null;   
			}     
		}
		function doProcess(myPacket)
		{
		
		    var retType = myPacket.data.findValueByName("retType");
			var retCode = myPacket.data.findValueByName("retCode");
			var retMsg = myPacket.data.findValueByName("retMsg");
				if(retCode=="000000"){
					//alert("����ɹ�");
					rdShowMessageDialog("�Ѿ�ɾ��!",2);
					submitMe('1');
				    //window.close();
				}else{
					//alert("����ʧ��!");
					rdShowMessageDialog("ʧ��",0);
					return false;
				}
		 } 
		 function getPhoneNum(){
			//document.getElementById("ACCEPT_NO").value = window.top.cCcommonTool.getCaller();
			document.getElementById("ACCEPT_NO").value = "13709811146";
			setTimeout("getPhoneNum()", 1000);
		}
		</script>
	</head>
	<body >
		<%@ include file="/npage/include/header.jsp"%>
	    <form name="sitechform" id="sitechform">
		    <div id="Operation_Table">
				<div class="title">
					������Ϣ<input type="hidden" name="ACCEPT_NO" id="ACCEPT_NO" value="<%=(ACCEPT_NO!=null)?ACCEPT_NO:"" %>" >
				</div>
				<div>
					<input name="delete_value" class="b_foot" type="button" id="add" value="����" onClick="clearValue();">
					<input name="search" class="b_foot" type="button" id="search" value="��ѯ" onClick="submitMe('1');">
					<input name="new" class="b_foot" type="button" id="new" value="�½�" onClick="submitQcContent();">
					<input name="update" class="b_foot" type="button" id="update" value="�޸�" onClick="submitUpContent();">
					<input name="delete" class="b_foot" type="button" id="delete" value="ɾ��" onClick="submitDELContent();">
					
				</div>
				<table  cellspacing="0">
				    <tr >
				      <td class="blue"  align="left" width="720">
				        <%if(pageCount!=0){%>
				        ��<%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
				        <%} else{%>
				        <font color="orange">��ǰ��¼Ϊ�գ�</font>
				        <%}%>
				        <%if(pageCount!=1 && pageCount!=0){%>
				        <a href="#"   onClick="doLoad('first');return false;">��ҳ</a>
				        <%}%>
				        <%if(curPage>1){%>
				        <a href="#"  onClick="doLoad('pre');return false;">��һҳ</a>
				        <%}%>
				        <%if(curPage<pageCount){%>
				        <a href="#" onClick="doLoad('next');return false;">��һҳ</a>
				        <%}%>
				        <%if(pageCount>1){%>
				        <a href="#" onClick="doLoad('last');return false;">βҳ</a>
				        <%}%>
				      </td>
				    </tr>
				</table> 
				<table cellSpacing="0">
					<input type="hidden" name="page" value="">
					<input type="hidden" name="myaction" value="">
					<input type="hidden" name="sqlFilter" value="">
					<input type="hidden" name="sqlWhere" value="">
				
					<tr>
						 <th align="center" class="blue" width="4%">&nbsp;</th> 
						 <th align="center" class="blue" width="10%">��ˮ��</th> 
						 <th align="center" class="blue" width="10%">�������</th> 
					     <th align="center" class="blue" width="10%">����ʱ��</th> 
					     <th align="center" class="blue" width="10%">Ŀ�����</th>
					     <th align="center" class="blue" width="10%">Լ��ʱ��</th> 
					     <th align="center" class="blue" width="10%">ִ�д���</th> 
					     <th align="center" class="blue" width="10%">���ʱ��</th> 
					     <th align="center" class="blue" width="10%">ԤԼ����</th>
					      <th align="center" class="blue" width="10%">�Ƿ�ִ��ִ�д���</th> 
					     <th align="center" class="blue" width="10%">��ע</th> 
					</tr>
					<div id ="checknull" style="display: none;">
						<input type="radio" name="SERIAL_NO" id="SERIAL_NO"  value="0" checked="checked"/>
						<input type="hidden" name="checkid" id ="checkid" value="0">
					</div>
					
					<%
							for (int i = 0; i < dataRows.length; i++) {
							String tdClass = "";
					%>

					<%
								if ((i + 1) % 2 == 1) {
								tdClass = "grey";
							}
					%>
					<tr>
						<td align="center" class="<%=tdClass%>" nowrap="nowrap"><input type="radio" name="SERIAL_NO" id="SERIAL_NO" value="<%= dataRows[i][0]%>" onclick="setObjID(this.value);"></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][0].length() != 0) ? dataRows[i][0]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][1].length() != 0) ? dataRows[i][1]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][2].length() != 0) ? dataRows[i][2]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][3].length() != 0) ? dataRows[i][3]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][4].length() != 0) ? dataRows[i][4]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][5].length() != 0) ? dataRows[i][5]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][6].length() != 0) ? dataRows[i][6]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][7].length() != 0) ? dataRows[i][7]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][8].length() != 0) ? dataRows[i][8]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][9].length() != 0) ? dataRows[i][9]: "&nbsp;"%></td>
					</tr>
					<%
					}
					
					%>
				</table>
				<table  cellspacing="0">
				    <tr >
				      <td class="blue"  align="left" width="720">
				        <%if(pageCount!=0){%>
				        ��<%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
				        <%} else{%>
				        <font color="orange">��ǰ��¼Ϊ�գ�</font>
				        <%}%>
				        <%if(pageCount!=1 && pageCount!=0){%>
				        <a href="#"   onClick="doLoad('first');return false;">��ҳ</a>
				        <%}%>
				        <%if(curPage>1){%>
				        <a href="#"  onClick="doLoad('pre');return false;">��һҳ</a>
				        <%}%>
				        <%if(curPage<pageCount){%>
				        <a href="#" onClick="doLoad('next');return false;">��һҳ</a>
				        <%}%>
				        <%if(pageCount>1){%>
				        <a href="#" onClick="doLoad('last');return false;">βҳ</a>
				        <%}%>
				      </td>
				    </tr>
				</table>
			</div>
		</form>
	    <%@ include file="/npage/include/footer.jsp"%>	
	</body>	  
</html>