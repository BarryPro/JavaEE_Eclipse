<%@ include file="/include/public_title_name.jsp"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%    
  			ArrayList arrSession = (ArrayList)session.getAttribute("allArr"); 
				String[][] baseInfoSession = (String[][])arrSession.get(0);
				String[][] otherInfoSession = (String[][])arrSession.get(2);
				String[][] pass = (String[][])arrSession.get(4);
			  String loginPasswd  = pass[0][0];       //ȡ����Ա����
        String workNo = (String) session.getAttribute("workNo");
        String workName = (String) session.getAttribute("workName");
				String op_name ="SP��ҵ��Ϣ���"; 
				
				String powerCode= otherInfoSession[0][4];
				String orgCode = baseInfoSession[0][16];
				String ip_Addr = request.getRemoteAddr();
				
				String region_Code = orgCode.substring(0,2);
				String region_Name = otherInfoSession[0][5];
				String town_Name = otherInfoSession[0][7];
				String loginNoPass = pass[0][0];
				int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		    int iPageSize = 20;
		    int iStartPos = (iPageNumber-1)*iPageSize;
		    int iEndPos = iPageNumber*iPageSize;
		    String sql1="";
				String sql2="";
				String verify_code2=request.getParameter("verify_code2");
				String message=request.getParameter("message");
				if(verify_code2.equals("0")){
				   sql1 ="select * from (select a.SP_CODE,a.SP_NAME,a.SP_TYPE,a.SERV_CODE,a.VALID_DATE,a.EXPIRE_DATE ,a.MAXACCEPT,rownum id from TDSMPSPINFOMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0' and nvl(a.SP_CODE,'') like '%"+message+"%') where id <"+iEndPos+" and id>="+iStartPos;
				   sql2 ="select nvl(count(*),0) num from TDSMPSPINFOMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0' and nvl(a.SP_CODE,'') like '%"+message+"%'";
	       }
	      else if(verify_code2.equals("1")){ 
	         sql1 ="select * from (select a.SP_CODE,a.SP_NAME,a.SP_TYPE,a.SERV_CODE,a.VALID_DATE,a.EXPIRE_DATE ,a.MAXACCEPT,rownum id from TDSMPSPINFOMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0' and nvl(a.SP_NAME,'') like '%"+message+"%') where id <"+iEndPos+" and id>="+iStartPos;
				   sql2 ="select nvl(count(*),0) num from TDSMPSPINFOMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0' and (a.SP_NAME,'') like '%"+message+"%'";
				}else{
			     sql1 ="select * from (select a.SP_CODE,a.SP_NAME,a.SP_TYPE,a.SERV_CODE,a.VALID_DATE,a.EXPIRE_DATE ,a.MAXACCEPT,rownum id from TDSMPSPINFOMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0') where id <"+iEndPos+" and id>="+iStartPos;
				   sql2 ="select nvl(count(*),0) num from TDSMPSPINFOMSG a,CDSMPCHECKCODE b where a.SP_ATTR = b.LOCALCODE and a.serv_type = b.serv_type and a.sp_type = b.sptype and b.AUTO_FLAG = '0' ";
        }  
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_Code%>" id="sLoginAccept" />

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_Code%>" retval="val1" outnum="8">
<wtc:sql><%=sql1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" property="val1" scope="end" />
	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_Code%>" retval="val2" outnum="1">
<wtc:sql><%=sql2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" property="val2" scope="end" />
<html>
<head>
<title><%=op_name%></title>
<script language=javascript>
		core.loadUnit("debug");
		core.loadUnit("rpccore");
			onload=function()
			{
			 core.rpc.onreceive=doProcess;
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
			rdShowMessageDialog("����"+retMsg);
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
   var page_type ="2";
   if(num>1){
   	sp_code = document.frm.checkId[i].value;
  }else{	
    sp_code = document.frm.checkId.value;
    }
   var myPacket = new RPCPacket("select_spmsg.jsp","���ڻ��SP��ҵ��Ϣ�����Ժ�......");
   myPacket.data.add("sp_code",sp_code);
   myPacket.data.add("page_type",page_type);
   core.rpc.sendPacket(myPacket);
	 delete(myPacket);	
  } 
  function printCommit()
			{
			       conf();
			       document.frm.systemNote.value="SP��ҵ"+document.frm.sp_name.value+"�����޸�";
			}
			
			
	function conf()
			{		  
			      frm.action="f9106_21.jsp";
			      frm.submit();
			} 
</script>	
</head>
<BODY bgcolor="#FFFFFF" text="#000000" background="../../images/jl_background_2.gif" leftmargin = "0" topmargin = "0" marginwidth = "0" marginheight = "0">
<form name="frm" method="POST" >
<input type="hidden" name="loginAccept" value="<%=sLoginAccept%>">
<input type="hidden" name="maxaccept" value="">
<input type="hidden" name="workno" value="<%=workNo%>">	 
<%@ include file="/include/header.jsp"%>
<table  width=98% height=25 border="0" align="center" bgcolor="#FFFFFF">
 	      <tr bgcolor="#eeeeee" class="title"> 
            <td width="13%" bgcolor="eeeeee" colspan="7"> 
            <div align="left">��˺�SP��Ϣ�б�</div>
            </td>
        </tr>
        <tr bgcolor="#eeeeee" > 
            <td colspan="7" align="right"> 
            	<%
            	  int recordNum = Integer.parseInt(result1[0][0].trim());
						    int iQuantity =recordNum;
						    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
								PageView view = new PageView(request,out,pg); 
						   	view.setVisible(true,true,0,1); 
            	%>
            </td>
        </tr>
        <tr  bgcolor="E8E8E8" class="title">
        	<td ><div align="center">ѡ��</div></td>
			    <td ><div align="center">��ҵ����</div></td>              
			    <td ><div align="center">��ҵ����</div></td>      
			    <td ><div align="center">��ҵ����</div></td>
		      <td ><div align="center">�������</div></td>
		      <td ><div align="center">��Ч����</div></td>
		      <td ><div align="center">ʧЧ����</div></td>
        </tr>	 
        <%
         
         for(int i=0;i<result.length;i++){               
        %>
        <tr id="tr0" bgcolor="#eeeeee">
        	<td><div align="center"><input type="radio" name="checkId" id="checkId" value="<%=result[i][6]%>" onclick="select_spmsg('<%=i%>')"></div></td>
        	<td class="listformtext" align="center" name=spcode height="20"><%=result[i][0]%></td>
        	<td class="listformtext" align="center" name=spname height="20"><%=result[i][1]%></td>
        	<td class="listformtext" align="center" name=sptype height="20"><%=result[i][2]%></td>
        	<td class="listformtext" align="center" name=spservcode height="20"><%=result[i][3]%></td>
        	<td class="listformtext" align="center" name=validdate height="20"><%=result[i][4]%></td>
        	<td class="listformtext" align="center" name=expiredate height="20"><%=result[i][5]%></td>
       </tr> 
       <%
       }
     %>           
 </table>      
<table  width=98% height=25 border="0" align="center" bgcolor="#FFFFFF">
        
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">��ҵ���룺</div>
          </td>
          <td colspan="6" bgcolor="eeeeee"> 
          <input type="text" readonly name="sp_code" value="" size=20 >	
          </td>
        </tr>
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">��ҵ���ƣ�</div>
          </td>
          <td colspan="6" bgcolor="eeeeee"> 
          <input type="text" readonly name="sp_name" value="" size=60>	
          </td>
        </tr>
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">��ҵ���ͣ�</div>
          </td>
          <td nowrap bgcolor="#eeeeee" colspan="1"> 
              <div align="left"> 
               <select size=1 name=sp_type >                
                 <option value="0">��ͨ��SP</option>
                 <option value="1">���з�����SP</option>
               </select>
              </div>
            </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">������룺</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" readonly name="serv_code" value="" size=20>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">ҵ�����ͣ�</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" readonly name="serv_type" value="" size=20>	
          </td>
        </tr>
         <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">����ʡ���룺</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" readonly name="prov_code" value="" size=11 maxlength=3>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">����ʡ���룺</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" readonly name="bal_prov" value="" size=11 maxlength=3>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">ƽ̨���룺</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" readonly name="dev_code" value="" size=11>	
          </td>
        </tr>
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">��Ч���ڣ�</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" readonly name="valid_date" value="" size=14>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">ʧЧ���ڣ�</div>
          </td>
          <td colspan="3" bgcolor="eeeeee"> 
          <input type="text" readonly name="expire_date" value="" size=14>	
          </td>
        </tr>
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">��ҵ������</div>
          </td>
          <td colspan="5" bgcolor="eeeeee"> 
          <input type="text" readonly name="description" value="" size=100>	
          </td>
        </tr>        
        <tr bgcolor="eeeeee"> 
        <td nowrap width="10%"> 
          <div align="left">ϵͳ��ע��</div>
        </td>
        <td nowrap colspan="5"> 
          <div align="left"> 
            <input type="text"  class="button" name="systemNote" id="systemNote" size="60" readonly maxlength=60>
          </div>
        </td>
      </tr>
      <tr bgcolor="eeeeee"> 
        <td nowrap width="10%"> 
          <div align="left">�û���ע��</div>
        </td>
        <td nowrap colspan="5"> 
          <div align="left"> 
            <input type="text" class="button" name="opNote" id="opNote" size="60" v_maxlength=60  v_type=string  v_name="�û���ע" index="28" maxlength=60>
          </div>
        </td>
      </tr>
      <tr bgcolor="eeeeee"> 
                  <td nowrap colspan="6"> 
                    <div align="center"> 
                      <input class="button" type="button" name="b_print" value="ȷ��" onClick="printCommit()" index="29">
                      <input class="button" type="button" name="b_clear" value="���" onClick="frm.reset();" index="30">
                      <input class="button" type="button" name="b_back" value="����" onClick="location='f9106_1.jsp'" index="31">
                    </div>
                  </td>
      </tr>
</table>          
<%@ include file="/include/footer.jsp"%>	
</form>	 	
</body>	
</html>
