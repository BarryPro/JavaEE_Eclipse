<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
      String opCode = "zg03";
	  String opName = "�������г�ֵ����";
	  String s_region_code=request.getParameter("s_region_code");
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  System.out.println("AAAAAAAAAAAAAAAAAAAaaa s_region_code is "+s_region_code);
	  //��ҳ
	  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	  int iPageSize = 20;
	   
	  //��ʼ ���� 
	  String s_dis_code= request.getParameter("s_dis_code");	
	  
	  String region_name =  request.getParameter("region_name");
	  String dis_name    =  request.getParameter("dis_name");

	  String ret_val[][];
	  String ret_val_new[][];
	  String[] inParas2 = new String[5];
 
	  inParas2[0]=workno;
	  inParas2[1]=s_region_code;
	  inParas2[2]=s_dis_code;
	  inParas2[3]= "" + iPageNumber;
	  inParas2[4]="" + iPageSize;
	  
 
%>
<wtc:service name="szg03Qry1" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="6">
		    <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
			<wtc:param value="<%=inParas2[2]%>"/>
			<wtc:param value="<%=inParas2[3]%>"/>
			<wtc:param value="<%=inParas2[4]%>"/>
</wtc:service>
<wtc:array id="mainInfo0"  start="0" length="2" scope="end"/>
<wtc:array id="mainInfo1"  start="2" length="2" scope="end"/>
<wtc:array id="mainInfo2"  start="4" length="2" scope="end"/>
<%
		String errCode = retCode2;
		String errMsg = retMsg2;
	 
		String[][] result1  = null ;
 
		result1 = mainInfo1; 
		int nowPage = 1;
		int allPage = 0;
		
		if(retCode2.equals("0")||retCode2.equals("000000"))
		{
			System.out.println("CCCCCCCCCCCCCCCCxxxxxxxxxxxxxxxxxxxxxxCCCCCCCCC �ɹ�"+result1.length);
			allPage = (Integer.parseInt(mainInfo2[0][0])- 1) / 20 + 1 ;//ҳ���� ����ҲҪ��
			%>
				 
				<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD><TITLE>��ѯ���</TITLE>
				</HEAD>
				<body onload="inits()">


				<FORM method=post name="frm1508_2">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">��ѯ���</div>
				</div>

					  <table cellspacing="0" id = "PrintA">
								<tr> 
								 
									<th>����</th>
									<th>����</th>
								 
									<th>�������ֻ�����</th>
									<th>�������˺�</th>
									 
									<th  >���� 
										<input type="checkbox" id="check_all_id" onclick="doSelectAllNodes()">ȫѡ &nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="check_not_id" onclick="doCancelChooseAll()">ȡ��ȫѡ 
									</th>
							<%
								for(int i=0;i<result1.length;i++)
								{
									%>
										<tr>
											 
											<td><%=region_name%></td>
											<td><%=dis_name%></td>
											 
											<td><%=result1[i][0]%></td>
											<td><%=result1[i][1]%></td> 
											<input type="hidden" id="phone_nos<%=i%>" value="<%=result1[i][0]%>" >
											<input type="hidden" id="contract_nos<%=i%>" value="<%=result1[i][1]%>" >
											<td>
											<input type="checkbox" id=checkbox<%=i%> name="regionCheck">
											</td>
										</tr>
									<%
								}
							%>

						 
						
						  <tr id="footer"> 
							<td colspan="9">
							  <input class="b_foot"  onClick="deletes_more()" type=button value=¼��>	
						 
							  <input class="b_foot" name=back onClick="window.location = 'zg03_1.jsp' " type=button value=����>
							  <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
							</td>
						  </tr>
						  
					  </table>
					 
					<!--��ҳ-->
					<div align="center">
						<table align="center">
						<tr>
							<td align="center">
								�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=mainInfo2[0][0]%></font>&nbsp;&nbsp;
								��ҳ����<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
								��ǰҳ��<font name="currentPage" id="currentPage"><%=mainInfo2[0][1]%></font>&nbsp;&nbsp;
								ÿҳ������20 
								 
								&nbsp;&nbsp;��ת��
								<select name="toPage" id="toPage" style="width:80px" onchange="gotos(this.value,'<%=mainInfo2[0][0]%>');">
										<%
										 
										for (int i = 1; i <= allPage; i ++){
											
											if(iPageNumber==i){
												//System.out.println("aaaaaaaaaaaaaaaaaaaa "+i);
												%>
												<option value="<%=i%>" selected >
													��<%=i%>ҳ
												</option>	
												<%
											}else{
												
												%>
													<option value="<%=i%>">��<%=i%>ҳ</option>
												<%
												}
										%>
										
									
									<%}%>
									</select>
								ҳ
							</td>
						</tr>
						</table>
					</div>
					<!--end ��ҳ-->	
							
				<input type="hidden" id="nowPage" />
				<input type="hidden" id="allPage" value="<%= allPage %>" />		

				<%@ include file="/npage/include/footer.jsp" %>
				</FORM>
				</BODY></HTML>
			<%
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("��ѯ���Ϊ�գ�");
					window.location.href="zg03_1.jsp";
				</script>
			<%
		}
%>	 
<script language="javascript">
	
	function inits()
	{
		//alert("1");
		document.getElementById("toPage").disabled=false;
		//alert("2");
	}

	 
	
	function deletes_more()
	{
		var idArrays=[];
		var conArrays=[];
		var len = "";
		len=document.all.regionCheck.length;
		var check_flag=0;
		if(len==undefined)
		{
			//id_nos
			var id_no=document.getElementById("phone_nos"+i).value;
			idArrays.push(id_no);
			//alert("ʲô��� "+idArrays);
			check_flag=1;
		}
		else
		{
			for (i = 0; i < len; i++)
			{
				if (document.all.regionCheck[i].checked == true) 
				{
					var phone_no=document.getElementById("phone_nos"+i).value;
					idArrays.push(phone_no);
					 
					var contract_no=document.getElementById("contract_nos"+i).value;
					conArrays.push(contract_no);
					check_flag=1;
				}
			}
		}
		if(check_flag==1)
		{
			//alert("phone_no is "+idArrays+" and conArrays is "+conArrays);
			var url="zg03_3.jsp?phone_arrays="+idArrays+"&conArrays="+conArrays;
			var url_new =url;//URLencode(url);
			//alert(url_new);
			document.frm1508_2.action=url_new;
			var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ�����β�����");
			if (prtFlag==1)
			{
				//alert("bizcodeArrays is "+bizcodeArrays);
				document.frm1508_2.submit();  
			}
			else
			{
				return false;
			}
		}
	}
	function gotos(page,total_1)
	{
		document.getElementById("toPage").disabled=true;
		window.location.href="zg03_2.jsp?pageNumber="+page+"&s_region_code="+"<%=s_region_code%>"+"&s_dis_code="+"<%=s_dis_code%>"+"&region_name="+"<%=region_name%>"+"&dis_name="+"<%=dis_name%>"; 
	}
	
	//ȫѡ
	function doSelectAllNodes()
	{
		//document.all.sure.disabled=false;
		if(document.getElementById("check_all_id").checked)
		{
			var regionChecks = document.getElementsByName("regionCheck");
			for(var i=0;i<regionChecks.length;i++){
				regionChecks[i].checked=true;
			}
		}
		
		 
	}
	//ȡ��ȫѡ
	function doCancelChooseAll()
	{
		if(document.getElementById("check_not_id").checked)
		{
			var regionChecks = document.getElementsByName("regionCheck");
			for(var i=0;i<regionChecks.length;i++){
				regionChecks[i].checked=false;
			}
		}	
	}
	function getId(id_no)
	{
		alert(id_no);
	}
</script> 
 


