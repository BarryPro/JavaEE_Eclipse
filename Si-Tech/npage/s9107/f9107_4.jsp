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
        String opCode = "9107";
        String opName = "SPҵ����Ϣ���";
            //ArrayList arrSession = (ArrayList)session.getAttribute("allArr"); //����session
            //String[][] baseInfoSession = (String[][])arrSession.get(0);
            //String[][] otherInfoSession = (String[][])arrSession.get(2);
            //String[][] pass = (String[][])arrSession.get(4);
        String loginPasswd  = (String)session.getAttribute("password");       //ȡ����Ա����
        String workNo = (String)session.getAttribute("workNo");
        String workName = (String)session.getAttribute("workName");
        String op_name ="SPҵ����Ϣ���"; 
        String optype = "";
        String powerCode= (String)session.getAttribute("powerCode");
        String orgCode = (String)session.getAttribute("orgCode");
        String ip_Addr = (String)session.getAttribute("ipAddr");
        
        String regionCode = orgCode.substring(0,2);
				
			int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		    int iPageSize = 20;
		    int iStartPos = (iPageNumber-1)*iPageSize;
		    int iEndPos = iPageNumber*iPageSize;
		    String sql1="";
				String sql2="";
				String verify_code2 = null;
				String message = null;
				String[][] result=null;
	      String[][] result1=null;
	      String errcode="000000";
	      String errmsg="";
				String disPlay = request.getParameter("disPlay") ;

		%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sLoginAccept" />
		<%		
				
		if("yes".equals(disPlay)){
		
				 verify_code2=request.getParameter("verify_code2");
				 message=request.getParameter("message");
								
				if(verify_code2.equals("0")){
				   sql1 ="select * from (select a.OPERATOR_CODE,a.OPERATOR_NAME,a.VALID_DATE,a.EXPIRE_DATE,to_char(a.MAXACCEPT),rownum id,a.op_type from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sptype from dDsmpSpInfo where spid = a.sp_code) and  b.auto_flag = '0' and nvl(a.SP_CODE,'')like '%"+message+"%') where id <"+iEndPos+" and id>="+iStartPos;
				   sql2 ="select nvl(count(*),0) num from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sp_type from TDSMPSPINFOPREMSG where sp_code = a.sp_code)and  b.auto_flag = '0' and nvl(a.SP_CODE,'')like '%"+message+"%'";
	       }
	      else if(verify_code2.equals("1")){ 
	         sql1 ="select * from (select a.OPERATOR_CODE,a.OPERATOR_NAME,a.VALID_DATE,a.EXPIRE_DATE,to_char(a.MAXACCEPT),rownum id,a.op_type from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sptype from dDsmpSpInfo where spid = a.sp_code) and  b.auto_flag = '0' and nvl(a.OPERATOR_CODE,'')like '%"+message+"%') where id <"+iEndPos+" and id>="+iStartPos;
				   sql2 ="select nvl(count(*),0) num from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sp_type from TDSMPSPINFOPREMSG where sp_code = a.sp_code)and  b.auto_flag = '0' and nvl(a.OPERATOR_CODE,'')like '%"+message+"%'";
				}else if(verify_code2.equals("2")){
					 sql1 ="select * from (select a.OPERATOR_CODE,a.OPERATOR_NAME,a.VALID_DATE,a.EXPIRE_DATE,to_char(a.MAXACCEPT),rownum id,a.op_type from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sptype from dDsmpSpInfo where spid = a.sp_code) and  b.auto_flag = '0' and nvl(a.OPERATOR_NAME,'')like '%"+message+"%') where id <"+iEndPos+" and id>="+iStartPos;
				   sql2 ="select nvl(count(*),0) num from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sp_type from TDSMPSPINFOPREMSG where sp_code = a.sp_code)and  b.auto_flag = '0' and nvl(a.OPERATOR_NAME,'')like '%"+message+"%'";
				}else{
			     sql1 ="select * from (select a.OPERATOR_CODE,a.OPERATOR_NAME,a.VALID_DATE,a.EXPIRE_DATE,to_char(a.MAXACCEPT),rownum id,a.op_type from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sptype from dDsmpSpInfo where spid = a.sp_code) and  b.auto_flag = '0') where id <"+iEndPos+" and id>="+iStartPos;
				   sql2 ="select nvl(count(*),0) num from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sp_type from TDSMPSPINFOPREMSG where sp_code = a.sp_code) and  b.auto_flag = '0'";
        }
%>


<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retval="val1" outnum="9">
<wtc:sql><%=sql1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="r0" property="val1" scope="end" />
	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retval="val2" outnum="1">
<wtc:sql><%=sql2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="r1" property="val2" scope="end" />

<%
 		result=r0;
		result1=r1;
		errcode=retCode;
		errmsg=retMsg;
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
<head>
<title><%=op_name%></title>
<script language=javascript>
	//core.loadUnit("debug");
		//core.loadUnit("rpccore");
			onload=function()
			{
			 //core.rpc.onreceive=doProcess;
			}
			
			
		function doProcess(packet)
	{	
		
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var operator_code = packet.data.findValueByName("operator_code");
		var operator_name = packet.data.findValueByName("operator_name");
		var serv_type = packet.data.findValueByName("serv_type");			
		var serv_attr = packet.data.findValueByName("serv_attr");
		var count = packet.data.findValueByName("count");
		var bill_flag = packet.data.findValueByName("bill_flag");
		var other_bal_obj1 = packet.data.findValueByName("other_bal_obj1");
		var other_bal_obj2 = packet.data.findValueByName("other_bal_obj2");
		var valid_date = packet.data.findValueByName("valid_date");
		var expire_date = packet.data.findValueByName("expire_date");
		var bal_prop = packet.data.findValueByName("bal_prop");
		var serv_type = packet.data.findValueByName("serv_type");
		if( parseInt(retCode) == 0 ){
			document.frm.operator_code.value= operator_code;
			document.frm.operator_name.value= operator_name;
			document.frm.serv_type.value= serv_type;
			document.frm.serv_attr.value= serv_attr;
			document.frm.count.value= count;
			document.frm.bill_flag.value= bill_flag;
			document.frm.other_bal_obj1.value= other_bal_obj1;
			document.frm.other_bal_obj2.value= other_bal_obj2;
			document.frm.valid_date.value= valid_date
			document.frm.expire_date.value= expire_date;
			document.frm.bal_prop.value= bal_prop;				
							
		}else{
			rdShowMessageDialog("����"+retMsg,0);
		}
		
		tbs1.style.display="";
	}
function checkall(){
     var num = 0;
     if(!(document.frm.checkId == null))
	    num = document.frm.checkId.length;
	 if(num>1){
		for(var i=0;i<num;i++){
			document.frm.checkId[i].checked=true;
		}
	 }else{
    	if(!(document.frm.checkId == null))
    	 	 document.frm.checkId.checked=true;
	  }
	}
	function cancelChoose(){
		var num = 0;
         if(!(document.frm.checkId == null))
    	    num = document.frm.checkId.length;
		if(num>1){
		for(var i=0;i<num;i++){
			document.frm.checkId[i].checked=false;
		}
	 }else{
	    if(!(document.frm.checkId == null))
	 	    document.frm.checkId.checked=false;
	  }	
	}
	function printCommit()
			{
				document.frm.check_flag.value = "yes"; 
			  document.frm.systemNote.value="����Ա:"+"<%=workNo%>"+"��SPҵ�����Ͻ����������"; 	    
			  conf();			       
			}			
	function printCommit1()
			{
				     document.frm.check_flag.value = "no"; 
			       document.frm.systemNote.value="����Ա:"+"<%=workNo%>"+"��SPҵ�����Ͻ����������";
			       conf();
			} 				
	function conf()
			{	
				if(document.getElementsByName('checkId')[0]!=null){
					var count = 0;
					for(var i=0;i<document.getElementsByName('checkId').length;i++){
						if(document.getElementsByName('checkId')[i].checked){
							count++;
						}
					}
					if(count==0)
					{rdShowMessageDialog('��ѡ��������ݣ�');
						return false;}
						else{
									frm.action="f9107_conf.jsp";
						      frm.submit();
							}
				}
			     
			} 
   function getFlagCode(){
   	if(!check(document.frm)){
			return false;			
		}
		document.frm.action="f9107_4.jsp";
		document.frm.submit();
   }
	   		  
</script>	
</head>
<BODY>
<form name="frm" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">SPҵ����Ϣ��˲�ѯ</div>
</div>
<input type="hidden" name="loginAccept" value="<%=sLoginAccept%>">
<input type="hidden" name="maxaccept" value="">
<input type="hidden" name="workno" value="<%=workNo%>">
<input type="hidden" name="sum_flag" value="">
<input type="hidden" name="check_flag" value="">
<input type="hidden" name="disPlay"  value="yes">	
<table cellSpacing="0">
 	      <tr> 
            <td class=blue nowrap> 
              <div align="left">��ѯ��ʽ</div>
            </td>
            <td nowrap> 
              <div align="left"> 
               <select size=1 name=verify_code2 >                
                 <option value="0">SP����</option>
                 <option value="1">ҵ�����</option>
                 <option value="2">ҵ������</option>
                 <option value="3">ȫ��</option>
               </select>
              </div>
            </td>	
          </tr>
          <tr>
            <td class=blue nowrap> 
              <div align="left">��ѯ����</div>
            </td>
            <td nowrap>
            	<input name="message" type="text" maxlength="30" id="message" value="">
            	<input name="select" class="b_text" type="button"  value="��ѯ" onClick="getFlagCode()">
             </td>
          </tr>
 </table>  
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�����SPҵ����Ϣ�б�</div>
</div>
<table cellSpacing="0">
        <tr> 
            <td colspan="8" align="right"> 
            	<%
            	  int iQuantity = 0;
            	  if(result1!=null){ 
            	  int recordNum = Integer.parseInt(result1[0][0].trim());
						    iQuantity =recordNum;
						    }
						    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
								PageView view = new PageView(request,out,pg); 
						   	view.setVisible(true,true,0,1); 
            	%>
            </td>
        </tr>
        <tr>
            <th><div align="center">ѡ��</div></th>
            <th><div align="center">��������</div></th>
            <th><div align="center">ҵ�����</div></th>              
            <th><div align="center">ҵ���Ʒ����</div></th>      
            <th><div align="center">��Ч����</div></th>
            <th><div align="center">ʧЧ����</div></th>
        </tr>	 
       <%
         int relength =0;
         if(result!=null){
           relength = result.length;
         for(int i=0;i<relength;i++){         
         String tdClass = "";            
         if (i%2==0){
             tdClass = "Grey";
         }      
        %>
        <tr id="tr0">
        	<td class="<%=tdClass%>"><div align="center"><input type="checkbox" name="checkId" id="checkId" value="<%=result[i][4]%>">&nbsp;</div></td>
        	<%
        		optype = result[i][6];
        		if(optype.equals("A")){
        		optype = "����";
        		}
        	else if(optype.equals("M")){
        		optype = "�޸�";
        		}
        	else if(optype.equals("D")){
        		optype = "ɾ��";
        		}
        	else{
        		optype = "����";
        		}
        	%>
        	<td class="<%=tdClass%>" align="center" name=spcode height="20"><%=optype%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" name=spcode height="20"><%=result[i][0]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" name=spname height="20"><%=result[i][1]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" name=sptype height="20"><%=result[i][2]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" name=spservcode height="20"><%=result[i][3]%>&nbsp;</td>
       </tr>
     <%
         }
       }
     %>  
     <tr> 
        <td nowrap class=blue> 
          <div align="left">��ע</div>
        </td>
        <td nowrap colspan="6"> 
          <div align="left"> 
            <input type="text" class="InputGrey" name="systemNote" id="systemNote" size="60" readonly maxlength=60>
          </div>
        </td>
      </tr>
      <tr style='display:none'> 
        <td nowrap> 
          <div align="left">�û���ע</div>
        </td>
        <td nowrap colspan="6"> 
          <div align="left"> 
            <input type="text" name="opNote" id="opNote" size="60" v_maxlength=60  v_type=string index="28" maxlength=60>
          </div>
        </td>
      </tr>
       <tr> 
          <td nowrap colspan="7"> 
              <div align="center"> 
                   <input class="b_text" type="button" name="b_print" value="ȫѡ" onClick="checkall()" index="39">
                   <input class="b_text" type="button" name="b_clear" value="ȫ��ѡ" onClick="cancelChoose()" index="30">
                  <!--
                   <input class="button" type="button" name="b_back" value="���ͨ��" onClick="" index="30">
                   <input class="button" type="button" name="b_back" value="��ͨ��" onClick="" index="30">
                   --> 
               </div>
           </td>
      </tr>	                
 	    <tr> 
                  <td nowrap id="footer" colspan="7"> 
                    <div align="center">
                      <input class="b_foot" type="button" name="b_clear" value="���" onClick="printCommit()" index="30"> 
                      <input class="b_foot" type="button" name="b_print" value="��˲�ͨ��" onClick="printCommit1()" index="29"> 
                      <input class="b_foot" type="button" name="b_clear" value="���" onClick="frm.reset();" index="30">
                      <input class="b_foot" type="button" name="b_back" value="����" onClick="location='f9107_1.jsp'" index="31">
                    </div>
                  </td>
      </tr>
</table>      
<%@ include file="/npage/include/footer.jsp"%>	
</form>	 	
</body>	
</html>

<%}%>
