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
        //ArrayList arrSession = (ArrayList)session.getAttribute("allArr"); 
        //String[][] baseInfoSession = (String[][])arrSession.get(0);
        //String[][] otherInfoSession = (String[][])arrSession.get(2);
        //String[][] pass = (String[][])arrSession.get(4);
    String loginPasswd  = (String)session.getAttribute("password");       //ȡ����Ա����
    String workNo = (String) session.getAttribute("workNo");
    String workName = (String) session.getAttribute("workName");
    String op_name ="SP��ҵ��Ϣ���"; 
    
    String powerCode= (String)session.getAttribute("powerCode");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    
    String region_Code = orgCode.substring(0,2);
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 20;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;
    String sql1="";
    String sql2="";
    String verify_code2=request.getParameter("verify_code2");
    String message=request.getParameter("message");
    String sptype="";
    String optype = "";
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
		var spid = packet.data.findValueByName("spid");
		var spname = packet.data.findValueByName("spname");
		var sptype = packet.data.findValueByName("sptype");			
		var spsvcid = packet.data.findValueByName("spsvcid");
		var provcode = packet.data.findValueByName("provcode");
		var balprov = packet.data.findValueByName("balprov");
		var devcode = packet.data.findValueByName("devcode");
		var validdate = packet.data.findValueByName("validdate");
		var expiredate = packet.data.findValueByName("expiredate");
		var spdesc = packet.data.findValueByName("spdesc");
		var maxaccept = packet.data.findValueByName("maxaccept");
		var serv_type = packet.data.findValueByName("serv_type");
		if( parseInt(retCode) == 0 ){
			document.frm.sp_code.value= spid;
			document.frm.sp_name.value= spname;
			document.frm.sp_type.value= sptype;
			document.frm.serv_code.value= spsvcid;
			document.frm.prov_code.value= provcode;
			document.frm.bal_prov.value= balprov;
			document.frm.dev_code.value= devcode;
			document.frm.valid_date.value= validdate;
			document.frm.expire_date.value= expiredate;
			document.frm.description.value= spdesc;
			document.frm.maxaccept.value= maxaccept;				
			document.frm.serv_type.value= serv_type;	
							
		}else{
			rdShowMessageDialog("����"+retMsg,0);
		}
		for(var i=0;i< document.frm.sp_type.length;i++){
			if(document.frm.sp_type.options[i].value==sptype){
				document.frm.sp_type.options[i].selected=true;
			  break;
			}
		}
		
		
	}
   function select_spmsg(i)
  {
   var num = <%=result1[0][0]%>;
   var sp_code;
   var page_type ="3";
   if(num>1){
   	sp_code = document.frm.checkId[i].value;
  }else{	
    sp_code = document.frm.checkId.value;
    }
   var myPacket = new AJAXPacket("select_spmsg.jsp","���ڻ��SP��ҵ��Ϣ�����Ժ�......");
   myPacket.data.add("sp_code",sp_code);
   myPacket.data.add("page_type",page_type);
   core.ajax.sendPacket(myPacket);
	 myPacket = null;	
  } 
  function printCommit()
			{
			  var sum_flag="";
			  document.frm.check_flag.value = "yes";
			  document.frm.sum_flag.value = document.frm.maxaccept.value; 	    		
			  document.frm.systemNote.value="����Ա"+document.frm.workno.value+":SP��ҵ"+document.frm.sp_name.value+"�������";  
			  conf();	
			}
			
	function printCommit1()
			{
			  var sum_flag="";	
			  document.frm.check_flag.value = "no";			 
			  document.frm.sum_flag.value = document.frm.maxaccept.value; 	    		
			  document.frm.systemNote.value="����Ա"+document.frm.workno.value+":SP��ҵ"+document.frm.sp_name.value+"�������";
			  conf();	  
		  }		
	function conf()
			{		   var sum_flag = document.frm.sum_flag.value;
				    if(sum_flag == ""){
				    	rdShowMessageDialog("��ѡ��У������");
							return false;
				    	}
			      frm.action="f9106_conf.jsp";
			      frm.submit();
			} 
</script>	
</head>
<BODY>
<form name="frm" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�����SP��Ϣ�б�</div>
</div>
<input type="hidden" name="loginAccept" value="<%=sLoginAccept%>">
<input type="hidden" name="maxaccept" value="">
<input type="hidden" name="workno" value="<%=workNo%>">
<input type="hidden" name="sum_flag" value="">
<input type="hidden" name="check_flag" value="">	
<table cellSpacing="0">
        <tr > 
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
        <tr class="title">
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
        	<td class="<%=tdClass%>"><div align="center"><input type="radio" name="checkId" id="checkId<%=i%>" value="<%=result[i][6]%>" onclick="select_spmsg('<%=i%>')">&nbsp;</div></td>
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
 </table>      
<table cellSpacing="0">
        <tr> 
          <td class=blue> 
          <div align="left">��ҵ����</div>
          </td>
          <td colspan="6"> 
          <input type="text" name="sp_code" value="" size=20 class="InputGrey" readonly>	
          </td>
        </tr>
        <tr> 
          <td class=blue> 
          <div align="left">��ҵ����</div>
          </td>
          <td colspan="6"> 
          <input type="text" name="sp_name" value="" size=60 class="InputGrey" readonly>	
          </td>
        </tr>
        <tr> 
          <td class=blue> 
          <div align="left">��ҵ����</div>
          </td>
          <td nowrap colspan="1" readonly> 
              <div align="left"> 
               <select size=1 name=sp_type  readonly>                
                 <option value="0">��ͨ��SP</option>
                 <option value="1">���з�����SP</option>
               </select>
              </div>
            </td>
          <td class=blue> 
          <div align="left">�������</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="serv_code" value="" size=20 class="InputGrey" readonly>	
          </td>
          <td class=blue> 
          <div align="left">ҵ������</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="serv_type" value="" size=20 class="InputGrey" readonly> 	
          </td>
        </tr>
         <tr> 
          <td class=blue> 
          <div align="left">����ʡ����</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="prov_code" value="" size=11 maxlength=3 class="InputGrey" readonly>	
          </td>
          <td class=blue> 
          <div align="left">����ʡ����</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="bal_prov" value="" size=11 maxlength=3 class="InputGrey" readonly> 	
          </td>
          <td class=blue> 
          <div align="left">ƽ̨����</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="dev_code" value="" size=11 class="InputGrey" readonly>	
          </td>
        </tr>
        <tr> 
          <td class=blue> 
          <div align="left">��Ч����</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="valid_date" value="" size=14 class="InputGrey" readonly>	
          </td>
          <td class=blue> 
          <div align="left">ʧЧ����</div>
          </td>
          <td colspan="3"> 
          <input type="text" name="expire_date" value="" size=14 class="InputGrey" readonly>	
          </td>
        </tr>
        <tr> 
          <td class=blue> 
          <div align="left">��ҵ����</div>
          </td>
          <td colspan="5"> 
          <input type="text" name="description" value="" size=100 class="InputGrey" readonly>	
          </td>
        </tr>
      <tr> 
        <td class=blue> 
          <div align="left">��&nbsp;&nbsp;&nbsp;&nbsp;ע</div>
        </td>
        <td nowrap colspan="6"> 
          <div align="left"> 
            <input type="text" class="InputGrey" name="systemNote" id="systemNote" size="60" readonly maxlength=60>
          </div>
        </td>
      </tr>
      <tr style='display:none'> 
        <td class=blue> 
          <div align="left">��˱�ע</div>
        </td>
        <td nowrap colspan="6"> 
          <div align="left"> 
            <input type="text" class="button" name="opNote" id="opNote" size="60" v_maxlength=60  v_type=string  index="28" maxlength=60>
          </div>
        </td>
      </tr>        
      <tr> 
                  <td id="footer" nowrap colspan="6"> 
                    <div align="center"> 
                      <input class="b_foot" type="button" name="b_print" value="���" onClick="printCommit()" index="29">
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
