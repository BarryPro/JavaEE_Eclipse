<%
/********************
 * version v2.0
 * ������: si-tech
 * update by wanglm @ 20110225
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
    String regionCode= (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String workNo = request.getParameter("workNo");
	String byWorkNo = request.getParameter("byWorkNo");
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String fileNo = request.getParameter("fileNo");
	System.out.println("--------------workNo------------------------   "+workNo);
	System.out.println("--------------byWorkNo------------------------   "+byWorkNo);
	System.out.println("--------------startTime------------------------   "+startTime);
	System.out.println("--------------endTime------------------------   "+endTime);
	System.out.println("--------------fileNo------------------------   "+fileNo);
	/*=======================��ò�����ˮ*/
	String printAccept="";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
	printAccept = seq;
	String retCode = "";
	String retMsg = "";
	String[][] result = new String[][]{};
	/*�������*/
	String [] inParas = new String[13];
	inParas[0] = printAccept;
	inParas[1] = "01";
	inParas[2] = "d347";
	inParas[3] = loginNo;
	inParas[4] = password;
	inParas[5] = "";
	inParas[6] = "";
	inParas[7] = groupId;
	inParas[8] = workNo;
	inParas[9] = byWorkNo;
	inParas[10] = startTime;
	inParas[11] = endTime;
	inParas[12] = fileNo;
	try{
%>                                                              
   <wtc:service  name="sd347Qry" routerKey="region" routerValue="<%=regionCode%>" 
   	 retcode="retCode1" retmsg="retMsg1" outnum="10">
   	 <wtc:param value="<%=inParas[0]%>" />
   	 <wtc:param value="<%=inParas[1]%>" />
   	 <wtc:param value="<%=inParas[2]%>" />
     <wtc:param value="<%=inParas[3]%>" />
     <wtc:param value="<%=inParas[4]%>" />
     <wtc:param value="<%=inParas[5]%>" />
     <wtc:param value="<%=inParas[6]%>" />
     <wtc:param value="<%=inParas[7]%>" />
     <wtc:param value="<%=inParas[8]%>" />
     <wtc:param value="<%=inParas[9]%>" />
     <wtc:param value="<%=inParas[10]%>" />
     <wtc:param value="<%=inParas[11]%>" />
     <wtc:param value="<%=inParas[12]%>" />
   </wtc:service>
   <wtc:array id="result1" scope="end" />
   	<%
   	result = result1;
   	retCode = retCode1;
   	retMsg = retMsg1;
   	}catch(Exception e){
   	   System.out.println("--------------error------------------------   ");
   	}
   	  int leng =  result.length ;
   	  System.out.println("--------------retCode------------------------   "+retCode);
   	  System.out.println("--------------leng------------------------   "+leng);
   	%>
<script language="javascript">
	function doCfm(){
	  var val = "";
	  var auditPassArr = "";
	  var auditCauseArr = "";
    var selBoxArr = $('input[name="selBox"]:checked');
    var auditPassSelectArr = $('input[name="auditPass"]');
    var auditCauseTextArr = $('input[name="auditCause"]');
    if(selBoxArr.length == 0){
   		rdShowMessageDialog("�ޱ�ѡ����Ϣ��");
  	  return;
   	}else{
   	    for(var j=0;j<selBoxArr.length;j++){
   	    	var selBoxValue = parseInt(selBoxArr[j].value)+1;
   	    	val = val + $("#tab tr:eq("+selBoxValue+") td:eq(8)").html() + ",";	
   	    	var checkBoxVal = $("#tab tr:eq("+selBoxValue+") td:eq(9) > select").val();
   	    	auditPassArr = auditPassArr + checkBoxVal + ",";
   	    	var auditCauseTemp = $("#tab tr:eq("+selBoxValue+") td:eq(10) > input").val().trim();
   	    	if(getByteLen(auditCauseTemp) > 30){
   	    		rdShowMessageDialog("���˽�����ó���15���ּ�30�ֽ�");
  	  			return;
   	    	}
   	    	/* �������δͨ����Ҫ������ڻ��˽����������˲�ͨ����ԭ�� */
   	    	if("0" == checkBoxVal && getByteLen(auditCauseTemp) == 0){
   	    		rdShowMessageDialog("����д���˲�ͨ����ԭ��");
   	    		return false;
   	    	}
   	    	auditCauseArr = auditCauseArr + auditCauseTemp + ",";
   	    }
   	 }
   	 getAfterPrompt();
   	window.location = "fd347_sub.jsp?val="+val + "&auditPass=" + auditPassArr 
   				+ "&auditCause=" + auditCauseArr;
   	//document.frm1.action = "fd347_sub.jsp?val="+val;
   	//document.frm1.submit();	
	}
		function getByteLen(str){ 
			//��ȡ�ֽ�
			var byteLen=0,len=str.length; 
			if(str){ 
				for(var i=0; i<len; i++){ 
					if(str.charCodeAt(i)>255){ 
						byteLen += 2; 
					} 
					else{ 
						byteLen++; 
					} 
				} 
				return byteLen; 
			} 
			else{ 
				return 0; 
			} 
		}
	function changeAuditPass(auditObj,rowNum){
		/* ��������ĺ���������Ƿ�������˽�� */
		var auditVal = auditObj.value;
		var auditCauseTextArr = $('input[name="auditCause"]');
		if("0" == auditVal){
			//$(auditCauseTextArr[rowNum]).removeAttr("readOnly");
		}else{
			$(auditCauseTextArr[rowNum]).val("");
			//$(auditCauseTextArr[rowNum]).attr("readOnly","readOnly");
		}
	}
	
</script>
<html>
<body >
<form name="frm1">
  <div id="Main">
   <DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">��������������Ϣ�б�</div>
	</div>
   	<table id="tab" width="100%">
   		<th>����</th>
   		<th>��Ȩ����</th>
   		<th>��Ȩ���ܴ���</th>
   		<th>����Ȩ����</th>
   		<th>ʱ��</th>
   		<th>�ļ����</th>
   		<th>��Ȩԭ��</th>
   		<th>�Ƿ����</th>
   		<th>�����Ƿ�ͨ��</th>
   		<th>���˽��</th>
   	<%
   	int u = 0;
   	int nowPage = 1;
		int allPage = 0;
	if(!retCode.equals("000000"))
	{
	  %>
	   <script language="javascript">
	      rdShowMessageDialog("������Ϣ��<%=retMsg%><br>������룺<%=retCode%>", 0);
	   </script>
	  <%
	}
	else
	{  	
	   	for(int i=0;i<leng;i++){
	   		String disabledCtrl = "";
	   		if("1".equals(result[i][8])){
	   			/* ��������� */
	   			disabledCtrl = "disabled";
	   		}
	   		System.out.println("$$$$$$$$$$$4 " + disabledCtrl);
	   %>
      	      <tr id="row_<%=i%>">
      	      	       <td >
      	      	       	<input type="checkbox" value="<%=u++%>" name="selBox" <%=disabledCtrl%> />
      	      	       </td>
      	      	       <td ><%=result[i][0]%></td>
      	               <td ><%=result[i][1]%></td>
      	               <td ><%=result[i][2]%></td>
      	               <td ><%=result[i][3]%></td>
      	               <td ><%=result[i][4]%></td>
      	               <td ><%=result[i][5]%></td>
      	               <td >
      	               	<%
      	               	  if("0".equals(result[i][7])){
      	               	    %>
      	               	      δ����
      	               	    <%
      	               	  }else if("1".equals(result[i][7])){
      	               	  	%>
      	               	      ����
      	               	    <%
      	               	  }
      	               	%>
      	               	</td>
      	               <td style="display:none"><%=result[i][6]%></td>
      	               <td>
      	               	<select name="auditPass" style="width:70px;" 
      	               		 onchange="changeAuditPass(this,<%=i%>)" <%=disabledCtrl%>>
      	               		<option value="1" 
      	               			<%if("1".equals(result[i][8])){%>selected<%}%> 
      	               			>--��--</option>
      	               		<option value="0" 
      	               			<%if("0".equals(result[i][8])){%>selected<%}%> 
      	               			>--��--</option>
      	               	</select>
      	               </td>
      	               <td>
      	               	<input type="text" name="auditCause" value="<%=result[i][9]%>"
      	               	 maxlength="30" v_type="string" 
      	               	 <%if("1".equals(result[i][8])){%>readOnly<%}%>  />
      	               </td>
      	      </tr>
		       <%
      	}
      	allPage = (leng - 1) / 10 + 1 ;
      	%>
      	<tr>
            <td colspan="10" align="center">
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
           </td>
        </tr>
        <%
	}
	System.out.println("--------------u------------------------   "+u);
	%>
</table>
	<div align="center">
			<table align="center">
			<tr>
				<td align="center">
					�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=leng%></font>&nbsp;&nbsp;
					��ҳ����<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
					��ǰҳ��<font name="currentPage" id="currentPage">1</font>&nbsp;&nbsp;
					ÿҳ������10
					<a href="javascript:setPage('1');">[��һҳ]</a>&nbsp;&nbsp;
					<a href="javascript:setPage('-1');">[��һҳ]</a>&nbsp;&nbsp;
					<a href="javascript:setPage('+1');">[��һҳ]</a>&nbsp;&nbsp;
					<a href="javascript:setPage('<%=allPage%>');">[���һҳ]</a>&nbsp;&nbsp;
					��ת��
					<select name="toPage" id="toPage" style="width:80px" onchange="setPage(this.value);">
						<%
						for (int i = 1; i <= allPage; i ++) {
						%>
							<option value="<%=i%>">��<%=i%>ҳ</option>
						<%
						}
						%>
					</select>
					ҳ
				</td>
			</tr>
			</table>
		</div>
		<input type="hidden" id="nowPage" />
		<input type="hidden" id="allPage" value="<%= allPage %>" />
</div>
</div>
</form>
</body>
<script language="javascript">
	$(document).ready(function(){
		var nowp = "<%= nowPage %>";
		$("#nowPage").val(nowp);
		setPage(nowp);
	});
	function setPage(goPage){
		if (goPage == "-1") {
			setPage(parseInt($("#nowPage").val()) - 1);
			return;
		} else if (goPage.length == 2 && "+1" == goPage) {
			setPage(parseInt($("#nowPage").val()) + 1);
			return;
		}else{ 
			goPage = parseInt(goPage);
			if(goPage < 1){
				return false;
			}else if(goPage > $("#allPage").val()){
				return false;
			}else{
				pageNo = parseInt(goPage);
				//����������
				$("[id^='row_']").hide();
				//��ʾ��
				var startRow = (pageNo - 1) * 10;
				var endRow = pageNo * 10 - 1;
				for(var i = startRow; i <= endRow; i++ ){
					var pageStr = "#row_" + i;
					$(pageStr).show();
				}
				$("#nowPage").val(pageNo);
				$("#currentPage").text(pageNo);
			}
		}
	}
</script>
</html>
      	
