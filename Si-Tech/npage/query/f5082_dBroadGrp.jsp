<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������Ϣ��ѯ</TITLE>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
	String opCode = "5082";
	String opName = "������Ϣ��ѯ";
	
	String cfm_login = request.getParameter("phoneNo");//��ѯ����
	String phoneNos="";
	
	String v_isDirectManageCust = "0";
	String v_directManageCustNo = "";
	String v_groupNo = "";
	String password = (String)session.getAttribute("password"); //diling add for ��ȫ�ӹ�
	String custLevelVal = "";//�ͻ��ȼ�
	String custLevelStartTime = "";//�ͻ��ȼ���ʼʱ��
	String custLevelEndTime = "";//�ͻ��ȼ�����ʱ��
	String innetYear = ""; /*�û����������������ȡ������*/ 
	String innetDay =""; /*�û�������ȥ����֮��ʣ���������ȡ������*/ 
	String innetInfo = "";
	String id_noss="";
	
	
		/* ningtn@20100707 �޸�ҳ��������ʾ��ʽ start */
	String custNameStr 			 = "";
	String custAddressStr 		 = "";
	String idIccidStr 			 = "";
	String idAddressStr 		 = "";
	String contactPersonStr      = "";
	String contactPhoneStr       = "";
	String contactAddressStr     = "";
	String contactPostStr        = "";
	String contactAddress1Str    = "";
	String contactMailaddressStr = "";
	String contactFaxStr         = "";
	String conNameStr = "";
	String pwdcheck = "N";
	/* ningtn@20100707 �޸�ҳ��������ʾ��ʽ end */
	
/**
	ArrayList arlist = new ArrayList();
	try
	{	//System.out.println("--------------5555555-------------");
		s1500View viewBean = new s1500View();//ʵ����viewBean
		arlist = viewBean.view_s1500Qry(phoneNo,idNo); 
		//System.out.println("--------------5555555-------------");
	}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	**/
	
	/* gaopeng 2014/01/14 10:12:18  ����ʵ���Ǽ�BOSS�������ӱ�������� ���뾭������Ϣ��չʾ*/
	String gestoresName = "";
	String gestoresAddr = "";
	String gestoresIccId = "";
	String gestoresIdType = "";
	String gestoresIdTypeName = "";
	
	String responsibleName="";
	String responsibleAddr="";
	String responsibleType="";
	String responsibleIccId="";
	String responsibleTypeName="";
	
	/* begin add for ���ڿ��������ն�CRMģʽAPP�ĺ� - ������@2015/3/30 */
	String realUserName = "";
	String realUserAddr = "";
	String realUserIdType = "";
	String realUserIccId = "";
	
%>
 	
  	
	<wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="1"  retcode="errCode" retmsg="errMsg">
		<wtc:param  value="0"/>
		<wtc:param  value="01"/>
		<wtc:param  value=""/>
		<wtc:param  value="<%=workNo%>"/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value="<%=cfm_login%>"/>
  </wtc:service>
  <wtc:array id="list" scope="end"/>
<%
			if("000000".equals(errCode)){
				if(list != null && list.length > 0){
				System.out.println("=== list[0][0] ===" + list[0][0]);
					phoneNos = list[0][0];
				}
			}
%>
		<wtc:service name="s1500PhoneQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9" >
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="0"/>
		<wtc:param value="<%=phoneNos%>"/>
		<wtc:param value="<%=regionCode%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
			
			<%
			if(result.length>0) {
			id_noss=result[0][3];
			}
			%>
			
			
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="s1500Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="28">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneNos%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=id_noss%>"/>
	</wtc:service>
	<wtc:array id="mainQryArr" scope="end"/>	
<%

	String xq_info_old = "";
	String xq_info_new = "";
	
	if(mainQryArr.length>0){
		xq_info_old = mainQryArr[0][25]+"--"+mainQryArr[0][23];
		xq_info_new = mainQryArr[0][26]+"--"+mainQryArr[0][24];
	}
		
	String oBroadBand = "";
	if(mainQryArr.length>0){
		oBroadBand = mainQryArr[0][27];
	}

	if(!retCode1.equals("000000")){
  %>
	<script language="javascript">
		rdShowMessageDialog("����δ�ܳɹ�,�������<%=retCode1%><br>������Ϣ<%=retMsg1%>!");
		parent.removeTab("<%=opCode%>");
	</script>
<%
		return;
	}else if(mainQryArr==null||mainQryArr.length==0){
%>
	<script language="javascript">
		rdShowMessageDialog("��ѯ���Ϊ��,�޴�������Ϣ���������!");
		parent.removeTab("<%=opCode%>");
	</script>
<%
		return;
	}
	
	
	
	

		//ѭ��ȡֵ,�������������list��
	ArrayList arlist = new ArrayList();
	StringTokenizer resToken = null;
  for(int i = 0; i<mainQryArr.length; i++){

  	for(int j=0;j<mainQryArr[i].length;j++){
  		String value;
      for(resToken = new StringTokenizer(mainQryArr[i][j], "|"); resToken.hasMoreElements(); arlist.add(value)){
          value = (String)resToken.nextElement();
          System.out.println("gaopengSeeLog20151207===="+arlist.size()+"wanghyd-----------"+value);
      }
    }
  }
  
  String ifVolte = "��";
  String arr44 = (String)arlist.get(44);
  String arr45 = (String)arlist.get(45);
  String arr46 = (String)arlist.get(46);
  if(arr44.indexOf("volte") != -1){
  	ifVolte = "��";
  }
  if(arr45.indexOf("volte") != -1){
  	ifVolte = "��";
  }
  if(arr46.indexOf("volte") != -1){
  	ifVolte = "��";
  }

		String userInfo1 = (String)arlist.get(29);
	String highmsg=(String)arlist.get(30);
	String ss="�и߶��û�";
	int spos=highmsg.indexOf(ss,0);
	
%>	
	
	
	<wtc:service name="sCustOprMsgQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeC1" retmsg="retMsgC1" outnum="8" >
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>	
    <wtc:param value="<%=password%>"/>		
    <wtc:param value="<%=phoneNos%>"/>	
    <wtc:param value=""/>
    <wtc:param value="��ѯ�ͻ���������Ϣ"/>
    <wtc:param value="<%=(String)arlist.get(2)%>"/>
  </wtc:service>
  <wtc:array id="resultC1" scope="end"/>


<%
	
	if("000000".equals(retCodeC1)){
		System.out.println("gaopengSeeLog=================����sCustOprMsgQry����ɹ���");
		
		gestoresName = resultC1[0][0];    
		gestoresAddr = resultC1[0][3];    
		gestoresIccId = resultC1[0][2];   
	  gestoresIdType = resultC1[0][1]; 
	  
	  responsibleName=resultC1[0][6];
	  responsibleAddr=resultC1[0][7];
	  responsibleType=resultC1[0][4];
	  responsibleIccId=resultC1[0][5];
	  
	  
	  System.out.println("gaopengSeeLog=================gestoresName="+gestoresName);
	  System.out.println("gaopengSeeLog=================gestoresAddr="+gestoresAddr);
	  System.out.println("gaopengSeeLog=================gestoresIccId="+gestoresIccId);
	  System.out.println("gaopengSeeLog=================gestoresIdType="+gestoresIdType);
	  
	  /*gaopeng ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� ����TlsPubSelCrm ��ѯ������֤����������չʾ��ҳ���ϣ�������֤�����Ͳ�����ģ��У�顣*/
	  String[] inParamsss1 = new String[2];
	  
		inParamsss1[0] = "select t.id_name from sidtype t where t.id_type=:s_idType";
		inParamsss1[1] = "s_idType="+gestoresIdType;
		
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeidTyp" retmsg="retMsgidTyp" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>

		<wtc:array id="s_idType0" scope="end" />
		
		
		<%
	  if("000000".equals(retCodeidTyp) && s_idType0.length > 0){
	  	gestoresIdTypeName = s_idType0[0][0];
	  	 System.out.println("gaopengSeeLog=================gestoresIdTypeName="+gestoresIdTypeName);
	  }
	  
	  
	 	  String[] inParamsss333 = new String[2];
	  
		inParamsss333[0] = "select t.id_name from sidtype t where t.id_type=:s_idType";
		inParamsss333[1] = "s_idType="+responsibleType;
		
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeidTypsdf" retmsg="retMsgidTypsdf" outnum="1">			
		<wtc:param value="<%=inParamsss333[0]%>"/>
		<wtc:param value="<%=inParamsss333[1]%>"/>	
		</wtc:service>

		<wtc:array id="s_idType33333" scope="end" />
		
		
		<%
	  if( s_idType33333.length > 0){
	  	responsibleTypeName = s_idType33333[0][0];
	  	System.out.println("gaopengSeeLog=================responsibleTypeName="+responsibleTypeName);
	  } 
	  
	  
	  
	}else{
		System.out.println("gaopengSeeLog=================����sCustOprMsgQry����ʧ�ܣ�");
	} 


%>
<script>
	if(<%=spos%>>=0){
		rdShowMessageDialog("���û����и߶��û���");
		}
	var userInfo = "<%= userInfo1 %>" ;
	var userType = oneTok(userInfo,"~",1);
	var stopFlag = oneTok(userInfo,"~",2);
	var stopDesc = "";
	if ( stopFlag == "N" ) {
		stopDesc = "��ͣ�û�";
		}
	else {
		stopDesc = "����ͣ�û�";
		}
	
	function init(){
	//document.all.attrCode.value = userType;
	//document.all.stop.value = stopDesc;
	$("#attrCode").html(userType);
	$("#stop").html(stopDesc);

}
</script>
</HEAD>
<%
/* ningtn@20100707 �޸�ҳ��������ʾ��ʽ start */

		custNameStr 		  = (String)arlist.get(3);
		custAddressStr 		  = (String)arlist.get(9);
		idIccidStr 			  = (String)arlist.get(11);
		idAddressStr 		  = (String)arlist.get(12);
		contactPersonStr      = (String)arlist.get(14);
		contactPhoneStr       = (String)arlist.get(15);
		contactAddressStr     = (String)arlist.get(16);
		contactPostStr        = (String)arlist.get(17);
		contactAddress1Str    = (String)arlist.get(18);
		contactMailaddressStr = (String)arlist.get(20);
		contactFaxStr         = (String)arlist.get(19);
		conNameStr         = (String)arlist.get(48);
		pwdcheck 						= (String)arlist.get(70);

/* ningtn@20100707 �޸�ҳ��������ʾ��ʽ end */
%>

<body onLoad="init()">
<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>

<table cellspacing="0" name="t1" id="t1">
  <tr> 
	<td colspan="8">
  	<div class="title">
		  <div id="title_zi">�ͻ���Ϣ</div>	
    </div>
    </td>
 </tr>
  <tr> 

 
    <tr> 
      <td class="blue">�ͻ���ʶ</td>
      <td> 
        <%=(String)arlist.get(2)%>
      </td>
      <td class="blue">�ͻ�����</td>
      <td> 
        <%=custNameStr%>
        </td>
      <td class="blue">�����ص�</td>
      <td> 
       <%=(String)arlist.get(4)%>
      </td>
      <td class="blue">�ͻ�״̬</td>
      <td > 
        <%=(String)arlist.get(5)%>
      </td>
    </tr>
    <tr> 
      <td class="blue">״̬ʱ��</td>
      <td> 
        <%=(String)arlist.get(6)%>
        </td>
      <td class="blue">�ͻ�����</td>
      <td> 
        <%=(String)arlist.get(7)%>
        </td>
      <td class="blue">�ͻ����</td>
      <td> 
        <%=(String)arlist.get(8)%>
        </td>
      <td class="blue">�ͻ���ַ</td>
      <td> 
        <%=custAddressStr%>
      </td>
    </tr>
    <tr> 
      <td class="blue">֤������</td>
      <td> 
        <%=(String)arlist.get(10)%>
        </td>
      <td class="blue">֤������</td>
      <td> 
        <%=idIccidStr%>
      </td>
      <td class="blue">֤����ַ</td>
      <td> 
        <%=idAddressStr%>
      </td>
      <td class="blue">֤����Ч��</td>
      <td> 
        <%=(String)arlist.get(13)%>
      </td>
    </tr>
    <tr> 
      <td class="blue">��ϵ��</td>
      <td> 
        <%=contactPersonStr%>
        </td>
      <td class="blue">��ϵ�绰</td>
      <td> 
        <%=contactPhoneStr%>
        </td>
      <td class="blue">��ϵ��ַ</td>
      <td> 
        <%=contactAddressStr%>
      </td>
      <td class="blue">��������</td>
      <td > 
        <%=contactPostStr%>
      </td>
    </tr>
    <tr> 
      <td class="blue">ͨѶ��ַ</td>
      <td> 
        <%=contactAddress1Str%>
        </td>
      <td class="blue">��ϵ�˴���</td>
      <td> 
       <%=contactFaxStr%>
      </td>
      <td class="blue">��������</td>
      <td > 
        <%=contactMailaddressStr%>
      </td>
      <td class="blue">����������ʶ</td>
      <td> 
        <%=(String)arlist.get(21)%>
      </td>
    </tr>
    <tr> 
      <td class="blue">����ʱ��</td>
      <td> 
        <%=(String)arlist.get(22)%>
      </td>
      <td class="blue">����ʱ��</td>
      <td> 
        <%=(String)arlist.get(23)%>
      </td>
      <td class="blue">�ϼ��ͻ�ID</td>
      <td > 
        <%=(String)arlist.get(24)%>
      </td>

      <td > 
       
      </td>
      <td > 
       
      </td>
    </tr>
    <tr>
    	<td class="blue">����������</td>
    	<td><%=gestoresName %></td>
    	<td class="blue">��������ϵ��ַ</td>
    	<td><%=gestoresAddr %></td>
    	<td class="blue">������֤������</td>
    	<td><%=gestoresIdTypeName %></td>
    	<td class="blue">������֤������</td>
    	<td><%=gestoresIccId %></td>
    </tr>
    
    <tr>
    	<td class="blue">����������</td>
    	<td><%=responsibleName %></td>
    	<td class="blue">��������ϵ��ַ</td>
    	<td><%=responsibleAddr %></td>
    	<td class="blue">������֤������</td>
    	<td><%=responsibleTypeName %></td>
    	<td class="blue">������֤������</td>
    	<td><%=responsibleIccId %></td>
    </tr>
    
         <tr> 
      <td class="blue">�û���ע��Ϣ</td>
      <td> 
        <%=(String)arlist.get(69)%>
      </td>
    </tr>

  <tr> 
	<td colspan="8">
      	&nbsp;
    </td>
 </tr> 
 
  
  <tr> 
	<td colspan="8">
  	<div class="title">
		  <div id="title_zi">�û���Ϣ</div>	
    </div>
    </td>
 </tr>
  <tr> 
    <td class="blue" nowrap>�������</td>
    <td> 
      <%=phoneNos%>
    </td>
    <td class="blue" nowrap>ҵ��Ʒ��</td>
    <td> 
      <%=(String)arlist.get(26)%>
    </td>
    <td class="blue" nowrap>����ʱ��</td>
    <td > 
      <%=(String)arlist.get(28)%>
    </td>
      <td > 
       
      </td>
      <td > 
       
      </td>
  </tr>
  <tr> 
    <td class="blue">�û�����</td>
    <td id="attrCode"> 
      
    </td>
    <td class="blue">��ͻ���־</td>
    <td> 
      <%=(String)arlist.get(30)%>
      </td>
    <td class="blue">���ö�</td>
    <td> 
      <%=(String)arlist.get(31)%>
    </td>
    <td class="blue" nowrap>������״̬</td>
    <td> 
      <%=(String)arlist.get(32)%>
    </td>
  </tr>
  <tr> 
    <td class="blue">��ǰ״̬</td>
    <td> 
     <%=(String)arlist.get(33)%>
    </td>
    <td class="blue">״̬�޸�ʱ��</td>
    <td> 
      <%=(String)arlist.get(34)%>
    </td>
    <td class="blue">����ʱ��</td>
    <td> 
      <%=(String)arlist.get(35)%>
    </td>
    <td class="blue">��������</td>
    <td> 
      <%=(String)arlist.get(36)%>
    </td>
  </tr>
  <tr> 
    <td class="blue">�ײ�����</td>
    <td> 
      <%=(String)arlist.get(37)%>
      </td>
    <td class="blue">�����ײ�</td>
    <td> 
      <%=(String)arlist.get(38)%>
      </td>
    <td class="blue">�ײ���ʼʱ��</td>
    <td> 
      <%=(String)arlist.get(39)%>
      </td>
    <td class="blue">��Чʱ��</td>
    <td> 
      <%=(String)arlist.get(40)%>
      </td>
  </tr>
  
  <tr > 
    <td  class="blue">С������--С������(��ǰ)</td>
    <td > 
      <%=xq_info_old%>
      </td>
    <td  class="blue">С������--С������(�µ�)</td>
    <td > 
      <%=xq_info_new%>
    </td>
          <td > 
       
      </td>
      <td > 
       
      </td>
            <td > 
       
      </td>
      <td > 
       
      </td>
  </tr>
  
  <tr> 
    
    <td class="blue">��ͣ��־</td>
    <td id="stop"> 
     
    </td>
    <td class="blue">���ʷѵ�˫������</td>
    <td>
      <%=(String)arlist.get(43)%>
    </td>
    <td class="blue"  style="display:block">����˺�</td>
    <td  style="display:block">
      <%=(String)arlist.get(63)%>
    </td>
        <td class="blue"  style="display:block">���ŷ־�</td>
    <td  style="display:block">
      <%=(String)arlist.get(67)%>
    </td>
  </tr>
      <tr> 
      <td class="blue">�ͻ��ȼ�</td>
      <td> 
        <%
        		custLevelVal = (String)arlist.get(74);
        		custLevelStartTime = (String)arlist.get(75);
        		custLevelEndTime = (String)arlist.get(76);
        %>
        <%=custLevelVal%>
      </td>
      
      <td class="blue">�ͻ��ȼ���ʼʱ��</td>
      <td> 
        
        <%=custLevelStartTime%>
      </td>
      
      <td class="blue">�ͻ��ȼ�����ʱ��</td>
      <td> 
       
        <%=custLevelEndTime%>
      </td>
      
      <%
      	/*** begin diling add for �����������������չ�ͻ����䡢�Ǽ���ѯ����@2014/2/19 ***/
      %>
      <td class="blue">�ͻ�����</td>
      <td> 
        <%
            innetYear = (String)arlist.get(71) ;
						innetDay = (String)arlist.get(72) ;
						innetInfo = innetYear+"��"+innetDay+"��";
        %>
        <%=innetInfo%>
      </td>
      </tr>
			<td class="blue">�������ʷ�</td>
      <td> 
				<%=(String)arlist.get(73)%>
      </td>
    
<%if(!"".equals(oBroadBand)){%>
	 <td class="blue">�������</td>
	 <td> 
		<%=oBroadBand%>
   </td>
<%}%>
 
		<%if(!"û�п���˺�".equals(arlist.get(63))){%>
	      <td class="blue">�����װ��ַ</td>
	      <td>
	        <%=(String)arlist.get(64)%>
	      </td>
      <%}%>
</tr>

</table>


 

    <table cellspacing=0>
      <tr id="footer"> 
		<td>
			  <input class="b_foot" name=back onClick="window.location.href='f5082_1.jsp'" type=button value=����>
			  <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
			  <input class="b_foot_long" name=print onclick="printTable(t1);" type=button value=����ΪXLS���>
		</td>
	  </tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<script ="javascript">
var excelObj;

function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.t1.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =13;//�����п� 
  sheet.Columns("B").ColumnWidth =21;//�����п� 
  sheet.Columns("B").numberformat="@";
  sheet.Columns("C").ColumnWidth =13;//�����п� 
  sheet.Columns("D").ColumnWidth =21;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =13;//�����п�
  sheet.Columns("F").ColumnWidth =21;//�����п�
  sheet.Columns("F").numberformat="@"; 
  sheet.Columns("G").ColumnWidth =13;//�����п� 
  sheet.Columns("H").ColumnWidth =21;//�����п� 
	sheet.Columns("H").numberformat="@"; 


		for(a=0;a<document.all.t1.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('����excelʧ��!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
   var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;  
  sheet.Columns("A").ColumnWidth =13;//�����п� 
  sheet.Columns("B").ColumnWidth =21;//�����п� 
  sheet.Columns("B").numberformat="@";
  sheet.Columns("C").ColumnWidth =13;//�����п� 
  sheet.Columns("D").ColumnWidth =21;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =13;//�����п�
  sheet.Columns("F").ColumnWidth =21;//�����п�
  sheet.Columns("F").numberformat="@"; 
  sheet.Columns("G").ColumnWidth =13;//�����п� 
  sheet.Columns("H").ColumnWidth =21;//�����п� 
	sheet.Columns("H").numberformat="@"; 

		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('����excelʧ��!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+str.charAt(cells+colspan-2)
+total_row).Borders.LineStyle=1;
}

</script>
