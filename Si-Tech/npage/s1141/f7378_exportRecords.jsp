<%
  /*
   * ���ڶ�BOSSϵͳ���Ӷ��Ű������û�����Ȩ�޵�����
   * ����: 2014-02-19
   * ����: zhouby
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<meta http-equiv="Expires" content="0">
  <meta http-equiv="Cache-Control" content="no-store"/>
  <meta http-equiv="Pragma" content="no-cache"/>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  String currentMonth = new java.text.SimpleDateFormat("MM", Locale.getDefault())
  												.format(new java.util.Date());
	String currentYear = new java.text.SimpleDateFormat("yyyy", Locale.getDefault())
  												.format(new java.util.Date());
  
  String opCode = "7378";
  String opName = "����ҵ��������������";
  
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  
  String currentPage = WtcUtil.repNull(request.getParameter("currentPage"));
  currentPage = currentPage.equals("") ? "1": currentPage;
  String listtype   = WtcUtil.repNull(request.getParameter("listtype"));
  String switchFlag = WtcUtil.repNull(request.getParameter("switchFlag"));
  String op_type    = WtcUtil.repNull(request.getParameter("op_type"));
  String category   = WtcUtil.repNull(request.getParameter("category"));
  String beginTime  = WtcUtil.repNull(request.getParameter("beginTime"));
  String endTime    = WtcUtil.repNull(request.getParameter("endTime"));

%>            

  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
	
<%
  String []inParas = new String[23];
  inParas[0] = accept;
  inParas[1] = "01";
  inParas[2] = opCode;
  inParas[3] = workNo;
  inParas[4] = password;
  inParas[5] = "";
  inParas[6] = "";
  inParas[7]  = listtype;
  inParas[8]  = switchFlag;
  inParas[9]  = op_type;
  inParas[10] = category;
  inParas[11] = beginTime;
  inParas[12] = endTime;
  inParas[13] = currentPage;
%>
	
  <wtc:service name="s7378QryBat" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
		<wtc:param value="<%=inParas[7]%>"/>
		<wtc:param value="<%=inParas[8]%>"/>
		<wtc:param value="<%=inParas[9]%>"/>
		<wtc:param value="<%=inParas[10]%>"/>
		<wtc:param value="<%=inParas[11]%>"/>
		<wtc:param value="<%=inParas[12]%>"/>
		<wtc:param value="<%=inParas[13]%>"/>
	</wtc:service>
	<wtc:array id="totalResultNumber" start="0" length="1" scope="end"/>
	<wtc:array id="result" start="1" length="3" scope="end"/>
	
<title><%=opName%></title>
<script language="javascript" type="text/javascript" 
  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language="javascript">
  var oXL = null;
  //����AX����excel
  var oWB = null;
  //��ȡworkbook����
  var oSheet = null;
  var rowIndex = 0;
  
  /** zhouby jquery for export
  */
  function ExportToExcel(targetTable, flag) { 
      //ȡ�ñ������
      $('#'+targetTable+' tr').each(function(i, e){
          var cols = $('td, th', this);
          cols.each(function(j, e){
              var value = $.trim($(this).text().replace(/\n/g, ''));
              if (value == ""){
                  value = $(this).find('input').val();
              }
              
              if (flag && (j + 1) == cols.length){
                  return true;
              }
              oSheet.Cells(rowIndex + 1, j + 1).value = value;
          });
          
          rowIndex++;
      });
  }
  
  function exportTables(tableIds, flag){
    try{   
        rowIndex = 0;
        oXL = new ActiveXObject("Excel.Application");
        oWB = oXL.Workbooks.Add();
        oSheet = oWB.ActiveSheet;
        
        if (tableIds.length <= 0){
            return;
        }
        
        for (var i = 0; i < tableIds.length; i++){
            ExportToExcel(tableIds[i], flag);
        }
        //����excel�ɼ�����
        oXL.Visible = true;
    }catch(e){
          if((!+'\v1')){ //ie�����  
             alert("�޷�����Excel����ȷ���������Ѿ���װ��Excel!\n\n����Ѿ���װ��Excel��" + 
                 "�����IE�İ�ȫ����\n\n���������\n\n"+"���� �� Internetѡ�� �� ��ȫ �� �Զ��弶�� �� ActiveX �ؼ��Ͳ�� �� ��δ���Ϊ�ɰ�ȫִ�нű���ActiveX �ؼ���ʼ����ִ�нű� �� ���� �� ȷ��"); 
          }else{ 
              alert("��ʹ��IE��������С����뵽EXCEL��������");  //�������ð�ȫ�ȼ�������Ϊie�����  
          } 
      }
  }
  
<%
  if ("000000".equals(retCode)){
%>
      var totalResultNumber = "<%=totalResultNumber[0][0]%>";
<%
  }
%>
  
  var currentPageNumber = "<%=currentPage%>", pageSize = 1000;
  
  function hasNextPage(){
      return (totalResultNumber - currentPageNumber * pageSize) > 0;
  }
  
  function hasPreviousPage(){
      return currentPageNumber > 1;
  }

  function getPagingToolBar(){
      var data = {listtype : "<%=listtype%>",
                  switchFlag : "<%=switchFlag%>",
                  op_type : "<%=op_type%>",
                  category : "<%=category%>",
                  beginTime : "<%=beginTime%>",
                  endTime : "<%=endTime%>"};
    
      var actionName = 'f7378_exportRecords.jsp?' + $.param(data);
    
      var totalPages = Math.ceil(totalResultNumber / pageSize);
      var temp="";
      if(actionName.indexOf("?")==-1){
          temp="?";
      }
      else {
          temp="&";
      }
      var str = "<tr><td colspan='3'>";
      str += "<p align='center'>";
      if(!hasPreviousPage())
          str+="<span id='firstPage'>��ҳ</span> <span id='prevPage'>��һҳ</span>&nbsp;";
      else
      {
          str+="<a id='first' href='"+actionName+temp+"currentPage=1'>��ҳ</a>&nbsp;";
          str+="<a id='prev' href='"+actionName+temp+"currentPage="+(currentPageNumber-1)+"'>��һҳ</a>&nbsp;";
      }
      if(!hasNextPage())
          str+="��һҳ βҳ&nbsp;";
      else
      {
          str+="<a id='next' href='"+actionName+temp+"currentPage="+(currentPageNumber+1)+"'>��һҳ</a>&nbsp;";
          str+="<a id='last' href='"+actionName+temp+"currentPage="+totalPages+"'>βҳ</a>&nbsp;";
      }
      str+="&nbsp;��<b>"+totalResultNumber+"</b>����¼&nbsp;";
      str+="</p>";
      str+="</td></tr>";
      
      $('#target').append(str);
  }
  
  $(function(){
      getPagingToolBar();
      
      $('#submitBtn').click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
          exportTables(['targetTable']);
      });
  });
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">		
<div id="Main">
 <DIV id="Operation_Table"> 
  
  <div class="title">
		<div id="title_zi">��ѯ���</div>
	</div>
  
  <table id="targetTable" cellspacing="0" >          
 		<tr> 
      <th>���</th>
      <th>�ֻ�����</th>
      <th>������������</th>
    </tr>
    
    <tbody id="target">
<%
    if ("000000".equals(retCode)){
      int length = result.length;
      if (length > 0){
          for (int i = 0; i < length; i++){
          
%>
              <tr>
                <td><%=result[i][0]%></td>  
                <td><%=result[i][1]%></td>  
                <td><%=result[i][2]%></td>  
              </tr>
<%
          }
      }
    }else {
%>
      <script language="javascript">
        rdShowMessageDialog("���÷���ʧ�ܣ�" + retCode + retMsg");
      </script>
<%
    }
%>
    </tbody>
	</table>
	
  <table cellspacing="0" >
   	<tr>
      <td id="footer">              
    	  <input type=button name="submitBtn" id="submitBtn" class="b_foot" value="����">
      </td>
  	</tr>
  </table>
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>