<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String op_code="9127";
	String op_name = "SP������ϵ��ѯ";
	String opCode = op_code;
	String opName = op_name;
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	//String[][] baseInfoSession = (String[][])arrSession.get(0);
	//String[][] fiveInfoSession = (String[][])arrSession.get(4);
	String workpw = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	
	
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("z")||workNo.substring(0,1).equals("Z"))
		workNoFlag=true;
	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	
	int rows=0;
	String errcode="000000";
	String errmsg="";
	String[][] result0=null;
	String[][] result1=null;
	String[][] result2=null;
	String phoneNo = "" ;
	String bizType= "" ;
	String spCode="";
	String spBizCode="";
	String ipAddr=request.getRemoteAddr();;
	String opNote = "";
	String beginPos=String.valueOf(iStartPos);
	String MaxNum=String.valueOf(iPageSize);
	String disPlay = request.getParameter("disPlay") ;
	
	
	if("yes".equals(disPlay)){
		//���Ƶ�һ�β���ʾ
		phoneNo=request.getParameter("phoneNo") ; 
		bizType=request.getParameter("bizType") ; 
		spCode=request.getParameter("spCode") ;
		spBizCode=request.getParameter("spBizCode") ;
%>
		<wtc:service name="s9127Qry" outnum="43" routerKey="phone" routerValue="<%=phoneNo%>">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=workpw%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=org_code%>"/>
			<wtc:param value="<%=bizType%>"/>
			<wtc:param value="<%=spCode%>"/>
			<wtc:param value="<%=spBizCode%>"/>
			<wtc:param value="<%=ipAddr%>"/>
			<wtc:param value="<%=opNote%>"/>
			<wtc:param value="<%=beginPos%>"/>
			<wtc:param value="<%=MaxNum%>"/>
		</wtc:service>
		<wtc:array id="r0" start="0" length="3" scope="end" />
		<wtc:array id="r1" start="3" length="6" scope="end" />
		<wtc:array id="r2" start="6" length="37" scope="end" />
<%
		errcode=retCode;
		errmsg=retMsg;
		result0=r0;
		result1=r1;
		result2=r2;
	}
	
	if(!errcode.equals("000000"))
	{
%>
		<script language='jscript'>
			rdShowMessageDialog('<%=errmsg%>' + '[' + '<%=errcode%>' + ']',0);
			history.go(-1);
		</script>
<%
	}else{
		
		
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>

<script language="javascript">
	onload=function()
	{
<%
		if(workNoFlag){
%>
			document.all.phoneNo.value="<%=userPhoneNo%>";
			document.all.phoneNo.readOnly=true;
			document.all.qryBtn.focus();
<%  	
		}
%>  
	}


	function doCheck(){
		if(!check(document.form)){
			return false;			
		}
		document.form.action="f9127_1.jsp";
		document.form.submit();
	}
	
	function spCodeQry(){
		var bizType=document.all.bizType.value;
		if(bizType.length<=0){
	    	rdShowMessageDialog("����ѡ��ҵ�����ͣ�",0);
	    	return false;
	    }
		var pageTitle = "SP��ҵ��Ϣ��ѯ";
		var fieldName = "sp��ҵ����|sp��ҵ����|sp��ҵӢ������|";
		var selType = "S";    //'S'��ѡ��'M'��ѡ
		var retQuence = "1|0|";
		var retToField = "spCode|";
		var sqlStr ="select a.SPID,decode(a.SPNAME,null,a.spshortname,a.SPNAME) SPNAME,a.spenname from DDSMPSPINFO a,sOBSpType b where trim(a.spid) between b.beginspid and b.endspid and a.SPSTATUS='A' and a.BIZTYPE= :bizType and a.spid in (select distinct c.spid from DDSMPSPBIZINFO c where c.BIZSTATUS='A') order by a.SPID";
		var varStr="bizType="+bizType;
		var serviceName="TlsPubSelCen";
		var routerKey="region";
		var routerValue="<%=regionCode%>";
		if(PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue));
	}
	
	function spBizCodeQry(){
		var spCode=document.all.spCode.value;
		if(spCode.length<=0){
	    	rdShowMessageDialog("��������SP��ҵ���룡",0);
	    	return false;
	    }
	    var pageTitle = "SPҵ����Ϣ��ѯ";
		var fieldName = "spҵ�����|spҵ������|ҵ������|";
		var sqlStr ="select b.bizcode,b.servname,b.BIZDESC from DDSMPSPINFO a,DDSMPSPBIZINFO b where  a.SPID=b.SPID and  b.BIZSTATUS='A' and a.SPID=:spid order by b.bizcode";
		var varStr="spid="+spCode;
		var selType = "S";    //'S'��ѡ��'M'��ѡ
		var retQuence = "1|0|";
		var retToField = "spBizCode|";
		var serviceName="TlsPubSelCen";
		var routerKey="region";
		var routerValue="<%=regionCode%>";
		if(PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue));
	}
	
function spBizQry(){
	var bizType=document.all.bizType.value;
	var spBizCode= document.all.spBizCode.value;
	var spCode= document.all.spCode.value;
	if(bizType=="00"){
		rdShowMessageDialog("��ѡ��ҵ�����ͣ�");
		return false;
	}
	if(spCode==""){
		rdShowMessageDialog("��ѡ��SP���룡");
		return false;
	}
	var path ="../s9126/f9126_1.jsp?bizType="+bizType+"&spCode="+spCode+"&spBizCode="+spBizCode+"&ifCall=true";
	window.open(path,"newwindow","height=450, width=790,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
}

function spQry(){
	var bizType=document.all.bizType.value;
	var spCode= document.all.spCode.value;
	if(bizType=="00"){
		rdShowMessageDialog("��ѡ��ҵ�����ͣ�");
		return false;
	}
	var path ="../s9125/f9125_1.jsp?bizType="+bizType+"&spCode="+spCode+"&ifCall=true";
	window.open(path,"newwindow","height=450, width=790,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");	
}
function doReset(){
	document.all.phoneNo.value="";
	document.all.spCode.value="";
	document.all.spBizCode.value="";
	document.all.bizType.value="";
}
	
</script>
</HEAD>

<body>
<form  method=post name="form" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">SP������ϵ��ѯ</div>
</div>
	<input type="hidden" name="disPlay"  value="yes">
	
<table cellspacing="0">
		<tr> 
			<td class=blue>�ֻ�����</td>
			<td>
				<input type="text" name="phoneNo" maxlength="11" value="<%=phoneNo%>" v_must="1" v_type="mobphone" >
				<font class="orange">*</font>
			</td>
			<td class=blue>ҵ������</td>
			<td>
				<select name="bizType"  class="button">
                	<option value="">---ȫ��---</option>
					<wtc:qoption  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="2" value="<%=bizType%>">
	            		<wtc:sql>
	            			select oprcode,oprname from sOBBizType where regtype='0' order by oprcode asc
	            		</wtc:sql>
	            	</wtc:qoption>
	            </select>
			</td>
		</tr>
		<tr> 
			<td class=blue>SP��ҵ����</td>
			<td>
				<input type="text" name="spCode" value="<%=spCode%>" v_must="0" v_type="string">
				<input type="button" class="b_text" name="spCodeBtn" value="��ѯ" onclick="spQry()" >
			</td>
			<td class=blue>SPҵ�����</td>
			<td>
				<input type="text" name="spBizCode" value="<%=spBizCode%>" v_must="0" v_type="string">
				<input type="button" class="b_text" name="spBizCodeBtn" value="��ѯ" onclick="spBizQry()" >
			</td>
		</tr>
		<tr id="footer"> 
			<td colspan="4" align="center">
				<input type="button" name="qryBtn" class="b_foot" value="��ѯ" onclick="doCheck()">
				&nbsp;&nbsp;
				<input type="button" name="qryBtn" class="b_foot" value="����" onclick="doReset()">
			</td>
		</tr>
	</table>
	</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>
<table cellspacing="0">
		<tr>
			<th>���</th>
			<th>SP����</th>
			<th>SP����</th>
			<th>ҵ�����</th>
			<th>ҵ������</th> 
			<th>�Ʒ�����</th>
			<th>����</th>
			<th width="70">��Чʱ��</th>
			<th>��ϵ״̬</th>
			<th width="70">����ʱ��</th>
			<th>��������</th>
			<th>�����ͺ���</th>
			<th>�ֻ�����</th>
			<th>��������</th>
		</tr>
	<%
		
		if(result2 != null){
			rows=result2.length;
		}
		if(rows<1){
	%>
		<tr><td colspan="14" align = "center"><b><font class="orange">�޲�ѯ���</font></td></tr>
	<%
		}
			
		for(int i=0;i<rows;i++){
		    String tdClass = "";            
            if (i%2==0){
                 tdClass = "Grey";
            }
	%>
		<tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';this.style.cursor='hand'">
			<%if(Integer.parseInt(result2[i][19].trim())==0||Integer.parseInt(result2[i][19].trim())==2){%>
			<td class="<%=tdClass%>"><%=(iStartPos+i+1)%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][6]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][7]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][8]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][9]%>&nbsp;</td> 
			<td class="<%=tdClass%>"><%=result2[i][20]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][24]%>Ԫ/��</td>
			<td class="<%=tdClass%>" width="70"><%=result2[i][13]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][11]%>&nbsp;</td>
			<td class="<%=tdClass%>" width="70"><%=result2[i][14]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][16]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][17]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][2]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][35]%>&nbsp;</td>
			<%}else{%>
			<%}%>
		</tr>
	<%
		}
	%>
		<tr id="footer">
			<td colspan="13" align="right" >
				<%
					int iQuantity=0;
					if(result1!=null){
					    iQuantity = Integer.parseInt(result1[0][0]);
					}
				    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
					PageViewCn view = new PageViewCn(request,out,pg); 
				   	view.setVisible(true,true,0,1);       
				%>
			</td>
		</tr>
	</table>
	
	<%@ include file="/npage/include/footer.jsp" %>
	
	</form>
	</BODY>
</HTML>

<%}%>
