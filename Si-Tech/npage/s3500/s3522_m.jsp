<%
/********************
 version v2.0
������: si-tech
�޸���	�޸�ʱ��	�޸�ԭ��
niuhr 2009/11/12	�������ù��ܸ���
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=gbk"%>
<%if ((request.getCharacterEncoding() == null))
      {request.setCharacterEncoding("GBK");}%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@ page import="sitech.www.frame.jdbc.SqlQuery" %>

<%
		String opCode = "3522";
		String opName = "�û������븽���ֶδ����Ӧ��";

		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
    	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));   
    	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
		String  powerCode= (String)session.getAttribute("powerCode");
		List sqlList = new ArrayList();
	//���й���Ȩ�޼���
    String sqlStr = "";
    String busiType = "";
    String userType = "";
    String fieldCode = "";
	String ctrlInfo = "";
	String fieldOrder = "";
	String fieldDefvalue = "";
	String openParamFlag = "";//newadd
	String updateFlag = "";//newadd
	
	String grpCode = "";
    int suc_flag = -1;

    //Vector vTemp=null;
    PrdMgrSql sqlSrvCode=new PrdMgrSql();
%>

<%

  String action=request.getParameter("action");

try {
    busiType = request.getParameter("busiType");

    userType =  request.getParameter("userType");

    fieldCode = request.getParameter("fieldCode");
    
    grpCode  = request.getParameter("grpCode");

	ctrlInfo = request.getParameter("ctrlInfo");
    fieldOrder = request.getParameter("fieldOrder");//add
	fieldDefvalue = request.getParameter("fieldDefvalue");//add
	openParamFlag = request.getParameter("openParamFlag");//add
	updateFlag = request.getParameter("updateFlag");//add
	System.out.println("openparamflag="+openParamFlag);
	System.out.println("updateFlag = "+updateFlag);
    //�޸Ľ�ɫ
    if ("modify".equals(action)) {
        sqlStr = "update  sUserTypeFieldRela  set busi_type='"+busiType+"', " +
                                    "user_type='"+userType+"', " +
                                    "field_code='"+fieldCode+"', " +
									"field_order='"+fieldOrder+"', " +
									"field_defvalue='"+fieldDefvalue+"', " +
									"ctrl_info='"+ctrlInfo+"'," + 
									"field_grp_no='"+grpCode+"', " +
									"OPEN_PARAM_FLAG='"+openParamFlag+"'" + 
									", UPDATE_FLAG='" +updateFlag+"'";

        sqlStr = sqlStr + "where busi_type='"+busiType+"' and user_type='"+userType+"' and field_code='"+fieldCode+"' and field_grp_no='"+grpCode+"'";
				sqlList.add(sqlStr);
                int flag=sqlSrvCode.updateTrsaction(sqlList);
				if(flag==1){
				%>
				<script>
					rdShowMessageDialog("�޸ĳɹ���",2)
				</script>
				<%
				}
				else{
				%>
				<script>
					rdShowMessageDialog("�޸�ʧ�ܣ�",0)
				</script>
				<%
				}
            suc_flag = 1;
    }
    }catch (Exception ex) {
        ex.printStackTrace();
        //throw new Exception(sqlStr+"����ʧ�ܣ�!!\n��̨������ϢΪ��"+ex);
    }

%>
<%
	int len1 = 0;
	String  strbusi = " select busi_type ,busi_name from suserbusitype order by busi_type ";
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:sql><%=strbusi%> </wtc:sql>
</wtc:pubselect>
<wtc:array id="rows1" scope="end"/>
<%			
	if(retCode.equals("000000"))
	{	
		for(int i=0;i<rows1.length;i++)
		{
             //System.out.println("rows["+i+"][0]"+rows[i][0]);
             //System.out.println("rows["+i+"][1]"+rows[i][1]);
		}	
        len1=rows1.length;
	}
	else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("��ѯҵ��������Ϣ����!",0);
			document.location.replace("<%=request.getContextPath()%>/npage/s3500/s3522.jsp");
		</script>
<%
	}		
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<SCRIPT language=javascript src="js/publicWeb.js"></SCRIPT>
<script language=javascript>

/*************************************************************************************/
function checkTable()
{
	var beginDate;
	var endDate;
 	if(trim(document.TestMForm.fieldName.value).length==0)
 	{
     	rdShowMessageDialog("�ֶ����Ʋ���Ϊ�գ�",1)
     	document.TestMForm.fieldName.focus();
     	return false;
 	}

	if(trim(document.TestMForm.fieldPurpose.value).length==0)
	{
	     rdShowMessageDialog("�ֶ���;����Ϊ�գ�",1)
	     document.TestMForm.fieldPurpose.focus();
	     return false;
	}
	 return true;
}
function submitInputModify(url)
{
    	submitMe(url);
}
function submitInput(url){
  submitMe(url);
}
function submitMe(url){
	
  window.TestMForm.action=url;
  window.TestMForm.method='post';
  window.TestMForm.submit();
}
function submitInput2(url){

submitMe(url);
}
//�ص��ַ���ǰ��ո�
function trim(arg)
{
  if(arg.length==0)
  {
    return '';
  }

    //��λ��һ���ǿո�λ��
  for(var i=0;i<arg.length;i++)
  {
    var onechar=arg.charAt(i);
    if(onechar!=' ')
    {
      break;
    }
  }
  arg=arg.substring(i,arg.length);

    if(arg.length==0)
  {
    return '';
  }

    //��λ��һ���ǿո�λ��(��������)
  for(var i=arg.length;i>0;i--)
  {
    var onechar=arg.charAt(i-1);
    if(onechar!=' ')
    {
      break;
    }
  }
  arg=arg.substring(0,i);
  return arg;
}

</SCRIPT>

</HEAD>

<BODY>
<FORM name="TestMForm" method="post" action="">
<%@ include file="/npage/include/header_pop.jsp" %> 
	<div class="title">
		<div id="title_zi"> �û������ֶδ���� </div>
	</div>

     <table  cellspacing="0">

          <tr>
               <td class="blue">ҵ������</td>
              <td>
               
               	  <SELECT name="busiType" id="busiType" disabled>
    	             	 <% 
    	             	  for(int i = 0; i < len1; i++){
    	             	    System.out.println(busiType+"===+++++===="+rows1[i][0]);
    	             	 %>
    	               <option value="<%=rows1[i][0].trim()%>" <%if(busiType.equals(rows1[i][0].trim()))out.println("selected");%>><%=rows1[i][0].trim()%>&nbsp;-&gt&nbsp;<%=rows1[i][1].trim()%></option>
											<%
										  }
											%>
				</select>
			   </td>
			   <!--<td>
               	  <SELECT name="busiType" id="busiType">
               	  	<option value="1000" <%=(busiType!=null&&busiType.equals("1000"))?"selected":""%>>1000--IDCҵ��</option>             
               	  </SELECT>
               </td>-->
               
              <!-- <td>
                  <input name="busiType" type="text" class="button" id="busiType" value="<%=(busiType==null)?"":busiType%>" readonly>

			   </td>
			   -->
               <td class="blue">�û�����</td>
               <td>
                  <input name="userType" type="text" class="button" id="userType" maxlength="20" value="<%=(userType==null)?"":userType%>" readonly>
			   </td>
           </tr>
           <tr>
		   <td class="blue">�ֶδ���</td>
               <td>
				  <input name="fieldCode" type="text" class="button" id="fieldCode" maxlength="20" value="<%=(fieldCode==null)?"":fieldCode%>" readonly>
			   </td>
             <td class="blue">������Ϣ</td>
             <td>
				<input name="ctrlInfo" type="text" class="button" id="ctrlInfo" maxlength="20" value="<%=(ctrlInfo.equals("null"))?"":ctrlInfo%>" >
			 </td>
           </tr>
		   <tr>
             <td class="blue">�ֶ����</td>
			 <td><input name="fieldOrder" type="text" class="button" id="fieldOrder" maxlength="5" value='<%=(fieldOrder==null)?"":fieldOrder%>'></td>
			 <td class="blue">Ĭ��ֵ</td>
			 <td><input name="fieldDefvalue" type="text" class="button" id="fieldDefvalue" maxlength="5" value='<%=(fieldDefvalue.equals("null"))?"":fieldDefvalue%>'></td>
           </tr>
           
           
           <tr>                     
           	<td class="blue">�����</td>
               <td>
				  <input name="grpCode" type="text" class="button" id="grpCode" maxlength="20" value="<%=(grpCode==null)?"":grpCode%>" readonly>
          		<td colspan="2"></td> 
           </tr>
           <tr>
           		<td class="blue">�Ƿ������</td>
               	<td>
				  <select name="openParamFlag">
					<option value="Y" <%=(openParamFlag!=null&&openParamFlag.equals("Y"))?"selected":""%>>Y--�洢����</option>
					<option value="N" <%=(openParamFlag!=null&&openParamFlag.equals("N"))?"selected":""%>>N--���洢����</option>
				  </select>
			   	</td>
				<td class="blue">�Ƿ���޸�</td>
				<td>
					<select name="updateFlag">		
						<option value="Y" <%=(updateFlag!=null&&updateFlag.equals("Y"))?"selected":""%>>Y--��</option>
						<option value="N" <%=(updateFlag!=null&&updateFlag.equals("N"))?"selected":""%>>N--��</option>					
					</select>
				</td>
			</tr>
		</table>
		<TABLE cellSpacing="0" >
			<TR id='footer'>
				<TD id="footer" align="center">          	                    	           	              	                          	
        	        <input name="confirm" type="button" class="b_foot"  value="�޸�" onClick="submitInputModify('<%=request.getContextPath()%>/npage/s3500/s3522_m.jsp?action=modify&busiType=<%=busiType%>&userType=<%=userType%>&fieldCode=<%=fieldCode%>')">
                	<input name="back" type="reset" class="b_foot"  value="����" onClick="submitInput('s3522.jsp')">
			    </td>
			</tr>
			
       </table>
 <%@ include file="/npage/include/footer_pop.jsp" %>   
</form>
</body>

</HTML>

