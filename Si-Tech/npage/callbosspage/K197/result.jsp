<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>



<%
	String opCode="K197";
	/*midify by yinzx 20091113 ������ѯ�����滻*/
 		String myParams="";     
	String nowtoday = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String loginNo = (String) session.getAttribute("workNo");
	String orgCode = (String) session.getAttribute("orgCode");
	String regionCode = "";
	  if(orgCode!=null){
	  regionCode = orgCode.substring(0,2);
	  }
	String kf_longin_no = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));
	
	String sqlStr = "select  ACCEPT_PHONE,CUST_NAME,funcname specialtype_name,GRADE_CODE,to_char(end_date,'yyyymmdd hh24:mi:ss'),nvl(SQ_LOGIN_NO,' '),nvl(op_login_no,' '),nvl(reason,' '),specialid from dcallspeciallist a ,scallspeciallist b where a.SPECIALTYPE_ID=b.funcid ";
 
	
	String strCountSql = "select to_char(count(*)) count    from dcallspeciallist a ,scallspeciallist b where a.SPECIALTYPE_ID=b.funcid";
	 
	String strOrderSql = " order by end_date desc ";

	String SPECIALTYPE_ID = "";
	String SQ_LOGIN_NO = "";
	String OP_LOGIN_NO = "";
	String ACCEPT_PHONE = "";
	String CUST_NAME = "";
	String CITY_CODE = "";
	String GRADE_CODE = "";
	String start_date = "";
  String end_date = "";
	 
	
	String SQLSPECIALTYPE_ID = "";
	String SQLSQ_LOGIN_NO = "";
	String SQLOP_LOGIN_NO = "";
	String SQLACCEPT_PHONE = "";
	String SQLCUST_NAME = "";
	String SQLCITY_CODE = "";
	String SQLGRADE_CODE = "";
	String SQLstart_date = "";
  String SQLend_date = "";
 
  
	 
	String[][] dataRows = new String[][] {};
  String[] strbind= {"",""};
	int rowCount = 0;
	int pageSize = 15; // Rows each page
	int pageCount = 0; // Number of all pages
	int curPage = 0; // Current page
	String strPage; // Transfered pages
	String param = "";
	String sqlTemp = "";
	String querySql = "";
 
 
	 
	String expFlag =request.getParameter("exp")==null?"":request.getParameter("exp");
	
	start_date = request.getParameter("start_date")==null?"":request.getParameter("start_date");
	
	end_date = request.getParameter("end_date")==null?"":request.getParameter("end_date");
	SPECIALTYPE_ID = request.getParameter("SPECIALTYPE_ID")==null?"":request.getParameter("SPECIALTYPE_ID");              
	SQ_LOGIN_NO = request.getParameter("SQ_LOGIN_NO")==null?"":request.getParameter("SQ_LOGIN_NO");  
	OP_LOGIN_NO = request.getParameter("OP_LOGIN_NO")==null?"":request.getParameter("OP_LOGIN_NO");              
  ACCEPT_PHONE = request.getParameter("ACCEPT_PHONE")==null?"":request.getParameter("ACCEPT_PHONE");              
  CUST_NAME = request.getParameter("CUST_NAME")==null?"":request.getParameter("CUST_NAME");    
  CITY_CODE = request.getParameter("CITY_CODE")==null?"":request.getParameter("CITY_CODE");     
  GRADE_CODE = request.getParameter("GRADE_CODE")==null?"":request.getParameter("GRADE_CODE");               
            
	 

 
	String sqlFilter = request.getParameter("sqlFilter");
	if (sqlFilter == null || sqlFilter.trim().length() == 0) {
		/*if (start_date != null && !start_date.trim().equals("")
		&& end_date != null && !end_date.trim().equals("")) {

			strDateSql = " where begin_date >=to_date('"
			+ start_date.trim()
			+ "','yyyyMMdd hh24:mi:ss') and begin_date <=to_date('"
			+ end_date.trim() + "','yyyyMMdd hh24:mi:ss') ";
			  */ 
 
			strbind=returnSql(request);
			sqlFilter =   strbind[0] + strOrderSql;
      myParams+=strbind[1];   
			}
		else {
			strbind=returnSql(request);
			sqlFilter =   strbind[0] + strOrderSql;
      myParams+=strbind[1];    
			} 
 
			
	 
 

%>
 

<%
		
		sqlStr += sqlFilter;
                sqlTemp = strCountSql + sqlFilter;
	  
%>
 
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
	<wtc:param value="<%=sqlTemp%>" />
	<wtc:param value="<%=myParams%>" />
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
	 System.out.println("sqlStrsqlStrsqlStr=--->  "+sqlStr); 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="10">
	<wtc:param value="<%=querySql%>" />
	<wtc:param value="<%=myParams%>" />
</wtc:service>
<wtc:array id="queryList" start="0" length="9" scope="end" />
<%
		
		dataRows = queryList;
 
		 
%>

<%
    if(expFlag.equals("all"))
    {
       	
       	String expquerySql ="select  ACCEPT_PHONE,CUST_NAME,funcname,GRADE_CODE,to_char(end_date,'yyyy-mm-dd hh24:mi:ss'),nvl(SQ_LOGIN_NO,' '),nvl(op_login_no,' '),nvl(reason,' '),specialid from dcallspeciallist a ,scallspeciallist b   where a.SPECIALTYPE_ID=b.funcid";
       	String[] strHead = { "�������", "�ͻ�����", "������������", "�ͻ��ȼ�", "��Ч����ʱ��","�������ʺ�","������", "����ԭ��"  };
     
     %>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
				<wtc:param value="<%=expquerySql%>" />
				</wtc:service>
				<wtc:array id="expall"   scope="end" />

     <%
         
         this.toExcel(expall, strHead, response); 
    }
    
%>
 
<html>
	<head>
		<%@ include file="k197_callMsgQry_include.jsp" %>		
	</head>
	<body onLoad="insertParentFrameValue();">
		<div id="Operation_Table">
				<input type="button" class="b_foot" value = "����" onClick="openWinMid('k197_addsceTrans.jsp','�������',650,800);" >
      <input type="button" class="b_foot" value = "�޸�" onClick="modifysceTrans();">
      <input type="button" class="b_foot" value = "ɾ��" onClick="delsceTrans();">

      <table  cellSpacing="0">
		          <tr >
        <th width="2%" >ѡ��<input type="checkbox" name="ck_all"  id="ck_all" onclick="checkAll(this)" ></th>
            <th align="center" class="blue" width="8%" nowrap > ������� </th>
            <th align="center" class="blue" width="8%" nowrap > �ͻ�����</th>
            <th align="center" class="blue" width="8%" nowrap > ����ͻ���� </th>
            <th align="center" class="blue" width="8%" nowrap > �ͻ����� </th>
            <th align="center" class="blue" width="8%" nowrap > ��Ч����ʱ��  </th>
            <th align="center" class="blue" width="8%" nowrap > �������ʺ�</th>
            <th align="center" class="blue" width="8%" nowrap > ������ </th>
            <th align="center" class="blue" width="8%" nowrap > ����ԭ��</th>
 
          </tr>

      
             
            
            <%   
              int m=0;
            	String tdClass="blue";
              for (int i=0+m; i < dataRows.length; i++ ) {
          	  
                  %>
	          <tr onClick="changeColor('<%=tdClass%>',this);"  >
            	<td><input type="checkbox" name="ck_2" value="<%=i%>" ></td>

						
				   	</td>
             
             
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
             
             
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
 
                <input type ="hidden"  id="sceid" name="sceid" value=<%=dataRows[i][8]%>>
          
           </tr>
             <% }//forѭ����β����
              %>

    <tr >
      <td class="blue"  align="right" colspan="24">
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
        <a href="#" onClick="doLoad('last');return false;">βҳ</a>&nbsp;
        <a>����ѡ��</a>
        <select onchange="jumpToPage(this.value)">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <a>������ת</a>
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=����>GO</font>
        <%}%>
      </td>
    </tr>
  </table>
  
</div>
	</body>
</html>


<%!
//����Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
        XLSExport e  =   new  XLSExport(null);
        String headname = "����������Ϣ����";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				 
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
           System.out.println( " ����Excel�ļ�[�ɹ�] ");
        }catch  (Exception e1) {
           System.out.println( " ����Excel�ļ�[ʧ��] ");
           e1.printStackTrace();
        } 
    }
    
    
    
     
%>