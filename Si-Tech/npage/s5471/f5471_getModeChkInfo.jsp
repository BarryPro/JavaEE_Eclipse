<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ��˼�¼��ѯ-���ݽ����ѯ��Ϣ
�� * �汾: v3.0
�� * ����: 2008-10-10
�� * ����: yangrq
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=GBK"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**��Ҫ�������.�������ҳ��,��ɾ��**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "5471";
 		String opName = "ɾ���ʷ��ײͰ��·���Ϣ";
		
		/**��ҪregionCode���������·��**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		
					
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("22222 checkSql->"+checkSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr1"  scope="end"/>
<%
		/**����loginRootDistance���жϹ���Ȩ������**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr1 !=null && sVerifyTypeArr1.length>0){
				loginRootDistance = sVerifyTypeArr1[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr1[0][0]);
				System.out.println("33333 loginRootDistance->"+loginRootDistance);
			}
		}					
		/** 
		 	*@inparam			audit_accept ������ˮ
			*@inparam			op_time_begin      ����ʱ�䣨����ʱ�䡢���޸�ʱ�䣩
			*@inparam			op_time_end      ����ʱ�䣨����ʱ�䡢���޸�ʱ�䣩
			*@inparam			opCode      ���淶Χ
			*@inparam			bill_type    Ʊ������
			*@inparam			prompt_type  ��ʾ����
			*@inparam			login_no     �����˹��ţ��������ˡ��޸��ˡ�ɾ���ˣ�
		 **/
		String mode_code = WtcUtil.repNull(request.getParameter("mode_code"));
		String begin_time = WtcUtil.repNull(request.getParameter("begin_time"));
		String region_code = WtcUtil.repNull(request.getParameter("region_code"));	
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));	
		String stream = WtcUtil.repNull(request.getParameter("stream"));	
		StringBuffer  getInfoSql = new StringBuffer();
		//String getInfoSql = "";	
			if(mode_code.equals(""))
			{				
					//getInfoSql.append("SELECT UNIQUE a.region_code, c.region_name, a.mode_code, b.offer_name,a.month_rent FROM smodechgchk a, product_offer b, sregioncode c WHERE a.active_flag = 'Y' AND a.region_code = '"+region_code+"' AND a.region_code = c.region_code AND to_number(a.mode_code) = b.offer_id");			
					getInfoSql.append("SELECT d.region_code,c.region_name,a.offer_id, b.offer_name, a.offer_attr_value FROM product_offer_attr a, product_offer b, region c, sregioncode d WHERE a.offer_id = b.offer_id AND a.offer_attr_seq = '50002' AND a.offer_id = c.offer_id AND b.offer_id = c.offer_id AND c.GROUP_ID = d.GROUP_ID AND d.region_code = '"+region_code+"'");
					System.out.println("getInfoSql====="+getInfoSql);									 		 	
			}
			else if(!mode_code.equals(""))
			{
					//getInfoSql.append("SELECT UNIQUE a.region_code, c.region_name, a.mode_code, b.offer_name,a.month_rent FROM smodechgchk a, product_offer b, sregioncode c WHERE a.active_flag = 'Y' AND a.region_code = '"+region_code+"' AND a.region_code = c.region_code AND to_number(a.mode_code) = b.offer_id and a.mode_code= '"+mode_code+"'");
					getInfoSql.append("SELECT d.region_code,c.region_name,a.offer_id, b.offer_name, a.offer_attr_value FROM product_offer_attr a, product_offer b, region c, sregioncode d WHERE a.offer_id = b.offer_id AND a.offer_attr_seq = '50002' AND a.offer_id = c.offer_id AND b.offer_id = c.offer_id AND c.GROUP_ID = d.GROUP_ID AND d.region_code = '"+region_code+"' AND a.offer_id ="+mode_code);
					System.out.println("getInfoSql====="+getInfoSql);										
			}	 										
		System.out.println("#######getInfoSql->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="9"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%			
System.out.println("retCode===="+retCode);
System.out.println("retMsg===="+retMsg);
System.out.println("sVerifyTypeArr.length=" + sVerifyTypeArr.length);
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
				/**��ѡ��ȫ��ѡ��**/
			function doSelectAllNodes(){
				document.all.sure.disabled=false;
				var regionChecks = document.getElementsByName("regionCheck");
				for(var i=0;i<regionChecks.length;i++){
					regionChecks[i].checked=true;
				}
				doChange();	
			}
			
			/**ȡ����ѡ��ȫ��ѡ��**/
			function doCancelChooseAll(){
				document.all.sure.disabled=true;
				var regionChecks = document.getElementsByName("regionCheck");
				for(var i=0;i<regionChecks.length;i++){
					regionChecks[i].checked=false;
				}
				doChange();				
			}
							
				function doChange(){
					document.all.sure.disabled=false;					
					parent.document.all.mode_code.disabled=true;
					parent.document.all.region_code.disabled=true;
					parent.document.all.region_name.disabled=true;
					parent.document.all.mode_name.disabled=true;	
					parent.document.all.opNote.disabled=true;				
				var regionChecks = document.getElementsByName("regionCheck");
				var impCodeStr = "";
				var tmpRegionStr = "";
				var regionLength=0;
				for(var i=0;i<regionChecks.length;i++){		
					if(regionChecks[i].checked){
					var impValue = regionChecks[i].value;
						var impArr = impValue.split("|");
						if(regionLength==0){
							tmpRegionStr = impArr[0];
							impCodeStr = impArr[2];
						}else{
							tmpRegionStr +=(","+impArr[0]);
							impCodeStr += (","+impArr[2]);								
						}
						regionLength++;
				}				
			}
			document.all.vRegionCode.value = tmpRegionStr;
			document.all.vModeCode.value = impCodeStr;
			if(document.all.vModeCode.value.length==0 || document.all.vRegionCode.value.length==0 )
			{
				document.all.sure.disabled=true;
			}		
		}
		function doConfirm(){
				var radioValue = document.all.vModeCode.value;
				var RegionCode = document.all.vRegionCode.value;
				var op_flag = document.all.op_flag.value;  
				var opNote = document.all.opNote.value;
				var begin_time = document.all.begin_time.value;
				var return_page = document.all.return_page.value;
				var stream = document.all.stream.value;
				var opName = document.all.opName.value;
				//alert(radioValue+"|"+RegionCode+"|"+op_flag+"|"+return_page+"|"+begin_time+"|"+opNote);
				window.location.href = "f5471_Cfm.jsp?mode_code="+radioValue+"&opNote="+opNote+"&region_code="+RegionCode+"&op_flag="+op_flag+"&return_page="+return_page+"&begin_time="+begin_time+"&stream="+stream+"&opName="+opName;
				}	
									
		//-->
	</script>
	
</head>
<body>	
	<div id="Operation_Table">
     <table cellspacing="0" id='t1'>
			<tr align="center">
				<th nowrap>ѡ��</th>
				<th nowrap>���д���</th>
				<th nowrap>��������</th>
				<th nowrap>�ʷѴ���</th>
				<th nowrap>�ʷ�����</th> 
				<th nowrap>�����</th>				
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>">
								<input type="checkbox" name="regionCheck" id="regionCheck" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>|<%=sVerifyTypeArr[i][2]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][4]%>" onclick="doChange()">	
							</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							</tr>
	<%				
				}
			}
	%>
  </table>
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	       <input type="button" name="allchoose"  class="b_text" value="ȫ��ѡ��" style="cursor:hand;" onclick="doSelectAllNodes()" >&nbsp;
	       <input type="button" name="cancelAll" class="b_text" value="ȡ��ȫѡ" style="cursor:hand;" onClick="doCancelChooseAll()" >&nbsp;				
				<input class="b_text" name="sure" type="button" value="ȷ  ��" style="cursor:hand;" onClick="doConfirm()" disabled>
				<input class="blue" name="vModeCode" type="hidden" >					
				<input class="blue" name="vRegionCode" type="hidden" >	
				<input type="hidden" name="begin_time" id="begin_time" value="<%=begin_time%>" >	
				<input name="op_flag" type="hidden"  id="op_flag" value="D">  				
				<input class="blue" name="opNote" type="hidden" value="<%=opNote%>">									
				<input class="blue" name="iOpCode" type="hidden" value="5471">	
				<input class="blue" name="opName" type="hidden" value="<%=opName%>">									
				<input class="blue" name="stream" type="hidden" value="<%=stream%>">									
				<input type="hidden" name="return_page" value="/npage/s5471/f5471_getModeChkInfo.jsp?region_code=<%=region_code%>&mode_code=<%=mode_code%>">
			</td>
	  </tr>
 </table>  
 	</div>
</body>
</html>  

