<%
   /*
   * ����: K199 �ͷ�������Ӫָ����ϵ
�� * �汾: 1.0.0
�� * ����: 2009/9/9
�� * ����: yinzx
�� * ��Ȩ: sitech
   * 
�� */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="java.util.*"%>

<%

  
	String[][] dataRows = null;
  	
	String opCode = "K199";
	String opName = "�ͷ�������Ӫָ����ϵ";
	String nowtoday = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String loginNo = (String) session.getAttribute("workNo");
	String orgCode = (String) session.getAttribute("orgCode");
	String kf_longin_no = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));

	String sqlStr = "  select SERIALNO || ',' || to_char(datetime, 'YYYY-MM-DD HH24:MI:SS') || ',' || c1 || ',' || c2 || ',' || c3 || ',' || c4 || ',' || c5 || ',' || c6 || ',' || c7 || ',' || c8 || ',' || c9 || ',' || c10 || ',' || c11 || ',' || c12 || ',' || c13 || ',' || c14 || ',' || c15 || ',' || c16 || ',' || c17 || ',' || c18 || ',' || c19 || ',' || c20 || ',' || c21 || ',' || c22 || ',' || c23 || ',' || c24 || ',' || c25 || ',' || c26 || ',' || c27 || ',' || c28 || ',' || c29 || ',' || c30 || ',' || c31 || ',' || c32 || ',' || c33 || ',' || c34 || ',' || c35 || ',' || c36 || ',' || c37 || ',' || c38 || ',' || c39 || ',' || c40 || ',' || c41 || ',' || c42 || ',' || c43 || ',' || c44 || ',' || c45 || ',' || c46 || ',' || c47 || ',' || c48 || ',' || c49 || ',' || c50 || ',' || c51 || ',' || c52 || ',' || c53 || ',' || c54 || ',' || c55 || ',' || c56 || ',' || c57 || ',' || c58 || ',' || c59 || ',' || c60 || ',' || c61 || ',' || c62 || ',' || c63 || ',' || c64 || ',' || c65 || ',' || c66 || ',' || c67 || ',' || c68 || ',' || c69 || ',' || c70 || ',' || c71 || ',' || c72 || ',' || c73 || ',' || c74 || ',' || c75 || ',' || c76 || ',' || c77 || ',' || c78 || ',' || c79 || ',' || c80 || ',' || c81 || ',' || c82 from difoperational  where 1=1  "  ;
 
	String strCountSql = "select to_char(count(*)) count  from difoperational a where 1=1";
	
	String edBeginTimeSql = " ";
 
  java.text.DecimalFormat dataFormat = new java.text.DecimalFormat("#.########");


	
	String start_date = request.getParameter("start_date"); //����ʱ��
	 
	


	
	String[] xx= new String[]{};
	int rowCount = 0;
	int pageSize = 20; // Rows each page
	int pageCount = 0; // Number of all pages
	int curPage = 0; // Current page
	String strPage; // Transfered pages
	String param = "";
	String action = "doLoad";
	String sqlOrderby=" order by  datetime desc";
	 

	 
	String sqlFilter = request.getParameter("sqlFilter");

	//��ѯ����
	if (sqlFilter == null || sqlFilter.trim().length() == 0)
	 {
		if (start_date != null && !start_date.trim().equals("")) 
		{
			edBeginTimeSql = " and  '"+start_date+"'  like to_char(datetime,'yyyymm') || '%'  ";
		}
		
		 sqlFilter= edBeginTimeSql;
	}

     sqlFilter+= sqlOrderby;
%>

<%
		if ("doLoad".equals(action)) {
		sqlStr += sqlFilter;
		String sqlTemp = strCountSql + sqlFilter;
		 
		HashMap hashMap =new HashMap();
		String _start_date = start_date;
		if(start_date!=null&&start_date.length()>8){
			_start_date = start_date.substring(0,8);
		}
		hashMap.put("start_date",_start_date); 

    rowCount=((Integer)KFEjbClient.queryForObject("k199Mainselect_CountSql",hashMap)).intValue(); 
    
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
		int start = (curPage - 1) * pageSize + 1;
	  int end = curPage * pageSize;
	  hashMap.put("start", ""+start);
	  hashMap.put("end", ""+end);
	

    List iDataList3 =(List)KFEjbClient.queryForList("k199Mainselect",hashMap);                              
	  String[][] queryList = getArrayFromListMap(iDataList3 ,0,2); 
	  dataRows = new String[queryList.length][];	 
    for(int i=0;i<queryList.length;i++)
    
   {       
              xx=queryList[i][1].split(",");
              dataRows[i]  =xx ;       
   }
   }
   
    
    
   
%>


<html>
	<head>
		<%@ include file="k199_query.jsp" %>
	</head>
	<body onLoad="">
		<div id="Operation_Table">
			<input type="button" class="b_foot" value = "����" onClick="openWinMid('k199_addsceTrans.jsp','�������',600,1000);" >
      <input type="button" class="b_foot" value = "�޸�" onClick="modifysceTrans();">
      <input type="button" class="b_foot" value = "ɾ��" onClick="delsceTrans();">
       
     
			<table cellspacing="0">
				<tr>
					<td class="blue" align="left" style="width:720px">
						
						
					</td>
				</tr>
			</table>
			<table cellSpacing="0">
				<input type="hidden" name="chkBoxNum" value="<%=dataRows.length%>">
				<tr>
				  <th width="2%" >ѡ��</th>
		     <td noWrap="nowrap" >���</td>
    <td width="120" noWrap="nowrap" >�ύ����</td>
    <td noWrap="nowrap" >Ա�������</td>
    <td noWrap="nowrap" >������ʧ��</td>
    <td noWrap="nowrap" >������ʧ��</td>
    <td noWrap="nowrap" >��Ա��Ƹ��ʱ��</td>
    <td noWrap="nowrap" >���ڼ�ʱ��</td>
    <td noWrap="nowrap" >��Ա��ת���ʣ��ϸ��ʣ�</td>
    <td noWrap="nowrap" >��ѵ������</td>
    <td noWrap="nowrap" >��ѵ��ʱ�����</td>
    <td noWrap="nowrap" >��ѵ������</td>
    <td noWrap="nowrap" >��ѵ�ϸ���</td>
    <td noWrap="nowrap" >�ͻ������</td>
    <td noWrap="nowrap" >�һ�������</td>
    <td noWrap="nowrap" >�����ۺϵ÷�</td>
    <td noWrap="nowrap" >�˹���������</td>
    <td noWrap="nowrap" >һ�ν����</td>
    <td noWrap="nowrap" >�ʼ�����</td>
    <td noWrap="nowrap" >������ʱ��</td>
    <td noWrap="nowrap" >����������</td>
    <td noWrap="nowrap" >����Ͷ����</td>
    <td noWrap="nowrap" >��Ӫ�ܳɱ�</td>
    <td noWrap="nowrap" >��Ӫ������</td>
    <td noWrap="nowrap" >����Ӫ��������</td>
    <td noWrap="nowrap" >�˾�����Ӫ������</td>
    <td noWrap="nowrap" >Ӫ��������</td>
    <td noWrap="nowrap" >�˾�Ӫ������</td>
    <td noWrap="nowrap" >��ϯ���������</td>
    <td noWrap="nowrap" >��ϯ���ƽ��ÿ�ͻ�����</td>
    <td noWrap="nowrap" >ƽ�������ɱ�</td>
    <td noWrap="nowrap" >ƽ���˹�����ɱ�</td>
    <td noWrap="nowrap" >ƽ��ÿ�ͻ�����ɱ�</td>
    <td noWrap="nowrap" >���Ӫ�������</td>
    <td noWrap="nowrap" >Ͷ�߹����ϸ���</td>
    <td noWrap="nowrap" >Ͷ�ߴ���ʱ��</td>
    <td noWrap="nowrap" >Ͷ���ɵ�������</td>
    <td noWrap="nowrap" >Ͷ�ߵ绰��</td>
    <td noWrap="nowrap" >�ظ�Ͷ����</td>
    <td noWrap="nowrap" >����Ͷ����</td>
    <td noWrap="nowrap" >Ͷ�ߴ���������</td>
    <td noWrap="nowrap" >����ˮƽ��15�������ͨ�ʣ�</td>
    <td noWrap="nowrap" >�˹����������</td>
    <td noWrap="nowrap" >���з�����</td>
    <td noWrap="nowrap" >ƽ���Ŷ�ʱ��</td>
    <td noWrap="nowrap" >��ͨ�Ŷ�ʱ��</td>
    <td noWrap="nowrap" >�����Ŷ�ʱ��</td>
    <td noWrap="nowrap" >�˹�������</td>
    <td noWrap="nowrap" >�˹���ͨ��</td>
    <td noWrap="nowrap" >�ŶӺ����ʣ��˹���ͨ�ʣ�</td>
    <td noWrap="nowrap" >VIP20���ͨ��</td>
    <td noWrap="nowrap" >ȫ��ͨ20���ͨ��</td>
    <td noWrap="nowrap" >������30���ͨ��</td>
    <td noWrap="nowrap" >���еش�30���ͨ��</td>
    <td noWrap="nowrap" >�������30���ͨ��</td>
    <td noWrap="nowrap" >ƽ���ӳ�ʱ��</td>
    <td noWrap="nowrap" >ƽ������ʱ��</td>
    <td noWrap="nowrap" >ƽ����̸ʱ����ͨ��������</td>
    <td noWrap="nowrap" >ƽ������ʱ��</td>
    <td noWrap="nowrap" >ƽ���º���ʱ��</td>
    <td noWrap="nowrap" >�˾�ÿСʱ�绰������</td>
    <td noWrap="nowrap" >����������</td>
    <td noWrap="nowrap" >��ʱ������</td>
    <td noWrap="nowrap" >������</td>
    <td noWrap="nowrap" >�˹�����ռ��</td>
    <td noWrap="nowrap" >���񲨶�ϵ��</td>
    <td noWrap="nowrap" >�˹�����Ԥ��׼ȷ��</td>
    <td noWrap="nowrap" >�Ű��Ǻ���</td>
    <td noWrap="nowrap" >����ˮƽ������</td>
    <td noWrap="nowrap" >ÿСʱ���Ӱ�����</td>
    <td noWrap="nowrap" >��Ŀ�������</td>
    <td noWrap="nowrap" >�����ͨ��</td>
    <td noWrap="nowrap" >���Ӫ���ɹ���</td>
    <td noWrap="nowrap" >ÿСʱ�����</td>
    <td noWrap="nowrap" >�ƻ�������</td>
    <td noWrap="nowrap" >�Ӵ��ɹ���</td>
    <td noWrap="nowrap" >���۳ɹ���</td>
    <td noWrap="nowrap" >�ʼ�ϸ���</td>
    <td noWrap="nowrap" >����Ӫ��Ͷ����</td>
    <td noWrap="nowrap" >�˹�ת�Զ�����</td>
    <td noWrap="nowrap" >IVR������</td>
    <td noWrap="nowrap" >֪ʶ��������</td>
    <td noWrap="nowrap" >ϵͳ��ͨ��</td>
    <td noWrap="nowrap" >ϵͳ��������</td>
    <td noWrap="nowrap" >������</td>
</tr>

				<%
						for (int i = 0; i < dataRows.length; i++) {
	 
						String tdClass = "one";
						if ((i + 1) % 2 == 1) {
							tdClass = "two";
						}
						
				%>
				<tr onClick="">

					<td><input type="checkbox" name="ck_2" value="<%=i%>" ></td>
					</td>

					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][0].length() != 0) ? dataRows[i][0]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][1].length() != 0) ? dataRows[i][1]
						: "&nbsp;"%>
					</td>
					
				<% for (int j = 2; j < 83; j++){ %>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][j].length() != 0) ? dataFormat.format(Double.parseDouble(dataRows[i][j]))
						: "&nbsp;"%>
					</td>
				<% }%>	
				
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][83].length() != 0) ? dataFormat.format(Double.parseDouble(dataRows[i][83]))
						: "&nbsp;"%>
						<input type ="hidden"  id="sceid" name="sceid" value=<%=dataRows[i][0]%>> 
					</td>
					
		
						
						  

					
				</tr>
				<%
				
				}
				%>
			</table>

			<table cellspacing="0">
				<tr>
					<td class="blue" align="right" width="720">
						<%
						if (pageCount != 0) {
						%>
						��
						<%=curPage%>
						ҳ ��
						<%=pageCount%>
						ҳ ��
						<%=rowCount%>
						��
						<%
						} else {
						%>
						<font color="orange">��ǰ��¼Ϊ�գ�</font>
						<%
						}
						%>
						<%
						if (pageCount != 1 && pageCount != 0) {
						%>
						<a href="#" onClick="doLoad('first');return false;">��ҳ</a>
						<%
						}
						%>
						<%
						if (curPage > 1) {
						%>
						<a href="#" onClick="doLoad('pre');return false;">��һҳ</a>
						<%
						}
						%>
						<%
						if (curPage < pageCount) {
						%>
						<a href="#" onClick="doLoad('next');return false;">��һҳ</a>
						<%
						}
						%>
						<%
						if (pageCount > 1) {
						%>
						<a href="#" onClick="doLoad('last');return false;">βҳ</a>
						<a>����ѡ��</a>
						<select onchange="jumpToPage(this.value)">
							<%
										for (int i = 1; i <= pageCount; i++) {
										out.print("<option value='" + i + "'");
										if (i == curPage) {
									out.print("selected");
										}
										out.print(">" + i + "</option>");
									}
							%>
						</select style="height:18px">
						&nbsp;&nbsp;
						<a>������ת</a>
						<input id="thePage" name="thePage" type="text"
							value="<%=curPage%>" style="height:18px;width:30px"
							onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
						<a href="#" onClick="jumpToPage('jumpToPage1');return false;">
							<font face=����>GO</font> <%
 }
 %>
						
					</td>
				</tr>
			</table>
		</div>
	</div>
	</body>
</html>
