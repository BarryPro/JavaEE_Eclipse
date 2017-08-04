<%
    /********************
     version v2.0
     ������: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<HTML>
	<HEAD>
		<TITLE>������ͬ������</TITLE>
		<%
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
		%>
		<%
    	String opCode = "b558";
    	String opName = "������ͬ������";
    	String workNo = (String)session.getAttribute("workNo");
      String workName = (String)session.getAttribute("workName");
      String regionCode=(String)session.getAttribute("regCode");
		%>
	</HEAD>
	<BODY>
		<SCRIPT language="JavaScript">
			function checknum(fData)
			{
				if(fData == "")
					return false;
				if ((isNaN(fData)) || (fData.indexOf(".")!=-1) || (fData.indexOf("-")!=-1))
					return false;
				return true;
			}
			function doCheck()
			{
				if(!document.frmb558.feefile.value)
				{
					rdShowMessageDialog("��ѡ��������ļ�!",0);
        	return false;
				}
				var tmpArr = document.frmb558.feefile.value.split(".");
				if(tmpArr[tmpArr.length-1].trim().toLowerCase()!="xlsx" && tmpArr[tmpArr.length-1].trim().toLowerCase()!="xls")
				{
					rdShowMessageDialog("��ѡ��EXCEL�ļ�!"+ tmpArr[tmpArr.length-1],0);
        	return false;
				}
				if(!checknum(document.frmb558.sheetno.value))
				{
					rdShowMessageDialog("�����������������0��������",0);
        	return false;
				}
				
				if(document.frmb558)
				var oButton = document.getElementById("Button1"); 
				oButton.disabled = true; 
				document.frmb558.action="fb558_2.jsp"
				frmb558.submit();
			}
			function typechange()
			{
				 if (document.frmb558.searchType.selectedIndex == 0) {
            IList1.style.display = "none";
        } else {
            IList1.style.display = "";
        }
			}
		</SCRIPT>
		<FORM method=post name="frmb558" ENCTYPE="multipart/form-data">
			<input type="hidden" name="opCode" value="b558">
			<input type="hidden" name="opName" value="������ͬ������">
			<input type="hidden" name="workNo" value="<%=workNo%>">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
        <div id="title_zi">EXCEL���ݵ���</div>
    	</div>
    	<TABLE cellSpacing="0">
				<TR>
            <TD class="blue" width=16%>��������</TD>
            <TD>
                <select name="searchType" onchange="typechange()">
                    <option value="0" selected>SP��ҵ������</option>
                    <option value="1">SPҵ�������</option>
                </select>
            </TD>
            <TD class="blue" width=16%>��������</TD>
            <TD colspan="3">
                <select name="optType">
                    <option value="0" selected>����</option>
                    <option value="1">�޸�</option>
                    <option value="2">ɾ��</option>
                </select>
            </TD>
        </TR>
        <TR>
        	<TD class="blue" width=16%>����������</TD>
            <TD>
                <select name="dsmpType">
                	<wtc:qoption name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
                		<wtc:sql>
											select servtype,servname from sdsmpservtype order by servtype
										</wtc:sql>
                	</wtc:qoption>  
                </select>
            </TD>
            <TD class="blue" width=16%>��������</TD>
            <TD colspan="3">
              <input type="text" name="sheetno" size="20" maxlength="2">
            </TD>
        </TR>
        	<TR style="display:none" id="IList1">
            <TD class="blue" width=16%>��λ</TD>
            <TD>
                <select name="feeunit">
                    <option value="0">Ԫ</option>
                    <option value="1">��</option>
                    <option value="2" selected>��</option>
                    <option value="3">��</option>
                </select>
            </TD>
            <TD class="blue" width=16%>���������ʽ</TD>
            <TD colspan="3">
								<select name="balprop">
                    <option value="0">һ����Ԫ��(85:0:0)</option>
                    <option value="1" selected>������Ԫ��(85 0 0)</option>
                </select>
            </TD>
        </TR>
				<TR>
      		<TD class="blue" width=16%>�������ļ���</TD>
      		<td colspan="7">
      			<input type="file" name="feefile" />
      		</td>
      	</TR>
    	</TABLE>
    	<TABLE cellspacing="0">
    		 <tr>
            <td id="footer">
                &nbsp; <input class="b_foot" name=Button1 type="button" onClick="doCheck()" value=�鿴>
                &nbsp; <input class="b_foot" name=reset type=reset onClick="" value=����>
                &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
            </td>
        </tr>
    	</TABLE>
      <%@ include file="/npage/include/footer.jsp" %>
    	<jsp:include page="/npage/common/pwd_comm.jsp"/>
		</FORM>
	</BODY>
</HTML>
