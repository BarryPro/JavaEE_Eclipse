<%
   /*���ƣ����ſͻ���Ŀ���� - ��ѯdParterOperation
�� * �汾: v1.0
�� * ����: 2007/2/7
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-24    qidp        �°漯�Ų�Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%

	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

	String parterId = request.getParameter("parterId");
	String checkdocId = request.getParameter("checkdocId");
	
	System.out.println("parterId = "+parterId);
	System.out.println("checkdocId = "+checkdocId);
	String opCode = "5648";
	String opName = "SI������ϵ��ѯ";

	ArrayList acceptList = new ArrayList();
	String[][] colNameArr = new String[][]{};

	System.out.println("######## parterId = "+parterId);
	try{
	%>
        <wtc:service name="s5648OperEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5" >
        	<wtc:param value="5648"/>
        	<wtc:param value="<%=workNo%>"/> 
        	<wtc:param value="<%=parterId%>"/>       	        		
        </wtc:service>
        <wtc:array id="retArr1" scope="end"/>
    <%
        if("000000".equals(retCode1)){
            if(retArr1.length>0){
                colNameArr = retArr1;
            }else{
                System.out.println("û�в鵽��ؼ�¼");
                %>
        			<script language='jscript'>
        				rdShowMessageDialog("û�в鵽��ؼ�¼��",0);
        			</script>
                <%
            }
        }else{
            %>
    			<script language='jscript'>
    				rdShowMessageDialog("������룺<%=retCode1%>,������Ϣ��<%=retMsg1%>",0);
    			</script>
            <%
        }
        
        if (colNameArr != null && colNameArr.length>0)
		{
			System.out.println("luxc:colNameArr"+colNameArr[0][0]);
			if ("".equals(colNameArr[0][0])) 
			{
				colNameArr = null;
			}
		}
		
    }catch(Exception e){
        e.printStackTrace();
        %>
			<script language='jscript'>
				rdShowMessageDialog("���÷���ʧ�ܣ�",0);
			</script>
        <%
    }
	//String[][] colNameArr = (String[][])acceptList.get(0);	
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<script language="javascript">
	//core.loadUnit("rpccore");
	onload=function()
	{
			//core.rpc.onreceive = doProcess;//Ϊfunction()��������������
	}
	
		function doProcess(myPacket)
	{
		var errCode    = myPacket.data.findValueByName("errCode");
		var retMessage = myPacket.data.findValueByName("errMsg");//�������ص���Ϣ
		var retFlag    = myPacket.data.findValueByName("retFlag");
				
		if (errCode==000000)
		{  
			if(retFlag=="queryMod")
			{			
				rdShowMessageDialog("�����ɹ���");
				window.parent.document.all.queryBusiBtn.onclick();
			}
		}
		
		//-----������ش������-----
		if(errCode!=000000)
		{
			rdShowMessageDialog(retMessage);	
		}
	}
	//��ʾ����ҵ����Ϣ���
	function showAddBusiInfo()
	{	
		tabAddBtn.style.display="none";
	}
	
	/************************ ����ҵ����Ϣ ***********************/
	function addCfm()
	{
		/****************** ͨ��У��  begin ********************/		
		if(!check(form1)) return false;	
				
		if(document.form1.oprEffTime.value == "")
		{
			rdShowMessageDialog("�����롰������Чʱ�䡱��");
			return false;
		}
				
		if(!validDate(document.all.oprEffTime))	return false;
		
		if(parseInt(document.all.oprEffTime.value) < parseInt("<%=strDate%>"))
		{
			rdShowMessageDialog("��������Чʱ�䡱����С��ϵͳ����ʱ�䣡");
			return false;
		}
		
		if(document.form1.provURL.value == "")
		{
			rdShowMessageDialog("�����롰SIProvision��URL����");
			return false;
		}
		
		if(document.form1.introURL.value == "")
		{
			rdShowMessageDialog("�����롰ҵ��Ľ�����ַ����");
			return false;
		}
						
		/****************** ͨ��У��  end ********************/		

		document.form1.action="f6312_modCfm.jsp?OprCode=01";
		document.form1.submit();					
	}
	
		//���
	function  queryMod(v_id)
	{				
			var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + v_id;
			var url="f5648_qry.jsp" + str;
			window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=auto,status=yes,location=no,menubar=no');
	}
	
	
	//��ʾĳ��ҵ����Ϣ
	function showInfo(v_id)
	{  
        //var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + v_id;
        //var path="f2896_showInfo.jsp" + str;
        var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + document.all.vflag.value;
        var path="../s2889/f2889_showInfo.jsp" + str;
		window.open(path,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=auto,status=yes,location=no,menubar=no');
	}

</script>

<body>
<form name="form1" method="post" action="">	
<input type="hidden" name="vflag" value="<%=checkdocId.trim()%>">
<input type="hidden" name="StartTime" value="">
<input type="hidden" name="EndTime" value="">
<input type="hidden" name="MOCode" value="">
<input type="hidden" name="CodeMathMode" value="">
<input type="hidden" name="MOType" value="">
<input type="hidden" name="DestServCode" value="">
<input type="hidden" name="ServCodeMathMode" value="">
<input type="hidden" name="bizType" value="">
<div id="Operation_Table">
	<%
	if(colNameArr!=null && colNameArr.length>0)
 	{	
	%>
	
	<TABLE width="100%" id="tabList" border=0 align="center" cellSpacing=0 bgcolor="#EEEEEE">			
	
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>
		<TABLE id="tabList" cellSpacing=0>			
			<tr>				
				<th nowrap align='center'>ҵ�����</th>
				<th nowrap align='center'>ҵ������</th>
				<th nowrap align='center'>����������</th>
				<th nowrap align='center'>ҵ������</th>
				<th nowrap align='center'>ҵ��״̬</th>
				<th nowrap align='center'>������ʽ</th>
			</tr>
	<%	
		int len = colNameArr.length;	
		for(int i = 0; i < len; i++)
		{		  
		System.out.println("iiiiiiiiiiiiiiiii="+len);
		System.out.println("iiiiiiiiiiiiiiiii="+colNameArr[0].length);
	%>			
			<tr id="tr<%=i+1%>">
				<input type="hidden" name="operId<%=i+1%>" value="<%=colNameArr[i][0].trim()%>">
				<input type="hidden" name="parterId<%=i+1%>" value="<%=colNameArr[i][2].trim()%>">
							
				<td nowrap align='center'><a style="CURSOR: hand; TEXT-DECORATION: none" href="javascript:showInfo(<%=i+1%>)"><%=colNameArr[i][0].trim()%></a></td>
				<td nowrap align='center'><%=colNameArr[i][1].trim()%></td>
				<td nowrap align='center'><%=colNameArr[i][2].trim()%></td>
				<td nowrap align='center'><%=colNameArr[i][3].trim()%></td>
				<td nowrap align='center'><%=colNameArr[i][4].trim()%></td>
				<td nowrap align='center'>
			        <input name="operator<%=i+1%>" style="cursor:hand" type="button" value="��ѯ" class="b_text" onclick="queryMod(<%=i+1%>)">		
				
				</td> 
			</tr>
			
	<%
		}
	%>		
		</TABLE>
<%}%>		
	
	 	   	
	</div>   
</form>
</body>
</html>

           