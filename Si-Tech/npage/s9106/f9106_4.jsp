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
    String opCode = "9106";
    String opName = "SP��ҵ��Ϣ���";
        //ArrayList arrSession = (ArrayList)session.getAttribute("allArr"); //����session
        //String[][] baseInfoSession = (String[][])arrSession.get(0);
        //String[][] otherInfoSession = (String[][])arrSession.get(2);
        //String[][] pass = (String[][])arrSession.get(4);
    String loginPasswd  = (String)session.getAttribute("password");       //ȡ����Ա����
    String workNo = (String) session.getAttribute("workNo");
    String workName = (String) session.getAttribute("workName");
    String op_name ="SP��ҵ��Ϣ���"; 
    String sptype="";
    String powerCode= (String) session.getAttribute("powerCode");
    String orgCode = (String) session.getAttribute("orgCode");
    String ip_Addr = (String) session.getAttribute("ipAddr");
    
    String region_Code = orgCode.substring(0,2);
    String optype = "";
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 20;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;
    String sql1="";
    String sql2="";
    String verify_code2=request.getParameter("verify_code2");
    String message=request.getParameter("message");
				if(verify_code2.equals("0")){
				   sql1 ="select * from (select a.SP_CODE,a.SP_NAME,a.SP_TYPE,a.SERV_CODE,a.VALID_DATE,a.EXPIRE_DATE ,a.MAXACCEPT,rownum id,a.op_type from TDSMPSPINFOPREMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0' and nvl(a.SP_CODE ,'') like '%"+message+"%') where id <"+iEndPos+" and id>="+iStartPos;
				   sql2 ="select nvl(count(*),0) num from TDSMPSPINFOPREMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0' and nvl(a.SP_CODE ,'') like '%"+message+"%'";
	       }
	      else if(verify_code2.equals("1")){ 
	         sql1 ="select * from (select a.SP_CODE,a.SP_NAME,a.SP_TYPE,a.SERV_CODE,a.VALID_DATE,a.EXPIRE_DATE ,a.MAXACCEPT,rownum id,a.op_type from TDSMPSPINFOPREMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0' and nvl(a.SP_NAME ,'') like '%"+message+"%') where id <"+iEndPos+" and id>="+iStartPos;
				   sql2 ="select nvl(count(*),0) num from TDSMPSPINFOPREMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0' and nvl(a.SP_NAME ,'') like '%"+message+"%'";
				}else{
			     sql1 ="select * from (select a.SP_CODE,a.SP_NAME,a.SP_TYPE,a.SERV_CODE,a.VALID_DATE,a.EXPIRE_DATE ,a.MAXACCEPT,rownum id,a.op_type from TDSMPSPINFOPREMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0') where id <"+iEndPos+" and id>="+iStartPos;
				   sql2 ="select nvl(count(*),0) num from TDSMPSPINFOPREMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0' ";
        } 
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_Code%>" id="sLoginAccept" />

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_Code%>" retval="val1" outnum="9">
<wtc:sql><%=sql1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" property="val1" scope="end" />
	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_Code%>" retval="val2" outnum="1">
<wtc:sql><%=sql2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" property="val2" scope="end" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<script language=javascript>
function checkall(){
	 var num = "<%=result1[0][0]%>";
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
		var num = "<%=result1[0][0]%>";
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
	      document.frm.systemNote.value="����Ա"+document.frm.workno.value+":SP��ҵ�����������";  		       
			  conf();	
			 
			}
	function printCommit1()
			{
			  document.frm.check_flag.value = "no";
	      document.frm.systemNote.value="����Ա"+document.frm.workno.value+":SP��ҵ�����������";  		       
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
					{
					    rdShowMessageDialog('��ѡ��������ݣ�');
						return false;}
						else{
									frm.action="f9106_conf.jsp";
						      frm.submit();
							}
				}

			}   
</script>	
</head>
<BODY>
<form name="frm" method="POST" >
<input type="hidden" name="loginAccept" value="<%=sLoginAccept%>">
<input type="hidden" name="maxaccept" value="">
<input type="hidden" name="workno" value="<%=workNo%>">
<input type="hidden" name="sum_flag" value="">
<input type="hidden" name="check_flag" value="">		
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�����SP��Ϣ�б�</div>
</div>
<table cellSpacing="0">
        <tr> 
            <td colspan="8" align="right"> 
            	<%
            	  int recordNum = Integer.parseInt(result1[0][0].trim());
						    int iQuantity =recordNum;
						    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
								PageView view = new PageView(request,out,pg); 
						   	view.setVisible(true,true,0,1); 
            	%>
            </td>
        </tr>
        <tr>
            <th><div align="center">ѡ��</div></th>
            <th><div align="center">��������</div></th>
            <th><div align="center">��ҵ����</div></th>              
            <th><div align="center">��ҵ����</div></th>      
            <th><div align="center">��ҵ����</div></th>
            <th><div align="center">�������</div></th>
            <th><div align="center">��Ч����</div></th>
            <th><div align="center">ʧЧ����</div></th>
        </tr>	 
       <%
         
         for(int i=0;i<result.length;i++){  
         String tdClass = "";            
         if (i%2==0){
             tdClass = "Grey";
         }              
        %>
        <tr id="tr0">
        	<td class="<%=tdClass%>"><div align="center"><input type="checkbox" name="checkId" id="checkId" value="<%=result[i][6]%>">&nbsp;</div></td>
        	<%
        		optype = result[i][8];
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
        	 <% 
        			sptype =	result[i][2];
        		if(sptype.equals("0"))
        		{
        			sptype = "��ͨSP";
        		}
        		else if(sptype.equals("1"))
    				{
    					sptype = "���з�����SP";
    				}
        		%>  
        	<td class="<%=tdClass%>" align="center" name=sptype height="20"><%=sptype%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" name=spservcode height="20"><%=result[i][3]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" name=validdate height="20"><%=result[i][4]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" name=expiredate height="20"><%=result[i][5]%>&nbsp;</td>
       </tr>
     <%
       }
     %>  
       <tr> 
        <td nowrap class=blue> 
          <div align="left">��ע</div>
        </td>
        <td nowrap colspan="7"> 
          <div align="left"> 
            <input type="text" class="InputGrey" name="systemNote" id="systemNote" size="60" readonly maxlength=60>
          </div>
        </td>
      </tr>
      <tr style='display:none'> 
        <td nowrap width="1%"> 
          <div align="left">��˱�ע</div>
        </td>
        <td nowrap colspan="7"> 
          <div align="left"> 
            <input type="text" name="opNote" id="opNote" size="60" v_maxlength=60  v_type=string index="28" maxlength=60>
          </div>
        </td>
      </tr>
        <tr> 
          <td nowrap colspan="8"> 
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
                  <td id="footer" nowrap colspan="8"> 
                    <div align="center">
                    	<input class="b_foot" type="button" name="b_clear" value="���" onClick="printCommit()" index="30">
                    	<input class="b_foot" type="button" name="b_print" value="��˲�ͨ��" onClick="printCommit1()" index="29"> 
                      <input class="b_foot" type="button" name="b_clear" value="���" onClick="frm.reset();" index="30">
                      <input class="b_foot" type="button" name="b_back" value="����" onClick="location='f9106_1.jsp'" index="31">
                    </div>
                  </td>
      </tr>
</table>	      
<%@ include file="/npage/include/footer.jsp"%>	
</form>	 	
</body>	
</html>
