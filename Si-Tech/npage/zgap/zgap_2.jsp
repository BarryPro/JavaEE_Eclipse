<%
/********************
version v1.0
������: si-tech
add by zhangleij
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%
			//��ҳ��������
		  int rowCount = 0;
			int pageSize = 50; // Rows each page
			int pageCount = 0; // Number of all pages
			int curPage = 0; // Current page
			String strPage; // Transfered pages
			int curData = 0;// ѭ������������
			int lastData = 0; // ѭ���е����һ������
			
			String return_code = "";
    	String return_num = "";
    	String return_fee = "";
    	List list2 = new ArrayList();
    	List list3 = new ArrayList();
			
    	String opCode = "zgap";
			String opName = " �����û���ϸ��ѯ";
			response.setHeader("Pragma", "No-Cache");
			response.setHeader("Cache-Control", "No-Cache");
			response.setDateHeader("Expires", 0);

			String in_contract_no = request.getParameter("contract_no");
			String in_con_pwd = request.getParameter("con_pwd");
			String in_bill_ym = request.getParameter("bill_ym");
			String in_page = request.getParameter("page");
			return_num = request.getParameter("returnNum");
			return_fee = request.getParameter("returnFee");
			return_code = request.getParameter("returnCode");
			
			if(return_fee != null) {
				DecimalFormat df = new DecimalFormat("0.00");
				return_fee = df.format(Double.parseDouble(return_fee));
			}

			String inParas[] = new String[2];
			inParas[0] = in_contract_no;
			inParas[1] = in_bill_ym;    	    	
			
			if(return_num != null) {
    	
				list2 = (List) session.getAttribute("se_list2");
				list3 = (List) session.getAttribute("se_list3");
			
			  //��ҳ��������(�ӵڶ�ҳ��ʼ)
			  rowCount = Integer.parseInt(return_num);
				if (in_page != null && in_page != "") {
					int i_page = Integer.parseInt(in_page);
					curData = (i_page - 1) * pageSize;
					if (i_page - 1 == rowCount / pageSize) {
						lastData = curData + rowCount % pageSize;
					} else {
						lastData = curData + pageSize;
					}
				} else {
					lastData = curData + pageSize;
				}
				
				strPage = request.getParameter("page");
				if (strPage == null || strPage.equals("") || strPage.trim().length() == 0||"undefined".equals(strPage)) {
					curPage = 1;
				} else {
					curPage = Integer.parseInt(strPage);
					if (curPage < 1)
						curPage = 1;
				}
				pageCount = (rowCount + pageSize - 1) / pageSize;
				if (curPage > pageCount)
				curPage = pageCount;
			}
			
if (in_page == null) {
%>
<wtc:service name="szgap" routerKey="phone" routerValue="<%=in_contract_no%>" outnum="5">
    <wtc:param value="<%=inParas[0]%>" />
    <wtc:param value="<%=inParas[1]%>" />
</wtc:service>
<wtc:array id="r_ret1" scope="end" start="0"  length="1" />	
<wtc:array id="r_ret2" scope="end" start="1"  length="2" />
<wtc:array id="r_ret3" scope="end" start="3"  length="2" />
<%
    	return_code = r_ret1[0][0];
    	return_num = r_ret3[0][0];
    	return_fee = r_ret3[0][1];
    	rowCount = Integer.parseInt(return_num);
    	
    	// �Ƴ�session�е�����
    	session.removeAttribute("se_list2");
    	session.removeAttribute("se_list3");
    	
    	if(r_ret2.length > 0 && r_ret3.length > 0) {
	    	for(int i=0; i < rowCount; i++) {
	    		list2.add(r_ret2[i][0]);
	    		list3.add(r_ret2[i][1]);
	    	}
    	}
    	// ���ֻ��źͷ����б�ŵ�session��
    	session.setAttribute("se_list2", list2);
    	session.setAttribute("se_list3", list3);
			
		  //��ҳ�������ã���ҳ��
		  rowCount = Integer.parseInt(return_num);
		  if(rowCount < pageSize) {
		  	lastData = rowCount;
		  } else {
				lastData = pageSize;
			}
			
			strPage = request.getParameter("page");
			if (strPage == null || strPage.equals("") || strPage.trim().length() == 0||"undefined".equals(strPage)) {
				curPage = 1;
			} else {
				curPage = Integer.parseInt(strPage);
				if (curPage < 1)
					curPage = 1;
			}
			pageCount = (rowCount + pageSize - 1) / pageSize;
			if (curPage > pageCount)
			curPage = pageCount;
}
%>
<%
    if (!return_code.equals("000000") && !return_code.equals("0")) {
%>
<script language="JavaScript">
	rdShowMessageDialog(" �����û���ϸ��ѯʧ��! ");
	window.location = "zgap_1.jsp";
</script>
<%
    } else {
%>

<HEAD>
<TITLE>������BOSS- �����û���ϸ��ѯ</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</HEAD>
<BODY leftmargin="0" topmargin="0">
        <%@ include file="/npage/include/header.jsp"%>
			  <form id=sitechform name=sitechform>
        <div class="title">
            <div id="title_zi">
                �����û���ϸ�б�
            </div>
        </div>
        <table cellspacing="0">
            <tr>
                <th>
                    <div align="center">
                        <b>��ͬ��</b>
                    </div>
                </th>
                <th>
                    <div align="center">
                        <b>�ֻ�����</b>
                    </div>
                </th>
                <th>
                    <div align="center">
                        <b>��������</b>
                    </div>
                </th>
                <th>
                    <div align="center">
                        <b>����</b>
                    </div>
                </th>
            </tr>

            <%
            	if(list2.size() > 0 && list3.size() > 0) {
                for (int i = curData; i < lastData; i++) {
            %>
            <tr>
                <td nowrap><%=in_contract_no%></td>
                <td nowrap><%=list2.get(i)%></td>
                <td nowrap><%=in_bill_ym%></td>
                <td nowrap><%=list3.get(i)%></td>
            </tr>
            <%
                }
                // �ж����һҳ��ʾ�ܷ���
		            if(lastData == rowCount) {
		            %>
		            <tr>
		            	<td colspan="3" align="center">�ܷ���</td>
		            	<td><%=return_fee%></td>
		            </tr>
		            <%
		            }
              }
            %>
            
    <tr >
      <td class="blue" colspan="4" align="right" >
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
			  <input type="hidden" name="page" value="">
			  
        </table>
        
        <!-------------------����table�������� begin----------------------->
        <table cellspacing="0" id="tabList" style="display:none">
            <tr>
                <th>
                    <div align="center">
                        <b>��ͬ��</b>
                    </div>
                </th>
                <th>
                    <div align="center">
                        <b>�ֻ�����</b>
                    </div>
                </th>
                <th>
                    <div align="center">
                        <b>��������</b>
                    </div>
                </th>
                <th>
                    <div align="center">
                        <b>����</b>
                    </div>
                </th>
            </tr>

            <%
            	if(list2.size() > 0 && list3.size() > 0) {
                for (int i = 0; i < list2.size(); i++) {
            %>
            <tr>
                <td nowrap><%=in_contract_no%></td>
                <td nowrap><%=list2.get(i)%></td>
                <td nowrap><%=in_bill_ym%></td>
                <td nowrap><%=list3.get(i)%></td>
            </tr>
            <%
                }
              }
            %>
			  <input type="hidden" name="page" value="">
			  
        </table>
        <!-------------------����table�������� end----------------------->
        
			 <TABLE cellSpacing="0">
				<TR> 
				  <TD id="footer"> 
					  <input type="button"  name="back"  class="b_foot" value="����" onClick="window.location='zgap_1.jsp'">
					  <input type="button"  name="back"  class="b_foot" value="�ر�" onClick="removeCurrentTab()">
					  <input type="button" name="print"  class="b_foot" value="��ӡ" onclick="javascript:window.print();" align="center">
					  <input type="button" class="b_foot" value="EXCEL����" onclick="saveToExcel(tabList)" id="saveToExcelBtn"  />
				  </TD>
				</TR>
			  </TABLE>
			</form>
        <%@ include file="/npage/include/footer_simple.jsp"%>
</BODY>
<% } %>
</HTML>

<script language="javascript">
function doLoad(operateCode){

   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
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
   submitMe();
} 

function submitMe(){
	 window.sitechform.action="zgap_2.jsp?contract_no="+<%=in_contract_no%>+"&bill_ym="+<%=in_bill_ym%>+"&page="+window.sitechform.page.value+"&returnNum="+<%=return_num%>+"&returnFee="+<%=return_fee%>+"&returnCode="+<%=return_code%>+"&list2="+<%=list2%>+"&list3="+<%=list3%>;
   window.sitechform.method='post';
   window.sitechform.submit(); 
}

function saveToExcel(obj) {
	var excelObj;
	<%
	if(list2.size() > 0 && list3.size() > 0) {
  %>
  var listsize = <%=list2.size()%>;  
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.tabList.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
    excelObj.WorkBooks.Add;
		for(a=0;a<document.all.tabList.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						for(j=0;j<cells;j++)
							excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
					}
				}
				catch(e)
				{
					rdShowMessageDialog("����excelʧ��! ");
					return false;
				}
			}
			else
			{
				rdShowMessageDialog("'no data! ");
				return false;
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
    excelObj.WorkBooks.Add;
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					for(j=0;j<cells;j++)
						excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
				}
			}
			catch(e)
			{
				rdShowMessageDialog("����excelʧ��! ");
				return false;
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			rdShowMessageDialog("'no data! ");
			return false;
		}
	}
  <%
  } else {
  %>
		rdShowMessageDialog("��ѯ���Ϊ�գ����ܵ���! ");
		return false;
  <%
  }
  %>
}
</script>
