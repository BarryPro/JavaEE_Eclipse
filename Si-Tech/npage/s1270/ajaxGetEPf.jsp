<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%System.out.println("----------------------------ajaxGetEPf.jsp--------�Ѵ��������ַ���������۽ӻ�ȥ----------------------------");  %>

<%
	String offerIdv = WtcUtil.repNull(request.getParameter("offerIdv"));
	String opCodev = WtcUtil.repNull(request.getParameter("opCode"));
	String regionCode = (String)session.getAttribute("regCode");
	
	String xqJf = WtcUtil.repNull(request.getParameter("xqJf"));
	
	System.out.println("С���ʷ�|======"+xqJf);
	
	if(opCodev==null||"".equals(opCodev)){
		opCodev = "1270";
	}
	
	String workNo = (String)session.getAttribute("workNo");
	
	String retResultStr = "";
	String descResultStr = "";
	String resultFlag="";
 	
 	String newZOfferECode  = "";  //���������ʷѶ�������
 	String newZOfferDesc   = "";  //���������ʷ�����
 	String dOfferId        = "";  //���ں�ִ���ʷ�Id
 	String dOfferName      = "";  //���ں�ִ���ʷ�Name
 	String dECode          = "";  //���ں��������
 	String dOfferDesc      = "";  //���ں��ʷ�����
 	String xq_name         = "";  //С������
 	
 	
 	System.out.println("-------------offerIdv----------------------"+offerIdv);
 	System.out.println("-------------workNo------------------------"+workNo);
 	System.out.println("-------------opCodev-----------------------"+opCodev);
 	System.out.println("-------------xqJf--------------------------"+xqJf);
 	
 	
		if(!offerIdv.equals("")&&offerIdv!=null){
%>

    <wtc:service name="sGetDetailCode" outnum="9" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=offerIdv%>" />
			<wtc:param value="<%=workNo%>" />	
			<wtc:param value="<%=opCodev%>" />	
			<wtc:param value="<%=xqJf%>" />	
		</wtc:service>
		<wtc:array id="result_t33" scope="end"   />

<%
		if(code.equals("000000") && result_t33.length > 0){
			for(int j=0;j<result_t33.length;j++){
				
				if(retResultStr+result_t33[j][2]!=null&&(!result_t33[j][2].equals(""))){
						retResultStr = retResultStr+" ���������ʷѶ������룺"+result_t33[j][2]+"|";
						newZOfferECode = result_t33[j][2];
					}
					
					descResultStr+=" ���������ʷ�������";
				if(retResultStr+result_t33[j][3]!=null&&(!result_t33[j][3].equals(""))){
						descResultStr += result_t33[j][3];
						newZOfferDesc = result_t33[j][3];
					}
				descResultStr+="|";
				
				if(retResultStr+result_t33[j][4]!=null&&(!result_t33[j][4].equals("")))	{
						retResultStr = retResultStr+" ���ں�ִ���ʷѣ�"+result_t33[j][4];
						dOfferId = result_t33[j][4];
					}
				
				if(retResultStr+result_t33[j][6]!=null&&(!result_t33[j][6].equals("")))	{
						retResultStr+= " "+result_t33[j][6];
						dOfferName = result_t33[j][6];
					}
					
				if((retResultStr+result_t33[j][4]!=null&&(!result_t33[j][4].equals("")))||(retResultStr+result_t33[j][6]!=null&&(!result_t33[j][6].equals(""))))	
					retResultStr += "|";	
					
				if(retResultStr+result_t33[j][5]!=null&&(!result_t33[j][5].equals(""))){		
						retResultStr = retResultStr+" ���ں�������룺"+result_t33[j][5]+"|";
						dECode = result_t33[j][5];
					}
				
				if(retResultStr+result_t33[j][7]!=null&&(!result_t33[j][7].equals(""))){
					descResultStr+= " ���ں��ʷ�������"+result_t33[j][7]+"|";
					dOfferDesc = result_t33[j][7];
					}
					
				if(retResultStr+result_t33[j][8]!=null&&(!result_t33[j][8].equals(""))){
					xq_name = result_t33[j][8];
				}
			}
		}else {
		   resultFlag="none";
		}
	}
	System.out.println("---------------retResultStr---------------"+retResultStr);
	System.out.println("---------------descResultStr--------------"+descResultStr);
	System.out.println("---------------newZOfferECode--------------"+newZOfferECode);
		
	retResultStr = retResultStr.replaceAll("\r\n","</br>");  
	retResultStr = retResultStr.replaceAll("\r","</br>"); 
	retResultStr = retResultStr.replaceAll("\n","</br>"); 
	retResultStr = retResultStr.replaceAll("\"","&quot;"); 
	retResultStr = retResultStr.replaceAll("\'","&quot;"); 
	
	descResultStr = descResultStr.replaceAll("\r\n","</br>");  
	descResultStr = descResultStr.replaceAll("\r","</br>"); 
	descResultStr = descResultStr.replaceAll("\n","</br>"); 
	descResultStr = descResultStr.replaceAll("\"","&quot;"); 
	descResultStr = descResultStr.replaceAll("\'","&quot;"); 
	
	
	newZOfferDesc = newZOfferDesc.replaceAll("\r\n","</br>");  
	newZOfferDesc = newZOfferDesc.replaceAll("\r","</br>"); 
	newZOfferDesc = newZOfferDesc.replaceAll("\n","</br>"); 
	newZOfferDesc = newZOfferDesc.replaceAll("\"","&quot;"); 
	newZOfferDesc = newZOfferDesc.replaceAll("\'","&quot;"); 
	
	dOfferDesc = dOfferDesc.replaceAll("\r\n","</br>");  
	dOfferDesc = dOfferDesc.replaceAll("\r","</br>"); 
	dOfferDesc = dOfferDesc.replaceAll("\n","</br>"); 
	dOfferDesc = dOfferDesc.replaceAll("\"","&quot;"); 
	dOfferDesc = dOfferDesc.replaceAll("\'","&quot;"); 
%>

var response = new AJAXPacket();
response.data.add("resultFlag","<%=resultFlag%>");
<%if(!resultFlag.equals("none")){%>
response.data.add("retResultStr","<%=retResultStr%>");
response.data.add("descResultStr","<%=descResultStr%>");  
response.data.add("newZOfferECode","<%=newZOfferECode%>"); 
response.data.add("newZOfferDesc","<%=newZOfferDesc%>"); 
response.data.add("dOfferId","<%=dOfferId%>"); 
response.data.add("dOfferName","<%=dOfferName%>"); 
response.data.add("dECode","<%=newZOfferECode%>"); 
response.data.add("dOfferDesc","<%=dOfferDesc%>"); 
response.data.add("xq_name","<%=xq_name%>"); 

<%}%>
core.ajax.receivePacket(response);




