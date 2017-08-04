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
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String regionCode= (String)session.getAttribute("regCode");
    String workNo = (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
	String groupId = request.getParameter("groupId");
	String retCode = "";
	String retMsg = "";
	String[][] result = new String[][]{};
	String PageSize = request.getParameter("PageSize")==null?"10":request.getParameter("PageSize");
	System.out.println("=========================PageSize================================   "+PageSize);
	int iPageSize = Integer.parseInt(PageSize);
	if(groupId.indexOf(",") == -1){
	   groupId = groupId + ",";
	}
	System.out.println("=========================groupId================================   "+groupId);
	String[] groupIdArr = groupId.split(",");
	for(int y=0;y<groupIdArr.length;y++){
	   System.out.println("---------------------  "+groupIdArr[y]);
	}
	/*=======================��ò�����ˮ*/
	String printAccept="";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
	printAccept = seq;
	/*�������*/
	String [] inParas = new String[7];
	inParas[0] = printAccept;
	inParas[1] = "01";
	inParas[2] = "d317";
	inParas[3] = workNo;
	inParas[4] = password;
	inParas[5] = "";
	inParas[6] = "";
	try{
%>                                                              
   <wtc:service  name="sd317Qry" routerKey="region" routerValue="<%=regionCode%>" 
   	 retcode="retCode1" retmsg="retMsg1" outnum="6">
				<wtc:param value="<%=inParas[0]%>" />
				<wtc:param value="<%=inParas[1]%>" />
				<wtc:param value="<%=inParas[2]%>" />
				<wtc:param value="<%=inParas[3]%>" />
				<wtc:param value="<%=inParas[4]%>" />
				<wtc:param value="<%=inParas[5]%>" />
				<wtc:param value="<%=inParas[6]%>" />
				<wtc:params value="<%=groupIdArr%>" />
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
   	  System.out.println("--------------retCode------------------------   "+retCode + "|" + retMsg);
   	  System.out.println("--------------leng------------------------   "+leng);
   	%>
<script language="javascript">
	$().ready(function(){
		page("1");
		
$("#checkedAll").click(function() { 
	var pageNo = document.getElementById("currentPage").innerText;
if ($(this).attr("checked") == true) { // ȫѡ
  $("#page_"+pageNo+" input[@type=checkbox]").each(function() {
  $(this).attr("checked", true);
  });
}else { // ȡ��ȫѡ
  $("#page_"+pageNo+" input[@type=checkbox]").each(function() {
  $(this).attr("checked", false);
  });
}
});
	});
	function page(pageNo) {
		$("#checkedAll").attr("checked",false);
		if (pageNo == "-1") {
			page(String(parseInt(document.getElementById("currentPage").innerText) - 1));
			return;
		} else if (pageNo == "+1") {
			page(String(parseInt(document.getElementById("currentPage").innerText) + 1));
			return;
		} else if (pageNo == "pageNo") {
			page(document.getElementById("pageNo").value);
			return;
		} else {
			pageNo = parseInt(pageNo);
			if (pageNo > parseInt(document.getElementById("totalPage").innerText) || pageNo < 1) {
				return;
			}
			for (var a = 1; a <= <%=((leng-1)/iPageSize+1)%>; a ++) {
				document.getElementById("page_" + a).style.display = "none";
			}
			document.getElementById("currentPage").innerText = pageNo;
			document.getElementById("page_" + pageNo).style.display = "";
		}
	}
</script>
<html>
<body >
<form name="form2">
  <div id="Main">
   <DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">��������������Ϣ�б�</div>
	</div>
   	<table id="tab" width="100%">
   		<th width="10%">����</th>
   		<th width="15%">����</th>
   		<th width="15%">����</th>
   		<th width="40%">Ӫҵ������</th>
   		<th width="20%">������Ч�ڵ���ʱ��</th>
    </table>
   	<%
   	int u = 1;
   	int pageNo = (leng-1)/iPageSize+1; //ҳ��
   	int y = 1;//div ��id
	if(!retCode.equals("000000"))
	{
	  %>
	   <script language="javascript">
	      rdShowMessageDialog("������Ϣ��<%=retMsg%><br>������룺<%=retCode%>", 0);
      	  window.location = "fd317.jsp";	
	   </script>
	  <%
	}else if(0 == leng){
		%>
			<script language="javascript">
	      rdShowMessageDialog("û�з��������Ĺ���", 0);
      	window.location = "fd317.jsp";	
	   	</script>
		<%
	}
	else
	{  
	   for(int i=0;i<leng;i++){
	      if(y%iPageSize == 1){
	         %>
      	   <div id='page_<%=(y/iPageSize+1)%>' style='display:none'>
      	   	<%
	      }
      	   %>
      	   <table>
      	      <tr>
      	      	       <td width="10%" ><input type="checkbox" value="<%=u++%>" name="selBox" /></td>
      	      	       <td width="15%" ><%=result[i][0]%></td>
      	               <td width="15%" ><%=result[i][1]%></td>
      	               <td width="40%"><%=result[i][2]%></td>
      	               <td width="20%"><%=result[i][3]%></td>
      	               
      	      </tr>
      	   </table>
      	       <%
      	      if (y % iPageSize == 0 || y == leng) {
             %>
					</div>
            <%
				}
      	   
      	   y++;
      	}
	}
	System.out.println("--------------u------------------------   "+u);
	%>

 <div align="center">
	<table align="center">
		<tr>
			<td align="center">
				<input type="checkbox" name="selcheckbox" id="checkedAll" />ȫѡ&nbsp;&nbsp;
				�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=leng%></font>&nbsp;&nbsp;
				��ҳ����<font name="totalPage" id="totalPage"><%=pageNo%></font>&nbsp;&nbsp;
				��ǰҳ��<font name="currentPage" id="currentPage">1</font>&nbsp;&nbsp;
				ÿҳ������<%=PageSize%>
				<a href="javascript:page('1');">[��ҳ]</a>&nbsp;&nbsp;
				<a href="javascript:page('-1');">[��һҳ]</a>&nbsp;&nbsp;
				<a href="javascript:page('+1');">[��һҳ]</a>&nbsp;&nbsp;
				<a href="javascript:page('<%=(leng-1)/iPageSize+1%>');">[βҳ]</a>&nbsp;&nbsp;
				��ת��ָ��ҳ��
				<select name="toPage" id="toPage" style="width:80px" onchange="page(this.value);">
<%
					for (int i = 1; i <= (leng-1)/iPageSize+1; i ++) {
%>
						<option value="<%=i%>">��<%=i%>ҳ</option>
<%
					}
%>
				</select>
			</td>
		</tr>
	</table>
</div>
</div>
</div>
</form>
</body>
</html>
      	
