
<%
	 /*
	 * ����: 12580Ⱥ��
	 * �汾: 1.0.0
	 * ����: 2009/01/12
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%@ include file="../../headTotal.jsp" %>

<%
  
  String opCode = "K505";
  String opName = "Ⱥ��";
  
  int rowCount = 0;
  int pageSize = 15; // Rows each page
  int pageCount = 0; // Number of all pages
  int curPage = 0; // Current page
  String strPage; // Transfered pages
  //chengh
  String flag = request.getParameter("flag");
  
  String loginNo = (String) session.getAttribute("workNo");
  String orgCode = (String) session.getAttribute("orgCode");
  String kf_longin_no = (String) session.getAttribute("kfWorkNo");
  String savelist = request.getParameter("savelist")==null?"":request.getParameter("savelist");
  
  String sqlStr = "select GRP_NAME,ACCEPT_NO,GRP_DESCR,nvl(count(b.LIST_SERIAL_NO),0),SERIAL_NO from DMSGGRP a left join DMSGGRPPHONLIST b ON b.GRP_SERIAL_NO = a.serial_no ";
  String strCountSql = "select to_char(count(*)) count  from DMSGGRP";
  String strAcceptLogSql = " Group by  GRP_NAME,ACCEPT_NO,GRP_DESCR,SERIAL_NO";
  String strAcceptTimeSql = "";
  String strDateSql = "";
  String strOrderSql = " order by SERIAL_NO  ";
  
  String ACCEPT_NO = "";
  String con_id = "";
  String[][] dataRows = new String[][] {};
  String param = "";
  String sqlTemp = "";
  String querySql = "";

  String action = request.getParameter("myaction");
  String pnno = (String)session.getAttribute("capn");//�������
  ACCEPT_NO = request.getParameter("ACCEPT_NO")==null?pnno:request.getParameter("ACCEPT_NO");
  con_id = request.getParameter("con_id");
  
  String sqlFilter = request.getParameter("sqlFilter");
  if (sqlFilter == null || sqlFilter.trim().length() == 0) {
  
  	sqlFilter = " where 1=1 AND GRP_TYPE = '1' and ACCEPT_NO = '" + ACCEPT_NO + "' ";
  	
  }
  
  //if ("doLoad".equals(action)) {

		sqlStr += sqlFilter  +strAcceptLogSql +strOrderSql;
		sqlTemp = strCountSql + sqlFilter;
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
	//}
%>


<html>
	<head>
		<title>Ⱥ��</title>
		 <style>
				#msg{
				width:180px;
				height:120px;
				position:absolute;
				right:0px;
				bottom:0px;
				z-index:2;
				border:1px solid #555;
				background:url(<%= request.getContextPath() %>/nresources/default/images/callimage/msg_bj.gif) repeat-x 0 0;
				font-size:12px;
				}
				#msgTitle{
				height:16px;
				padding:8px 0px 0px 10px;
				border-bottom:2px solid #b3f9ff;
				position:relative;
				}
				#msgContent{
				padding:10px;
				height:1%;
				color:#555;
				}
				#msgImg{
				position:absolute;
				right:5px;
				top:5px;
				z-index:10;
				width:10px;
				height:10px;
				}
    </style>
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
		<script language=javascript>
		smp();
		function smp(){
			
			var falg = "<%=flag %>";
			if(falg=="msgY"){
				parent.similarMSNPop("���ŷ��ͳɹ�");
		  }
		  else if(falg=="msgN"){
		  	parent.similarMSNPop("���ŷ���ʧ��");
		  }
		  else if(falg=="Y"){
		  	parent.similarMSNPop("�����������֤��");
		  }
		  else
		  	return;
	  }
		//�������¼
		function clearValue(){
			var e = document.sitechform.elements;
			for(var i=0;i<e.length;i++){
				if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
				  e[i].value="";
				}else{
			  		e[i].checked=false;
			    }
			}
			parent.similarMSNPop("�ѽ�������գ�"); 
			//rdShowMessageDialog("�ѽ�������գ�",2);   
		}
		//select
		function submitMe(flag){
		   //window.sitechform.myaction.value="doLoad";
		   	if(flag=='0'){
				   var vCon_id=window.top.document.getElementById('contactId').value;
		       window.sitechform.action="k505_query_main.jsp?con_id="+vCon_id;
				}else if(flag=='msgY'){
					 window.sitechform.action="k505_query_main.jsp?flag=msgY";
				}else if(flag=='msgN'){
			     window.sitechform.action="k505_query_main.jsp?flag=msgN";
			  }else if(flag=='1'){
			     window.sitechform.action="k505_query_main.jsp";
			  }
		   window.sitechform.method='post';
		   window.sitechform.submit(); 
		}
		//=========================================================================
		// LOAD PAGES.
		//=========================================================================
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
		   //
		  function setObjID(idvalue)
			{
				var name = document.getElementsByName("obj_id");
				//alert(name.length);
				var n = 0;
				for(var i = 0;i<name.length;i++){
					
					//alert(name[i].value);
					if(name[i].checked){
						
					    document.getElementById("checkid").value = name[i].value;
					    n++;
					}
				}
				if(n==0){
					document.getElementById("checkid").value  = "0";
				}
				//alert(document.getElementById("checkid").value);
			} 
		  function keepValue()
			{
			
			}
			function submitQcContent()
			{
					//var tf32 = document.getElementById("tf32ty").value;//�ж��Ƿ�ͨ�ƶ��������
					//if(tf32 != "availability"){
					//	rdShowMessageDialog("�������û�п�ͨ�ƶ�����������ʧЧ��");
					//	return;
					//}
					window.sitechform.action="k505_query_main.jsp";
			    var ACCEPT_NO = document.getElementById("ACCEPT_NO").value
			    
			    if(""==ACCEPT_NO){
		    	  parent.similarMSNPop("����Ų���Ϊ�գ�");
			    	//rdShowMessageDialog("����Ų���Ϊ�գ�",0)
			    	return;
			    }
			    if(!f_check_mobile(ACCEPT_NO)){
			    	parent.similarMSNPop("����Ÿ�ʽ����ȷ��");
						//rdShowMessageDialog("����Ÿ�ʽ����ȷ��",0);
						return;
					}
			    //if(!f_check_mobile(ACCEPT_NO)){;
						//showTip(document.sitechform.ACCEPT_NO,"����Ÿ�ʽ����ȷ�������ѡ�������");
				    //sitechform.ACCEPT_NO.focus();
						//return;
					//}
				var winParam = 'dialogWidth=800px;dialogHeight=600px';
				window.showModelessDialog("../../../../callbosspage/12580/9KA52/K505/k505_newedit_obj.jsp?ACCEPT_NO="+ACCEPT_NO,window, winParam);
			
			}
			function submitUpContent(){
				
				window.sitechform.action="k505_query_main.jsp";
				var name = document.getElementsByName("obj_id");
				var n="0";
				for(var i =0;i<name.length;i++){
					if(name[i].checked){
						n++;
					}
				}
				
				var obj_id = document.getElementById("checkid").value;
				//alert(obj_id+"-"+n);
				if("0"==obj_id||n>1){
					 parent.similarMSNPop("����ѡ��һ����¼��");
				   //rdShowMessageDialog("����ѡ��һ����¼��",0);
				   return;
				}
				
				var winParam = 'dialogWidth=800px;dialogHeight=600px';
				window.showModelessDialog("../../../../callbosspage/12580/9KA52/K505/k505_edit_obj.jsp?SERIAL_NO="+obj_id,window, winParam);
			 
			}
		  function submitDELContent(){
		  
			window.sitechform.action="k505_query_main.jsp";
			var name = document.getElementsByName("obj_id");
			var obj_id="0";
			for(var i =0;i<name.length;i++){
				
				if(name[i].checked){
					
					var obj_iid = name[i].value;
					obj_id = obj_id + "_"+obj_iid;
				}
			}

			if("0"==obj_id){
				 parent.similarMSNPop("����ѡ��һ����¼��");
			   //rdShowMessageDialog("����ѡ��һ����¼��",0);
			   return;
			}
			if(rdShowConfirmDialog("ȷʵҪɾ����?",2) != 1){
				
			}else{
		    	 var myPacket = new AJAXPacket("k505_deleteGRP_obj.jsp","�����ύ�����Ժ�......");
			     myPacket.data.add("obj_id",obj_id);
			     core.ajax.sendPacket(myPacket,doProcess,true);
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
					parent.similarMSNPop("�ɹ�");
					//rdShowMessageDialog("�ɹ�",2);
					submitMe('1');
				    //window.close();
				}else{
					//alert("����ʧ��!");
					parent.similarMSNPop("ʧ��");
					//rdShowMessageDialog("ʧ��",0);
					return false;
				}
		 }
		 function submitSendContent(){
		 	var obj_id = document.getElementById("checkid").value;
			var ACCEPT_NO = document.getElementById("ACCEPT_NO").value
			var savelist =document.getElementById("savelist").value;
			//var tf32 = document.getElementById("tf32ty").value;//�ж��Ƿ�ͨ�ƶ��������
			//	if(tf32 != "availability"){
			//		rdShowMessageDialog("�������û�п�ͨ�ƶ�����������ʧЧ��");
			//		return;
			//	}
		  if(""==ACCEPT_NO){
		    	  parent.similarMSNPop("����Ų���Ϊ�գ�");
			    	//rdShowMessageDialog("����Ų���Ϊ�գ�",0)
			    	return;
			    }
			    if(!f_check_mobile(ACCEPT_NO)){
			    	parent.similarMSNPop("����Ÿ�ʽ����ȷ��");
						//rdShowMessageDialog("����Ÿ�ʽ����ȷ��",0);
						return;
					}
			var name = document.getElementsByName("obj_id");
			var n=0;
			var serial_no ="";
			for(var i =0;i<name.length;i++){
				if(name[i].checked){
					
					serial_no += name[i].value + ";";
					n++;
				}
			}
			
			if(n==0){
				 parent.similarMSNPop("����ѡ��һ����¼��");
			   //rdShowMessageDialog("����ѡ��һ����¼��",0);
			   return;
			}
			
				
			var winParam = "toolbar=no,menubar=no,width=800px,height=400px";
			window.open("../../../../callbosspage/12580/9KA52/K505/k505_sendmessage_obj.jsp?SERIAL_NO="+serial_no+"&ACCEPT_NO="+ACCEPT_NO+"&savelist="+savelist,"", winParam);
			 
		 }	
		 
		
		 function submitSaveContent(){
		 	window.sitechform.action="k505_query_main.jsp";
		 	var savelist =document.getElementById("savelist").value;
			var obj_id = document.getElementById("checkid").value;
			var name = document.getElementsByName("obj_id");
			//alert(savelist+"-"+"obj_id");
			var n="0";
			for(var i =0;i<name.length;i++){
				if(name[i].checked){
					n++;
				}
			}
			if("0"==obj_id||n>1){
				 parent.similarMSNPop("����ѡ��һ����¼��");
			   //rdShowMessageDialog("����ѡ��һ����¼��",0);
			   return;
			}
		 	if(savelist != ""){
		 		
		 	    var mylist = savelist.split("_");
		 	    for(var i = 0;i<mylist.length;i++){
		 	    	
		 	    	if(mylist[i] ==obj_id ){
		 	    		parent.similarMSNPop("��Ⱥ���ڶ������Ѵ��ڣ�");
		 	    		//rdShowMessageDialog("��Ⱥ���ڶ������Ѵ��ڣ�",0);
		 	    		return;
		 	    	}
		 	    }
		 		
		 		savelist = savelist+"_"+obj_id;
		 	}else{
		 		savelist =obj_id;
		 	}
		 	
		 	document.getElementById("savelist").value = savelist;
		 	parent.similarMSNPop("�ѽ���Ⱥ����ӵ������У�");
		 	//rdShowMessageDialog("�ѽ���Ⱥ����ӵ������У�",2);
		 }
		 function getPhoneNum(){
			//document.getElementById("ACCEPT_NO").value = window.top.cCcommonTool.getCaller();
			document.getElementById("ACCEPT_NO").value = "13709811146";			
			setTimeout("getPhoneNum()", 1000);
		}
		var bool = false;
		function setAllCheck(){
		
			var name = document.getElementsByName("obj_id");
			if(bool){
				bool = false;
				for(var i = 0;i<name.length;i++){
					
					name[i].checked="";
					setObjID();
				}
			}else{
				bool = true;
				for(var i = 0;i<name.length;i++){
					
					name[i].checked="checked";
					setObjID();
				}
			}
		}
		
		</script>
	</head>
	<body>	    
	    <%@ include file="/npage/include/header.jsp"%>
	    <form name="sitechform" id="sitechform">
		    <div id="Operation_Table">
				<!--<div class="title">
					������룺--><input type="hidden" name="ACCEPT_NO" id="ACCEPT_NO" value="<%=(request.getParameter("ACCEPT_NO")!=null)?request.getParameter("ACCEPT_NO"):"" %>" onClick="hiddenTip(this);">
				<!--</div>-->
				
				<div id="">
					<!--<input name="delete_value" class="b_foot" type="button" id="add" value="����" onClick="clearValue();">-->
					<input name="search" class="b_foot" type="button" id="search" value="��ѯ" onClick="submitMe('1');">
					<input name="new" class="b_foot" type="button" id="new" value="�½�/����" onClick="submitQcContent();">
					<input name="update" class="b_foot" type="button" id="update" value="�޸�Ⱥ��" onClick="submitUpContent();">
					<input name="delete" class="b_foot" type="button" id="delete" value="ɾ��Ⱥ��" onClick="submitDELContent();">
					<input name="" class="b_foot" type="button" id="" value="��ӵ����ŷ��Ͷ���" onClick="submitSaveContent();">
					<input name="sendmessage" class="b_foot" type="button" id="sendmessage" value="���Ͷ���" onClick="submitSendContent();">
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
					<input type="hidden" name="savelist" id="savelist" value="<%=savelist %>">
					<tr>
						 <th align="center" class="blue" width="8%">ѡ������<input type="checkbox" id="allcheck" name="allcheck" onclick="setAllCheck();" value="0" > </th> 
						 <th align="center" class="blue" width="15%">���</th> 
						 <th align="center" class="blue" width="15%">Ⱥ������</th> 
					     <th align="center" class="blue" width="15%">�����绰</th> 
					     <th align="center" class="blue" width="15%">��ע</th> 
					     <th align="center" class="blue" width="15%">�����绰����</th> 
					     <th align="center" class="blue" width="15%">Ⱥ�����</th> 
					</tr>
					<div id ="checknull" style="display: none;">
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
						<td align="center" class="<%=tdClass%>" nowrap="nowrap"><input type="checkbox" name="obj_id"  value="<%=dataRows[i][4] %>" onclick="setObjID(this.value);"></td>
						<td align="center" class="<%=tdClass%>" ><%=i+1%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][0].length() != 0) ? dataRows[i][0]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][1].length() != 0) ? dataRows[i][1]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][2].length() != 0) ? dataRows[i][2]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][3].length() != 0) ? dataRows[i][3]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][4].length() != 0) ? dataRows[i][4]: "&nbsp;"%></td>
					</tr>
					<%
					}
					%>
				</table>	
				<table  cellspacing="0">
				    <tr >
				      <td class="blue"  align="right" width="720">
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