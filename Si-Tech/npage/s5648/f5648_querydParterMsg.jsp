<%
   /*
   * ����: SI������ϵ��ѯ - ��ѯdpartermsg
�� * �汾: v1.0
�� * ����: 2007/2/9
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-23    qidp        �°漯�Ų�Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String flag="0";
	
	String op_name = "���������Ϣ�б�";
	
	String opName = "���������Ϣ�б�";
	
	//-----------------------------------------------
	
	String queryType = request.getParameter("queryType");
	String queryInfo = request.getParameter("queryInfo");	
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();

	ArrayList retList = new ArrayList();

	String errcode = "";
    String errmsg = "";
	String[][] colNameArr = new String[][]{};
	try{
	%>
        <wtc:service name="s5648ParterEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4" >
        	<wtc:param value="5648"/>
        	<wtc:param value="<%=workNo%>"/> 
        	<wtc:param value="<%=queryType%>"/>
        	<wtc:param value="<%=queryInfo%>"/>         		
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
        errcode = retCode;
        errmsg = retMsg;
        if("000000".equals(retCode)){
            if(retArr.length>0){
                colNameArr = retArr;
            }else{
                %>
                    <script type=text/javascript>
                        rdShowMessageDialog("û�в鵽��ؼ�¼��",0);
                        window.close();
                    </script>
                <%
            }
        }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("������룺<%=errcode%>,������Ϣ��<%=errmsg%>",0);
                    window.close();
                </script>
            <%
        }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("��ѯ���������Ϣʧ�ܣ�",0);
                window.close();
            </script>
        <%
        e.printStackTrace();
    }
	//String[][] colNameArr = (String[][])retList.get(0);
	    
	    System.out.println("colNameArr.length="+colNameArr.length);
	    
	    for(int i=0;i < colNameArr.length;i++){ 
				System.out.println("colNameArr[i][0]="+colNameArr[i][0]);
				System.out.println("colNameArr[i][1]="+colNameArr[i][1]);
				System.out.println("colNameArr[i][2]="+colNameArr[i][2]);
				System.out.println("colNameArr[i][3]="+colNameArr[i][3]);
	}	    
	if(colNameArr==null)
 	{
%>           
			<script language='jscript'>
				rdShowMessageDialog("û�в鵽��ؼ�¼��");
				window.close();
			</script>
<%  
	} else
	{				
%>        
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">���������Ϣ�б�</div>
</div>	    	
	<TABLE id="tab1" cellspacing="0" align="center">
	<tr align="center">
		<th nowrap>
			ѡ��
		</th>
		<th nowrap>
			����������
		</th>
		<th nowrap>
			���������
		</th>
		<th nowrap>
			�����������
		</th>
		<th nowrap>
			�ͷ��绰
		</th>
	</tr>
	
	</TABLE>

<table cellspacing="0">
	<tr id="footer">
		<td>
            <input type="button" name="commit" class="b_foot" style="cursor:hand" onClick="doCommit();" value="ȷ��">
            <input type="button" name="back" class="b_foot" style="cursor:hand" onClick="window.close();" value="�ر�">
		</td>
	</tr>
</table>
</div>
</form>
</body>
</html>

<script>
	  
	<%for(int i=0;i < colNameArr.length;i++){ %>		
		var str='<input type="hidden" name="parterId" value="<%=colNameArr[i][0]%>">';
		str+='<input type="hidden" name="checkdocId" value="<%=colNameArr[i][1]%>">';
		str+='<input type="hidden" name="parterName" value="<%=colNameArr[i][2]%>">';
		str+='<input type="hidden" name="spTel" value="<%=colNameArr[i][3]%>">';
					
		var rows = document.getElementById("tab1").rows.length;
		var newrow = document.getElementById("tab1").insertRow(rows);
		newrow.align="center";
		newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
	  	newrow.insertCell(1).innerHTML = '<%=colNameArr[i][0]%>';
	  	newrow.insertCell(2).innerHTML = '<%=colNameArr[i][1]%>';
	  	newrow.insertCell(3).innerHTML = '<%=colNameArr[i][2]%>';
	  	newrow.insertCell(4).innerHTML = '<%=colNameArr[i][3]%>';
	  	
	<%}%>
	

	function doCommit()
	{		
		if("<%=colNameArr.length%>"=="0")
		{
			rdShowMessageDialog("û�п�ѡ��ļ�¼��",0);
			return false;
		}
		else if("<%=colNameArr.length%>"=="1")
		{//ֵΪһ��ʱ����Ҫ������
			if(document.all.num.checked)
			{				
			  window.opener.form1.parterId.value = document.all.parterId.value;
			  window.opener.form1.checkdocId.value = document.all.checkdocId.value;
			  window.opener.form1.parterName.value = document.all.parterName.value;
			  window.opener.form1.spTel.value = document.all.spTel.value;
       			
       	//window.opener.tabNext.style.display="";
       	//window.opener.tabEC.style.display="";
       	window.opener.tabNext.style.display="";
       	window.opener.tabEC.style.display="";
       	window.opener.tabBlank.style.display="";
       	window.opener.tabBusi.style.display="none";
       			
       	var newTable = window.opener.document.getElementById("tabEC");
       	if (newTable.rows.length > 1)
				{
					newTable.deleteRow(newTable.rows.length-1);
				}
       			var newRow = window.opener.tabEC.insertRow();
				//newRow.bgColor = "#F5F5F5";
				newRow.insertCell().innerHTML = '<center>' + document.all.parterId.value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.checkdocId.value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.parterName.value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.spTel.value + '</center>';
				newRow.insertCell().innerHTML = '<center><input name="queryBusiBtn" style="cursor:hand" type="button" value="��ѯҵ����Ϣ" class="b_text" onclick="queryBusiInfo()">&nbsp;</center>';
		
				window.close();
       			/*var newRow = window.opener.tabEC.insertRow();
				newRow.insertCell().innerHTML = '<center>' + document.all.parterId.value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.parterName.value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.spTel.value + '</center>';
				newRow.insertCell().innerHTML = '<center><input name="queryBaseCodeBtn" style="cursor:hand" type="button" value="��ѯ�������Ϣ" class="b_text" onclick="queryBasecodeInfo()">&nbsp;&nbsp;</center>';
				newRow.insertCell().innerHTML = '<center><input name="queryBusiBtn" style="cursor:hand" type="button" value="��ѯҵ����Ϣ" class="b_text" onclick="queryBusiInfo()">&nbsp;</center>';
		
				window.close();*/
			}
			else
			{
				rdShowMessageDialog("��ѡ���¼��");
				return false;
			}
		}
		else
		{//ֵΪ����ʱ��Ҫ������
			var a=-1;
			for(i=0;i<document.all.num.length;i++)
			{
				if(document.all.num[i].checked)
				{
					a=i;
					break;
				}
			}
			if(a!=-1)
			{				
				/*window.opener.form1.parterId.value=document.all.parterId[a].value;
				window.opener.form1.parterName.value=document.all.parterName[a].value;
				window.opener.form1.spTel.value=document.all.spTel[a].value;
				window.opener.form1.checkdocId.value="<%=flag%>";
       			
       			window.opener.tabNext.style.display="";
       			window.opener.tabEC.style.display="";*/
       			window.opener.tabNext.style.display="";
       			window.opener.form1.parterId.value=document.all.parterId[a].value;
				window.opener.form1.checkdocId.value=document.all.checkdocId[a].value;
				window.opener.form1.parterName.value=document.all.parterName[a].value;
				window.opener.form1.spTel.value=document.all.spTel[a].value;

       			window.opener.tabEC.style.display="";
       			window.opener.tabBlank.style.display="";
       			window.opener.tabBusi.style.display="none";
       			
       			var newTable = window.opener.document.getElementById("tabEC");
       			if (newTable.rows.length > 1)
				{
					newTable.deleteRow(newTable.rows.length-1);
				}
       			
       			var newRow = window.opener.tabEC.insertRow();
				/*newRow.insertCell().innerHTML = '<center>' + document.all.parterId[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.parterName[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.spTel[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center><input name="queryBaseCodeBtn" style="cursor:hand" type="button" value="��ѯ�������Ϣ" class="b_text" onclick="queryBasecodeInfo()">&nbsp;&nbsp;</center>';
				newRow.insertCell().innerHTML = '<center><input name="queryBusiBtn" style="cursor:hand" type="button" value="��ѯҵ����Ϣ" class="b_text" onclick="queryBusiInfo()">&nbsp;</center>' ;
				*/
				newRow.insertCell().innerHTML = '<center>' + document.all.parterId[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.checkdocId[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.parterName[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.spTel[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center><input name="queryBusiBtn" style="cursor:hand" type="button" value="��ѯҵ����Ϣ" class="b_text" onclick="queryBusiInfo()">&nbsp;</center>' ;
								
				window.close();
			}
			else
			{
				rdShowMessageDialog("��ѡ���¼��");
				return false;
			}
		}
	}
	
	function onkeydown(event) 
	{
		if (event.srcElement.type!="button")
		{
			if (event.keyCode == 13)
			{
				doCommit();
			}
		}
	}
	function doClose()
	{
		window.close();
	}
</script>

<%            
    	}
    %>