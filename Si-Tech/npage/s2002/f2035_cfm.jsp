<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: leimd
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>

<%
	String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
	String opName = WtcUtil.repNull(request.getParameter("pageOpName"));
	int error_code = 0;
	String error_msg = "";
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));
	String ipAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	
	String productId = request.getParameter("productId");
	String orderSource = request.getParameter("orderSource");//������Դ
	String operType = WtcUtil.repNull(request.getParameter("operType"));
	//wuxy add 20090812
	String productSpecNum=WtcUtil.repNull(request.getParameter("productSpecNum"));
	
	String pay_flag = WtcUtil.repNull(request.getParameter("pay_flag1"));//���ѷ�ʽ
	String mode_code = WtcUtil.repNull(request.getParameter("addProduct"));//�����ʷ�
	String addmodeflag = WtcUtil.repNull(request.getParameter("addmodeflag"));//�����ʷ�
	
	System.out.println("pay_flag="+pay_flag+",mode_code"+mode_code+",addmodeflag="+addmodeflag);
	
	/*file*/
	String iInputFile           = WtcUtil.repNull((String)request.getParameter("inputFile"));
	String iServerIpAddr        = realip;   // 0.100��������ip�����淽���õ�����0.100����ʵip
	String file_flag = request.getParameter("fileflag") == null ? "0" : request.getParameter("fileflag");
	
	String hBeginTime = request.getParameter("beginTime");
	String hMemberGroup = request.getParameter("memberGroup");
	String hEndTime = request.getParameter("endTime");
	String hmemberType = request.getParameter("memberType");
	String hSA = request.getParameter("SAType");
	
	System.out.println("hBeginTime =  " + hBeginTime);
	System.out.println("hMemberGroup =  " + hMemberGroup);	
	System.out.println("hEndTime =  " + hEndTime);	
	System.out.println("hmemberType =  " + hmemberType);	
		
	StringTokenizer strToken1=null;
	StringTokenizer strToken2=null;
	
	System.out.println("orderSource="+orderSource);
	int len = 0;
	String[] tMemberNo = null;
	String[] tMemberType = null;
	String[] tMemberGroup = null;
	String[] tBeginTime = null;
	String[] tEndTime = null;
	String[] tMemberProperty = null;
	/* �������۴�������� */
	String[] tSaList = null;
	
	String[] chkbx = null;
	String[] tMemberNoTmp = null;
	String[] tMemberTypeTmp = null;
	String[] tMemberGroupTmp = null;
	String[] tBeginTimeTmp = null;
	String[] tEndTimeTmp = null;
	String[] tMemberPropertyTmp = null;
	/* �������۴�������� */
	String[] tSaListTmp = null;
	
	String[] characterIds = null;
	String[] characterNames = null;
	String[] characterValues =null;
	String[] operTypes =null;	
	
	if("6".equals(operType)){
    	chkbx = request.getParameterValues("chkbx");
    	tMemberNoTmp = request.getParameterValues("tMemberNo"); 
    	tMemberTypeTmp = request.getParameterValues("tMemberType"); 
    	tMemberGroupTmp = request.getParameterValues("tMemberGroup"); 
    	tBeginTimeTmp = request.getParameterValues("tBeginTime"); 
    	tEndTimeTmp = request.getParameterValues("tEndTime"); 
    	/* �������۴�������� */
    	//tSaListTmp = request.getParameterValues("tSaHide"); 
    	
    	tMemberPropertyTmp = request.getParameterValues("tMemberProperty")==null?(new String[1]):request.getParameterValues("tMemberProperty"); 
    	System.out.println("##*************>>>>>>>>>>>>>>---"+tMemberPropertyTmp.length);
    	len = chkbx.length;
    	tMemberNo = new String[len];
    	tMemberType = new String[len];
    	tMemberGroup = new String[len];
    	tBeginTime = new String[len];
    	tEndTime = new String[len];
    	tMemberProperty = new String[len];
    	tSaList = new String[len];
    }else{
    	tMemberNo = request.getParameterValues("tMemberNo"); 
    	tMemberType = request.getParameterValues("tMemberType"); 
    	tMemberGroup = request.getParameterValues("tMemberGroup"); 
    	tBeginTime = request.getParameterValues("tBeginTime"); 
    	tEndTime = request.getParameterValues("tEndTime"); 
    	tSaList = request.getParameterValues("tSaHide"); 
    	tMemberProperty = request.getParameterValues("tMemberProperty")==null?(new String[1]):request.getParameterValues("tMemberProperty"); 
	}
	if(tMemberNo==null &&  "0".equals(file_flag))
	{
		%>
			<script language="JavaScript">
			rdShowMessageDialog("û�����Ҫ�����ĺ�����Ϣ");
			window.location.replace("f2035_1.jsp");
			
			</script>
		<%		
		return;
	}
   else if ( tMemberNo!=null && "0".equals(file_flag))/*���ļ��ϴ�*/
   {	
		if("6".equals(operType)){
	    int label = 0;
			for(int i=0;(!("".equals(chkbx[0]))&&(i<chkbx.length));i++){
			    int tmp = Integer.parseInt(chkbx[i]);
			    System.out.println("temp=================="+tmp);
			    tMemberNo[label] = tMemberNoTmp[tmp];
			    tMemberType[label] = tMemberTypeTmp[tmp];
			    tMemberGroup[label] = tMemberGroupTmp[tmp];
			    tBeginTime[label] = tBeginTimeTmp[tmp];
			    tEndTime[label] = tEndTimeTmp[tmp];
			    tMemberProperty[label] = tMemberPropertyTmp[tmp];
			    /* �������۴�������� */
			    //tSaList[label] = tSaListTmp[tmp];
			    label++;
			}
			
		    for(int i=0;(!("".equals(chkbx[0]))&&(i<chkbx.length));i++){
				System.out.println("#######################f2035_cfm.jsp->chkbx["+i+"]->"+chkbx[i]);
			}
		}
		for(int i=0;(!("".equals(tMemberNo[0]))&&(i<tMemberNo.length));i++){
			System.out.println("#######################f2035_cfm.jsp->tMemberNo["+i+"]->"+tMemberNo[i]);
		}
	    
		for(int i=0;(!("".equals(tMemberType[0]))&&(i<tMemberType.length));i++){
			System.out.println("#######################f2035_cfm.jsp->tMemberType["+i+"]->"+tMemberType[i]);
		}
	    
		for(int i=0;(!("".equals(tMemberGroup[0]))&&(i<tMemberGroup.length));i++){
			System.out.println("#######################f2035_cfm.jsp->tMemberGroup["+i+"]->"+tMemberGroup[i]);
		}
		
		for(int i=0;(!("".equals(tBeginTime[0]))&&(i<tBeginTime.length));i++){
			System.out.println("#######################f2035_cfm.jsp->tBeginTime["+i+"]->"+tBeginTime[i]);
		}
		
		for(int i=0;(!("".equals(tEndTime[0]))&&(i<tEndTime.length));i++){
			System.out.println("#######################f2035_cfm.jsp->tEndTime["+i+"]->"+tEndTime[i]);
		}
	    
		for(int i=0;(!("".equals(tMemberProperty[0])) &&(i<tMemberProperty.length));i++){
			System.out.println("#######################f2035_cfm.jsp->tMemberProperty["+i+"]->"+tMemberProperty[i]);
		}
	
	
		characterIds = new String[tMemberNo.length];
		characterNames = new String[tMemberNo.length]; 
		characterValues = new String[tMemberNo.length];
		operTypes = new String[tMemberNo.length];
		
		String characterId = "";
		String characterName = "";
		String characterValue = "";
		
		for(int i=0;i<tMemberNo.length;i++){
		    operTypes[i] = operType;
		}
		
		for(int i=0;(!("".equals(tMemberProperty[0])) && (i<tMemberProperty.length));i++){
			characterId = "";
			characterName = "";
			characterValue = "";
			if(!("undefined".equals(tMemberProperty[i])))
			{
		    	String[] temp = tMemberProperty[i].split("~");
		    	for(int j=0;j<temp.length;j++){
		    	    String[] temp_1 = temp[j].split("\\^");
		    	    if(temp_1.length>0){
				        characterId +=temp_1[0]+"|";
				        characterName +=temp_1[1]+"|";
				        characterValue +=temp_1[2]+"|";       	
		    	    }
		    	}
		    	characterIds[i]=characterId;
		    	characterNames[i]=characterName;
		    	characterValues[i]=characterValue;
		    }
		}
		
	}
	else if ( tMemberNo!=null && "1".equals(file_flag))
	{
		%>
			<script language="JavaScript">
			rdShowMessageDialog("����Ҫ�����ĺ�����Ϣ!!");
			window.location.replace("f2035_1.jsp");
			</script>
		<%
		return;			
	}
	System.out.println("iServerIpAddr==" + iServerIpAddr);
	System.out.println("file_flag==" + file_flag);
	System.out.println("iInputFile==" + iInputFile);
%>

<wtc:service name="s2035Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3"  retcode="Code" retmsg="Msg">
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="<%=org_code%>" />
	<wtc:param value="<%=productId%>" />
	<wtc:param value="<%=orderSource%>" />
	<wtc:param value="<%=operType%>" />
	<wtc:params value="<%=tMemberNo%>" />
	<wtc:params value="<%=tMemberType%>" />
	<wtc:params value="<%=tMemberGroup%>" />
	<wtc:params value="<%=tBeginTime%>" />
	<wtc:params value="<%=tEndTime%>" />
	<wtc:params value="<%=tSaList%>" />
	<wtc:params value="<%=characterIds%>" />
	<wtc:params value="<%=characterNames%>" />
	<wtc:params value="<%=characterValues%>" />
	<wtc:param value="<%=pay_flag%>" />
	<wtc:param value="<%=mode_code%>" />
	<wtc:param value="<%=addmodeflag%>" />
	<wtc:param value="<%=workPwd%>"/>
	<wtc:param value="<%=ipAddr%>"/>
	<wtc:param value="<%=iServerIpAddr%>" />
	<wtc:param value="<%=file_flag%>"/>
	<wtc:param value="<%=iInputFile%>"/>	
	<wtc:param value="<%=hBeginTime%>"/>
	<wtc:param value="<%=hMemberGroup%>" />
	<wtc:param value="<%=hEndTime%>"/>
	<wtc:param value="<%=hmemberType%>"/>			
	<wtc:param value="<%=hSA%>"/>			
		
</wtc:service>
<wtc:array id="result" scope="end"/>
	
<%
	String failedPhones = "";
	String failedReasons = "";
	if(result!=null&&result.length>0){
				failedPhones = result[0][0];
				failedReasons = result[0][1];
			}
	System.out.println("###################################failedPhones="+failedPhones);
	System.out.println("###################################failedReasons="+failedReasons);
	error_code = Code==""?999999:Integer.parseInt(Code);
    error_msg= Msg;
	if(error_code!=0){
%>
<script language="JavaScript">
	rdShowMessageDialog("�������:"+"<%=error_code%></br>"+"������Ϣ:"+"<%=error_msg%>",0);
	window.location.replace("f2035_1.jsp");
</script>
<%
 		return;
}
	else{
		if("44754".equals(mode_code)&&"1".equals(operType)){
		%>
			<script language="JavaScript">
				rdShowMessageDialog("ҵ������������ύ����24Сʱ���ѯ�鵵�������δ��ʱ�鵵�뷢��ҵ����档",1);
			</script>
		<%
		}
	}
	strToken1=new StringTokenizer(failedPhones,"|");
	strToken2=new StringTokenizer(failedReasons,"|");
%>
<HTML><HEAD><TITLE> δ�ɹ������б� </TITLE>
</HEAD>
<body>
<FORM method=post name="backandwhite">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">δ�ɹ������б�</div>
		</div>		
      <table cellspacing=0>
        <TBODY>
          <TR>
            <TD class="blue">��ˮ</TD>
          </TR>
        </TBODY>
      </table>

	    <TABLE cellSpacing="0">
	      <TBODY>
	        <TR> 			
	          <TD width=12%>δ��ӳɹ�����</TD>
	          <TD width=13%>ʧ��ԭ��</TD>
	        </TR>
				
			<%
			while (strToken1.hasMoreTokens()) 
			{
			%>
				<TR>
					<td> <%= strToken1.nextToken()%> </td>
					<td> <%= strToken2.nextToken()%> </td>
				</TR>
			<%
			}
			%>
      </TBODY>
    </TABLE>
          
      <table cellspacing=0>
        <tbody> 
          <tr> 
      	    <td id="footer">
      	        <input class="b_foot" name=back onClick="window.location.href='f2035_1.jsp';" type=button value=����>
      	    	<input class="b_foot" name=close onClick="removeCurrentTab();" type=button value=�ر�>
    	    	</td>
          </tr>
        </tbody> 
      </table>
  		<%@ include file="/npage/include/footer.jsp" %>      
		</FORM>
	</BODY>
</HTML>




