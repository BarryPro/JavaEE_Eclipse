<%
/********************
 *������: si-tech
 *��ͨ��Ʊ
 *create by ningtn @ 20111026
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%!
 public String oneTok(String str,int loc){
  
		   String temStr="";
		   temStr=str;
		   if(str.charAt(0)=='|')  temStr=str.substring(1,str.length());
		   
		   if(str.charAt((str.length())-1)=='|')  temStr=temStr.substring(0,(temStr.length()-1));
		    
		
			 int temLoc;
			 int temLen;
			 
		    for(int ii=0;ii<loc-1;ii++)
			{
		       temLen=temStr.length();
		       temLoc=temStr.indexOf("|");
		       temStr=temStr.substring(temLoc+1,temLen);
		 	}
			if(temStr.indexOf("|")==-1)
			  return temStr;
			else
		    return temStr.substring(0,temStr.indexOf("|"));
		    }
%>
<%
System.out.println("===================== ningtn hljCrmPDPrintPublic.jsp ====");
		String work_no_bill =(String)session.getAttribute("workNo");
		String org_code_bill =(String)session.getAttribute("orgCode");
		String regionCode_bill = org_code_bill.substring(0,2);
		String regionCode = org_code_bill.substring(0,2);
		//qucc---add
		String groupId = (String) session.getAttribute("groupId");//ȡӪҵ����
		String loginAccept = request.getParameter("loginAccept");
		String op_code = request.getParameter("op_code");
		String retInfo=request.getParameter("retInfo");
		String dirtPage=request.getParameter("dirtPage");
		String infoStr="";
		infoStr=retInfo;
		String print_workNo = "";
		String print_accept = "";
		String print_opName = "";
		String printMessage = oneTok(retInfo,1);
	 
		if(printMessage.length()>0){
		    String resSplitMsg[] = printMessage.split("\\s{1,}")  ;
		    if(resSplitMsg.length==3){
		      print_workNo = resSplitMsg[0];
	        print_accept = resSplitMsg[1];
	        print_opName = resSplitMsg[2];
		    }else if(resSplitMsg.length==2){
	        print_workNo = resSplitMsg[0];
	        print_accept = resSplitMsg[1];
	        print_opName = "";
		    }else{
		      print_workNo = resSplitMsg[0];
	        print_accept = "";
	        print_opName = "";
		    }
		}else{
	%>
		  <SCRIPT type=text/javascript>
	      rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���״�ӡ��Ʊ!",0);
	      location="<%=dirtPage%>";
		  </SCRIPT>
	<%
		}
	String sqlss =" select * from dcustmsg where phone_no ='"+oneTok(infoStr,7)+"'";
	String id_no="";
	%>
		<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode11" retmsg="retMsg11">
		<wtc:sql><%=sqlss%></wtc:sql>
	  </wtc:pubselect>
	  <wtc:array id="result1111" scope="end"/>
	<%
	if(retCode11.equals("000000")){
	if(result1111.length>0) {
	id_no=result1111[0][0];
	}else {
		id_no =oneTok(infoStr,7);
	}
	//out.println(id_no);
  }else {
  	//out.println("ȥidʧ���˰���");
	}
	
//��ȡ��Ʊ��  ��ƱԤվ
%>
		<wtc:service name="scancelInDB" routerKey="region" routerValue="<%=regionCode_bill%>" retcode="retCode2" retmsg="retMsg2" outnum="8" >
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=print_workNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=oneTok(infoStr,7) %>"/>
			<wtc:param value="<%=id_no%>"/>
			<wtc:param value="0"/><!--ûȷ��contract_no-->
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=oneTok(infoStr,11)%>"/>
			<wtc:param value="<%=oneTok(infoStr,10)%>"/>
			<wtc:param value=""/>
			<wtc:param value="6"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=oneTok(infoStr,5)%>"/>
			<wtc:param value="0"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=regionCode_bill%>"/>
			<wtc:param value="<%=groupId%>"/>
			<wtc:param value="1"/>
		</wtc:service>
		<wtc:array id="RetResult" scope="end"/>
<%
String[][] result2 = new String[][]{};
%>
<script type="text/javascript">

</script>
<%
	if(RetResult.length>0){
		result2 = RetResult;
		if((result2[0][0].equals("000000"))){
			%>
			<script>
			var wlHref = window.location.href;
			wlHref = wlHref.replace('hljCrmPDPrintPublic.jsp','hljCrmPDPrintPublic2.jsp');
			if(rdShowConfirmDialog('��Ʊ������<%=result2[0][2]%>���Ƿ��ӡ�վݣ�')==1){
				location = wlHref + '&bill_number=<%=result2[0][2]%>&bill_code=<%=result2[0][6]%>' ;
			}else {
				if(parent.g_activateTab == undefined){
					var l_activateTab = "";
					var lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
					for(var i=0; i<lis.length; i++){
						if(lis[i].className == "current"){
							l_activateTab = lis[i].id;
							break;		        
						} 
					}
					parent.removeTab(l_activateTab);
			     }else{
					parent.removeTab(parent.g_activateTab); 
			     }
			}
			
			
			
		</script>
	<%}else{
		%>
		<script>
			
			alert('��ȡ��Ʊ����ʧ�ܣ�������:<%=result2[0][0]%>,������Ϣ:<%=result2[0][1]%>');
			if(parent.g_activateTab == undefined){
				var l_activateTab = "";
				var lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
				for(var i=0; i<lis.length; i++){
					if(lis[i].className == "current"){
						l_activateTab = lis[i].id;
						break;		        
					} 
				}
				parent.removeTab(l_activateTab);
		     }else{
				parent.removeTab(parent.g_activateTab); 
		     }
		</script>
<%
		}
	}
%>
	

