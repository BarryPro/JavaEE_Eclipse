<%
   /*
   * ����: ��ѯ�����������Ϣ
�� * �汾: v1.0
�� * ����: 2009/3/6
�� * ����: wuxy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-24    qidp        �°漯�Ų�Ʒ����
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
	
	String op_name = "�����������Ϣ�б�";
	
	String opName = "�����������Ϣ�б�";
	//-----------------------------------------------
	
	String queryType = request.getParameter("queryType");
	String queryInfo = request.getParameter("queryInfo");	
	
	System.out.println("queryType="+queryType);
	System.out.println("queryInfo="+queryInfo);
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();

	ArrayList retList = new ArrayList();
	/*	
	String sqlStr = "";		
	
	if(queryType.equals("0"))//����������
	{
		sqlStr = "select baseservcode,decode(trim(baseservcodeprop),'01','����','02','����','δ֪') a ,decode(basecodestatus,'1','����','3','��ͣ','δ֪') b from daccessnomsg "
		       +" where ecsiid='"+queryInfo+"' ";
                        
	}else if(queryType.equals("1"))//EC�ͻ�ID
	{
		sqlStr = "select baseservcode,decode(trim(baseservcodeprop),'01','����','02','����','δ֪') a ,decode(basecodestatus,'1','����','3','��ͣ','δ֪') b from daccessnomsg "
		       +" where dcu_ecsiid='"+queryInfo+"' ";
	}
	*/
	String[][] colNameArr = new String[][]{};
	//retList = callView.sPubSelect("3",sqlStr);
	//System.out.println("# return from f5648_querydBaseCode.jsp sql -> "+sqlStr);
	try{
    	%>
        <wtc:service name="s5648BaseEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
        	<wtc:param value="5648"/>
        	<wtc:param value="<%=workNo%>"/> 
        	<wtc:param value="<%=queryType%>"/>
        	<wtc:param value="<%=queryInfo%>"/>         		
        </wtc:service>
        <wtc:array id="retArr1" scope="end"/>
        <%
        System.out.println("# return from f5648_querydBaseCode.jsp by sPubSelect -> retCode = "+retCode1);
        System.out.println("# return from f5648_querydBaseCode.jsp by sPubSelect -> retMsg  = "+retMsg1);
        System.out.println("# return from f5648_querydBaseCode.jsp by sPubSelect -> retArr.length  = "+retArr1.length);
        if("000000".equals(retCode1)){
            if(retArr1.length>0){
                colNameArr = retArr1;
            }else{
                System.out.println("û�в鵽��ؼ�¼");
                %>
        			<script language='jscript'>
        				rdShowMessageDialog("û�в鵽��ؼ�¼��",0);
        				window.close();
        			</script>
                <%
            }
        }else{
            %>
    			<script language='jscript'>
    				rdShowMessageDialog("������룺<%=retCode1%>,������Ϣ��<%=retMsg1%>",0);
    				window.close();
    			</script>
            <%
        }
	    
		if (colNameArr != null && colNameArr.length>0)
		{
			if (colNameArr[0][0].equals("")) 
			{
				colNameArr = null;
				System.out.println("colNameArr = null");
			}
		}
		
    }catch(Exception e){
        e.printStackTrace();
        %>
			<script language='jscript'>
				rdShowMessageDialog("���÷���ʧ�ܣ�",0);
				window.close();
			</script>
        <%
    }
    
	//String[][] colNameArr = (String[][])retList.get(0);
	    
	    	    
	    
if (colNameArr != null && colNameArr.length>0)
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
<TABLE id="tab1" cellspacing="0">
	<tr>
		<th nowrap>
			���������
		</th>
		<th nowrap>
			����
		</th>
		<th nowrap>
			״̬
		</th>
	</tr>
</table>
<table cellspacing="0">
<tr id="footer">
	<td>
        <input type="button" name="back" class="b_foot" style="cursor:hand" onClick="doClose();" value=" �ر� ">
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
		str+='<input type="hidden" name="parterName" value="<%=colNameArr[i][1]%>">';
		str+='<input type="hidden" name="spTel" value="<%=colNameArr[i][2]%>">';
					
		var rows = document.getElementById("tab1").rows.length;
		var newrow = document.getElementById("tab1").insertRow(rows);
	  	newrow.insertCell(0).innerHTML = '<%=colNameArr[i][0]%>';
	  	newrow.insertCell(1).innerHTML = '<%=colNameArr[i][1]%>';
	  	newrow.insertCell(2).innerHTML = '<%=colNameArr[i][2]%>';
	  	
	<%}%>

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

