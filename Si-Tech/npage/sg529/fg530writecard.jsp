<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		
		String workNo = (String)session.getAttribute("workNo");
		String work_name =(String)session.getAttribute("workName");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
	
		String idIccid = request.getParameter("idIccid");
		String cus_pass = request.getParameter("cus_pass");
		String opnote =workNo+"����g530д�������ѯ";


%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
     <wtc:service name="sg530Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="20">
        <wtc:param value="<%=loginAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="g530"/>
        	<wtc:param value="<%=workNo%>"/>
        	<wtc:param value="<%=password%>"/>
         	<wtc:param value=""/>
        	<wtc:param value=""/>
        	<wtc:param value="<%=opnote%>"/>
        		<wtc:param value="0"/>
        </wtc:service>
        <wtc:array id="dcust2" scope="end" />
<%
/*System.out.println("--wanghyd"+dcust2.length);*/
%>

<body>
	<form name="frm" method="post" action="fg530writecardsub.jsp">
		<%@ include file="/npage/include/header.jsp" %>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">�����ۿ�����-д��</div>
			</div>

							<table >
									<tr >
											
								<th>�ֻ�����</th>
								<th>����״̬</th>
								<th>�û�����</th>
								<th>sim����</th>
								<th>��Ƭ����</th>
								<th>sim������</th>
								<th>֤������</th>
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							   for(int i=0;i<dcust2.length; i++) {
							%>
							<tr> 
								
 					
 						<td width="8%"><a  href="<%=request.getContextPath()%>/npage/sg529/fg530writecard2.jsp?opCode=<%=opCode%>&groupids=<%=dcust2[i][3]%>&opName=<%=opName%>&phoneNO=<%=dcust2[i][0]%>&kehuxingming=<%=dcust2[i][4]%>&zhengjianmingcheng=<%=dcust2[i][11]%>&zhengjianhaoma=<%=dcust2[i][5]%>&simming=<%=dcust2[i][9]%>&haomaguishu=<%=dcust2[i][10]%>&dingdanzhuangtai=<%=dcust2[i][8]%>&kehudizhi=<%=dcust2[i][12]%>&simtype=<%=dcust2[i][2]%>&kapianhaoma=<%=dcust2[i][6]%>&yonghubianma=<%=dcust2[i][7]%>&simnono=<%=dcust2[i][1]%>&offerids=<%=dcust2[i][13]%>&offernames=<%=dcust2[i][14]%>&offfercomments=<%=dcust2[i][15]%>"><%=dcust2[i][0]%></a></td>
 						<td width="10%"><%if(dcust2[i][8].equals("1")) {out.print("����δ֧��");}if(dcust2[i][8].equals("2")) {out.print("����֧���ɹ�");}if(dcust2[i][8].equals("3")) {out.print("�������ʼ�");}if(dcust2[i][8].equals("4")) {out.print("������ʱ");}%></td>
 						<td width="8%"><%=dcust2[i][7]%></td>
 						<td width="10%"><%=dcust2[i][1]%></td>
 						<td width="10%"><%=dcust2[i][6]%></td>
 						<td width="5%"><%=dcust2[i][2]%></td>
 						<td width="10%"><%=dcust2[i][5]%></td>
						  </tr>
						  		<%
		    }
		    %>
		    	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input class="b_foot" type="button" name="b_return" value="����" onmouseup="doreturn()" />
			</div>
			</td>
		</tr>
	</table>
	<%
		    }
		  else {
		%>
		<tr height='25' align='center'><td colspan='7'>��ѯ��ϢΪ�գ�</td></tr>
		<tr height='25' align='center'><td colspan='7'><input class="b_foot" type="button" name="b_return" value="����" onmouseup="doreturn()" /></td>
					</tr>
<%}}else {
			%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
					</script>
					<tr height='25' align='center'><td colspan='7'>��ѯ��ϢΪ�գ�</td>
						
					</tr>
										<tr height='25' align='center'><td colspan='7'><input class="b_foot" type="button" name="b_return" value="����" onmouseup="doreturn()" /></td>
					</tr>
					
					<%
	}%>
						</table>
					</div>
				</div>
 <%@ include file="/npage/include/footer.jsp" %>

</form>
</body>
</html>
<script language="javascript">

	function writechg(obj){
		document.all.b_write.disabled=true;
		var phonenos="";
		var simnos="";
		var simtypes="";
		var groupids="";
		var phonesnames="";
		var smssarry= new Array();
		
						 var radio1 = document.getElementsByName("opFlag");
							  for(var i=0;i<radio1.length;i++)
				  {
				    if(radio1[i].checked)
					{
					  var opFlag = radio1[i].value;
					  smssarry =opFlag.split(",");
					  phonenos=smssarry[0];
					   simnos=smssarry[1];
					    simtypes=smssarry[2];
					    groupids=smssarry[3];
					    phonesnames=smssarry[4];

					}
					}
					
					if(phonenos.trim()=="") {
						rdShowMessageDialog("��ѡ��һ����в�����",0);
						document.all.b_write.disabled=false;
						return false;
						}
					//alert(phonenos+"--"+simnos+"--"+simtypes+"--"+groupids+"--"+phonesnames);	
						//billdeal('13333333333','��С��','33333');
						//location = location;
						//return false;
						
		/*			
    var path = "<%=request.getContextPath()%>/npage/sg529/fg529_fwritecard.jsp";
    path = path + "?regioncode=" + "<%=regionCode%>";
    path = path + "&sim_type="+simtypes;
    path = path + "&sim_no="+simnos;
    path = path + "&op_code=" +"<%=opCode%>";
    path = path + "&phone="+phonenos+"&pageTitle=" + "д��";
    path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; 
    var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    
    if(typeof(retInfo) == "undefined"){	
    	rdShowMessageDialog("д��ʧ��",0);
    	 document.all.b_write.disabled=false;
    	return false;   
    } 
    var retsimcode=oneTok(oneTok(retInfo,"|",1));
    var retsimno=oneTok(oneTok(retInfo,"|",2));
    var cardstatus=oneTok(oneTok(retInfo,"|",3));
    var cardNo=oneTok(oneTok(retInfo,"|",4));
    */
    var retsimcode="0";
    var retsimno="89860070089810966258";
    var cardstatus="00";
    var cardNo="0806001650003224";
    
    if(retsimcode=="0"){
      rdShowMessageDialog("д���ɹ�");
  
    var myPacket = new AJAXPacket("fg530writecardsub.jsp","�������д����Ϣ���Ժ�......");
		myPacket.data.add("cardNo",cardNo);
		myPacket.data.add("simtypes",simtypes);
		myPacket.data.add("simnos",simnos);
		myPacket.data.add("phonenos",phonenos);
		myPacket.data.add("groupids",groupids);
		myPacket.data.add("phonesnames",phonesnames);
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
		
    }else{
      
      rdShowMessageDialog("д��ʧ��,0");
      document.all.b_write.disabled=false;
    }
  }

				function doSetStsDate(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(retcode=="000000"){
				 rdShowMessageDialog("����ɹ�����ʼ��ӡ��Ʊ��");
				 var liushui1 = packet.data.findValueByName("liushui");
				 var phonesno = packet.data.findValueByName("phonesno");
				
				 billdeal(phonesno,phonesnames,liushui1);
				// location = location;
			
		}else {
				 rdShowMessageDialog("����ʧ�ܣ��������"+retcode+"������ԭ��"+retmsg,0);
		}
		document.all.b_write.disabled=false;//д���ɹ����ύ
	}						  	

		function doreturn(){
			window.location.href = "fg530.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			//location = location;
			
		}
		
		function billdeal(phoneno,phonenames,liushui){

  var infoStr="";	
	infoStr+="<%=workNo%>  <%=work_name%>"+"       ��ͨ����"+"|";//����
	infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	infoStr+=phonenames+"|";
	infoStr+=" "+"|";
	infoStr+=phoneno+"|";
	infoStr+=" "+"|";//Э�����
	infoStr+=" "+"|";
	
	infoStr+="��ʰԪ��"+"|";//�ϼƽ��(��д)
	infoStr+="50"+"|";//Сд
	infoStr+="SIM���ѣ�0Ԫ~����Ԥ��ѣ�50Ԫ"+"|";
	
	infoStr+="<%=work_name%>"+"|";//��Ʊ��
	infoStr+=" "+"|";//�տ���
	infoStr+=" "+"|";//�տ���
	
	infoStr+=" "+"|";
	dirtPate = "/npage/sg529/fg530writecard.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=opCode%>&loginAccept="+liushui+"&dirtPage="+codeChg(dirtPate);
	

}
</script>