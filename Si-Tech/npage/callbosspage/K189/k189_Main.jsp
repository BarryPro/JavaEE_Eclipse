<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
   /*
   * ����: K189 �˹�ת�Զ�-תҵ����ѯά���������
�� * �汾: 1.0.0
�� * ����: 2009/8/8
�� * ����: yinzx
�� * ��Ȩ: sitech
   * 
�� */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="java.util.*"%>     
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>                                     
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%
  String yin = request.getParameter("yin"); //����ʱ��
  
  String sqlyin="";
  String sqlxin="";
      /*midify by yinzx 20091113 ������ѯ�����滻*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
 	  	
	String opCode = "K189";
	String opName = "תҵ����ѯά���������";
	String nowtoday = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String loginNo = (String) session.getAttribute("workNo");
	String kf_longin_no = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));

	String sqlStr = " select distinct a.typeid,a.servicename,a.accesscode,a.citycode,a.transfercode,a.digitcode,a.usertype,a.messegecontent,a.visiable from DZXSCETRANSFERTAB a where 1=1   ";

	String strCountSql = " select to_char(count(*)) from ("+sqlStr+") where 1=1";

	String strCityCodeSql = " ";
	String strDigitcodeSql = " ";
	String strServiceNmaeSql = " ";
	String strOrderSql = " order by digitcode ";
	


	
	String city_code = request.getParameter("city_code");  
	String digit_code = request.getParameter("digit_code")==null?"":request.getParameter("digit_code");  
	String service_name = request.getParameter("service_name")==null?"":request.getParameter("service_name");  
	int start=0;
  int end=0;  
	HashMap pMap=new HashMap();
	if (city_code != null && !city_code.trim().equals("")) 
		{
	 			pMap.put("city_code", city_code);
		}
		
		if (digit_code != null && !digit_code.trim().equals("")) 
		{
			 pMap.put("digit_code", digit_code);
		}
		
		if (service_name != null && !service_name.trim().equals("")) 
		{  
			 pMap.put("service_name", service_name.trim());
		}
   
	String[][] dataRows = new String[][] {};
	int rowCount = 0;
	int pageSize = 20; // Rows each page
	int pageCount = 0; // Number of all pages
	int curPage = 0; // Current page
	String strPage; // Transfered pages
	String param = "";
	String action = "doLoad";
	String expFlag = request.getParameter("exp");
	String sqlFilter = request.getParameter("sqlFilter");

	//��ѯ����
		if ("doLoad".equals(action)) {
    rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K189_strCountSql",pMap)).intValue();
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
			  start = (curPage - 1) * pageSize + 1;
		    end = curPage * pageSize;
        pMap.put("start", ""+start);
		    pMap.put("end", ""+end);
		    List queryList4 =(List)KFEjbClient.queryForList("query_K189_sqlStr",pMap);     
        dataRows = getArrayFromListMap(queryList4 ,1,10); 
   }
%>


<html>
	<head>
		
	</head>
	<body onLoad="">
	  <%@ include file="k189_query.jsp" %>
    <tr>
					<td class="blue"  align="left" colspan="10">
			<input type="button" class="b_foot" value = "����" onClick="openWinMid('k189_addsceTrans.jsp','�������',650,800);" >
      <input type="button" class="b_foot" value = "�޸�" onClick="modifysceTrans();">
      <input type="button" class="b_foot" value = "ɾ��" onClick="delsceTrans();">
      <input name="import" type="button" class="b_foot"  id="import" value="����EXECL" onClick="beforeLoadExecl();">   
      <input name="export" type="button" class="b_foot"  id="export" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>  
    </td>
    </tr>
      <tr>
					<td class="blue"  align="left" colspan="10">
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
				<input type="hidden" name="chkBoxNum" value="<%=dataRows.length%>">
				<tr>
				  <th width="2%" ><nobr>ѡ��<input type="checkbox" name="ck_all"  id="ck_all" onclick="checkAll(this)" ></th>
					
					
					<th align="center" class="blue" width="9%">
						<nobr>������
					</th>
					<th align="center" class="blue" width="8%">
						<nobr>���д���
					</th>
					 
					<th align="center" class="blue" width="5%">
						<nobr>����·��
					</th>
					<th align="center" class="blue" width="5%">
						<nobr>������
					</th>
					 <th align="center" class="blue" >
						<nobr>��������
					</th>
					<th align="center" class="blue"  >
						<nobr>�ض����̱�־
					</th>
					<th align="center" class="blue"  >
						<nobr>���̵���������
					</th>
					<th align="center" class="blue"  >
						<nobr>�Ƿ���ʾ
					</th>
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
						<%=(dataRows[i][2].length() != 0) ? dataRows[i][2]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][3].length() != 0) ? dataRows[i][3]
						: "&nbsp;"%>
					</td>
					 
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][5].length() != 0) ? dataRows[i][5]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][4].length() != 0) ? dataRows[i][4]
						: "&nbsp;"%>
					</td>
 
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][7].length() != 0) ? dataRows[i][7]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][0].length() != 0) ? dataRows[i][0]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][1].length() != 0) ? dataRows[i][1]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][8].length() != 0) ? dataRows[i][8]
						: "&nbsp;"%>
					</td>
				 
						 <input type ="hidden"  id="sceid" name="sceid" value=<%=dataRows[i][2]+dataRows[i][3]+"10"+dataRows[i][5] %>>
						  <input type ="hidden" id="accesscode" name="accesscode" value=<%=dataRows[i][2]%>>
						   <input type ="hidden" id="citycode" name="citycode" value=<%=dataRows[i][3]%>>
						    <input type ="hidden"  id="digitcode"name="digitcode" value=<%=dataRows[i][5]%>>
          </tr>
				<%
				
				}
				%>
								<tr>
					<td class="blue"  align="left" colspan="10">
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
